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
        }

        // The mood thoughts that depend on the temperature are cached and refreshed on ticks; the scene runs paused, so drop them now.
        // Cosmetic refresh: nothing in it may fail the step, the temperature is already held at this point (a mod's thought that throws while it is rebuilt,
            // fa-head-gallery-1, 2026-10-30; the colonist list itself or a pawn label throwing in SanctuaryBacklot ticket 2840, 2026-11-04, "Exception has been thrown
            // by the target of an invocation" right after the log line above). The whole refresh sits in one try, and the exception is logged in full.
        private static void RefreshSituationalThoughts()
        {
            try
            {
                foreach (Pawn p in PawnsFinder.AllMaps_FreeColonists.ToList())
                {
                    try
                    {
                        object situational = p.needs?.mood?.thoughts?.situational;
                        if (situational == null) continue;
                        situational.GetType().GetMethod("Notify_SituationalThoughtsDirty", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.Invoke(situational, null);
                        var cache = situational.GetType().GetField("cachedThoughts", BindingFlags.Instance | BindingFlags.NonPublic);
                        (cache?.GetValue(situational) as System.Collections.IList)?.Clear();
                    }
                    catch (Exception e)
                    {
                        Log.Warning("[temperature] the situational thoughts of a colonist could not be refreshed: " + (e.InnerException ?? e));
                    }
                }
            }
            catch (Exception e)
            {
                Log.Warning("[temperature] the situational thoughts could not be refreshed: " + (e.InnerException ?? e));
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
        public async System.Threading.Tasks.Task SetTemperature(PickleContext ctx, float degrees)
        {
            ctx.Require(Find.CurrentMap != null, "Load a map first");
            Hold(ctx, degrees);
            // The pawn lists of the game may be read on the main thread only: a step of a Background can start elsewhere (SanctuaryBacklot tickets 496b and 17c2,
            // 2026-11-05: "Accessing map pawns off main thread", reported by a later step). The wait resumes on the main thread.
            if (!UnityData.IsInMainThread)
            {
                await ctx.WaitUntil(() => UnityData.IsInMainThread, 30f);
            }

            RefreshSituationalThoughts();
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
