using System;
using System.Linq;
using System.Reflection;
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

        /// <summary>
        /// Types a text in the search box of the info card's Stats tab, as a player does: the rows that match are highlighted, the others
        /// dimmed, and the list scrolls to the first match. The card must be open on the Stats tab. Written 2026-10-25 for
        /// GeniusesCraftFastRenew (the General Labor Speed row). Compiled, not played.
        /// </summary>
        [When("Nelim's Pickle Tools: I type {string} in the search box of the open info card")]
        public async Task TypeInSearchBox(PickleContext ctx, string text)
        {
            RequireStatsTab(ctx);
            await ctx.WaitFrames(2);
            StatsReportUtility.QuickSearchWidget.filter.Text = text;
            StatsReportUtility.Notify_QuickSearchChanged();
            await ctx.WaitFrames(5);
            ctx.Assert(!StatsReportUtility.QuickSearchWidget.noResultsMatched, $"no row of the Stats tab matches '{text}'");
        }

        /// <summary>
        /// Selects a stat on the Stats tab of the open info card (by StatDef name) and scrolls the list to its row, so the row and its
        /// explanation show in a capture. Fails when the card is not open on the Stats tab or the stat is not drawn for this thing (a stat a
        /// pawn does not show, or one hidden by the search text). Written 2026-10-25 for GeniusesCraftFastRenew. Compiled, not played.
        /// </summary>
        [When("Nelim's Pickle Tools: the info card Stats tab is scrolled to the stat {string}")]
        public async Task ScrollToStat(PickleContext ctx, string statName)
        {
            RequireStatsTab(ctx);
            StatDef stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, $"no StatDef named '{statName}'");
            await ctx.WaitFrames(3);
            StatsReportUtility.SelectEntry(stat, false);
            ctx.Assert(StatsReportUtility.SelectedStatIndex >= 0, $"the stat '{statName}' is not drawn on the Stats tab of this thing");
            var field = typeof(StatsReportUtility).GetField("scrollPositioner", BindingFlags.NonPublic | BindingFlags.Static);
            ctx.Require(field != null, "StatsReportUtility.scrollPositioner is gone: this game version changed the Stats tab");
            ((ScrollPositioner)field.GetValue(null)).Arm();
            await ctx.WaitFrames(5);
        }

        static void RequireStatsTab(PickleContext ctx)
        {
            Dialog_InfoCard card = Find.WindowStack.WindowOfType<Dialog_InfoCard>();
            ctx.Require(card != null, "open the info card first: I open the info card of the selected thing on the \"Stats\" tab");
            var tab = typeof(Dialog_InfoCard).GetField("tab", BindingFlags.NonPublic | BindingFlags.Instance);
            ctx.Require(tab == null || Equals(tab.GetValue(card), Dialog_InfoCard.InfoCardTab.Stats), "the info card is not on the Stats tab");
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
