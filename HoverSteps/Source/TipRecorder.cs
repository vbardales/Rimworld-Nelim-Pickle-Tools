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
    /// Makes every tooltip region a tag. Pickle records a tag for a button label and nothing else, so a
    /// checkbox, a slider or a label with a tooltip has no name a scenario can hover. The game calls
    /// TooltipHandler.TipRegion for every such region on every repaint, hovered or not, and only decides
    /// inside it whether the pointer is over the rect: a prefix on it sees them all, and hands each one to
    /// Pickle tag store as "tip:" plus its text, where the ordinary Hover finds it.
    /// </summary>
    internal static class TipRecorder
    {
        private const string HarmonyId = "nelim.pickletools.hoversteps";
        private const string TagPrefix = "tip:";

        private static bool patched;
        private static MethodInfo record;
        private static Func<IEnumerable<string>> knownTags;

        internal static string Prefix { get { return TagPrefix; } }

        internal static void Ensure(PickleContext ctx)
        {
            if (patched) return;
            var storeType = typeof(PickleContext).Assembly.GetType("RimWorks.Pickle.Input.TagStore");
            ctx.Require(storeType != null, "Pickle has no RimWorks.Pickle.Input.TagStore in this build: the tag store moved, this tool has to follow");
            record = storeType.GetMethod("Record", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic,
                null, new[] { typeof(string), typeof(Rect) }, null);
            ctx.Require(record != null, "TagStore.Record(string, Rect) is not there in this Pickle build");
            var known = storeType.GetProperty("KnownTags", BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
            ctx.Require(known != null, "TagStore.KnownTags is not there in this Pickle build");
            knownTags = () => ((IEnumerable<string>)known.GetValue(null, null)).ToList();

            var target = AccessTools.Method(typeof(TooltipHandler), "TipRegion", new[] { typeof(Rect), typeof(TipSignal) });
            ctx.Require(target != null, "TooltipHandler.TipRegion(Rect, TipSignal) is not there in this game build");
            new Harmony(HarmonyId).Patch(target,
                prefix: new HarmonyMethod(typeof(TipRecorder), nameof(BeforeTipRegion)));
            patched = true;
        }

        internal static IList<string> Tags()
        {
            return knownTags == null ? new List<string>() : knownTags().Where(t => t.StartsWith(TagPrefix, StringComparison.Ordinal)).ToList();
        }

        private static void BeforeTipRegion(Rect rect, TipSignal tip)
        {
            if (record == null) return;
            // The game calls a tip's text getter only for the region the pointer is over; this prefix calls it for every region on every repaint.
            // A getter that reads what is under the pointer can throw for a region that is not hovered, and an exception here would spoil the
            // game's own drawing of that window: skip such a region, it just has no tag.
            string text;
            try
            {
                text = tip.textGetter != null ? tip.textGetter() : tip.text;
            }
            catch (Exception)
            {
                return;
            }

            if (string.IsNullOrEmpty(text)) return;
            record.Invoke(null, new object[] { TagPrefix + text, rect });
        }
    }
}
