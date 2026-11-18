using System.Collections.Generic;
using RimWorks.Pickle;
using RimWorld;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps for a mod that may refuse a player's order (a Harmony prefix on <c>Pawn_JobTracker.TryTakeOrderedJob</c>), written 2026-11-17 for
    /// BetweenSus: the mood of a colonist is set, a Goto order is given many times, and the number of refusals is asserted in a range (the
    /// refusal is random, so a count, never one try). Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class OrderSteps
    {
        private static readonly Dictionary<Pawn, (int accepted, int refused)> OrderCounts = new Dictionary<Pawn, (int, int)>();

        /// <summary>
        /// Sets the mood level (0 to 1) of a colonist. It is not held: the game moves the mood back toward its thoughts as ticks pass, so the
        /// step goes right before the orders; a scenario loads its own save, so nothing needs restoring.
        /// </summary>
        [Given("Nelim's Pickle Tools: the mood of {string} is set to {float}")]
        public void SetMood(PickleContext ctx, string nickname, float level)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.needs?.mood != null, $"{nickname} has no mood need");
            ctx.Require(level >= 0f && level <= 1f, $"the mood level {level} is outside 0 to 1");
            pawn.needs.mood.CurLevel = level;
            Log.Message($"[mood-set] {nickname}: {pawn.needs.mood.CurLevel:0.000}");
        }

        /// <summary>
        /// Gives a colonist a Goto order to a cell, N times in a row, the way a player's right click does
        /// (<c>pawn.jobs.TryTakeOrderedJob</c>, tag Misc). The job is stopped between two orders so a refusal never keeps the job of the order
        /// before. Counts accepted and refused orders and logs <c>[order-count] accepted=A refused=R</c>.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is ordered to go to \\({int}, {int}\\) {int} times")]
        public void OrderedToGo(PickleContext ctx, string nickname, int x, int z, int times)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(pawn.Spawned && pawn.jobs != null, $"{nickname} is not spawned on a map");
            ctx.Require(cell.InBounds(pawn.Map), $"the cell ({x}, {z}) is outside the map");
            ctx.Require(times > 0, "the number of orders must be above 0");

            int accepted = 0, refused = 0;
            for (int i = 0; i < times; i++)
            {
                pawn.jobs.StopAll();
                pawn.jobs.ClearQueuedJobs();
                Job job = JobMaker.MakeJob(JobDefOf.Goto, cell);
                if (pawn.jobs.TryTakeOrderedJob(job, JobTag.Misc)) accepted++; else refused++;
            }

            pawn.jobs.StopAll();
            OrderCounts[pawn] = (accepted, refused);
            Log.Message($"[order-count] accepted={accepted} refused={refused}");
        }

        /// <summary>Asserts the refused orders of the last "is ordered to go" step of a colonist fall in a range. The failure gives accepted and refused.</summary>
        [Then("Nelim's Pickle Tools: the orders of {string} were refused between {int} and {int} times")]
        public void RefusedBetween(PickleContext ctx, string nickname, int min, int max)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(OrderCounts.TryGetValue(pawn, out var counts), $"no orders were counted for {nickname}: add 'is ordered to go to' before");
            ctx.Assert(counts.refused >= min && counts.refused <= max,
                $"the orders of {nickname} should be refused between {min} and {max} times; accepted={counts.accepted} refused={counts.refused}");
        }

        private static readonly Dictionary<Pawn, bool> LastOrderTaken = new Dictionary<Pawn, bool>();

        /// <summary>
        /// Gives a colonist an attack order (melee) on the first thing of a def (a pawn's race def counts) standing on a cell, as a right click on it
        /// does (<c>TryTakeOrderedJob</c>, tag Misc). A mod that refuses the order shows its message: read it with
        /// <c>the last message shown contains</c> right after. Logs <c>[order-attack] taken=True|False</c>. Compiled, NOT PLAYED.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is ordered to attack the thing {string} at \\({int}, {int}\\)")]
        public void OrderedToAttack(PickleContext ctx, string nickname, string defName, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Thing target = ThingAt(ctx, pawn, defName, x, z);
            pawn.jobs.StopAll();
            pawn.jobs.ClearQueuedJobs();
            bool taken = pawn.jobs.TryTakeOrderedJob(JobMaker.MakeJob(JobDefOf.AttackMelee, target), JobTag.Misc);
            LastOrderTaken[pawn] = taken;
            Log.Message("[order-attack] " + nickname + " taken=" + taken);
        }

        /// <summary>
        /// Gives a colonist a haul order: carry the first thing of a def on a cell to another cell (<c>HaulToCell</c>, tag Misc). A refusing mod shows
        /// its message: read it with <c>the last message shown contains</c>. Logs <c>[order-haul] taken=True|False</c>. Compiled, NOT PLAYED.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is ordered to haul the thing {string} at \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void OrderedToHaul(PickleContext ctx, string nickname, string defName, int x, int z, int toX, int toZ)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Thing target = ThingAt(ctx, pawn, defName, x, z);
            var dest = new IntVec3(toX, 0, toZ);
            ctx.Require(dest.InBounds(pawn.Map), "the cell (" + toX + ", " + toZ + ") is outside the map");
            pawn.jobs.StopAll();
            pawn.jobs.ClearQueuedJobs();
            Job job = JobMaker.MakeJob(JobDefOf.HaulToCell, target, dest);
            job.count = target.stackCount;
            bool taken = pawn.jobs.TryTakeOrderedJob(job, JobTag.Misc);
            LastOrderTaken[pawn] = taken;
            Log.Message("[order-haul] " + nickname + " taken=" + taken);
        }

        /// <summary>Asserts the last attack or haul order of a colonist was refused (the game or a mod said no).</summary>
        [Then("Nelim's Pickle Tools: the last order of {string} was refused")]
        public void LastOrderRefused(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(LastOrderTaken.TryGetValue(pawn, out bool taken), "no attack or haul order was given to " + nickname);
            ctx.Assert(!taken, "the last order of " + nickname + " was taken, not refused");
        }

        /// <summary>Asserts the last attack or haul order of a colonist was taken.</summary>
        [Then("Nelim's Pickle Tools: the last order of {string} was taken")]
        public void LastOrderTakenStep(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(LastOrderTaken.TryGetValue(pawn, out bool taken), "no attack or haul order was given to " + nickname);
            ctx.Assert(taken, "the last order of " + nickname + " was refused, not taken");
        }

        private static Thing ThingAt(PickleContext ctx, Pawn pawn, string defName, int x, int z)
        {
            ctx.Require(pawn.Spawned && pawn.jobs != null, pawn.LabelShort + " is not spawned on a map");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(pawn.Map), "the cell (" + x + ", " + z + ") is outside the map");
            foreach (Thing t in cell.GetThingList(pawn.Map))
                if (t != pawn && (string.Equals(t.def.defName, defName, System.StringComparison.OrdinalIgnoreCase)
                    || (t is Pawn p && string.Equals(p.kindDef?.defName, defName, System.StringComparison.OrdinalIgnoreCase)))) return t;
            ctx.Require(false, "no thing '" + defName + "' on (" + x + ", " + z + "); the cell holds " + string.Join(", ", cell.GetThingList(pawn.Map).ConvertAll(t => t.def.defName)));
            return null;
        }
    }
}
