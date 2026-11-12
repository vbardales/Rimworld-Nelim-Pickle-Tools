using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.DefFields
{
    /// <summary>
    /// Reads a public field of a def, by the def's TYPE and name. Pickle's own <c>def {string} field {string} is {string}</c>
    /// looks the def up by name alone and refuses a name that two def types share, which is the case of every animal:
    /// <c>Muffalo</c> is a ThingDef and a PawnKindDef. The type in the step says which one is meant.
    ///
    /// The path is a dotted walk over public fields and properties from the def (<c>race.lifeExpectancy</c>), as Pickle's
    /// step does. The value is turned into text and compared to the expected text, ignoring case; numbers are written with
    /// the invariant culture, so <c>1.5</c> reads <c>1.5</c> on a French install too (a bare <c>ToString()</c> would give
    /// <c>1,5</c> there). A value with a decimal fraction that a float cannot hold exactly reads as the float writes it
    /// (a float 0.1 reads <c>0.1</c>, a computed one may read <c>0.3000000119</c>): prefer values the patch wrote literally.
    ///
    /// Every pattern starts with "Nelim's Pickle Tools:" so that it cannot be ambiguous with a step of Pickle's own.
    /// </summary>
    [PickleSteps]
    public class DefFieldSteps
    {
        [Then("Nelim's Pickle Tools: def {string} of type {string} field {string} is {string}")]
        public void FieldIs(PickleContext ctx, string defName, string typeName, string fieldPath, string expected)
        {
            Def def = Find(ctx, defName, typeName);
            string actual = Text(Walk(ctx, def, fieldPath));
            ctx.Assert(
                string.Equals(actual, expected, StringComparison.OrdinalIgnoreCase),
                $"{def.GetType().Name} '{defName}' field '{fieldPath}' should be '{expected}'; actual '{actual}'");
        }

        /// <summary>Asserts a biome lists a pawn kind among its wild animals (BiomeDef.wildAnimals, which a patch fills; the commonality is not read).</summary>
        [Then("Nelim's Pickle Tools: the biome {string} lists the wild animal {string}")]
        public void BiomeListsAnimal(PickleContext ctx, string biomeName, string kindName)
        {
            var biome = DefDatabase<RimWorld.BiomeDef>.GetNamedSilentFail(biomeName);
            ctx.Require(biome != null, $"no BiomeDef named '{biomeName}'");
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no PawnKindDef named '{kindName}'");
            ctx.Assert(biome.AllWildAnimals.Contains(kind), $"biome '{biomeName}' does not list '{kindName}'; its wild animals: " + string.Join(", ", biome.AllWildAnimals.Select(k => k.defName).Take(30)));
        }

        /// <summary>
        /// Asserts a recipe is offered to a race: the race's recipe list (ThingDef.AllRecipes, which holds the race's own recipes and every
        /// recipe whose recipeUsers names it, built after all patches and after a mod such as A Dog Said... Animal Prosthetics 2 copied its lists)
        /// contains it and its research prerequisites are met (AvailableNow). A def-level read: it does not look at a pawn's body parts.
        /// </summary>
        [Then("Nelim's Pickle Tools: the recipe {string} is offered for the race {string}")]
        public void RecipeOffered(PickleContext ctx, string recipeName, string raceName)
        {
            var recipe = DefDatabase<RecipeDef>.GetNamedSilentFail(recipeName);
            ctx.Require(recipe != null, $"no RecipeDef named '{recipeName}' (an abstract def is not a def: read a concrete recipe)");
            var race = DefDatabase<ThingDef>.GetNamedSilentFail(raceName);
            ctx.Require(race != null, $"no ThingDef named '{raceName}'");
            ctx.Assert(race.AllRecipes.Contains(recipe), $"'{recipeName}' is not in the recipes of '{raceName}'");
            ctx.Assert(recipe.AvailableNow, $"'{recipeName}' is listed for '{raceName}' but its research prerequisites are not met");
        }

        /// <summary>
        /// The negative twin of <c>the recipe ... is offered for the race</c>: the race's recipe list (<c>ThingDef.AllRecipes</c>) does not
        /// contain the recipe. It does not look at research. Written 2026-10-12 from A Certain Series' own step. Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: the race {string} is not offered the recipe {string}")]
        public void RaceNotOfferedRecipe(PickleContext ctx, string raceName, string recipeName)
        {
            var recipe = DefDatabase<RecipeDef>.GetNamedSilentFail(recipeName);
            ctx.Require(recipe != null, $"no RecipeDef named '{recipeName}'");
            var race = DefDatabase<ThingDef>.GetNamedSilentFail(raceName);
            ctx.Require(race != null, $"no ThingDef named '{raceName}'");
            ctx.Assert(!race.AllRecipes.Contains(recipe), $"'{raceName}' is offered '{recipeName}'");
        }

        /// <summary>
        /// The recipe is offered to the pawn kind AND the game finds a part of that def on a real pawn of the kind: being listed is not
        /// being usable. Generates a pawn of the kind (<c>PawnGenerator</c>) and destroys it at once. Written 2026-10-12 from A Certain
        /// Series' own step. Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: the recipe {string} can be applied on a {string} of a {string}")]
        public void RecipeAppliesOnPart(PickleContext ctx, string recipeName, string partName, string kindName)
        {
            var recipe = DefDatabase<RecipeDef>.GetNamedSilentFail(recipeName);
            ctx.Require(recipe != null, $"no RecipeDef named '{recipeName}'");
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no PawnKindDef named '{kindName}'");
            Pawn pawn = PawnGenerator.GeneratePawn(kind);
            try
            {
                ctx.Assert(pawn.def.AllRecipes.Contains(recipe), $"'{kindName}' is not offered '{recipeName}'");
                var parts = recipe.Worker.GetPartsToApplyOn(pawn, recipe).ToList();
                ctx.Assert(
                    parts.Any(p => p.def.defName == partName),
                    $"'{recipeName}' finds no '{partName}' on a '{kindName}': parts found are [{string.Join(", ", parts.Select(p => p.def.defName))}]");
            }
            finally
            {
                if (!pawn.Destroyed)
                {
                    pawn.Destroy();
                }
            }
        }

        /// <summary>
        /// Compares the SURGERY recipes of two races by defName (RecipeDef.IsSurgery in ThingDef.AllRecipes): the same set, or a failure that
        /// names the recipes only one of them has. No recipe defName is hardcoded, so it follows a mod that adds its own.
        /// </summary>
        [Then("Nelim's Pickle Tools: the surgery recipes of the race {string} match those of the race {string}")]
        public void SurgeriesMatch(PickleContext ctx, string raceName, string otherName)
        {
            var a = Surgeries(ctx, raceName);
            var b = Surgeries(ctx, otherName);
            ctx.Require(b.Count > 0, $"'{otherName}' has no surgery recipe: nothing to compare against");
            var onlyA = a.Except(b).ToList();
            var onlyB = b.Except(a).ToList();
            ctx.Assert(onlyA.Count == 0 && onlyB.Count == 0,
                $"surgery recipes differ: only for '{raceName}' [{string.Join(", ", onlyA)}]; only for '{otherName}' [{string.Join(", ", onlyB)}]");
        }

        private const string MatingGroupType = "Revolus.DogsMate.AnimalGroupDef";

        /// <summary>
        /// Dogs Mate keeps its mating groups as defs of the type <c>Revolus.DogsMate.AnimalGroupDef</c>, whose public list <c>pawnKinds</c> names the
        /// kinds (the resolved list is the property <c>FoundPawnKinds</c>, read when the field is empty). Read by reflection, so this tool does not
        /// reference the mod. Written 2026-10-13 for Mengwu Expanded Animals Renew. Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: the pawn kind {string} is in the mating group {string}")]
        public void KindInMatingGroup(PickleContext ctx, string kindName, string groupName)
        {
            Type type = GenTypes.GetTypeInAnyAssembly(MatingGroupType);
            ctx.Require(type != null, $"no type {MatingGroupType}: is Dogs Mate loaded?");
            Def group = GenDefDatabase.GetDefSilentFail(type, groupName, false);
            ctx.Require(group != null, $"no {MatingGroupType} named '{groupName}'");
            var names = new List<string>();
            foreach (string member in new[] { "pawnKinds", "FoundPawnKinds" })
            {
                object value = type.GetField(member)?.GetValue(group) ?? type.GetProperty(member)?.GetValue(group);
                if (value is System.Collections.IEnumerable list)
                {
                    names.AddRange(list.OfType<Def>().Select(d => d.defName));
                }
            }

            ctx.Assert(names.Contains(kindName), $"mating group '{groupName}' holds [{string.Join(", ", names.Distinct())}], not '{kindName}'");
        }

        private const string CrossbreedingExtension = "DZY.CrossBreeding.Extension";
        private const string NocturnalExtension = "NocturnalAnimals.ExtendedRaceProperties";

        /// <summary>
        /// Asserts the race (ThingDef) lists another race among <c>race.canCrossBreedWith</c>, which a patch fills.
        /// Written 2026-10-13 from Funny Creatures Renew's own step. Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: the race {string} lists {string} as a crossbreeding partner")]
        public void RaceListsPartner(PickleContext ctx, string raceName, string partnerName)
        {
            List<string> partners = Partners(ctx, raceName);
            ctx.Assert(partners.Contains(partnerName), $"'{raceName}' lists [{string.Join(", ", partners)}] as crossbreeding partners, not '{partnerName}'");
        }

        /// <summary>The negative twin of <c>the race ... lists ... as a crossbreeding partner</c>. Not played here.</summary>
        [Then("Nelim's Pickle Tools: the race {string} does not list {string} as a crossbreeding partner")]
        public void RaceDoesNotListPartner(PickleContext ctx, string raceName, string partnerName)
        {
            List<string> partners = Partners(ctx, raceName);
            ctx.Assert(!partners.Contains(partnerName), $"'{raceName}' lists [{string.Join(", ", partners)}] as crossbreeding partners, including '{partnerName}'");
        }

        private static List<string> Partners(PickleContext ctx, string raceName)
        {
            var race = DefDatabase<ThingDef>.GetNamedSilentFail(raceName);
            ctx.Require(race != null && race.race != null, $"no race ThingDef named '{raceName}'");
            return race.race.canCrossBreedWith?.Select(d => d.defName).ToList() ?? new List<string>();
        }

        /// <summary>
        /// What Better Crossbreeding (DZY.CrossBreeding) will answer for a birth: the extension on the MOTHER's PawnKindDef holds outcomes keyed
        /// by the FATHER's kind, each with a behavior (<c>Maternal</c>, <c>Random</c>, ...). Read by reflection on the type's full name, so this
        /// tool does not reference the mod. Fails with the outcomes it found. Written 2026-10-13 from Funny Creatures Renew's own step. Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: a {string} mother answers a {string} father with {word}")]
        public void MotherAnswers(PickleContext ctx, string motherKind, string fatherKind, string behavior)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(motherKind);
            ctx.Require(kind != null, $"no PawnKindDef named '{motherKind}'");
            DefModExtension extension = kind.modExtensions?.FirstOrDefault(e => e.GetType().FullName == CrossbreedingExtension);
            ctx.Require(extension != null, $"'{motherKind}' carries no {CrossbreedingExtension}; its extensions: "
                + string.Join(", ", (kind.modExtensions ?? new List<DefModExtension>()).Select(e => e.GetType().FullName)));
            var outcomes = extension.GetType().GetField("outcomes")?.GetValue(extension) as System.Collections.IEnumerable;
            ctx.Require(outcomes != null, $"{CrossbreedingExtension} has no readable 'outcomes' list: has the mod changed?");
            var seen = new List<string>();
            foreach (object outcome in outcomes)
            {
                Type type = outcome.GetType();
                var father = type.GetField("kindDef")?.GetValue(outcome) as PawnKindDef;
                string actual = type.GetField("behavior")?.GetValue(outcome)?.ToString();
                seen.Add($"{father?.defName}={actual}");
                if (father?.defName == fatherKind)
                {
                    ctx.Assert(actual == behavior, $"a '{motherKind}' mother with a '{fatherKind}' father answers {actual}, expected {behavior}");
                    return;
                }
            }

            ctx.Assert(false, $"a '{motherKind}' mother has no outcome for a '{fatherKind}' father; outcomes: [{string.Join(", ", seen)}]");
        }

        /// <summary>
        /// Nocturnal Animals keeps an animal's body clock in a public field <c>bodyClock</c> of the extension <c>NocturnalAnimals.ExtendedRaceProperties</c>
        /// on the race. Read by reflection. Written 2026-10-13 from Funny Creatures Renew's own step. Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: the race {string} has the body clock {word}")]
        public void RaceHasBodyClock(PickleContext ctx, string raceName, string expected)
        {
            var race = DefDatabase<ThingDef>.GetNamedSilentFail(raceName);
            ctx.Require(race != null, $"no ThingDef named '{raceName}'");
            DefModExtension extension = race.modExtensions?.FirstOrDefault(e => e.GetType().FullName == NocturnalExtension);
            ctx.Require(extension != null, $"'{raceName}' carries no {NocturnalExtension}; its extensions: "
                + string.Join(", ", (race.modExtensions ?? new List<DefModExtension>()).Select(e => e.GetType().FullName)));
            object clock = extension.GetType().GetField("bodyClock")?.GetValue(extension);
            ctx.Require(clock != null, $"{NocturnalExtension} has no readable 'bodyClock' field: has the mod changed?");
            ctx.Assert(clock.ToString() == expected, $"'{raceName}' has the body clock {clock}, expected {expected}");
        }

        /// <summary>The race carries no Nocturnal Animals extension (an animal without it is diurnal). Not played here.</summary>
        [Then("Nelim's Pickle Tools: the race {string} has no body clock")]
        public void RaceHasNoBodyClock(PickleContext ctx, string raceName)
        {
            var race = DefDatabase<ThingDef>.GetNamedSilentFail(raceName);
            ctx.Require(race != null, $"no ThingDef named '{raceName}'");
            ctx.Assert(!(race.modExtensions?.Any(e => e.GetType().FullName == NocturnalExtension) ?? false), $"'{raceName}' carries {NocturnalExtension}, expected none");
        }

        private static List<string> Surgeries(PickleContext ctx, string raceName)
        {
            var race = DefDatabase<ThingDef>.GetNamedSilentFail(raceName);
            ctx.Require(race != null, $"no ThingDef named '{raceName}'");
            return race.AllRecipes.Where(r => r.IsSurgery).Select(r => r.defName).OrderBy(n => n, StringComparer.Ordinal).ToList();
        }


        /// <summary>Asserts a def of that type and name is loaded (any def type the game knows, such as StyleCategoryDef or ThingStyleDef). Written 2026-10-29 for PropsAsStyle. Compiled, not played.</summary>
        [Then("Nelim's Pickle Tools: the def {string} of type {string} is loaded")]
        public void DefIsLoaded(PickleContext ctx, string defName, string typeName) => Find(ctx, defName, typeName);

        /// <summary>The negative twin: no def of that type and name is loaded (an optional source mod is absent). Fails when the type is not a def type the game knows. Compiled, not played.</summary>
        [Then("Nelim's Pickle Tools: the def {string} of type {string} is not loaded")]
        public void DefIsNotLoaded(PickleContext ctx, string defName, string typeName)
        {
            Type type = ResolveDefType(typeName);
            ctx.Require(type != null && typeof(Def).IsAssignableFrom(type), $"'{typeName}' is not a def type the game knows (a name such as StyleCategoryDef or ThingDef)");
            ctx.Assert(GenDefDatabase.GetDefSilentFail(type, defName, false) == null, $"a {type.Name} named '{defName}' is loaded, and it should not be");
        }

        /// <summary>
        /// Asserts the def of that type and name was loaded from the mod (its packageId, with or without the player-facing suffix, case-insensitive). Pickle's own
        /// "defined by mod" step refuses a name two def types share (every animal); the type in this step says which. Written 2026-11-03 from
        /// DalmatiansRenew's step for RedWolvesRenew. Compiled, not played.
        /// </summary>
        [Then("Nelim's Pickle Tools: the def {string} of type {string} comes from the mod {string}")]
        public void DefComesFromMod(PickleContext ctx, string defName, string typeName, string packageId)
        {
            Def def = Find(ctx, defName, typeName);
            ModContentPack pack = def.modContentPack;
            bool match = pack != null && (string.Equals(pack.PackageId, packageId, StringComparison.OrdinalIgnoreCase)
                || string.Equals(pack.PackageIdPlayerFacing, packageId, StringComparison.OrdinalIgnoreCase));
            ctx.Assert(match, $"{def.GetType().Name} '{defName}' comes from '{pack?.PackageIdPlayerFacing}', expected {packageId}");
        }

        /// <summary>
        /// Asserts the def carries a mod extension of that type (its full name, such as <c>RimScentReworked.ModExtension_Scent</c>) and that a public
        /// field or property of it, read by the same dotted walk as <c>def ... field ... is</c>, reads as the expected text (a def by its defName).
        /// Read by reflection on the type's full name, so this tool does not reference the mod. The path has no list index, which is why
        /// <c>modExtensions</c> cannot be walked by the plain step. Written 2026-11-03 for RimScentExtendedEverydayLifeExpansion. Compiled, not played.
        /// </summary>
        [Then("Nelim's Pickle Tools: the def {string} of type {string} has the extension {string} with field {string} {string}")]
        public void ExtensionFieldIs(PickleContext ctx, string defName, string typeName, string extensionType, string fieldPath, string expected)
        {
            Def def = Find(ctx, defName, typeName);
            DefModExtension extension = def.modExtensions?.FirstOrDefault(e => e != null && e.GetType().FullName == extensionType);
            ctx.Require(extension != null, $"{def.GetType().Name} '{defName}' carries no {extensionType}; its extensions: "
                + string.Join(", ", (def.modExtensions ?? new List<DefModExtension>()).Select(e => e?.GetType().FullName ?? "(null)")));
            string actual = Text(Walk(ctx, extension, fieldPath));
            ctx.Assert(
                string.Equals(actual, expected, StringComparison.OrdinalIgnoreCase),
                $"{extensionType} on {def.GetType().Name} '{defName}' field '{fieldPath}' should be '{expected}'; actual '{actual}'");
        }

        /// <summary>
        /// Asserts a list field of a def (dotted path, such as <c>tradeTags</c> or <c>comps</c>) holds an item, by text (a def by its defName), ignoring
        /// case. The plain field step compares the WHOLE list; this one reads one item. Written 2026-11-10 for PropsAsDeco. Compiled, NOT PLAYED.
        /// </summary>
        [Then("Nelim's Pickle Tools: the def {string} of type {string} has {string} in the list {string}")]
        public void ListHas(PickleContext ctx, string defName, string typeName, string item, string fieldPath)
        {
            Def def = Find(ctx, defName, typeName);
            var items = ItemsOf(ctx, def, fieldPath);
            ctx.Assert(items.Contains(item, StringComparer.OrdinalIgnoreCase), $"{def.GetType().Name} '{defName}' list '{fieldPath}' does not hold '{item}'; it holds: " + string.Join(", ", items));
        }

        /// <summary>The negative twin of <c>the def ... has ... in the list ...</c>. Compiled, NOT PLAYED.</summary>
        [Then("Nelim's Pickle Tools: the def {string} of type {string} does not have {string} in the list {string}")]
        public void ListHasNot(PickleContext ctx, string defName, string typeName, string item, string fieldPath)
        {
            Def def = Find(ctx, defName, typeName);
            var items = ItemsOf(ctx, def, fieldPath);
            ctx.Assert(!items.Contains(item, StringComparer.OrdinalIgnoreCase), $"{def.GetType().Name} '{defName}' list '{fieldPath}' holds '{item}'");
        }

        /// <summary>
        /// Asserts a ThingDef carries a comp of that class (its full name, such as <c>MyMod.CompProperties_Deco</c>, found in <c>comps</c>, which the
        /// plain path cannot index). Read by reflection on the name, so this tool does not reference the mod. Written 2026-11-10 for PropsAsDeco.
        /// Compiled, NOT PLAYED.
        /// </summary>
        [Then("Nelim's Pickle Tools: the def {string} of type {string} has the comp {string}")]
        public void HasComp(PickleContext ctx, string defName, string typeName, string compType)
        {
            Def def = Find(ctx, defName, typeName);
            var comps = (def as ThingDef)?.comps ?? new List<CompProperties>();
            ctx.Assert(comps.Any(c => c != null && (c.GetType().FullName == compType || c.compClass?.FullName == compType)),
                $"{def.GetType().Name} '{defName}' carries no comp {compType}; its comps: " + string.Join(", ", comps.Select(c => c?.GetType().FullName ?? "(null)")));
        }

        /// <summary>
        /// Asserts the label of a def as the game shows it in the language it runs in (<c>LabelCap</c>, so a translation of the def is applied), compared
        /// exactly: a name that must stay English in a French run is checked by running with that language. Written 2026-11-10 for RetroJoyRenew.
        /// Compiled, NOT PLAYED.
        /// </summary>
        [Then("Nelim's Pickle Tools: the def {string} of type {string} is labelled {string}")]
        public void DefLabelReads(PickleContext ctx, string defName, string typeName, string expected)
        {
            Def def = Find(ctx, defName, typeName);
            string actual = def.LabelCap.ToString();
            ctx.Assert(actual == expected, $"{def.GetType().Name} '{defName}' is labelled '{actual}' in the language of this run, expected '{expected}'");
        }

        /// <summary>The same for the description of the def, exact text. Compiled, NOT PLAYED.</summary>
        [Then("Nelim's Pickle Tools: the def {string} of type {string} is described as {string}")]
        public void DefDescriptionReads(PickleContext ctx, string defName, string typeName, string expected)
        {
            Def def = Find(ctx, defName, typeName);
            ctx.Assert(def.description == expected, $"{def.GetType().Name} '{defName}' is described as '{def.description}' in the language of this run, expected '{expected}'");
        }

        private static List<string> ItemsOf(PickleContext ctx, Def def, string fieldPath)
        {
            object value = Walk(ctx, def, fieldPath);
            ctx.Require(value is System.Collections.IEnumerable && !(value is string), $"'{fieldPath}' of {def.GetType().Name} '{def.defName}' is not a list");
            return ((System.Collections.IEnumerable)value).Cast<object>().Select(o => o is Def d ? d.defName : Text(o)).ToList();
        }

        /// <summary>Asserts the PawnKindDef carries exactly one Better Crossbreeding extension (a patch that adds a second one would fail the game's own read). Compiled, not played.</summary>
        [Then("Nelim's Pickle Tools: the pawn kind {string} carries one Better Crossbreeding extension")]
        public void KindCarriesOneCrossbreedingExtension(PickleContext ctx, string kindName)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no PawnKindDef named '{kindName}'");
            int count = kind.modExtensions?.Count(e => e != null && e.GetType().FullName == CrossbreedingExtension) ?? 0;
            ctx.Assert(count == 1, $"'{kindName}' carries {count} {CrossbreedingExtension}");
        }

        /// <summary>The negative twin of <c>a ... mother answers a ... father with ...</c>: no extension, or none with an outcome for that father kind. Compiled, not played.</summary>
        [Then("Nelim's Pickle Tools: a {string} mother has no answer for a {string} father")]
        public void MotherHasNoAnswer(PickleContext ctx, string motherKind, string fatherKind)
        {
            var kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(motherKind);
            ctx.Require(kind != null, $"no PawnKindDef named '{motherKind}'");
            DefModExtension extension = kind.modExtensions?.FirstOrDefault(e => e != null && e.GetType().FullName == CrossbreedingExtension);
            if (extension == null) return;
            var outcomes = extension.GetType().GetField("outcomes")?.GetValue(extension) as System.Collections.IEnumerable;
            ctx.Require(outcomes != null, $"{CrossbreedingExtension} has no readable 'outcomes' list: has the mod changed?");
            foreach (object outcome in outcomes)
            {
                var father = outcome.GetType().GetField("kindDef")?.GetValue(outcome) as PawnKindDef;
                ctx.Assert(father?.defName != fatherKind, $"a '{motherKind}' mother has an outcome for a '{fatherKind}' father, which this pass does not expect");
            }
        }

        /// <summary>Asserts an ideoligion style category gives a thing the style: its <c>thingDefStyles</c> holds the pair (thing, style). Written 2026-10-29 for PropsAsStyle. Compiled, not played.</summary>
        [Then("Nelim's Pickle Tools: the style category {string} gives the thing {string} the style {string}")]
        public void CategoryGivesStyle(PickleContext ctx, string categoryName, string thingName, string styleName)
        {
            var category = DefDatabase<StyleCategoryDef>.GetNamedSilentFail(categoryName);
            ctx.Require(category != null, $"no StyleCategoryDef named '{categoryName}'");
            var thing = DefDatabase<ThingDef>.GetNamedSilentFail(thingName);
            ctx.Require(thing != null, $"no ThingDef named '{thingName}'");
            var style = DefDatabase<ThingStyleDef>.GetNamedSilentFail(styleName);
            ctx.Require(style != null, $"no ThingStyleDef named '{styleName}'");
            ctx.Assert(category.thingDefStyles != null && category.thingDefStyles.Any(s => s.ThingDef == thing && s.StyleDef == style),
                $"category '{categoryName}' does not give '{thingName}' the style '{styleName}'; its styles for that thing: "
                + string.Join(", ", (category.thingDefStyles ?? new System.Collections.Generic.List<ThingDefStyle>()).Where(s => s.ThingDef == thing).Select(s => s.StyleDef?.defName ?? "(null)")));
        }

        /// <summary>
        /// Asserts the graphic a style gives a thing resolves: the graphic is built from the style's own graphicData (or the thing's, when the style has
        /// none) and its material is not the game's pink bad-texture material. A def-level read: no thing is placed. Written 2026-10-29 for PropsAsStyle. Compiled, not played.
        /// </summary>
        [Then("Nelim's Pickle Tools: the style {string} of the thing {string} draws a texture that resolves")]
        public void StyleGraphicResolves(PickleContext ctx, string styleName, string thingName)
        {
            var style = DefDatabase<ThingStyleDef>.GetNamedSilentFail(styleName);
            ctx.Require(style != null, $"no ThingStyleDef named '{styleName}'");
            var thing = DefDatabase<ThingDef>.GetNamedSilentFail(thingName);
            ctx.Require(thing != null, $"no ThingDef named '{thingName}'");
            Graphic graphic = style.graphicData != null ? style.graphicData.Graphic : thing.graphic;
            ctx.Assert(graphic != null, $"style '{styleName}' of '{thingName}' builds no graphic");
            ctx.Assert(graphic.MatSingle != null && graphic.MatSingle != BaseContent.BadMat,
                $"style '{styleName}' of '{thingName}' draws the pink bad-texture material (texPath '{graphic.path}')");
        }

        /// <summary>Finds a def type by name; falls back to a scan of every Def subclass by full or short name, so a type of another mod (AlienRace.BackstoryDef) resolves.</summary>
        private static Type ResolveDefType(string typeName)
        {
            Type type = GenTypes.GetTypeInAnyAssembly(typeName);
            if (type != null && typeof(Def).IsAssignableFrom(type)) return type;
            return typeof(Def).AllSubclasses().FirstOrDefault(t => t.FullName == typeName)
                ?? typeof(Def).AllSubclasses().FirstOrDefault(t => t.Name == typeName);
        }

        private static Def Find(PickleContext ctx, string defName, string typeName)
        {
            Type type = ResolveDefType(typeName);
            if (type == null || !typeof(Def).IsAssignableFrom(type))
            {
                string shortName = typeName.Substring(typeName.LastIndexOf('.') + 1);
                string seen = string.Join(", ", AppDomain.CurrentDomain.GetAssemblies()
                    .SelectMany(a => { try { return a.GetTypes(); } catch (ReflectionTypeLoadException e) { return e.Types.Where(t => t != null); } catch { return Type.EmptyTypes; } })
                    .Where(t => t.Name == shortName).Select(t => t.FullName + (typeof(Def).IsAssignableFrom(t) ? " (a Def)" : " (NOT a Def)")).Take(5));
                ctx.Require(false, $"'{typeName}' is not a def type the game knows (a name such as ThingDef or PawnKindDef); types of that short name in the loaded assemblies: " + (seen.Length > 0 ? seen : "none (the mod that defines it is not loaded?)"));
            }

            Def def = GenDefDatabase.GetDefSilentFail(type, defName, false);
            if (def == null)
            {
                string near = string.Join(", ", DefsOf(type).Where(d => d.defName.IndexOf(defName, StringComparison.OrdinalIgnoreCase) >= 0).Select(d => d.defName).Take(8));
                ctx.Require(false, $"no {type.Name} named '{defName}'" + (near.Length > 0 ? "; defs of that type with a similar name: " + near : string.Empty));
            }

            return def;
        }

        private static IEnumerable<Def> DefsOf(Type type)
        {
            Type database = typeof(DefDatabase<>).MakeGenericType(type);
            var all = database.GetProperty("AllDefsListForReading", BindingFlags.Public | BindingFlags.Static)?.GetValue(null, null) as System.Collections.IEnumerable;
            return all == null ? Enumerable.Empty<Def>() : all.Cast<Def>();
        }

        private static object Walk(PickleContext ctx, object start, string path)
        {
            object current = start;
            // 'stages.0.baseMoodEffect' and 'stages[0].baseMoodEffect' read the first item of a list (RSEFyE, 2026-11-12: "List`1 has no public field or property '0'").
            foreach (string part in path.Replace("[", ".").Replace("]", string.Empty).Split(new[] { '.' }, StringSplitOptions.RemoveEmptyEntries))
            {
                ctx.Require(current != null, $"'{path}' walks through a null at '{part}'");
                Type type = current.GetType();
                if (int.TryParse(part, out int index) && current is System.Collections.IList list)
                {
                    ctx.Require(index >= 0 && index < list.Count, $"'{path}': the list has {list.Count} item(s), no item {index}");
                    current = list[index];
                    continue;
                }

                FieldInfo field = type.GetField(part, BindingFlags.Instance | BindingFlags.Public);
                if (field != null)
                {
                    current = field.GetValue(current);
                    continue;
                }

                PropertyInfo property = type.GetProperty(part, BindingFlags.Instance | BindingFlags.Public);
                ctx.Require(property != null && property.GetIndexParameters().Length == 0,
                    $"{type.Name} has no public field or property '{part}'. Some of its fields: " + Describe(type));
                current = property.GetValue(current, null);
            }

            return current;
        }

        /// <summary>
        /// Reads the label of one stage of a thought def as the player sees it in the current game language: the translated <c>ThoughtStage.label</c>, with the
        /// <c>{PAWN_...}</c> tokens resolved for the pawn named (a colonist or animal, by short name or nickname, on any loaded map) and its first letter capitalised,
        /// which is what the game's <c>Thought.LabelCap</c> shows. Compares the whole text after trimming, ignoring case. Stage is the 0-based index in <c>ThoughtDef.stages</c>.
        /// Written 2026-11-11 for RimScentExtendedEverydayLifeExpansion (the English and French display runs). Compiled, NOT PLAYED.
        /// </summary>
        [Then("Nelim's Pickle Tools: the thought label of the stage {int} of {string} shown to {string} reads {string}")]
        public void ThoughtLabelReads(PickleContext ctx, int stage, string thoughtDefName, string pawnName, string expected)
        {
            ThoughtStage s = ThoughtStageOf(ctx, thoughtDefName, stage);
            Pawn pawn = PawnNamed(ctx, pawnName);
            string actual = s.label.Formatted(pawn.Named("PAWN")).Resolve().CapitalizeFirst().Trim();
            ctx.Assert(
                string.Equals(actual, expected.Trim(), StringComparison.OrdinalIgnoreCase),
                $"the label of stage {stage} of {thoughtDefName} shown to {pawnName} should read '{expected}'; it reads '{actual}' (language {Prefs.LangFolderName})");
        }

        /// <summary>
        /// Reads the description of one stage of a thought def as the player sees it: the translated <c>ThoughtStage.description</c> with the <c>{PAWN_...}</c> tokens
        /// resolved for the pawn named (as <c>Thought.Description</c> does). Compares the whole text after trimming, ignoring case. Written 2026-11-11 for
        /// RimScentExtendedEverydayLifeExpansion. Compiled, NOT PLAYED.
        /// </summary>
        [Then("Nelim's Pickle Tools: the thought description of the stage {int} of {string} shown to {string} reads {string}")]
        public void ThoughtDescriptionReads(PickleContext ctx, int stage, string thoughtDefName, string pawnName, string expected)
        {
            ThoughtStage s = ThoughtStageOf(ctx, thoughtDefName, stage);
            Pawn pawn = PawnNamed(ctx, pawnName);
            string actual = (s.description ?? string.Empty).Formatted(pawn.Named("PAWN")).Resolve().Trim();
            ctx.Assert(
                string.Equals(actual, expected.Trim(), StringComparison.OrdinalIgnoreCase),
                $"the description of stage {stage} of {thoughtDefName} shown to {pawnName} should read '{expected}'; it reads '{actual}' (language {Prefs.LangFolderName})");
        }

        private static ThoughtStage ThoughtStageOf(PickleContext ctx, string thoughtDefName, int stage)
        {
            ThoughtDef def = DefDatabase<ThoughtDef>.GetNamedSilentFail(thoughtDefName);
            ctx.Require(def != null, $"no ThoughtDef named '{thoughtDefName}'");
            ctx.Require(def.stages != null && stage >= 0 && stage < def.stages.Count, $"the thought {thoughtDefName} has {(def.stages == null ? 0 : def.stages.Count)} stage(s): there is no stage {stage}");
            return def.stages[stage];
        }

        private static Pawn PawnNamed(PickleContext ctx, string name)
        {
            Pawn pawn = Verse.Find.Maps.SelectMany(m => m.mapPawns.AllPawnsSpawned).FirstOrDefault(p =>
                string.Equals(p.LabelShort, name, StringComparison.OrdinalIgnoreCase)
                || (p.Name is NameTriple t && string.Equals(t.Nick, name, StringComparison.OrdinalIgnoreCase)));
            ctx.Require(pawn != null, $"no pawn named '{name}' stands on a loaded map");
            return pawn;
        }

        private static string Describe(Type type)
        {
            return string.Join(", ", type.GetFields(BindingFlags.Instance | BindingFlags.Public).Select(f => f.Name).OrderBy(n => n, StringComparer.OrdinalIgnoreCase).Take(12));
        }

        private static string Text(object value)
        {
            if (value == null)
            {
                return "(null)";
            }

            var list = value as System.Collections.IEnumerable;
            if (list != null && !(value is string))
            {
                // A list or array reads as its items joined by ", " (a def by its defName), in order: List.ToString() would print only the type.
                return string.Join(", ", list.Cast<object>().Select(o => o is Def d ? d.defName : Text(o)));
            }

            var formattable = value as IFormattable;
            return formattable != null ? formattable.ToString(null, CultureInfo.InvariantCulture) : value.ToString();
        }
    }
}
