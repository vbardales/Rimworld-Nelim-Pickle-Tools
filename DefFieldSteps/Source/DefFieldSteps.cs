using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
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
            Type type = GenTypes.GetTypeInAnyAssembly(typeName);
            ctx.Require(type != null && typeof(Def).IsAssignableFrom(type), $"'{typeName}' is not a def type the game knows (a name such as StyleCategoryDef or ThingDef)");
            ctx.Assert(GenDefDatabase.GetDefSilentFail(type, defName, false) == null, $"a {type.Name} named '{defName}' is loaded, and it should not be");
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

        private static Def Find(PickleContext ctx, string defName, string typeName)
        {
            Type type = GenTypes.GetTypeInAnyAssembly(typeName);
            ctx.Require(
                type != null && typeof(Def).IsAssignableFrom(type),
                $"'{typeName}' is not a def type the game knows (a name such as ThingDef or PawnKindDef)");

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
            foreach (string part in path.Split('.'))
            {
                ctx.Require(current != null, $"'{path}' walks through a null at '{part}'");
                Type type = current.GetType();
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
