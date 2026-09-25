using System;
using System.Diagnostics;
using System.IO;
using Nelim.PickleTools.SoundCapture;
using Xunit;

namespace Nelim.PickleTools.SoundCapture.Tests
{
    public class SoundAnalysisTests
    {
        // Lines as ffmpeg's volumedetect prints them, taken from the WSL install on 2026-09-24.
        private const string Idle =
            "[Parsed_volumedetect_0 @ 0x5babc04d4dc0] mean_volume: -91.0 dB\n" +
            "[Parsed_volumedetect_0 @ 0x5babc04d4dc0] max_volume: -91.0 dB\n";

        private const string Tone =
            "[Parsed_volumedetect_0 @ 0x63519ddb3500] mean_volume: -21.1 dB\n" +
            "[Parsed_volumedetect_0 @ 0x63519ddb3500] max_volume: -18.1 dB\n";

        [Theory]
        [InlineData(Idle, -91.0)]
        [InlineData(Tone, -18.1)]
        [InlineData("max_volume: 0.0 dB", 0.0)]
        [InlineData("max_volume:-3 dB", -3.0)]
        public void ReadsTheLoudestSample(string report, double expected)
        {
            Assert.True(SoundAnalysis.TryParseMaxVolume(report, out double peak));
            Assert.Equal(expected, peak, 3);
        }

        [Fact]
        public void DigitalSilenceIsMinusInfinity()
        {
            Assert.True(SoundAnalysis.TryParseMaxVolume("max_volume: -inf dB", out double peak));
            Assert.True(double.IsNegativeInfinity(peak));
            Assert.True(SoundAnalysis.IsSilent(peak));
            Assert.False(SoundAnalysis.IsNotSilent(peak));
        }

        [Theory]
        [InlineData(null)]
        [InlineData("")]
        [InlineData("Input #0, wav, from 'x.wav': Duration: 00:00:01.00")]
        [InlineData("mean_volume: -21.1 dB")]
        public void AReportWithoutAPeakIsNotParsed(string report)
        {
            Assert.False(SoundAnalysis.TryParseMaxVolume(report, out double peak));
            Assert.True(double.IsNegativeInfinity(peak));
        }

        [Fact]
        public void TheThresholdsSeparateWhatWasMeasured()
        {
            Assert.True(SoundAnalysis.IsNotSilent(-18.1));
            Assert.False(SoundAnalysis.IsNotSilent(-91.0));
            Assert.True(SoundAnalysis.IsSilent(-91.0));
            Assert.False(SoundAnalysis.IsSilent(-18.1));
        }

        [Fact]
        public void BetweenTheThresholdsIsNeitherSilentNorHeard()
        {
            Assert.False(SoundAnalysis.IsNotSilent(-70.0));
            Assert.False(SoundAnalysis.IsSilent(-70.0));
            Assert.False(SoundAnalysis.IsNotSilent(SoundAnalysis.NotSilentAboveDb));
            Assert.False(SoundAnalysis.IsSilent(SoundAnalysis.SilentBelowDb));
        }

        [Fact]
        public void TheRecordingCommandNamesTheSourceTheFileAndALimit()
        {
            string arguments = SoundAnalysis.RecordArguments("RDPSink.monitor", "/tmp/a b/sound.wav", 120);

            Assert.Contains("-f pulse -i RDPSink.monitor", arguments);
            Assert.Contains("-t 120", arguments);
            Assert.EndsWith("\"/tmp/a b/sound.wav\"", arguments);
        }

