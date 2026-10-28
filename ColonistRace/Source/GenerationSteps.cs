using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that generate pawns the way the game does at a birth or a raid (PawnGenerator, a pawn kind) and read the genes they came out with, to test a weighting
    /// of random genes (Seren skin colours, for SeRenBiotechExtended). The pawns are never spawned and are discarded after the scenario. Written 2026-10-28. NOT PLAYED when written. Needs Biotech.
    /// </summary>
    [PickleSteps]
    public class GenerationSteps
    {
        private static readonly List<Pawn> Generated = new List<Pawn>();

        /// <summary>
        /// Generates N pawns of a PawnKindDef (by defName) with the game's own generator, not spawned, and keeps them for the steps that read them (a later step of the scenario
        /// replaces the previous batch). Fails when the kind does not exist or N is not between 1 and 2000.
        /// </summary>
        [Given("Nelim's Pickle Tools: {int} pawns of kind {string} are generated")]
        public void Generate(PickleContext ctx, int count, string kindName)
        {
            ctx.Require(ModsConfig.BiotechActive, "genes need Biotech, and it is not active in this run");
            ctx.Require(count >= 1 && count <= 2000, "the count must be between 1 and 2000");
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no PawnKindDef named '{kindName}'");
            Discard();
            for (int i = 0; i < count; i++)
            {
                Pawn pawn = PawnGenerator.GeneratePawn(new PawnGenerationRequest(kind, Faction.OfPlayer, PawnGenerationContext.NonPlayer, forceGenerateNewPawn: true, canGeneratePawnRelations: false));
                Generated.Add(pawn);
            }

            ctx.Assert(Generated.Count == count && Generated.All(p => p.genes != null), $"{count} pawns with genes should be generated; got {Generated.Count}");
            Log.Message($"[generated] {count} pawns of kind {kindName}");
        }

        private static float Share(string geneName)
        {
            return 100f * Generated.Count(p => p.genes.GenesListForReading.Any(g => g.def.defName == geneName)) / Generated.Count;
        }

        /// <summary>Asserts the share of the generated pawns that hold a gene (by defName, endogene or xenogene) is between two percentages, inclusive. Logs the count.</summary>
        [Then("Nelim's Pickle Tools: the share of the generated pawns holding the gene {string} is between {float} and {float} percent")]
        public void ShareBetween(PickleContext ctx, string geneName, float min, float max)
        {
            ctx.Require(Generated.Count > 0, "no pawns generated: use 'N pawns of kind ... are generated' first");
            ctx.Require(DefDatabase<GeneDef>.GetNamedSilentFail(geneName) != null, $"no gene '{geneName}' (is its mod loaded?)");
            float share = Share(geneName);
            Log.Message($"[generated] {geneName}: {share:0.##} percent of {Generated.Count}");
            ctx.Assert(share >= min && share <= max, $"the share of pawns holding {geneName} should be between {min} and {max} percent; it is {share:0.##} ({Generated.Count} pawns)");
        }

        /// <summary>Logs, for every gene whose defName starts with the prefix, how many of the generated pawns hold it (lines starting [generated]). Never fails except with no batch.</summary>
        [Then("Nelim's Pickle Tools: the genes with the prefix {string} of the generated pawns are counted")]
        public void CountPrefix(PickleContext ctx, string prefix)
        {
            ctx.Require(Generated.Count > 0, "no pawns generated: use 'N pawns of kind ... are generated' first");
            foreach (GeneDef def in DefDatabase<GeneDef>.AllDefsListForReading.Where(d => d.defName.StartsWith(prefix)).OrderBy(d => d.defName))
            {
                int n = Generated.Count(p => p.genes.GenesListForReading.Any(g => g.def == def));
                Log.Message($"[generated] {def.defName}: {n} of {Generated.Count} ({100f * n / Generated.Count:0.##} percent)");
            }
        }

        private static void Discard()
        {
            foreach (Pawn p in Generated) if (!p.Destroyed) p.Discard(true);
            Generated.Clear();
        }

        [AfterScenario]
        public void DiscardAll()
        {
            Discard();
        }
    }
}
