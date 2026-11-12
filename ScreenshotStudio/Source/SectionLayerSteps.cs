using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using HarmonyLib;
using RimWorks.Pickle;
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
            foreach (Type t in classes)
            {
                Hidden.Add(t.Name);
                MethodInfo m = t.GetMethod("DrawLayer", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly);
                if (m != null && m.GetParameters().Length == 0 && m.ReturnType == typeof(void))
                {
                    harmony.Patch(m, prefix: new HarmonyMethod(typeof(SectionLayerSteps), nameof(PrefixDraw)));
                    patched++;
                }
            }
            // A layer that does not override DrawLayer is drawn by the base method: patch it once, the prefix tests the class.
            MethodInfo baseDraw = typeof(SectionLayer).GetMethod("DrawLayer", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly);
            if (baseDraw != null && baseDraw.GetParameters().Length == 0 && baseDraw.ReturnType == typeof(void))
            {
                try { harmony.Patch(baseDraw, prefix: new HarmonyMethod(typeof(SectionLayerSteps), nameof(PrefixDraw))); patched++; } catch (Exception) { }
            }
            Log.Message("[section-layers] hiding " + string.Join(", ", classes.Select(t => t.Name)) + " (" + patched + " DrawLayer method(s) patched)");
            ctx.Require(patched > 0, "no DrawLayer method could be patched: the game changed");
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
