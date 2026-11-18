using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using System.Text;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Writes the metadata of every ThingDef and TerrainDef of a mod, as the running game holds them (after the patches), one JSON line per def,
    /// for the catalogue registry (CaT, 2026-11-18). Compiled, NOT PLAYED when written. Everything the game may have moved is read by reflection,
    /// and a member that cannot be read gives null or an empty list, never a failure.
    /// </summary>
    [PickleSteps]
    public class DefMetadataSteps
    {
        private const BindingFlags All = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic;

        /// <summary>
        /// Logs and attaches (<c>def-metadata-PACKAGEID</c>, JSON lines) one line per ThingDef and TerrainDef whose mod has the package id (case
        /// ignored): packageId, defName, label, type, category (building, item, apparel, plant, floor, pawn, other), size, cost, stuffCategories, workToMake,
        /// textures, power, research, dependencies, techLevel, designationCategory, minifiable, minifiedDef and givers. Givers: bill, joy, sit, sleep,
        /// eat, research, store, medical, ritual (a heuristic on the class and the comps). NOT read: wash and work (no robust game link). Fails when the mod
        /// has no def of these two types.
        /// </summary>
        [Given("Nelim's Pickle Tools: the def metadata of the mod {string} is logged")]
        public void LogDefMetadata(PickleContext ctx, string packageId)
        {
            // The game generates a blueprint, a frame and an install blueprint for every building and floor of a mod (Blueprint_X, Frame_X, Install_X, Minified...):
            // they carry the mod's package id but are not content of the mod (found on Simple Ivory, ticket cf83, 2026-11-18): left out.
            Func<Def, bool> ofMod = d => d.modContentPack != null && string.Equals(d.modContentPack.PackageId, packageId, StringComparison.OrdinalIgnoreCase)
                && !(d is ThingDef && (d.defName.StartsWith("Blueprint_") || d.defName.StartsWith("Frame_") || d.defName.StartsWith("Install_") || d.defName.StartsWith("Minified")));
            List<ThingDef> things = DefDatabase<ThingDef>.AllDefs.Where(d => ofMod(d)).ToList();
            List<TerrainDef> terrains = DefDatabase<TerrainDef>.AllDefs.Where(d => ofMod(d)).ToList();
            ctx.Require(things.Count + terrains.Count > 0, $"the mod '{packageId}' has no ThingDef or TerrainDef (is it loaded? the package id must match its About.xml)");

            HashSet<string> joyThings = new HashSet<string>(DefDatabase<JoyGiverDef>.AllDefs.Where(j => j.thingDefs != null).SelectMany(j => j.thingDefs).Select(t => t.defName));
            var sb = new StringBuilder();
            foreach (ThingDef d in things.OrderBy(x => x.defName)) sb.AppendLine(ThingLine(d, joyThings));
            foreach (TerrainDef d in terrains.OrderBy(x => x.defName)) sb.AppendLine(TerrainLine(d));

            Log.Message($"[def-metadata] {packageId}: {things.Count} ThingDef, {terrains.Count} TerrainDef");
            ctx.Attach("def-metadata-" + packageId, sb.ToString());
        }

        private static string ThingLine(ThingDef d, HashSet<string> joyThings)
        {
            var o = new List<string>();
            Common(o, d, ThingCategoryOf(d));
            o.Add(N("size", d.size.x + "," + d.size.z));
            o.Add(L("cost", d.costList?.Select(c => c.thingDef.defName + ":" + c.count)));
            o.Add(N("costStuffCount", d.costStuffCount.ToString(CultureInfo.InvariantCulture)));
            o.Add(L("stuffCategories", d.stuffCategories?.Select(s => s.defName)));
            o.Add(N("workToMake", Stat(d, "WorkToBuild") ?? Stat(d, "WorkToMake")));
            o.Add(L("textures", Textures(d)));
            o.Add(N("power", Power(d)));
            o.Add(L("research", d.researchPrerequisites?.Select(r => r.defName)));
            o.Add(N("techLevel", d.techLevel.ToString()));
            o.Add(S("designationCategory", d.designationCategory?.defName));
            o.Add(B("minifiable", d.Minifiable));
            o.Add(S("minifiedDef", d.minifiedDef?.defName));
            o.Add(L("givers", Givers(d, joyThings)));
            return "{" + string.Join(",", o.Where(x => x != null)) + "}";
        }

        private static string TerrainLine(TerrainDef d)
        {
            var o = new List<string>();
            Common(o, d, "floor");
            o.Add(N("size", "1,1"));
            o.Add(L("cost", d.costList?.Select(c => c.thingDef.defName + ":" + c.count)));
            o.Add(N("costStuffCount", d.costStuffCount.ToString(CultureInfo.InvariantCulture)));
            o.Add(L("stuffCategories", d.stuffCategories?.Select(s => s.defName)));
            o.Add(N("workToMake", Stat(d, "WorkToBuild")));
            o.Add(L("textures", new[] { d.texturePath }.Where(t => !string.IsNullOrEmpty(t))));
            o.Add(N("power", null));
            o.Add(L("research", d.researchPrerequisites?.Select(r => r.defName)));
            o.Add(N("techLevel", null));
            o.Add(S("designationCategory", d.designationCategory?.defName));
            o.Add(B("minifiable", false));
            o.Add(S("minifiedDef", null));
            o.Add(L("givers", new string[0]));
            return "{" + string.Join(",", o.Where(x => x != null)) + "}";
        }

        private static void Common(List<string> o, Def d, string category)
        {
            o.Add(S("packageId", d.modContentPack?.PackageId));
            o.Add(S("defName", d.defName));
            o.Add(S("label", d.label));
            o.Add(S("type", d.GetType().Name));
            o.Add(S("category", category));
            o.Add(L("dependencies", Dependencies(d)));
        }

        private static string ThingCategoryOf(ThingDef d)
        {
            if (d.IsApparel) return "apparel";
            if (d.plant != null) return "plant";
            if (d.building != null) return "building";
            if (d.race != null) return "pawn";
            if (d.category == ThingCategory.Item) return "item";
            return "other";
        }

        // The package id of the mod and the hard dependencies its About.xml declares.
        private static IEnumerable<string> Dependencies(Def d)
        {
            var list = new List<string>();
            if (d.modContentPack == null) return list;
            list.Add(d.modContentPack.PackageId);
            try
            {
                object meta = d.modContentPack.ModMetaData;
                object deps = meta?.GetType().GetProperty("Dependencies", All)?.GetValue(meta, null);
                if (deps is System.Collections.IEnumerable e)
                    foreach (object dep in e)
                    {
                        string id = dep.GetType().GetField("packageId", All)?.GetValue(dep) as string
                            ?? dep.GetType().GetProperty("packageId", All)?.GetValue(dep, null) as string;
                        if (id != null) list.Add(id);
                    }
            }
            catch { }
            return list.Distinct();
        }

        private static IEnumerable<string> Textures(ThingDef d)
        {
            var list = new List<string>();
            if (!string.IsNullOrEmpty(d.graphicData?.texPath)) list.Add(d.graphicData.texPath);
            if (!string.IsNullOrEmpty(d.apparel?.wornGraphicPath)) list.Add(d.apparel.wornGraphicPath);
            return list;
        }

        private static string Power(ThingDef d)
        {
            try
            {
                CompProperties_Power p = d.comps?.OfType<CompProperties_Power>().FirstOrDefault();
                if (p == null) return null;
                // A producer has a negative consumption: watts the building draws (positive) or makes (negative).
                return p.PowerConsumption.ToString(CultureInfo.InvariantCulture);
            }
            catch { return null; }
        }

        private static string Stat(Def d, string statName)
        {
            try
            {
                StatDef stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
                if (stat == null) return null;
                if (d is ThingDef t) return t.GetStatValueAbstract(stat).ToString(CultureInfo.InvariantCulture);
                if (d is TerrainDef tr) return tr.GetStatValueAbstract(stat).ToString(CultureInfo.InvariantCulture);
            }
            catch { }
            return null;
        }

        private static IEnumerable<string> Givers(ThingDef d, HashSet<string> joyThings)
        {
            var g = new List<string>();
            try { if (d.AllRecipes != null && d.AllRecipes.Count > 0) g.Add("bill"); } catch { }
            if (d.building != null && d.building.joyKind != null || joyThings.Contains(d.defName)) g.Add("joy");
            if (d.building != null && d.building.isSittable) g.Add("sit");
            if (d.IsBed) g.Add("sleep");
            if (BoolOf(d, "IsFoodDispenser") || BoolOf(d, "IsNutrientPasteDispenser") || (d.building != null && BoolOf(d.building, "isMealSource"))) g.Add("eat");
            if (BoolOf(d, "IsResearchBench")) g.Add("research");
            if (d.building != null && (d.building.fixedStorageSettings != null || typeof(Building_Storage).IsAssignableFrom(d.thingClass))) g.Add("store");
            if (d.IsBed && d.building != null && BoolOf(d.building, "bed_defaultMedical")) g.Add("medical");
            if (Ritual(d)) g.Add("ritual");
            return g;
        }

        // Heuristic: an altar, a lectern, a ritual spot or an ideogram: the thing class, or one of its comps, has Ritual, Altar or Lectern in its name.
        private static bool Ritual(ThingDef d)
        {
            Func<string, bool> hit = n => n != null && (n.IndexOf("Ritual", StringComparison.OrdinalIgnoreCase) >= 0
                || n.IndexOf("Altar", StringComparison.OrdinalIgnoreCase) >= 0 || n.IndexOf("Lectern", StringComparison.OrdinalIgnoreCase) >= 0);
            return hit(d.thingClass?.Name) || (d.comps != null && d.comps.Any(c => hit(c.compClass?.Name) || hit(c.GetType().Name)));
        }

        private static bool BoolOf(object o, string name)
        {
            try
            {
                Type t = o.GetType();
                object v = t.GetProperty(name, All)?.GetValue(o, null) ?? t.GetField(name, All)?.GetValue(o);
                return v is bool b && b;
            }
            catch { return false; }
        }

        private static string Esc(string s)
        {
            var sb = new StringBuilder("\"");
            foreach (char c in s ?? "")
            {
                if (c == '"' || c == '\\') sb.Append('\\').Append(c);
                else if (c == '\n') sb.Append("\\n");
                else if (c == '\r') { }
                else if (c < 0x20) sb.Append(' ');
                else sb.Append(c);
            }
            return sb.Append('"').ToString();
        }

        private static string S(string key, string value) => "\"" + key + "\":" + (value == null ? "null" : Esc(value));
        private static string N(string key, string value) => "\"" + key + "\":" + (value == null ? "null" : Esc(value));
        private static string B(string key, bool value) => "\"" + key + "\":" + (value ? "true" : "false");
        private static string L(string key, IEnumerable<string> values) => "\"" + key + "\":[" + string.Join(",", (values ?? new string[0]).Select(Esc)) + "]";
    }
}
