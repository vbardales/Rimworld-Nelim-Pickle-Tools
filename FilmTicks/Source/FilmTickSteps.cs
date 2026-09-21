using System;
using System.Diagnostics;
using System.IO;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorks.Pickle.Evidence;
using RimWorks.Pickle.Runtime;
using Verse;

namespace Nelim.PickleTools.FilmTicks
{
    /// <summary>
    /// Films a stretch of a scenario one picture every N game ticks, as a pair of steps. Pickle's own
    /// <c>@film</c> is paced by a stopwatch at ten pictures a second, which catches an effect that lives one
    /// tick in fifteen only by chance, and it films the scenario from its first step, so a long walk uses up
    /// the cap before the interesting part. These steps film only between the two of them.
    ///
    /// Everything they use is public in Pickle: the frame hook, the detached jpeg capture, the frame folder
    /// and the encoder. Nothing is patched, so they work on the Workshop build as it is.
    ///
    /// The tick counter is read on each rendered frame. At normal speed that is one frame per tick, so
    /// <c>every 1 ticks</c> gives one picture per tick. Where several ticks run between two frames, or without
    /// <c>@watch</c>, a picture lands on the first frame after the interval and cannot show the ticks in between.
    ///
    /// Every pattern starts with "Nelim's Pickle Tools:". Pickle loads the steps of every installed suite into
    /// one namespace, and a repeated text is an "Ambiguous step" that fails healthy scenarios; if Pickle ever
    /// ships a step of its own with the same words, the prefix keeps these apart.
    /// </summary>
    [PickleSteps]
    public class FilmTickSteps
    {
        // The films of this tool sit under one folder name in the report, apart from Pickle's own per-feature ones.
        private const string FeatureFolder = "pickletools";

        // Pickle films at 960 wide because the jpeg encode runs on the main thread. Same here.
        private const int FrameWidth = 960;

        // A film past this is minutes of encoding. Counted in frames, since pictures are per tick, not per second.
        private const int MaxFrames = 900;

        private sealed class Recording
        {
            public string Name;
            public FilmTickGate Gate;
            public Action Hook;
            public int Frames;
            public bool Capped;
            public readonly Stopwatch Clock = Stopwatch.StartNew();
        }

        // Static: the step that starts a film and the one that ends it share no object.
        private static Recording active;

        [When("Nelim's Pickle Tools: I film every {int} ticks as {string}")]
        public void Start(PickleContext ctx, int ticksPerFrame, string name)
        {
            ctx.Require(Current.Game != null, "load a save first: the tick counter has to exist");
            ctx.Assert(ticksPerFrame >= 1, "a film needs at least one tick between pictures");
            ctx.Assert(active == null, $"already filming \"{active?.Name}\": stop that film first");

            string directory = ScreenshotCapture.FrameDirectory(FeatureFolder, name);
            foreach (string frame in Directory.GetFiles(directory, "*.jpg"))
            {
                File.Delete(frame);
            }

            File.Delete(Path.Combine(directory, "film.webm"));

            var recording = new Recording { Name = name, Gate = new FilmTickGate(ticksPerFrame) };
            recording.Hook = () => OnFrame(recording);
            active = recording;
            PickleDriver.Instance.AddFrameHook(recording.Hook);
        }

        [When("Nelim's Pickle Tools: I stop filming")]
        public async Task Stop(PickleContext ctx)
        {
            ctx.Assert(active != null, "no film is running: start one with \"I film every N ticks as ...\"");

            // The readback is asynchronous: the last pictures are still being written when the step arrives.
            await ctx.WaitFrames(10);
            Finish(ctx);
        }

        // A scenario that dies between the two steps must not leave a frame hook behind for the next one.
        [AfterScenario]
        public void CleanUp(PickleContext ctx)
        {
            if (active != null)
            {
                Finish(ctx);
            }
        }

        private static void OnFrame(Recording recording)
        {
            if (recording.Frames >= MaxFrames)
            {
                recording.Capped = true;
                return;
            }

            if (!recording.Gate.ShouldCapture(Find.TickManager.TicksGame))
            {
                return;
            }

            PickleDriver.Instance.CaptureFrameDetached(
                ScreenshotCapture.BuildFramePath(FeatureFolder, recording.Name, recording.Frames), FrameWidth);
            recording.Frames++;
        }

        private static void Finish(PickleContext ctx)
        {
            Recording recording = active;
            active = null;
            PickleDriver.Instance.RemoveFrameHook(recording.Hook);
            PickleDriver.Instance.ReleaseFrameBuffers();
            recording.Clock.Stop();

            if (recording.Frames == 0)
            {
                ctx.Attach("film-note", $"\"{recording.Name}\" took no picture: no rendered frame came between the two steps.");
                return;
            }

            string directory = ScreenshotCapture.FrameDirectory(FeatureFolder, recording.Name);
            double seconds = Math.Max(recording.Clock.Elapsed.TotalSeconds, 0.1);
            double fps = recording.Frames / seconds;
            string webm = FilmEncoder.Available ? FilmEncoder.TryEncode(directory, fps) : null;

            string note = $"\"{recording.Name}\": {recording.Frames} pictures in {seconds:0.0} s" +
                          (recording.Capped ? $", stopped at the {MaxFrames}-picture cap" : string.Empty) +
                          (webm != null ? $", encoded to {webm}" : ", not encoded (no ffmpeg on the PATH, or the encode failed)");
            ctx.Attach("film-note", note);
            ctx.Attach("film-frames", ScreenshotCapture.BuildFramePath(FeatureFolder, recording.Name, 0));
        }
    }
}
