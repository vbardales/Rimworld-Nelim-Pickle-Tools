using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps for a recreation mod, written 2026-11-10 for RetroJoyRenew: the joy need, the joy tolerance of a kind and the experience of a skill
    /// are remembered, then compared after a joy job ran; a colonist is downed in a bed; an Architect tab shows a def only once its research is
    /// done. Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class JoyAndDownedSteps
    {
        private static readonly Dictionary<Pawn, float> JoyBaseline = new Dictionary<Pawn, float>();
        private static readonly Dictionary<(Pawn, JoyKindDef), float> ToleranceBaseline = new Dictionary<(Pawn, JoyKindDef), float>();
        private static readonly Dictionary<(Pawn, SkillDef), double> SkillBaseline = new Dictionary<(Pawn, SkillDef), double>();

        /// <summary>Remembers the level of the joy need (0 to 1) of a colonist.</summary>
        [When("Nelim's Pickle Tools: I remember {string}'s joy level")]
        public void RememberJoy(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.needs?.joy != null, $"{nickname} has no joy need");
            JoyBaseline[pawn] = pawn.needs.joy.CurLevel;
        }

        /// <summary>The joy need is higher than the remembered level (it fails when nothing was remembered).</summary>
        [Then("Nelim's Pickle Tools: {string}'s joy level is higher than remembered")]
        public void JoyRose(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(JoyBaseline.TryGetValue(pawn, out float before), $"no joy level was remembered for {nickname}: add 'I remember {nickname}'s joy level' before the action");
            float after = pawn.needs.joy.CurLevel;
            ctx.Assert(after > before, $"{nickname}'s joy level went from {before:0.000} to {after:0.000}: it did not rise");
        }

        /// <summary>Remembers the joy tolerance (0 to 1, higher is more used up) of a colonist for a JoyKindDef, by defName.</summary>
        [When("Nelim's Pickle Tools: I remember {string}'s joy tolerance for the kind {string}")]
        public void RememberTolerance(PickleContext ctx, string nickname, string kindName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            JoyKindDef kind = Kind(ctx, kindName);
            ctx.Require(pawn.needs?.joy != null, $"{nickname} has no joy need");
            ToleranceBaseline[(pawn, kind)] = pawn.needs.joy.tolerances[kind];
        }

        /// <summary>The joy tolerance of the kind is higher than the remembered value: the colonist really took joy of that kind.</summary>
        [Then("Nelim's Pickle Tools: {string}'s joy tolerance for the kind {string} is higher than remembered")]
        public void ToleranceRose(PickleContext ctx, string nickname, string kindName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            JoyKindDef kind = Kind(ctx, kindName);
            ctx.Require(ToleranceBaseline.TryGetValue((pawn, kind), out float before), $"no tolerance of {kindName} was remembered for {nickname}");
            float after = pawn.needs.joy.tolerances[kind];
            ctx.Assert(after > before, $"{nickname}'s tolerance for {kindName} went from {before:0.0000} to {after:0.0000}: it did not rise");
        }

        /// <summary>Remembers the experience of a colonist's skill (SkillDef defName such as Melee), levels included.</summary>
        [When("Nelim's Pickle Tools: I remember {string}'s skill {string} experience")]
        public void RememberSkill(PickleContext ctx, string nickname, string skillName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            SkillDef skill = SkillOf(ctx, skillName);
            SkillBaseline[(pawn, skill)] = Experience(ctx, pawn, skill, nickname);
        }

        /// <summary>The skill's experience is higher than remembered (a level gained counts).</summary>
        [Then("Nelim's Pickle Tools: {string}'s skill {string} experience is higher than remembered")]
        public void SkillRose(PickleContext ctx, string nickname, string skillName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            SkillDef skill = SkillOf(ctx, skillName);
            ctx.Require(SkillBaseline.TryGetValue((pawn, skill), out double before), $"no {skillName} experience was remembered for {nickname}");
            double after = Experience(ctx, pawn, skill, nickname);
            ctx.Assert(after > before, $"{nickname}'s {skillName} experience went from {before} to {after}: it did not rise (a disabled skill or a learn rate of zero learns nothing)");
        }

        /// <summary>
        /// Sets a colonist's skill (SkillDef defName) to a level, with no experience towards the next one. Fails loudly when the skill is disabled for that
        /// colonist (a backstory or trait: a level cannot fix that) or when the level is outside 0 to 20. Written 2026-11-10 for RetroJoyRenew. Compiled, NOT PLAYED.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} has the skill {string} at level {int}")]
        public void SkillAtLevel(PickleContext ctx, string nickname, string skillName, int level)
        {
            SkillRecord record = Record(ctx, nickname, skillName, level);
            record.Level = level;
            record.xpSinceLastLevel = 0f;
            ctx.Assert(record.Level == level, $"{nickname}'s {skillName} reads {record.Level} after setting {level}");
        }

        /// <summary>The same, and the passion (None, Minor or Major), which sets how fast the skill learns.</summary>
        [Given("Nelim's Pickle Tools: {string} has the skill {string} at level {int} with the passion {word}")]
        public void SkillAtLevelWithPassion(PickleContext ctx, string nickname, string skillName, int level, string passion)
        {
            SkillRecord record = Record(ctx, nickname, skillName, level);
            ctx.Require(Enum.GetNames(typeof(Passion)).Any(n => string.Equals(n, passion, StringComparison.OrdinalIgnoreCase)), "the passion must be one of " + string.Join(", ", Enum.GetNames(typeof(Passion))) + $", not '{passion}'");
            record.Level = level;
            record.xpSinceLastLevel = 0f;
            record.passion = (Passion)Enum.Parse(typeof(Passion), passion, true);
            ctx.Assert(record.Level == level && record.passion.ToString().Equals(passion, StringComparison.OrdinalIgnoreCase), $"{nickname}'s {skillName} reads level {record.Level}, passion {record.passion} after setting {level}, {passion}");
        }

        private static SkillRecord Record(PickleContext ctx, string nickname, string skillName, int level)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            SkillDef skill = SkillOf(ctx, skillName);
            SkillRecord record = pawn.skills?.GetSkill(skill);
            ctx.Require(record != null, $"{nickname} has no skill tracker for {skill.defName}");
            ctx.Require(level >= 0 && level <= 20, $"a skill level is 0 to 20, not {level}");
            ctx.Require(!record.TotallyDisabled, $"{nickname}'s {skill.defName} is disabled (a backstory or a trait): a level cannot enable it; pick another colonist");
            return record;
        }

        /// <summary>
        /// Downs a colonist in a bed: both legs are removed (the colonist stays conscious and cannot move, as after a bad fight), the colonist is put on
        /// the bed's first sleeping spot and the health state is rechecked at once. Fails when no bed stands at the cell, the body has no legs, or the
        /// colonist is not downed afterwards. The legs are not healed back: the scenario ends with the colonist, as other injuring steps do.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is downed in the bed at \\({int}, {int}\\)")]
        public void DownedInBed(PickleContext ctx, string nickname, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.Spawned && pawn.Map != null, $"{nickname} is not spawned on a map");
            Map map = pawn.Map;
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            Building_Bed bed = cell.GetThingList(map).OfType<Building_Bed>().FirstOrDefault();
            ctx.Require(bed != null, $"no bed stands at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            var legs = pawn.RaceProps.body.GetPartsWithDef(BodyPartDefOf.Leg).ToList();
            ctx.Require(legs.Count > 0, $"{nickname}'s body has no legs to remove");
            foreach (BodyPartRecord leg in legs)
            {
                if (pawn.health.hediffSet.PartIsMissing(leg))
                {
                    continue;
                }

                Hediff missing = HediffMaker.MakeHediff(HediffDefOf.MissingBodyPart, pawn, leg);
                pawn.health.AddHediff(missing, leg);
            }

            pawn.health.CheckForStateChange(null, null);
            ctx.Require(pawn.Downed, $"{nickname} is not downed after both legs were removed (moving {pawn.health.capacities.GetLevel(PawnCapacityDefOf.Moving):0.00})");
            pawn.jobs?.StopAll();
            pawn.Position = bed.GetSleepingSlotPos(0);
            pawn.Notify_Teleported(true, true);
            ctx.Assert(pawn.Position == bed.GetSleepingSlotPos(0) && pawn.Downed, $"{nickname} is at {pawn.Position}, downed {pawn.Downed}; the bed's first sleeping spot is {bed.GetSleepingSlotPos(0)}");
        }

        /// <summary>
        /// Asserts an Architect category tab SHOWS a building def: it is among the tab's designators (a drop-down group's included), the designator
        /// is visible and the def's research is finished. <c>the architect tab ... lists the def</c> reads the designator list only and ignores research.
        /// Developer god mode shows everything, so it fails when god mode is on.
        /// </summary>
        [Then("Nelim's Pickle Tools: the architect tab {string} shows the def {string}")]
        public void TabShows(PickleContext ctx, string tabName, string defName)
        {
            bool shown = IsShown(ctx, tabName, defName, out string why);
            ctx.Assert(shown, $"the Architect tab '{tabName}' does not show '{defName}': {why}");
        }

        /// <summary>The negative twin of <c>the architect tab ... shows the def ...</c>: not listed, not visible or its research is not finished.</summary>
        [Then("Nelim's Pickle Tools: the architect tab {string} does not show the def {string}")]
        public void TabDoesNotShow(PickleContext ctx, string tabName, string defName)
        {
            bool shown = IsShown(ctx, tabName, defName, out string why);
            ctx.Assert(!shown, $"the Architect tab '{tabName}' shows '{defName}'");
        }

        private static bool IsShown(PickleContext ctx, string tabName, string defName, out string why)
        {
            ctx.Require(!DebugSettings.godMode, "developer god mode is on: it shows every building whatever the research; turn it off for this step");
            var categories = DefDatabase<DesignationCategoryDef>.AllDefsListForReading;
            DesignationCategoryDef tab = categories.FirstOrDefault(c => string.Equals(c.defName, tabName, StringComparison.OrdinalIgnoreCase))
                ?? categories.FirstOrDefault(c => string.Equals(c.LabelCap.ToString(), tabName, StringComparison.OrdinalIgnoreCase));
            ctx.Require(tab != null, $"no Architect tab '{tabName}'; the tabs are " + string.Join(", ", categories.Select(c => c.defName)));
            var places = new List<Designator_Place>();
            foreach (Designator designator in tab.ResolvedAllowedDesignators)
            {
                if (designator is Designator_Dropdown dropdown)
                {
                    places.AddRange(dropdown.Elements.OfType<Designator_Place>());
                }
                else if (designator is Designator_Place place)
                {
                    places.Add(place);
                }
            }

            Designator_Place found = places.FirstOrDefault(p => p.PlacingDef != null && string.Equals(p.PlacingDef.defName, defName, StringComparison.OrdinalIgnoreCase));
            if (found == null)
            {
                why = "not among the designators of the tab";
                return false;
            }

            bool researched = found.PlacingDef.IsResearchFinished;
            bool visible = found.Visible;
            why = $"researched {researched}, designator visible {visible}";
            return researched && visible;
        }

        private static JoyKindDef Kind(PickleContext ctx, string kindName)
        {
            JoyKindDef kind = DefDatabase<JoyKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no JoyKindDef '{kindName}'; the kinds are " + string.Join(", ", DefDatabase<JoyKindDef>.AllDefsListForReading.Select(k => k.defName)));
            return kind;
        }

        private static SkillDef SkillOf(PickleContext ctx, string skillName)
        {
            SkillDef skill = DefDatabase<SkillDef>.GetNamedSilentFail(skillName);
            ctx.Require(skill != null, $"no SkillDef '{skillName}'; the skills are " + string.Join(", ", DefDatabase<SkillDef>.AllDefsListForReading.Select(s => s.defName)));
            return skill;
        }

        private static double Experience(PickleContext ctx, Pawn pawn, SkillDef skill, string nickname)
        {
            SkillRecord record = pawn.skills?.GetSkill(skill);
            ctx.Require(record != null, $"{nickname} has no skill tracker for {skill.defName}");
            return record.Level * 1000000.0 + record.xpSinceLastLevel;
        }
    }
}
