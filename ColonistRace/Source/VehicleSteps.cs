using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using Verse;
using RimWorld;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A vehicle of Vehicle Framework (SmashPhil.VehicleFramework), finished, on a cell. A VehicleDef is a ThingDef that makes a VehiclePawn: the generic spawn steps
    /// (building, item) do not apply. Reflection only, so the tool does not depend on the framework. Written 2026-11-14 for the catalogue of RimAlert Vehicle
    /// (3256230223). COMPILED, NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class VehicleSteps
    {
        private static Type FindType(string fullName)
        {
            foreach (Assembly assembly in AppDomain.CurrentDomain.GetAssemblies())
            {
                Type t = assembly.GetType(fullName, false);
                if (t != null) return t;
            }

            return null;
        }

        /// <summary>
        /// Spawns a finished vehicle of the VehicleDef (by defName) of the player faction with its centre on a cell, facing north, east, south or west, through the framework's own
        /// <c>VehicleSpawner.GenerateVehicle</c> and the game's spawn. Fails when Vehicle Framework is not loaded, the def is not a VehicleDef or the framework's spawner is not
        /// found (the framework changed). The ground is not checked: clear the area first.
        /// </summary>
        [Given("Nelim's Pickle Tools: the vehicle {string} is spawned at \\({int}, {int}\\) facing {word}")]
        public void VehicleSpawned(PickleContext ctx, string defName, int x, int z, string facing)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            Type defType = FindType("Vehicles.VehicleDef");
            Type spawner = FindType("Vehicles.VehicleSpawner");
            ctx.Require(defType != null && spawner != null, "Vehicle Framework (Vehicles.VehicleDef, Vehicles.VehicleSpawner) is not loaded: put SmashPhil.VehicleFramework in the map");
            object def = typeof(DefDatabase<>).MakeGenericType(defType).GetMethod("GetNamedSilentFail", BindingFlags.Public | BindingFlags.Static).Invoke(null, new object[] { defName });
            ctx.Require(def != null, "no VehicleDef named '" + defName + "'");
            MethodInfo generate = spawner.GetMethods(BindingFlags.Public | BindingFlags.Static).FirstOrDefault(m => m.Name == "GenerateVehicle"
                && m.GetParameters().Length >= 2 && m.GetParameters()[0].ParameterType.IsAssignableFrom(defType) && m.GetParameters()[1].ParameterType == typeof(Faction));
            ctx.Require(generate != null, "Vehicles.VehicleSpawner.GenerateVehicle(VehicleDef, Faction) not found: the framework changed, update this step; its static methods: "
                + string.Join(", ", spawner.GetMethods(BindingFlags.Public | BindingFlags.Static).Select(m => m.Name + "/" + m.GetParameters().Length)));
            object[] args = new object[generate.GetParameters().Length];
            args[0] = def;
            args[1] = Faction.OfPlayer;
            for (int i = 2; i < args.Length; i++) args[i] = generate.GetParameters()[i].HasDefaultValue ? generate.GetParameters()[i].DefaultValue : null;
            var vehicle = generate.Invoke(null, args) as Thing;
            ctx.Require(vehicle != null, "the framework made no vehicle for " + defName);
            Rot4 rot = SerumChainSteps.ParseFacing(ctx, facing);
            GenSpawn.Spawn(vehicle, new IntVec3(x, 0, z), map, rot, WipeMode.Vanish);
            ctx.Require(vehicle.Spawned, "the vehicle " + defName + " was not spawned at (" + x + ", " + z + ")");
            Log.Message($"[vehicle] {defName} spawned at ({vehicle.Position.x}, {vehicle.Position.z}) facing {rot}, size {vehicle.def.size.x}x{vehicle.def.size.z}");
        }
    }
}
