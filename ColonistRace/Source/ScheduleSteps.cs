using RimWorks.Pickle;
using RimWorld;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A step that takes a colonist out of the work and sleep rhythm, so that a recreation giver is the only thing it can pick. Promoted
    /// 2026-10-12 from Anima Song's local step, for Fullzoon Cookies Renew's scenario 15. Not played here.
    /// </summary>
    [PickleSteps]
    public class ScheduleSteps
    {
        /// <summary>
        /// Sets all 24 hours of the colonist's schedule to joy, disables every work type, and ends the job in progress, so that work
        /// does not come before a recreation giver (a bored colonist went milking, 63 cells away, in an Anima Song run). The change is
        /// to the colonist's schedule and work settings, kept in a save made after it.
        /// </summary>
        [Given("Nelim's Pickle Tools: the schedule of {string} is joy all day")]
        public void ScheduleJoy(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Assert(pawn.timetable != null, $"{nickname} has no schedule");
            for (int hour = 0; hour < 24; hour++)
            {
                pawn.timetable.SetAssignment(hour, TimeAssignmentDefOf.Joy);
            }

            if (pawn.workSettings != null)
            {
                foreach (WorkTypeDef work in DefDatabase<WorkTypeDef>.AllDefs)
                {
                    pawn.workSettings.Disable(work);
                }
            }

            pawn.jobs.EndCurrentJob(JobCondition.InterruptForced);
        }
    }
}
