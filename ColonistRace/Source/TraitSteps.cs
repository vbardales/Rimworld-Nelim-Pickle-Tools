using System;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps on the traits of a colonist and on the text of a trait def. Written 2026-10-28 for PreciousStonesAndJewelryRenew (thoughts that depend on
    /// Greedy, Jealous or Ascetic, and a description a mod appends to). NOT PLAYED when written: compiled only.
    /// </summary>
    [PickleSteps]
    public class TraitSteps
    {
        private static TraitDef Trait(PickleContext ctx, string traitName)
        {
            TraitDef def = DefDatabase<TraitDef>.GetNamedSilentFail(traitName);
            ctx.Require(def != null, $"no trait '{traitName}' in this game; the traits are {string.Join(", ", DefDatabase<TraitDef>.AllDefsListForReading.Select(d => d.defName))}");
            return def;
        }

        // The traits a colonist had before a step changed them, put back after the scenario so a saved colonist reacquired by name is unchanged.
        private static readonly System.Collections.Generic.Dictionary<Pawn, System.Collections.Generic.List<(TraitDef Def, int Degree)>> Original =
            new System.Collections.Generic.Dictionary<Pawn, System.Collections.Generic.List<(TraitDef, int)>>();

        private static void Remember(Pawn pawn)
        {
            if (!Original.ContainsKey(pawn)) Original[pawn] = pawn.story.traits.allTraits.Select(t => (t.def, t.Degree)).ToList();
        }

        [AfterScenario]
        public void RestoreTraits()
        {
            foreach (var pair in Original.ToList())
            {
                Pawn pawn = pair.Key;
                if (pawn.Destroyed || pawn.story?.traits == null) continue;
                foreach (Trait t in pawn.story.traits.allTraits.ToList()) pawn.story.traits.RemoveTrait(t);
                foreach (var (def, degree) in pair.Value) pawn.story.traits.GainTrait(new Trait(def, degree, true), true);
            }

            Original.Clear();
        }

        /// <summary>
        /// Gives a colonist a trait by <c>TraitDef</c> name, at its first degree, and removes the traits that conflict with it first (Greedy replaces
        /// Ascetic). Does nothing when the colonist already has it. Reads it back. The colonist's own traits come back after the scenario.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} has the trait {string}")]
        public void GivesTrait(PickleContext ctx, string nickname, string traitName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story?.traits != null, $"pawn '{nickname}' has no traits");
            TraitDef def = Trait(ctx, traitName);
            Remember(pawn);
            if (pawn.story.traits.HasTrait(def)) return;
            foreach (Trait t in pawn.story.traits.allTraits.Where(x => def.conflictingTraits != null && def.conflictingTraits.Contains(x.def)).ToList())
                pawn.story.traits.RemoveTrait(t);
            pawn.story.traits.GainTrait(new Trait(def, def.degreeDatas[0].degree, true), true);
            ctx.Assert(pawn.story.traits.HasTrait(def), $"{nickname} should have the trait {traitName}; it has {string.Join(", ", pawn.story.traits.allTraits.Select(t => t.def.defName))}");
        }

        /// <summary>Takes a trait off a colonist by <c>TraitDef</c> name; does nothing when it has none. Reads it back.</summary>
        [Given("Nelim's Pickle Tools: {string} has no trait {string}")]
        public void RemovesTrait(PickleContext ctx, string nickname, string traitName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story?.traits != null, $"pawn '{nickname}' has no traits");
            TraitDef def = Trait(ctx, traitName);
            Remember(pawn);
            foreach (Trait t in pawn.story.traits.allTraits.Where(x => x.def == def).ToList())
                pawn.story.traits.RemoveTrait(t);
            ctx.Assert(!pawn.story.traits.HasTrait(def), $"{nickname} should not have the trait {traitName}; it still has it");
        }

        /// <summary>
        /// Asserts the description of a trait def (the text of its first degree, as the game loads it with the active language and the mods' patches
        /// and translations) contains the text, ignoring case. The failure prints the description.
        /// </summary>
        [Then("Nelim's Pickle Tools: the trait {string} description contains {string}")]
        public void DescriptionContains(PickleContext ctx, string traitName, string text)
        {
            string description = Description(ctx, traitName);
            ctx.Assert(description.IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0, $"the description of the trait {traitName} should contain \"{text}\"; it is \"{description}\"");
        }

        /// <summary>The same, asserting the description equals the text (ignoring case).</summary>
        [Then("Nelim's Pickle Tools: the trait {string} description reads {string}")]
        public void DescriptionReads(PickleContext ctx, string traitName, string text)
        {
            string description = Description(ctx, traitName);
            ctx.Assert(string.Equals(description, text, StringComparison.OrdinalIgnoreCase), $"the description of the trait {traitName} should read \"{text}\"; it is \"{description}\"");
        }

        private static string Description(PickleContext ctx, string traitName)
        {
            TraitDef def = Trait(ctx, traitName);
            ctx.Require(def.degreeDatas != null && def.degreeDatas.Count > 0, $"the trait {traitName} has no degree");
            string description = def.degreeDatas[0].description ?? "";
            Log.Message($"[trait] {traitName} description: \"{description}\"");
            return description;
        }
    }
}
