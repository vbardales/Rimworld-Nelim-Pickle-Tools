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

        private static List<string> Surgeries(PickleContext ctx, string raceName)
        {
            var race = DefDatabase<ThingDef>.GetNamedSilentFail(raceName);
            ctx.Require(race != null, $"no ThingDef named '{raceName}'");
            return race.AllRecipes.Where(r => r.IsSurgery).Select(r => r.defName).OrderBy(n => n, StringComparer.Ordinal).ToList();
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
