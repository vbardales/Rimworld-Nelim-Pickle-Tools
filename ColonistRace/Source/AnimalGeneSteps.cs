using System;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Genes on an animal. The colonist step <c>"X" has the gene "Y"</c> finds free colonists only, so it cannot name an animal. Written
    /// 2026-10-31 at the request of SanctuaryBacklot (Atticus's eye gene recorded in game before the Animal Cosmetic Genes mod exists).
    /// The step does not create a gene tracker: an animal with <c>Pawn.genes == null</c> fails with a message that says so, which is the proof
    /// that a mod is needed. NOT PLAYED: compiled against the reference assemblies only.
    /// </summary>
    [PickleSteps]
    public class AnimalGeneSteps
    {
        /// <summary>
        /// Gives the named animal (colony animal or any spawned animal whose short name matches, case-insensitive) the gene. Fails when Biotech
        /// is off, when no animal has that name (it lists the animals), when the animal has no gene tracker, or when the gene is unknown.
        /// A gene that excludes one the animal holds replaces it, as for colonists. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the animal {string} has the gene {string}")]
        public void GiveGene(PickleContext ctx, string name, string geneName)
        {
            ctx.Require(ModsConfig.BiotechActive, "genes need Biotech, and it is not active in this run");
            Pawn animal = FindAnimal(ctx, name);
            ctx.Require(animal.genes != null, $"the animal '{name}' ({animal.def.defName}) has no gene tracker (Pawn.genes is null): vanilla Biotech gives animals no genes, a mod has to");
            GeneDef def = DefDatabase<GeneDef>.GetNamedSilentFail(geneName);
            ctx.Require(def != null, $"no gene '{geneName}' (is the mod that defines it loaded in this pass?)");
            if (def.exclusionTags != null && def.exclusionTags.Count > 0)
                foreach (Gene g in animal.genes.GenesListForReading.Where(x => x.def != def && x.def.exclusionTags != null && x.def.exclusionTags.Any(def.exclusionTags.Contains)).ToList())
                    animal.genes.RemoveGene(g);
            if (!animal.genes.GenesListForReading.Any(x => x.def == def)) animal.genes.AddGene(def, false);
            animal.Drawer?.renderer?.SetAllGraphicsDirty();
            ctx.Assert(animal.genes.GenesListForReading.Any(x => x.def == def),
                $"the animal '{name}' does not hold the gene '{geneName}'; it holds {string.Join(", ", animal.genes.GenesListForReading.Select(x => x.def.defName))}");
        }

        /// <summary>
        /// Asserts the named animal holds the gene; the failure lists the genes it holds, or says it has no gene tracker. NOT PLAYED when written.
        /// </summary>
        [Then("Nelim's Pickle Tools: the animal {string} holds the gene {string}")]
        public void HoldsGene(PickleContext ctx, string name, string geneName)
        {
            Pawn animal = FindAnimal(ctx, name);
            ctx.Assert(animal.genes != null, $"the animal '{name}' ({animal.def.defName}) has no gene tracker (Pawn.genes is null), so it holds no gene");
            ctx.Assert(animal.genes.GenesListForReading.Any(x => x.def.defName == geneName),
                $"the animal '{name}' does not hold the gene '{geneName}'; it holds {string.Join(", ", animal.genes.GenesListForReading.Select(x => x.def.defName))}");
        }

        internal static Pawn FindAnimal(PickleContext ctx, string name)
        {
            var animals = PawnsFinder.AllMaps_Spawned.Where(p => p.RaceProps != null && p.RaceProps.Animal).ToList();
            Pawn animal = animals.FirstOrDefault(p => string.Equals(p.Name?.ToStringShort, name, StringComparison.OrdinalIgnoreCase));
            ctx.Require(animal != null, $"no spawned animal named '{name}'; the named animals are {string.Join(", ", animals.Where(p => p.Name != null).Select(p => p.Name.ToStringShort + " (" + p.def.defName + ")").Take(40))}");
            return animal;
        }
    }
}
