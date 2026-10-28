using System;
using System.Linq;
using System.Text.RegularExpressions;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.LoadAudit
{
    /// <summary>
    /// Steps that read a text the way a colonist is shown it, for the gendered French rule every mod shares (TRANSLATIONS.md, "Player
    /// choice for gendered French"): the text is resolved through <c>Formatted</c> with the colonist, so a gender switch picks that
    /// colonist's own branch. Written 2026-10-12 from the two copies in Food Court (FrenchGenderSteps) and Mechanoid Factory
    /// (FrenchChoiceSteps). The steps that SET the mode, and the settings page and shortcut steps, stay in the mods: they use the
    /// mod's own settings. Not played here.
    /// </summary>
    [PickleSteps]
    public class GenderTextSteps
    {
        // A gender switch is a placeholder of the form {NAME_gender ...}, where NAME is the symbol the text is formatted with.
        private static readonly Regex Switch = new Regex(@"\{[A-Za-z0-9]+_gender\b", RegexOptions.Compiled);

        private static Pawn Colonist(PickleContext ctx, string nickname)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "there is no current map: a save has to be loaded first");
            Pawn pawn = map.mapPawns.FreeColonists.FirstOrDefault(p => p.Name != null && p.Name.ToStringShort == nickname);
            ctx.Require(pawn != null, $"no colonist is nicknamed '{nickname}'");
            return pawn;
        }

        /// <summary>
        /// The <c>label</c> or <c>description</c> of a stage of a <c>HediffDef</c> or a <c>ThoughtDef</c>, formatted with the colonist as
        /// <c>PAWN</c>, contains the expected text. The first word is <c>hediff</c> or <c>thought</c>, the second <c>label</c> or
        /// <c>description</c> (a hediff stage has a label only).
        /// </summary>
        [Then("Nelim's Pickle Tools: the {word} {word} of the stage {int} of {string} shown to {string} reads {string}")]
        public void StageTextReads(PickleContext ctx, string kind, string field, int stage, string defName, string nickname, string expected)
        {
            Pawn pawn = Colonist(ctx, nickname);
            string raw = StageText(ctx, kind, field, defName, stage);
            ReadsAs(ctx, raw, $"{defName} stage {stage} {field}", nickname, pawn, expected);
        }

        /// <summary>The same for the text of the def itself (a hediff's or a thought's own description or label).</summary>
        [Then("Nelim's Pickle Tools: the {word} {word} of {string} shown to {string} reads {string}")]
        public void DefTextReads(PickleContext ctx, string kind, string field, string defName, string nickname, string expected)
        {
            Pawn pawn = Colonist(ctx, nickname);
            string k = kind.ToLowerInvariant();
            string f = field.ToLowerInvariant();
            ctx.Require(k == "hediff" || k == "thought", $"'{kind}' is not hediff or thought");
            ctx.Require(f == "label" || f == "description", $"'{field}' is not label or description");
            Def def = k == "hediff" ? (Def)DefDatabase<HediffDef>.GetNamedSilentFail(defName) : DefDatabase<ThoughtDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no {k} def named '{defName}' is loaded in this pass");
            ReadsAs(ctx, f == "label" ? def.label : def.description, $"{defName} {f}", nickname, pawn, expected);
        }

        /// <summary>
        /// A keyed translation, translated with the colonist as the named symbol (<c>PAWN</c>, <c>MACHINE</c>...), contains the expected text.
        /// </summary>
        [Then("Nelim's Pickle Tools: the message of the key {string} for {string} as {word} reads {string}")]
        public void KeyedReads(PickleContext ctx, string key, string nickname, string symbol, string expected)
        {
            Pawn pawn = Colonist(ctx, nickname);
            string shown = key.Translate(pawn.Named(symbol)).Resolve();
            ctx.Assert(shown.Contains(expected), $"{key} for {nickname} ({pawn.gender}): [{shown}] does not contain [{expected}]");
        }

        /// <summary>
        /// The <c>deathMessage</c> of a <c>DamageDef</c>, formatted for the colonist the way the game does when a pawn dies of that damage
        /// (<c>Pawn_HealthTracker.NotifyPlayerOfKilled</c>: <c>deathMessage.Formatted(pawn.LabelShortCap, pawn.Named("PAWN"))</c>, so both
        /// <c>{0}</c> and <c>{PAWN_gender ...}</c> resolve), contains the expected text. Set the colonist's gender first. No death happens.
        /// Written 2026-10-14 for ParaBellum. The call is the one remembered from the game's own method, not decompiled in this session. Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: the death message of the damage def {string} for {string} reads {string}")]
        public void DeathMessageReads(PickleContext ctx, string damageDefName, string nickname, string expected)
        {
            Pawn pawn = Colonist(ctx, nickname);
            DamageDef def = DefDatabase<DamageDef>.GetNamedSilentFail(damageDefName);
            ctx.Require(def != null, $"no damage def named '{damageDefName}' is loaded in this pass");
            ctx.Require(!string.IsNullOrEmpty(def.deathMessage), $"{damageDefName} has no deathMessage");
            string shown = def.deathMessage.Formatted(pawn.LabelShortCap, pawn.Named("PAWN")).Resolve();
            ctx.Assert(shown.Contains(expected), $"death message of {damageDefName} for {nickname} ({pawn.gender}): [{shown}] does not contain [{expected}]");
        }

        /// <summary>
        /// A keyed translation with no symbol (a message that names no pawn), in the language the game runs in, contains the expected text; fails
        /// when the key has no translation (the game would show the raw key). Written 2026-10-28 for Seren Biotech Extended scenario 13. Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: the translation of the key {string} reads {string}")]
        public void KeyReads(PickleContext ctx, string key, string expected)
        {
            ctx.Require(key.CanTranslate(), $"the key '{key}' has no translation in {LanguageDatabase.activeLanguage?.FriendlyNameNative}: the game would show it raw");
            string shown = key.Translate().Resolve();
            ctx.Assert(shown.Contains(expected), $"{key}: [{shown}] does not contain [{expected}]");
        }

        /// <summary>
        /// No text of the mod (labels and descriptions of its defs, of the stages of its hediffs and thoughts, and its keyed translations
        /// in the active language) still holds a gender switch. For the presentations that remove them (Inclusive, MiddleDot,
        /// Masculine): the mod's own step sets the mode first.
        /// </summary>
        [Then("Nelim's Pickle Tools: no text of the mod {string} keeps a gender switch")]
        public void NoSwitchLeft(PickleContext ctx, string packageId)
        {
            ModContentPack pack = LoadedModManager.RunningMods.FirstOrDefault(
                m => string.Equals(m.PackageId, packageId, StringComparison.OrdinalIgnoreCase) ||
                     string.Equals(m.PackageIdPlayerFacing, packageId, StringComparison.OrdinalIgnoreCase));
            ctx.Require(pack != null, $"the mod \"{packageId}\" is not loaded in this run");
            foreach (Def def in pack.AllDefs)
            {
                CheckText(ctx, def.defName + " label", def.label);
                CheckText(ctx, def.defName + " description", def.description);
                if (def is HediffDef hediff && hediff.stages != null)
                {
                    foreach (HediffStage stage in hediff.stages)
                    {
                        CheckText(ctx, hediff.defName + " stage label", stage?.label);
                    }
                }

                if (def is ThoughtDef thought && thought.stages != null)
                {
                    foreach (ThoughtStage stage in thought.stages)
                    {
                        CheckText(ctx, thought.defName + " stage label", stage?.label);
                        CheckText(ctx, thought.defName + " stage description", stage?.description);
                    }
                }
            }

            string root = pack.RootDir.Replace('\\', '/').TrimEnd('/') + "/";
            foreach (var pair in LanguageDatabase.activeLanguage.keyedReplacements)
            {
                string file = (pair.Value.fileSourceFullPath ?? string.Empty).Replace('\\', '/');
                if (file.StartsWith(root, StringComparison.OrdinalIgnoreCase))
                {
                    CheckText(ctx, "key " + pair.Key, pair.Value.value);
                }
            }
        }

        private static void CheckText(PickleContext ctx, string where, string text)
        {
            ctx.Assert(string.IsNullOrEmpty(text) || !Switch.IsMatch(text), $"{where} still holds a gender switch: {text}");
        }

        private static string StageText(PickleContext ctx, string kind, string field, string defName, int stage)
        {
            string k = kind.ToLowerInvariant();
            bool label = field.ToLowerInvariant() == "label";
            ctx.Require(label || field.ToLowerInvariant() == "description", $"'{field}' is not label or description");
            if (k == "thought")
            {
                ThoughtDef thought = DefDatabase<ThoughtDef>.GetNamedSilentFail(defName);
                ctx.Require(thought != null, $"no thought def named '{defName}' is loaded in this pass");
                ctx.Require(thought.stages != null && stage >= 0 && stage < thought.stages.Count, $"{defName} has no stage {stage}");
                return label ? thought.stages[stage].label : thought.stages[stage].description;
            }

            ctx.Require(k == "hediff", $"'{kind}' is not hediff or thought");
            HediffDef hediff = DefDatabase<HediffDef>.GetNamedSilentFail(defName);
            ctx.Require(hediff != null, $"no hediff def named '{defName}' is loaded in this pass");
            ctx.Require(label, "a hediff stage has a label only");
            ctx.Require(hediff.stages != null && stage >= 0 && stage < hediff.stages.Count, $"{defName} has no stage {stage}");
            return hediff.stages[stage].label;
        }

        private static void ReadsAs(PickleContext ctx, string raw, string what, string nickname, Pawn pawn, string expected)
        {
            ctx.Require(raw != null, $"{what} is empty");
            string shown = raw.Formatted(pawn.Named("PAWN")).Resolve();
            ctx.Assert(shown.Contains(expected), $"{what} shown to {nickname} ({pawn.gender}): [{shown}] does not contain [{expected}]");
        }
    }
}
