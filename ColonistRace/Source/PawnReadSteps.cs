using System;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that read a colonist back: its gender, body type, xenotype, race and stage of life. The steps
    /// that set these say what was asked; these say what the game holds, which is not always the same thing
    /// (a gene sets the body type again, a race keeps its own, a child is not an adult). Every failure says
    /// the state it found.
    ///
    /// Written to sit beside Pickle's own ColonistSteps and meant to go there. Until then they live here,
    /// under a text of their own, see ../README.md.
    /// </summary>
    [PickleSteps]
    public class PawnReadSteps
    {
        private const string None = "(none)";

        /// <summary>Asserts a pawn's gender, <c>male</c> or <c>female</c>, case insensitive.</summary>
        [Then("Nelim's Pickle Tools: {string} has gender {word}")]
        public void AssertGender(PickleContext ctx, string nickname, string gender)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Gender expected;
            switch (gender.ToLowerInvariant())
            {
                case "male":
                    expected = Gender.Male;
                    break;
                case "female":
                    expected = Gender.Female;
                    break;
                default:
                    throw new ArgumentException($"unknown gender '{gender}'; supported: male, female");
            }

            ctx.Assert(
                pawn.gender == expected,
                $"pawn '{nickname}' should have gender {expected}; it has {pawn.gender}");
        }

        /// <summary>Asserts a pawn's body type by def name, case insensitive.</summary>
        [Then("Nelim's Pickle Tools: {string} has body type {word}")]
        public void AssertBodyType(PickleContext ctx, string nickname, string bodyTypeDefName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story, so it has no body type");
            string actual = pawn.story.bodyType?.defName ?? None;

            ctx.Assert(
                string.Equals(actual, bodyTypeDefName, StringComparison.OrdinalIgnoreCase),
                $"pawn '{nickname}' should have body type {bodyTypeDefName}; it has {actual}");
        }

        /// <summary>
        /// Asserts a pawn's xenotype by def name, case insensitive. A pawn with a custom xenotype reads as
        /// the def it was built from, and the failure names the custom one.
        /// </summary>
        [Then("Nelim's Pickle Tools: {string} has xenotype {string}")]
        public void AssertXenotype(PickleContext ctx, string nickname, string xenotypeDefName)
        {
            ctx.Require(ModsConfig.BiotechActive, "xenotypes need Biotech, and it is not active in this run");
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.genes != null, $"pawn '{nickname}' has no genes, so it has no xenotype");
            string actual = pawn.genes.Xenotype?.defName ?? None;
            string custom = string.IsNullOrEmpty(pawn.genes.xenotypeName) ? string.Empty : $" (custom name '{pawn.genes.xenotypeName}')";

            ctx.Assert(
                string.Equals(actual, xenotypeDefName, StringComparison.OrdinalIgnoreCase),
                $"pawn '{nickname}' should have xenotype {xenotypeDefName}; it has {actual}{custom}");
        }

        /// <summary>Asserts a pawn's race by def name, case insensitive: <c>Human</c>, or a race a mod adds.</summary>
        [Then("Nelim's Pickle Tools: {string} is of race {string}")]
        public void AssertRace(PickleContext ctx, string nickname, string raceDefName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            string actual = pawn.def?.defName ?? None;

            ctx.Assert(
                string.Equals(actual, raceDefName, StringComparison.OrdinalIgnoreCase),
                $"pawn '{nickname}' should be of race {raceDefName}; it is of race {actual}");
        }

        /// <summary>
        /// Asserts a pawn's stage of life: <c>Baby</c>, <c>Newborn</c>, <c>Child</c> or <c>Adult</c>, case
        /// insensitive. Needs Biotech for the first three.
        /// </summary>
        [Then("Nelim's Pickle Tools: {string} is at the {word} stage of life")]
        public void AssertDevelopmentalStage(PickleContext ctx, string nickname, string stage)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            DevelopmentalStage actual = pawn.DevelopmentalStage;

            ctx.Assert(
                string.Equals(actual.ToString(), stage, StringComparison.OrdinalIgnoreCase),
                $"pawn '{nickname}' should be at the {stage} stage of life; it is at the {actual} stage, aged {pawn.ageTracker?.AgeBiologicalYears} years");
        }
    }
}
