using System;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that make and read the parent and child relations between two colonists, for scenarios that need a family (a mother and her
    /// daughters). Only the Parent relation is stored by the game, on the child; "child" is read from it. Written 2026-10-27 for
    /// SanctuaryBacklot's family feature. NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class RelationSteps
    {
        /// <summary>
        /// Makes the first colonist the mother, father or parent of the second (<c>mother</c> and <c>father</c> also require that gender),
        /// or the son, daughter or child of the second. Already related: nothing changes. Fails when a colonist is unknown, both are the
        /// same pawn, the word is unknown, or the gender does not fit the word.
        /// </summary>
        /// <param name="nickname">the colonist the word is about</param>
        /// <param name="word"><c>mother</c>, <c>father</c>, <c>parent</c>, <c>daughter</c>, <c>son</c> or <c>child</c>, any case</param>
        /// <param name="otherNickname">the other colonist</param>
        [Given("Nelim's Pickle Tools: {string} is the {word} of {string}")]
        public void SetRelation(PickleContext ctx, string nickname, string word, string otherNickname)
        {
            Resolve(ctx, nickname, word, otherNickname, out Pawn parent, out Pawn child);
            if (!child.relations.DirectRelationExists(PawnRelationDefOf.Parent, parent))
            {
                child.relations.AddDirectRelation(PawnRelationDefOf.Parent, parent);
            }

            ctx.Assert(child.relations.DirectRelationExists(PawnRelationDefOf.Parent, parent),
                $"'{parent.Name.ToStringShort}' could not be made the parent of '{child.Name.ToStringShort}'");
        }

        /// <summary>
        /// Asserts what the game holds: the first colonist is recorded as the mother, father, parent, son, daughter or child of the second.
        /// </summary>
        [Then("Nelim's Pickle Tools: {string} is recorded as the {word} of {string}")]
        public void AssertRelation(PickleContext ctx, string nickname, string word, string otherNickname)
        {
            Resolve(ctx, nickname, word, otherNickname, out Pawn parent, out Pawn child);
            ctx.Assert(child.relations.DirectRelationExists(PawnRelationDefOf.Parent, parent),
                $"'{parent.Name.ToStringShort}' is not recorded as the parent of '{child.Name.ToStringShort}'; "
                + $"the parents of '{child.Name.ToStringShort}' are {string.Join(", ", ParentNames(child))}");
        }

        private static void Resolve(PickleContext ctx, string nickname, string word, string otherNickname, out Pawn parent, out Pawn child)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Pawn other = ColonistLookup.Require(otherNickname);
            ctx.Require(pawn != other, $"'{nickname}' cannot be related to itself");
            ctx.Require(pawn.relations != null && other.relations != null, "a colonist has no relations tracker");

            switch (word.ToLowerInvariant())
            {
                case "mother":
                    RequireGender(ctx, pawn, Gender.Female, word);
                    parent = pawn; child = other;
                    break;
                case "father":
                    RequireGender(ctx, pawn, Gender.Male, word);
                    parent = pawn; child = other;
                    break;
                case "parent":
                    parent = pawn; child = other;
                    break;
                case "daughter":
                    RequireGender(ctx, pawn, Gender.Female, word);
                    parent = other; child = pawn;
                    break;
                case "son":
                    RequireGender(ctx, pawn, Gender.Male, word);
                    parent = other; child = pawn;
                    break;
                case "child":
                    parent = other; child = pawn;
                    break;
                default:
                    throw new ArgumentException($"unknown relation '{word}'; supported: mother, father, parent, daughter, son, child");
            }
        }

        private static void RequireGender(PickleContext ctx, Pawn pawn, Gender expected, string word)
        {
            ctx.Require(pawn.gender == expected, $"'{pawn.Name.ToStringShort}' is {pawn.gender}, so cannot be the {word}");
        }

        private static string[] ParentNames(Pawn child)
        {
            var names = new System.Collections.Generic.List<string>();
            foreach (DirectPawnRelation r in child.relations.DirectRelations)
            {
                if (r.def == PawnRelationDefOf.Parent)
                {
                    names.Add(r.otherPawn.Name?.ToStringShort ?? "(none)");
                }
            }

            return names.Count == 0 ? new[] { "(none)" } : names.ToArray();
        }
    }
}
