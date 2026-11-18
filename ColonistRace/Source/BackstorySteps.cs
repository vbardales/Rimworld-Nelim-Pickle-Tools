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
            Assign(pawn, BackstorySlot.Childhood, null);
            Assign(pawn, BackstorySlot.Adulthood, null);
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

            Assign(pawn, slot, def);
            Refresh(pawn);
            BackstoryDef read = slot == BackstorySlot.Childhood ? pawn.story.Childhood : pawn.story.Adulthood;
            ctx.Assert(read == def, $"{nickname} should have the {slot} backstory '{defName}'; it has {Describe(pawn)}");
        }

        // The property setter of the game can throw for a null or a pawn without the usual trackers (ticket f08b: a NullReferenceException on 'has no backstory'):
        // the field is then set by reflection, which skips whatever the setter does with the old value.
        private static void Assign(Pawn pawn, BackstorySlot slot, BackstoryDef def)
        {
            try
            {
                if (slot == BackstorySlot.Childhood) pawn.story.Childhood = def; else pawn.story.Adulthood = def;
            }
            catch (Exception e) when (e is NullReferenceException)
            {
                string field = slot == BackstorySlot.Childhood ? "childhood" : "adulthood";
                System.Reflection.FieldInfo info = typeof(Pawn_StoryTracker).GetField(field, System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public);
                if (info == null) throw;
                info.SetValue(pawn.story, def);
                Log.Warning("[backstory] the setter of " + field + " threw a NullReferenceException; the field was set directly");
            }
        }

        // The game caches the disabled work tags and skills of a pawn; both caches are told to recompute. A refresh that throws does not fail the step:
        // the read-back below says whether the backstory is the wanted one, and the work restriction is read from the backstory itself.
        private static void Refresh(Pawn pawn)
        {
            try { pawn.Notify_DisabledWorkTypesChanged(); }
            catch (Exception e) { Log.Warning("[backstory] Notify_DisabledWorkTypesChanged threw " + e.GetType().Name + ": " + e.Message); }
            try { pawn.skills?.Notify_SkillDisablesChanged(); }
            catch (Exception e) { Log.Warning("[backstory] Notify_SkillDisablesChanged threw " + e.GetType().Name + ": " + e.Message); }
        }

        private static string Describe(Pawn pawn)
        {
            return $"childhood {pawn.story.Childhood?.defName ?? "(none)"}, adulthood {pawn.story.Adulthood?.defName ?? "(none)"}";
        }
    }
}
