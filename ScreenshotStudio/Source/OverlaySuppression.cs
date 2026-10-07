using System;
using System.Reflection;
using HarmonyLib;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Hides what the game draws without a setting for it: the status icons over buildings (no power, broken down), the stack counts under items and the name labels under pawns (a prefix on
    /// <c>ThingOverlays.ThingOverlaysOnGUI</c>), the mouse-over tooltips (<c>TooltipHandler.DoTooltipGUI</c>) and the learning helper's
    /// new cards (<c>LearningReadout.TryActivateConcept</c>). Each patch is installed on first use only; a scenario that never asks never has the
    /// game patched. Needs Harmony in the mod list.
    /// </summary>
    internal static class OverlaySuppression
    {
        private static readonly object Gate = new object();
        private static Harmony harmony;
        private static bool overlaysPatched, tooltipsPatched, helperPatched, readoutPatched, alertsPatched, statusPatched, bracketsPatched;

        public static bool Active { get; private set; }
        public static bool TooltipsHidden { get; private set; }
        public static bool HelperHidden { get; private set; }
        public static bool ReadoutHidden { get; private set; }
        public static bool AlertsHidden { get; private set; }
        public static bool BracketsHidden { get; private set; }

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
                if (!statusPatched)
                {
                    // The status icons over buildings (no power, power off, broken down, out of fuel): presentation mode hides them too.
                    foreach (string name in new[] { "RenderNeedsPowerOverlay", "RenderPowerOffOverlay", "RenderBrokenDownOverlay", "RenderOutOfFuelOverlay" })
                    {
                        MethodInfo method = AccessTools.Method(typeof(OverlayDrawer), name);
                        if (method != null) harmony.Patch(method, prefix: new HarmonyMethod(typeof(OverlaySuppression), nameof(SkipOverlays)));
                    }
                    statusPatched = true;
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

        public static void HideReadout()
        {
            lock (Gate)
            {
                Harmony();
                if (!readoutPatched)
                {
                    harmony.Patch(AccessTools.Method(typeof(ResourceReadout), nameof(ResourceReadout.ResourceReadoutOnGUI)), prefix: new HarmonyMethod(typeof(OverlaySuppression), nameof(SkipReadout)));
                    readoutPatched = true;
                }
                ReadoutHidden = true;
            }
        }

        public static void HideAlerts()
        {
            lock (Gate)
            {
                Harmony();
                if (!alertsPatched)
                {
                    harmony.Patch(AccessTools.Method(typeof(AlertsReadout), nameof(AlertsReadout.AlertsReadoutOnGUI)), prefix: new HarmonyMethod(typeof(OverlaySuppression), nameof(SkipAlerts)));
                    alertsPatched = true;
                }
                AlertsHidden = true;
            }
        }

        public static void HideBrackets()
        {
            lock (Gate)
            {
                Harmony();
                if (!bracketsPatched)
                {
                    harmony.Patch(AccessTools.Method(typeof(SelectionDrawer), nameof(SelectionDrawer.DrawSelectionOverlays)), prefix: new HarmonyMethod(typeof(OverlaySuppression), nameof(SkipBrackets)));
                    bracketsPatched = true;
                }
                BracketsHidden = true;
            }
        }

        public static void End() { Active = false; TooltipsHidden = false; HelperHidden = false; ReadoutHidden = false; AlertsHidden = false; BracketsHidden = false; }

        private static void Harmony() { if (harmony == null) harmony = new Harmony("nelim.pickletools.screenshotstudio.overlays"); }

        private static bool SkipOverlays() => !Active;
        private static bool SkipTooltips() => !TooltipsHidden;
        private static bool SkipConcepts() => !HelperHidden;
        private static bool SkipReadout() => !ReadoutHidden;
        private static bool SkipAlerts() => !AlertsHidden;
        private static bool SkipBrackets() => !BracketsHidden;
    }
}
