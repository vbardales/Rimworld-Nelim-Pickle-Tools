using System;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that read a colonist's gender (the game's <c>Pawn.gender</c>), written 2026-11-17 for SanctuaryBacklot: proving that the sex of a pawn does not change
    /// when the same save is loaded several times. The step that sets a gender ("X" gender is ...) is in ColonistRaceSteps. Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class GenderReadSteps
    {
        /// <summary>Logs the gender of a colonist as <c>[gender] Name: Male|Female|None</c>, so two runs can be compared in their logs.</summary>
        [When("Nelim's Pickle Tools: the gender of {string} is logged")]
        public void LogGender(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Log.Message($"[gender] {nickname}: {pawn.gender}");
        }

        /// <summary>Asserts the gender of a colonist: <c>male</c>, <c>female</c> or <c>neutral</c> (also <c>none</c>, <c>neutre</c>, <c>nonbinary</c>, <c>genderless</c> = Gender.None). The failure gives the gender found.</summary>
        [Then("Nelim's Pickle Tools: the gender of {string} is {word}")]
        public void GenderIs(PickleContext ctx, string nickname, string gender)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Gender wanted;
            switch (gender.ToLowerInvariant())
            {
                case "male": wanted = Gender.Male; break;
                case "female": wanted = Gender.Female; break;
                case "none": case "neutral": case "neutre": case "nonbinary": case "genderless": wanted = Gender.None; break;
                default: wanted = Gender.None; ctx.Require(false, $"the gender must be male, female or neutral (none), not '{gender}'"); break;
            }

            ctx.Assert(pawn.gender == wanted, $"{nickname} should be {wanted}; the game has {pawn.gender}");
        }
    }
}
