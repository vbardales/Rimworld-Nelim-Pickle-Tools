using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Four small generic steps on a colonist, promoted 2026-10-12 from A Perfect Mind in a Perfect Body's own steps (TraitSteps,
    /// InteractionSteps): no traits, standing next to another colonist, a stat compared with a remembered value, and the mood thoughts a
    /// colonist currently FEELS (an offset above zero), as against the ones <c>has the thought</c> counts. Not played here.
    /// </summary>
    [PickleSteps]
    public class PawnStateSteps
    {
        private static readonly Dictionary<(Pawn, StatDef), float> StatBaseline = new Dictionary<(Pawn, StatDef), float>();

        /// <summary>Removes every trait of the colonist, the game's own conflict suppression left alone.</summary>
        [Given("Nelim's Pickle Tools: {string} has no traits")]
        public void NoTraits(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story?.traits != null, $"{nickname} has no trait set");
            foreach (Trait trait in pawn.story.traits.TraitsSorted.ToList())
            {
                pawn.story.traits.RemoveTrait(trait, false);
            }
        }

        /// <summary>
        /// Places the first colonist on a walkable cell beside the second, through the game's own teleport notification so that no job
        /// or path pulls it back. Fails when the second is not spawned or the first ends more than 2.5 cells away.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} stands next to {string}")]
        public void StandsNextTo(PickleContext ctx, string mover, string anchor)
        {
            Pawn pawn = ColonistLookup.Require(mover);
            Pawn other = ColonistLookup.Require(anchor);
            ctx.Require(other.Spawned && other.Map != null, $"{anchor} is not spawned on a map");
            IntVec3 cell = CellFinder.RandomClosewalkCellNear(other.Position, other.Map, 1);
            pawn.Position = cell;
            pawn.Notify_Teleported(true, true);
            ctx.Assert(
                pawn.Position.DistanceTo(other.Position) <= 2.5f,
                $"{mover} is {pawn.Position.DistanceTo(other.Position):0.#} cells from {anchor} after being placed beside it");
        }

        /// <summary>
        /// Remembers a stat of a colonist (the value without the cache), by StatDef name, for the two steps that compare it later. An
        /// absolute stat depends on skills, health and everything the colonist carries, so only a change after one edit is comparable.
        /// </summary>
        [When("Nelim's Pickle Tools: I remember {string}'s stat {string}")]
        public void RememberStat(PickleContext ctx, string nickname, string statName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            StatDef stat = Stat(ctx, statName);
            StatBaseline[(pawn, stat)] = Uncached(pawn, stat);
        }

        /// <summary>The stat differs from the remembered value by the expected amount, within 2 percent of it (and at least 0.01).</summary>
        [Then("Nelim's Pickle Tools: {string}'s stat {string} changed by {float}")]
        public void StatChangedBy(PickleContext ctx, string nickname, string statName, float expected)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            StatDef stat = Stat(ctx, statName);
            float before = Remembered(ctx, pawn, stat, nickname, statName);
            float after = Uncached(pawn, stat);
            float tolerance = Math.Max(0.01f, Math.Abs(expected) * 0.02f);
            ctx.Assert(
                Math.Abs((after - before) - expected) <= tolerance,
                $"{nickname}'s {statName} went from {before} to {after} (change {after - before}); {expected} was expected");
        }

        /// <summary>The stat is the expected multiple of the remembered value, within 0.005. Refuses a remembered value of zero.</summary>
        [Then("Nelim's Pickle Tools: {string}'s stat {string} is {float} times the remembered value")]
        public void StatRatio(PickleContext ctx, string nickname, string statName, float expected)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            StatDef stat = Stat(ctx, statName);
            float before = Remembered(ctx, pawn, stat, nickname, statName);
            ctx.Require(before > 0.0001f, $"the remembered {statName} is {before}: a ratio to zero says nothing");
            float after = Uncached(pawn, stat);
            float ratio = after / before;
            ctx.Assert(Math.Abs(ratio - expected) <= 0.005f, $"{nickname}'s {statName} went from {before} to {after}: a factor of {ratio}, expected {expected}");
        }

        /// <summary>
        /// The colonist currently FEELS the mood thought: it is in the colonist's mood thoughts with an offset other than zero, after the
        /// situational thoughts are recomputed. <c>has the thought</c> counts a thought a trait cancels (offset 0) as present; this one
        /// does not.
        /// </summary>
        [Then("Nelim's Pickle Tools: {string} currently feels the mood thought {string}")]
        public void Feels(PickleContext ctx, string nickname, string defName)
        {
            bool found = Felt(ctx, nickname).Any(t => t.def.defName == defName);
            ctx.Assert(found, $"{nickname} does not currently feel the mood thought '{defName}' (absent, or silenced to an offset of zero)");
        }

        /// <summary>The colonist does not currently feel the mood thought (absent, or with an offset of zero).</summary>
        [Then("Nelim's Pickle Tools: {string} currently does not feel the mood thought {string}")]
        public void DoesNotFeel(PickleContext ctx, string nickname, string defName)
        {
            Thought found = Felt(ctx, nickname).FirstOrDefault(t => t.def.defName == defName);
            ctx.Assert(found == null, $"{nickname} unexpectedly feels the mood thought '{defName}' at {found?.MoodOffset()}");
        }

        private static List<Thought> Felt(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.needs?.mood != null, $"{nickname} has no mood need");
            var list = new List<Thought>();
            pawn.needs.mood.thoughts.situational.Notify_SituationalThoughtsDirty();
            pawn.needs.mood.thoughts.GetAllMoodThoughts(list);
            return list.Where(t => Math.Abs(t.MoodOffset()) > 0.0001f).ToList();
        }

        private static StatDef Stat(PickleContext ctx, string statName)
        {
            StatDef stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, $"no StatDef named '{statName}'");
            return stat;
        }

        private static float Remembered(PickleContext ctx, Pawn pawn, StatDef stat, string nickname, string statName)
        {
            ctx.Require(
                StatBaseline.TryGetValue((pawn, stat), out float before),
                $"no remembered value for {nickname}'s {statName}: use 'I remember ...'s stat' first");
            return before;
        }

        private static float Uncached(Pawn pawn, StatDef stat)
        {
            return stat.Worker.GetValue(StatRequest.For(pawn), true);
        }
    }
}
