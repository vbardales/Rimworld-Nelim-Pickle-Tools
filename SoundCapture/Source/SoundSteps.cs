using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Text;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorks.Pickle.Evidence;
using RimWorks.Pickle.Runtime;
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

            // Set when the recording is also a film: pictures by the clock, from the moment ffmpeg is started.
            public bool Film;
            public Action Hook;
            public int Frames;
            public bool Capped;
            public Stopwatch Clock;

            // Real time from the start of the recorder to its stop, to compare with the length of the file it left.
            public readonly Stopwatch Elapsed = Stopwatch.StartNew();
            public int Rate = 22050;
            public int Channels = 1;
        }

        // Static: the step that starts a recording and the one that ends it share no object.
        private static Recording active;
        private static readonly Dictionary<string, string> Recorded = new Dictionary<string, string>();
        private static readonly Dictionary<string, string> Short = new Dictionary<string, string>();

        // Ten pictures a second, as Pickle's own @film, at the width it uses because the jpeg encode runs on the main thread.
        private const int PictureEveryMilliseconds = 100;
        private const int FrameWidth = 960;
        private const int MaxFrames = 600;

        [When("Nelim's Pickle Tools: I record the sound as {string}")]
        public async Task Start(PickleContext ctx, string name)
        {
            await Begin(ctx, name, false);
        }

        /// <summary>
        /// A video WITH its sound: the recorder and the film start in the same step, so the sound and the picture begin
        /// together (to within ffmpeg's start, a fraction of a second). Pickle's own @film has no sound, and FilmTicks
        /// films by game ticks, whose length is not the length of the sound.
        /// </summary>
        [When("Nelim's Pickle Tools: I film with sound as {string}", TimeoutSeconds = 30)]
        public async Task StartFilm(PickleContext ctx, string name)
        {
            await Begin(ctx, name, true);
        }

        private async Task Begin(PickleContext ctx, string name, bool film)
        {
            ctx.Assert(active == null, $"already recording \"{active?.Name}\": stop that recording first");

            string directory = ScreenshotCapture.FrameDirectory(FeatureFolder, name);
            string file = Path.Combine(directory, "sound.wav");
            if (File.Exists(file))
            {
                File.Delete(file);
            }

            if (film)
            {
                foreach (string frame in Directory.GetFiles(directory, "*.jpg"))
                {
                    File.Delete(frame);
                }

                foreach (string old in new[] { "film.webm", "film-sound.mp4" })
                {
                    File.Delete(Path.Combine(directory, old));
                }
            }

            string source = Environment.GetEnvironmentVariable("PICKLETOOLS_SOUND_SOURCE");
            if (string.IsNullOrWhiteSpace(source))
            {
                source = SoundAnalysis.DefaultSource;
            }

            var recording = new Recording { Name = name, File = file, Source = source, Film = film, Rate = film ? 44100 : 22050, Channels = film ? 2 : 1 };

            // A sound that goes into a video is kept at CD quality; a sound that is only measured needs no more than this.
            string arguments = film
                ? SoundAnalysis.RecordArguments(source, file, MaxSeconds, 44100, 2)
                : SoundAnalysis.RecordArguments(source, file, MaxSeconds);
            var start = new ProcessStartInfo("ffmpeg", arguments)
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

            if (film)
            {
                // Before the wait below, so that the picture starts with the sound and not twenty frames after it.
                recording.Clock = Stopwatch.StartNew();
                recording.Hook = () => OnFrame(recording);
                PickleDriver.Instance.AddFrameHook(recording.Hook);
            }

            // A source that does not exist, or no audio server at all, makes ffmpeg exit at once with a message.
            await ctx.WaitFrames(20);
            if (recording.Process.HasExited)
            {
                active = null;
                EndFilm(recording);
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
            ctx.Assert(!active.Film, $"\"{active.Name}\" is a film with sound: end it with \"I stop filming with sound\"");
            await End(ctx);
        }

        // The encode of the pictures and the mux run on the main thread, as those of FilmTicks do: a few seconds, so the step has room.
        [When("Nelim's Pickle Tools: I stop filming with sound", TimeoutSeconds = 120)]
        public async Task StopFilm(PickleContext ctx)
        {
            ctx.Assert(active != null, "no film is running: start one with \"I film with sound as ...\"");
            ctx.Assert(active.Film, $"\"{active.Name}\" is a sound only: end it with \"I stop recording the sound\"");
            await End(ctx);
        }

        private async Task End(PickleContext ctx)
        {
            // The last buffers are still on their way from the audio server, and the last pictures still being written.
            await ctx.WaitFrames(10);
            Recording recording = active;
            active = null;

            EndFilm(recording);
            Finish(recording);
            ctx.Assert(File.Exists(recording.File) && new FileInfo(recording.File).Length > 44,
                $"\"{recording.Name}\" left no sound file at {recording.File}: {ErrorsOf(recording)}");

            Recorded[recording.Name] = recording.File;
            string shortNote = ShortRecording(recording);
            if (shortNote != null)
            {
                Short[recording.Name] = shortNote;
                ctx.Attach("sound-short", shortNote);
            }

            ctx.Attach("sound-file", recording.File);
            ctx.Attach("sound-note", $"\"{recording.Name}\": recorded from '{recording.Source}', {new FileInfo(recording.File).Length} bytes. " +
                                     "It also played on the Windows speakers. Listening to the file is what says the sound is the right one.");

            if (recording.Film)
            {
                Mux(ctx, recording);
            }
        }

        private static void OnFrame(Recording recording)
        {
            if (recording.Frames >= MaxFrames)
            {
                recording.Capped = true;
                return;
            }

            // By the clock, not by the frame: the picture of a second is ten pictures however slowly the game draws.
            if (recording.Clock.ElapsedMilliseconds < recording.Frames * (long)PictureEveryMilliseconds)
            {
                return;
            }

            PickleDriver.Instance.CaptureFrameDetached(
                ScreenshotCapture.BuildFramePath(FeatureFolder, recording.Name, recording.Frames), FrameWidth);
            recording.Frames++;
        }

        // Takes the frame hook off and stops the clock; the pictures are encoded later, once the sound has stopped as well.
        private static void EndFilm(Recording recording)
        {
            if (!recording.Film || recording.Hook == null)
            {
                return;
            }

            PickleDriver.Instance.RemoveFrameHook(recording.Hook);
            recording.Hook = null;
            PickleDriver.Instance.ReleaseFrameBuffers();
            recording.Clock.Stop();
        }

        private static void Mux(PickleContext ctx, Recording recording)
        {
            string directory = ScreenshotCapture.FrameDirectory(FeatureFolder, recording.Name);
            ctx.Assert(recording.Frames > 0, $"\"{recording.Name}\" took no picture: no rendered frame came between the two steps.");
            ctx.Assert(FilmEncoder.Available, "the film cannot be encoded: no ffmpeg that Pickle's encoder can use on the PATH");

            // As FilmTicks does: the pictures are encoded at the rate they were taken, so the video lasts as long as the sound.
            double seconds = Math.Max(recording.Clock.Elapsed.TotalSeconds, 0.1);
            double fps = recording.Frames / seconds;
            string webm = FilmEncoder.TryEncode(directory, fps);
            ctx.Assert(webm != null && File.Exists(webm), $"Pickle's encoder made no video from the {recording.Frames} pictures of \"{recording.Name}\"");

            string mp4 = Path.Combine(directory, "film-sound.mp4");
            var start = new ProcessStartInfo("ffmpeg", SoundAnalysis.MuxArguments(webm, recording.File, mp4))
            {
                UseShellExecute = false,
                CreateNoWindow = true,
                RedirectStandardError = true,
            };

            string report;
            int exit;
            using (Process process = Process.Start(start))
            {
                report = process.StandardError.ReadToEnd();
                process.WaitForExit(90000);
                exit = process.HasExited ? process.ExitCode : -1;
            }

            ctx.Assert(exit == 0 && File.Exists(mp4) && new FileInfo(mp4).Length > 0,
                $"ffmpeg could not put the sound into the video (exit {exit}): {report.Trim()}");

            ctx.Attach("film-file", mp4);
            ctx.Attach("film-note", $"\"{recording.Name}\": {recording.Frames} pictures in {seconds:0.0} s" +
                                    (recording.Capped ? $", stopped at the {MaxFrames}-picture cap" : string.Empty) +
                                    $", with the sound, in {mp4}. The picture and the sound start together to within ffmpeg's start; " +
                                    "watching and listening to the file is what says they are in step.");
        }

        [Then("Nelim's Pickle Tools: the sound recorded as {string} is not silent")]
        public void IsNotSilent(PickleContext ctx, string name)
        {
            double peak = PeakOf(ctx, name);
            ctx.Attach("sound-level", $"\"{name}\": peak {peak:0.0} dB, the threshold is above {SoundAnalysis.NotSilentAboveDb:0} dB");
            ctx.Assert(SoundAnalysis.IsNotSilent(peak),
                $"the sound recorded as \"{name}\" peaks at {peak:0.0} dB, not above {SoundAnalysis.NotSilentAboveDb:0} dB: " +
                "the recorder heard nothing the game played (no audio output in the game, another sink, or nothing was played)." +
                (Short.ContainsKey(name) ? " " + Short[name] : string.Empty));
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
                EndFilm(recording);
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

        // An audio server that delivers nothing (an idle sink, or a stalled one: the WSLg rdp-sink of 2026-09-25) leaves a file that holds a
        // fraction of the real time, and a video whose sound would then be out of step. Say so instead of leaving a bare level.
        private static string ShortRecording(Recording recording)
        {
            double held = Math.Max(new FileInfo(recording.File).Length - 44, 0) / (double)(recording.Rate * recording.Channels * 2);
            double real = recording.Elapsed.Elapsed.TotalSeconds;
            if (held >= real * 0.8)
            {
                return null;
            }

            return $"\"{recording.Name}\": the file holds {held:0.0} s of sound for {real:0.0} s of recording. The audio server delivered data for only part of the time " +
                   "(an idle sink sends nothing, and a stalled one sends nothing at all: see the WSLg pulseaudio.log for \"rdp-sink ... q overrun\"). " +
                   "A level measured on it says little, and a video made with it would be out of step.";
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
