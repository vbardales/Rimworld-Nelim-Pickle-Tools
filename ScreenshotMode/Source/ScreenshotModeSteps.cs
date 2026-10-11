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

        /// <summary>
        /// Clears the messages drawn at the top left of the screen (<c>Messages.Clear()</c>: "The psychic soothe is ending."...). A message the game posts later still appears: play it
        /// right before the capture. Written 2026-10-10 for Anima Song. Not played when written.
        /// </summary>
        [When("Nelim's Pickle Tools: the messages are cleared from the screen")]
        public void ClearMessages(PickleContext ctx)
        {
            Messages.Clear();
        }

        /// <summary>
        /// Pauses the game and remembers the speed it had, so the beasts (or animals, or pawns) stay where they were put until the capture. The
        /// speed comes back with <c>the interface is shown again</c> or after the scenario. From Ancient Chinese Beast, 2026-10-11 (its
        /// <c>time is paused</c>), moved here because a second mod (Animal Ark) uses the same helper.
        /// </summary>
        [When("Nelim's Pickle Tools: time is paused for the capture", TimeoutSeconds = 30f)]
        public async Task TimePaused(PickleContext ctx)
        {
            if (!paused) { savedSpeed = Find.TickManager.CurTimeSpeed; paused = true; }
            Find.TickManager.CurTimeSpeed = TimeSpeed.Paused;
            await ctx.WaitFrames(3);
        }

        /// <summary>
        /// A capture of the map and nothing else: the game's own screenshot mode, with EVERY open window (the Pickle launcher panel and the
        /// log viewer included) told not to draw in it. Unlike <c>screenshot mode is enabled around the open windows</c>, which keeps the
        /// windows that are not Pickle's. Undone by <c>the interface is shown again</c> or after the scenario. From Ancient Chinese Beast, 2026-10-11.
        /// </summary>
        [When("Nelim's Pickle Tools: the map is shown alone for a capture", TimeoutSeconds = 30f)]
        public async Task MapAlone(PickleContext ctx)
        {
            Restore();
            var root = Find.UIRoot;
            ctx.Require(root?.screenshotMode != null, "no UIRoot screenshot mode is available");
            foreach (var window in Find.WindowStack.Windows.ToList())
            {
                previous[window] = window.drawInScreenshotMode;
                window.drawInScreenshotMode = false;
            }

            wasActive = root.screenshotMode.Active;
            root.screenshotMode.Active = true;
            enabled = true;
            await ctx.WaitFrames(3);
        }

        /// <summary>Puts the windows, the screenshot mode and the game speed back (what <c>the map is shown alone for a capture</c> and <c>time is paused for the capture</c> changed).</summary>
        [When("Nelim's Pickle Tools: the interface is shown again")]
        public void InterfaceBack(PickleContext ctx)
        {
            Restore();
            RestorePause();
        }

        private bool paused;
        private TimeSpeed savedSpeed = TimeSpeed.Normal;

        private void RestorePause()
        {
            if (paused && Find.TickManager != null) Find.TickManager.CurTimeSpeed = savedSpeed;
            paused = false;
        }
        [AfterScenario]
        public void RestoreAfterScenario(PickleContext ctx)
        {
            Restore();
            RestorePause();
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
