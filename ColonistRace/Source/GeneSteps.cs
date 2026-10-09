using System;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that give a colonist a gene and check it, for galleries that need an eye colour or a body trait from a gene mod (EyeGenes3 for
    /// instance). Ported on 2026-10-08 from SanctuaryBacklot (commit 2428ab8, Virginie: the pawn steps belong to Pickle Tools). Needs Biotech.
    /// </summary>
    [PickleSteps]
    public class GeneSteps
    {
        /// <summary>
        /// Gives a colonist a gene by its def name and redraws it. Any gene of the pawn that shares an exclusion tag with the new one is removed first
        /// (an eye colour replaces the previous eye colour, which the game would otherwise refuse to combine), then the gene is added as an endogene.
        /// Reads the gene back and fails with what the pawn holds if it is missing. Needs Biotech.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} has the gene {string}")]
        public void GiveGene(PickleContext ctx, string nickname, string geneName)
        {
            ctx.Require(ModsConfig.BiotechActive, "genes need Biotech, and it is not active in this run");
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.genes != null, "pawn '" + nickname + "' has no genes");
            GeneDef def = DefDatabase<GeneDef>.GetNamedSilentFail(geneName);
            ctx.Require(def != null, "no gene '" + geneName + "' (is the mod that defines it loaded in this pass?)");
            if (def.exclusionTags != null && def.exclusionTags.Count > 0)
                foreach (Gene g in pawn.genes.GenesListForReading.Where(x => x.def != def && x.def.exclusionTags != null && x.def.exclusionTags.Any(def.exclusionTags.Contains)).ToList())
                    pawn.genes.RemoveGene(g);
            if (!pawn.genes.GenesListForReading.Any(x => x.def == def)) pawn.genes.AddGene(def, false);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            ctx.Assert(pawn.genes.GenesListForReading.Any(x => x.def == def),
                "pawn '" + nickname + "' does not hold the gene '" + geneName + "'; it holds " + string.Join(", ", pawn.genes.GenesListForReading.Select(x => x.def.defName)));
        }

        /// <summary>Asserts that a colonist holds a gene, by its def name. The failure lists the genes the pawn holds.</summary>
        [Then("Nelim's Pickle Tools: {string} holds the gene {string}")]
        public void HoldsGene(PickleContext ctx, string nickname, string geneName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.genes != null, "pawn '" + nickname + "' has no genes");
            ctx.Assert(pawn.genes.GenesListForReading.Any(x => string.Equals(x.def.defName, geneName, StringComparison.OrdinalIgnoreCase)),
                "pawn '" + nickname + "' does not hold the gene '" + geneName + "'; it holds " + string.Join(", ", pawn.genes.GenesListForReading.Select(x => x.def.defName)));
        }
    }
}
