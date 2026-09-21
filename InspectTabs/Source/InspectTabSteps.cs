using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.InspectTabs
{
    /// <summary>
    /// Two steps that drive the inspect pane's own tabs (Gear, Bio, Health, Social, Needs, Log), which
    /// Pickle's <c>I open the {string} tab</c> cannot reach: that one switches the MAIN tabs.
    ///
    /// A copy of RimWorks/Rimworld-Pickle#31 (branch feat/inspect-tab-steps), kept in step with it until it
    /// lands: a change to one goes to the other, see ../README.md. Written in this repository's style, so the
    /// braces and the nullable annotations differ from the pull request; the logic must not.
    /// </summary>
    [PickleSteps]
    public class InspectTabSteps
    {
        private const string Nothing = "(none)";

        /// <summary>
        /// Opens an inspect tab on the selected thing, naming it by type or label key.
        /// </summary>
        // Named by type or label key, never by the translated label a player reads, so a scenario
        // written here still passes under a language mod. OpenTab switches the main tabs root to
        // Inspect on its own and toggles only a closed tab, so reopening an open tab is a no-op.
        [When("Nelim's Pickle Tools: I open the {string} inspect tab")]
        public async Task OpenInspectTab(PickleContext ctx, string tabName)
        {
            List<InspectTabBase> tabs = RequireInspectTabs(ctx);
            InspectTabBase tab = RequireInspectTab(tabs, tabName);

            ctx.Require(
                tab.IsVisible && !tab.Hidden,
                $"inspect tab '{tabName}' is on the selection but hidden, so no player could open it. " +
                $"available tabs: {DescribeInspectTabs(tabs)}");

            InspectPaneUtility.OpenTab(tab.GetType());
            await ctx.WaitFrames(2);

            ctx.Assert(
                InspectPane().OpenTabType == tab.GetType(),
                $"inspect tab '{tabName}' should be open; open tab: {DescribeOpenInspectTab()}");
        }

        /// <summary>
        /// Asserts the named inspect tab is the one currently open.
        /// </summary>
        // Waits the way 'window is open' does: a tab opened by a real click lands a frame or two
        // after the click, and asserting straight away would race it.
        [Then("Nelim's Pickle Tools: the {string} inspect tab is open")]
        public async Task AssertInspectTabOpen(PickleContext ctx, string tabName)
        {
            List<InspectTabBase> tabs = RequireInspectTabs(ctx);
            InspectTabBase tab = RequireInspectTab(tabs, tabName);

            await ctx.AssertEventually(
                () => InspectPane().OpenTabType == tab.GetType(),
                () => $"inspect tab '{tabName}' should be open; open tab: {DescribeOpenInspectTab()}");
        }

        private static MainTabWindow_Inspect InspectPane()
        {
            return (MainTabWindow_Inspect)MainButtonDefOf.Inspect.TabWindow;
        }

        // CurTabs is null for anything but a single selected thing, and null again while
        // screenshot mode is on, which hides the whole pane. Both read as "no tabs" here, so
        // the requirement names what is selected rather than leaving an author with a null.
        private static List<InspectTabBase> RequireInspectTabs(PickleContext ctx)
        {
            IEnumerable<InspectTabBase> tabs = InspectPane().CurTabs;
            ctx.Require(
                tabs != null,
                "no inspect tabs are available; the pane needs exactly one thing selected. " +
                $"selected: {DescribeSelection()}");

            List<InspectTabBase> list = tabs.ToList();
            ctx.Require(list.Count > 0, $"'{DescribeSelection()}' has no inspect tabs at all");

            return list;
        }

        // Three passes, widening only when the narrower one finds nothing: the exact type name,
        // then the exact label key, then the short form of either. A tie inside one pass is an
        // author's ambiguity, not a pick Pickle should make for them.
        private static InspectTabBase RequireInspectTab(List<InspectTabBase> tabs, string name)
        {
            foreach (Func<InspectTabBase, bool> match in InspectTabMatchers(name))
            {
                List<InspectTabBase> hits = tabs.Where(match).ToList();

                if (hits.Count == 1)
                {
                    return hits[0];
                }

                if (hits.Count > 1)
                {
                    throw new InvalidOperationException(
                        $"'{name}' matches {hits.Count} inspect tabs: {DescribeInspectTabs(hits)}. " +
                        "name one by its full type name");
                }
            }

            throw new InvalidOperationException(
                $"no inspect tab matches '{name}' on the current selection. " +
                $"available tabs: {DescribeInspectTabs(tabs)}");
        }

        private static IEnumerable<Func<InspectTabBase, bool>> InspectTabMatchers(string name)
        {
            yield return t => SameName(t.GetType().Name, name) || SameName(t.GetType().FullName, name);
            yield return t => SameName(t.labelKey, name);

            // "Gear" for ITab_Pawn_Gear or the TabGear label key. Both are identifiers, so this
            // stays a shorthand for a type or a key and never matches the label a player sees.
            yield return t => t.GetType().Name.EndsWith($"_{name}", StringComparison.OrdinalIgnoreCase)
                || SameName(t.labelKey, $"Tab{name}");
        }

        private static bool SameName(string actual, string expected)
        {
            return string.Equals(actual, expected, StringComparison.OrdinalIgnoreCase);
        }

        private static string DescribeInspectTabs(IEnumerable<InspectTabBase> tabs)
        {
            List<string> described = tabs
                .Select(DescribeInspectTab)
                .OrderBy(n => n, StringComparer.OrdinalIgnoreCase)
                .ToList();

            return described.Count == 0 ? Nothing : string.Join(", ", described);
        }

        private static string DescribeInspectTab(InspectTabBase tab)
        {
            string name = tab.GetType().Name;
            string label = tab.labelKey == null ? name : $"{name} ('{tab.labelKey}')";

            return tab.IsVisible && !tab.Hidden ? label : $"{label} [hidden]";
        }

        private static string DescribeOpenInspectTab()
        {
            Type open = InspectPane().OpenTabType;

            return open == null ? Nothing : open.Name;
        }

        private static string DescribeSelection()
        {
            List<string> labels = Find.Selector.SelectedObjectsListForReading
                .Select(o => o is Thing t ? t.LabelCap.ToString() : o.GetType().Name)
                .Where(l => !string.IsNullOrEmpty(l))
                .ToList();

            return labels.Count == 0 ? Nothing : string.Join(", ", labels);
        }
    }
}
