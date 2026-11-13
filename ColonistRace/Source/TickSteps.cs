using System.Diagnostics;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A fast-forward: runs game ticks in a loop on the main thread, as fast as the machine allows, instead of waiting for the game speed to pass them
    /// (about 18 ticks a second on the 1.7 server lane, so a game day of 60 000 ticks takes over 55 minutes at the fastest speed). Written 2026-11-13 for BurnBarrel
    /// (04-pollution, one game day). NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class TickSteps
    {
        /// <summary>
        /// Advances the game by a number of ticks at once: each frame runs ticks (<c>TickManager.DoSingleTick</c>, the game's own tick: map, pawns, things,
        /// processors) for about 40 ms, then lets the frame draw, until the count is done. The game speed and the pause are left as they are. Logs
        /// <c>[ticks-advanced]</c> with the ticks done and the seconds taken. Fails, saying how many ticks were done, when 280 seconds pass first.
        /// </summary>
        [When("Nelim's Pickle Tools: the game is advanced by {int} ticks", TimeoutSeconds = 295f)]
        public async System.Threading.Tasks.Task AdvanceTicks(PickleContext ctx, int ticks)
        {
            ctx.Require(ticks > 0, "the number of ticks must be above 0");
            ctx.Require(Current.ProgramState == ProgramState.Playing && Find.TickManager != null, "no game is playing");
            int start = Find.TickManager.TicksGame;
            var clock = Stopwatch.StartNew();
            while (Find.TickManager.TicksGame - start < ticks && clock.Elapsed.TotalSeconds < 280)
            {
                var slice = Stopwatch.StartNew();
                while (Find.TickManager.TicksGame - start < ticks && slice.ElapsedMilliseconds < 40) Find.TickManager.DoSingleTick();
                await ctx.WaitFrames(1);
            }

            int done = Find.TickManager.TicksGame - start;
            Log.Message($"[ticks-advanced] {done} of {ticks} ticks in {clock.Elapsed.TotalSeconds:0.0} s");
            ctx.Assert(done >= ticks, $"only {done} of {ticks} ticks were run in {clock.Elapsed.TotalSeconds:0} s");
        }
    }
}
