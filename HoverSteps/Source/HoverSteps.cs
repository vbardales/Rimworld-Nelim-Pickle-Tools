using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.HoverSteps
{
    /// <summary>
    /// Puts the pointer over a tooltip region and waits for the game to draw the tooltip, so that a
    /// scenario can look at it (a screenshot after the step) or assert it. The region is named by the text
    /// of its tooltip: literally, by the translation key it comes from, or by a part of it.
    ///
    /// The step texts start with "Nelim's Pickle Tools:". Pickle loads the steps of every installed suite
    /// into one namespace, and a repeated text is an "Ambiguous step" that fails healthy scenarios.
    /// </summary>
    [PickleSteps]
    public class HoverSteps
    {
        private const float DrawTimeoutSeconds = 4f;

        [BeforeScenario]
        public void RecordTooltipRegions(PickleContext ctx)
        {
            TipRecorder.Ensure(ctx);
        }

        private static string Keyed(PickleContext ctx, string key)
        {
            ctx.Require(key.CanTranslate(),
                "no translation is loaded for \"" + key + "\", so no tooltip text can be built from it. "
                + "active language: " + (LanguageDatabase.activeLanguage != null ? LanguageDatabase.activeLanguage.FriendlyNameEnglish : "(none)"));
            return key.Translate().Resolve();
        }

        private static string Containing(PickleContext ctx, string part)
        {
            var found = TipRecorder.Tags().Select(t => t.Substring(TipRecorder.Prefix.Length))
                .Where(t => t.Contains(part)).Distinct().ToList();
            ctx.Require(found.Count == 1,
                found.Count == 0
                    ? "no tooltip region on screen contains \"" + part + "\"; regions drawn this frame: " + Listing()
                    : "more than one tooltip region contains \"" + part + "\": " + string.Join(" | ", found.Select(Short).ToArray()));
            return found[0];
        }

        private static string Listing()
        {
            var all = TipRecorder.Tags().Select(t => Short(t.Substring(TipRecorder.Prefix.Length))).ToList();
            return all.Count == 0 ? "none" : string.Join(" | ", all.ToArray());
        }

        private static string Short(string text)
        {
            var flat = text.Replace("\n", " ");
            return flat.Length <= 60 ? flat : flat.Substring(0, 60) + "...";
        }

        private static bool IsDrawn(string text)
        {
            foreach (var tip in TooltipHandler.activeTips.Values)
            {
                var own = tip.signal.textGetter != null ? tip.signal.textGetter() : tip.signal.text;
                if (own == text && Time.realtimeSinceStartup > tip.firstTriggerTime + tip.signal.delay) return true;
            }
            return false;
        }

        private static async Task Hover(PickleContext ctx, string text)
        {
            await ctx.Hover(TipRecorder.Prefix + text);
            await ctx.AssertEventually(() => IsDrawn(text),
                () => "the pointer is over the region, but the tooltip \"" + Short(text) + "\" was not drawn within "
                    + DrawTimeoutSeconds + " seconds", DrawTimeoutSeconds);
        }

        [When("Nelim's Pickle Tools: I hover over the tooltip keyed {string}", TimeoutSeconds = 12f)]
        public async Task HoverKeyed(PickleContext ctx, string key) { await Hover(ctx, Keyed(ctx, key)); }

        [When("Nelim's Pickle Tools: I hover over the tooltip reading {string}", TimeoutSeconds = 12f)]
        public async Task HoverReading(PickleContext ctx, string text) { await Hover(ctx, text); }

        [When("Nelim's Pickle Tools: I hover over the tooltip containing {string}", TimeoutSeconds = 12f)]
        public async Task HoverContaining(PickleContext ctx, string part) { await Hover(ctx, Containing(ctx, part)); }

        /// <summary>
        /// Puts the pointer over a gizmo button (an Architect designator or group button, the gizmo of a selected thing) found by its label (ignoring case; an exact label wins, otherwise a part of a label) and waits for a
        /// tooltip to be drawn, so a capture shows it. The gizmos are recorded while they are drawn: open the Architect tab first (<c>I open the architect tab ...</c>) and let a few frames
        /// pass. Fails with the labels drawn when none or several match. Written 2026-11-15 for ArchitectStudio (the tooltip of a custom group button). NOT PLAYED when written.
        /// </summary>
        [When("Nelim's Pickle Tools: I hover over the gizmo labelled {string}", TimeoutSeconds = 20f)]
        public async Task HoverGizmo(PickleContext ctx, string part)
        {
            GizmoRecorder.Ensure(ctx);
            await ctx.WaitFrames(30);
            var labels = GizmoRecorder.Tags().Select(t => t.Substring(GizmoRecorder.Prefix.Length)).Distinct().ToList();
            var hit = labels.Where(l => l.Equals(part, System.StringComparison.OrdinalIgnoreCase)).ToList();
            if (hit.Count == 0) hit = labels.Where(l => l.IndexOf(part, System.StringComparison.OrdinalIgnoreCase) >= 0).ToList();
            ctx.Require(hit.Count == 1,
                hit.Count == 0
                    ? "no gizmo is drawn whose label contains \"" + part + "\"; gizmos drawn: " + (labels.Count == 0 ? "none (open the Architect tab or select a thing first)" : string.Join(" | ", labels.ToArray()))
                    : "more than one gizmo label contains \"" + part + "\": " + string.Join(" | ", hit.ToArray()));
            await ctx.Hover(GizmoRecorder.Prefix + hit[0]);
            await ctx.AssertEventually(() => TooltipHandler.activeTips.Values.Any(tip => Time.realtimeSinceStartup > tip.firstTriggerTime + tip.signal.delay),
                () => "the pointer is over the gizmo \"" + hit[0] + "\", but no tooltip was drawn within " + DrawTimeoutSeconds + " seconds", DrawTimeoutSeconds);
        }

        [Then("Nelim's Pickle Tools: the tooltip keyed {string} is drawn")]
        public void DrawnKeyed(PickleContext ctx, string key)
        {
            var text = Keyed(ctx, key);
            ctx.Assert(IsDrawn(text), "the tooltip \"" + Short(text) + "\" is not drawn");
        }

        [Then("Nelim's Pickle Tools: the tooltip containing {string} is drawn")]
        public void DrawnContaining(PickleContext ctx, string part)
        {
            var drawn = TooltipHandler.activeTips.Values.Any(tip =>
            {
                var own = tip.signal.textGetter != null ? tip.signal.textGetter() : tip.signal.text;
                return own != null && own.Contains(part) && Time.realtimeSinceStartup > tip.firstTriggerTime + tip.signal.delay;
            });
            ctx.Assert(drawn, "no drawn tooltip contains \"" + part + "\"");
        }

        [Then("Nelim's Pickle Tools: no tooltip is drawn")]
        public void NoneDrawn(PickleContext ctx)
        {
            var count = TooltipHandler.activeTips.Values.Count(tip => Time.realtimeSinceStartup > tip.firstTriggerTime + tip.signal.delay);
            ctx.Assert(count == 0, count + " tooltip(s) are drawn");
        }
    }
}
