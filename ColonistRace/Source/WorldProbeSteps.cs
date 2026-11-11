using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Reflection;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that set up a scene for a mod that reacts to its surroundings (a scent, a smell, a mood from a room or a corpse) and one read-only probe of a
    /// mod's static state. Written 2026-11-03 for RimScentExtended. NOT PLAYED when written: compiled only. What a step creates (corpses, food) is
    /// destroyed after the scenario; the room temperature and the burner are not given back (the game moves the temperature on, a reload resets the rest).
    /// </summary>
    [PickleSteps]
    public class WorldProbeSteps
    {
        private static readonly List<Thing> Made = new List<Thing>();

        private static Map CurrentMap(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded; load a save first with 'the save ... is loaded'");
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
            ThingWithComps thing = cell.GetThingList(map).OfType<ThingWithComps>().FirstOrDefault(t => t.def.defName == defName);
            ctx.Require(thing != null, $"no {defName} stands at ({x}, {z}); the things there are " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            return thing;
        }

        /// <summary>
        /// Sets the temperature of the room that holds a cell to this value in degrees Celsius, once, through the room's temperature tracker. The game moves it
        /// back toward the outdoors over the next ticks, so place the step right before what reads it. Fails when the cell has no room or the game offers no
        /// way to set it.
        /// </summary>
        [Given("Nelim's Pickle Tools: the room at \\({int}, {int}\\) is held at {float} degrees")]
        public void RoomTemperature(PickleContext ctx, int x, int z, float degrees)
        {
            Map map = CurrentMap(ctx);
            Room room = Cell(ctx, map, x, z).GetRoom(map);
            ctx.Require(room != null, $"no room holds ({x}, {z})");
            const BindingFlags any = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic;
            PropertyInfo prop = typeof(Room).GetProperty("Temperature", any);
            if (prop != null && prop.CanWrite) prop.SetValue(room, degrees);
            else
            {
                object tracker = typeof(Room).GetField("tempTracker", any)?.GetValue(room) ?? typeof(Room).GetProperty("TempTracker", any)?.GetValue(room);
                ctx.Require(tracker != null, "the game has no way to set the temperature of a room that this step knows");
                PropertyInfo t = tracker.GetType().GetProperty("Temperature", any);
                ctx.Require(t != null && t.CanWrite, "the room temperature tracker has no settable Temperature");
                t.SetValue(tracker, degrees);
            }

            ctx.Assert(Math.Abs(room.Temperature - degrees) < 0.5f, $"the room at ({x}, {z}) should be at {degrees} degrees; it reads {room.Temperature}");
        }

        /// <summary>Fills the fuel of the building of a def at a cell to its capacity (<c>CompRefuelable</c>). Fails when the building has no fuel comp.</summary>
        [Given("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) is fuelled")]
        public void Fuelled(PickleContext ctx, string defName, int x, int z)
        {
            ThingWithComps building = BuildingAt(ctx, defName, x, z);
            CompRefuelable fuel = building.GetComp<CompRefuelable>();
            ctx.Require(fuel != null, $"the {defName} has no fuel comp");
            fuel.Refuel(fuel.Props.fuelCapacity - fuel.Fuel);
            ctx.Assert(fuel.Fuel >= fuel.Props.fuelCapacity - 0.01f, $"the {defName} at ({x}, {z}) holds {fuel.Fuel} fuel, not its capacity {fuel.Props.fuelCapacity}");
        }

        /// <summary>Empties the fuel of the building of a def at a cell (<c>CompRefuelable</c>), so a torch or campfire goes out and its glow is recomputed. Fails when the building has no fuel comp.</summary>
        [Given("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) is put out")]
        public void PutOut(PickleContext ctx, string defName, int x, int z)
        {
            ThingWithComps building = BuildingAt(ctx, defName, x, z);
            CompRefuelable fuel = building.GetComp<CompRefuelable>();
            ctx.Require(fuel != null, $"the {defName} has no fuel comp");
            fuel.ConsumeFuel(fuel.Fuel);
            building.GetComp<CompGlower>()?.UpdateLit(building.Map);
            ctx.Assert(fuel.Fuel <= 0.01f, $"the {defName} at ({x}, {z}) still holds {fuel.Fuel} fuel");
        }

        /// <summary>Switches a flickable building of a def at a cell on or off (<c>CompFlickable.SwitchIsOn</c>, <c>{word}</c> is on or off). Fails when it has no flick comp.</summary>
        [Given("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) is switched {word}")]
        public void Switched(PickleContext ctx, string defName, int x, int z, string state)
        {
            ctx.Require(state == "on" || state == "off", $"the state is on or off, not '{state}'");
            ThingWithComps building = BuildingAt(ctx, defName, x, z);
            CompFlickable flick = building.GetComp<CompFlickable>();
            ctx.Require(flick != null, $"the {defName} has no flick comp");
            flick.SwitchIsOn = state == "on";
            ctx.Assert(flick.SwitchIsOn == (state == "on"), $"the {defName} at ({x}, {z}) should be switched {state}");
        }

        /// <summary>
        /// Powers (by a battery, as against `is powered` of StageDecor which only flips PowerOn) the building of a def at a cell through the game's own power net: a Battery (full) is spawned on a free cell touching the building, the nets
        /// are rebuilt and ticked once (the scene runs paused). Fails when the building has no power comp, no cell touches it, or the building is still unpowered
        /// after that (its switch is off, or the draw is above the battery's stored energy: it holds 600 Wd). Does not touch the building's switch.
        /// Asked for by RSEIE (electric crematorium and smelter scents). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the building {string} at \\({int}, {int}\\) is powered by a battery")]
        public async System.Threading.Tasks.Task Powered(PickleContext ctx, string defName, int x, int z)
        {
            ThingWithComps building = BuildingAt(ctx, defName, x, z);
            CompPowerTrader trader = building.GetComp<CompPowerTrader>();
            ctx.Require(trader != null, $"the {defName} has no power trader comp");
            Map map = building.Map;
            ThingDef batteryDef = DefDatabase<ThingDef>.GetNamedSilentFail("Battery");
            ctx.Require(batteryDef != null, "no Battery def in this game");
            IntVec3 spot = GenAdj.CellsAdjacentCardinal(building).FirstOrDefault(c => c.InBounds(map) && c.Standable(map) && c.GetEdifice(map) == null && c.GetFirstItem(map) == null);
            ctx.Require(spot.IsValid && spot != IntVec3.Zero, $"no free cell touches the {defName} at ({x}, {z}) for a battery");
            var battery = (ThingWithComps)ThingMaker.MakeThing(batteryDef);
            battery.SetFactionDirect(Faction.OfPlayer);
            GenSpawn.Spawn(battery, spot, map);
            battery.GetComp<CompPowerBattery>().SetStoredEnergyPct(1f);
            ctx.Require(battery.Spawned, $"the Battery did not stay spawned at {spot} (something destroyed or refused it)");
            map.powerNetManager.UpdatePowerNetsAndConnections_First();
            await ctx.WaitFrames(3);
            // The game connects a trader to an adjacent transmitter when either spawns, but a building put on the map by a step can miss that pass (RSEIE 2026-11-11: 3x2 crematorium,
            // "net none" after the battery). Connect it ourselves with the game's own call, then let the net be rebuilt.
            CompPower batteryPower = battery.GetComp<CompPower>();
            if (trader.PowerNet == null && batteryPower != null && trader.connectParent == null)
            {
                trader.ConnectToTransmitter(batteryPower);
                map.powerNetManager.UpdatePowerNetsAndConnections_First();
                await ctx.WaitFrames(3);
            }

            // The net decides PowerOn when it ticks: tick it a few times, as the game's own map tick would, before reading the state.
            for (int tick = 0; tick < 5 && trader.PowerNet != null && !trader.PowerOn; tick++) trader.PowerNet.PowerNetTick();
            CompPower batteryComp = battery.GetComp<CompPower>();
            string net = trader.PowerNet == null
                ? "none"
                : $"{trader.PowerNet.powerComps.Count} traders/producers, {trader.PowerNet.batteryComps.Count} batteries, stored {trader.PowerNet.CurrentStoredEnergy():0.0} Wd, gain {trader.PowerNet.CurrentEnergyGainRate():0.0} Wd per tick, the battery is " + (batteryComp?.PowerNet == trader.PowerNet ? "on this net" : "NOT on this net");
            Log.Message($"[power] battery at {spot} for the {defName} at ({x}, {z}): net {net}, PowerOn {trader.PowerOn}, draws {trader.Props.PowerConsumption:0} W");
            ctx.Assert(trader.PowerOn, $"the {defName} at ({x}, {z}) is still unpowered after the battery at {spot} (net {net}; draws {trader.Props.PowerConsumption:0} W; switch " + (building.GetComp<CompFlickable>()?.SwitchIsOn.ToString() ?? "none") + ")");
        }

        /// <summary>Asserts the power state of the building of a def at a cell: <c>CompPowerTrader.PowerOn</c> is true for <c>powered</c>, false for <c>unpowered</c>. Fails when the building has no power comp.</summary>
        [Then("Nelim's Pickle Tools: the power of the building {string} at \\({int}, {int}\\) is {word}")]
        public void PowerState(PickleContext ctx, string defName, int x, int z, string state)
        {
            ctx.Require(state == "powered" || state == "unpowered", $"the state is powered or unpowered, not '{state}'");
            CompPowerTrader trader = BuildingAt(ctx, defName, x, z).GetComp<CompPowerTrader>();
            ctx.Require(trader != null, $"the {defName} has no power trader comp");
            ctx.Assert(trader.PowerOn == (state == "powered"), $"the {defName} at ({x}, {z}) should be {state}; PowerOn is {trader.PowerOn}");
        }

        /// <summary>
        /// Places a corpse of a pawn kind at a cell at a rot stage: <c>fresh</c> (no rot), <c>rotting</c> (just past the start of rot) or <c>dessicated</c> (past
        /// the time to dessicate). The pawn is generated, spawned and killed, so the corpse is the game's own. Removed after the scenario.
        /// </summary>
        [Given("Nelim's Pickle Tools: a {word} corpse of the kind {string} is placed at \\({int}, {int}\\)")]
        public void Corpse(PickleContext ctx, string stage, string kindName, int x, int z)
        {
            ctx.Require(stage == "fresh" || stage == "rotting" || stage == "dessicated", $"the rot stage is fresh, rotting or dessicated, not '{stage}'");
            Map map = CurrentMap(ctx);
            IntVec3 cell = Cell(ctx, map, x, z);
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no pawn kind '{kindName}' in this game");
            Pawn pawn = PawnGenerator.GeneratePawn(kind, null);
            GenSpawn.Spawn(pawn, cell, map);
            pawn.Kill(null);
            Corpse corpse = pawn.Corpse;
            ctx.Require(corpse != null && corpse.Spawned, $"the {kindName} left no corpse at ({x}, {z})");
            Made.Add(corpse);
            CompRottable rot = corpse.GetComp<CompRottable>();
            ctx.Require(rot != null, $"the corpse of {kindName} cannot rot");
            rot.RotProgress = stage == "fresh" ? 0f : stage == "rotting" ? rot.PropsRot.TicksToRotStart + 1f : rot.PropsRot.TicksToDessicated + 1f;
            ctx.Assert(rot.Stage == (stage == "fresh" ? RotStage.Fresh : stage == "rotting" ? RotStage.Rotting : RotStage.Dessicated), $"the corpse should be {stage}; it is {rot.Stage}");
        }

        /// <summary>
        /// Places a thing of a def with a rot comp (food) at a cell, its rot progress set to this fraction of its time to start rotting: 0 is fresh, 1 or more is
        /// spoiled (rotten). Removed after the scenario. Fails when the def cannot rot.
        /// </summary>
        [Given("Nelim's Pickle Tools: the thing {string} is placed at \\({int}, {int}\\) at {float} of its time to rot")]
        public void RotFood(PickleContext ctx, string defName, int x, int z, float fraction)
        {
            Map map = CurrentMap(ctx);
            IntVec3 cell = Cell(ctx, map, x, z);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no thing def '{defName}' in this game");
            Thing thing = ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
            CompRottable rot = thing.TryGetComp<CompRottable>();
            ctx.Require(rot != null, $"the {defName} cannot rot");
            GenSpawn.Spawn(thing, cell, map);
            ctx.Require(thing.Spawned, $"the {defName} did not reach ({x}, {z})");
            Made.Add(thing);
            rot.RotProgress = fraction * rot.PropsRot.TicksToRotStart + (fraction >= 1f ? 1f : 0f);
            ctx.Assert(fraction < 1f || rot.Stage != RotStage.Fresh, $"the {defName} should be spoiled; its rot stage is {rot.Stage}");
        }

        [AfterScenario]
        public void RemoveMade()
        {
            foreach (Thing t in Made.ToList()) if (!t.Destroyed) t.Destroy();
            Made.Clear();
        }

        /// <summary>
        /// Reads a static field or property of a type, then a dotted path of fields and properties (public or not, instance) after it, and compares the value's text
        /// with the expected text, ignoring case; two numbers compare within 0.0001. The type is found by full name, or by short name when only one type has it.
        /// Read only: it changes nothing. Example: <c>the static member "settings.threshold" of the type "MyMod.Core" is "5"</c>.
        /// </summary>
        [Then("Nelim's Pickle Tools: the static member {string} of the type {string} is {string}")]
        public void StaticMemberIs(PickleContext ctx, string path, string typeName, string expected)
        {
            Type type = FindType(ctx, typeName);
            string[] parts = path.Split('.');
            const BindingFlags all = BindingFlags.Instance | BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.FlattenHierarchy;
            object value = null;
            Type at = type;
            for (int i = 0; i < parts.Length; i++)
            {
                object holder = value;
                if (i > 0) { ctx.Require(holder != null, $"'{string.Join(".", parts.Take(i))}' of {type.FullName} is null; cannot read '{parts[i]}'"); at = holder.GetType(); }
                MemberInfo member = at.GetMember(parts[i], all).FirstOrDefault(m => (m is FieldInfo f && (i > 0 || f.IsStatic)) || (m is PropertyInfo p && p.GetIndexParameters().Length == 0 && p.CanRead && (i > 0 || (p.GetMethod?.IsStatic ?? false))));
                ctx.Require(member != null, $"{at.FullName} has no {(i == 0 ? "static " : "")}field or property '{parts[i]}'; its members are " + string.Join(", ", at.GetMembers(all).Where(m => m is FieldInfo || m is PropertyInfo).Select(m => m.Name).Distinct().Take(40)));
                value = member is FieldInfo fi ? fi.GetValue(holder) : ((PropertyInfo)member).GetValue(holder);
            }

            string read = Convert.ToString(value, CultureInfo.InvariantCulture) ?? "null";
            bool same = string.Equals(read, expected, StringComparison.OrdinalIgnoreCase)
                || (float.TryParse(read, NumberStyles.Float, CultureInfo.InvariantCulture, out float a) && float.TryParse(expected, NumberStyles.Float, CultureInfo.InvariantCulture, out float b) && Math.Abs(a - b) <= 0.0001f);
            ctx.Assert(same, $"{type.FullName}.{path} reads '{read}', not '{expected}'");
        }

        private static Type FindType(PickleContext ctx, string typeName)
        {
            var found = new List<Type>();
            foreach (Assembly asm in AppDomain.CurrentDomain.GetAssemblies())
            {
                Type exact = asm.GetType(typeName, false);
                if (exact != null) return exact;
                try { found.AddRange(asm.GetTypes().Where(t => t.Name == typeName)); } catch (ReflectionTypeLoadException) { }
            }

            ctx.Require(found.Count == 1, found.Count == 0 ? $"no type '{typeName}' is loaded" : $"the type name '{typeName}' is shared by " + string.Join(", ", found.Select(t => t.FullName)) + "; give the full name");
            return found[0];
        }
    }
}
