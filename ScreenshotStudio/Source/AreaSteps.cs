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
            Find.Selector.ClearSelection();
            Find.CameraDriver.JumpToCurrentMapLoc(new IntVec3(x, 0, z));
            Find.CameraDriver.SetRootSize(rootSize);
            await ctx.WaitFrames(90);
            float last = -1f; int still = 0;
            for (int i = 0; i < 600 && still < 20; i++)
            {
                float glow = Find.CurrentMap.skyManager.CurSkyGlow;
                still = Math.Abs(glow - last) < 0.0005f ? still + 1 : 0;
                last = glow;
                await ctx.WaitFrames(1);
            }
            Log.Message("[frame] asked (" + x + ", " + z + ") root size " + rootSize + ", camera at " + Find.CameraDriver.MapPosition + ", root size " + Find.CameraDriver.RootSize.ToString("0.0") + ", sky glow " + last.ToString("0.00"));
        }

        /// <summary>
        /// Destroys every thing in the area: furniture, items, plants, filth, corpses. Pawns, walls, doors, natural rock, ethereal things and
        /// projectiles stay. Terrain and roofs are untouched. Returns how many things were destroyed.
        /// </summary>
        public static int Empty(PickleContext ctx, MapArea area)
        {
            Map map = RequireMap(ctx);
            var doomed = map.listerThings.AllThings.Where(t => area.Contains(t.Position)
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

        /// <summary>Despawns (does not kill) the animals standing in the area now, once: an animal that walks in later stays. Returns how many.</summary>
        public static int RemoveAnimals(PickleContext ctx, MapArea area)
        {
            Map map = RequireMap(ctx);
            var animals = map.mapPawns.AllPawnsSpawned.Where(p => p.RaceProps.Animal && area.Contains(p.Position)).ToList();
            foreach (var a in animals) a.DeSpawn();
            return animals.Count;
        }

        /// <summary>
        /// Despawns the animals of the area now, then on every frame until the scenario ends (animals come back through the doors). May be called
        /// for several areas. The hooks are removed after the scenario by <see cref="AreaSteps"/>, so the assembly needs no clean-up of its own.
        /// </summary>
        public static void KeepAnimalsOut(PickleContext ctx, MapArea area)
        {
            RequireMap(ctx);
            Action hook = () =>
            {
                Map map = Find.CurrentMap;
                if (map == null) return;
                foreach (var a in map.mapPawns.AllPawnsSpawned.Where(p => p.RaceProps.Animal && area.Contains(p.Position)).ToList()) a.DeSpawn();
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
        public static int HideThings(PickleContext ctx, string defName, int x, int z, int radius)
        {
            Map map = RequireMap(ctx);
            var found = map.listerThings.AllThings.Where(t => t.Spawned && t.def.defName == defName
                && Math.Abs(t.Position.x - x) <= radius && Math.Abs(t.Position.z - z) <= radius).ToList();
            ctx.Require(found.Count > 0, "No " + defName + " within " + radius + " cells of (" + x + ", " + z + "): the save changed, or the step already ran");
            foreach (var t in found) t.DeSpawn();
            return found.Count;
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

        /// <summary>Gives the dry cells of the rectangle the terrain of the cell 3 cells west of it at mid height (Soil if that is water or rock), without paint. One sample for the whole rectangle: do not use it on an enclosure.</summary>
        [Given(Prefix + "the floor of the area from \\({int}, {int}\\) to \\({int}, {int}\\) is bared")]
        public void BareFloor(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.BareFloor(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>Gives the dry cells of the rectangle the terrain of a chosen cell, without paint (the sample cell for an enclosure or mixed ground).</summary>
        [Given(Prefix + "the floor of the area from \\({int}, {int}\\) to \\({int}, {int}\\) is bared like the cell \\({int}, {int}\\)")]
        public void BareFloorLike(PickleContext ctx, int x0, int z0, int x1, int z1, int sx, int sz) => AreaOps.BareFloor(ctx, new MapArea(x0, z0, x1, z1), new IntVec3(sx, 0, sz));

        /// <summary>Despawns the animals standing in the rectangle now, once. Colonists stay. Does not fail when there is none.</summary>
        [Given(Prefix + "the animals are removed from the area from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void RemoveAnimals(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.RemoveAnimals(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>Despawns the animals of the rectangle now and on every frame until the scenario ends. May be written for several rectangles.</summary>
        [Given(Prefix + "the animals are kept out of the area from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void KeepAnimalsOut(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.KeepAnimalsOut(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>Removes the roofs of the rectangle (thick roofs stay) so the sun lights it.</summary>
        [Given(Prefix + "the roof is removed from the area from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void RemoveRoof(PickleContext ctx, int x0, int z0, int x1, int z1) => AreaOps.RemoveRoof(ctx, new MapArea(x0, z0, x1, z1));

        /// <summary>Despawns the things of a def (by defName) within N cells of a cell, for this run only. Fails when none is there.</summary>
        [Given(Prefix + "the things {string} within {int} cells of \\({int}, {int}\\) are hidden")]
        public void HideThings(PickleContext ctx, string defName, int radius, int x, int z) => AreaOps.HideThings(ctx, defName, x, z, radius);

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

        [AfterScenario]
        public void ReleaseAreaHooks() => AreaOps.StopKeepingAnimalsOut();
    }
}
