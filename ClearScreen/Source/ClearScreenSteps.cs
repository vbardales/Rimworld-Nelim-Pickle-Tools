using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ClearScreen
{
    /// <summary>
    /// A click step aims at a point on screen, so a window another mod owns over that point takes the
    /// click and the scenario reads as a dead button. These steps close what is open and keep it closed
    /// for the rest of the scenario.
    ///
    /// These are the same steps as the ones proposed to Pickle itself, RimWorks/Rimworld-Pickle pull
    /// request 21 (<c>the screen is clear</c> and <c>windows are allowed to open again</c>, branch
    /// <c>feat/clear-the-screen</c> on the fork). **When it lands, this mod can go**, and a scenario
    /// written against it changes one prefix. Until then the two are kept in step: a change asked for in
    /// review is made in both places.
    ///
    /// The patterns start with "Nelim's Pickle Tools:". Pickle loads the steps of every installed suite
    /// into one namespace, and a repeated text is an "Ambiguous step" that fails healthy scenarios. Once
    /// Pickle ships the steps under its own words, the prefix is what keeps the two apart.
    /// </summary>
    [PickleSteps]
    public class ClearScreenSteps
    {
        /// <summary>
        /// Closes every window the runner does not own, and drops every one that opens until the scenario ends,
        /// the scenario's own included: lift it with "windows are allowed to open again" before a click whose
        /// effect is to open a window.
        /// </summary>
        [Given("Nelim's Pickle Tools: the screen is clear")]
        public async Task ScreenIsClear(PickleContext ctx)
        {
            WindowSuppression.Begin();

            foreach (Window window in Find.WindowStack.Windows.Where(w => !WindowSuppression.IsOwn(w)).ToList())
            {
                Find.WindowStack.TryRemove(window, doCloseSound: false);
            }

            await ctx.WaitFrames(2);
        }

        /// <summary>Lets the game open its own windows again, undoing the clear screen.</summary>
        [When("Nelim's Pickle Tools: windows are allowed to open again")]
        public void AllowWindows(PickleContext ctx)
        {
            WindowSuppression.End();
        }

        // A scenario that dies between the two steps would otherwise leave the player's game unable to
        // open anything at all, which is a far worse failure than the one being tested.
        [AfterScenario]
        public void ReleaseWindowSuppression()
        {
            WindowSuppression.End();
        }
    }
}
