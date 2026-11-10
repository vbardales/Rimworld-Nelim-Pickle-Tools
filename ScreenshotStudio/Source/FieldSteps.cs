using System;
using System.Linq;
using RimWorks.Pickle;
using RimWorks.Pickle.Runtime;
using RimWorld;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// The "field" family: an open rectangle of ground found at run time near a colonist, then things placed by offset inside it. The fixtures
    /// are deserts with rock in them, so a rectangle picked by map coordinates can be rock, roofed or out of the colonist's reach; a scenario asks
    /// for a field near a colonist instead and uses offsets (0..17, 0..7). Taken from Eden Garden's suite and Malay Themed Expansion Renew's copy of it
    /// (both had the same code), written 2026-11-10 so that both drop their copies. Compiled, not played here (played in Eden Garden's own copy).
    /// </summary>
    [PickleSteps]
    public class FieldSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private const int FieldWidth = 18;
        private const int FieldHeight = 8;

        private sealed class Field
        {
            public IntVec3 Origin;
        }

        private static Map CurrentMap(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            return map;
        }

        private static ThingDef Def(PickleContext ctx, string defName)
        {
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, "no ThingDef named '" + defName + "' is loaded");
            return def;
        }

        private static IntVec3 FieldCell(PickleContext ctx, int dx, int dz)
        {
            Field field = null;
            try { field = ctx.Get<Field>(); }
            catch (InvalidOperationException) { }
            ctx.Require(field != null, "no field is laid yet: start the scenario with an open field step");
            ctx.Require(dx >= 0 && dx < FieldWidth && dz >= 0 && dz < FieldHeight,
                "the field cell (" + dx + ", " + dz + ") is outside the " + FieldWidth + " x " + FieldHeight + " field");
            return new IntVec3(field.Origin.x + dx, 0, field.Origin.z + dz);
        }

        private static CellRect FieldRect(PickleContext ctx, int dx1, int dz1, int dx2, int dz2)
        {
            IntVec3 a = FieldCell(ctx, dx1, dz1), b = FieldCell(ctx, dx2, dz2);
            return CellRect.FromLimits(a.x, a.z, b.x, b.z);
        }

        private static bool OpenCell(Map map, IntVec3 cell)
        {
            if (!cell.InBounds(map) || !cell.Standable(map) || cell.Roofed(map)) return false;
            TerrainDef terrain = cell.GetTerrain(map);
            if (terrain == null || terrain.passability == Traversability.Impassable || terrain.IsWater) return false;
            return !cell.GetThingList(map).Any(t => t.def.passability == Traversability.Impassable || t is Building);
        }

        private static void LayField(PickleContext ctx, string colonistName, bool soil)
        {
            Map map = CurrentMap(ctx);
            Pawn pawn = map.mapPawns.FreeColonists.FirstOrDefault(p => p.LabelShort == colonistName || p.Name?.ToStringShort == colonistName);
            ctx.Require(pawn != null, "no colonist named '" + colonistName + "' on the map");
            IntVec3 start = pawn.Position;
            IntVec3? best = null;
            int bestDistance = int.MaxValue;
            for (int ox = start.x - 45; ox <= start.x + 45; ox++)
            {
                for (int oz = start.z - 45; oz <= start.z + 45; oz++)
                {
                    int distance = Math.Abs(ox - start.x) + Math.Abs(oz - start.z);
                    if (distance >= bestDistance) continue;
                    var rect = new CellRect(ox, oz, FieldWidth, FieldHeight);
                    if (!rect.InBounds(map) || !rect.Cells.All(c => OpenCell(map, c))) continue;
                    var center = new IntVec3(ox + FieldWidth / 2, 0, oz + FieldHeight / 2);
                    if (!map.reachability.CanReach(start, center, PathEndMode.OnCell, TraverseParms.For(pawn))) continue;
                    best = new IntVec3(ox, 0, oz);
                    bestDistance = distance;
                }
            }

            ctx.Require(best.HasValue,
                "no " + FieldWidth + " x " + FieldHeight + " open field within 45 cells of '" + colonistName + "' at " + start + ": the fixture changed or the colonist is walled in");
            foreach (IntVec3 cell in new CellRect(best.Value.x, best.Value.z, FieldWidth, FieldHeight))
            {
                foreach (Thing thing in cell.GetThingList(map).ToList())
                    if (!(thing is Pawn) && thing.def.destroyable) thing.Destroy();
                if (soil) map.terrainGrid.SetTerrain(cell, TerrainDefOf.Soil);
            }

            ctx.Set(new Field { Origin = best.Value });
            Log.Message("[field] origin " + best.Value + ", " + FieldWidth + " x " + FieldHeight + ", nearest to '" + colonistName + "' at " + start);
        }

        /// <summary>Finds the open 18 x 8 rectangle nearest to the colonist (every cell standable, unroofed, no water, no building or impassable thing, reachable by the colonist, within 45 cells), destroys everything destroyable on it except pawns, and makes it the field the other field steps offset from. The terrain is left as it is.</summary>
        /// <param name="colonistName">a colonist's short name or nickname</param>
        [Given(Prefix + "an open field near {string} is cleared")]
        public void OpenField(PickleContext ctx, string colonistName) => LayField(ctx, colonistName, false);

        /// <summary>The same, and every cell of the field is laid as fertile soil (for growing zones).</summary>
        /// <param name="colonistName">a colonist's short name or nickname</param>
        [Given(Prefix + "an open field near {string} is cleared and laid as fertile soil")]
        public void OpenFieldSoil(PickleContext ctx, string colonistName) => LayField(ctx, colonistName, true);

        /// <summary>Lays a stockpile zone (the game's default filter: accepts everything) on the field cells of the rectangle, offsets from the field's corner. Fails when no field is laid, an offset is outside 0..17 x 0..7, or no cell is left. Create it before spawning what it should hold.</summary>
        [When(Prefix + "I create a stockpile in the field from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void CreateFieldStockpile(PickleContext ctx, int dx1, int dz1, int dx2, int dz2)
        {
            Map map = CurrentMap(ctx);
            var zone = new Zone_Stockpile(StorageSettingsPreset.DefaultStockpile, map.zoneManager);
            map.zoneManager.RegisterZone(zone);
            foreach (IntVec3 cell in FieldRect(ctx, dx1, dz1, dx2, dz2)) zone.AddCell(cell);
            ctx.Require(zone.Cells.Count > 0, "the stockpile holds no cell");
            Log.Message("[stockpile-created] " + zone.Cells.Count + " cells in the field, offsets (" + dx1 + ", " + dz1 + ") to (" + dx2 + ", " + dz2 + ")");
        }

        /// <summary>Lays a growing zone of a plant on the field cells of the rectangle. The def must be a plant.</summary>
        [When(Prefix + "I create a growing zone of {string} in the field from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void CreateFieldZone(PickleContext ctx, string plantDef, int dx1, int dz1, int dx2, int dz2)
        {
            Map map = CurrentMap(ctx);
            ThingDef def = Def(ctx, plantDef);
            ctx.Require(def.plant != null, "'" + plantDef + "' is not a plant");
            var zone = new Zone_Growing(map.zoneManager);
            map.zoneManager.RegisterZone(zone);
            foreach (IntVec3 cell in FieldRect(ctx, dx1, dz1, dx2, dz2)) zone.AddCell(cell);
            zone.SetPlantDefToGrow(def);
            ctx.Require(zone.Cells.Count > 0, "the growing zone holds no cell");
        }

        /// <summary>Asserts that a growing zone of the plant covers a field cell.</summary>
        [Then(Prefix + "a growing zone of {string} covers the field cell \\({int}, {int}\\)")]
        public void AssertFieldZone(PickleContext ctx, string plantDef, int dx, int dz)
        {
            Map map = CurrentMap(ctx);
            IntVec3 cell = FieldCell(ctx, dx, dz);
            var zone = map.zoneManager.ZoneAt(cell) as Zone_Growing;
            ctx.Assert(zone != null, "no growing zone covers the field cell (" + dx + ", " + dz + "), map cell " + cell);
            ctx.Assert(zone.GetPlantDefToGrow()?.defName == plantDef,
                "the growing zone at " + cell + " grows '" + (zone.GetPlantDefToGrow()?.defName ?? "nothing") + "', expected '" + plantDef + "'");
        }

        /// <summary>Builds a thing of a def (default stuff) as the colony's, facing north, on a field cell.</summary>
        [When(Prefix + "I build a {string} in the field at \\({int}, {int}\\)")]
        public void BuildInField(PickleContext ctx, string defName, int dx, int dz)
        {
            Map map = CurrentMap(ctx);
            ThingDef def = Def(ctx, defName);
            Thing thing = ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def));
            thing.SetFaction(Faction.OfPlayer);
            GenSpawn.Spawn(thing, FieldCell(ctx, dx, dz), map, Rot4.North);
            ctx.Assert(thing.Faction == Faction.OfPlayer, "the " + defName + " is still not the colony's");
        }

        /// <summary>Spawns one thing of a def on a field cell.</summary>
        [When(Prefix + "I spawn a {string} in the field at \\({int}, {int}\\)")]
        public void SpawnInField(PickleContext ctx, string defName, int dx, int dz)
            => GenSpawn.Spawn(ThingMaker.MakeThing(Def(ctx, defName)), FieldCell(ctx, dx, dz), CurrentMap(ctx));

        /// <summary>Spawns a stack of N things of a def on a field cell, or on the nearest free cell when it is taken (into a stockpile cell when one is there). Fails when there is no room.</summary>
        [When(Prefix + "{int} {string} is spawned in the field at \\({int}, {int}\\)")]
        public void SpawnStackInField(PickleContext ctx, int count, string defName, int dx, int dz)
        {
            Map map = CurrentMap(ctx);
            Thing thing = ThingMaker.MakeThing(Def(ctx, defName));
            thing.stackCount = count;
            ctx.Assert(GenPlace.TryPlaceThing(thing, FieldCell(ctx, dx, dz), map, ThingPlaceMode.Near),
                "no room to place " + count + " " + defName + " near the field cell (" + dx + ", " + dz + ")");
        }
    }
}
