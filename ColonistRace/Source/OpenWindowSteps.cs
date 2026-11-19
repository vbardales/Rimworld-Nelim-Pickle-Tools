using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using RimWorld;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that open a window a capture needs: an Architect category tab by name, and the configuration dialog of a bill. Written 2026-10-26 for
    /// ManureComposting's gallery (the "Hygiene" tab holding two composters; the Fertile Fields "make raw compost" bill dialog). NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class OpenWindowSteps
    {
        /// <summary>
        /// Opens the Architect menu on the category tab whose DesignationCategoryDef defName or label (any language, case ignored) is the text, so the
        /// buildings of that tab are drawn in the panel above the menu. Fails listing the tabs when none matches.
        /// </summary>
        [When("Nelim's Pickle Tools: I open the architect tab {string}")]
        public void OpenArchitectTab(PickleContext ctx, string nameOrLabel)
        {
            Find.MainTabsRoot.SetCurrentTab(MainButtonDefOf.Architect, false);
            var window = MainButtonDefOf.Architect.TabWindow as MainTabWindow_Architect;
            ctx.Require(window != null, "the Architect window did not open (is the colonist's map loaded?)");
            var panels = typeof(MainTabWindow_Architect).GetField("desPanelsCached", BindingFlags.NonPublic | BindingFlags.Instance)?.GetValue(window) as IEnumerable;
            ctx.Require(panels != null, "the Architect window has no desPanelsCached any more (the game changed): update this step");
            var all = panels.Cast<ArchitectCategoryTab>().ToList();
            ArchitectCategoryTab tab = all.FirstOrDefault(t => string.Equals(t.def.defName, nameOrLabel, StringComparison.OrdinalIgnoreCase))
                ?? all.FirstOrDefault(t => string.Equals(t.def.LabelCap.ToString(), nameOrLabel, StringComparison.OrdinalIgnoreCase));
            ctx.Require(tab != null, $"no Architect tab '{nameOrLabel}'; the tabs are " + string.Join(", ", all.Select(t => t.def.defName + " (" + t.def.LabelCap + ")")));
            MethodInfo click = typeof(MainTabWindow_Architect).GetMethod("ClickedCategory", BindingFlags.NonPublic | BindingFlags.Instance);
            if (click != null) click.Invoke(window, new object[] { tab }); else window.selectedDesPanel = tab;
            ctx.Assert(window.selectedDesPanel == tab, $"the Architect menu shows '{window.selectedDesPanel?.def.defName ?? "no tab"}', not '{tab.def.defName}'");
        }

        /// <summary>
        /// Opens the drop-down menu of a DesignatorDropdownGroupDef (the Architect button with a "+" that groups several buildings, e.g.
        /// "Nelim_Composters") on the Architect tab already open, so the options of the group are listed in a menu. Fails when no tab is open or the
        /// group is not on it, listing the groups of the open tab. NOT PLAYED when written.
        /// </summary>
        [When("Nelim's Pickle Tools: I open the architect dropdown {string}")]
        public void OpenArchitectDropdown(PickleContext ctx, string groupDefName)
        {
            var window = MainButtonDefOf.Architect.TabWindow as MainTabWindow_Architect;
            ctx.Require(window != null && window.selectedDesPanel != null, "no Architect tab is open: open one with 'I open the architect tab' first");
            var tab = window.selectedDesPanel;
            var dropdowns = tab.def.ResolvedAllowedDesignators.OfType<Designator_Dropdown>().ToList();
            Func<Designator_Dropdown, string> groupOf = d => d.Elements.OfType<Designator_Place>()
                .Select(p => p.PlacingDef?.designatorDropdown?.defName).FirstOrDefault(n => n != null);
            Designator_Dropdown dropdown = dropdowns.FirstOrDefault(d => string.Equals(groupOf(d), groupDefName, StringComparison.OrdinalIgnoreCase));
            ctx.Require(dropdown != null, $"no dropdown '{groupDefName}' on the tab '{tab.def.defName}'; its groups are " + string.Join(", ", dropdowns.Select(groupOf)));
            dropdown.ProcessInput(new Event { type = EventType.MouseDown, button = 0 });
            ctx.Assert(Find.WindowStack.Windows.Any(w => w is FloatMenu || w is FloatMenuGrid), "the dropdown menu did not open");
        }

        /// <summary>
        /// Asserts an Architect category tab (DesignationCategoryDef defName or label, case ignored) lists a building def among its designators, the
        /// ones inside a drop-down group included. A def-level read of <c>ResolvedAllowedDesignators</c>: no window opens. Compiled, NOT PLAYED.
        /// </summary>
        [Then("Nelim's Pickle Tools: the architect tab {string} lists the def {string}")]
        public void ArchitectTabLists(PickleContext ctx, string tabName, string defName)
        {
            var listed = ArchitectDefs(ctx, tabName, out DesignationCategoryDef tab);
            ctx.Assert(listed.Contains(defName, StringComparer.OrdinalIgnoreCase), $"the Architect tab '{tab.defName}' does not list '{defName}'; it lists " + string.Join(", ", listed.Take(60)));
        }

        /// <summary>The negative twin of <c>the architect tab ... lists the def ...</c>: other entries of the tab are not read. Compiled, NOT PLAYED.</summary>
        [Then("Nelim's Pickle Tools: the architect tab {string} does not list the def {string}")]
        public void ArchitectTabDoesNotList(PickleContext ctx, string tabName, string defName)
        {
            var listed = ArchitectDefs(ctx, tabName, out DesignationCategoryDef tab);
            ctx.Assert(!listed.Contains(defName, StringComparer.OrdinalIgnoreCase), $"the Architect tab '{tab.defName}' lists '{defName}'");
        }

        // The only defs a tab may offer while a scenario runs; null = no limit. Read by the postfix on ResolvedAllowedDesignators, which the
        // Architect menu reads every frame it draws a tab, so no cache has to be rebuilt.
        private static System.Collections.Generic.HashSet<string> onlyDefs;
        private static DesignationCategoryDef limitedTab;
        private static HarmonyLib.Harmony designatorHarmony;

        private static bool Kept(Designator d)
        {
            if (d is Designator_Dropdown dropdown)
                return dropdown.Elements.Any(Kept);
            if (d is Designator_Place place)
                return place.PlacingDef != null && onlyDefs.Contains(place.PlacingDef.defName);
            return true;
        }

        private static System.Collections.Generic.IEnumerable<Designator> FilterDesignators(System.Collections.Generic.IEnumerable<Designator> __result, DesignationCategoryDef __instance)
        {
            if (onlyDefs == null || __instance != limitedTab)
                return __result;
            return __result.Where(Kept).ToList();
        }

        /// <summary>
        /// Limits what one Architect tab offers to a list of building defs (comma separated defNames), for the length of the scenario, so a capture of a
        /// tab with thirty entries (the Unsorted tab with the Ideology and Odyssey items) shows a few rows. A drop-down group stays when one of its
        /// members is listed; designators that are no building (cancel, copy) stay. Postfix on <c>DesignationCategoryDef.ResolvedAllowedDesignators</c>.
        /// Written 2026-11-20 for ArchitectStudio scene 3. COMPILED, NOT PLAYED.
        /// </summary>
        [Given("Nelim's Pickle Tools: the architect tab {string} shows only the defs {string}")]
        public void ArchitectTabShowsOnly(PickleContext ctx, string tabName, string defNames)
        {
            var categories = DefDatabase<DesignationCategoryDef>.AllDefsListForReading;
            DesignationCategoryDef tab = categories.FirstOrDefault(c => string.Equals(c.defName, tabName, StringComparison.OrdinalIgnoreCase))
                ?? categories.FirstOrDefault(c => c.label != null && string.Equals(c.LabelCap.ToString(), tabName, StringComparison.OrdinalIgnoreCase));
            ctx.Require(tab != null, $"no Architect tab '{tabName}'; the tabs are " + string.Join(", ", categories.Select(c => c.defName)));
            var names = new System.Collections.Generic.HashSet<string>(
                defNames.Split(',').Select(n => n.Trim()).Where(n => n.Length > 0), StringComparer.OrdinalIgnoreCase);
            ctx.Require(names.Count > 0, "the list of defs is empty");
            if (designatorHarmony == null)
            {
                MethodInfo getter = typeof(DesignationCategoryDef).GetProperty("ResolvedAllowedDesignators")?.GetGetMethod();
                ctx.Require(getter != null, "DesignationCategoryDef.ResolvedAllowedDesignators is not there any more (the game changed): update this step");
                var h = new HarmonyLib.Harmony("nelim.pickletools.architectonly");
                h.Patch(getter, postfix: new HarmonyLib.HarmonyMethod(typeof(OpenWindowSteps), nameof(FilterDesignators)));
                designatorHarmony = h;
            }

            limitedTab = tab;
            onlyDefs = names;
            int shown = tab.ResolvedAllowedDesignators.Count();
            Log.Message($"[architect] tab {tab.defName} limited to {string.Join(", ", names)}: {shown} designator(s) left");
            ctx.Assert(shown > 0, $"no designator of '{tab.defName}' is left: none of {string.Join(", ", names)} is on it");
        }

        [AfterScenario]
        public void ArchitectTabUnlimited()
        {
            onlyDefs = null;
            limitedTab = null;
        }

        private static System.Collections.Generic.List<string> ArchitectDefs(PickleContext ctx, string tabName, out DesignationCategoryDef tab)
        {
            var categories = DefDatabase<DesignationCategoryDef>.AllDefsListForReading;
            tab = categories.FirstOrDefault(c => string.Equals(c.defName, tabName, StringComparison.OrdinalIgnoreCase))
                ?? categories.FirstOrDefault(c => c.label != null && string.Equals(c.LabelCap.ToString(), tabName, StringComparison.OrdinalIgnoreCase));
            ctx.Require(tab != null, $"no Architect tab '{tabName}'; the tabs are " + string.Join(", ", categories.Select(c => c.defName)));
            // Read from the defs, not from tab.ResolvedAllowedDesignators: building that list instantiates designators that read the game
            // (Find.CurrentMap, selector) and throws a NullReferenceException at the main menu, where no game is loaded (ticket 54a6 of RepossessedFurniture, 2026-11-12).
            // A buildable is on a tab when its designationCategory is that tab; members of a drop-down group are on the same tab.
            var names = new System.Collections.Generic.List<string>();
            try
            {
                foreach (ThingDef def in DefDatabase<ThingDef>.AllDefsListForReading)
                    if (def != null && def.designationCategory == tab) names.Add(def.defName);
                foreach (TerrainDef def in DefDatabase<TerrainDef>.AllDefsListForReading)
                    if (def != null && def.designationCategory == tab) names.Add(def.defName);
            }
            catch (Exception e)
            {
                ctx.Require(false, "reading the defs of the Architect tab '" + tab.defName + "' threw: " + e);
            }
            return names;
        }

        /// <summary>
        /// Opens the bill configuration dialog (the window with the ingredient list) of the bill for a recipe (RecipeDef defName) held by a work table
        /// (by defName, at a cell). Fails when no such table or bill is there, listing what the table holds.
        /// </summary>
        [When("Nelim's Pickle Tools: I open the configuration of the bill {string} on the building {string} at \\({int}, {int}\\)")]
        public void OpenBillConfig(PickleContext ctx, string recipeDefName, string buildingDefName, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            Thing t = cell.GetThingList(map).FirstOrDefault(b => b.def.defName == buildingDefName);
            ctx.Require(t != null, $"no {buildingDefName} stands at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(b => b.def.defName)));
            var giver = t as IBillGiver;
            ctx.Require(giver != null, $"{buildingDefName} holds no bills");
            Bill_Production bill = giver.BillStack.Bills.OfType<Bill_Production>().FirstOrDefault(b => b.recipe.defName == recipeDefName);
            ctx.Require(bill != null, $"{buildingDefName} has no bill for '{recipeDefName}'; it has " + string.Join(", ", giver.BillStack.Bills.Select(b => b.recipe.defName)));
            Find.WindowStack.Add(new Dialog_BillConfig(bill, t.Position));
            ctx.Assert(Find.WindowStack.Windows.OfType<Dialog_BillConfig>().Any(), "the bill dialog did not open");
        }
    }
}
