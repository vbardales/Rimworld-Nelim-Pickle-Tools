using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Lists, in the log, every value the look steps accept in the loaded game, mod by mod: hairstyles, beards, head types, tattoos, bodies and
    /// garments. It is how a catalogue of the options is made (docs/CATALOGUE-LOOKS.md): played once on a pass that stages the mods whose
    /// options are wanted, then the lines are copied into the catalogue. Written 2026-10-15 at the owner's request, so that the sessions that
    /// choose what a pawn wears, its hair and its face can pick from a list. Not played here.
    /// </summary>
    [PickleSteps]
    public class LookCatalogueSteps
    {
        /// <summary>
        /// Logs the hairstyles (<c>[look-hair]</c>), beards (<c>[look-beard]</c>), head types (<c>[look-head]</c>), tattoos (<c>[look-tattoo]</c>)
        /// and body types (<c>[look-body]</c>) of the game, one line per mod with the defNames, the ones the look steps take. A hairstyle is
        /// followed by its gender when it has one (<c>Male</c>, <c>Female</c>), a head type by its gender. Never fails.
        /// </summary>
        [Given("Nelim's Pickle Tools: the hair, beard, head, tattoo and body options are listed")]
        public void ListLooks(PickleContext ctx)
        {
            Dump("look-hair", DefDatabase<HairDef>.AllDefsListForReading, d => d.defName + Tag(d.styleGender.ToString(), "Any"));
            Dump("look-beard", DefDatabase<BeardDef>.AllDefsListForReading, d => d.defName);
            Dump("look-head", DefDatabase<HeadTypeDef>.AllDefsListForReading, d => d.defName + Tag(d.gender.ToString(), "None"));
            Dump("look-tattoo", DefDatabase<TattooDef>.AllDefsListForReading, d => d.defName + Tag(d.tattooType.ToString(), "None"));
            Dump("look-body", DefDatabase<BodyTypeDef>.AllDefsListForReading, d => d.defName);
        }

        /// <summary>
        /// Logs the garments of the game (<c>[look-apparel]</c>): one line per mod and per layer, each defName followed by the body part groups it
        /// covers, so a session can choose a garment and know what it covers (a hat and a jacket do not take the same place). Only the apparel
        /// defs that are not abstract and not a bare "tradeable" stub. Never fails.
        /// </summary>
        [Given("Nelim's Pickle Tools: the garment options are listed")]
        public void ListApparel(PickleContext ctx)
        {
            List<ThingDef> apparel = DefDatabase<ThingDef>.AllDefsListForReading.Where(d => d.IsApparel && d.apparel != null).ToList();
            foreach (var mod in apparel.GroupBy(d => d.modContentPack?.Name ?? "(none)").OrderBy(g => g.Key))
            {
                foreach (var layer in mod.GroupBy(d => string.Join("+", d.apparel.layers.Select(l => l.defName).OrderBy(n => n))).OrderBy(g => g.Key))
                {
                    string items = string.Join(", ", layer.Select(d => d.defName + "[" + string.Join("/", d.apparel.bodyPartGroups.Select(b => b.defName)) + "]").OrderBy(n => n));
                    Log.Message("[look-apparel] " + mod.Key + " | " + layer.Key + " (" + layer.Count() + "): " + items);
                }
            }

            Log.Message("[look-apparel] total " + apparel.Count);
        }

        /// <summary>
        /// Logs every colour def of the game (<c>[look-colour]</c>): one line per mod and per colour type (Hair, Ideology, Structure, Misc), each defName
        /// followed by its colour as hex, so a session can choose a hair dye, an ideology garment colour or a floor paint by name. Never fails.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colour options are listed")]
        public void ListColours(PickleContext ctx)
        {
            List<ColorDef> all = DefDatabase<ColorDef>.AllDefsListForReading.ToList();
            foreach (var mod in all.GroupBy(d => d.modContentPack?.Name ?? "(none)").OrderBy(g => g.Key))
            {
                foreach (var type in mod.GroupBy(d => d.colorType.ToString()).OrderBy(g => g.Key))
                {
                    Log.Message("[look-colour] " + mod.Key + " | " + type.Key + " (" + type.Count() + "): " + string.Join(", ", type.Select(d => d.defName + "#" + ColorUtility.ToHtmlStringRGB(d.color)).OrderBy(n => n)));
                }
            }

            Log.Message("[look-colour] total " + all.Count);
        }

        /// <summary>
        /// Logs the weapons (<c>[look-weapon]</c>: one line per mod and per kind, Melee or Ranged, each defName) and what the game can craft (<c>[look-craft]</c>:
        /// one line per mod and per work table, each defName of the products of the recipes it offers, with the recipe count), so a session can pick a weapon
        /// or a craftable item by name. Never fails.
        /// </summary>
        [Given("Nelim's Pickle Tools: the weapon and craftable options are listed")]
        public void ListWeaponsAndCrafts(PickleContext ctx)
        {
            List<ThingDef> weapons = DefDatabase<ThingDef>.AllDefsListForReading.Where(d => d.IsWeapon).ToList();
            foreach (var mod in weapons.GroupBy(d => d.modContentPack?.Name ?? "(none)").OrderBy(g => g.Key))
            {
                foreach (var kind in mod.GroupBy(d => d.IsRangedWeapon ? "Ranged" : "Melee").OrderBy(g => g.Key))
                {
                    Log.Message("[look-weapon] " + mod.Key + " | " + kind.Key + " (" + kind.Count() + "): " + string.Join(", ", kind.Select(d => d.defName).OrderBy(n => n)));
                }
            }

            Log.Message("[look-weapon] total " + weapons.Count);
            int recipes = 0;
            foreach (var mod in DefDatabase<RecipeDef>.AllDefsListForReading.Where(r => r.products != null && r.products.Count > 0 && r.recipeUsers != null && r.recipeUsers.Count > 0).GroupBy(r => r.modContentPack?.Name ?? "(none)").OrderBy(g => g.Key))
            {
                var benches = mod.SelectMany(r => r.recipeUsers.Select(u => new { Bench = u.defName, Recipe = r })).GroupBy(x => x.Bench).OrderBy(g => g.Key);
                foreach (var bench in benches)
                {
                    recipes += bench.Count();
                    Log.Message("[look-craft] " + mod.Key + " | " + bench.Key + " (" + bench.Count() + "): " + string.Join(", ", bench.SelectMany(x => x.Recipe.products.Select(p => p.thingDef.defName)).Distinct().OrderBy(n => n)));
                }
            }

            Log.Message("[look-craft] total " + recipes);
        }

        private static string Tag(string value, string none)
        {
            return value == none ? string.Empty : " (" + value + ")";
        }

        private static void Dump<T>(string tag, IEnumerable<T> defs, System.Func<T, string> name)
            where T : Def
        {
            List<T> all = defs.ToList();
            foreach (var mod in all.GroupBy(d => d.modContentPack?.Name ?? "(none)").OrderBy(g => g.Key))
            {
                Log.Message("[" + tag + "] " + mod.Key + " (" + mod.Count() + "): " + string.Join(", ", mod.Select(name).OrderBy(n => n)));
            }

            Log.Message("[" + tag + "] total " + all.Count);
        }
    }
}
