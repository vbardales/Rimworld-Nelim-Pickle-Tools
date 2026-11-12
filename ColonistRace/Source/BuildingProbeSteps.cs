using System;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Generic steps on a finished building: set and read its fuel as a percentage, read whether it glows, read the temperature of its room, and ask the game
    /// whether a def may be placed on a cell. Asked for by RpF (Repossessed Furniture) on 2026-11-12, for any mod that adds buildings. COMPILED, NOT PLAYED.
    /// Everything reads or sets the live state: to read a state after some ticks, put <c>I let {int} ticks pass</c> before the Then step. The map must be loaded.
    /// </summary>
    [PickleSteps]
    public class BuildingProbeSteps
    {
        private static Map CurrentMap(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded; load a save or start a colony first");
            return map;
        }

        private static IntVec3 Cell(PickleContext ctx, Map map, int x, int z)
        {
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            return cell;
        }

        private static ThingWithComps BuildingAt(PickleContext ctx, string defName, int x, int z)
        {
            Map map = CurrentMap(ctx);
            IntVec3 cell = Cell(ctx, map, x, z);
            ThingWithComps thing = cell.GetThingList(map).OfType<ThingWithComps>().FirstOrDefault(t => string.Equals(t.def.defName, defName, StringComparison.OrdinalIgnoreCase));
            ctx.Require(thing != null, $"no {defName} stands at ({x}, {z}); the things there are " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            return thing;
        }

        private static CompRefuelable FuelOf(PickleContext ctx, string defName, int x, int z)
        {
            CompRefuelable fuel = BuildingAt(ctx, defName, x, z).GetComp<CompRefuelable>();
            ctx.Require(fuel != null, $"the {defName} at ({x}, {z}) has no fuel comp");
            return fuel;
        }

        /// <summary>
        /// Sets the fuel of the building of a def at a cell to a percentage of its capacity (0 to 100), up or down, through the comp's own Refuel and ConsumeFuel.
        /// Fails when the building has no fuel comp or the level read back differs by more than one percent.
        /// </summary>
        [Given("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) is filled with {int} percent fuel")]
        public void FuelSet(PickleContext ctx, string defName, int x, int z, int percent)
        {
            ctx.Require(percent >= 0 && percent <= 100, $"the percentage is 0 to 100, not {percent}");
            CompRefuelable fuel = FuelOf(ctx, defName, x, z);
            float target = fuel.Props.fuelCapacity * percent / 100f;
            if (target > fuel.Fuel) fuel.Refuel(target - fuel.Fuel);
            else if (target < fuel.Fuel) fuel.ConsumeFuel(fuel.Fuel - target);
            ThingWithComps building = (ThingWithComps)fuel.parent;
            building.GetComp<CompGlower>()?.UpdateLit(building.Map);
            float read = fuel.Fuel / fuel.Props.fuelCapacity * 100f;
            ctx.Assert(Math.Abs(read - percent) <= 1f, $"the {defName} at ({x}, {z}) holds {read:0.#} percent fuel ({fuel.Fuel} of {fuel.Props.fuelCapacity}), not {percent}");
        }

        /// <summary>Asserts the fuel of the building of a def at a cell is at least this percentage of its capacity.</summary>
        [Then("Nelim's Pickle Tools: the fuel of the building {string} at \\({int}, {int}\\) is at least {int} percent")]
        public void FuelAtLeast(PickleContext ctx, string defName, int x, int z, int percent)
        {
            CompRefuelable fuel = FuelOf(ctx, defName, x, z);
            float read = fuel.Fuel / fuel.Props.fuelCapacity * 100f;
            ctx.Assert(read >= percent - 0.01f, $"the {defName} at ({x}, {z}) holds {read:0.#} percent fuel ({fuel.Fuel} of {fuel.Props.fuelCapacity}), less than {percent}");
        }

        /// <summary>Asserts the fuel of the building of a def at a cell is at most this percentage of its capacity (use 0 for out of fuel).</summary>
        [Then("Nelim's Pickle Tools: the fuel of the building {string} at \\({int}, {int}\\) is at most {int} percent")]
        public void FuelAtMost(PickleContext ctx, string defName, int x, int z, int percent)
        {
            CompRefuelable fuel = FuelOf(ctx, defName, x, z);
            float read = fuel.Fuel / fuel.Props.fuelCapacity * 100f;
            ctx.Assert(read <= percent + 0.01f, $"the {defName} at ({x}, {z}) holds {read:0.#} percent fuel ({fuel.Fuel} of {fuel.Props.fuelCapacity}), more than {percent}");
        }

        private static CompGlower GlowerOf(PickleContext ctx, string defName, int x, int z)
        {
            CompGlower glower = BuildingAt(ctx, defName, x, z).GetComp<CompGlower>();
            ctx.Require(glower != null, $"the {defName} at ({x}, {z}) has no light comp (CompGlower)");
            return glower;
        }

        /// <summary>Asserts the building of a def at a cell glows now (its light comp is lit: a lamp that is powered and on, a torch that holds fuel). Fails when it has no light comp.</summary>
        [Then("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) glows")]
        public void Glows(PickleContext ctx, string defName, int x, int z)
        {
            CompGlower glower = GlowerOf(ctx, defName, x, z);
            ctx.Assert(glower.Glows, $"the {defName} at ({x}, {z}) does not glow");
        }

        /// <summary>Asserts the building of a def at a cell does not glow now. Fails when it has no light comp (a building with no light never glows: that is not what is asked).</summary>
        [Then("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) does not glow")]
        public void DoesNotGlow(PickleContext ctx, string defName, int x, int z)
        {
            CompGlower glower = GlowerOf(ctx, defName, x, z);
            ctx.Assert(!glower.Glows, $"the {defName} at ({x}, {z}) glows");
        }

        private static float RoomTemperature(PickleContext ctx, int x, int z)
        {
            Map map = CurrentMap(ctx);
            IntVec3 cell = Cell(ctx, map, x, z);
            Room room = cell.GetRoom(map);
            ctx.Require(room != null, $"no room holds ({x}, {z})");
            return room.Temperature;
        }

        /// <summary>Asserts the temperature of the room that holds a cell is at least this value in degrees Celsius (a heater that warms a closed room).</summary>
        [Then("Nelim's Pickle Tools: the room at \\({int}, {int}\\) is at least {float} degrees")]
        public void RoomAtLeast(PickleContext ctx, int x, int z, float degrees)
        {
            float read = RoomTemperature(ctx, x, z);
            ctx.Assert(read >= degrees, $"the room at ({x}, {z}) is at {read:0.#} degrees, less than {degrees}");
        }

        /// <summary>Asserts the temperature of the room that holds a cell is at most this value in degrees Celsius (a cooler).</summary>
        [Then("Nelim's Pickle Tools: the room at \\({int}, {int}\\) is at most {float} degrees")]
        public void RoomAtMost(PickleContext ctx, int x, int z, float degrees)
        {
            float read = RoomTemperature(ctx, x, z);
            ctx.Assert(read <= degrees, $"the room at ({x}, {z}) is at {read:0.#} degrees, more than {degrees}");
        }

        /// <summary>
        /// Runs the game at its fastest speed until a bill (by recipe defName) of a work building (by defName, at a cell) is done, counted in GAME ticks, and puts the
        /// speed back. A "do N times" bill (repeat count) leaves the stack when its last iteration is finished, which is what is awaited; a "do forever" or "until X" bill
        /// never leaves, so the step refuses them up front. The deadline is the game's ticks (the real-time cap is 285 s, near 2800 ticks at 10 ticks per second on 1.7, 17000 at
        /// 60). Written 2026-11-12 for HMM (Pickle's <c>I wait for bill</c> counts real seconds and gave up at 120 s on 1.7). On failure it says what the colonists do and the
        /// state of the bill. COMPILED, NOT PLAYED. Put it right after the bill is added and the colonist is free to work.
        /// </summary>
        [When("Nelim's Pickle Tools: the bill {string} on the building {string} at \\({int}, {int}\\) is done within {int} ticks", TimeoutSeconds = 295f)]
        public async System.Threading.Tasks.Task BillDoneWithin(PickleContext ctx, string recipeName, string defName, int x, int z, int ticks)
        {
            ctx.Require(ticks >= 1, "the tick count is at least 1");
            ThingWithComps building = BuildingAt(ctx, defName, x, z);
            var giver = building as IBillGiver;
            ctx.Require(giver != null, $"the {defName} at ({x}, {z}) holds no bills");
            Func<Bill_Production> find = () => giver.BillStack.Bills.OfType<Bill_Production>().FirstOrDefault(b => b.recipe.defName == recipeName);
            Bill_Production bill = find();
            ctx.Require(bill != null, $"the {defName} at ({x}, {z}) has no bill for '{recipeName}'; it has " + string.Join(", ", giver.BillStack.Bills.Select(b => b.recipe.defName)));
            ctx.Require(bill.repeatMode == BillRepeatModeDefOf.RepeatCount, $"the bill '{recipeName}' repeats '{bill.repeatMode.defName}': only a 'do N times' bill leaves the stack when done, so this step cannot wait for it");
            Map map = building.Map;
            TickManager tm = Find.TickManager;
            TimeSpeed before = tm.CurTimeSpeed;
            int start = tm.TicksGame;
            int target = start + ticks;
            tm.CurTimeSpeed = TimeSpeed.Ultrafast;
            try { await ctx.WaitUntil(() => find() == null || tm.TicksGame >= target, 285f); }
            finally { tm.CurTimeSpeed = before; }
            if (find() == null) return;
            Bill_Production left = find();
            string workers = string.Join("; ", map.mapPawns.FreeColonistsSpawned.Take(8).Select(p => p.LabelShort + ": " + (p.CurJob == null ? "no job" : p.CurJob.def.defName + (p.CurJob.bill == left ? " (this bill)" : ""))));
            ctx.Assert(false, $"the bill '{recipeName}' on the {defName} at ({x}, {z}) is not done after {tm.TicksGame - start} ticks (asked {ticks}): {left.repeatCount} left to do, suspended {left.suspended}, should be done now {left.ShouldDoNow()}; colonists: {workers}");
        }

        private static AcceptanceReport CanPlace(PickleContext ctx, string defName, int x, int z, string facing, out BuildableDef def)
        {
            Map map = CurrentMap(ctx);
            def = (BuildableDef)DefDatabase<ThingDef>.GetNamedSilentFail(defName) ?? DefDatabase<TerrainDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef or TerrainDef named '{defName}'");
            IntVec3 cell = Cell(ctx, map, x, z);
            return GenConstruct.CanPlaceBlueprintAt(def, cell, SerumChainSteps.ParseFacing(ctx, facing), map);
        }

        /// <summary>
        /// Asks the game, as the architect does, whether a def (a building or a terrain) may be placed with its centre on a cell, facing north: its own
        /// <c>GenConstruct.CanPlaceBlueprintAt</c>, place workers and terrain rules included. Nothing is placed. Fails with the game's reason when refused.
        /// </summary>
        [Then("Nelim's Pickle Tools: placing {string} at \\({int}, {int}\\) is allowed")]
        public void PlacingAllowed(PickleContext ctx, string defName, int x, int z) => Allowed(ctx, defName, x, z, "north");

        /// <summary>The same with a facing: north, east, south or west.</summary>
        [Then("Nelim's Pickle Tools: placing {string} at \\({int}, {int}\\) facing {word} is allowed")]
        public void PlacingAllowedFacing(PickleContext ctx, string defName, int x, int z, string facing) => Allowed(ctx, defName, x, z, facing);

        private static void Allowed(PickleContext ctx, string defName, int x, int z, string facing)
        {
            AcceptanceReport report = CanPlace(ctx, defName, x, z, facing, out _);
            ctx.Assert(report.Accepted, $"placing {defName} at ({x}, {z}) is refused: '{report.Reason}'");
        }

        /// <summary>
        /// Asserts the game refuses to place a def on a cell (facing north) and that its reason contains the text, case ignored (the message of a place
        /// worker, a rot protection or a terrain rule, as the player reads it in the active language). Pass an empty text to accept any reason. Nothing is placed.
        /// </summary>
        [Then("Nelim's Pickle Tools: placing {string} at \\({int}, {int}\\) is refused with {string}")]
        public void PlacingRefused(PickleContext ctx, string defName, int x, int z, string text) => Refused(ctx, defName, x, z, "north", text);

        /// <summary>The same with a facing: north, east, south or west.</summary>
        [Then("Nelim's Pickle Tools: placing {string} at \\({int}, {int}\\) facing {word} is refused with {string}")]
        public void PlacingRefusedFacing(PickleContext ctx, string defName, int x, int z, string facing, string text) => Refused(ctx, defName, x, z, facing, text);

        private static void Refused(PickleContext ctx, string defName, int x, int z, string facing, string text)
        {
            AcceptanceReport report = CanPlace(ctx, defName, x, z, facing, out _);
            ctx.Assert(!report.Accepted, $"placing {defName} at ({x}, {z}) is allowed; the test expected it to be refused");
            string reason = report.Reason ?? "";
            ctx.Assert(string.IsNullOrEmpty(text) || reason.IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0,
                $"placing {defName} at ({x}, {z}) is refused with '{reason}', which does not contain '{text}'");
        }
    }
}
