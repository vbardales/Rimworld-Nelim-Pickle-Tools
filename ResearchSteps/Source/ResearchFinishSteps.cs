using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.Research
{
    /// <summary>
    /// Finishes research projects so that every building they unlock shows as available (the Architect tab, the catalogue photographs).
    /// Written 2026-10-25 for SanctuaryBacklot's Architect tab captures. NOT PLAYED when written: compiled against the reference assemblies only.
    /// The game's own <c>ResearchManager.FinishProject</c> runs, without the completion dialog and letter, so the unlock side effects happen
    /// (recipes, buildings, the "research finished" state). The companion step of ScreenshotStudio, "all research is reset", does the reverse.
    /// </summary>
    [PickleSteps]
    public class ResearchFinishSteps
    {
        /// <summary>Finishes every research project of the game, the ones of every loaded mod included.</summary>
        [Given("Nelim's Pickle Tools: all research is finished")]
        public void FinishAll(PickleContext ctx)
        {
            Finish(ctx, DefDatabase<ResearchProjectDef>.AllDefsListForReading, "all");
        }

        /// <summary>Finishes the projects named in a comma-separated list of <c>ResearchProjectDef</c> names (their prerequisites are not finished unless listed).</summary>
        [Given("Nelim's Pickle Tools: the research projects {string} are finished")]
        public void FinishList(PickleContext ctx, string defNames)
        {
            var projects = new List<ResearchProjectDef>();
            foreach (string name in defNames.Split(',').Select(n => n.Trim()).Where(n => n.Length > 0))
            {
                ResearchProjectDef def = DefDatabase<ResearchProjectDef>.GetNamedSilentFail(name);
                ctx.Require(def != null, "no research project '" + name + "'");
                projects.Add(def);
            }

            ctx.Require(projects.Count > 0, "the list of research projects is empty");
            Finish(ctx, projects, "listed");
        }

        /// <summary>Finishes every project defined by a mod, by its package id (case does not matter), e.g. <c>ludeon.rimworld.ideology</c>.</summary>
        [Given("Nelim's Pickle Tools: the research projects of the mod {string} are finished")]
        public void FinishMod(PickleContext ctx, string packageId)
        {
            List<ResearchProjectDef> projects = DefDatabase<ResearchProjectDef>.AllDefsListForReading
                .Where(d => d.modContentPack != null && string.Equals(d.modContentPack.PackageId, packageId, StringComparison.OrdinalIgnoreCase))
                .ToList();
            ctx.Require(projects.Count > 0, "no research project is defined by the mod '" + packageId + "' (loaded mods: "
                + string.Join(", ", DefDatabase<ResearchProjectDef>.AllDefsListForReading.Select(d => d.modContentPack?.PackageId).Where(p => p != null).Distinct()) + ")");
            Finish(ctx, projects, "of " + packageId);
        }

        private static void Finish(PickleContext ctx, IEnumerable<ResearchProjectDef> projects, string what)
        {
            ctx.Require(Find.ResearchManager != null, "no research manager: load a save first");
            List<ResearchProjectDef> list = projects.ToList();
            int done = 0;
            foreach (ResearchProjectDef project in list)
            {
                if (!project.IsFinished)
                {
                    Find.ResearchManager.FinishProject(project, false, null, false);
                    done++;
                }
            }

            ctx.Assert(list.All(p => p.IsFinished), "every " + what + " research project should be finished; still open: "
                + string.Join(", ", list.Where(p => !p.IsFinished).Select(p => p.defName)));
            Log.Message("[research] finished " + done + " of " + list.Count + " " + what + " projects");
        }
    }
}
