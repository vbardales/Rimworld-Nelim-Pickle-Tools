using System;
using System.Globalization;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using Verse;
using RimWorld.Planet;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Reads a field of a GameComponent or a WorldComponent of the running game, by type name and field name, so a scenario can assert a value
    /// a mod keeps in its own component after "I save and reload". Written 2026-11-18 for Between Sus (S25). Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class GameComponentSteps
    {
        private const BindingFlags All = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;

        /// <summary>
        /// Asserts the field (or property) of the game component, or the world component, whose class name (short or full, case ignored) is given,
        /// reads the text. Numbers and booleans are compared as invariant text (<c>True</c>, <c>3</c>, <c>0.5</c>). Reads the component the game holds
        /// now, so it sees the value after a reload. The failure lists the components or the members.
        /// </summary>
        [Then("Nelim's Pickle Tools: the field {string} of the game component {string} is {string}")]
        public void FieldIs(PickleContext ctx, string member, string typeName, string expected)
        {
            object component = FindComponent(ctx, typeName);
            string actual = Read(ctx, component, member);
            ctx.Assert(string.Equals(actual, expected, StringComparison.OrdinalIgnoreCase),
                $"the field '{member}' of '{typeName}' reads '{actual}', not '{expected}'");
        }

        private static object FindComponent(PickleContext ctx, string typeName)
        {
            ctx.Require(Current.Game != null, "no game is running");
            Func<object, bool> match = c => string.Equals(c.GetType().Name, typeName, StringComparison.OrdinalIgnoreCase)
                || string.Equals(c.GetType().FullName, typeName, StringComparison.OrdinalIgnoreCase);
            object found = Current.Game.components.Cast<object>().FirstOrDefault(match);
            if (found == null && Find.World != null) found = Find.World.components.Cast<object>().FirstOrDefault(match);
            ctx.Require(found != null, $"no game or world component '{typeName}'; the game components are "
                + string.Join(", ", Current.Game.components.Select(c => c.GetType().Name))
                + (Find.World == null ? "" : "; the world components are " + string.Join(", ", Find.World.components.Select(c => c.GetType().Name))));
            return found;
        }

        private static string Read(PickleContext ctx, object o, string member)
        {
            Type t = o.GetType();
            object v;
            FieldInfo f = FindField(t, member);
            if (f != null) v = f.GetValue(o);
            else
            {
                PropertyInfo p = t.GetProperties(All).FirstOrDefault(x => x.GetIndexParameters().Length == 0 && x.CanRead
                    && string.Equals(x.Name, member, StringComparison.OrdinalIgnoreCase));
                ctx.Require(p != null, $"'{t.Name}' has no field or property '{member}'; it has "
                    + string.Join(", ", t.GetFields(All).Select(x => x.Name).Take(40)));
                v = p.GetValue(o, null);
            }
            return v == null ? "null" : Convert.ToString(v, CultureInfo.InvariantCulture);
        }

        private static FieldInfo FindField(Type t, string name)
        {
            for (; t != null; t = t.BaseType)
            {
                FieldInfo f = t.GetFields(All | BindingFlags.DeclaredOnly).FirstOrDefault(x => string.Equals(x.Name, name, StringComparison.OrdinalIgnoreCase));
                if (f != null) return f;
            }
            return null;
        }
    }
}
