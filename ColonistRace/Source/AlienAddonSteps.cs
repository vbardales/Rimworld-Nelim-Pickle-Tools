using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Lists the Humanoid Alien Races body addons of a colonist and sets the variant of one. HAR draws an addon's variant from
    /// <c>AlienComp.addonVariants</c>, chosen at random when the pawn is generated, and offers no gene or setting to pick one: the original
    /// Seren draws its body masks that way. Everything is reached by reflection, so this assembly needs no reference to HAR and loads
    /// without it (a pawn of a race that is not a HAR race fails with a message that says so).
    ///
    /// Written 2026-10-31 at the request of SerenBiotechExtended (original Seren body mask 6 on every body type). NOT PLAYED: compiled
    /// against the reference assemblies, with the member names read from AlienRace.dll's metadata (addonVariants, addonGraphics,
    /// alienRace.generalSettings.alienPartGenerator.bodyAddons, BodyAddon.path and variantCount); the first run says whether they hold.
    /// </summary>
    [PickleSteps]
    public class AlienAddonSteps
    {
        private const BindingFlags Any = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance;

        /// <summary>
        /// Logs (<c>[alien-addon]</c>, one line per body addon in the order of the race definition) the index, path, body part, variant count
        /// and current variant of every Humanoid Alien Races body addon of the colonist, and attaches the same text as <c>alien-addons</c>.
        /// Never fails on a race with no addons; fails on a pawn that is not of a HAR race. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the alien addons of {string} are listed")]
        public void List(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            string text = Describe(ctx, pawn, out _, out _);
            foreach (string line in text.Split('\n')) Log.Message("[alien-addon] " + line);
            ctx.Attach("alien-addons", text);
        }

        /// <summary>
        /// Sets the variant of the body addon whose path equals the given text, or ends with it, and redraws the pawn. The variant must be
        /// below the addon's variant count. Reads the value back and fails listing every addon when none matches or the value did not
        /// stick. NOT PLAYED when written.
        /// </summary>
        [When("Nelim's Pickle Tools: {string} alien addon {string} variant is {int}")]
        public void SetVariant(PickleContext ctx, string nickname, string addon, int variant)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            string listing = Describe(ctx, pawn, out IList addons, out object comp);
            int index = -1;
            for (int i = 0; i < addons.Count; i++)
            {
                string path = Field<string>(addons[i], "path") ?? "";
                if (string.Equals(path, addon, StringComparison.OrdinalIgnoreCase) || path.EndsWith(addon, StringComparison.OrdinalIgnoreCase)) { index = i; break; }
            }
            ctx.Require(index >= 0, $"no body addon of '{nickname}' has the path '{addon}'. The addons are:\n{listing}");

            int count = Field<int>(addons[index], "variantCount");
            ctx.Assert(variant >= 0 && variant < Math.Max(count, 1), $"variant {variant} is out of range for '{addon}': it has {count} variant(s) (0 to {Math.Max(count, 1) - 1})");

            var variants = FieldValue(comp, "addonVariants") as IList<int>;
            ctx.Require(variants != null, $"the AlienComp of '{nickname}' has no addonVariants list; the HAR build on disk differs from the one this step was written for");
            while (variants.Count <= index) variants.Add(0);
            variants[index] = variant;
            pawn.Drawer.renderer.SetAllGraphicsDirty();

            ctx.Assert(variants[index] == variant, $"the variant of '{addon}' reads {variants[index]} after setting {variant}: something reset it. The addons are:\n{Describe(ctx, pawn, out _, out _)}");
            ctx.Attach("alien-addon", $"{nickname}: addon {index} '{Field<string>(addons[index], "path")}' variant set to {variant} of {count}");
        }

        private static string Describe(PickleContext ctx, Pawn pawn, out IList addons, out object comp)
        {
            comp = pawn.AllComps.FirstOrDefault(c => c.GetType().Name == "AlienComp");
            ctx.Require(comp != null, $"'{pawn.Name?.ToStringShort}' has no AlienComp: its race '{pawn.def.defName}' is not a Humanoid Alien Races race (generate the pawn from an alien kind)");
            object race = FieldValue(pawn.def, "alienRace");
            object general = FieldValue(race, "generalSettings");
            object generator = FieldValue(general, "alienPartGenerator");
            addons = FieldValue(generator, "bodyAddons") as IList ?? new List<object>();
            var variants = FieldValue(comp, "addonVariants") as IList<int>;

            var text = new StringBuilder();
            for (int i = 0; i < addons.Count; i++)
            {
                object bodyPart = FieldValue(addons[i], "bodyPart");
                text.Append(i).Append(" path=").Append(Field<string>(addons[i], "path"))
                    .Append(" bodyPart=").Append(bodyPart?.ToString() ?? "(none)")
                    .Append(" variantCount=").Append(Field<int>(addons[i], "variantCount"))
                    .Append(" variant=").Append(variants != null && i < variants.Count ? variants[i].ToString() : "?")
                    .Append('\n');
            }

            text.Append("total ").Append(addons.Count);
            return text.ToString();
        }

        private static object FieldValue(object target, string name)
        {
            if (target == null) return null;
            for (Type t = target.GetType(); t != null; t = t.BaseType)
            {
                FieldInfo field = t.GetField(name, Any | BindingFlags.DeclaredOnly);
                if (field != null) return field.GetValue(target);
                PropertyInfo property = t.GetProperty(name, Any | BindingFlags.DeclaredOnly);
                if (property != null && property.GetIndexParameters().Length == 0) return property.GetValue(target, null);
            }

            return null;
        }

        private static T Field<T>(object target, string name)
        {
            object value = FieldValue(target, name);
            return value is T typed ? typed : default(T);
        }
    }
}
