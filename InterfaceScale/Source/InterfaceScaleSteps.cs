using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.InterfaceScale
{
    /// <summary>
    /// Changes the interface scale the way the Options page does, for the length of a scenario - and puts
    /// the tag store repair in place before any scenario of the run, so that a click lands at that scale.
    ///
    /// This is the same step as the one proposed to Pickle itself, RimWorks/Rimworld-Pickle pull request
    /// 23 (<c>the interface scale is {int} percent</c>, branch <c>fix/tag-rect-interface-scale</c> on the
    /// fork). **When it lands, this mod's step can go**, and a scenario written against it changes one
    /// prefix. Until then the two are kept in step: a change asked for in review is made in both places.
    ///
    /// The pattern starts with "Nelim's Pickle Tools:". Pickle loads the steps of every installed suite
    /// into one namespace, and a repeated text is an "Ambiguous step" that fails healthy scenarios. Once
    /// Pickle ships the step under its own words, the prefix is what keeps the two apart.
    /// </summary>
    [PickleSteps]
    public class InterfaceScaleSteps
    {
        private float? scaleBeforeScenario;

        // Before EVERY scenario of the run, whatever suite it belongs to: Pickle scans the step classes of
        // all the suites for hooks. A suite that stages this mod gets a tag store that converts right at
        // every scale without writing a line of Gherkin, which is the point - the scenarios that need it
        // (a click at 150 percent) are the ones a suite already has.
        [BeforeScenario]
        public void RepairTagStore(PickleContext ctx)
        {
            TagStoreRepair.Ensure(ctx);
        }

        // Writing Prefs.UIScale is not enough, and a scenario that only writes it tests nothing. Widgets are
        // laid out in UI.screenWidth/screenHeight, two cached fields that only Root.OnGUI recomputes, and a
        // window already open keeps the rect it was given in the old space until something tells it the
        // resolution moved. A tag recorded from such a rect points where nothing is drawn any more, and the
        // click that follows misses for a reason that has nothing to do with the conversion under test. So:
        // write it, drop the label widths measured at the old scale, let frames pass for the fields, lay the
        // open windows out again as WindowStack.AdjustWindowsIfResolutionChanged does, and refuse to go on
        // if the GUI space did not follow.
        //
        // Prefs.Save is never called and the hook below puts the value back, so a run leaves the player's
        // scale as it found it.
        [Given("Nelim's Pickle Tools: the interface scale is {int} percent")]
        public async Task InterfaceScaleIs(PickleContext ctx, int percent)
        {
            scaleBeforeScenario ??= Prefs.UIScale;

            Prefs.UIScale = percent / 100f;
            GenUI.ClearLabelWidthCache();
            await ctx.WaitFrames(2);

            foreach (var window in Find.WindowStack.Windows.ToList())
            {
                window.Notify_ResolutionChanged();
            }

            await ctx.WaitFrames(5);

            var expected = Mathf.RoundToInt(Screen.height / Prefs.UIScale);
            ctx.Require(
                Verse.UI.screenHeight == expected,
                $"the GUI space did not follow the scale: UI.screenHeight is {Verse.UI.screenHeight}, and "
                    + $"{Screen.height} pixels at {Prefs.UIScale:0.##} make {expected}. Every rect measured now "
                    + "still belongs to the old layout");
        }

        [AfterScenario]
        public void RestoreInterfaceScale()
        {
            if (scaleBeforeScenario is float previous)
            {
                Prefs.UIScale = previous;
                scaleBeforeScenario = null;
            }
        }
    }
}
