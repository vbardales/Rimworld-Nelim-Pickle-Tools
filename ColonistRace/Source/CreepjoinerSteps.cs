using System;
using System.Linq;
using RimWorld;
using RimWorld.QuestGen;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that fire the real Anomaly creepjoiner arrival quest for a chosen CreepJoinerFormKindDef and read the letter it sends (label and text, in the
    /// language the game runs in). Written 2026-10-28 for Seren Biotech Extended scenario 12. NOT PLAYED when written. The quest is found by name
    /// (a QuestScriptDef whose defName holds "creepjoiner", diagnostic when none or several); the letter is the newest one in the letter stack.
    /// </summary>
    [PickleSteps]
    public class CreepjoinerSteps
    {
        private static Pawn lastPawn;
        private static string lastLabel;
        private static string lastText;

        [When("Nelim's Pickle Tools: I trigger the creepjoiner arrival of the kind {string}")]
        public void Trigger(PickleContext ctx, string formDefName)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            CreepJoinerFormKindDef form = DefDatabase<CreepJoinerFormKindDef>.GetNamedSilentFail(formDefName);
            ctx.Require(form != null, $"no CreepJoinerFormKindDef '{formDefName}' (Anomaly active?); the kinds are " + string.Join(", ", DefDatabase<CreepJoinerFormKindDef>.AllDefsListForReading.Select(d => d.defName)));
            var scripts = DefDatabase<QuestScriptDef>.AllDefsListForReading.Where(d => d.defName.IndexOf("creepjoiner", StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            QuestScriptDef script = scripts.FirstOrDefault(d => d.defName.IndexOf("arrival", StringComparison.OrdinalIgnoreCase) >= 0) ?? (scripts.Count == 1 ? scripts[0] : null);
            ctx.Require(script != null, "no single creepjoiner QuestScriptDef; candidates: " + string.Join(", ", scripts.Select(d => d.defName)));

            CreepJoinerBenefitDef benefit = null; CreepJoinerDownsideDef downside = null; CreepJoinerAggressiveDef aggressive = null; CreepJoinerRejectionDef rejection = null;
            CreepJoinerUtility.GetCreepjoinerSpecifics(map, ref form, ref benefit, ref downside, ref aggressive, ref rejection);
            var slate = new Slate();
            slate.Set("map", map);
            slate.Set("points", StorytellerUtility.DefaultThreatPointsNow(map));
            slate.Set("form", form);
            slate.Set("benefit", benefit);
            slate.Set("downside", downside);
            slate.Set("aggressive", aggressive);
            slate.Set("rejection", rejection);

            int before = Find.LetterStack.LettersListForReading.Count;
            Quest quest = QuestUtility.GenerateQuestAndMakeAvailable(script, slate);
            ctx.Require(quest != null, $"quest {script.defName} did not generate");
            var letters = Find.LetterStack.LettersListForReading;
            ctx.Require(letters.Count > before, $"quest {script.defName} sent no letter");
            Letter letter = letters.Last();
            lastLabel = letter.Label.ToString();
            lastText = (letter as ChoiceLetter)?.Text.ToString();
            ctx.Require(lastText != null, $"the letter is a {letter.GetType().Name}, not a ChoiceLetter: no text to read");
            lastPawn = Find.CurrentMap.mapPawns.AllPawnsSpawned.LastOrDefault(p => p.creepjoiner != null && p.creepjoiner.form == form);
            ctx.Require(lastPawn != null, $"no spawned pawn of the kind {formDefName} after the quest");
        }

        /// <summary>
        /// Sets the arrived pawn's gender (Male, Female or None) and rebuilds the letter text the way the quest does (the form's letterLabel and the
        /// appended sentence, both formatted with the pawn), so the pronouns and agreements of that gender can be read.
        /// </summary>
        [When("Nelim's Pickle Tools: the arrived creepjoiner is made {word} and the letter is read again")]
        public void RegenderAndReread(PickleContext ctx, string gender)
        {
            ctx.Require(lastPawn != null, "no creepjoiner has arrived in this scenario");
            ctx.Require(Enum.TryParse(gender, true, out Gender g), $"'{gender}' is not a Gender (Male, Female, None)");
            lastPawn.gender = g;
            lastLabel = lastPawn.GetKindLabelSingular().CapitalizeFirst();
            lastText = lastPawn.creepjoiner.form.letterLabel.Formatted(lastPawn.Named("PAWN")).ToString() + "\n\n" + "LetterCreeperAppearedAppended".Translate(lastPawn.Named("PAWN")).CapitalizeFirst().ToString();
        }

        [Then("Nelim's Pickle Tools: the creepjoiner letter text contains {string}")]
        public void TextContains(PickleContext ctx, string part)
        {
            ctx.Require(lastText != null, "no creepjoiner letter was read");
            ctx.Assert(lastText.IndexOf(part, StringComparison.OrdinalIgnoreCase) >= 0, $"the letter text does not contain '{part}': {lastText}");
        }

        [Then("Nelim's Pickle Tools: the creepjoiner letter text does not contain {string}")]
        public void TextLacks(PickleContext ctx, string part)
        {
            ctx.Require(lastText != null, "no creepjoiner letter was read");
            ctx.Assert(lastText.IndexOf(part, StringComparison.OrdinalIgnoreCase) < 0, $"the letter text contains '{part}': {lastText}");
        }

        [Then("Nelim's Pickle Tools: the creepjoiner letter label contains {string}")]
        public void LabelContains(PickleContext ctx, string part)
        {
            ctx.Require(lastLabel != null, "no creepjoiner letter was read");
            ctx.Assert(lastLabel.IndexOf(part, StringComparison.OrdinalIgnoreCase) >= 0, $"the letter label does not contain '{part}': {lastLabel}");
        }

        /// <summary>No raw translation key, no unresolved {PAWN_...} token, no empty label or text, in the letter as read.</summary>
        [Then("Nelim's Pickle Tools: the creepjoiner letter is fully resolved")]
        public void Resolved(PickleContext ctx)
        {
            ctx.Require(lastText != null && lastLabel != null, "no creepjoiner letter was read");
            ctx.Assert(!string.IsNullOrWhiteSpace(lastLabel) && !string.IsNullOrWhiteSpace(lastText), $"empty letter: label '{lastLabel}', text '{lastText}'");
            foreach (string bad in new[] { "PAWN_", "{", "}", "LetterCreeperAppearedAppended", "(missing", "Translation missing" })
                ctx.Assert(lastText.IndexOf(bad, StringComparison.Ordinal) < 0 && lastLabel.IndexOf(bad, StringComparison.Ordinal) < 0, $"the letter holds '{bad}': label '{lastLabel}', text '{lastText}'");
        }
    }
}
