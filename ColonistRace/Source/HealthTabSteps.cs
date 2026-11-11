using System;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// The Operations list of the Health tab of the inspect pane. The tab itself opens with the InspectTabs step <c>I open the "Health" inspect tab</c>; the game keeps the choice between its
    /// Overview and Operations lists in a private static flag of <c>HealthCardUtility</c>, which no step reached. Written 2026-11-11 for PomeranianADogSaid2Renew (the surgery bills of a dog
    /// on a vet bed). NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class HealthTabSteps
    {
        /// <summary>
        /// Opens the Health tab of the selected pawn (a colonist or an animal) and switches it to its Operations list, the list of the bills of surgery with the recipes offered. The game
        /// keeps that choice in a static boolean of HealthCardUtility, found by the word "peration" in its name; the step fails with the booleans the class holds when none is found, and
        /// when the pawn is not a single selected pawn. The flag stays set until another list is chosen, so later captures of the tab show Operations too. NOT PLAYED when written.
        /// </summary>
        [When("Nelim's Pickle Tools: I open the Operations list of the Health tab")]
        public async Task OpenOperations(PickleContext ctx)
        {
            var selected = Find.Selector.SingleSelectedThing as Pawn;
            ctx.Require(selected != null, "select exactly one pawn (a colonist or an animal) first; selected: " + string.Join(", ", Find.Selector.SelectedObjectsListForReading.Select(o => o.GetType().Name)));
            InspectPaneUtility.OpenTab(typeof(ITab_Pawn_Health));
            await ctx.WaitFrames(2);
            FieldInfo[] flags = typeof(HealthCardUtility).GetFields(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic).Where(f => f.FieldType == typeof(bool)).ToArray();
            FieldInfo flag = flags.FirstOrDefault(f => f.Name.IndexOf("peration", StringComparison.OrdinalIgnoreCase) >= 0);
            ctx.Require(flag != null, "HealthCardUtility holds no static boolean for the Operations list; it holds: " + string.Join(", ", flags.Select(f => f.Name)));
            flag.SetValue(null, true);
            await ctx.WaitFrames(2);
            ctx.Assert((bool)flag.GetValue(null), $"the flag {flag.Name} of HealthCardUtility did not stay set");
        }
    }
}
