using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using HarmonyLib;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.HoverSteps
{
    /// <summary>
    /// Makes every gizmo button a tag. The Architect's designator buttons (and the gizmos of a selected thing) are not drawn with the widgets Pickle records, and the tooltip of a gizmo
    /// is registered only while the pointer is over it, so the tooltip recorder never sees it: ArchitectStudio (run 46d3, 2026-11-15) found no tag for the button of a custom group.
    /// A postfix on <c>Command.GizmoOnGUI</c> and <c>Designator.GizmoOnGUI</c> hands each drawn gizmo (its label and the rectangle it was drawn at) to Pickle's tag store as
    /// "gizmo:" plus its label, where the ordinary Hover finds it. Written 2026-11-15. NOT PLAYED when written.
    /// </summary>
    internal static class GizmoRecorder
    {
        private const string HarmonyId = "nelim.pickletools.hoversteps.gizmos";
        private const string TagPrefix = "gizmo:";

        private static readonly HashSet<string> seen = new HashSet<string>();
        private static int seenFrame = -1;
        private static bool patched;
        private static MethodInfo record;
        private static Func<IEnumerable<string>> knownTags;

        internal static string Prefix { get { return TagPrefix; } }

        internal static void Ensure(PickleContext ctx)
        {
            if (patched) return;
            var storeType = typeof(PickleContext).Assembly.GetType("RimWorks.Pickle.Input.TagStore");
            ctx.Require(storeType != null, "Pickle has no RimWorks.Pickle.Input.TagStore in this build: the tag store moved, this tool has to follow");
            record = storeType.GetMethod("Record", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic, null, new[] { typeof(string), typeof(Rect) }, null);
            ctx.Require(record != null, "TagStore.Record(string, Rect) is not there in this Pickle build");
            var known = storeType.GetProperty("KnownTags", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
            ctx.Require(known != null, "TagStore.KnownTags is not there in this Pickle build");
            knownTags = () => ((IEnumerable<string>)known.GetValue(null, null)).ToList();

            var harmony = new Harmony(HarmonyId);
            int count = 0;
            foreach (Type type in new[] { typeof(Command), typeof(Designator) })
            {
                MethodInfo target = AccessTools.DeclaredMethod(type, "GizmoOnGUI", new[] { typeof(Vector2), typeof(float), typeof(GizmoRenderParms) });
                if (target == null) continue;
                harmony.Patch(target, postfix: new HarmonyMethod(typeof(GizmoRecorder), nameof(AfterGizmo)));
                count++;
            }

            ctx.Require(count > 0, "Command.GizmoOnGUI(Vector2, float, GizmoRenderParms) is not there in this game build: the gizmo drawing changed, this step has to follow");
            patched = true;
        }

        internal static IList<string> Tags()
        {
            return knownTags == null ? new List<string>() : knownTags().Where(t => t.StartsWith(TagPrefix, StringComparison.Ordinal)).ToList();
        }

        private static void AfterGizmo(Gizmo __instance, Vector2 topLeft, float maxWidth)
        {
            if (record == null) return;
            try
            {
                // the store records on Repaint only; the dedupe below must not see the Layout pass first
                if (Event.current == null || Event.current.type != EventType.Repaint) return;
                string label = (__instance as Command)?.LabelCap;
                if (string.IsNullOrEmpty(label)) return;
                var rect = new Rect(topLeft.x, topLeft.y, __instance.GetWidth(maxWidth), 75f);
                // Designator.GizmoOnGUI calls Command.GizmoOnGUI, and both are patched: the same gizmo at the same rect arrives twice per draw, and Pickle's tag store calls that
                // "ambiguous" (ArS run 1a65: the tag was listed yet "not found"). Record one entry per label and rectangle each frame.
                if (Time.frameCount != seenFrame) { seen.Clear(); seenFrame = Time.frameCount; }
                if (!seen.Add(label + "@" + rect)) return;
                record.Invoke(null, new object[] { TagPrefix + label, rect });
            }
            catch (Exception)
            {
                // a gizmo whose label or width cannot be read just has no tag
            }
        }
    }
}
