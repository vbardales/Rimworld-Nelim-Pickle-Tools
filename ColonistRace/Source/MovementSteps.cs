using System;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using UnityEngine;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A diagnostic for a pawn that does not walk (RimWorld 1.7 under Pickle PR 63: a vanilla Goto job closes in on nothing). It watches one colonist
    /// for a number of real seconds and logs, every 5 s, where it is, what it does and what the pather holds, with the game tick against the wall
    /// clock, so "does not move", "moves slowly" and "ticks do not run" are told apart. Written 2026-10-18 for AnimaSong's control scenario. Not played.
    /// </summary>
    [PickleSteps]
    public class MovementSteps
    {
        /// <summary>
        /// Logs the colonist every 5 real seconds for the given number of seconds, the first line at once (lines starting <c>[walk]</c>): wall seconds since
        /// the step began, game tick and ticks gained since the step began, game speed, cell, job def and its target, pather moving, next cell, nodes
        /// left in the path, distance to the pather's destination. Never fails on a verdict, only when the colonist is unknown or seconds is not 5 to 600.
        /// </summary>
        [Given("Nelim's Pickle Tools: the movement of the colonist {string} is logged for {int} seconds", TimeoutSeconds = 700f)]
        public async Task LogMovement(PickleContext ctx, string nickname, int seconds)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(seconds >= 5 && seconds <= 600, "seconds run from 5 to 600");
            float start = Time.realtimeSinceStartup;
            int tick0 = Find.TickManager.TicksGame;
            for (int sample = 0; ; sample++)
            {
                Log.Message("[walk] " + Describe(pawn, nickname, Time.realtimeSinceStartup - start, tick0));
                if (Time.realtimeSinceStartup - start >= seconds)
                {
                    break;
                }

                float next = start + (sample + 1) * 5f;
                await ctx.WaitUntil(() => Time.realtimeSinceStartup >= next, 10f);
            }
        }

        private static string Describe(Pawn pawn, string nickname, float wall, int tick0)
        {
            string path;
            try
            {
                Pawn_PathFollower pather = pawn.pather;
                path = $"moving {pather.Moving}, next cell {pather.nextCell}, nodes left {pather.curPath?.NodesLeftCount.ToString() ?? "no path"}, destination {pather.Destination.Cell}, "
                    + $"distance to it {(pather.Destination.IsValid ? (pawn.Position - pather.Destination.Cell).LengthHorizontal.ToString("0.0") : "n/a")}";
            }
            catch (Exception e)
            {
                path = "pather unreadable: " + e.GetType().Name;
            }

            Job job = pawn.CurJob;
            return $"{nickname} wall {wall:0.0} s, tick {Find.TickManager.TicksGame} (+{Find.TickManager.TicksGame - tick0}), speed {Find.TickManager.CurTimeSpeed}, "
                + $"cell {pawn.Position}, job {job?.def.defName ?? "none"} -> {job?.targetA.ToString() ?? "-"}, {path}";
        }
    }
}
