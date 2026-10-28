using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps on the age of a colonist: read the biological age and make a colonist age by a number of calendar years the way the game does, through the age
    /// tracker, so a gene that slows or speeds the ageing (Seren's OL_SerenLongevity) counts. Written 2026-10-28 for SeRenBiotechExtended. NOT PLAYED when written.
    /// A colonist's ages come back after the scenario.
    /// </summary>
    [PickleSteps]
    public class AgeSteps
    {
        private const long TicksPerYear = 3600000L;
        private static readonly Dictionary<Pawn, (long Bio, long Chrono)> Before = new Dictionary<Pawn, (long, long)>();

        /// <summary>Asserts the biological age of a colonist (years, with the fraction) is strictly above a number.</summary>
        [Then("Nelim's Pickle Tools: {string} biological age is above {float} years")]
        public void AgeAbove(PickleContext ctx, string nickname, float years)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            float age = pawn.ageTracker.AgeBiologicalYearsFloat;
            Log.Message($"[age] {nickname} biological age {age:0.###} years, chronological {pawn.ageTracker.AgeChronologicalYearsFloat:0.###}");
            ctx.Assert(age > years, $"{nickname}'s biological age should be above {years} years; it is {age:0.###}");
        }

        /// <summary>The same, strictly below a number.</summary>
        [Then("Nelim's Pickle Tools: {string} biological age is below {float} years")]
        public void AgeBelow(PickleContext ctx, string nickname, float years)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            float age = pawn.ageTracker.AgeBiologicalYearsFloat;
            Log.Message($"[age] {nickname} biological age {age:0.###} years, chronological {pawn.ageTracker.AgeChronologicalYearsFloat:0.###}");
            ctx.Assert(age < years, $"{nickname}'s biological age should be below {years} years; it is {age:0.###}");
        }

        /// <summary>
        /// Makes a colonist age by a number of CALENDAR years: the chronological age grows by that many years and the biological age grows by what the ageing
        /// factor of the colonist gives (the age tracker's BiologicalTicksPerTick, read again every quarter of a year of calendar time, so a factor that changes at
        /// a biological age, 1 up to 19 years then 0.214 from 20 for OL_SerenLongevity, is followed). The ages are restored after the scenario. Logs [age] before and after.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} ages by {float} years")]
        public void AgesBy(PickleContext ctx, string nickname, float years)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.ageTracker != null && years > 0f, "the colonist needs an age tracker and the years must be above 0");
            if (!Before.ContainsKey(pawn)) Before[pawn] = (pawn.ageTracker.AgeBiologicalTicks, pawn.ageTracker.AgeChronologicalTicks);
            float start = pawn.ageTracker.AgeBiologicalYearsFloat;
            long remaining = (long)(years * TicksPerYear);
            const long chunk = TicksPerYear / 4;
            while (remaining > 0)
            {
                long step = remaining < chunk ? remaining : chunk;
                float factor = pawn.ageTracker.BiologicalTicksPerTick;
                pawn.ageTracker.AgeChronologicalTicks += step;
                pawn.ageTracker.AgeBiologicalTicks += (long)(step * factor);
                remaining -= step;
            }

            Recalc(pawn);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            Log.Message($"[age] {nickname} aged by {years} calendar years: biological {start:0.###} -> {pawn.ageTracker.AgeBiologicalYearsFloat:0.###}, chronological {pawn.ageTracker.AgeChronologicalYearsFloat:0.###}, factor now {pawn.ageTracker.BiologicalTicksPerTick:0.###}");
        }

        private static void Recalc(Pawn pawn) => HarmonyLib.AccessTools.Method(typeof(Pawn_AgeTracker), "RecalculateLifeStageIndex")?.Invoke(pawn.ageTracker, null);

        [AfterScenario]
        public void RestoreAges()
        {
            foreach (var pair in Before.ToList())
            {
                Pawn pawn = pair.Key;
                if (pawn.Destroyed || pawn.ageTracker == null) continue;
                pawn.ageTracker.AgeBiologicalTicks = pair.Value.Bio;
                pawn.ageTracker.AgeChronologicalTicks = pair.Value.Chrono;
                Recalc(pawn);
            }

            Before.Clear();
        }
    }
}
