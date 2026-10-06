using System;
using HarmonyLib;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Hides the text the game draws over things on the map: the stack counts under items and the name labels under pawns. The game has no
    /// setting for either, so a prefix on <c>ThingOverlays.ThingOverlaysOnGUI</c> skips them while a presentation scenario runs. The game is
    /// patched on first use only; a scenario that never turns presentation mode on never has it patched. Needs Harmony in the mod list.
    /// </summary>
    internal static class OverlaySuppression
    {
        private static readonly object Gate = new object();
        private static bool patched;

        public static bool Active { get; private set; }

        public static void Begin()
        {
            lock (Gate)
            {
                if (!patched)
                {
                    var harmony = new Harmony("nelim.pickletools.screenshotstudio.overlays");
                    harmony.Patch(AccessTools.Method(typeof(ThingOverlays), nameof(ThingOverlays.ThingOverlaysOnGUI)),
                        prefix: new HarmonyMethod(typeof(OverlaySuppression), nameof(SkipWhileActive)));
                    patched = true;
                }
                Active = true;
            }
        }

        public static void End() { Active = false; }

        private static bool SkipWhileActive() => !Active;
    }
}
