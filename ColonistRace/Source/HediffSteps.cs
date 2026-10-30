using System.Linq;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that give a colonist a whole-body hediff by def name, remove it, and check it. Asked for by NSB on 2026-10-30: Simple Trans (Expanded)
    /// gives the sex capability through hediffs (PregnancyCarry, PregnancySire, Cisgender, Transgender), not through genes.
    /// </summary>
    [PickleSteps]
    public class HediffSteps
    {
        /// <summary>
        /// Adds a hediff to the colonist, on no body part, unless it already holds one of that def. Reads it back and fails with the hediffs the
        /// pawn holds if it is missing. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} has the hediff {string}")]
        public void GiveHediff(PickleContext ctx, string nickname, string hediffName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            HediffDef def = DefDatabase<HediffDef>.GetNamedSilentFail(hediffName);
            ctx.Require(def != null, "no hediff '" + hediffName + "' (is the mod that defines it loaded in this pass?)");
            if (!pawn.health.hediffSet.hediffs.Any(h => h.def == def)) pawn.health.AddHediff(def);
            ctx.Assert(pawn.health.hediffSet.hediffs.Any(h => h.def == def),
                "pawn '" + nickname + "' does not hold the hediff '" + hediffName + "'; it holds " + HoldList(pawn));
        }

        /// <summary>Removes every hediff of that def from the colonist. Does nothing when it holds none. NOT PLAYED when written.</summary>
        [Given("Nelim's Pickle Tools: {string} loses the hediff {string}")]
        public void LoseHediff(PickleContext ctx, string nickname, string hediffName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            HediffDef def = DefDatabase<HediffDef>.GetNamedSilentFail(hediffName);
            ctx.Require(def != null, "no hediff '" + hediffName + "' (is the mod that defines it loaded in this pass?)");
            foreach (Hediff h in pawn.health.hediffSet.hediffs.Where(x => x.def == def).ToList()) pawn.health.RemoveHediff(h);
            ctx.Assert(!pawn.health.hediffSet.hediffs.Any(h => h.def == def),
                "pawn '" + nickname + "' still holds the hediff '" + hediffName + "'");
        }

        /// <summary>Asserts a colonist holds a hediff of that def; the failure lists the hediffs it holds. NOT PLAYED when written.</summary>
        [Then("Nelim's Pickle Tools: {string} holds the hediff {string}")]
        public void HoldsHediff(PickleContext ctx, string nickname, string hediffName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Assert(pawn.health.hediffSet.hediffs.Any(h => h.def.defName == hediffName),
                "pawn '" + nickname + "' does not hold the hediff '" + hediffName + "'; it holds " + HoldList(pawn));
        }

        static string HoldList(Pawn pawn) => string.Join(", ", pawn.health.hediffSet.hediffs.Select(h => h.def.defName));
    }
}
