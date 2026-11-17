using System.Diagnostics;
using System.Linq;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A fast-forward: runs game ticks in a loop on the main thread, as fast as the machine allows, instead of waiting for the game speed to pass them
    /// (about 18 ticks a second on the 1.7 server lane, so a game day of 60 000 ticks takes over 55 minutes at the fastest speed). Written 2026-11-13 for BurnBarrel
    /// (04-pollution, one game day). Played 2026-11-17 on the 1.7 lane by ACBaGE (drought scenario, 3600 ticks in 114.6 s, about 31 ticks a second; the same wait without this step: 354 ticks in 401.9 s, red).
    /// </summary>
    [PickleSteps]
    public class TickSteps
    {
        /// <summary>
        /// A pawn is drawn from a smoothed position (PawnTweener) that follows its cell frame by frame: after many ticks run without frames it still draws the pawn where it was (CrB, 2026-11-17: the pawn
        /// had walked six cells in the logic and was drawn in the door frame). Snaps every spawned pawn of the current map to where it stands.
        /// </summary>
        internal static void SnapPawnDrawPositions()
        {
            Map map = Find.CurrentMap;
            if (map == null) return;
            foreach (Pawn pawn in map.mapPawns.AllPawnsSpawned.ToList())
                pawn.Drawer?.tweener?.ResetTweenedPosToRoot();
        }

        /// <summary>
        /// Advances the game by a number of ticks at once: each frame runs ticks (<c>TickManager.DoSingleTick</c>, the game's own tick: map, pawns, things,
        /// processors) for about 40 ms, then lets the frame draw, until the count is done. The game speed and the pause are left as they are. Logs
        /// <c>[ticks-advanced]</c> with the ticks done and the seconds taken. Fails, saying how many ticks were done, when 280 seconds pass first.
        /// </summary>
        [When("Nelim's Pickle Tools: the game is advanced by {int} ticks", TimeoutSeconds = 295f)]
        public async System.Threading.Tasks.Task AdvanceTicks(PickleContext ctx, int ticks)
        {
            // Ticks touch the pawn lists, which the game reads on the main thread only (1.7 asserts it): a step can start elsewhere, as Pickle's own wait step does (BurnBarrel, 2026-11-13).
            await LookSteps.OnMainThread(ctx);
            ctx.Require(ticks > 0, "the number of ticks must be above 0");
            ctx.Require(Current.ProgramState == ProgramState.Playing && Find.TickManager != null, "no game is playing");
            int start = Find.TickManager.TicksGame;
            var clock = Stopwatch.StartNew();
            while (Find.TickManager.TicksGame - start < ticks && clock.Elapsed.TotalSeconds < 280)
            {
                await LookSteps.OnMainThread(ctx);
                var slice = Stopwatch.StartNew();
                while (Find.TickManager.TicksGame - start < ticks && slice.ElapsedMilliseconds < 40) Find.TickManager.DoSingleTick();
                await ctx.WaitFrames(1);
            }

            // The last frame wait may resume on another thread; the next step of the scenario runs from here, so hand the step back on the main thread (ACBaGE births, 2026-11-17: 'map pawns off main thread' after a batch).
            await LookSteps.OnMainThread(ctx);
            SnapPawnDrawPositions();
            int done = Find.TickManager.TicksGame - start;
            Log.Message($"[ticks-advanced] {done} of {ticks} ticks in {clock.Elapsed.TotalSeconds:0.0} s");
            ctx.Assert(done >= ticks, $"only {done} of {ticks} ticks were run in {clock.Elapsed.TotalSeconds:0} s");
        }
    }
}
