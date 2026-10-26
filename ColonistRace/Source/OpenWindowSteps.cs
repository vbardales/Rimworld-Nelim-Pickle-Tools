using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using RimWorld;
using RimWorks.Pickle;
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
