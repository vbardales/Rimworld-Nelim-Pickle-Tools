using System;
using System.Linq;
using System.Reflection;
using HarmonyLib;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Holds the temperature of the map at a value for the rest of the scenario, so that a gallery capture of a pawn is not spoiled by the
    /// heat (sweat and blush of Facial Animation, a hot mood thought). Written 2026-10-08 at the request of SanctuaryBacklot (owner: 20 degrees).
    /// The value is imposed on every read of a temperature the game makes for a cell, a room, a pawn and the outdoors, and given back after the
    /// scenario. Needs Harmony.
    /// </summary>
    [PickleSteps]
    public class TemperatureSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private static Harmony harmony;
        private static float? held;

        private static void Hold(PickleContext ctx, float value)
        {
            if (harmony == null)
            {
                Harmony h = new Harmony("nelim.pickletools.temperature");
                int patched = 0;
                void Post(MethodBase m, string name)
                {
                    if (m == null) return;
                    h.Patch(m, postfix: new HarmonyMethod(typeof(TemperatureSteps), name));
                    patched++;
                }
                Post(AccessTools.Method(typeof(GenTemperature), "GetTemperatureForCell", new[] { typeof(IntVec3), typeof(Map) }), nameof(PostFloat));
                Post(AccessTools.PropertyGetter(typeof(MapTemperature), "OutdoorTemp"), nameof(PostFloat));
                Post(AccessTools.PropertyGetter(typeof(Room), "Temperature"), nameof(PostFloat));
                Post(AccessTools.PropertyGetter(typeof(Thing), "AmbientTemperature"), nameof(PostFloat));
                if (patched == 0)
                {
                    h.UnpatchAll(h.Id);
                    ctx.Require(false, "no temperature read could be patched: the game changed");
                }
                harmony = h;
                Log.Message("[temperature] " + patched + " reads of the temperature are held at " + value + " degrees");
            }
            held = value;
            // The mood thoughts that depend on the temperature are cached and refreshed on ticks; the scene runs paused, so drop them now.
            foreach (Pawn p in PawnsFinder.AllMaps_FreeColonists.ToList())
            {
                object situational = p.needs?.mood?.thoughts?.situational;
                if (situational == null) continue;
                situational.GetType().GetMethod("Notify_SituationalThoughtsDirty", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.Invoke(situational, null);
                var cache = situational.GetType().GetField("cachedThoughts", BindingFlags.Instance | BindingFlags.NonPublic);
                (cache?.GetValue(situational) as System.Collections.IList)?.Clear();
            }
        }

        private static void PostFloat(ref float __result)
        {
            if (held.HasValue) __result = held.Value;
        }

        /// <summary>
        /// Holds the temperature of the whole map (outdoors, every room, every pawn's ambient temperature) at this value in degrees Celsius
        /// until the scenario ends, then gives it back. Meant for captures: at 20 degrees a pawn does not sweat or blush. Place it before the pawns are
        /// framed. Needs Harmony.
        /// </summary>
        [Given(Prefix + "the temperature of the map is {float} degrees")]
        public void SetTemperature(PickleContext ctx, float degrees)
        {
            ctx.Require(Find.CurrentMap != null, "Load a map first");
            Hold(ctx, degrees);
        }

        /// <summary>Asserts the temperature of the map reads this value to half a degree, by the game's own reading of the outdoors.</summary>
        [Then(Prefix + "the temperature of the map reads {float} degrees")]
        public void TemperatureReads(PickleContext ctx, float degrees)
        {
            ctx.Require(Find.CurrentMap != null, "Load a map first");
            float read = Find.CurrentMap.mapTemperature.OutdoorTemp;
            ctx.Assert(Math.Abs(read - degrees) < 0.5f, "the temperature of the map should read " + degrees + " degrees; it reads " + read + " (was the step run first?)");
        }

        [AfterScenario]
        public void ReleaseTemperature()
        {
            held = null;
        }
    }
}
