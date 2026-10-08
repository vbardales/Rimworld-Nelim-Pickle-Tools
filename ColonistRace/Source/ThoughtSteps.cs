using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that read why a colonist looks the way it does: the thermal state (ambient temperature and comfort range) and the mood thoughts that are
    /// active, such as the heat or the "naked" ones that make Facial Animation draw sweat or a blush. Written 2026-10-08 after SanctuaryBacklot's
    /// diagnosis that the heat face persisted at a held temperature. NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class ThoughtSteps
    {
        private static List<Thought> Thoughts(Pawn pawn)
        {
            var all = new List<Thought>();
            pawn.needs?.mood?.thoughts?.GetAllMoodThoughts(all);
            return all;
        }

        /// <summary>
        /// Writes in the log, and fails with nothing, the ambient temperature of a colonist, its comfortable range and every mood thought it has
        /// now (situational ones included). To read in the report why a face shows sweat or a blush.
        /// </summary>
        [When("Nelim's Pickle Tools: the thermal state and thoughts of {string} are logged")]
        public void LogThermalState(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            FloatRange range = pawn.ComfortableTemperatureRange();
            string thoughts = string.Join(", ", Thoughts(pawn).Select(t => t.def.defName + " (" + t.MoodOffset().ToString("0.#") + ")"));
            Log.Message("[thoughts] " + nickname + ": ambient " + pawn.AmbientTemperature.ToString("0.#") + " degrees, comfortable " + range.min.ToString("0.#") + " to "
                + range.max.ToString("0.#") + ", thoughts: " + (thoughts.Length > 0 ? thoughts : "(none)"));
        }

        /// <summary>Asserts a colonist has the mood thought <c>ThoughtDef</c> now (for example <c>EnvironmentHot</c>); the failure lists the thoughts it has.</summary>
        [Then("Nelim's Pickle Tools: {string} has the thought {string}")]
        public void HasThought(PickleContext ctx, string nickname, string thoughtName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            var all = Thoughts(pawn);
            ctx.Assert(all.Any(t => t.def.defName == thoughtName), nickname + " should have the thought " + thoughtName + "; it has " + string.Join(", ", all.Select(t => t.def.defName)));
        }

        /// <summary>Asserts a colonist does NOT have the mood thought <c>ThoughtDef</c> now; the failure says it is there, with its mood offset.</summary>
        [Then("Nelim's Pickle Tools: {string} has no thought {string}")]
        public void HasNoThought(PickleContext ctx, string nickname, string thoughtName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Thought found = Thoughts(pawn).FirstOrDefault(t => t.def.defName == thoughtName);
            ctx.Assert(found == null, nickname + " should not have the thought " + thoughtName + "; it has it (mood " + found?.MoodOffset().ToString("0.#") + ", ambient " + pawn.AmbientTemperature.ToString("0.#") + " degrees)");
        }
    }
}
