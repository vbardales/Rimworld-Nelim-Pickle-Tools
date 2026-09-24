using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorks.Pickle.Evidence;
using Verse;

namespace Nelim.PickleTools.SoundCapture
{
    /// <summary>
    /// Records what the game plays, so a person can hear it from a report and a scenario can assert that something
    /// was heard. Optional: nothing here runs unless a scenario asks for it, and nothing in Pickle or in the launcher
    /// changes.
    ///
    /// How: ffmpeg records the monitor of an audio sink through PulseAudio, for the length between two steps. On the
    /// WSL install the game plays into the sink WSLg provides (<c>RDPSink</c>), so its monitor carries the game's
    /// mix and nothing else. <b>The same sound also reaches her Windows speakers</b>, because that sink is the way
    /// out; keep a recording to a few seconds. The source can be changed with the environment variable
    /// <c>PICKLETOOLS_SOUND_SOURCE</c>.
    ///
    /// What it shows: that the game's sound reached the sink. What it does not: that the sound is the RIGHT one; a
    /// person listening to the file is still what says that. The level is measured, not the content.
    ///
    /// Every pattern starts with "Nelim's Pickle Tools:" so that it cannot be ambiguous with a step of Pickle's own.
    /// </summary>
    [PickleSteps]
    public class SoundSteps
    {
        private const string FeatureFolder = "pickletools-sound";
        private const int MaxSeconds = 120;

        private sealed class Recording
        {
            public string Name;
            public string File;
            public string Source;
            public Process Process;
            public readonly StringBuilder Errors = new StringBuilder();
        }

        // Static: the step that starts a recording and the one that ends it share no object.
        private static Recording active;
        private static readonly Dictionary<string, string> Recorded = new Dictionary<string, string>();

        [When("Nelim's Pickle Tools: I record the sound as {string}")]
        public async Task Start(PickleContext ctx, string name)
        {
            ctx.Assert(active == null, $"already recording \"{active?.Name}\": stop that recording first");

            string directory = ScreenshotCapture.FrameDirectory(FeatureFolder, name);
            string file = Path.Combine(directory, "sound.wav");
            if (File.Exists(file))
            {
                File.Delete(file);
            }

            string source = Environment.GetEnvironmentVariable("PICKLETOOLS_SOUND_SOURCE");
            if (string.IsNullOrWhiteSpace(source))
            {
                source = SoundAnalysis.DefaultSource;
            }

            var recording = new Recording { Name = name, File = file, Source = source };
            var start = new ProcessStartInfo("ffmpeg", SoundAnalysis.RecordArguments(source, file, MaxSeconds))
            {
                UseShellExecute = false,
                CreateNoWindow = true,
                RedirectStandardInput = true,
                RedirectStandardError = true,
            };

            try
            {
                recording.Process = Process.Start(start);
            }
            catch (Exception exception)
            {
                ctx.Assert(false, $"ffmpeg could not be started ({exception.Message}): it has to be on the PATH of the game");
            }

            recording.Process.ErrorDataReceived += (sender, e) =>
            {
                if (e.Data != null)
                {
                    lock (recording.Errors)
                    {
                        recording.Errors.AppendLine(e.Data);
                    }
                }
            };
            recording.Process.BeginErrorReadLine();
            active = recording;

            // A source that does not exist, or no audio server at all, makes ffmpeg exit at once with a message.
            await ctx.WaitFrames(20);
            if (recording.Process.HasExited)
            {
                active = null;
                ctx.Assert(false,
                    $"ffmpeg stopped at once (exit {recording.Process.ExitCode}) while recording '{source}': {ErrorsOf(recording)}" +
                    "Is there an audio server (PULSE_SERVER) and does the source exist? `ffmpeg -sources pulse` lists them.");
            }
        }

        [When("Nelim's Pickle Tools: I let {int} real seconds go by", TimeoutSeconds = 60)]
        public async Task LetSecondsGoBy(PickleContext ctx, int seconds)
        {
            ctx.Assert(seconds >= 1 && seconds <= 45, "between 1 and 45 real seconds: a recording is a few seconds, not a film");
            var clock = Stopwatch.StartNew();
            while (clock.Elapsed.TotalSeconds < seconds)
            {
                await ctx.WaitFrames(1);
            }
        }

