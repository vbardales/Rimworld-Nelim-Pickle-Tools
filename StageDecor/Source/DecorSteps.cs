using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.StageDecor
{
    /// <summary>
    /// Steps that dress a map for a gallery capture and take the dressing away: place a thing (a brazier, a rug, a plant, a shelf), lay a
    /// floor on a rectangle, and remove everything these steps made in one step. What a scenario placed is remembered, so removal
    /// needs no list; an [AfterScenario] removes what a failed scenario left. The things and the floor live in the loaded game only.
    ///
    /// Written on 2026-10-02 for CrystalBall's staged workshop captures (its session, at Virginie's request). NOT PLAYED: compiled
    /// against the reference assemblies only. Pickle's own <c>I spawn a {string} at</c> and <c>I destroy the {string} at</c> do the
    /// single thing; these add the floor, the set, and the removal of the whole set.
    /// </summary>
    [PickleSteps]
    public class DecorSteps
    {
        private sealed class OldFloor
        {
            public IntVec3 Cell;
            public TerrainDef Terrain;
        }

        // What this tool made. After a reload these belong to the game that was replaced: removal only touches what is still spawned
        // on the current map.
        private static readonly List<Thing> Placed = new List<Thing>();
        private static readonly List<OldFloor> Floors = new List<OldFloor>();

        /// <summary>
        /// Places a thing of the def at a cell, made of its default stuff, and remembers it for removal. Fails naming the cell if it is
        /// off the map or already holds a pawn or a building (the game would otherwise wipe what stood there).
        /// </summary>
        [Given("Nelim's Pickle Tools: I place the decor {string} at \\({int}, {int}\\)")]
        public void PlaceDecor(PickleContext ctx, string thingDefName, int x, int z)
        {
            Map map = CurrentMap(ctx);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(thingDefName);
            ctx.Require(def != null, $"no thing def '{thingDefName}' in this game");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            Thing blocker = cell.GetThingList(map).FirstOrDefault(t => t is Pawn || t is Building);
            ctx.Require(blocker == null, $"the cell ({x}, {z}) already holds {blocker?.def.defName}");

            Thing thing = ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
            Placed.Add(GenSpawn.Spawn(thing, cell, map, WipeMode.Vanish));
        }

        /// <summary>
        /// Places a thing like "I place the decor" and, when it is a plant, brings it to full growth in the same step, so a flower or a bush shows at
        /// its adult size without a second step. A thing that is not a plant is placed as it is.
        /// </summary>
        [Given("Nelim's Pickle Tools: I place the decor {string} at \\({int}, {int}\\) fully grown")]
        public void PlaceDecorGrown(PickleContext ctx, string thingDefName, int x, int z)
        {
            PlaceDecor(ctx, thingDefName, x, z);
            if (Placed.LastOrDefault() is Plant plant) plant.Growth = 1f;
        }

        /// <summary>
        /// Lays a floor (a TerrainDef: a carpet, a tile, soil) on every cell of the rectangle from the first corner to the second, and
        /// remembers what each cell held, so the removal step puts it back. Fails naming the first cell off the map or under a wall.
        /// </summary>
        [Given("Nelim's Pickle Tools: I lay the floor {string} from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void LayFloor(PickleContext ctx, string terrainDefName, int x1, int z1, int x2, int z2)
        {
            Map map = CurrentMap(ctx);
            TerrainDef def = DefDatabase<TerrainDef>.GetNamedSilentFail(terrainDefName);
            ctx.Require(def != null, $"no terrain def '{terrainDefName}' in this game");
            CellRect rect = CellRect.FromLimits(x1, z1, x2, z2);
            foreach (IntVec3 c in rect)
            {
                ctx.Require(c.InBounds(map), $"the cell ({c.x}, {c.z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            }

            foreach (IntVec3 c in rect)
            {
                Floors.Add(new OldFloor { Cell = c, Terrain = map.terrainGrid.TerrainAt(c) });
                map.terrainGrid.SetTerrain(c, def);
            }

            IntVec3 probe = rect.CenterCell;
            ctx.Assert(
                map.terrainGrid.TerrainAt(probe) == def,
                $"the floor at ({probe.x}, {probe.z}) should be {terrainDefName}; the game reports {map.terrainGrid.TerrainAt(probe)?.defName}");
        }

        /// <summary>
        /// Lays a floor like the plain step, then paints it with a colour def (Structure_Cream, Structure_OrangePastel, ...): a painted
        /// floor of the studio loses its paint when another floor is laid on it, and this brings it back.
        /// </summary>
        [Given("Nelim's Pickle Tools: I lay the floor {string} from \\({int}, {int}\\) to \\({int}, {int}\\) painted {string}")]
        public void LayPaintedFloor(PickleContext ctx, string terrainDefName, int x1, int z1, int x2, int z2, string colorDefName)
        {
            ColorDef color = DefDatabase<ColorDef>.GetNamedSilentFail(colorDefName);
            ctx.Require(color != null, $"no colour def '{colorDefName}' in this game");
            LayFloor(ctx, terrainDefName, x1, z1, x2, z2);
            Map map = CurrentMap(ctx);
            foreach (IntVec3 c in CellRect.FromLimits(x1, z1, x2, z2))
            {
                map.terrainGrid.SetTerrainColor(c, color);
            }

            IntVec3 probe = CellRect.FromLimits(x1, z1, x2, z2).CenterCell;
            ctx.Assert(
                map.terrainGrid.ColorAt(probe) == color,
                $"the floor at ({probe.x}, {probe.z}) should be painted {colorDefName}; the game reports {map.terrainGrid.ColorAt(probe)?.defName}");
        }

        /// <summary>
        /// Brings every plant on the rectangle to full growth, so a tree spawned by a step shows at its adult size instead of as a sapling.
        /// </summary>
        [Given("Nelim's Pickle Tools: the plants from \\({int}, {int}\\) to \\({int}, {int}\\) are fully grown")]
        public void GrowPlants(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            Map map = CurrentMap(ctx);
            CellRect rect = CellRect.FromLimits(x1, z1, x2, z2);
            foreach (IntVec3 c in rect)
            {
                ctx.Require(c.InBounds(map), $"the cell ({c.x}, {c.z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            }

            foreach (IntVec3 c in rect)
            {
                foreach (Plant p in c.GetThingList(map).OfType<Plant>().ToList())
                {
                    p.Growth = 1f;
                }
            }
        }

        /// <summary>
        /// Makes a placed light-giving thing burn: fills its fuel when it is refuelable (a torch, a campfire) and switches it on when it has a
        /// switch, then waits up to 10 seconds for the game to say it glows. Fails if the thing at the cell has no light, or does not glow
        /// (a lamp that needs power on a network that gives none says so).
        /// </summary>
        [Given("Nelim's Pickle Tools: the decor {string} at \\({int}, {int}\\) is lit", TimeoutSeconds = 15f)]
        public async System.Threading.Tasks.Task Lit(PickleContext ctx, string thingDefName, int x, int z)
        {
            Map map = CurrentMap(ctx);
            Thing thing = new IntVec3(x, 0, z).GetThingList(map).FirstOrDefault(t => t.def.defName == thingDefName);
            ctx.Require(thing is ThingWithComps, $"no '{thingDefName}' stands at ({x}, {z})");
            var withComps = (ThingWithComps)thing;
            CompGlower glower = withComps.GetComp<CompGlower>();
            ctx.Require(glower != null, $"'{thingDefName}' gives no light (it has no glow component)");

            CompRefuelable fuel = withComps.GetComp<CompRefuelable>();
            if (fuel != null)
            {
                fuel.Refuel(fuel.Props.fuelCapacity);
            }

            CompFlickable flick = withComps.GetComp<CompFlickable>();
            if (flick != null)
            {
                flick.SwitchIsOn = true;
            }

            await ctx.WaitUntil(() => glower.Glows, 10f);
            ctx.Assert(
                glower.Glows,
                $"'{thingDefName}' at ({x}, {z}) does not glow after refuelling{(withComps.GetComp<CompPowerTrader>() != null ? "; it needs power and the network gives none" : string.Empty)}");
        }

        private static readonly System.Collections.Generic.List<System.Tuple<IntVec3, RoofDef>> Roofs = new System.Collections.Generic.List<System.Tuple<IntVec3, RoofDef>>();

        /// <summary>
        /// Takes the roof off a rectangle of cells (a test colony under a mountain roof is dark in a capture) and remembers each roof, so the
        /// removal step puts it back. A cell with no roof is left alone.
        /// </summary>
        [Given("Nelim's Pickle Tools: the roof is removed from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void RemoveRoof(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            Map map = CurrentMap(ctx);
            foreach (IntVec3 c in CellRect.FromLimits(x1, z1, x2, z2))
            {
                ctx.Require(c.InBounds(map), $"the cell ({c.x}, {c.z}) is outside the map");
                RoofDef roof = map.roofGrid.RoofAt(c);
                if (roof != null)
                {
                    Roofs.Add(System.Tuple.Create(c, roof));
                    map.roofGrid.SetRoof(c, null);
                }
            }

            IntVec3 probe = CellRect.FromLimits(x1, z1, x2, z2).CenterCell;
            ctx.Assert(map.roofGrid.RoofAt(probe) == null, $"the cell ({probe.x}, {probe.z}) should have no roof; it has {map.roofGrid.RoofAt(probe)?.defName}");
        }

        private sealed class Taken
        {
            public Thing Thing;
            public IntVec3 Cell;
            public Rot4 Rot;
        }

        private static readonly List<Taken> Cleared = new List<Taken>();

        /// <summary>
        /// Takes every thing off a rectangle of cells (plants, filth, items, buildings, blueprints; not pawns, motes or projectiles) so the
        /// capture shows bare ground, and remembers each one: the removal step spawns the same instances back at their cell and rotation.
        /// Floors and roofs stay (use the floor and roof steps). A multi-cell thing is taken once, whole, when any of its cells is in the
        /// rectangle.
        /// </summary>
        [Given("Nelim's Pickle Tools: the area from \\({int}, {int}\\) to \\({int}, {int}\\) is cleared")]
        public void ClearArea(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            Map map = CurrentMap(ctx);
            CellRect rect = CellRect.FromLimits(x1, z1, x2, z2);
            foreach (IntVec3 c in rect)
            {
                ctx.Require(c.InBounds(map), $"the cell ({c.x}, {c.z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            }

            var seen = new HashSet<Thing>();
            foreach (IntVec3 c in rect)
            {
                foreach (Thing t in c.GetThingList(map).ToList())
                {
                    if (t is Pawn || t is Mote || t is Projectile || t is Skyfaller || !seen.Add(t) || Placed.Contains(t))
                    {
                        continue;
                    }

                    Cleared.Add(new Taken { Thing = t, Cell = t.Position, Rot = t.Rotation });
                    t.DeSpawn();
                }
            }

            int left = rect.Cells.Sum(c => c.GetThingList(map).Count(t => !(t is Pawn) && !(t is Mote) && !(t is Projectile) && !(t is Skyfaller) && !Placed.Contains(t)));
            ctx.Assert(left == 0, $"{left} things are still on the cells from ({x1}, {z1}) to ({x2}, {z2}) after clearing");
        }

        /// <summary>Removes every thing the place step made and puts back every floor the lay step replaced, in one step.</summary>
        [When("Nelim's Pickle Tools: the decor is removed")]
        public void RemoveDecor(PickleContext ctx)
        {
            Remove();
        }

        [AfterScenario]
        public void CleanUp(PickleContext ctx)
        {
            Remove();
        }

        private static void Remove()
        {
            Map map = Find.CurrentMap;
            foreach (Thing t in Placed.ToList())
            {
                if (map != null && t.Spawned && t.Map == map && !t.Destroyed)
                {
                    t.Destroy();
                }
            }

            for (int i = Cleared.Count - 1; i >= 0; i--)
            {
                Taken k = Cleared[i];
                if (map != null && !k.Thing.Destroyed && !k.Thing.Spawned && k.Cell.InBounds(map))
                {
                    GenSpawn.Spawn(k.Thing, k.Cell, map, k.Rot, WipeMode.Vanish);
                }
            }

            Cleared.Clear();

            // Last laid, first undone: a cell laid twice returns to what it held before the first.
            for (int i = Floors.Count - 1; i >= 0; i--)
            {
                if (map != null && Floors[i].Cell.InBounds(map))
                {
                    map.terrainGrid.SetTerrain(Floors[i].Cell, Floors[i].Terrain);
                }
            }

            for (int i = Roofs.Count - 1; i >= 0; i--)
            {
                if (map != null && Roofs[i].Item1.InBounds(map))
                {
                    map.roofGrid.SetRoof(Roofs[i].Item1, Roofs[i].Item2);
                }
            }

            Roofs.Clear();
            Placed.Clear();
            Floors.Clear();
        }

        private static Map CurrentMap(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map is loaded; load a save first with 'the save ... is loaded'");
            return map;
        }
    }
}
