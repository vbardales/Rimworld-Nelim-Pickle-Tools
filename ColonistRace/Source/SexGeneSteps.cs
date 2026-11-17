using System;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// The SEX of a pawn as a gene, for Biotech Bodies 1.1.0 (owner model 2026-11-17): <c>Pawn.gender</c> is the GENDER (what the profile shows, None = neutral), the sex is
    /// an endogene that drives body, head, hair and organs. The gene defNames are PROVISIONAL and kept in one place (the two constants below): BiB tells the final names. Until
    /// the genes exist the sex steps fail saying so; the gender steps behave as before. Compiled, NOT PLAYED (no BiB code exists yet).
    /// </summary>
    [PickleSteps]
    public class SexGeneSteps
    {
        // PROVISIONAL names (BiB, 2026-11-17): the only place to change when the owner names them.
        public const string MaleGeneName = "BiB_SexMale";
        public const string FemaleGeneName = "BiB_SexFemale";

        private static bool Defined(out GeneDef male, out GeneDef female)
        {
            male = DefDatabase<GeneDef>.GetNamedSilentFail(MaleGeneName);
            female = DefDatabase<GeneDef>.GetNamedSilentFail(FemaleGeneName);
            return male != null && female != null;
        }

        private static void NeedGenes(PickleContext ctx, out GeneDef male, out GeneDef female)
        {
            ctx.Require(Defined(out male, out female), $"the sex gene {MaleGeneName} or {FemaleGeneName} is not defined (BiB 1.1.0 not loaded, or the defNames changed)");
        }

        private static Gene Held(Pawn pawn, GeneDef male, GeneDef female)
        {
            return pawn.genes?.GenesListForReading.FirstOrDefault(g => g.def == male || g.def == female);
        }

        private static void SetSexGene(Pawn pawn, GeneDef wanted, GeneDef male, GeneDef female)
        {
            foreach (Gene g in pawn.genes.GenesListForReading.Where(x => x.def == male || x.def == female).ToList())
            {
                if (g.def != wanted) pawn.genes.RemoveGene(g);
            }

            if (!pawn.genes.GenesListForReading.Any(g => g.def == wanted)) pawn.genes.AddGene(wanted, false);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
        }

        /// <summary>
        /// Called by the gender setter: when the sex genes exist, a male or female gender sets the sex gene to the same value; a neutral gender leaves an existing sex gene
        /// and draws a random sex only when the pawn holds none (logged as <c>[sex-drawn] Name: Male|Female seed=N</c>). Does nothing when the genes are not defined.
        /// </summary>
        internal static void FollowGender(Pawn pawn, Gender gender)
        {
            if (pawn.genes == null || !Defined(out GeneDef male, out GeneDef female)) return;
            if (gender == Gender.Male) SetSexGene(pawn, male, male, female);
            else if (gender == Gender.Female) SetSexGene(pawn, female, male, female);
            else if (Held(pawn, male, female) == null)
            {
                int seed = Find.TickManager.TicksGame ^ pawn.thingIDNumber;
                bool isMale = new System.Random(seed).Next(2) == 0;
                SetSexGene(pawn, isMale ? male : female, male, female);
                Log.Message($"[sex-drawn] {pawn.Name?.ToStringShort}: {(isMale ? "Male" : "Female")} seed={seed}");
            }
        }

        /// <summary>Sets the SEX gene of a colonist: <c>male</c> or <c>female</c> adds that sex gene (endogene) and removes the other. Fails while the genes are not defined. Does not touch Pawn.gender.</summary>
        [Given("Nelim's Pickle Tools: {string} sex is {word}")]
        public void SetSex(PickleContext ctx, string nickname, string sex)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            NeedGenes(ctx, out GeneDef male, out GeneDef female);
            ctx.Require(pawn.genes != null, $"{nickname} has no genes (Biotech)");
            GeneDef wanted;
            switch (sex.ToLowerInvariant())
            {
                case "male": wanted = male; break;
                case "female": wanted = female; break;
                default: wanted = null; ctx.Require(false, $"the sex must be male or female, not '{sex}'"); break;
            }

            SetSexGene(pawn, wanted, male, female);
            ctx.Assert(pawn.genes.GenesListForReading.Any(g => g.def == wanted), $"{nickname} should hold {wanted.defName} after this step");
        }

        /// <summary>Asserts the sex gene of a colonist, <c>male</c> or <c>female</c>. Fails while the genes are not defined, or when the pawn holds none (it says so).</summary>
        [Then("Nelim's Pickle Tools: the sex of {string} is {word}")]
        public void SexIs(PickleContext ctx, string nickname, string sex)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            NeedGenes(ctx, out GeneDef male, out GeneDef female);
            Gene held = Held(pawn, male, female);
            GeneDef wanted = sex.ToLowerInvariant() == "male" ? male : sex.ToLowerInvariant() == "female" ? female : null;
            ctx.Require(wanted != null, $"the sex must be male or female, not '{sex}'");
            ctx.Assert(held != null && held.def == wanted, $"{nickname} should have the sex {sex}; the sex gene held is {held?.def.defName ?? "none"}");
        }

        /// <summary>Writes <c>[sex] Name: Male|Female|none</c> (the sex gene held) and <c>[sex-genes] Name: ...</c> (every gene whose defName starts with BiB_Sex). Fails while the genes are not defined.</summary>
        [When("Nelim's Pickle Tools: the sex of {string} is written to the log")]
        public void LogSex(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            NeedGenes(ctx, out GeneDef male, out GeneDef female);
            Gene held = Held(pawn, male, female);
            Log.Message($"[sex] {nickname}: {(held == null ? "none" : held.def == male ? "Male" : "Female")}");
            Log.Message($"[sex-genes] {nickname}: {string.Join(", ", (pawn.genes?.GenesListForReading ?? new System.Collections.Generic.List<Gene>()).Where(g => g.def.defName.StartsWith("BiB_Sex")).Select(g => g.def.defName))}");
        }
    }
}
