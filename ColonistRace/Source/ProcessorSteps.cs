using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps for the buildings of [SYR] Processor Framework (<c>ProcessorFramework.CompProcessor</c>, Workshop 3210544395): put an ingredient in
    /// one the way a hauler does, move its process forward, empty it and read the product. The framework is reached by reflection (its API read from
    /// the 1.6 assembly on 2026-10-28), so this assembly needs no reference to it and the steps fail with a clear message when it is not loaded.
    /// Written 2026-10-28 for ProcessorFrameworkVCERenew (VCE_CheesePress, VCE_ElectricPot, VCE_StewPot, VCE_SoyFermenter). NOT PLAYED when written: compiled only.
    /// The progress is moved by writing the process's tick counter, so power, fuel, temperature and the speed factor are NOT tested by these steps.
    /// </summary>
    [PickleSteps]
    public class ProcessorSteps
    {
        private const BindingFlags Any = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

        // What each emptied building gave, so the Then steps can read it after the process is gone.
        private static readonly Dictionary<Thing, List<Thing>> Products = new Dictionary<Thing, List<Thing>>();

        private static Type FrameworkType(PickleContext ctx, string name)
        {
            Type t = GenTypes.AllTypes.FirstOrDefault(x => x.FullName == "ProcessorFramework." + name);
            ctx.Require(t != null, "Processor Framework is not loaded (no type ProcessorFramework." + name + "): load the mod before this step");
            return t;
        }

        private static ThingWithComps Building(PickleContext ctx, string defName, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            ThingWithComps found = map.thingGrid.ThingsListAt(cell).OfType<ThingWithComps>().FirstOrDefault(t => t.def.defName == defName);
            ctx.Require(found != null, $"no '{defName}' at ({x}, {z}); there is {string.Join(", ", map.thingGrid.ThingsListAt(cell).Select(t => t.def.defName))}");
            return found;
        }

        private static ThingComp Processor(PickleContext ctx, ThingWithComps building)
        {
            Type comp = FrameworkType(ctx, "CompProcessor");
            ThingComp c = building.AllComps.FirstOrDefault(x => comp.IsInstanceOfType(x));
            ctx.Require(c != null, $"'{building.def.defName}' has no processor comp (ProcessorFramework.CompProcessor)");
            return c;
        }

        private static IList ActiveProcesses(ThingComp comp) => (IList)comp.GetType().GetField("activeProcesses", Any).GetValue(comp);

        private static float DaysToComplete(object process)
        {
            Type t = process.GetType();
            object def = t.GetField("processDef", Any).GetValue(process);
            bool quality = (bool)def.GetType().GetField("usesQuality", Any).GetValue(def);
            return quality
                ? (float)t.GetProperty("DaysToReachTargetQuality", Any).GetValue(process)
                : (float)def.GetType().GetField("processDays", Any).GetValue(def);
        }

        /// <summary>
        /// Puts a stack of an ingredient (a <c>ThingDef</c> name such as Milk or VCE_RawSoybean) into the processor of the building of that def at a cell, the way a
        /// hauler does: through the framework's own add-ingredient path (CompProcessor.AddIngredient), on the first process of the building whose filter allows the
        /// ingredient. What does not fit is dropped beside the building, as the framework does. Fails when there is no such building or no process takes the ingredient.
        /// </summary>
        /// <param name="buildingDef">the ThingDef name of the processing building (VCE_CheesePress, VCE_ElectricPot...)</param>
        /// <param name="count">how many of the ingredient</param>
        /// <param name="ingredientDef">the ThingDef name of the ingredient</param>
        [Given("Nelim's Pickle Tools: the {string} at \\({int}, {int}\\) is filled with {int} of {string}")]
        public void Fill(PickleContext ctx, string buildingDef, int x, int z, int count, string ingredientDef)
        {
            ThingWithComps building = Building(ctx, buildingDef, x, z);
            ThingComp comp = Processor(ctx, building);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(ingredientDef);
            ctx.Require(def != null, $"no ThingDef named '{ingredientDef}'");
            ctx.Require(count > 0, "the count must be above 0");
            object props = comp.GetType().GetProperty("Props", Any).GetValue(comp);
            var processes = ((IEnumerable)props.GetType().GetField("processes", Any).GetValue(props)).Cast<Def>().ToList();
            Def process = processes.FirstOrDefault(p => ((ThingFilter)p.GetType().GetField("ingredientFilter", Any).GetValue(p)).Allows(def));
            ctx.Require(process != null, $"no process of '{buildingDef}' takes '{ingredientDef}'; its processes make {string.Join(", ", processes.Select(p => ((ThingDef)p.GetType().GetField("thingDef", Any).GetValue(p))?.defName))}");
            Thing stack = ThingMaker.MakeThing(def);
            stack.stackCount = count;
            comp.GetType().GetMethod("AddIngredient", Any).Invoke(comp, new object[] { stack, process });
            IList active = ActiveProcesses(comp);
            int held = 0;
            foreach (object ap in active)
                if (ap.GetType().GetField("processDef", Any).GetValue(ap) == process) held += (int)ap.GetType().GetField("ingredientCount", Any).GetValue(ap);
            ctx.Assert(held > 0, $"the '{buildingDef}' should hold the ingredient '{ingredientDef}' after the fill; it holds nothing for that process (capacity?)");
            Log.Message($"[processor] {buildingDef} at ({x}, {z}) filled with {count} of {ingredientDef}: process {process.defName} holds {held} (after efficiency of the ingredient)");
        }

        /// <summary>
        /// Moves every process of the processor forward by a number of days (60 000 ticks each) by adding to its tick counter, so a 10-day process
        /// needs no 600 000 ticks of waiting. Power, fuel, temperature and the speed factor are NOT used: this tests what the process makes, not what drives it.
        /// </summary>
        /// <param name="days">days to add, for example 0.5 or 10</param>
        [Given("Nelim's Pickle Tools: the {string} at \\({int}, {int}\\) is advanced by {float} days")]
        public void Advance(PickleContext ctx, string buildingDef, int x, int z, float days)
        {
            ThingComp comp = Processor(ctx, Building(ctx, buildingDef, x, z));
            IList active = ActiveProcesses(comp);
            ctx.Require(active.Count > 0, $"the '{buildingDef}' at ({x}, {z}) holds no process: fill it first");
            foreach (object ap in active)
            {
                FieldInfo ticks = ap.GetType().GetField("activeProcessTicks", Any);
                ticks.SetValue(ap, (long)ticks.GetValue(ap) + (long)Math.Round(days * 60000f));
            }
        }

        /// <summary>
        /// Moves every process of the processor to the end of its run: the days of the process, or for a process with quality the days that reach its target quality. The
        /// framework's own <c>Complete</c> is read back and must be true. Power, fuel, temperature and the speed factor are NOT used.
        /// </summary>
        [Given("Nelim's Pickle Tools: the {string} at \\({int}, {int}\\) is advanced until its process is complete")]
        public void Complete(PickleContext ctx, string buildingDef, int x, int z)
        {
            ThingComp comp = Processor(ctx, Building(ctx, buildingDef, x, z));
            IList active = ActiveProcesses(comp);
            ctx.Require(active.Count > 0, $"the '{buildingDef}' at ({x}, {z}) holds no process: fill it first");
            foreach (object ap in active)
            {
                FieldInfo ticks = ap.GetType().GetField("activeProcessTicks", Any);
                ticks.SetValue(ap, (long)Math.Ceiling(DaysToComplete(ap) * 60000f) + 1L);
                bool done = (bool)ap.GetType().GetProperty("Complete", Any).GetValue(ap);
                ctx.Assert(done, $"the process of the '{buildingDef}' should be complete after being advanced to {DaysToComplete(ap)} days; the framework still says it is not");
            }
        }

        /// <summary>
        /// Empties the processor as the emptying job does (CompProcessor.TakeOutProduct for each process), puts each product on the ground beside the building and
        /// remembers it for the product steps. A process that is not complete is emptied too (its product is what it makes so far: use the advance steps first). Fails when the processor holds nothing.
        /// </summary>
        [When("Nelim's Pickle Tools: the {string} at \\({int}, {int}\\) is emptied")]
        public void Empty(PickleContext ctx, string buildingDef, int x, int z)
        {
            ThingWithComps building = Building(ctx, buildingDef, x, z);
            ThingComp comp = Processor(ctx, building);
            IList active = ActiveProcesses(comp);
            ctx.Require(active.Count > 0, $"the '{buildingDef}' at ({x}, {z}) holds nothing to empty");
            Map map = building.Map;
            IntVec3 pos = building.Position;
            var made = new List<Thing>();
            foreach (object ap in active.Cast<object>().ToList())
            {
                Thing product = (Thing)comp.GetType().GetMethod("TakeOutProduct", Any).Invoke(comp, new[] { ap });
                if (product == null) continue;
                made.Add(product);
                GenPlace.TryPlaceThing(product, pos, map, ThingPlaceMode.Near);
            }

            Products[building] = made;
            Log.Message($"[processor] {buildingDef} at ({x}, {z}) emptied: {(made.Count == 0 ? "(nothing, ruined)" : string.Join(", ", made.Select(t => t.stackCount + " " + t.def.defName + QualityOf(t) + " \"" + t.Label + "\"")))}");
        }

        private static string QualityOf(Thing t) => t.TryGetComp<CompQuality>() is CompQuality q ? " " + q.Quality : "";

        private static List<Thing> Made(PickleContext ctx, string buildingDef, int x, int z)
        {
            ThingWithComps building = Building(ctx, buildingDef, x, z);
            ctx.Require(Products.TryGetValue(building, out var list), $"the '{buildingDef}' at ({x}, {z}) was not emptied by a step: use 'is emptied' first");
            return list;
        }

        /// <summary>Asserts what the emptied processor gave: this many in total of this ThingDef (all its products of that def, summed).</summary>
        [Then("Nelim's Pickle Tools: the product of the {string} at \\({int}, {int}\\) is {int} of {string}")]
        public void ProductIs(PickleContext ctx, string buildingDef, int x, int z, int count, string productDef)
        {
            List<Thing> made = Made(ctx, buildingDef, x, z);
            int total = made.Where(t => t.def.defName == productDef).Sum(t => t.stackCount);
            ctx.Assert(total == count, $"the '{buildingDef}' should have given {count} of {productDef}; it gave {(made.Count == 0 ? "nothing" : string.Join(", ", made.Select(t => t.stackCount + " " + t.def.defName)))}");
        }

        /// <summary>Asserts the quality (Awful, Poor, Normal, Good, Excellent, Masterwork, Legendary; any case) of the emptied processor's product of that ThingDef.</summary>
        [Then("Nelim's Pickle Tools: the {string} product of the {string} at \\({int}, {int}\\) has quality {string}")]
        public void ProductQuality(PickleContext ctx, string productDef, string buildingDef, int x, int z, string quality)
        {
            Thing product = Made(ctx, buildingDef, x, z).FirstOrDefault(t => t.def.defName == productDef);
            ctx.Require(product != null, $"the '{buildingDef}' gave no {productDef}");
            CompQuality q = product.TryGetComp<CompQuality>();
            ctx.Require(q != null, $"{productDef} has no quality");
            ctx.Assert(string.Equals(q.Quality.ToString(), quality, StringComparison.OrdinalIgnoreCase), $"the {productDef} of the '{buildingDef}' should be {quality}; it is {q.Quality}");
        }

        /// <summary>Asserts the label (as the game shows it, quality and ingredients included) of the emptied processor's product of that ThingDef contains the text, ignoring case.</summary>
        [Then("Nelim's Pickle Tools: the {string} product of the {string} at \\({int}, {int}\\) is labelled {string}")]
        public void ProductLabel(PickleContext ctx, string productDef, string buildingDef, int x, int z, string text)
        {
            Thing product = Made(ctx, buildingDef, x, z).FirstOrDefault(t => t.def.defName == productDef);
            ctx.Require(product != null, $"the '{buildingDef}' gave no {productDef}");
            ctx.Assert(product.LabelCap.IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0, $"the {productDef} of the '{buildingDef}' should be labelled with \"{text}\"; it is \"{product.LabelCap}\"");
        }

        [AfterScenario]
        public void ForgetProducts()
        {
            Products.Clear();
        }
    }
}
