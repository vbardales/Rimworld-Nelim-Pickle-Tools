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
        private static bool SkipUnplaced;

        /// <summary>From here on, a 'near' placement that finds no cell is skipped and logged ([decor-skipped]) instead of failing the scenario, so one stubborn object does not cost the other places their shots. For the scenario only: it is set again by each scenario that wants it.</summary>
        [Given("Nelim's Pickle Tools: a decor that finds no cell is skipped and logged")]
        public void SkipWhatFindsNoCell(PickleContext ctx)
        {
            SkipUnplaced = true;
        }

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
        /// Places a building near a cell, the way the game's own placing rules allow it: the nearest cell (rings of up to 4 cells, row by row) where
        /// <c>GenConstruct.CanPlaceBlueprintAt</c> accepts the def with one of the rotations (north, east, south, west, in that order) is taken, so a
        /// wall attachment finds its wall, a door its opening, a big thing its free footprint. Logs where it went ([decor-placed]) and fails, naming
        /// the def and the cell, when no cell within 4 qualifies. Fuel burners are filled. Written 2026-11-05 for the modded decor of the Sanctuary.
        /// </summary>
        [Given("Nelim's Pickle Tools: I place the decor {string} near \\({int}, {int}\\)")]
        public void PlaceDecorNear(PickleContext ctx, string thingDefName, int x, int z)
        {
            PlaceNear(ctx, thingDefName, x, z, null);
        }
        /// <summary>
        /// Places a building on exactly this cell, if the game's own rules accept it there with one of the rotations (north first); otherwise it is
        /// skipped and logged when the scenario asked for that, and fails when it did not. For a chain of cells that must touch (a hidden conduit).
        /// </summary>
        [Given("Nelim's Pickle Tools: I place the decor {string} exactly at \\({int}, {int}\\)")]
        public void PlaceDecorExactly(PickleContext ctx, string thingDefName, int x, int z)
        {
            PlaceNear(ctx, thingDefName, x, z, null, 0);
        }

        /// <summary>
        /// Asserts that the powered building of a def at a cell sits on a real power net that holds a power source (not only the forced
        /// <c>PowerOn</c> flag): the net the game built when the things were spawned. The failure says what the net holds.
        /// </summary>
        [Then("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) is on a power net with a power source")]
        public void BuildingIsOnPoweredNet(PickleContext ctx, string defName, int x, int z)
        {
            Map map = CurrentMap(ctx);
            Thing building = new IntVec3(x, 0, z).GetThingList(map).FirstOrDefault(t => t.def.defName == defName);
            ctx.Require(building != null, $"no {defName} stands at ({x}, {z})");
            CompPower power = building.TryGetComp<CompPower>();
            ctx.Require(power != null, $"the {defName} at ({x}, {z}) has no power comp");
            PowerNet net = power.PowerNet;
            ctx.Assert(net != null, $"the {defName} at ({x}, {z}) is on no power net at all (nothing connects it)");
            ctx.Assert(net.hasPowerSource, $"the {defName} at ({x}, {z}) is on a net of {net.powerComps.Count} consumers and {net.transmitters.Count} transmitters, with no power source");
        }

        /// <summary>
        /// Drops the connection of a powered or transmitting building and lets the game connect it again to the best transmitter around, so a
        /// conduit laid after it is taken (a thing connects once, to what exists when it is spawned, and keeps that parent). Written 2026-11-05
        /// for the ritual hall wires of the Sanctuary. Never fails when nothing connects (a later check says so).
        /// </summary>
        [Given("Nelim's Pickle Tools: the power connection of the building {string} at \\({int}, {int}\\) is remade")]
        public void RemakePowerConnection(PickleContext ctx, string defName, int x, int z)
        {
            Map map = CurrentMap(ctx);
            Thing building = new IntVec3(x, 0, z).GetThingList(map).FirstOrDefault(t => t.def.defName == defName);
            ctx.Require(building != null, $"no {defName} stands at ({x}, {z})");
            CompPower comp = building.TryGetComp<CompPower>();
            ctx.Require(comp != null, $"the {defName} at ({x}, {z}) has no power comp");
            PowerConnectionMaker.DisconnectFromPowerNet(comp);
            PowerConnectionMaker.TryConnectToAnyPowerNet(comp);
            Log.Message($"[power-remade] {defName} at ({x}, {z}): parent now {(comp.connectParent == null ? "none" : comp.connectParent.parent.def.defName + " at (" + comp.connectParent.parent.Position.x + ", " + comp.connectParent.parent.Position.z + ")")}");
        }

        /// <summary>
        /// Asserts that the building is connected to a part that touches it (the conduit under it, or next to it): the game draws a wire line only
        /// between a thing and a parent that does not touch it. The failure names the parent and its cell.
        /// </summary>
        [Then("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) is connected with no visible wire")]
        public void BuildingHasNoVisibleWire(PickleContext ctx, string defName, int x, int z)
        {
            Map map = CurrentMap(ctx);
            Thing building = new IntVec3(x, 0, z).GetThingList(map).FirstOrDefault(t => t.def.defName == defName);
            ctx.Require(building != null, $"no {defName} stands at ({x}, {z})");
            CompPower comp = building.TryGetComp<CompPower>();
            ctx.Require(comp != null, $"the {defName} at ({x}, {z}) has no power comp");
            Thing parent = comp.connectParent?.parent;
            ctx.Assert(parent != null, $"the {defName} at ({x}, {z}) has no connection parent");
            bool touches = building.OccupiedRect().ExpandedBy(1).Overlaps(parent.OccupiedRect());
            ctx.Assert(touches, $"the {defName} at ({x}, {z}) is connected to {parent.def.defName} at ({parent.Position.x}, {parent.Position.z}), {(parent.Position - building.Position).LengthHorizontal:F1} cells away: a wire is drawn");
        }

        /// <summary>
        /// Cuts the power connection of every powered or transmitting building of a rectangle (they stay where they are, unpowered, with no wire
        /// drawn): for the original things of a room that a new power net would otherwise reach by a visible wire (the vitals monitors beside the
        /// beds of the infirmary took the new hidden conduits as parents). Logs what it cut ([power-cut]). Written 2026-11-05 for the Sanctuary.
        /// </summary>
        [Given("Nelim's Pickle Tools: the power connections of the area from \\({int}, {int}\\) to \\({int}, {int}\\) are cut")]
        public void CutPowerConnections(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            Map map = CurrentMap(ctx);
            var seen = new HashSet<Thing>();
            foreach (IntVec3 c in CellRect.FromLimits(x1, z1, x2, z2))
            {
                if (!c.InBounds(map)) continue;
                foreach (Thing t in c.GetThingList(map).ToList())
                {
                    if (!(t is ThingWithComps twc) || !seen.Add(t)) continue;
                    CompPower comp = twc.GetComp<CompPower>();
                    if (comp == null || comp.connectParent == null) continue;
                    Thing parent = comp.connectParent.parent;
                    PowerConnectionMaker.DisconnectFromPowerNet(comp);
                    Log.Message($"[power-cut] {t.def.defName} at ({t.Position.x}, {t.Position.z}) cut from {parent.def.defName} at ({parent.Position.x}, {parent.Position.z})");
                }
            }
        }

        /// <summary>
        /// Logs the power links of every powered or transmitting building of a rectangle ([power-link]): for each, its def, its cell, the thing its
        /// connection parent is and the distance to it (the game draws a wire line between a thing and its connection parent when they do not
        /// touch), and the net it sits on. To find what a visible wire connects. Never fails. Written 2026-11-05 for the Sanctuary infirmary.
        /// </summary>
        [Given("Nelim's Pickle Tools: the power links of the area from \\({int}, {int}\\) to \\({int}, {int}\\) are logged")]
        public void LogPowerLinks(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            Map map = CurrentMap(ctx);
            var seen = new HashSet<Thing>();
            foreach (IntVec3 c in CellRect.FromLimits(x1, z1, x2, z2))
            {
                if (!c.InBounds(map)) continue;
                foreach (Thing t in c.GetThingList(map).ToList())
                {
                    if (!(t is ThingWithComps twc) || !seen.Add(t)) continue;
                    CompPower comp = twc.GetComp<CompPower>();
                    if (comp == null) continue;
                    Thing parent = comp.connectParent?.parent;
                    string line = parent == null ? "no connection parent" : $"parent {parent.def.defName} at ({parent.Position.x}, {parent.Position.z}), {(parent.Position - t.Position).LengthHorizontal:F1} cells away";
                    Log.Message($"[power-link] {t.def.defName} at ({t.Position.x}, {t.Position.z}) size {t.def.size.x}x{t.def.size.z}: {line}; net {(comp.PowerNet == null ? "none" : comp.PowerNet.transmitters.Count + " transmitters, source " + comp.PowerNet.hasPowerSource)}");
                }
            }
        }


        /// <summary>The same with a given facing (north, east, south or west): only that rotation is tried.</summary>
        [Given("Nelim's Pickle Tools: I place the decor {string} near \\({int}, {int}\\) facing {word}")]
        public void PlaceDecorNearFacing(PickleContext ctx, string thingDefName, int x, int z, string facing)
        {
            Rot4 rot;
            switch (facing.ToLowerInvariant())
            {
                case "north": rot = Rot4.North; break;
                case "east": rot = Rot4.East; break;
                case "south": rot = Rot4.South; break;
                case "west": rot = Rot4.West; break;
                default: ctx.Require(false, $"facing must be north, east, south or west, not '{facing}'"); return;
            }

            PlaceNear(ctx, thingDefName, x, z, rot);
        }

        // A plant takes the nearest cell (rings of up to 4) with no building and no pawn on it, at full growth: a plant has no placing rules of its own, but a statue or a bench is not wiped.
        private void PlacePlantNear(PickleContext ctx, Map map, ThingDef def, int x, int z)
        {
            for (int radius = 0; radius <= 4; radius++)
            {
                for (int dz = -radius; dz <= radius; dz++)
                {
                    for (int dx = -radius; dx <= radius; dx++)
                    {
                        if (System.Math.Max(System.Math.Abs(dx), System.Math.Abs(dz)) != radius) continue;
                        var cell = new IntVec3(x + dx, 0, z + dz);
                        if (!cell.InBounds(map) || !cell.Walkable(map) || cell.GetTerrain(map).IsWater) continue;
                        if (cell.GetThingList(map).Any(t => t is Pawn || t is Building || t.def.category == ThingCategory.Item)) continue;
                        var plant = (Plant)ThingMaker.MakeThing(def);
                        plant.Growth = 1f;
                        Placed.Add(GenSpawn.Spawn(plant, cell, map, WipeMode.Vanish));
                        Log.Message($"[decor-placed] {def.defName} asked ({x}, {z}), put at ({cell.x}, {cell.z}), {radius} cells away");
                        return;
                    }
                }
            }

            if (SkipUnplaced)
            {
                Log.Warning($"[decor-skipped] plant {def.defName} asked ({x}, {z}): no free dry cell within 4 cells");
                return;
            }

            ctx.Require(false, $"no free dry cell within 4 cells of ({x}, {z}) for the plant {def.defName}");
        }

        private void PlaceNear(PickleContext ctx, string thingDefName, int x, int z, Rot4? only, int limit = 4)
        {
            Map map = CurrentMap(ctx);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(thingDefName);
            if (def == null && SkipUnplaced)
            {
                Log.Warning($"[decor-skipped] {thingDefName} asked ({x}, {z}): no such thing def in this game");
                return;
            }

            ctx.Require(def != null, $"no thing def '{thingDefName}' in this game");
            var asked = new IntVec3(x, 0, z);
            ctx.Require(asked.InBounds(map), $"the cell ({x}, {z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            if (def.category == ThingCategory.Plant)
            {
                PlacePlantNear(ctx, map, def, x, z);
                return;
            }

            Rot4[] rotations = only.HasValue ? new[] { only.Value } : new[] { Rot4.North, Rot4.East, Rot4.South, Rot4.West };
            ThingDef stuff = def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null;
            for (int radius = 0; radius <= limit; radius++)
            {
                for (int dz = -radius; dz <= radius; dz++)
                {
                    for (int dx = -radius; dx <= radius; dx++)
                    {
                        if (System.Math.Max(System.Math.Abs(dx), System.Math.Abs(dz)) != radius) continue;
                        var cell = new IntVec3(x + dx, 0, z + dz);
                        if (!cell.InBounds(map)) continue;
                        foreach (Rot4 rot in rotations)
                        {
                            if (!GenConstruct.CanPlaceBlueprintAt(def, cell, rot, map, false, null, null, stuff).Accepted) continue;
                            Thing thing = ThingMaker.MakeThing(def, stuff);
                            Thing spawned = GenSpawn.Spawn(thing, cell, map, rot, WipeMode.Vanish);
                            Placed.Add(spawned);
                            CompRefuelable fuel = spawned.TryGetComp<CompRefuelable>();
                            fuel?.Refuel(fuel.Props.fuelCapacity);
                            CompPowerTrader powerTrader = spawned.TryGetComp<CompPowerTrader>();
                            if (powerTrader != null) powerTrader.PowerOn = true;
                            Log.Message($"[decor-placed] {def.defName} asked ({x}, {z}), put at ({cell.x}, {cell.z}) facing {rot}, {radius} cells away");
                            return;
                        }
                    }
                }
            }

            if (SkipUnplaced)
            {
                Log.Warning($"[decor-skipped] {thingDefName} asked ({x}, {z}): no cell within 4 cells takes it (size {def.size.x}x{def.size.z})");
                return;
            }

            ctx.Require(false, $"no cell within 4 cells of ({x}, {z}) takes the {thingDefName} (size {def.size.x}x{def.size.z}, rotations tried: {string.Join(", ", rotations.Select(r => r.ToStringHuman()))})");
        }

        /// <summary>
        /// Places a thing like "I place the decor" and gives it an ideoligion thing style (a <c>ThingStyleDef</c>, by defName) the way the game does
        /// when a style category applies: <c>Thing.SetStyleDef</c>. Fails when the style is unknown, or when the thing does not hold the style after
        /// the step. The style is not checked against a style category: any style can be forced, which is what a test of a style's graphic wants.
        /// Written 2026-10-29 for PropsAsStyle. Compiled, not played.
        /// </summary>
        [Given("Nelim's Pickle Tools: I place the decor {string} with the style {string} at \\({int}, {int}\\)")]
        public void PlaceDecorStyled(PickleContext ctx, string thingDefName, string styleDefName, int x, int z)
        {
            ThingStyleDef style = DefDatabase<ThingStyleDef>.GetNamedSilentFail(styleDefName);
            ctx.Require(style != null, $"no ThingStyleDef named '{styleDefName}' in this game");
            PlaceDecor(ctx, thingDefName, x, z);
            Thing thing = Placed.Last();
            thing.SetStyleDef(style);
            ctx.Assert(thing.StyleDef == style, $"the {thingDefName} at ({x}, {z}) holds the style '{thing.StyleDef?.defName ?? "none"}' after the step, not '{styleDefName}'");
        }

        /// <summary>Asserts the thing of a def standing at a cell holds a given thing style. Reads the map as it is now, so it works after a save and a reload. Compiled, not played.</summary>
        [Then("Nelim's Pickle Tools: the thing {string} at \\({int}, {int}\\) has the style {string}")]
        public void ThingHasStyle(PickleContext ctx, string thingDefName, int x, int z, string styleDefName)
        {
            Thing thing = ThingAt(ctx, thingDefName, x, z);
            ctx.Assert(thing.StyleDef != null && thing.StyleDef.defName == styleDefName,
                $"the {thingDefName} at ({x}, {z}) holds the style '{thing.StyleDef?.defName ?? "none"}', not '{styleDefName}'");
        }

        /// <summary>
        /// Asserts the graphic the thing at a cell draws now (the style's, when it holds one) is built and is not the pink bad-texture material.
        /// Compiled, not played.
        /// </summary>
        [Then("Nelim's Pickle Tools: the thing {string} at \\({int}, {int}\\) draws a texture that resolves")]
        public void ThingGraphicResolves(PickleContext ctx, string thingDefName, int x, int z)
        {
            Thing thing = ThingAt(ctx, thingDefName, x, z);
            Graphic graphic = thing.Graphic;
            ctx.Assert(graphic != null, $"the {thingDefName} at ({x}, {z}) has no graphic");
            ctx.Assert(graphic.MatSingle != null && graphic.MatSingle != BaseContent.BadMat,
                $"the {thingDefName} at ({x}, {z}) draws the pink bad-texture material (texPath '{graphic.path}', style '{thing.StyleDef?.defName ?? "none"}')");
        }


        private static readonly Dictionary<string, int> RememberedHitPoints = new Dictionary<string, int>();

        /// <summary>
        /// Asserts how many things a storage building holds (the things lying in its slot group, one per stack, not the sum of the stacks). The building is
        /// found by def at a cell of its footprint. Fails when no such building stands there or it is not a storage building. Written 2026-10-29 for PropsInUse
        /// (a ten-book shelf). Compiled, not played.
        /// </summary>
        [Then("Nelim's Pickle Tools: the storage building {string} at \\({int}, {int}\\) holds {int} things")]
        public void StorageHolds(PickleContext ctx, string buildingDefName, int x, int z, int expected)
        {
            var storage = StorageAt(ctx, buildingDefName, x, z);
            int count = Held(storage).Count();
            ctx.Assert(count == expected, $"the {buildingDefName} at ({x}, {z}) holds {count} thing(s), not {expected}: " + string.Join(", ", Held(storage).Select(t => t.def.defName + " x" + t.stackCount)));
        }

        /// <summary>
        /// Puts N things of a def onto the cells of a storage building with the game's own placing (<c>GenPlace.TryPlaceThing</c>), as a way to fill it
        /// without a hauling job. Fails when the building is unknown or not a storage building, or when nothing reached it. Compiled, not played.
        /// </summary>
        [Given("Nelim's Pickle Tools: I fill the storage building {string} at \\({int}, {int}\\) with {int} things {string}")]
        public void FillStorage(PickleContext ctx, string buildingDefName, int x, int z, int count, string thingDefName)
        {
            Fill(ctx, buildingDefName, x, z, count, thingDefName, null);
        }

        /// <summary>
        /// The same, each thing given the quality (Awful, Poor, Normal, Good, Excellent, Masterwork, Legendary; any case) through its quality comp: a book
        /// of the Book comp carries one. Fails when the def has no quality comp. Written 2026-11-03 for ReadingBonusAndBookshelfRenew. Compiled, not played.
        /// </summary>
        [Given("Nelim's Pickle Tools: I fill the storage building {string} at \\({int}, {int}\\) with {int} things {string} of quality {word}")]
        public void FillStorageOfQuality(PickleContext ctx, string buildingDefName, int x, int z, int count, string thingDefName, string quality)
        {
            QualityCategory parsed;
            try
            {
                parsed = (QualityCategory)System.Enum.Parse(typeof(QualityCategory), quality, true);
            }
            catch (System.ArgumentException)
            {
                ctx.Require(false, $"'{quality}' is not a quality; the qualities are " + string.Join(", ", System.Enum.GetNames(typeof(QualityCategory))));
                return;
            }

            Fill(ctx, buildingDefName, x, z, count, thingDefName, parsed);
        }

        private void Fill(PickleContext ctx, string buildingDefName, int x, int z, int count, string thingDefName, QualityCategory? quality)
        {
            var storage = StorageAt(ctx, buildingDefName, x, z);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(thingDefName);
            ctx.Require(def != null, $"no thing def '{thingDefName}' in this game");
            Map map = CurrentMap(ctx);
            int before = Held(storage).Count();
            for (int i = 0; i < count; i++)
            {
                Thing thing = ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
                thing.stackCount = 1;
                if (quality.HasValue)
                {
                    CompQuality comp = thing.TryGetComp<CompQuality>();
                    ctx.Require(comp != null, $"the {thingDefName} has no quality comp");
                    comp.SetQuality(quality.Value, ArtGenerationContext.Colony);
                }

                Thing placed = Put(storage, thing, map);
                if (placed != null) Placed.Add(placed);
            }

            int after = Held(storage).Count();
            ctx.Assert(after - before >= 1, $"no {thingDefName} reached the {buildingDefName} at ({x}, {z}) ({before} before, {after} after)");
        }

        /// <summary>
        /// Builds a closed, roofed room whose south-west inside cell is (x, z): walls around an inside of the given width by depth, a door in the middle of
        /// the south wall (the inside must be at least 3 wide), a constructed roof over the inside, then waits for the game to make a proper room of it.
        /// Plants and filth in the way are cleared; fails naming the first cell outside the map or holding a building or a pawn. The walls and the door are
        /// removed with the other decor. Written 2026-11-03 for ReadingBonusAndBookshelfRenew. Compiled, not played.
        /// </summary>
        [Given("Nelim's Pickle Tools: a closed roofed room is built at \\({int}, {int}\\) of {int} by {int}", TimeoutSeconds = 15f)]
        public async System.Threading.Tasks.Task BuildRoom(PickleContext ctx, int x, int z, int width, int depth)
        {
            Map map = CurrentMap(ctx);
            ctx.Require(width >= 3 && depth >= 1, $"the inside must be at least 3 by 1, not {width} by {depth}");
            CellRect inside = new CellRect(x, z, width, depth);
            CellRect footprint = inside.ExpandedBy(1);
            IntVec3 doorCell = new IntVec3(x + 1, 0, z - 1);
            foreach (IntVec3 c in footprint)
            {
                ctx.Require(c.InBounds(map), $"the cell ({c.x}, {c.z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
                Thing blocker = c.GetThingList(map).FirstOrDefault(t => t is Pawn || t is Building);
                ctx.Require(blocker == null, $"the cell ({c.x}, {c.z}) already holds {blocker?.def.defName}");
            }

            foreach (IntVec3 c in footprint)
            {
                foreach (Thing t in c.GetThingList(map).Where(t => t.def.category == ThingCategory.Plant || t.def.category == ThingCategory.Filth).ToList())
                {
                    t.Destroy();
                }
            }

            foreach (IntVec3 c in footprint.Cells.Where(c => !inside.Contains(c)))
            {
                ThingDef def = c == doorCell ? ThingDefOf.Door : ThingDefOf.Wall;
                Placed.Add(GenSpawn.Spawn(ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def)), c, map, WipeMode.Vanish));
            }

            foreach (IntVec3 c in inside)
            {
                map.roofGrid.SetRoof(c, RoofDefOf.RoofConstructed);
            }

            map.regionAndRoomUpdater.RebuildAllRegionsAndRooms();
            IntVec3 probe = inside.CenterCell;
            await ctx.WaitUntil(() => probe.GetRoom(map)?.ProperRoom == true, 10f);
            Room room = probe.GetRoom(map);
            ctx.Assert(room != null && room.ProperRoom, $"the room at ({probe.x}, {probe.z}) should be a proper room, proper room: {room?.ProperRoom}, cells: {room?.CellCount}");
        }

        /// <summary>
        /// Asserts a stat of the room that holds a cell (RoomStatDef by defName), read after the room's stats are marked dirty, within 0.0001. The failure
        /// prints the value read. Fails when the cell has no room. Written 2026-11-03 for ReadingBonusAndBookshelfRenew. Compiled, not played.
        /// </summary>
        [Then("Nelim's Pickle Tools: the room at \\({int}, {int}\\) has the stat {string} at {float}")]
        public void RoomHasStat(PickleContext ctx, int x, int z, string statName, float expected)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            Room room = cell.GetRoom(map);
            ctx.Require(room != null, $"no room holds ({x}, {z})");
            RoomStatDef stat = DefDatabase<RoomStatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, $"no room stat '{statName}'; the room stats are " + string.Join(", ", DefDatabase<RoomStatDef>.AllDefsListForReading.Select(d => d.defName)));
            typeof(Room).GetMethod("Notify_RoomShapeChanged", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic)?.Invoke(room, null);
            float actual = room.GetStat(stat);
            ctx.Assert(System.Math.Abs(actual - expected) <= 0.0001f, $"the room at ({x}, {z}) has {statName} at {actual:0.#####}, not {expected:0.#####}");
        }

        /// <summary>
        /// Asks the game whether it would store a thing of a def in the storage building (<c>StoreUtility.IsGoodStoreCell</c> on each cell of its footprint,
        /// for the player faction): true when the building takes another one, false when it is full or refuses the def. Compiled, not played.
        /// </summary>
        [Then("Nelim's Pickle Tools: the storage building {string} at \\({int}, {int}\\) accepts another {string}")]
        public void StorageAccepts(PickleContext ctx, string buildingDefName, int x, int z, string thingDefName)
        {
            ctx.Assert(WouldStore(ctx, buildingDefName, x, z, thingDefName), $"the {buildingDefName} at ({x}, {z}) would not take another {thingDefName}");
        }

        /// <summary>The negative twin: the game would not store another thing of that def in the building (a full shelf, the eleventh book). Compiled, not played.</summary>
        [Then("Nelim's Pickle Tools: the storage building {string} at \\({int}, {int}\\) refuses another {string}")]
        public void StorageRefuses(PickleContext ctx, string buildingDefName, int x, int z, string thingDefName)
        {
            ctx.Assert(!WouldStore(ctx, buildingDefName, x, z, thingDefName), $"the {buildingDefName} at ({x}, {z}) would take another {thingDefName}, and it should not");
        }

        /// <summary>Asserts the hit points of the thing of a def at a cell (an item, a building, a plant). Compiled, not played.</summary>
        [Then("Nelim's Pickle Tools: the thing {string} at \\({int}, {int}\\) has {int} hit points")]
        public void ThingHasHitPoints(PickleContext ctx, string thingDefName, int x, int z, int expected)
        {
            Thing thing = ThingAt(ctx, thingDefName, x, z);
            ctx.Assert(thing.HitPoints == expected, $"the {thingDefName} at ({x}, {z}) has {thing.HitPoints} hit points, not {expected}");
        }

        /// <summary>Remembers the hit points of the thing of a def at a cell until the scenario ends, so a later step can compare (hay in the rain). Compiled, not played.</summary>
        [Given("Nelim's Pickle Tools: the hit points of the thing {string} at \\({int}, {int}\\) are remembered")]
        public void RememberHitPoints(PickleContext ctx, string thingDefName, int x, int z)
        {
            Thing thing = ThingAt(ctx, thingDefName, x, z);
            RememberedHitPoints[thingDefName + "@" + x + "," + z] = thing.HitPoints;
        }

        /// <summary>Asserts the hit points of the thing equal what the remembering step stored: it did not deteriorate. Fails when nothing was remembered for that thing and cell. Compiled, not played.</summary>
        [Then("Nelim's Pickle Tools: the thing {string} at \\({int}, {int}\\) has kept its remembered hit points")]
        public void ThingKeptHitPoints(PickleContext ctx, string thingDefName, int x, int z)
        {
            string key = thingDefName + "@" + x + "," + z;
            ctx.Require(RememberedHitPoints.TryGetValue(key, out int before), $"no hit points were remembered for the {thingDefName} at ({x}, {z})");
            Thing thing = ThingAt(ctx, thingDefName, x, z);
            ctx.Assert(thing.HitPoints == before, $"the {thingDefName} at ({x}, {z}) has {thing.HitPoints} hit points, it had {before} when remembered");
        }

        [AfterScenario]
        public void ForgetHitPoints() => RememberedHitPoints.Clear();

        // A storage building is a Building_Storage (things lie in its slot group) or a Building_Bookcase (books sit in its own container, no slot group).
        private static Building StorageAt(PickleContext ctx, string buildingDefName, int x, int z)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            Building storage = cell.GetThingList(map).OfType<Building>().FirstOrDefault(b => b.def.defName == buildingDefName && (b is Building_Storage || b is Building_Bookcase));
            ctx.Require(storage != null, $"no storage building or bookcase {buildingDefName} stands at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(t => t.GetType().Name + " " + t.def.defName)));
            return storage;
        }

        private static IEnumerable<Thing> Held(Building storage)
        {
            if (storage is Building_Storage shelf) return shelf.GetSlotGroup().HeldThings;
            return ((IThingHolder)storage).GetDirectlyHeldThings().ToList();
        }

        private static Thing Put(Building storage, Thing thing, Map map)
        {
            if (storage is Building_Storage)
            {
                GenPlace.TryPlaceThing(thing, storage.Position, map, ThingPlaceMode.Direct, out Thing placed);
                return placed;
            }

            return ((IThingHolder)storage).GetDirectlyHeldThings().TryAdd(thing, false) ? thing : null;
        }

        private static bool WouldStore(PickleContext ctx, string buildingDefName, int x, int z, string thingDefName)
        {
            var storage = StorageAt(ctx, buildingDefName, x, z);
            ctx.Require(storage is Building_Storage, $"the {buildingDefName} is a bookcase; accepts/refuses reads slot groups, which a bookcase has none");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(thingDefName);
            ctx.Require(def != null, $"no thing def '{thingDefName}' in this game");
            Map map = CurrentMap(ctx);
            Thing probe = ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
            try
            {
                return storage.OccupiedRect().Cells.Any(c => StoreUtility.IsGoodStoreCell(c, map, probe, null, Faction.OfPlayer));
            }
            finally
            {
                probe.Destroy();
            }
        }
        private static Thing ThingAt(PickleContext ctx, string thingDefName, int x, int z)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            Thing thing = cell.GetThingList(map).FirstOrDefault(t => t.def.defName == thingDefName);
            ctx.Require(thing != null, $"no {thingDefName} stands at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            return thing;
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
        /// Places a pot (a building, by defName) at a cell and a plant (by defName) in it, fully grown, in one step: the pot first, then the plant on
        /// the same cell, which the game lets stand there. Both are remembered for "the decor is removed". Fails when the cell holds a pawn or a
        /// building already, when the second def is not a plant, or when the pot or the plant is gone from the map after the step.
        /// </summary>
        [Given("Nelim's Pickle Tools: I place the decor {string} holding {string} fully grown at \\({int}, {int}\\)")]
        public void PlaceDecorHolding(PickleContext ctx, string potDefName, string plantDefName, int x, int z)
        {
            ThingDef plantDef = DefDatabase<ThingDef>.GetNamedSilentFail(plantDefName);
            ctx.Require(plantDef != null && plantDef.plant != null, $"'{plantDefName}' is not a plant def in this game");
            PlaceDecor(ctx, potDefName, x, z);
            Thing pot = Placed.Last();
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            var plant = (Plant)ThingMaker.MakeThing(plantDef);
            plant.Growth = 1f;
            Placed.Add(GenSpawn.Spawn(plant, cell, map, WipeMode.Vanish));
            ctx.Assert(pot.Spawned, $"the {potDefName} at ({x}, {z}) is gone after the {plantDefName} was placed in it: the game wipes the pot, a pot with a plant on it is not possible here");
            ctx.Assert(plant.Spawned, $"the {plantDefName} at ({x}, {z}) is not on the map after the step");
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
        /// Logs what a thing def is, to choose cells for it before it is placed ([decor-def]): its size, its category and passability, the
        /// kind of building (an attachment sits on a wall), whether it burns fuel or needs power, and the mod that owns it. Fails naming
        /// the def when the loaded game has none (the mod is not staged). Written 2026-11-05 for the modded decor of the Sanctuary.
        /// </summary>
        [Given("Nelim's Pickle Tools: the decor def {string} is described")]
        public void DescribeDef(PickleContext ctx, string thingDefName)
        {
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(thingDefName);
            if (def == null)
            {
                TerrainDef terrain = DefDatabase<TerrainDef>.GetNamedSilentFail(thingDefName);
                ctx.Require(terrain != null, $"no thing def or terrain def '{thingDefName}' in this game: is its mod staged?");
                Log.Message("[decor-def] " + terrain.defName + " is a TERRAIN (layer=" + terrain.layerable + " passability=" + terrain.passability + " mod=" + terrain.modContentPack?.PackageId + " texture=" + terrain.texturePath + ")");
                return;
            }

            string comps = def.comps == null ? string.Empty : string.Join(",", def.comps.Select(c => c.compClass?.Name));
            Log.Message("[decor-def] " + def.defName + " size=" + def.size.x + "x" + def.size.z + " category=" + def.category +
                        " passability=" + def.passability + " rotatable=" + def.rotatable + " attachment=" + (def.building?.isAttachment ?? false) +
                        " edifice=" + def.IsEdifice() + " placeWorkers=" + (def.placeWorkers == null ? string.Empty : string.Join(",", def.placeWorkers.Select(p => p.Name))) +
                        " comps=" + comps + " mod=" + def.modContentPack?.PackageId + " graphic=" + def.graphicData?.texPath);
        }

        /// <summary>
        /// Gives one cell the terrain and the paint of another cell (a patch of bare ground under a door that must match the room's
        /// floor). Not remembered for removal: the change is meant to stay, as when a fixture is repaired before it is saved.
        /// </summary>
        [Given("Nelim's Pickle Tools: the floor of the cell \\({int}, {int}\\) is copied from the cell \\({int}, {int}\\)")]
        public void CopyFloor(PickleContext ctx, int x, int z, int sx, int sz)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            var sample = new IntVec3(sx, 0, sz);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            ctx.Require(sample.InBounds(map), $"the cell ({sx}, {sz}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            TerrainDef terrain = map.terrainGrid.TerrainAt(sample);
            ColorDef color = map.terrainGrid.ColorAt(sample);
            map.terrainGrid.SetTerrain(cell, terrain);
            if (color != null)
            {
                map.terrainGrid.SetTerrainColor(cell, color);
            }

            ctx.Assert(
                map.terrainGrid.TerrainAt(cell) == terrain && map.terrainGrid.ColorAt(cell) == color,
                $"the floor at ({x}, {z}) should be {terrain.defName} painted {color?.defName ?? "nothing"} like ({sx}, {sz}); the game reports {map.terrainGrid.TerrainAt(cell)?.defName} painted {map.terrainGrid.ColorAt(cell)?.defName ?? "nothing"}");
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

        /// <summary>
        /// Turns every building of the def that stands in the rectangle to face north, east, south or west, on the same cells: the thing
        /// is taken off the map and spawned again with the new rotation at the position that keeps its occupied rectangle (a two-cell bed
        /// turned by half a turn would otherwise shift by one cell). Fails when none is found, so a wrong def or rectangle is not silent.
        /// NOT PLAYED. Written 2026-11-07 for NSB (pediatrics beds: head against the north wall).
        /// </summary>
        [Given("Nelim's Pickle Tools: the buildings {string} from \\({int}, {int}\\) to \\({int}, {int}\\) are turned to face {word}")]
        public void TurnBuildings(PickleContext ctx, string thingDefName, int x1, int z1, int x2, int z2, string facing)
        {
            Map map = CurrentMap(ctx);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(thingDefName);
            ctx.Require(def != null, $"no thing def named '{thingDefName}'");
            Rot4 rot;
            switch (facing.ToLowerInvariant())
            {
                case "north": rot = Rot4.North; break;
                case "east": rot = Rot4.East; break;
                case "south": rot = Rot4.South; break;
                case "west": rot = Rot4.West; break;
                default: ctx.Require(false, $"facing must be north, east, south or west, not '{facing}'"); return;
            }

            CellRect rect = CellRect.FromLimits(x1, z1, x2, z2);
            var found = new HashSet<Building>();
            foreach (IntVec3 c in rect)
            {
                if (!c.InBounds(map)) continue;
                foreach (Thing t in c.GetThingList(map))
                {
                    if (t is Building b && b.def == def) found.Add(b);
                }
            }

            ctx.Require(found.Count > 0, $"no building {thingDefName} from ({x1}, {z1}) to ({x2}, {z2})");
            foreach (Building b in found.ToList())
            {
                CellRect old = b.OccupiedRect();
                IntVec2 size = b.def.size;
                IntVec3 target = IntVec3.Invalid;
                foreach (IntVec3 cand in old)
                {
                    if (GenAdj.OccupiedRect(cand, rot, size) == old) { target = cand; break; }
                }

                ctx.Require(target.IsValid, $"{thingDefName} at ({b.Position.x}, {b.Position.z}) cannot be turned in place");
                Rot4 oldRot = b.Rotation;
                b.DeSpawn();
                GenSpawn.Spawn(b, target, map, rot, WipeMode.Vanish);
                Log.Message($"[decor-turned] {thingDefName} was rot {oldRot} on ({old.minX},{old.minZ})-({old.maxX},{old.maxZ}), now at ({target.x}, {target.z}) facing {rot}");
            }

            Log.Message($"[decor-turned] {found.Count} {thingDefName} turned to face {rot}");
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

        /// <summary>
        /// Switches on the power trader of the first building of a def (by defName) on a cell of the current map, with no power net: a bench,
        /// a lamp or a machine that works only when powered then works. Fails when no such building is on the cell or it has no
        /// <c>CompPowerTrader</c>. Not a grid: nothing is connected. Promoted 2026-10-15 from the copies of A Certain Series, Joy Preservation
        /// and Ancient Salvage, asked by Mintchoco Confectionery. Not played here.
        /// </summary>
        [Given("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) is powered")]
        public void BuildingPowered(PickleContext ctx, string defName, int x, int z)
        {
            Map map = CurrentMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"cell ({x}, {z}) is outside the map");
            Thing building = cell.GetThingList(map).FirstOrDefault(t => t.def.defName == defName);
            ctx.Require(building != null, $"no {defName} at ({x}, {z})");
            CompPowerTrader power = building.TryGetComp<CompPowerTrader>();
            ctx.Require(power != null, $"{defName} at ({x}, {z}) has no power trader component");
            power.PowerOn = true;
            ctx.Assert(power.PowerOn, $"{defName} at ({x}, {z}) is still off after the step");
        }

        private static Map CurrentMap(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map is loaded; load a save first with 'the save ... is loaded'");
            return map;
        }
    }
}
