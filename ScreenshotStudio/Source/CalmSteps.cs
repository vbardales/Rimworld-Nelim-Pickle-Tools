using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Stops a colonist from fleeing, for a capture. Written 2026-11-09 for AnimalArk shot 12: Nelim stood in the job FleeAndCower beside tamed
    /// monsters and the game drew its red "!" over her. That job comes from the hostility response of the colonist (the in-game button
    /// "Hostility response": ignore, attack, flee); this step sets it to Ignore, the same setting a player clicks, and ends a flee job already running.
    /// Compiled, not played.
    /// </summary>
    [PickleSteps]
    public class CalmSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";

        private static Pawn FindColonist(PickleContext ctx, string name)
        {
            Pawn pawn = PawnsFinder.AllMaps_FreeColonists.FirstOrDefault(p => p.Name != null
                && (string.Equals(p.Name.ToStringShort, name, System.StringComparison.OrdinalIgnoreCase)
                    || string.Equals(p.LabelShort, name, System.StringComparison.OrdinalIgnoreCase)));
            ctx.Require(pawn != null, "no colonist named '" + name + "'");
            return pawn;
        }

        /// <summary>
        /// Sets the hostility response of a colonist to Ignore (as the button of the colonist bar) and ends the job FleeAndCower or Flee when she is
        /// in it, so she stays where she stands and no flee icon is drawn. Runs once: put it after the colonist is placed.
        /// </summary>
        [Given(Prefix + "the colonist {string} does not flee from hostile pawns")]
        public void NoFlee(PickleContext ctx, string name)
        {
            Pawn pawn = FindColonist(ctx, name);
            ctx.Require(pawn.playerSettings != null, name + " has no player settings");
            pawn.playerSettings.hostilityResponse = HostilityResponseMode.Ignore;
            string job = pawn.CurJob?.def.defName;
            if (job == "FleeAndCower" || job == "Flee")
            {
                pawn.jobs.EndCurrentJob(JobCondition.InterruptForced);
            }
            Log.Message("[calm] " + name + ": hostility response Ignore, job was " + (job ?? "none"));
        }
    }
}
