using System;
using System.Linq;
using System.Threading.Tasks;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.InspectTabs
{
    /// <summary>
    /// Steps for the info card, the window the small "i" button of the inspect pane opens (<c>Dialog_InfoCard</c>), with its tabs.
    /// Not part of the Pickle pull request. Written 2026-10-12 for AnimalsNaturally (a gallery image of an animal's Health tab).
    /// Not played.
    /// </summary>
    [PickleSteps]
    public class InfoCardSteps
    {
        /// <summary>
        /// Opens the info card of the single selected thing on a tab, as the "i" button does. The tab is named by its enum name
        /// (<c>Stats</c>, <c>Character</c>, <c>Health</c>, <c>Records</c>), never by the translated label. Fails when nothing or several
        /// things are selected, or when the name is not a tab of this game version (the message lists them). The card is a window: close it
        /// with <c>I close the info card</c>.
        /// </summary>
        [When("Nelim's Pickle Tools: I open the info card of the selected thing on the {string} tab")]
        public async Task OpenInfoCard(PickleContext ctx, string tabName)
        {
            ctx.Require(Find.Selector.SingleSelectedThing != null, "select exactly one thing first: the info card shows one");
            Dialog_InfoCard.InfoCardTab tab;
            ctx.Require(
                Enum.TryParse(tabName, true, out tab),
                $"'{tabName}' is not an info card tab; the tabs are: {string.Join(", ", Enum.GetNames(typeof(Dialog_InfoCard.InfoCardTab)))}");
            var card = new Dialog_InfoCard(Find.Selector.SingleSelectedThing);
            card.SetTab(tab);
            Find.WindowStack.Add(card);
            await ctx.WaitFrames(2);
            ctx.Assert(Find.WindowStack.WindowOfType<Dialog_InfoCard>() != null, "the info card did not open");
        }

        /// <summary>Closes the info card if one is open; nothing otherwise, so it can end every scenario that opened one.</summary>
        [When("Nelim's Pickle Tools: I close the info card")]
        public async Task CloseInfoCard(PickleContext ctx)
        {
            Dialog_InfoCard card = Find.WindowStack.WindowOfType<Dialog_InfoCard>();
            if (card != null)
            {
                card.Close(false);
                await ctx.WaitFrames(2);
            }
        }
    }
}
