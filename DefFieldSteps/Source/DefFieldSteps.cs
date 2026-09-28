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

            var formattable = value as IFormattable;
            return formattable != null ? formattable.ToString(null, CultureInfo.InvariantCulture) : value.ToString();
        }
    }
}
