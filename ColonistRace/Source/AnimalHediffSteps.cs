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

        /// <summary>
        /// Adds a hediff to ONE body part of the animal, found by its label ("rear left leg", case insensitive) or, failing that, by its def name ("Leg": the first part of that
        /// def, front or rear, that the animal still has). A hediff that is an added part (a peg leg, a bionic leg) replaces the part as an operation does: it takes a part that is
        /// missing first, the part is restored (the missing part hediff goes), then the hediff is added. A wound def is given severity 2. Fails when the animal, the def or the part is
        /// unknown (it lists the parts), or when the hediff is not on the part afterwards. Written 2026-11-11 for PomeranianADogSaid2Renew (a peg leg on a rear leg). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the animal {string} has the hediff {string} on its {string}")]
        public void GiveHediffOnPart(PickleContext ctx, string name, string hediffName, string partName)
        {
            Pawn animal = AnimalGeneSteps.FindAnimal(ctx, name);
            HediffDef def = DefDatabase<HediffDef>.GetNamedSilentFail(hediffName);
            ctx.Require(def != null, $"no hediff '{hediffName}' (is the mod that defines it loaded in this pass?)");
            bool replacesPart = def.hediffClass != null && typeof(Hediff_AddedPart).IsAssignableFrom(def.hediffClass);
            BodyPartRecord part = FindPart(ctx, animal, name, partName, replacesPart);
            if (replacesPart) animal.health.RestorePart(part);
            Hediff hediff = HediffMaker.MakeHediff(def, animal, part);
            if (hediff is Hediff_Injury) hediff.Severity = 2f;
            animal.health.AddHediff(hediff, part);
            ctx.Assert(animal.health.hediffSet.hediffs.Any(h => h.def == def && h.Part == part),
                $"the animal '{name}' does not hold the hediff '{hediffName}' on its {partName}; it holds {HoldList(animal)}");
        }

        /// <summary>
        /// Removes ONE body part of the animal (a MissingBodyPart hediff on it), found as in <c>has the hediff ... on its ...</c>: by label, else by def name (the first part of that def
        /// the animal still has, so "Leg" removes one leg; name "rear left leg" for a given one). Fails when the part is unknown or already missing (it lists the parts). Written
        /// 2026-11-11 for PomeranianADogSaid2Renew. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the animal {string} is missing its {string}")]
        public void MissingPart(PickleContext ctx, string name, string partName)
        {
            Pawn animal = AnimalGeneSteps.FindAnimal(ctx, name);
            BodyPartRecord part = FindPart(ctx, animal, name, partName, false);
            animal.health.AddHediff(HediffMaker.MakeHediff(HediffDefOf.MissingBodyPart, animal, part), part);
            ctx.Assert(animal.health.hediffSet.PartIsMissing(part), $"the part '{part.Label}' of the animal '{name}' is not missing after the step; it holds {HoldList(animal)}");
        }

        /// <summary>Asserts the animal holds a hediff of that def on a body part (found by label, else def name, as the Given steps do); the failure lists the hediffs it holds with their parts. NOT PLAYED when written.</summary>
        [Then("Nelim's Pickle Tools: the animal {string} holds the hediff {string} on its {string}")]
        public void HoldsHediffOnPart(PickleContext ctx, string name, string hediffName, string partName)
        {
            Pawn animal = AnimalGeneSteps.FindAnimal(ctx, name);
            ctx.Assert(animal.health.hediffSet.hediffs.Any(h => h.def.defName == hediffName && h.Part != null
                    && (string.Equals(h.Part.Label, partName, System.StringComparison.OrdinalIgnoreCase) || string.Equals(h.Part.def.defName, partName, System.StringComparison.OrdinalIgnoreCase))),
                $"the animal '{name}' does not hold the hediff '{hediffName}' on its {partName}; it holds " + string.Join(", ", animal.health.hediffSet.hediffs.Select(h => h.def.defName + " on " + (h.Part?.Label ?? "no part"))));
        }

        /// <summary>The part an operation or a wound names: label first, then def name. Among several of a def the first the animal still has; for a part that an added part replaces, a missing one first.</summary>
        internal static BodyPartRecord FindPart(PickleContext ctx, Pawn animal, string name, string partName, bool missingFirst)
        {
            var parts = animal.RaceProps.body.AllParts;
            var matches = parts.Where(p => string.Equals(p.Label, partName, System.StringComparison.OrdinalIgnoreCase)).ToList();
            if (matches.Count == 0) matches = parts.Where(p => string.Equals(p.def.defName, partName, System.StringComparison.OrdinalIgnoreCase)).ToList();
            ctx.Require(matches.Count > 0, $"the animal '{name}' has no body part '{partName}'; it has " + string.Join(", ", parts.Select(p => p.Label).Distinct()));
            BodyPartRecord part = missingFirst
                ? matches.FirstOrDefault(p => animal.health.hediffSet.PartIsMissing(p)) ?? matches[0]
                : matches.FirstOrDefault(p => !animal.health.hediffSet.PartIsMissing(p));
            ctx.Require(part != null, $"every part '{partName}' of the animal '{name}' is already missing ({string.Join(", ", matches.Select(p => p.Label))})");
            return part;
        }

        private static string HoldList(Pawn animal) => string.Join(", ", animal.health.hediffSet.hediffs.Select(h => h.def.defName));
    }
}
