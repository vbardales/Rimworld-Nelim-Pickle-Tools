using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Whole-body hediffs on an animal, found by short name among the spawned animals like <see cref="AnimalGeneSteps"/>. Written 2026-10-31 at
    /// the request of SanctuaryBacklot: Animal Traits System (luved.animaltraits) stores an animal's traits as AnimalTrait_* hediffs, and the
    /// colonist hediff steps cannot name an animal. NOT PLAYED: compiled against the reference assemblies only. A mod that rolls its own
    /// traits at spawn may add more than the ones set here; the read-back lists what the animal holds.
    /// </summary>
    [PickleSteps]
    public class AnimalHediffSteps
    {
        /// <summary>
        /// Adds a hediff to the animal on no body part, unless it already holds one of that def, and reads it back. Fails when the animal is not
        /// found (it lists the animals), when the def is unknown, or when the hediff is missing afterwards (it lists those held). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the animal {string} has the hediff {string}")]
        public void GiveHediff(PickleContext ctx, string name, string hediffName)
        {
            Pawn animal = AnimalGeneSteps.FindAnimal(ctx, name);
            HediffDef def = DefDatabase<HediffDef>.GetNamedSilentFail(hediffName);
            ctx.Require(def != null, $"no hediff '{hediffName}' (is the mod that defines it loaded in this pass?)");
            if (!animal.health.hediffSet.hediffs.Any(h => h.def == def)) animal.health.AddHediff(def);
            ctx.Assert(animal.health.hediffSet.hediffs.Any(h => h.def == def),
                $"the animal '{name}' does not hold the hediff '{hediffName}'; it holds {HoldList(animal)}");
        }

        /// <summary>
        /// Fills the milk bar of an animal that gives milk (the CompMilkable of the game: a cow, a goat, a modded milker) to the top, so the job Milk has something to take. Fails when the
        /// animal gives no milk, is male or not yet adult (the comp then does not fill), or when the bar does not read full afterwards. Written 2026-11-06 for BeefEatersRenew (a forced
        /// Milk job ended at once, the bar was empty). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the animal {string} is full of milk")]
        public void FullOfMilk(PickleContext ctx, string name)
        {
            Pawn animal = AnimalGeneSteps.FindAnimal(ctx, name);
            CompMilkable comp = animal.TryGetComp<CompMilkable>();
            ctx.Require(comp != null, $"the animal '{name}' ({animal.def.defName}) gives no milk: it has no milk comp");
            ctx.Require(HarmonyLib.Traverse.Create(comp).Property("Active").GetValue<bool>(), $"the animal '{name}' does not fill its milk bar right now (a male, a child, or a milk giver the game keeps empty); the comp is not active");
            HarmonyLib.Traverse.Create(comp).Field("fullness").SetValue(1f);
            ctx.Assert(comp.Fullness >= 0.99f, $"the milk bar of '{name}' reads {comp.Fullness:0.00} after the step, not full");
        }

        /// <summary>Removes every hediff of that def from the animal; does nothing when it holds none. NOT PLAYED when written.</summary>
        [Given("Nelim's Pickle Tools: the animal {string} loses the hediff {string}")]
        public void LoseHediff(PickleContext ctx, string name, string hediffName)
        {
            Pawn animal = AnimalGeneSteps.FindAnimal(ctx, name);
            HediffDef def = DefDatabase<HediffDef>.GetNamedSilentFail(hediffName);
            ctx.Require(def != null, $"no hediff '{hediffName}' (is the mod that defines it loaded in this pass?)");
            foreach (Hediff h in animal.health.hediffSet.hediffs.Where(x => x.def == def).ToList()) animal.health.RemoveHediff(h);
            ctx.Assert(!animal.health.hediffSet.hediffs.Any(h => h.def == def), $"the animal '{name}' still holds the hediff '{hediffName}'");
        }

        /// <summary>Asserts the animal holds a hediff of that def; the failure lists the hediffs it holds. NOT PLAYED when written.</summary>
        [Then("Nelim's Pickle Tools: the animal {string} holds the hediff {string}")]
        public void HoldsHediff(PickleContext ctx, string name, string hediffName)
        {
            Pawn animal = AnimalGeneSteps.FindAnimal(ctx, name);
            ctx.Assert(animal.health.hediffSet.hediffs.Any(h => h.def.defName == hediffName),
                $"the animal '{name}' does not hold the hediff '{hediffName}'; it holds {HoldList(animal)}");
        }

        private static string HoldList(Pawn animal) => string.Join(", ", animal.health.hediffSet.hediffs.Select(h => h.def.defName));
    }
}