        [When("Nelim's Pickle Tools: I stop recording the sound")]
        public async Task Stop(PickleContext ctx)
        {
            ctx.Assert(active != null, "no recording is running: start one with \"I record the sound as ...\"");

            // The last buffers are still on their way from the audio server.
            await ctx.WaitFrames(10);
            Recording recording = active;
            active = null;

            Finish(recording);
            ctx.Assert(File.Exists(recording.File) && new FileInfo(recording.File).Length > 44,
                $"\"{recording.Name}\" left no sound file at {recording.File}: {ErrorsOf(recording)}");

            Recorded[recording.Name] = recording.File;
            ctx.Attach("sound-file", recording.File);
            ctx.Attach("sound-note", $"\"{recording.Name}\": recorded from '{recording.Source}', {new FileInfo(recording.File).Length} bytes. " +
                                     "It also played on the Windows speakers. Listening to the file is what says the sound is the right one.");
        }

        [Then("Nelim's Pickle Tools: the sound recorded as {string} is not silent")]
        public void IsNotSilent(PickleContext ctx, string name)
        {
            double peak = PeakOf(ctx, name);
            ctx.Attach("sound-level", $"\"{name}\": peak {peak:0.0} dB, the threshold is above {SoundAnalysis.NotSilentAboveDb:0} dB");
            ctx.Assert(SoundAnalysis.IsNotSilent(peak),
                $"the sound recorded as \"{name}\" peaks at {peak:0.0} dB, not above {SoundAnalysis.NotSilentAboveDb:0} dB: " +
                "the recorder heard nothing the game played (no audio output in the game, another sink, or nothing was played).");
        }

        [Then("Nelim's Pickle Tools: the sound recorded as {string} is silent")]
        public void IsSilent(PickleContext ctx, string name)
        {
            double peak = PeakOf(ctx, name);
            ctx.Attach("sound-level", $"\"{name}\": peak {peak:0.0} dB, silence is below {SoundAnalysis.SilentBelowDb:0} dB");
            ctx.Assert(SoundAnalysis.IsSilent(peak),
                $"the sound recorded as \"{name}\" peaks at {peak:0.0} dB, not below {SoundAnalysis.SilentBelowDb:0} dB: something was playing.");
        }

        // A scenario that dies between the two steps must not leave ffmpeg recording for the next one.
        [AfterScenario]
        public void CleanUp(PickleContext ctx)
        {
            if (active != null)
            {
                Recording recording = active;
                active = null;
                Finish(recording);
            }
        }

        private static void Finish(Recording recording)
        {
            Process process = recording.Process;
            if (process.HasExited)
            {
                return;
            }

            try
            {
                process.StandardInput.Write("q");
                process.StandardInput.Flush();
            }
            catch (Exception)
            {
                // ffmpeg already gone: the wait below returns at once.
            }

            if (!process.WaitForExit(8000))
            {
                process.Kill();
                process.WaitForExit(2000);
            }
        }

        private static string ErrorsOf(Recording recording)
        {
            lock (recording.Errors)
            {
                string text = recording.Errors.ToString().Trim();
                return text.Length == 0 ? "no message from ffmpeg. " : text + " ";
            }
        }

        private static double PeakOf(PickleContext ctx, string name)
        {
            string file;
            ctx.Assert(Recorded.TryGetValue(name, out file), $"nothing was recorded as \"{name}\": record it and stop first");

            var start = new ProcessStartInfo("ffmpeg", SoundAnalysis.VolumeDetectArguments(file))
            {
                UseShellExecute = false,
                CreateNoWindow = true,
                RedirectStandardError = true,
            };

            string report;
            using (Process process = Process.Start(start))
            {
                report = process.StandardError.ReadToEnd();
                process.WaitForExit(20000);
            }

            double peak;
            ctx.Assert(SoundAnalysis.TryParseMaxVolume(report, out peak),
                $"ffmpeg's volume report of {file} has no max_volume line:\n{report}");
            return peak;
        }
    }
}
