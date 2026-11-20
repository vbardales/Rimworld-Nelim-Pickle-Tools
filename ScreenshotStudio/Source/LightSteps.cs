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
        // Ceiling on the sun term only: in this game version the glow grid (GetAccumulatedGlowAt, VisualGlowAt) holds the LAMP glow alone, the sun is added by GroundGlowAt
        // (decompiled 2026-11-20, ticket b8a8 of AnN: no field "glowGrid" exists, the fields are accumulatedGlow and map). So the Color32 reads are left alone in this mode and the
        // float read keeps the lamp term of the cell (AnN galerie-45 and 46).
        private static bool ceilingKeepsLamps;
        private static float lampScale = 1f;

        // The lamp part of GroundGlowAt, as the game computes it (alpha 1 = overlit, else 3.6 x the brightest channel, at most 0.5), read through the public VisualGlowAt.
        private static float LampTerm(GlowGrid grid, object cell)
        {
            if (!(cell is IntVec3 c)) return 0f;
            UnityEngine.Color32 a = grid.VisualGlowAt(c);
            if (a.a == 1) return 1f;
            return UnityEngine.Mathf.Min(0.5f, System.Math.Max(a.r, System.Math.Max(a.g, a.b)) / 255f * 3.6f);
        }

        private static void PostGlowColor(GlowGrid __instance, object __0, ref UnityEngine.Color32 __result)
        {
            if (lampScale != 1f)
                __result = new UnityEngine.Color32((byte)UnityEngine.Mathf.Clamp(UnityEngine.Mathf.RoundToInt(__result.r * lampScale), 0, 255), (byte)UnityEngine.Mathf.Clamp(UnityEngine.Mathf.RoundToInt(__result.g * lampScale), 0, 255), (byte)UnityEngine.Mathf.Clamp(UnityEngine.Mathf.RoundToInt(__result.b * lampScale), 0, 255), __result.a);
            if (glowFloor.HasValue)
            {
                byte f = (byte)UnityEngine.Mathf.Clamp(UnityEngine.Mathf.RoundToInt(glowFloor.Value * 255f), 0, 255);
                __result = new UnityEngine.Color32((byte)System.Math.Max(__result.r, f), (byte)System.Math.Max(__result.g, f), (byte)System.Math.Max(__result.b, f), __result.a);
            }
            if (glowCeiling.HasValue && !ceilingKeepsLamps)
            {
                byte c = (byte)UnityEngine.Mathf.Clamp(UnityEngine.Mathf.RoundToInt(glowCeiling.Value * 255f), 0, 255);
                __result = new UnityEngine.Color32((byte)System.Math.Min(__result.r, c), (byte)System.Math.Min(__result.g, c), (byte)System.Math.Min(__result.b, c), __result.a);
            }
        }

        private static void PostGlow(GlowGrid __instance, object __0, ref float __result)
        {
            if (glowFloor.HasValue && __result < glowFloor.Value) __result = glowFloor.Value;
            if (glowCeiling.HasValue)
            {
                float keep = ceilingKeepsLamps ? System.Math.Max(glowCeiling.Value, LampTerm(__instance, __0)) : glowCeiling.Value;
                if (__result > keep) __result = keep;
            }
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
            Log.Message("[light] GlowGrid fields: " + string.Join("; ", typeof(GlowGrid).GetFields(System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Static | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.DeclaredOnly).Select(x => x.FieldType.Name + " " + x.Name)));
            Log.Message("[light] GlowGrid methods: " + string.Join("; ", all.Select(x => x.ReturnType.Name + " " + x.Name + "(" + string.Join(", ", x.GetParameters().Select(p => p.ParameterType.Name)) + ")")));
            foreach (System.Reflection.MethodInfo m in all.Where(x => x.GetParameters().Length >= 1 && x.Name.IndexOf("Glow", System.StringComparison.OrdinalIgnoreCase) >= 0))
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
            ceilingKeepsLamps = false;
            RefreshGlow(Find.CurrentMap);
        }

        /// <summary>
        /// Dims only the SUN term of the light of every cell to at most this glow (0 dark, 1 full day) and keeps the glow of lit lamps, torches and braziers as the glow grid stores it, so a lit
        /// lamp throws its pool on a dark night floor (AnN galerie-45: sun hold alone drew day; galerie-46: the plain dim clamped the lamps). Same patches as the plain dim; the float read (GroundGlowAt) keeps the lamp
        /// term of the cell and the Color32 reads (lamp glow alone in this game version) are not clamped. Written 2026-11-20, rewritten the same day after AnN's ticket b8a8 (the grid field is not called glowGrid). COMPILED, NOT PLAYED. Needs Harmony.
        /// </summary>
        [Given(Prefix + "the sun light of the map is dimmed to at most {float}, lamps kept")]
        public void DimSunLight(PickleContext ctx, float ceiling)
        {
            ctx.Require(Find.CurrentMap != null, "No loaded map");
            ctx.Require(ceiling >= 0f && ceiling <= 1f, "the glow runs from 0 to 1");
            EnsureGlowPatched(ctx);
            glowCeiling = ceiling;
            ceilingKeepsLamps = true;
            RefreshGlow(Find.CurrentMap);
        }

        /// <summary>
        /// Scales the glow of the lamps (every light of the glow grid: torches, braziers, lamps) to this percent of its value (100 = unchanged) until the scenario ends, keeping the falloff, so
        /// a night scene lit by lamps shows a pool that fades out instead of a floor lit flat (AnN galerie-46 and 48: a flat clamp or no clamp at all). Scales the Color32 lamp reads the
        /// lighting overlay draws and the lamp term GroundGlowAt computes from them. Written 2026-11-20. COMPILED, NOT PLAYED. Needs Harmony.
        /// </summary>
        [Given(Prefix + "the glow of the lamps is scaled to {int} percent")]
        public void ScaleLampGlow(PickleContext ctx, int percent)
        {
            ctx.Require(Find.CurrentMap != null, "No loaded map");
            ctx.Require(percent >= 0 && percent <= 400, "a percent runs from 0 to 400");
            EnsureGlowPatched(ctx);
            lampScale = percent / 100f;
            RefreshGlow(Find.CurrentMap);
        }

        /// <summary>
        /// Logs ([light-at]) what the light is on one cell: the lamp glow of the grid (r, g, b, a: alpha 1 = overlit), the ground glow the game reads, whether the cell is roofed, the sky glow
        /// and the sun glow. Reads only, to tell a lamp pool from the sun on a capture that reads bright. Written 2026-11-20 for AnN. COMPILED, NOT PLAYED.
        /// </summary>
        [When(Prefix + "the light at \\({int}, {int}\\) is logged")]
        public void LogLightAt(PickleContext ctx, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var c = new IntVec3(x, 0, z);
            ctx.Require(c.InBounds(map), "the cell (" + x + ", " + z + ") is off the map");
            UnityEngine.Color32 lamp = map.glowGrid.VisualGlowAt(c);
            Log.Message("[light-at] (" + x + ", " + z + ") lamp glow r" + lamp.r + " g" + lamp.g + " b" + lamp.b + " a" + lamp.a + ", ground glow " + map.glowGrid.GroundGlowAt(c).ToString("0.00") + ", ground glow without the sky " + map.glowGrid.GroundGlowAt(c, false, true).ToString("0.00")
                + ", roofed " + map.roofGrid.Roofed(c) + ", sky glow " + map.skyManager.CurSkyGlow.ToString("0.00") + ", sun glow " + GenCelestial.CurCelestialSunGlow(map).ToString("0.00"));
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

        private static HarmonyLib.Harmony sunHarmony;
        private static float? sunHeld;

        private static void PostSunGlow(ref float __result) { if (sunHeld.HasValue) __result = sunHeld.Value; }

        /// <summary>
        /// Holds the sun glow and the sky glow of the map at this value (0 night, 1 full day; about 0.3 to 0.6 is a dawn or dusk with a low sun and a tinted sky) until the scenario ends,
        /// whatever the hour: postfix on GenCelestial.CurCelestialSunGlow and SkyManager.CurSkyGlow, then the sky, the glow grid and the map mesh are refreshed at once. It changes what the game
        /// reads as the light of the day (sky colour, lighting overlay, shadows follow the sun position, not the glow). Written 2026-11-12 for ArS scene 1 (dawn). COMPILED, NOT PLAYED. Needs Harmony.
        /// </summary>
        [Given(Prefix + "the sun glow of the map is held at {float}")]
        public void HoldSunGlow(PickleContext ctx, float glow)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            ctx.Require(glow >= 0f && glow <= 1f, "the glow runs from 0 to 1");
            if (sunHarmony == null)
            {
                var h = new HarmonyLib.Harmony("nelim.pickletools.sunglowheld");
                int patched = 0;
                System.Reflection.MethodInfo a = typeof(GenCelestial).GetMethod("CurCelestialSunGlow", new[] { typeof(Map) });
                if (a != null && a.ReturnType == typeof(float)) { h.Patch(a, postfix: new HarmonyLib.HarmonyMethod(typeof(LightSteps), nameof(PostSunGlow))); patched++; }
                System.Reflection.MethodInfo b = typeof(SkyManager).GetProperty("CurSkyGlow")?.GetGetMethod();
                if (b != null && b.ReturnType == typeof(float)) { h.Patch(b, postfix: new HarmonyLib.HarmonyMethod(typeof(LightSteps), nameof(PostSunGlow))); patched++; }
                if (patched == 0) { h.UnpatchAll(h.Id); ctx.Require(false, "neither GenCelestial.CurCelestialSunGlow nor SkyManager.CurSkyGlow could be patched: the game changed"); }
                Log.Message("[light] " + patched + " sun glow reads are patched");
                sunHarmony = h;
            }
            sunHeld = glow;
            RefreshSky(map);
            ctx.Assert(System.Math.Abs(GenCelestial.CurCelestialSunGlow(map) - glow) < 0.001f, "the sun glow reads " + GenCelestial.CurCelestialSunGlow(map).ToString("0.00") + " after the step, not " + glow);
        }

        private static void RefreshSky(Map map)
        {
            if (map == null) return;
            try { map.skyManager.ForceSetCurSkyGlow(sunHeld ?? GenCelestial.CurCelestialSunGlow(map)); } catch { }
            try { map.skyManager.SkyManagerUpdate(); } catch { }
            RefreshGlow(map);
        }

        [AfterScenario]
        public void ReleaseSunGlow()
        {
            if (!sunHeld.HasValue) return;
            sunHeld = null;
            try { RefreshSky(Find.CurrentMap); } catch { }
        }

        [AfterScenario]
        public void ReleaseGlowFloor()
        {
            if (!glowFloor.HasValue && !glowCeiling.HasValue) return;
            glowFloor = null;
            glowCeiling = null;
            try { RefreshGlow(Find.CurrentMap); } catch { }
        }

        /// <summary>
        /// Sets the local date of the map to a day of the year (0 to 59: 15 days a quadrum, so the 8th of the third quadrum is day 37) and an hour (0 to 23), keeping the year, by moving the
        /// game tick counter, so every scene of a gallery shows the same date (the plain hour step moves to the nearest such hour, which can fall on the day before or after). Reads the
        /// local date back and fails when it differs. Written 2026-11-20 for ContentedLivestock (the date readout went back a day between scenes). COMPILED, NOT PLAYED.
        /// </summary>
        [Given(Prefix + "the date is set to day {int} of the year at hour {int}")]
        public void SetDate(PickleContext ctx, int day, int hour)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            ctx.Require(day >= 0 && day < 60, $"the day of the year runs from 0 to 59 (15 days a quadrum), not {day}");
            ctx.Require(hour >= 0 && hour < 24, $"the hour runs from 0 to 23, not {hour}");
            TickManager tm = Find.TickManager;
            float longitude = Find.WorldGrid.LongLatOf(map.Tile).x;
            long offset = GenDate.LocalTicksOffsetFromLongitude(longitude);
            long absNow = tm.TicksAbs;
            long localNow = absNow + offset;
            long yearBase = localNow / GenDate.TicksPerYear * GenDate.TicksPerYear;
            long localTarget = yearBase + (long)day * GenDate.TicksPerDay + (long)hour * GenDate.TicksPerHour;
            long gameTicks = localTarget - offset - tm.gameStartAbsTick;
            if (gameTicks < 0)
                gameTicks += GenDate.TicksPerYear;
            tm.DebugSetTicksGame((int)gameTicks);
            int readDay = GenLocalDate.DayOfYear(map);
            int readHour = GenLocalDate.HourInteger(map);
            Log.Message($"[date] asked day {day} hour {hour}; game ticks {gameTicks}; local date reads day {readDay} hour {readHour}");
            ctx.Assert(readDay == day && readHour == hour, $"the local date reads day {readDay} hour {readHour} after the step, not day {day} hour {hour}");
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
