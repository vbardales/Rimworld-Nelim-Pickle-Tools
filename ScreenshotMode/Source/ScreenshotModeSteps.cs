using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ScreenshotMode
{
    [PickleSteps]
    public sealed class ScreenshotModeSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private readonly Dictionary<Window, bool> previous = new Dictionary<Window, bool>();
        private bool wasActive;
        private bool enabled;

        private static bool IsPickleWindow(Window window)
        {
            return window.GetType().Assembly.GetName().Name
                .StartsWith("RimWorks.Pickle", StringComparison.OrdinalIgnoreCase);
        }

        [When(Prefix + "screenshot mode is enabled around the open windows")]
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

        [When(Prefix + "screenshot mode is disabled")]
        public void Disable(PickleContext ctx)
        {
            Restore();
        }

        [AfterScenario]
        public void RestoreAfterScenario(PickleContext ctx)
        {
            Restore();
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
