using System;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Sets the backstories of a colonist by BackstoryDef defName, so a scenario that needs a colonist able to do some work (an artistic
    /// pawn to play music, a doctor) does not depend on the random backstory the colonist was generated with. A backstory carries work tag
    /// restrictions (Artistic, Violent, Caring...) that no work setting overrides. Written 2026-11-18 for EponaInstrumentsRenew
    /// (Miel, Soren: the music joy gave no job, WorkTagIsDisabled(Artistic)). Compiled, NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class BackstorySteps
    {
        /// <summary>Gives the colonist this childhood backstory (a BackstoryDef of slot Childhood), then refreshes the work restrictions it carries.</summary>
        [Given("Nelim's Pickle Tools: {string} childhood is {string}")]
        public void SetChildhood(PickleContext ctx, string nickname, string backstoryDefName) => Set(ctx, nickname, backstoryDefName, BackstorySlot.Childhood);

        /// <summary>Gives the colonist this adulthood backstory (a BackstoryDef of slot Adulthood), then refreshes the work restrictions it carries.</summary>
        [Given("Nelim's Pickle Tools: {string} adulthood is {string}")]
        public void SetAdulthood(PickleContext ctx, string nickname, string backstoryDefName) => Set(ctx, nickname, backstoryDefName, BackstorySlot.Adulthood);

        /// <summary>Removes both backstories of the colonist, so no backstory restricts its work (a colonist without backstory has no disabled work tag from it).</summary>
        [Given("Nelim's Pickle Tools: {string} has no backstory")]
        public void ClearBackstories(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story tracker");
            pawn.story.Childhood = null;
            pawn.story.Adulthood = null;
            Refresh(pawn);
            ctx.Assert(
                pawn.story.Childhood == null && pawn.story.Adulthood == null,
                $"{nickname} should have no backstory; it has {Describe(pawn)}");
        }

        private static void Set(PickleContext ctx, string nickname, string defName, BackstorySlot slot)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story tracker");
            BackstoryDef def = DefDatabase<BackstoryDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no BackstoryDef named '{defName}' in this game");
            ctx.Require(def.slot == slot, $"'{defName}' is a {def.slot} backstory, not a {slot} one");

            if (slot == BackstorySlot.Childhood)
            {
                pawn.story.Childhood = def;
            }
            else
            {
                pawn.story.Adulthood = def;
            }

            Refresh(pawn);
            BackstoryDef read = slot == BackstorySlot.Childhood ? pawn.story.Childhood : pawn.story.Adulthood;
            ctx.Assert(read == def, $"{nickname} should have the {slot} backstory '{defName}'; it has {Describe(pawn)}");
        }

        // The game caches the disabled work tags and skills of a pawn; both caches are told to recompute.
        private static void Refresh(Pawn pawn)
        {
            pawn.Notify_DisabledWorkTypesChanged();
            pawn.skills?.Notify_SkillDisablesChanged();
        }

        private static string Describe(Pawn pawn)
        {
            return $"childhood {pawn.story.Childhood?.defName ?? "(none)"}, adulthood {pawn.story.Adulthood?.defName ?? "(none)"}";
        }
    }
}
