using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ScreenshotMode
{
    [PickleSteps]
    public sealed class ScreenshotModeSteps
    {
        private readonly Dictionary<Window, bool> previous = new Dictionary<Window, bool>();
        private bool wasActive;
        private bool enabled;

        private static bool IsPickleWindow(Window window)
        {
            return window.GetType().Assembly.GetName().Name
                .StartsWith("RimWorks.Pickle", StringComparison.OrdinalIgnoreCase);
        }

        [When("Nelim's Pickle Tools: screenshot mode is enabled around the open windows")]
        public async Task Enable(PickleContext ctx)
        {
            Restore();
            var root = Find.UIRoot;
            ctx.Require(root?.screenshotMode != null, "no UIRoot screenshot mode is available");

            var retained = 0;
            foreach (var window in Find.WindowStack.Windows.ToList())
            {
                previous[window] = window.drawInScreenshotMode;
                var keep = !IsPickleWindow(window);
                window.drawInScreenshotMode = keep;
                if (keep) retained++;
            }
            ctx.Require(retained > 0,
                "every open window belongs to Pickle; open the window to review before enabling screenshot mode");

            wasActive = root.screenshotMode.Active;
            root.screenshotMode.Active = true;
            enabled = true;
            await ctx.WaitFrames(3);
        }

        [When("Nelim's Pickle Tools: screenshot mode is disabled")]
        public void Disable(PickleContext ctx)
        {
            Restore();
        }

        // Screenshot mode hides the developer controls, but it also hides the main tab bar, which some
        // captures need (a main tab's panel is only recognisable with the bar under it). This step is for
        // those: it turns developer mode off and leaves the rest of the interface as a player sees it.
        // The runner starts the game with developer mode on, so a full-interface capture shows its
        // toolbar unless this runs first.
        [When("Nelim's Pickle Tools: developer mode is turned off for the capture")]
        public async Task DeveloperModeOff(PickleContext ctx)
        {
            if (!developerModeChanged) developerModeBefore = Prefs.DevMode;
            developerModeChanged = true;
            Prefs.DevMode = false;
            await ctx.WaitFrames(3);
        }

        [When("Nelim's Pickle Tools: developer mode is restored")]
        public void DeveloperModeRestored(PickleContext ctx)
        {
            RestoreDeveloperMode();
        }

        private static readonly FieldInfo ActiveAlertsField =
            typeof(AlertsReadout).GetField("activeAlerts", BindingFlags.NonPublic | BindingFlags.Instance);

        /// <summary>
        /// Clears the letter stack (public API: <c>LetterStack.RemoveLetter</c>) and the alerts readout's
        /// currently drawn list (private field, cleared by reflection: <c>AlertsReadout</c> has no public way
        /// to do this). Neither is a lasting suppression: a letter removed this way is gone for good (the
        /// game's own dismiss), but an alert whose condition is still true comes back on its own within at
        /// most 24 frames (<c>AlertsReadout.AlertsReadoutUpdate</c> checks a slice of all alert types every
        /// frame, round-robin). This only clears what is on screen for the capture that follows right away;
        /// it proves nothing about alerts or letters, and is not a way to silence them for a scenario.
        /// From DrumBathHygiene, 2026-09-27 (its own local step, ported here as shared).
        /// </summary>
        [When("Nelim's Pickle Tools: the letters and the alerts are cleared from the screen")]
        public void ClearLettersAndAlerts(PickleContext ctx)
        {
            ctx.Require(ActiveAlertsField != null,
                "AlertsReadout has no field 'activeAlerts' any more: the game moved it, this step has to be rewritten");
            var uiRoot = Find.UIRoot as UIRoot_Play;
            ctx.Require(uiRoot != null, "no play UI is up (Find.UIRoot is not a UIRoot_Play); load a save first");

            foreach (Letter letter in Find.LetterStack.LettersListForReading.ToList())
            {
                Find.LetterStack.RemoveLetter(letter);
            }

            ((IList)ActiveAlertsField.GetValue(uiRoot.alerts)).Clear();
        }

        [AfterScenario]
        public void RestoreAfterScenario(PickleContext ctx)
        {
            Restore();
            RestoreDeveloperMode();
        }

        private bool developerModeBefore;
        private bool developerModeChanged;

        private void RestoreDeveloperMode()
        {
            if (!developerModeChanged) return;
            Prefs.DevMode = developerModeBefore;
            developerModeChanged = false;
        }

        private void Restore()
        {
            if (!enabled) return;
            foreach (var pair in previous)
                if (pair.Key != null) pair.Key.drawInScreenshotMode = pair.Value;
            previous.Clear();
            var root = Find.UIRoot;
            if (root?.screenshotMode != null) root.screenshotMode.Active = wasActive;
            enabled = false;
        }
    }
}
