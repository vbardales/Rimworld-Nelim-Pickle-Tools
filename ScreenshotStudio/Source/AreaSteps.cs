using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorks.Pickle.Runtime;
using RimWorld;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>A rectangle of map cells, both corners included. The corners may be given in any order.</summary>
    public readonly struct MapArea
    {
        public readonly int MinX, MaxX, MinZ, MaxZ;

        public MapArea(int x0, int z0, int x1, int z1)
        {
            MinX = Math.Min(x0, x1); MaxX = Math.Max(x0, x1);
            MinZ = Math.Min(z0, z1); MaxZ = Math.Max(z0, z1);
        }

        /// <summary>The square a camera centred on (x, z) at this root size shows on a 16:9 screen: x ± ceil(size × 16 / 9), z ± ceil(size).</summary>
        public static MapArea OfCamera(int x, int z, float rootSize)
        {
            int hx = Mathf.CeilToInt(rootSize * 16f / 9f), hz = Mathf.CeilToInt(rootSize);
            return new MapArea(x - hx, z - hz, x + hx, z + hz);
        }

        /// <summary>The cells the camera shows right now (the game's own view rectangle, clipped to the map): what a capture taken now contains.</summary>
        public static MapArea OfView()
        {
            CellRect r = Find.CameraDriver.CurrentViewRect.ClipInsideMap(Find.CurrentMap);
            return new MapArea(r.minX, r.minZ, r.maxX, r.maxZ);
        }

        public bool Contains(IntVec3 c) => c.x >= MinX && c.x <= MaxX && c.z >= MinZ && c.z <= MaxZ;

        public IEnumerable<IntVec3> Cells(Map map)
        {
            for (int x = MinX; x <= MaxX; x++)
                for (int z = MinZ; z <= MaxZ; z++)
                {
                    var c = new IntVec3(x, 0, z);
                    if (c.InBounds(map)) yield return c;
                }
        }

        public override string ToString() => "(" + MinX + ", " + MinZ + ") to (" + MaxX + ", " + MaxZ + ")";
    }

    /// <summary>
    /// What a scenario does to a rectangle of the map before a capture, as plain static methods another assembly may call (a suite that names its
    /// own places resolves a name to a <see cref="MapArea"/> and calls these) and as Gherkin steps taking the rectangle (class <see cref="AreaSteps"/>).
    /// Every method works on the running scene only: the save on disk is not touched.
    /// </summary>
    public static class AreaOps
    {
        private static readonly List<Action> KeepOutHooks = new List<Action>();
        private static Map lastFramedMap;

        // Not map.mapPawns: its accessors throw "Accessing map pawns off main thread" when a step runs off the main thread (EntityGazing gallery-8, 2026-10-15).
        internal static IEnumerable<Pawn> SpawnedPawns(Map map) => map == null ? Enumerable.Empty<Pawn>() : map.listerThings.ThingsInGroup(ThingRequestGroup.Pawn).OfType<Pawn>().Where(p => p.Spawned).ToList();

        private static Map RequireMap(PickleContext ctx)
        {
            ctx.Require(Find.CurrentMap != null, "Load a map first");
            return Find.CurrentMap;
        }

        // The game keeps the camera root size between 11 and 60 (CameraMapConfig.sizeRange); a tighter or wider frame needs the range widened first.
        public static void LiftZoomLimit()
        {
            object config = Find.CameraDriver?.config;
            var field = config?.GetType().GetField("sizeRange");
            if (field != null && field.FieldType == typeof(FloatRange)) field.SetValue(config, new FloatRange(2f, 130f));
            else Log.Warning("[frame] CameraMapConfig.sizeRange not found: the zoom stays limited to the game's own range");
        }

        /// <summary>
        /// Lifts the zoom limit, clears the selection, jumps the camera to the cell and sets the root size (smaller is closer), waits 90 frames for
        /// the zoom, then waits (600 frames at most) until the sky glow holds still so that two shots of one run have the same light.
        /// </summary>
        public static async Task Frame(PickleContext ctx, int x, int z, float rootSize)
        {
            RequireMap(ctx);
            LiftZoomLimit();
            // Asked again for the place it already shows (a scenario that frames the same place before every shot): nothing to wait for. Each wait is
            // 90 frames, 33 s on a machine short of memory (VenusTouchWaistlines 405b, 2026-10-20: nine waits of that kind outlast the 300 s of a scenario).
            if (Find.CameraDriver.MapPosition == new IntVec3(x, 0, z) && Mathf.Abs(Find.CameraDriver.RootSize - rootSize) < 0.05f && lastFramedMap == Find.CurrentMap)
            {
                Find.Selector.ClearSelection();
                await ctx.WaitFrames(1);
                Log.Message("[frame] already at (" + x + ", " + z + ") root size " + rootSize + ": no wait");
                return;
            }

            Find.Selector.ClearSelection();
            Find.CameraDriver.JumpToCurrentMapLoc(new IntVec3(x, 0, z));
            Find.CameraDriver.SetRootSize(rootSize);
            var clock = System.Diagnostics.Stopwatch.StartNew();
            await ctx.WaitFrames(90);
            long zoomMs = clock.ElapsedMilliseconds;
            float last = -1f; int still = 0;
            // The light wait stops after 15 s of wall clock too: at a few frames a second 600 frames outlast the 60 s a frame step is given
            // (VenusTouchWaistlines tickets 4b8e, 73de, 2026-10-19: "timed out after 60s").
            for (int i = 0; i < 600 && still < 20 && clock.ElapsedMilliseconds - zoomMs < 15000; i++)
            {
                float glow = Find.CurrentMap.skyManager.CurSkyGlow;
                still = Math.Abs(glow - last) < 0.0005f ? still + 1 : 0;
                last = glow;
                await ctx.WaitFrames(1);
            }
            Log.Message("[frame] asked (" + x + ", " + z + ") root size " + rootSize + ", camera at " + Find.CameraDriver.MapPosition + ", root size " + Find.CameraDriver.RootSize.ToString("0.0") + ", sky glow " + last.ToString("0.00") + "; zoom wait " + zoomMs + " ms, total " + clock.ElapsedMilliseconds + " ms");
            lastFramedMap = Find.CurrentMap;
        }

        /// <summary>
        /// Destroys every thing in the area: furniture, items, plants, filth, corpses. Pawns, walls, doors, natural rock, ethereal things and
        /// projectiles stay. Terrain and roofs are untouched. Returns how many things were destroyed.
        /// </summary>
        public static int Empty(PickleContext ctx, MapArea area) => Empty(ctx, area, false);

        /// <summary>
        /// The same, and with <paramref name="keepRoofHolders"/> the things that hold a roof up (columns, pillars: ThingDef.holdsRoof) stay too, because the
        /// game collapses an unsupported roof the moment its holder is despawned (a "Roof collapse" letter, dust and unroofed cells in the shot) and putting
        /// the holder back afterwards does not undo it.
        /// </summary>
        public static int Empty(PickleContext ctx, MapArea area, bool keepRoofHolders)
        {
            Map map = RequireMap(ctx);
            var doomed = map.listerThings.AllThings.Where(t => area.Contains(t.Position) && !(keepRoofHolders && t.def.holdsRoof)
                && !(t is Pawn) && t.def.category != ThingCategory.Ethereal && t.def.category != ThingCategory.Projectile
                && !(t.def.building != null && (t.def.IsDoor || t.def.defName.EndsWith("Wall") || t.def.building.isNaturalRock))).ToList();
            foreach (var t in doomed) if (!t.Destroyed) t.Destroy();
            return doomed.Count;
        }

        /// <summary>
        /// Gives every dry cell of the area the terrain read on ONE sample cell and removes the paint of the cell. Without <paramref name="sample"/>
        /// the sample is the cell 3 cells west of the area at the middle of its height; water or impassable terrain there falls back to Soil.
        /// Water cells of the area are skipped; roofs, things and walls stay. One sample for the whole area: in an enclosure or on mixed ground
        /// pass a sample cell inside it, or the result is not what the place looked like.
        /// </summary>
        public static void BareFloor(PickleContext ctx, MapArea area, IntVec3? sample = null)
        {
            Map map = RequireMap(ctx);
            IntVec3 from = sample ?? new IntVec3(Math.Max(0, area.MinX - 3), 0, (area.MinZ + area.MaxZ) / 2);
            ctx.Require(from.InBounds(map), "the terrain sample cell " + from + " is outside the map");
            TerrainDef ground = from.GetTerrain(map);
            if (ground == null || ground.IsWater || ground.passability == Traversability.Impassable) ground = DefDatabase<TerrainDef>.GetNamed("Soil");
            foreach (var c in area.Cells(map))
            {
                if (c.GetTerrain(map).IsWater) continue;
                map.terrainGrid.SetTerrain(c, ground);
                map.terrainGrid.SetTerrainColor(c, null);
            }
        }

        /// <summary>
        /// Sets every dry cell of the area to the named terrain (<c>TerrainDef</c> defName, for instance <c>Concrete</c> or <c>Soil</c>) and removes
        /// the paint. Water cells are skipped. Fails when the terrain does not exist. Roofs, things and walls stay. NOT PLAYED when written (2026-10-30,
        /// for AnimalsNaturally's neutral-ground captures).
        /// </summary>
        public static void SetFloor(PickleContext ctx, MapArea area, string terrainDefName)
        {
            Map map = RequireMap(ctx);
            TerrainDef ground = DefDatabase<TerrainDef>.GetNamedSilentFail(terrainDefName);
            ctx.Require(ground != null, "no terrain '" + terrainDefName + "' (is the mod that defines it loaded in this pass?)");
            foreach (var c in area.Cells(map))
            {
                if (c.GetTerrain(map).IsWater) continue;
                map.terrainGrid.SetTerrain(c, ground);
                map.terrainGrid.SetTerrainColor(c, null);
            }
        }

        /// <summary>Despawns (does not kill) the animals standing in the area now, once: an animal that walks in later stays. Returns how many.</summary>
        public static int RemoveAnimals(PickleContext ctx, MapArea area)
        {
            Map map = RequireMap(ctx);
            var animals = AreaOps.SpawnedPawns(map).Where(p => p.RaceProps.Animal && area.Contains(p.Position)).ToList();
            foreach (var a in animals) a.DeSpawn();
            return animals.Count;
        }

        /// <summary>
        /// Despawns the animals of the area now, then on every frame until the scenario ends (animals come back through the doors). May be called
        /// for several areas. The hooks are removed after the scenario by <see cref="AreaSteps"/>, so the assembly needs no clean-up of its own.
        /// </summary>
        public static void KeepAnimalsOut(PickleContext ctx, MapArea area) => KeepAnimalsOut(ctx, area, null);

        /// <summary>The same, except the animal whose short name (<c>Name.ToStringShort</c>, as the animal steps of ColonistRace find it) is given: it stays and is not despawned.</summary>
        public static void KeepAnimalsOut(PickleContext ctx, MapArea area, string exceptName)
        {
            RequireMap(ctx);
            Func<Pawn, bool> spared = p => !string.IsNullOrEmpty(exceptName) && string.Equals(p.Name?.ToStringShort ?? p.LabelShort, exceptName, StringComparison.OrdinalIgnoreCase);
            Action hook = () =>
            {
                Map map = Find.CurrentMap;
                if (map == null) return;
                foreach (var a in AreaOps.SpawnedPawns(map).Where(p => p.RaceProps.Animal && area.Contains(p.Position) && !spared(p)).ToList()) a.DeSpawn();
            };
            hook();
            KeepOutHooks.Add(hook);
            PickleDriver.Instance.AddFrameHook(hook);
        }

        /// <summary>Removes every roof of the area, so the sun lights it. Thick roofs (mountain) stay. Walls, things and terrain stay. Returns how many cells lost a roof.</summary>
        public static int RemoveRoof(PickleContext ctx, MapArea area)
        {
            Map map = RequireMap(ctx);
            int removed = 0;
            foreach (var c in area.Cells(map))
            {
                RoofDef roof = map.roofGrid.RoofAt(c);
                if (roof == null || roof.isThickRoof) continue;
                map.roofGrid.SetRoof(c, null);
                removed++;
            }
            return removed;
        }

        /// <summary>
        /// Despawns every spawned thing of this def within <paramref name="radius"/> cells (square, both axes) of the cell, for this run only.
        /// Fails when none is there, so a save that changed, or a step that ran twice, is told. Returns how many were hidden.
        /// </summary>
        public static int HideThings(PickleContext ctx, string defName, int x, int z, int radius, bool mustFind = true)
        {
            Map map = RequireMap(ctx);
            // defName is one exact defName or several separated by commas (spaces around them ignored).
            var names = defName.Split(',').Select(n => n.Trim()).Where(n => n.Length > 0).ToList();
            var found = map.listerThings.AllThings.Where(t => t.Spawned && names.Contains(t.def.defName)
                && Math.Abs(t.Position.x - x) <= radius && Math.Abs(t.Position.z - z) <= radius).ToList();
            Log.Message("[hide-things] " + found.Count + " of " + defName + " within " + radius + " cells of (" + x + ", " + z + "): " + string.Join(", ", found.Select(t => t.def.defName + "@" + t.Position.x + "," + t.Position.z)));
            ctx.Require(found.Count > 0 || !mustFind, "No " + defName + " within " + radius + " cells of (" + x + ", " + z + "): the save changed, or the step already ran");
            foreach (var t in found) t.DeSpawn();
            return found.Count;
        }

        /// <summary>
        /// Logs (<c>[things-near]</c>) and attaches to the report (<c>things-near</c>) every spawned thing within <paramref name="radius"/> cells (square) of the cell that is
        /// not a pawn, filth or mote: defName, position and class, so a hide step can name the right defNames. Reads only. Written 2026-10-30 for GeniusesCraftFast.
        /// </summary>
        public static void ListThingsNear(PickleContext ctx, int x, int z, int radius)
        {
            Map map = RequireMap(ctx);
            var found = map.listerThings.AllThings.Where(t => t.Spawned && !(t is Pawn) && !(t is Filth) && !(t is Mote)
                && Math.Abs(t.Position.x - x) <= radius && Math.Abs(t.Position.z - z) <= radius).OrderBy(t => t.def.defName).ThenBy(t => t.Position.x).ThenBy(t => t.Position.z).ToList();
            string report = found.Count + " thing(s) within " + radius + " cells of (" + x + ", " + z + ")\n"
                + string.Join("\n", found.Select(t => t.def.defName + "@" + t.Position.x + "," + t.Position.z + " (" + t.GetType().Name + ", " + t.def.category + ")"));
            Log.Message("[things-near] " + report);
            ctx.Attach("things-near", report);
        }

        /// <summary>
        /// Despawns every artificial building (<c>ThingDef.IsBuildingArtificial</c>: not natural rock) within <paramref name="radius"/> cells (square) of the cell, for this run
        /// only. What lowers the meditation focus of an anima tree or any focus object (the red lines drawn when it is selected) is the set of artificial buildings and some named
        /// things within its radius. Does not fail when none is there. Returns how many were hidden.
        /// </summary>
        public static int HideArtificialBuildings(PickleContext ctx, int x, int z, int radius)
        {
            Map map = RequireMap(ctx);
            var found = map.listerThings.AllThings.Where(t => t.Spawned && t.def.IsBuildingArtificial
                && Math.Abs(t.Position.x - x) <= radius && Math.Abs(t.Position.z - z) <= radius).ToList();
            Log.Message("[hide-buildings] " + found.Count + " artificial building(s) within " + radius + " cells of (" + x + ", " + z + "): " + string.Join(", ", found.Select(t => t.def.defName + "@" + t.Position.x + "," + t.Position.z + " (" + t.GetType().Name + ")")));
            foreach (var t in found) t.DeSpawn();
            return found.Count;
        }

        /// <summary>
        /// Logs (lines starting <c>[free-cells]</c>) the cells of the rectangle a pawn can stand on with nothing on them (no building, item, plant,
        /// pawn or blueprint; filth and motes do not count), as runs per row, the top row (largest z) first: the format of the old
        /// sanctuary listing. A cell with a wall, a rock or any impassable thing is not standable and is left out.
        /// </summary>
        public static void ListFreeCells(PickleContext ctx, MapArea area)
        {
            Map map = RequireMap(ctx);
            var rows = new List<string>();
            int total = 0;
            for (int z = area.MaxZ; z >= area.MinZ; z--)
            {
                var runs = new List<string>();
                int start = int.MinValue, prev = int.MinValue;
                for (int x = area.MinX; x <= area.MaxX + 1; x++)
                {
                    bool free = x <= area.MaxX && IsFreeStandable(map, new IntVec3(x, 0, z));
                    if (free)
                    {
                        total++;
                        if (start == int.MinValue) start = x;
                        prev = x;
                    }
                    else if (start != int.MinValue)
                    {
                        runs.Add(start == prev ? start.ToString() : start + "-" + prev);
                        start = int.MinValue;
                    }
                }
                rows.Add(z + ": " + (runs.Count == 0 ? "none" : string.Join(", ", runs)));
            }
            string report = "area " + area + ", " + total + " free standable cell(s), runs per row z: x1-x2\n" + string.Join("\n", rows);
            Log.Message("[free-cells] " + report);
            ctx.Attach("free-cells", report);
        }

        private static bool IsFreeStandable(Map map, IntVec3 c)
        {
            if (!c.InBounds(map) || !c.Walkable(map) || !c.Standable(map)) return false;
            foreach (Thing t in map.thingGrid.ThingsListAtFast(c))
                if (!(t is Filth) && !(t is Mote)) return false;
            return true;
        }

        internal static void StopKeepingAnimalsOut()
        {
            foreach (var hook in KeepOutHooks) PickleDriver.Instance?.RemoveFrameHook(hook);
            KeepOutHooks.Clear();
        }
    }

    /// <summary>The same operations as steps, on a rectangle given by its two corners (cells, either order).</summary>
    [PickleSteps]
    public class AreaSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";

        /// <summary>Centres the camera on a cell at a root size (smaller is closer, down to 2 and up to 130: the game's own limit is lifted) and waits until the sky glow holds still. Same as framing a rectangle, but the zoom is the one asked for.</summary>
        [When(Prefix + "I frame the area centred on \\({int}, {int}\\) at root size {float}", TimeoutSeconds = 60f)]
        public Task Frame(PickleContext ctx, int x, int z, float rootSize) => AreaOps.Frame(ctx, x, z, rootSize);

        /// <summary>Destroys the furniture, items, plants, filth and corpses of the rectangle. Pawns, walls, doors and natural rock stay; terrain and roofs are untouched.</summary>
        [Given(Prefix + "the area from \\({int}, {int}\\) to \\({int}, {int}\\) is emptied")]
        public void Empty(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.Empty(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>
        /// Logs ([zone-bounds]) every zone of the map whose label contains a text: its kind, its cell count, the min and max x and z of its cells, and the
        /// plants standing on it by def. Never fails on a missing zone (it logs that none matched), so a feature can look before it plants.
        /// Written 2026-11-06 for the sanctuary (rice zones, dump zone). Compiled, not played.
        /// </summary>
        /// <param name="label">a text the zone's label contains, case insensitive, for instance <c>Zone agricole 19</c> or <c>Décharge</c></param>
        [Given(Prefix + "the zones named {string} are logged")]
        public void ZonesLogged(PickleContext ctx, string label)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var zones = map.zoneManager.AllZones.Where(z => z.label != null && z.label.IndexOf(label, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            if (zones.Count == 0) Log.Message("[zone-bounds] no zone of the map matches \"" + label + "\"; zones: " + string.Join(" | ", map.zoneManager.AllZones.Select(z => z.label)));
            foreach (Zone zone in zones)
            {
                var cells = zone.Cells;
                string plants = string.Join(", ", cells.SelectMany(c => c.GetThingList(map)).OfType<Plant>().GroupBy(p => p.def.defName).Select(g => g.Key + "=" + g.Count()));
                string line = zone.label + " (" + zone.GetType().Name + "): " + cells.Count + " cells, x " + cells.Min(c => c.x) + ".." + cells.Max(c => c.x)
                    + ", z " + cells.Min(c => c.z) + ".." + cells.Max(c => c.z) + "; plants: " + (plants.Length > 0 ? plants : "none");
                Log.Message("[zone-bounds] " + line);
                ctx.Attach("zone-bounds-" + zone.label, line);
            }
        }

        /// <summary>
        /// Sows a growing zone: puts a plant of a def, fully grown, on every cell of the zone that holds no plant and whose ground can carry a crop (fertility above 0,
        /// no building), and sets the zone to sow that def. Fails when no zone matches or the def does not exist. Written 2026-11-06 for the sanctuary rice zones
        /// (the save holds the zones but no rice). Compiled, not played.
        /// </summary>
        /// <param name="label">a text the zone's label contains, such as <c>Zone agricole 19</c></param>
        /// <param name="plantDef">a plant def, such as <c>Plant_Rice</c></param>
        [Given(Prefix + "the zones named {string} are sown with {string} fully grown")]
        public void ZonesSown(PickleContext ctx, string label, string plantDef) => SowZones(ctx, label, plantDef, false);

        /// <summary>Like sowing a zone, but first destroys every plant of the zone that is not a tree (wild grass, moss, a crop of another kind), so the zone ends as a field of the one crop. Compiled, not played.</summary>
        /// <param name="label">a text the zone label contains</param>
        /// <param name="plantDef">a plant def, such as <c>Plant_Rice</c></param>
        [Given(Prefix + "the zones named {string} are resown with {string} fully grown")]
        public void ZonesResown(PickleContext ctx, string label, string plantDef) => SowZones(ctx, label, plantDef, true);

        private static void SowZones(PickleContext ctx, string label, string plantDef, bool clearFirst)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(plantDef);
            ctx.Require(def != null && def.plant != null, "No plant def \"" + plantDef + "\"");
            var zones = map.zoneManager.AllZones.OfType<Zone_Growing>().Where(z => z.label != null && z.label.IndexOf(label, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            ctx.Require(zones.Count > 0, "No growing zone whose label contains \"" + label + "\"");
            foreach (Zone_Growing zone in zones)
            {
                zone.SetPlantDefToGrow(def);
                int sown = 0, skipped = 0;
                foreach (IntVec3 cell in zone.Cells.ToList())
                {
                    if (clearFirst)
                        foreach (Plant old in cell.GetThingList(map).OfType<Plant>().Where(p => !p.def.plant.IsTree).ToList()) old.Destroy();
                    if (cell.GetPlant(map) != null || cell.GetTerrain(map).fertility <= 0f || cell.GetEdifice(map) != null) { skipped++; continue; }
                    Plant plant = (Plant)ThingMaker.MakeThing(def);
                    plant.Growth = 1f;
                    GenSpawn.Spawn(plant, cell, map);
                    sown++;
                }
                Log.Message("[zone-sown] " + zone.label + ": " + sown + " " + plantDef + " fully grown, " + skipped + " cells skipped (plant, no soil or building)");
            }
        }

        /// <summary>
        /// For the growing zones that touch a rectangle: destroys the dead and dying plants of the zone (not trees), then puts a plant fully grown on every cell of the zone that holds
        /// none and can carry a crop, and logs each cell filled (<c>[zone-filled]</c>, so a logo drawn by a zone shows what was missing). The plant is the one the zone is set to grow
        /// when <paramref name="plantDef"/> is the word <c>its own</c>, else the def given. Written 2026-11-07 for the Nelim logo of enclosure-south (NSB). Compiled, not played.
        /// </summary>
        [Given(Prefix + "the growing zones in the area from \\({int}, {int}\\) to \\({int}, {int}\\) are cleaned and filled with {string} fully grown")]
        public void ZonesInAreaFilled(PickleContext ctx, int x0, int z0, int x1, int z1, string plantDef) => FillZonesInArea(ctx, x0, z0, x1, z1, plantDef, false);

        /// <summary>Like cleaning and filling, but also removes every wild plant of the zone cells: any non-tree plant that is not the zone's flower (grass, tall grass, bushes) and the tree saplings, then fills. Written 2026-11-07 for the dry grass tufts inside the Nelim logo zones (NSB). Compiled, not played.</summary>
        [Given(Prefix + "the growing zones in the area from \\({int}, {int}\\) to \\({int}, {int}\\) are cleared of wild plants and filled with {string} fully grown")]
        public void ZonesInAreaWildCleared(PickleContext ctx, int x0, int z0, int x1, int z1, string plantDef) => FillZonesInArea(ctx, x0, z0, x1, z1, plantDef, true);

        private static void FillZonesInArea(PickleContext ctx, int x0, int z0, int x1, int z1, string plantDef, bool wild)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var area = new MapArea(x0, z0, x1, z1);
            var zones = map.zoneManager.AllZones.OfType<Zone_Growing>().Where(z => z.Cells.Any(c => c.x >= System.Math.Min(x0, x1) && c.x <= System.Math.Max(x0, x1) && c.z >= System.Math.Min(z0, z1) && c.z <= System.Math.Max(z0, z1))).ToList();
            ctx.Require(zones.Count > 0, "No growing zone has a cell in the area from (" + x0 + ", " + z0 + ") to (" + x1 + ", " + z1 + "); the growing zones are " + string.Join(", ", map.zoneManager.AllZones.OfType<Zone_Growing>().Select(z => z.label)));
            foreach (Zone_Growing zone in zones)
            {
                ThingDef def = string.Equals(plantDef, "its own", StringComparison.OrdinalIgnoreCase) ? zone.GetPlantDefToGrow() : DefDatabase<ThingDef>.GetNamedSilentFail(plantDef);
                ctx.Require(def != null && def.plant != null, "No plant def \"" + plantDef + "\" for the zone " + zone.label);
                int dead = 0, filled = 0, skipped = 0;
                var filledCells = new List<string>();
                foreach (IntVec3 cell in zone.Cells.ToList())
                {
                    foreach (Plant old in cell.GetThingList(map).OfType<Plant>().Where(p => (!p.def.plant.IsTree && (p.Dying || (wild && p.def != def))) || (wild && p.def.plant.IsTree && p.Growth < 0.5f)).ToList()) { old.Destroy(); dead++; }
                    if (cell.GetPlant(map) != null || cell.GetTerrain(map).fertility <= 0f || cell.GetEdifice(map) != null) { skipped++; continue; }
                    Plant plant = (Plant)ThingMaker.MakeThing(def);
                    plant.Growth = 1f;
                    GenSpawn.Spawn(plant, cell, map);
                    filled++;
                    filledCells.Add("(" + cell.x + "," + cell.z + ")");
                }
                Log.Message("[zone-filled] " + zone.label + ": " + dead + " dead or dying plants removed, " + filled + " " + def.defName + " fully grown added, " + skipped + " cells skipped; cells filled: " + string.Join(" ", filledCells));
            }
        }

        private static string JsonText(string s) => "\"" + (s ?? "").Replace("\\", "\\\\").Replace("\"", "\\\"").Replace("\r", " ").Replace("\n", " ").Replace("\t", " ") + "\"";

        /// <summary>
        /// Logs ([terrain-stats], one JSON object per line) what the game loaded for every terrain def of a mod, after patches and inheritance: defName, label, description,
        /// tech level, cost list, beauty, work to build, cleanliness, fertility, affordances, path cost, passability, texture path, research prerequisites. For the capture catalogue
        /// (the content sheet of the mod is only the fallback: patches change values). Never fails on a mod without terrains (logs that none matched).
        /// Written 2026-11-06 for the terrain catalogue. Compiled, not played.
        /// </summary>
        /// <param name="packageId">the packageId of the mod (or its name), case insensitive</param>
        [Given(Prefix + "the terrains of the mod {string} are logged")]
        public void TerrainStatsLogged(PickleContext ctx, string packageId)
        {
            var defs = DefDatabase<TerrainDef>.AllDefs.Where(d => d.modContentPack != null
                && (string.Equals(d.modContentPack.PackageId, packageId, StringComparison.OrdinalIgnoreCase)
                    || string.Equals(d.modContentPack.PackageIdPlayerFacing, packageId, StringComparison.OrdinalIgnoreCase)
                    || string.Equals(d.modContentPack.Name, packageId, StringComparison.OrdinalIgnoreCase))).OrderBy(d => d.defName).ToList();
            if (defs.Count == 0) Log.Message("[terrain-stats] no terrain def of the mod \"" + packageId + "\"");
            foreach (TerrainDef d in defs)
            {
                string cost = string.Join(",", (d.costList ?? new List<ThingDefCountClass>()).Select(c => c.thingDef.defName + "=" + c.count));
                string aff = string.Join(",", (d.affordances ?? new List<TerrainAffordanceDef>()).Select(a => a.defName));
                string research = string.Join(",", (d.researchPrerequisites ?? new List<ResearchProjectDef>()).Select(r => r.defName));
                string json = "{\"defName\":" + JsonText(d.defName) + ",\"label\":" + JsonText(d.label) + ",\"description\":" + JsonText(d.description)
                    + ",\"techLevel\":" + JsonText((d.researchPrerequisites == null || d.researchPrerequisites.Count == 0 ? TechLevel.Undefined : d.researchPrerequisites.Max(r => r.techLevel)).ToString()) + ",\"costList\":" + JsonText(cost)
                    + ",\"beauty\":" + d.GetStatValueAbstract(StatDefOf.Beauty).ToString(System.Globalization.CultureInfo.InvariantCulture)
                    + ",\"workToBuild\":" + d.GetStatValueAbstract(StatDefOf.WorkToBuild).ToString(System.Globalization.CultureInfo.InvariantCulture)
                    + ",\"cleanliness\":" + d.GetStatValueAbstract(StatDefOf.Cleanliness).ToString(System.Globalization.CultureInfo.InvariantCulture)
                    + ",\"fertility\":" + d.fertility.ToString(System.Globalization.CultureInfo.InvariantCulture)
                    + ",\"pathCost\":" + d.pathCost + ",\"passability\":" + JsonText(d.passability.ToString())
                    + ",\"affordances\":" + JsonText(aff) + ",\"texturePath\":" + JsonText(d.texturePath) + ",\"research\":" + JsonText(research) + "}";
                Log.Message("[terrain-stats] " + json);
            }
            ctx.Attach("terrain-stats-" + packageId, defs.Count + " terrain defs logged");
        }

        /// <summary>The same as emptying the rectangle, but the things that hold a roof up (columns, pillars) stay, so the roof does not collapse.</summary>
        [Given(Prefix + "the area from \\({int}, {int}\\) to \\({int}, {int}\\) is emptied, the roof holders kept")]
        public void EmptyKeepingRoofHolders(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.Empty(ctx, new MapArea(x0, z0, x1, z1), true);

        /// <summary>Gives the dry cells of the rectangle the terrain of the cell 3 cells west of it at mid height (Soil if that is water or rock), without paint. One sample for the whole rectangle: do not use it on an enclosure.</summary>
        [Given(Prefix + "the floor of the area from \\({int}, {int}\\) to \\({int}, {int}\\) is bared")]
        public void BareFloor(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.BareFloor(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>Gives the dry cells of the rectangle the terrain of a chosen cell, without paint (the sample cell for an enclosure or mixed ground).</summary>
        [Given(Prefix + "the floor of the area from \\({int}, {int}\\) to \\({int}, {int}\\) is bared like the cell \\({int}, {int}\\)")]
        public void BareFloorLike(PickleContext ctx, int x0, int z0, int x1, int z1, int sx, int sz) => AreaOps.BareFloor(ctx, new MapArea(x0, z0, x1, z1), new IntVec3(sx, 0, sz));

        /// <summary>Sets the dry cells of the rectangle to a named terrain (<c>Concrete</c>, <c>Soil</c>...), without paint. Fails when the terrain does not exist. Not played yet (2026-10-30).</summary>
        [Given(Prefix + "the floor of the area from \\({int}, {int}\\) to \\({int}, {int}\\) is set to the terrain {string}")]
        public void SetFloor(PickleContext ctx, int x0, int z0, int x1, int z1, string terrainDefName) => AreaOps.SetFloor(ctx, new MapArea(x0, z0, x1, z1), terrainDefName);

        /// <summary>Despawns the animals standing in the rectangle now, once. Colonists stay. Does not fail when there is none.</summary>
        [Given(Prefix + "the animals are removed from the area from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void RemoveAnimals(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.RemoveAnimals(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>Despawns the animals of the rectangle now and on every frame until the scenario ends. May be written for several rectangles.</summary>
        [Given(Prefix + "the animals are kept out of the area from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void KeepAnimalsOut(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.KeepAnimalsOut(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>Despawns the animals of the rectangle now and on every frame until the scenario ends, except the one animal of that short name (an animal a scenario places in the area, such as the dog of a portrait). Compiled, not played.</summary>
        [Given(Prefix + "the animals except {string} are kept out of the area from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void KeepAnimalsOutExcept(PickleContext ctx, string exceptName, int x0, int z0, int x1, int z1) => AreaOps.KeepAnimalsOut(ctx, new MapArea(x0, z0, x1, z1), exceptName);

        /// <summary>Removes the roofs of the rectangle (thick roofs stay) so the sun lights it.</summary>
        [Given(Prefix + "the roof is removed from the area from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void RemoveRoof(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.RemoveRoof(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>Writes to the game log (lines starting <c>[free-cells]</c>) the cells of the rectangle a pawn can stand on with nothing on them, as runs per row (top row first). Reads only, changes nothing. Compiled, not played.</summary>
        [When(Prefix + "the free standable cells of the area from \\({int}, {int}\\) to \\({int}, {int}\\) are listed")]
        public void ListFreeCells(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.ListFreeCells(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>Despawns the things of a def (exact defName; several defNames may be separated by commas) within N cells of a cell (square, both axes), for this run only. Fails when none is there.</summary>
        [Given(Prefix + "the things {string} within {int} cells of \\({int}, {int}\\) are hidden")]
        public void HideThings(PickleContext ctx, string defName, int radius, int x, int z) => AreaOps.HideThings(ctx, defName, x, z, radius);

        /// <summary>The same, and does not fail when none is there (it logs how many it hid). Compiled, not played.</summary>
        [Given(Prefix + "the things {string} within {int} cells of \\({int}, {int}\\) are hidden when present")]
        public void HideThingsWhenPresent(PickleContext ctx, string defName, int radius, int x, int z) => AreaOps.HideThings(ctx, defName, x, z, radius, false);

        /// <summary>Lists (log lines <c>[things-near]</c> and the report attachment <c>things-near</c>) the defName, cell and class of every thing within N cells of a cell (square), pawns, filth and motes left out. Reads only. Compiled, not played.</summary>
        [When(Prefix + "the things within {int} cells of \\({int}, {int}\\) are listed")]
        public void ListThingsNear(PickleContext ctx, int radius, int x, int z) => AreaOps.ListThingsNear(ctx, x, z, radius);

        /// <summary>Despawns every artificial building within N cells of a cell, for this run only (what draws red focus lines on a selected anima tree). Does not fail when none is there.</summary>
        /// <summary>
        /// Takes every interaction bubble (the speech and icon bubbles pawns show over their heads for a chat, an insult, a hand shake: MoteBubble) off the map, for this run only, so a capture shows
        /// none. A bubble lasts about two seconds of game time and a new one can start while the game ticks: run it last, right before the screenshot, with the game paused. Does not fail when none
        /// is there (it logs how many it removed). Written 2026-11-06 for FoldingSkateboardRenew (a hand icon over Soren in a capture taken in presentation mode). NOT PLAYED when written.
        /// </summary>
        [Given(Prefix + "the interaction bubbles are cleared")]
        public void ClearInteractionBubbles(PickleContext ctx)
        {
            ctx.Require(Find.CurrentMap != null, "no map is loaded: load a save first");
            Map map = Find.CurrentMap;
            List<Thing> bubbles = map.listerThings.AllThings.Where(t => t is MoteBubble).ToList();
            foreach (Thing t in bubbles) t.Destroy(DestroyMode.Vanish);
            Log.Message("[bubbles-cleared] " + bubbles.Count);
        }

        [Given(Prefix + "the artificial buildings within {int} cells of \\({int}, {int}\\) are hidden")]
        public void HideArtificialBuildings(PickleContext ctx, int radius, int x, int z) => AreaOps.HideArtificialBuildings(ctx, x, z, radius);

        // The same operations on what the camera shows now: frame first, then clean the frame. No coordinate, no place name.
        // The view is read when the step runs; the zoom must have settled (the frame steps wait for it).
        private static MapArea View(PickleContext ctx)
        {
            ctx.Require(Find.CurrentMap != null, "Load a map first");
            return MapArea.OfView();
        }

        /// <summary>Destroys the furniture, items, plants, filth and corpses of every cell the camera shows now. Pawns, walls, doors and natural rock stay.</summary>
        [Given(Prefix + "the frame is emptied")]
        public void EmptyFrame(PickleContext ctx) => AreaOps.Empty(ctx, View(ctx));

        /// <summary>The same as emptying the frame, but the things that hold a roof up (columns, pillars) stay, so the roof does not collapse.</summary>
        [Given(Prefix + "the frame is emptied, the roof holders kept")]
        public void EmptyFrameKeepingRoofHolders(PickleContext ctx) => AreaOps.Empty(ctx, View(ctx), true);

        /// <summary>Bares the floor of every cell the camera shows now, with the terrain of the cell 3 cells west of the view at mid height. One sample: not for an enclosure.</summary>
        [Given(Prefix + "the floor of the frame is bared")]
        public void BareFloorFrame(PickleContext ctx) => AreaOps.BareFloor(ctx, View(ctx));

        /// <summary>Despawns the animals standing in the frame now, once.</summary>
        [Given(Prefix + "the animals are removed from the frame")]
        public void RemoveAnimalsFrame(PickleContext ctx) => AreaOps.RemoveAnimals(ctx, View(ctx));

        /// <summary>Keeps animals out of the cells the camera shows now, every frame until the scenario ends (the area is fixed at the moment of the step).</summary>
        [Given(Prefix + "the animals are kept out of the frame")]
        public void KeepAnimalsOutFrame(PickleContext ctx) => AreaOps.KeepAnimalsOut(ctx, View(ctx));

        /// <summary>Removes the roofs of the frame (thick roofs stay).</summary>
        [Given(Prefix + "the roof is removed from the frame")]
        public void RemoveRoofFrame(PickleContext ctx) => AreaOps.RemoveRoof(ctx, View(ctx));

        /// <summary>Waits this many rendered frames (the game keeps its pause): enough for a pawn just changed to be drawn again before a capture, at a fraction of the 90 frames a framing step waits.</summary>
        /// <param name="frames">the number of frames, 1 to 600</param>
        [When(Prefix + "I let {int} frames pass", TimeoutSeconds = 60f)]
        public async Task LetFramesPass(PickleContext ctx, int frames)
        {
            ctx.Require(frames >= 1 && frames <= 600, "frames run from 1 to 600");
            await ctx.WaitFrames(frames);
        }

        private static readonly List<Zone> HiddenZones = new List<Zone>();

        /// <summary>Hides every painted zone of the map (growing zones, stockpiles) from the capture, as the game's own "hide" toggle of a zone does; put back after the scenario. The zones keep working.</summary>
        [Given(Prefix + "the painted zones are hidden")]
        public void HideZones(PickleContext ctx)
        {
            ctx.Require(Find.CurrentMap != null, "Load a map first");
            foreach (Zone z in Find.CurrentMap.zoneManager.AllZones) if (!z.Hidden) { z.Hidden = true; HiddenZones.Add(z); }
        }

        [AfterScenario]
        public void ReleaseAreaHooks()
        {
            AreaOps.StopKeepingAnimalsOut();
            foreach (Zone z in HiddenZones) z.Hidden = false;
            HiddenZones.Clear();
        }
    }
}