        // The analysis is only worth trusting if the command it builds tells a tone from silence on a real file.
        [Fact]
        public void FfmpegTellsAToneFromSilenceOnRealFiles()
        {
            if (!Ffmpeg("-version", out _))
            {
                return; // no ffmpeg here: the parsing tests above still run
            }

            string folder = Path.Combine(Path.GetTempPath(), "soundcapture-tests-" + Guid.NewGuid().ToString("N"));
            Directory.CreateDirectory(folder);
            try
            {
                string tone = Path.Combine(folder, "tone.wav");
                string silence = Path.Combine(folder, "silence.wav");
                Assert.True(Ffmpeg($"-hide_banner -loglevel error -f lavfi -i \"sine=frequency=440:duration=1\" -ar 22050 -ac 1 \"{tone}\"", out _));
                Assert.True(Ffmpeg($"-hide_banner -loglevel error -f lavfi -i \"anullsrc=r=22050:cl=mono\" -t 1 \"{silence}\"", out _));

                Assert.True(Ffmpeg(SoundAnalysis.VolumeDetectArguments(tone), out string toneReport));
                Assert.True(Ffmpeg(SoundAnalysis.VolumeDetectArguments(silence), out string silenceReport));
                Assert.True(SoundAnalysis.TryParseMaxVolume(toneReport, out double tonePeak));
                Assert.True(SoundAnalysis.TryParseMaxVolume(silenceReport, out double silencePeak));

                Assert.True(SoundAnalysis.IsNotSilent(tonePeak), $"tone peaked at {tonePeak} dB");
                Assert.True(SoundAnalysis.IsSilent(silencePeak), $"silence peaked at {silencePeak} dB");
            }
            finally
            {
                Directory.Delete(folder, true);
            }
        }

        [Fact]
        public void AFilmRecordsInStereoAtCdQualityAndASoundOnlyKeepsTheDefault()
        {
            Assert.Contains("-ar 44100 -ac 2", SoundAnalysis.RecordArguments("RDPSink.monitor", "a.wav", 120, 44100, 2));
            Assert.Contains("-ar 22050 -ac 1", SoundAnalysis.RecordArguments("RDPSink.monitor", "a.wav", 120));
        }

        // The mux is only worth trusting if it gives one file that has both streams, an even picture, and the picture's length.
        [Fact]
        public void FfmpegPutsTheSoundIntoTheVideoAsH264AndAac()
        {
            if (!Ffmpeg("-version", out _))
            {
                return;
            }

            string folder = Path.Combine(Path.GetTempPath(), "soundcapture-tests-" + Guid.NewGuid().ToString("N"));
            Directory.CreateDirectory(folder);
            try
            {
                string film = Path.Combine(folder, "film.webm");
                string sound = Path.Combine(folder, "sound.wav");
                string mp4 = Path.Combine(folder, "film-sound.mp4");

                // Three seconds of picture, on purpose an odd 181 high, and five seconds of sound: the sound must be cut to the picture.
                if (!Ffmpeg($"-hide_banner -loglevel error -f lavfi -i \"testsrc=size=320x181:rate=10:duration=3\" -c:v libvpx \"{film}\"", out _))
                {
                    return; // this ffmpeg has no vp8 encoder: nothing to mux here
                }

                Assert.True(Ffmpeg($"-hide_banner -loglevel error -f lavfi -i \"sine=frequency=440:duration=5\" -ar 44100 -ac 2 \"{sound}\"", out _));

                if (!Ffmpeg(SoundAnalysis.MuxArguments(film, sound, mp4), out string report))
                {
                    if (report.Contains("Unknown encoder") || report.Contains("libx264") || report.Contains("aac"))
                    {
                        return; // this ffmpeg has no H.264 or AAC encoder
                    }

                    Assert.Fail("the mux failed: " + report);
                }

                Ffmpeg(SoundAnalysis.ProbeArguments(mp4), out string probe);
                Assert.Contains("Video: h264", probe);
                Assert.Contains("Audio: aac", probe);
                Assert.Contains("320x180", probe); // the odd 181 became 180
                Assert.Matches(@"Duration: 00:00:0[23]\.", probe); // the picture's three seconds, not the sound's five
                Assert.DoesNotContain("Duration: 00:00:05", probe);
            }
            finally
            {
                Directory.Delete(folder, true);
            }
        }

        private static bool Ffmpeg(string arguments, out string stderr)
        {
            stderr = string.Empty;
            try
            {
                var start = new ProcessStartInfo("ffmpeg", arguments)
                {
                    UseShellExecute = false,
                    CreateNoWindow = true,
                    RedirectStandardError = true,
                    RedirectStandardOutput = true,
                };
                using (Process process = Process.Start(start))
                {
                    var output = process.StandardOutput.ReadToEndAsync();
                    stderr = process.StandardError.ReadToEnd();
                    process.WaitForExit(30000);
                    output.Wait(5000);
                    return process.ExitCode == 0;
                }
            }
            catch (System.ComponentModel.Win32Exception)
            {
                return false;
            }
        }
    }
}
