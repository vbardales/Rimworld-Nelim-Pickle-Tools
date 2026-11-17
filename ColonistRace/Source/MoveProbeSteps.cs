using RimWorks.Pickle;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A probe of what a colonist is doing and whether she moves, written 2026-11-17 for CrystalBall (a pawn holds a job but does not walk): position, the pather (moving, destination, next
    /// cell), the job (def, targets, toil index and count), and the conditions that keep a pawn still. Written to the log and attached to the step in the report. Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class MoveProbeSteps
    {
        /// <summary>
        /// Writes <c>[move-probe]</c> for a colonist: cell, spawned, downed, drafted, mental state, the pather (<c>Moving</c>, <c>Destination</c>, <c>nextCell</c>), the current job (def, target A and B, player
        /// forced) and its driver (toil index, toil count, current toil label). Call it before and after "the game is advanced by N ticks" to see whether the cell or the toil changed.
        /// </summary>
        [When("Nelim's Pickle Tools: the movement of {string} is written to the log")]
        public void LogMovement(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Job job = pawn.CurJob;
            JobDriver driver = pawn.jobs?.curDriver;
            string toil = "none";
            if (driver != null)
            {
                int index = driver.CurToilIndex;
                var toils = driver.GetType().GetField("toils", System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Instance)?.GetValue(driver) as System.Collections.Generic.List<Toil>;
                toil = $"index {index} of {toils?.Count.ToString() ?? "?"}" + (toils != null && index >= 0 && index < toils.Count ? $", defaultCompleteMode {toils[index].defaultCompleteMode}" : "");
            }

            string text = $"{nickname} at ({pawn.Position.x}, {pawn.Position.z}); spawned={pawn.Spawned} downed={pawn.Downed} drafted={pawn.Drafted} mentalState={pawn.MentalStateDef?.defName ?? "none"} " +
                          $"pather: moving={pawn.pather?.Moving} destination={pawn.pather?.Destination} ; job={job?.def.defName ?? "none"} targetA={job?.targetA} targetB={job?.targetB} playerForced={job?.playerForced} ; toil {toil}; " +
                          $"tick {Find.TickManager.TicksGame}";
            Log.Message($"[move-probe] {text}");
            ctx.Attach("movement of " + nickname, text);
        }
    }
}
