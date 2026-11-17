using System;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// The sex gene of a pawn for Biotech Bodies 1.1.0 (owner model 2026-11-17): <c>Pawn.gender</c> is the GENDER, the SEX is an endogene. This file holds only what the gender setter needs:
    /// a plain defName lookup (no code dependency on BiB). The sex steps (`sex is`, `the sex of ... is`, its log) are NOT here: the owner decided on 2026-11-17 that BiB ships them in its own package.
    /// Names final since 2026-11-17. Compiled, NOT PLAYED (no BiB code exists yet).
    /// </summary>
    internal static class SexGeneSteps
    {
        // Final names (BiB, validated by the owner 2026-11-17): the only place to change if they ever change.
        internal const string MaleGeneName = "BiB_SexMale";
        internal const string FemaleGeneName = "BiB_SexFemale";

        private static bool Defined(out GeneDef male, out GeneDef female)
        {
            male = DefDatabase<GeneDef>.GetNamedSilentFail(MaleGeneName);
            female = DefDatabase<GeneDef>.GetNamedSilentFail(FemaleGeneName);
            return male != null && female != null;
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
    }
}
