using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Holds the orthographic size the camera draws, below the floor the camera driver keeps (ACG gallery-ortho, ticket d222, 2026-11-09:
    /// root size 1.5 left Find.Camera.orthographicSize at 2). The camera driver writes the size each frame, so one direct write is lost: a
    /// postfix on the driver's per-frame methods writes it again after the driver. Written 2026-11-09. COMPILED, NOT PLAYED. Needs Harmony.
    /// </summary>
    [PickleSteps]
    public class CameraOrthoSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private static HarmonyLib.Harmony harmony;
        private static float? held;

        private static void PostDriver()
        {
            if (held.HasValue && Find.Camera != null)
            {
                Find.Camera.orthographicSize = held.Value;
            }
        }

        /// <summary>
        /// Sets the camera orthographic size (half the screen height in cells, smaller is closer) and keeps it there until the scenario ends,
        /// by writing it again after every update of the camera driver. Frame the subject first (centre the camera on the cell or the animal),
        /// then hold the size. Fails when the size is not positive, or when no camera driver method could be patched.
        /// </summary>
        [Given(Prefix + "the camera orthographic size is held at {float}")]
        public void HoldOrthographicSize(PickleContext ctx, float size)
        {
            ctx.Require(size > 0f, $"a camera orthographic size must be positive, not {size}");
            ctx.Require(Find.Camera != null, "no camera is loaded: load a map first");
            if (harmony == null)
            {
                var h = new HarmonyLib.Harmony("nelim.pickletools.orthoheld");
                int patched = 0;
                foreach (string name in new[] { "Update", "ApplyPositionToGameObject" })
                {
                    System.Reflection.MethodInfo m = typeof(CameraDriver).GetMethod(name, System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic);
                    if (m != null && !m.IsAbstract)
                    {
                        h.Patch(m, postfix: new HarmonyLib.HarmonyMethod(typeof(CameraOrthoSteps), nameof(PostDriver)));
                        patched++;
                    }
                }

                if (patched == 0)
                {
                    h.UnpatchAll(h.Id);
                    ctx.Require(false, "no CameraDriver Update or ApplyPositionToGameObject could be patched: the game changed");
                }

                harmony = h;
                Log.Message("[camera] " + patched + " CameraDriver methods are patched to hold the orthographic size");
            }

            held = size;
            Find.Camera.orthographicSize = size;
            Log.Message("[camera] orthographic size held at " + size + ", the camera reads " + Find.Camera.orthographicSize);
        }
    }
}
