using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using HarmonyLib;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.Research
{
    /// <summary>
    /// The research window: a tab opened by def name, by the label a player reads, or by a translation
    /// key, and what the window then lists.
    ///
    /// No vanilla Pickle step can do this. The window draws its tabs as <c>TabRecord</c>s through
    /// <c>TabDrawer.DrawTabsOverflow</c>, which records no button tag, so <c>I click button "Storage"</c>
    /// fails with "no tags recorded this frame" (2026-09-21, English and French). These steps run the tab
    /// record's own click action instead, and read what the window would list rather than the picture.
    ///
    /// Waiting for RimWorks/Rimworld-Pickle#33, which carries the same idea by def name only: once it is
    /// merged, a suite should move to its texts and this assembly can go. The texts here carry "PickleTools"
    /// so the two never make a line ambiguous while both are loaded.
    /// </summary>
    [PickleSteps]
    public class ResearchTabSteps
    {
        // ---------------------------------------------------------------- opening a tab

        /// <summary>By def name first, then by the label the tab is drawn with, in the language the game runs in.</summary>
        [When("I open the PickleTools research tab {string}")]
        public Task OpenTab(PickleContext ctx, string nameOrLabel)
        {
            return Open(ctx, ResolveTab(ctx, nameOrLabel));
        }

        /// <summary>
        /// By translation key: the key is translated and the result is matched against the tabs' labels, so a
        /// scenario naming the key runs in any language. It only reaches a tab whose label comes from a Keyed
        /// string; a def's label injected by DefInjected has no key that <c>.Translate()</c> resolves.
        /// </summary>
        [When("I open the PickleTools research tab keyed {string}")]
        public Task OpenTabKeyed(PickleContext ctx, string key)
        {
            var label = TranslateKey(ctx, key);
            return Open(ctx, ResolveTabByLabel(ctx, label, string.Format("the key '{0}' reads '{1}'", key, label)));
        }

        private static async Task Open(PickleContext ctx, ResearchTabDef tab)
        {
            Find.MainTabsRoot.SetCurrentTab(MainButtonDefOf.Research, false);

            // PostOpen builds the tab records; the window is added to the stack by the call above.
            await ctx.WaitUntil(() => Records(Window()).Count > 0, 10f);
            var window = Window();
            ctx.Require(window != null, "the research window did not open");

            var record = RecordOf(window, tab);
            ctx.Require(record != null, string.Format("the research window built no tab record for '{0}'; it built: {1}",
                tab.defName, DescribeRecords(window)));

            // What a click on the tab runs: it sets the window's current tab and its selected project.
            record.clickedAction();
            await ctx.WaitFrames(3);

            ctx.Attach("research tabs the window drew",
                DescribeRecords(window) + "\nselected: " + (window.CurTab == null ? "none" : window.CurTab.defName));
        }

        // ---------------------------------------------------------------- what the window shows

        /// <summary>The window is on that tab, it drew a selected record for it, and its contents are revealed.</summary>
        [Then("the PickleTools research window is on the tab {string}")]
        public void OnTab(PickleContext ctx, string nameOrLabel)
        {
            var window = Window();
            ctx.Require(window != null, "the research window is not open");
            var tab = ResolveTab(ctx, nameOrLabel);

            var current = window.CurTab;
            ctx.Assert(current == tab, string.Format("the research window is on '{0}', not '{1}'",
                current == null ? "no tab" : current.defName, tab.defName));

            var record = RecordOf(window, tab);
            ctx.Assert(record != null && record.Selected, string.Format(
                "the window drew no selected tab record for '{0}'; it drew: {1}", tab.defName, DescribeRecords(window)));

            // A tab whose info is not visible draws "not discovered" in place of its projects.
            ctx.Assert(Find.ResearchManager.TabInfoVisible(tab), string.Format(
                "'{0}' is selected but its info is not visible: the window would not list its projects", tab.defName));
        }

        /// <summary>The label of the tab's record, which the window built from <c>LabelCap</c> when it opened.</summary>
        [Then("the PickleTools research window labels the tab {string} as {string}")]
        public void LabelsTab(PickleContext ctx, string nameOrLabel, string label)
        {
            var window = Window();
            ctx.Require(window != null, "the research window is not open");
            var tab = ResolveTab(ctx, nameOrLabel);

            var record = RecordOf(window, tab);
            ctx.Require(record != null, string.Format("the research window built no tab record for '{0}'; it built: {1}",
                tab.defName, DescribeRecords(window)));
            ctx.Assert(record.label == label, string.Format("the tab '{0}' is labelled '{1}', not '{2}'",
                tab.defName, record.label, label));
        }

        /// <summary>
        /// The project is one the window lists on its current tab: among the visible projects whose tab is the
        /// selected one, the very list <c>ListProjects</c> draws from, and not hidden. By def name or by label.
        /// </summary>
        [Then("the PickleTools research window lists the project {string}")]
        public void ListsProject(PickleContext ctx, string nameOrLabel)
        {
            AssertListed(ctx, nameOrLabel, null);
        }

        [Then("the PickleTools research window lists the project {string} costing {int}")]
        public void ListsProjectCosting(PickleContext ctx, string nameOrLabel, int cost)
        {
            AssertListed(ctx, nameOrLabel, cost);
        }

        private static void AssertListed(PickleContext ctx, string nameOrLabel, int? cost)
        {
            var window = Window();
            ctx.Require(window != null, "the research window is not open");
            ctx.Require(window.CurTab != null, "the research window has no current tab");
            var project = ResolveProject(ctx, nameOrLabel);

            var listed = window.VisibleResearchProjects.Where(p => p.tab == window.CurTab).ToList();
            ctx.Attach("projects listed on " + window.CurTab.defName, Describe(listed));

            ctx.Assert(listed.Contains(project), string.Format(
                "the window does not list '{0}' on '{1}'; it lists: {2}", project.defName, window.CurTab.defName,
                string.Join(", ", listed.Select(p => p.defName).ToArray())));
            ctx.Assert(!project.IsHidden, string.Format("'{0}' is listed but hidden", project.defName));
            if (cost.HasValue)
            {
                ctx.Assert(Math.Abs(project.Cost - cost.Value) < 0.01f,
                    string.Format("'{0}' costs {1}, not {2}", project.defName, project.Cost, cost.Value));
            }
        }

        // ---------------------------------------------------------------- resolving a name

        /// <summary>A def name wins over a label, so a tab can always be reached by its def name.</summary>
        private static ResearchTabDef ResolveTab(PickleContext ctx, string nameOrLabel)
        {
            var byDef = DefDatabase<ResearchTabDef>.AllDefsListForReading
                .FirstOrDefault(t => string.Equals(t.defName, nameOrLabel, StringComparison.OrdinalIgnoreCase));
            return byDef ?? ResolveTabByLabel(ctx, nameOrLabel, string.Format("'{0}' is not a def name", nameOrLabel));
        }

        private static ResearchTabDef ResolveTabByLabel(PickleContext ctx, string label, string why)
        {
            var all = DefDatabase<ResearchTabDef>.AllDefsListForReading;
            var matches = all.Where(t => string.Equals(t.LabelCap.ToString(), label, StringComparison.OrdinalIgnoreCase)).ToList();

            ctx.Require(matches.Count > 0, string.Format("no research tab is named or labelled '{0}' ({1}). tabs: {2}",
                label, why, DescribeTabs(all)));
            ctx.Require(matches.Count == 1, string.Format("the label '{0}' names several research tabs: {1}. name one by its def name",
                label, DescribeTabs(matches)));
            return matches[0];
        }

        private static ResearchProjectDef ResolveProject(PickleContext ctx, string nameOrLabel)
        {
            var all = DefDatabase<ResearchProjectDef>.AllDefsListForReading;
            var byDef = all.FirstOrDefault(p => string.Equals(p.defName, nameOrLabel, StringComparison.OrdinalIgnoreCase));
            if (byDef != null)
            {
                return byDef;
            }

            var matches = all.Where(p => string.Equals(p.LabelCap.ToString(), nameOrLabel, StringComparison.OrdinalIgnoreCase)).ToList();
            ctx.Require(matches.Count > 0, string.Format("no research project is named or labelled '{0}'; closest by def name: {1}",
                nameOrLabel, string.Join(", ", all.OrderBy(p => Distance(p.defName, nameOrLabel)).Take(3).Select(p => p.defName).ToArray())));
            ctx.Require(matches.Count == 1, string.Format("the label '{0}' names several research projects: {1}. name one by its def name",
                nameOrLabel, string.Join(", ", matches.Select(p => p.defName).ToArray())));
            return matches[0];
        }

        private static string TranslateKey(PickleContext ctx, string key)
        {
            ctx.Require(key.CanTranslate(), string.Format("no translation is loaded for the key '{0}' in the active language", key));
            return key.Translate().ToString();
        }

        private static string DescribeTabs(IEnumerable<ResearchTabDef> tabs)
        {
            return string.Join(", ", tabs.Select(t => string.Format("{0} ('{1}')", t.defName, t.LabelCap)).ToArray());
        }

        private static string Describe(List<ResearchProjectDef> projects)
        {
            return string.Join("\n", projects.Select(p => string.Format("{0}: '{1}', cost {2}, at ({3}, {4}), {5}",
                p.defName, p.LabelCap, p.Cost, p.ResearchViewX, p.ResearchViewY, p.techLevel)).ToArray());
        }

        /// <summary>Levenshtein distance, only to order the suggestions of a miss.</summary>
        private static int Distance(string a, string b)
        {
            var d = new int[a.Length + 1, b.Length + 1];
            for (var i = 0; i <= a.Length; i++) d[i, 0] = i;
            for (var j = 0; j <= b.Length; j++) d[0, j] = j;
            for (var i = 1; i <= a.Length; i++)
            {
                for (var j = 1; j <= b.Length; j++)
                {
                    var cost = char.ToLowerInvariant(a[i - 1]) == char.ToLowerInvariant(b[j - 1]) ? 0 : 1;
                    d[i, j] = Math.Min(Math.Min(d[i - 1, j] + 1, d[i, j - 1] + 1), d[i - 1, j - 1] + cost);
                }
            }

            return d[a.Length, b.Length];
        }

        // ---------------------------------------------------------------- what the window holds

        private static MainTabWindow_Research Window()
        {
            return Find.WindowStack == null ? null : Find.WindowStack.WindowOfType<MainTabWindow_Research>();
        }

        /// <summary>The window's private list of tab records, <c>tabs</c>, filled by PostOpen.</summary>
        private static List<TabRecord> Records(MainTabWindow_Research window)
        {
            var result = new List<TabRecord>();
            if (window == null)
            {
                return result;
            }

            var field = AccessTools.Field(typeof(MainTabWindow_Research), "tabs");
            if (field == null)
            {
                throw new InvalidOperationException("MainTabWindow_Research.tabs no longer exists: update the step");
            }

            var list = field.GetValue(window) as IEnumerable;
            if (list != null)
            {
                foreach (var item in list)
                {
                    result.Add((TabRecord)item);
                }
            }

            return result;
        }

        /// <summary>The record is a private nested class whose <c>def</c> is a public field, hence AccessTools.</summary>
        private static ResearchTabDef DefOf(TabRecord record)
        {
            var field = AccessTools.Field(record.GetType(), "def");
            if (field == null)
            {
                throw new InvalidOperationException(record.GetType().Name + ".def no longer exists: update the step");
            }

            return (ResearchTabDef)field.GetValue(record);
        }

        private static TabRecord RecordOf(MainTabWindow_Research window, ResearchTabDef tab)
        {
            return Records(window).FirstOrDefault(r => DefOf(r) == tab);
        }

        private static string DescribeRecords(MainTabWindow_Research window)
        {
            return string.Join(", ", Records(window).Select(r =>
                string.Format("{0} (label '{1}'{2})", DefOf(r).defName, r.label, r.Selected ? ", selected" : "")).ToArray());
        }
    }
}
