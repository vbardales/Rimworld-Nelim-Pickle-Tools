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

        /// <summary>
        /// Logs every gene of a colonist (<c>[genes]</c>: endogenes and xenogenes, defName and the exclusion tags). Never fails. Written 2026-10-25 to find
        /// what draws the "beauty" look of the fixture eyes (owner: the eye catalogue still shows lashes and a liner). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the genes of {string} are logged")]
        public void LogGenes(PickleContext ctx, string nickname)
        {
            ctx.Require(ModsConfig.BiotechActive, "genes need Biotech, and it is not active in this run");
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.genes != null, "pawn '" + nickname + "' has no genes");
            Log.Message("[genes] " + nickname + " xenotype " + (pawn.genes.Xenotype?.defName ?? pawn.genes.xenotypeName ?? "custom") + ": "
                + string.Join(", ", pawn.genes.GenesListForReading.Select(g => g.def.defName + (g.def.exclusionTags != null && g.def.exclusionTags.Count > 0 ? "{" + string.Join("/", g.def.exclusionTags) + "}" : "") + (pawn.genes.Xenogenes.Contains(g) ? "(xeno)" : ""))));
        }

        /// <summary>
        /// Removes every gene of a colonist, endogenes and xenogenes, and redraws it: a plain pawn whose face a gallery sets part by part, with no gene
        /// (a beauty gene, an eye colour) steering the look. A gene added afterwards (<c>has the gene</c>) is the only one it holds. Needs Biotech.
        /// Written 2026-10-25. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} loses all genes")]
        public void LoseAllGenes(PickleContext ctx, string nickname)
        {
            ctx.Require(ModsConfig.BiotechActive, "genes need Biotech, and it is not active in this run");
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.genes != null, "pawn '" + nickname + "' has no genes");
            foreach (Gene g in pawn.genes.GenesListForReading.ToList())
                pawn.genes.RemoveGene(g);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            ctx.Assert(pawn.genes.GenesListForReading.Count == 0, "pawn '" + nickname + "' still holds " + string.Join(", ", pawn.genes.GenesListForReading.Select(x => x.def.defName)));
        }

        /// <summary>
        /// Gives a colonist the hair colour its genes define, as the generator does for a xenotype: the colour of the FIRST active gene that has a hair colour, in the order the pawn holds its genes, and no other (it does not blend several: for that use <c>hair colour is refreshed by the game from all its genes</c>; to drop the random gene a new colonist holds, <c>loses the genes that set a hair colour</c>) (the game does not rewrite
        /// <c>story.HairColor</c> when a gene is ADDED later, so <c>has the gene</c> alone leaves the old colour). Fails when no active gene defines a hair colour (it lists the genes) or when the
        /// colour read back differs. Written 2026-10-28 for SanctuaryBacklot (colours by genes, no rgb). NOT PLAYED when written. Needs Biotech.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} hair colour is taken from its genes")]
        public void HairColourFromGenes(PickleContext ctx, string nickname)
        {
            ctx.Require(ModsConfig.BiotechActive, "genes need Biotech, and it is not active in this run");
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.genes != null && pawn.story != null, "pawn '" + nickname + "' has no genes or no story");
            Gene gene = pawn.genes.GenesListForReading.FirstOrDefault(g => g.Active && g.def.hairColorOverride.HasValue);
            ctx.Require(gene != null, "no active gene of '" + nickname + "' defines a hair colour; it holds " + string.Join(", ", pawn.genes.GenesListForReading.Select(x => x.def.defName + (x.def.hairColorOverride.HasValue ? "(hair)" : ""))));
            UnityEngine.Color wanted = gene.def.hairColorOverride.Value;
            pawn.story.HairColor = wanted;
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            UnityEngine.Color read = pawn.story.HairColor;
            Log.Message("[colour] " + nickname + " hair colour from gene " + gene.def.defName + " (the first of " + pawn.genes.GenesListForReading.Count(g => g.Active && g.def.hairColorOverride.HasValue) + " active hair colour gene(s)): rgb (" + UnityEngine.Mathf.RoundToInt(read.r * 255f) + ", " + UnityEngine.Mathf.RoundToInt(read.g * 255f) + ", " + UnityEngine.Mathf.RoundToInt(read.b * 255f) + ")");
            ctx.Assert(UnityEngine.Mathf.Abs(read.r - wanted.r) < 0.01f && UnityEngine.Mathf.Abs(read.g - wanted.g) < 0.01f && UnityEngine.Mathf.Abs(read.b - wanted.b) < 0.01f,
                nickname + "'s hair colour should read the colour of " + gene.def.defName + " " + wanted + "; it reads " + read + " (something forces another colour)");
        }

        /// <summary>
        /// Removes every gene of a colonist that sets a hair colour (<c>hairColorOverride</c>), endogenes and xenogenes, and redraws it: the colonist
        /// starts a hair colour scenario with no random hair gene left (a new colonist holds one). A hair colour gene added afterwards (<c>has the gene</c>)
        /// is then the only one, and the colour is whatever the game, or a mod that changes the rule, makes of the genes added. Logs the genes removed
        /// (<c>[colour]</c>). Needs Biotech. Written 2026-11-01 for SanctuaryBacklot (Ryu, Hair Color Feels Unique Now). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} loses the genes that set a hair colour")]
        public void LoseHairColourGenes(PickleContext ctx, string nickname)
        {
            ctx.Require(ModsConfig.BiotechActive, "genes need Biotech, and it is not active in this run");
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.genes != null, "pawn '" + nickname + "' has no genes");
            var removed = pawn.genes.GenesListForReading.Where(g => g.def.hairColorOverride.HasValue).ToList();
            foreach (Gene g in removed)
                pawn.genes.RemoveGene(g);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            Log.Message("[colour] " + nickname + " lost the hair colour genes: " + (removed.Count == 0 ? "(none)" : string.Join(", ", removed.Select(g => g.def.defName))));
            ctx.Assert(!pawn.genes.GenesListForReading.Any(g => g.def.hairColorOverride.HasValue),
                "pawn '" + nickname + "' still holds " + string.Join(", ", pawn.genes.GenesListForReading.Where(g => g.def.hairColorOverride.HasValue).Select(x => x.def.defName)));
        }

        /// <summary>
        /// Lets the game compute the hair colour from ALL the hair colour genes of a colonist, which <c>hair colour is taken from its genes</c> does not (it
        /// copies the first gene). It calls the game's own refresh, <c>Pawn_GeneTracker.Notify_GenesChanged</c> with a hair colour gene, the call the game makes when
        /// a gene is added or removed: a mod that blends the genes (Hair Color Feels Unique Now averages them) acts there, and without such a mod the game leaves its
        /// colour. Redraws the pawn and logs the colour it now draws with (<c>[colour]</c>, the genes and the rgb). Does not assert a colour: follow it with
        /// <c>hair colour reads rgb</c>. Fails when no active gene sets a hair colour. Needs Biotech. Written 2026-11-01 for SanctuaryBacklot. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} hair colour is refreshed by the game from all its genes")]
        public void HairColourRefreshed(PickleContext ctx, string nickname)
        {
            ctx.Require(ModsConfig.BiotechActive, "genes need Biotech, and it is not active in this run");
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.genes != null && pawn.story != null, "pawn '" + nickname + "' has no genes or no story");
            var hairGenes = pawn.genes.GenesListForReading.Where(g => g.Active && g.def.hairColorOverride.HasValue).ToList();
            ctx.Require(hairGenes.Count > 0, "no active gene of '" + nickname + "' defines a hair colour; it holds " + string.Join(", ", pawn.genes.GenesListForReading.Select(x => x.def.defName)));
            var refresh = typeof(Pawn_GeneTracker).GetMethod("Notify_GenesChanged", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic, null, new[] { typeof(GeneDef) }, null);
            ctx.Require(refresh != null, "Pawn_GeneTracker.Notify_GenesChanged(GeneDef) is not in this game build: the game moved its refresh, this step has to follow");
            refresh.Invoke(pawn.genes, new object[] { hairGenes[0].def });
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            UnityEngine.Color read = pawn.story.HairColor;
            Log.Message("[colour] " + nickname + " hair colour after the game's refresh from " + hairGenes.Count + " gene(s) " + string.Join(", ", hairGenes.Select(g => g.def.defName))
                + ": rgb (" + UnityEngine.Mathf.RoundToInt(read.r * 255f) + ", " + UnityEngine.Mathf.RoundToInt(read.g * 255f) + ", " + UnityEngine.Mathf.RoundToInt(read.b * 255f) + ")");
        }

        /// <summary>
        /// Removes the skin colour override of a colonist (<c>story.skinColorOverride</c>, what the step <c>skin colour is rgb</c> writes and what a save keeps), so the skin is the colour of its
        /// skin genes. Does nothing when there is none. Reads it back. Written 2026-10-28 for SanctuaryBacklot. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} skin colour override is cleared")]
        public void ClearSkinOverride(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, "pawn '" + nickname + "' has no story, so it has no skin colour");
            pawn.story.skinColorOverride = null;
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            ctx.Assert(!pawn.story.skinColorOverride.HasValue, nickname + "'s skin colour override should be cleared; it is " + pawn.story.skinColorOverride);
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
