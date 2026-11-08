using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>Reads the light of the current map so that a dark capture can be explained: the local hour, the sun glow, the weather, and whether the sky is dark.</summary>
    [PickleSteps]
    public class LightSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";

        [Then(Prefix + "the light of the map is logged")]
        public void LogLight(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            float glow = GenCelestial.CurCelestialSunGlow(map);
            Log.Message("[light] hour " + GenLocalDate.HourInteger(map) + " (day " + GenLocalDate.DayOfYear(map) + "), game ticks " + Find.TickManager.TicksGame
                + ", sun glow " + glow.ToString("0.00") + ", sky glow " + map.skyManager.CurSkyGlow.ToString("0.00") + ", weather " + map.weatherManager.curWeather.defName
                + ", eclipse " + map.gameConditionManager.ConditionIsActive(GameConditionDefOf.Eclipse) + ", active conditions " + string.Join(", ", map.gameConditionManager.ActiveConditions.ConvertAll(c => c.def.defName)));
        }

        // An eclipse darkens the whole map for days: end it so that noon is bright (the draft save carries one that the game rolled while Virginie played).
        [Given(Prefix + "the eclipse of the map is ended")]
        public void EndEclipse(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            // The eclipse can live on the map or on the world (a condition of the world reaches every map): end both, and say which one carried it.
            foreach (var manager in new[] { map.gameConditionManager, Find.World.gameConditionManager })
                foreach (GameCondition c in manager.ActiveConditions.ToList())
                    if (c.def == GameConditionDefOf.Eclipse)
                    {
                        Log.Message("[light] ending the eclipse held by the " + (manager == map.gameConditionManager ? "map" : "world") + ", permanent " + c.Permanent + ", ticks left " + c.TicksLeft);
                        c.Permanent = false;
                        c.End();
                    }
            ctx.Assert(!map.gameConditionManager.ConditionIsActive(GameConditionDefOf.Eclipse), "The eclipse is still active");
        }

        private static HarmonyLib.Harmony glowHarmony;
        private static float? glowFloor;

        // The glow grid keeps a cache: ask it to recompute through whichever refresh method this game version has.
        private static void RefreshGlow(Map map)
        {
            if (map == null) return;
            foreach (string n in new[] { "RecalculateAllGlow", "RecalculateAllGlowNow", "DirtyCache" })
            {
                System.Reflection.MethodInfo m = map.glowGrid.GetType().GetMethod(n, System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic, null, System.Type.EmptyTypes, null);
                if (m != null) { m.Invoke(map.glowGrid, null); break; }
            }
            map.mapDrawer.RegenerateEverythingNow();
        }

        private static float? glowCeiling;

        private static void PostGlowColor(ref UnityEngine.Color32 __result)
        {
            if (glowFloor.HasValue)
            {
                byte f = (byte)UnityEngine.Mathf.Clamp(UnityEngine.Mathf.RoundToInt(glowFloor.Value * 255f), 0, 255);
                __result = new UnityEngine.Color32((byte)System.Math.Max(__result.r, f), (byte)System.Math.Max(__result.g, f), (byte)System.Math.Max(__result.b, f), __result.a);
            }
            if (glowCeiling.HasValue)
            {
                byte c = (byte)UnityEngine.Mathf.Clamp(UnityEngine.Mathf.RoundToInt(glowCeiling.Value * 255f), 0, 255);
                __result = new UnityEngine.Color32((byte)System.Math.Min(__result.r, c), (byte)System.Math.Min(__result.g, c), (byte)System.Math.Min(__result.b, c), __result.a);
            }
        }

        private static void PostGlow(ref float __result)
        {
            if (glowFloor.HasValue && __result < glowFloor.Value) __result = glowFloor.Value;
            if (glowCeiling.HasValue && __result > glowCeiling.Value) __result = glowCeiling.Value;
        }

        // Patches every read of the glow grid once; the floor and the ceiling are read by the postfixes.
        private static void EnsureGlowPatched(PickleContext ctx)
        {
            if (glowHarmony != null) return;
            var h = new HarmonyLib.Harmony("nelim.pickletools.glowfloor");
            int patched = 0;
            var all = typeof(GlowGrid).GetMethods(System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.DeclaredOnly)
                .Where(x => !x.IsAbstract && !x.ContainsGenericParameters).ToList();
            // The signatures are logged: the glow reads differ between game versions (a float glow, a Color32 the lighting overlay draws; ticket eb32, AnN 2026-11-07).
            Log.Message("[light] GlowGrid methods: " + string.Join("; ", all.Select(x => x.ReturnType.Name + " " + x.Name + "(" + string.Join(", ", x.GetParameters().Select(p => p.ParameterType.Name)) + ")")));
            foreach (System.Reflection.MethodInfo m in all.Where(x => x.Name.IndexOf("GlowAt", System.StringComparison.OrdinalIgnoreCase) >= 0 || x.Name.IndexOf("Glow", System.StringComparison.OrdinalIgnoreCase) >= 0 && x.GetParameters().Length >= 1))
            {
                if (m.ReturnType == typeof(float)) { h.Patch(m, postfix: new HarmonyLib.HarmonyMethod(typeof(LightSteps), nameof(PostGlow))); patched++; }
                else if (m.ReturnType == typeof(UnityEngine.Color32)) { h.Patch(m, postfix: new HarmonyLib.HarmonyMethod(typeof(LightSteps), nameof(PostGlowColor))); patched++; }
            }
            if (patched == 0) { h.UnpatchAll(h.Id); ctx.Require(false, "no GlowGrid read could be patched: the game changed"); }
            glowHarmony = h;
            Log.Message("[light] " + patched + " reads of the glow are patched");
        }

        /// <summary>
        /// Dims the light of every cell of the map to at most this glow (0 dark, 1 full day) until the scenario ends, for a dusk or night capture that renders as day after the hour is set
        /// (AnB, gallery-lg-7, scenes 6 and 7). The glow grid is recomputed and the map mesh redrawn at once. Written 2026-11-08. COMPILED, NOT PLAYED. Needs Harmony.
        /// </summary>
        [Given(Prefix + "the light of the map is dimmed to at most {float}")]
        public void DimLight(PickleContext ctx, float ceiling)
        {
            ctx.Require(Find.CurrentMap != null, "No loaded map");
            ctx.Require(ceiling >= 0f && ceiling <= 1f, "the glow runs from 0 to 1");
            EnsureGlowPatched(ctx);
            glowCeiling = ceiling;
            RefreshGlow(Find.CurrentMap);
        }

        /// <summary>Recomputes the glow grid and redraws the map mesh, for a capture taken after the hour was set in a paused game (the glow cache is refreshed on a tick only).</summary>
        [When(Prefix + "the light of the map is refreshed")]
        public void RefreshLight(PickleContext ctx)
        {
            ctx.Require(Find.CurrentMap != null, "No loaded map");
            RefreshGlow(Find.CurrentMap);
        }

        /// <summary>
        /// Lifts the light of every cell of the map to at least this glow (0 dark, 1 full day) until the scenario ends, so an indoor capture (a roofed hut at 13:00 or 20:00 comes
        /// out dark green) is lit like a room with lamps. Raises the game glow, the ground glow and the visual glow the lighting overlay draws. Written 2026-11-07 at the request of AnN
        /// (AnimalsNaturally galerie-17). COMPILED, NOT PLAYED. Needs Harmony.
        /// </summary>
        [Given(Prefix + "the light of the map is lifted to at least {float}")]
        public void LiftLight(PickleContext ctx, float floor)
        {
            ctx.Require(Find.CurrentMap != null, "No loaded map");
            ctx.Require(floor >= 0f && floor <= 1f, "the glow runs from 0 to 1");
            EnsureGlowPatched(ctx);
            glowFloor = floor;
            RefreshGlow(Find.CurrentMap);
            Find.CurrentMap.mapDrawer.RegenerateEverythingNow();
        }

        [AfterScenario]
        public void ReleaseGlowFloor()
        {
            if (!glowFloor.HasValue && !glowCeiling.HasValue) return;
            glowFloor = null;
            glowCeiling = null;
            try { RefreshGlow(Find.CurrentMap); } catch { }
        }

        [Then(Prefix + "the sun glow of the map is at least {float}")]
        public void SunGlowAtLeast(PickleContext ctx, float minimum)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            float glow = map.skyManager.CurSkyGlow;
            ctx.Assert(glow >= minimum, "The sky glow is " + glow.ToString("0.00") + " at hour " + GenLocalDate.HourInteger(map) + " with the weather " + map.weatherManager.curWeather.defName + "; expected at least " + minimum);
        }
    }
}
