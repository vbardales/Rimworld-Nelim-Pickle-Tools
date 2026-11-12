using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using HarmonyLib;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// The section layers of the map (terrain, pollution cloud, gas, shadows, fog...) as a list, and a way to not draw some. Written 2026-11-12 for ACBaGE (a brown-green veil on the
    /// whole frame that the sky overlay and the game condition steps did not remove; suspects SectionLayer_PollutionCloud and SectionLayer_Gas). COMPILED, NOT PLAYED. Needs Harmony.
    /// </summary>
    [PickleSteps]
    public class SectionLayerSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private static Harmony harmony;
        private static readonly HashSet<string> Hidden = new HashSet<string>(StringComparer.OrdinalIgnoreCase);

        private static IEnumerable<Section> SomeSections(Map map)
        {
            // One section of the cell the camera looks at, and the first section of the map: enough to read which layers exist and their state.
            var seen = new HashSet<Section>();
            foreach (IntVec3 c in new[] { Find.CameraDriver.MapPosition, new IntVec3(map.Size.x / 2, 0, map.Size.z / 2) })
                if (c.InBounds(map)) { Section s = map.mapDrawer.SectionAt(c); if (s != null && seen.Add(s)) yield return s; }
        }

        /// <summary>
        /// Logs ([section-layers]) every layer of the section under the camera: its class, whether it is visible (Visible) and its mesh vertex count when readable, plus the
        /// classes of the layers that are hidden by the step below. Reads only; never fails.
        /// </summary>
        [Given(Prefix + "the section layers of the map are logged")]
        public void LogLayers(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("[section-layers] hidden by step: " + (Hidden.Count == 0 ? "none" : string.Join(", ", Hidden)));
            foreach (Section s in SomeSections(map))
            {
                sb.AppendLine("section " + s.botLeft + ":");
                FieldInfo lf = typeof(Section).GetField("layers", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
                var layers = lf?.GetValue(s) as IEnumerable<SectionLayer>;
                if (layers == null) { sb.AppendLine("  layers: not readable"); continue; }
                foreach (SectionLayer l in layers)
                {
                    string visible = "?";
                    try { visible = l.Visible.ToString(); } catch { }
                    int verts = -1;
                    try
                    {
                        FieldInfo sm = typeof(SectionLayer).GetField("subMeshes", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
                        if (sm?.GetValue(l) is System.Collections.IEnumerable subs)
                            foreach (object o in subs)
                            {
                                var mesh = o.GetType().GetField("mesh", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)?.GetValue(o) as UnityEngine.Mesh;
                                if (mesh != null) verts += mesh.vertexCount + 1;
                            }
                    }
                    catch { }
                    sb.AppendLine("  " + l.GetType().Name + " visible=" + visible + " vertices=" + (verts < 0 ? "?" : verts.ToString()) + (Hidden.Contains(l.GetType().Name) ? " HIDDEN BY STEP" : string.Empty));
                }
            }
            Log.Message(sb.ToString());
            ctx.Attach("section-layers", sb.ToString());
        }

        /// <summary>
        /// Logs ([draw-over-map]) what can draw over the map at the camera: the sun glow, the weather and its overlay classes, the active conditions (map and world), the lights near the camera
        /// (glowers: def, position, radius, colour) and every Harmony patch on a draw, overlay or render method of the map, section, sky, weather, glow, fleck or camera classes (owner id, patch kind).
        /// A cloudy veil that no section layer owns is usually one of those. Reads only; never fails. Written 2026-11-12 for ACBaGE. NOT PLAYED.
        /// </summary>
        [Given(Prefix + "what draws over the map is logged")]
        public void LogDrawOverMap(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var sb = new System.Text.StringBuilder();
            sb.AppendLine("[draw-over-map] camera " + Find.CameraDriver.MapPosition + " root size " + Find.CameraDriver.RootSize.ToString("0.0") + ", sun glow " + GenCelestial.CurCelestialSunGlow(map).ToString("0.00") + ", weather " + map.weatherManager.curWeather.defName
                + ", overlays " + string.Join(", ", (map.weatherManager.curWeather.overlayClasses ?? new List<Type>()).Select(t => t.Name))
                + ", conditions " + string.Join(", ", map.gameConditionManager.ActiveConditions.Select(c => c.def.defName)) + ", world conditions " + string.Join(", ", Find.World.gameConditionManager.ActiveConditions.Select(c => c.def.defName)));
            try
            {
                var lights = map.listerThings.AllThings.Select(t => t.TryGetComp<CompGlower>()).Where(g => g != null && g.Glows && g.parent.Position.InHorDistOf(Find.CameraDriver.MapPosition, 40f)).Take(20)
                    .Select(g => g.parent.def.defName + "@" + g.parent.Position + " r" + g.Props.glowRadius + " " + g.GlowColor);
                sb.AppendLine("glowers within 40 cells: " + string.Join("; ", lights));
            }
            catch (Exception e) { sb.AppendLine("glower read error: " + e.Message); }
            try
            {
                string[] names = { "Map", "Section", "Sky", "Weather", "Overlay", "Glow", "Fleck", "GenDraw", "Camera", "PawnRender" };
                foreach (MethodBase m in Harmony.GetAllPatchedMethods().Where(m => m.DeclaringType != null && (m.DeclaringType.Namespace == "Verse" || m.DeclaringType.Namespace == "RimWorld")
                    && (m.Name.IndexOf("Draw", StringComparison.OrdinalIgnoreCase) >= 0 || m.Name.IndexOf("Overlay", StringComparison.OrdinalIgnoreCase) >= 0 || m.Name.IndexOf("Render", StringComparison.OrdinalIgnoreCase) >= 0)
                    && names.Any(n => m.DeclaringType.Name.IndexOf(n, StringComparison.Ordinal) >= 0)))
                {
                    Patches pi = Harmony.GetPatchInfo(m);
                    var owners = new List<string>();
                    foreach (var p in pi.Prefixes) owners.Add("prefix:" + p.owner);
                    foreach (var p in pi.Postfixes) owners.Add("postfix:" + p.owner);
                    foreach (var p in pi.Transpilers) owners.Add("transpiler:" + p.owner);
                    foreach (var p in pi.Finalizers) owners.Add("finalizer:" + p.owner);
                    sb.AppendLine("patched " + m.DeclaringType.Name + "." + m.Name + " by " + string.Join(", ", owners));
                }
            }
            catch (Exception e) { sb.AppendLine("patch read error: " + e.Message); }
            Log.Message(sb.ToString());
            ctx.Attach("draw-over-map", sb.ToString());
        }

        /// <summary>
        /// Logs ([altitudes]) the draw altitude (y) of every AltitudeLayer of the game, then every thing within 20 cells of the camera (pawns, items, buildings, plants, motes, filth, gas)
        /// whose draw altitude lies between the two bounds: def, class, mod package id, cell, altitude layer. For a veil that covers a pawn: what is drawn just above the pawn layer.
        /// The fleck systems have no list to read. Reads only; never fails. Written 2026-11-12 for ACBaGE (body hidden under something at y 8.42 to 8.43). NOT PLAYED.
        /// </summary>
        [Given(Prefix + "the things drawn at an altitude from {float} to {float} are logged")]
        public void LogAltitudeBand(PickleContext ctx, float from, float to)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var sb = new System.Text.StringBuilder();
            var table = new List<string>();
            foreach (AltitudeLayer l in Enum.GetValues(typeof(AltitudeLayer)))
            {
                try { table.Add(l + "=" + l.AltitudeFor().ToString("0.000")); }
                catch (Exception e) { table.Add(l + "=(" + e.GetType().Name + ")"); }
            }
            table.Sort(StringComparer.Ordinal);
            sb.AppendLine("[altitudes] layers: " + string.Join("; ", table));
            IntVec3 cam = Find.CameraDriver.MapPosition;
            int found = 0;
            try
            {
            foreach (Thing t in map.listerThings.AllThings.ToList().Where(t => t.Spawned && t.Position.InHorDistOf(cam, 20f)))
            {
                float y;
                try { y = t.def.Altitude; } catch (Exception) { continue; }
                if (y < from || y > to) continue;
                found++;
                if (found <= 80) sb.AppendLine("  " + t.def.defName + " (" + t.GetType().Name + ", " + (t.def.modContentPack?.PackageId ?? "?") + ") at " + t.Position + " layer " + t.def.altitudeLayer + " y " + y.ToString("0.000"));
            }
            }
            catch (Exception e) { sb.AppendLine("read error: " + e); }
            sb.AppendLine(found + " thing(s) with y between " + from + " and " + to + " within 20 cells of " + cam);
            Log.Message(sb.ToString());
            ctx.Attach("altitudes", sb.ToString());
        }

        private static bool SkipLayer(SectionLayer __instance) => !Hidden.Contains(__instance.GetType().Name);

        /// <summary>
        /// The section layers whose class name contains the text (<c>PollutionCloud</c>, <c>Gas</c>) are not drawn until the scenario ends: DrawLayer is skipped, the map data is not touched.
        /// Fails when no layer class matches the text. Call "the section layers of the map are logged" to read the names.
        /// </summary>
        [Given(Prefix + "the section layers named {string} are hidden")]
        public void HideLayers(PickleContext ctx, string text)
        {
            ctx.Require(Find.CurrentMap != null, "No loaded map");
            var classes = GenTypes.AllSubclasses(typeof(SectionLayer)).Where(t => t.Name.IndexOf(text, StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            ctx.Require(classes.Count > 0, "no SectionLayer class has a name containing '" + text + "'");
            harmony = harmony ?? new Harmony("nelim.pickletools.sectionlayers");
            int patched = 0;
            var problems = new List<string>();
            var targets = new List<MethodInfo>();
            const BindingFlags decl = BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly;
            // The layer classes themselves, then the base class: a layer that does not override a method is drawn by the base one, and the prefix tests the class.
            foreach (Type t in classes.Concat(new[] { typeof(SectionLayer) }))
                foreach (MethodInfo m in t.GetMethods(decl))
                    if (m.ReturnType == typeof(void) && m.GetParameters().Length == 0 && (m.Name == "DrawLayer" || m.Name == "DrawLayer_Internal")) targets.Add(m);
            foreach (MethodInfo m in targets)
            {
                try { harmony.Patch(m, prefix: new HarmonyMethod(typeof(SectionLayerSteps), nameof(PrefixDraw))); patched++; }
                catch (Exception e) { problems.Add(m.DeclaringType.Name + "." + m.Name + ": " + e.Message); }
            }
            // Also the visibility test: Section.DrawSection asks it before drawing a layer.
            foreach (Type t in classes.Concat(new[] { typeof(SectionLayer) }))
            {
                MethodInfo g = t.GetProperty("Visible", decl)?.GetGetMethod(true);
                if (g == null || g.ReturnType != typeof(bool)) continue;
                try { harmony.Patch(g, prefix: new HarmonyMethod(typeof(SectionLayerSteps), nameof(PrefixVisible))); patched++; }
                catch (Exception e) { problems.Add(t.Name + ".Visible: " + e.Message); }
            }
            Log.Message("[section-layers] hiding " + string.Join(", ", classes.Select(t => t.Name)) + " (" + patched + " method(s) patched)");
            if (patched == 0)
            {
                string methods = string.Join("; ", typeof(SectionLayer).GetMethods(decl).Select(m => m.ReturnType.Name + " " + m.Name + "(" + m.GetParameters().Length + ")"));
                ctx.Require(false, "no DrawLayer or Visible could be patched; SectionLayer declares: " + methods + (problems.Count > 0 ? "; errors: " + string.Join(" | ", problems) : string.Empty));
            }
        }

        private static bool PrefixVisible(SectionLayer __instance, ref bool __result)
        {
            if (Hidden.Contains(__instance.GetType().Name)) { __result = false; return false; }
            return true;
        }

        private static bool PrefixDraw(SectionLayer __instance) => SkipLayer(__instance);

        [AfterScenario]
        public void ReleaseLayers()
        {
            if (harmony == null) return;
            try { harmony.UnpatchAll(harmony.Id); } catch { }
            harmony = null;
            Hidden.Clear();
        }
    }
}
