using System;
using System.Reflection;
using HarmonyLib;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Hides what the game draws without a setting for it: the stack counts under items and the name labels under pawns (a prefix on
    /// <c>ThingOverlays.ThingOverlaysOnGUI</c>), the mouse-over tooltips (<c>TooltipHandler.DoTooltipGUI</c>) and the learning helper's
    /// new cards (<c>LearningReadout.TryActivateConcept</c>). Each patch is installed on first use only; a scenario that never asks never has the
    /// game patched. Needs Harmony in the mod list.
    /// </summary>
    internal static class OverlaySuppression
    {
        private static readonly object Gate = new object();
        private static Harmony harmony;
        private static bool overlaysPatched, tooltipsPatched, helperPatched;

        public static bool Active { get; private set; }
        public static bool TooltipsHidden { get; private set; }
        public static bool HelperHidden { get; private set; }

        public static void Begin()
        {
            lock (Gate)
            {
                Harmony();
                if (!overlaysPatched)
                {
                    harmony.Patch(AccessTools.Method(typeof(ThingOverlays), nameof(ThingOverlays.ThingOverlaysOnGUI)), prefix: new HarmonyMethod(typeof(OverlaySuppression), nameof(SkipOverlays)));
                    overlaysPatched = true;
                }
                Active = true;
            }
        }

        public static void HideTooltips()
        {
            lock (Gate)
            {
                Harmony();
                if (!tooltipsPatched)
                {
                    harmony.Patch(AccessTools.Method(typeof(TooltipHandler), nameof(TooltipHandler.DoTooltipGUI)), prefix: new HarmonyMethod(typeof(OverlaySuppression), nameof(SkipTooltips)));
                    tooltipsPatched = true;
                }
                TooltipsHidden = true;
            }
        }

        public static void HideHelper()
        {
            lock (Gate)
            {
                Harmony();
                if (!helperPatched)
                {
                    MethodInfo method = AccessTools.Method(typeof(LearningReadout), "TryActivateConcept");
                    if (method != null) harmony.Patch(method, prefix: new HarmonyMethod(typeof(OverlaySuppression), nameof(SkipConcepts)));
                    helperPatched = true;
                }
                HelperHidden = true;
            }
        }

        public static void End() { Active = false; TooltipsHidden = false; HelperHidden = false; }

        private static void Harmony() { if (harmony == null) harmony = new Harmony("nelim.pickletools.screenshotstudio.overlays"); }

        private static bool SkipOverlays() => !Active;
        private static bool SkipTooltips() => !TooltipsHidden;
        private static bool SkipConcepts() => !HelperHidden;
    }
}
