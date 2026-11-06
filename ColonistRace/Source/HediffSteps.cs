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

        /// <summary>
        /// Adds a hediff to ONE body part of the colonist (a wound: Cut, Scratch, Bruise, Burn...), found by its label ("left arm", "right hand", "neck", case insensitive) or by its def name.
        /// A wound def (an injury) is given severity 2 unless a value is asked; the part must be one the pawn still has. Written 2026-11-06 for APerfectMindInAPerfectBody (a cut on a forearm).
        /// NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} has the hediff {string} on the {string}")]
        public void GiveHediffOnPart(PickleContext ctx, string nickname, string hediffName, string partName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            HediffDef def = DefDatabase<HediffDef>.GetNamedSilentFail(hediffName);
            ctx.Require(def != null, "no hediff '" + hediffName + "' (is the mod that defines it loaded in this pass?)");
            BodyPartRecord part = pawn.RaceProps.body.AllParts.FirstOrDefault(p => string.Equals(p.Label, partName, System.StringComparison.OrdinalIgnoreCase) || string.Equals(p.def.defName, partName, System.StringComparison.OrdinalIgnoreCase));
            ctx.Require(part != null, "pawn '" + nickname + "' has no body part '" + partName + "'; it has " + string.Join(", ", pawn.RaceProps.body.AllParts.Select(p => p.Label).Distinct()));
            Hediff hediff = HediffMaker.MakeHediff(def, pawn, part);
            if (hediff is Hediff_Injury) hediff.Severity = 2f;
            pawn.health.AddHediff(hediff, part);
            ctx.Assert(pawn.health.hediffSet.hediffs.Any(h => h.def == def && h.Part == part),
                "pawn '" + nickname + "' does not hold the hediff '" + hediffName + "' on the " + partName + "; it holds " + HoldList(pawn));
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
