using System.Collections.Generic;
using System.Reflection;
using RimWorks.Pickle;
using RimWorld;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Makes the picture of a thing def bigger for a capture (a 64 px item such as Dust is unreadable at 268 px). Written 2026-11-09 for
    /// DustBunniesRenew. The step multiplies <c>graphicData.drawSize</c> of the def, drops the cached graphic of the def and of every spawned thing
    /// of that def, and marks their cells dirty so the map redraws them. The original size is put back, and the caches dropped again, after the
    /// scenario. Compiled, not played.
    /// </summary>
    [PickleSteps]
    public class DrawSizeSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private static readonly Dictionary<ThingDef, Vector2> Original = new Dictionary<ThingDef, Vector2>();
        private static readonly FieldInfo CachedGraphic = typeof(GraphicData).GetField("cachedGraphic", BindingFlags.Instance | BindingFlags.NonPublic);
        private static readonly FieldInfo ThingGraphic = typeof(Thing).GetField("graphicInt", BindingFlags.Instance | BindingFlags.NonPublic);

        /// <summary>
        /// Draws every thing of the def <paramref name="defName"/> at <paramref name="factor"/> times the size its graphic has, until the scenario
        /// ends. Fails when the def is unknown, has no graphic data, or the factor is not between 0.1 and 20. A second call on the same def
        /// multiplies the original size again, it does not stack on the first.
        /// </summary>
        [Given(Prefix + "the graphic of the def {string} is drawn at {float} times its size")]
        public void ScaleGraphic(PickleContext ctx, string defName, float factor)
        {
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, "no ThingDef named '" + defName + "' is loaded");
            ctx.Require(def.graphicData != null, "the def '" + defName + "' has no graphicData");
            ctx.Require(factor >= 0.1f && factor <= 20f, "the factor " + factor + " is outside 0.1 to 20");
            ctx.Require(CachedGraphic != null && ThingGraphic != null, "the cached graphic fields were not found (game version changed)");
            if (!Original.ContainsKey(def)) Original[def] = def.graphicData.drawSize;
            def.graphicData.drawSize = Original[def] * factor;
            int things = Refresh(def);
            Vector2 now = def.graphicData.drawSize;
            ctx.Require(Mathf.Abs(now.x - Original[def].x * factor) < 0.0001f, "the draw size did not stick");
            Log.Message("[draw-size] " + defName + " drawSize " + Original[def] + " -> " + now + ", " + things + " spawned thing(s) redrawn");
        }

        private static int Refresh(ThingDef def)
        {
            CachedGraphic.SetValue(def.graphicData, null);
            int n = 0;
            foreach (Map map in Find.Maps)
            {
                foreach (Thing t in map.listerThings.ThingsOfDef(def))
                {
                    ThingGraphic.SetValue(t, null);
                    if (t.Spawned) map.mapDrawer.MapMeshDirty(t.Position, MapMeshFlagDefOf.Things);
                    n++;
                }
            }
            return n;
        }

        [AfterScenario]
        public void RestoreSizes()
        {
            foreach (KeyValuePair<ThingDef, Vector2> pair in Original)
            {
                pair.Key.graphicData.drawSize = pair.Value;
                Refresh(pair.Key);
            }
            Original.Clear();
        }
    }
}
