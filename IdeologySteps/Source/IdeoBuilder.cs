using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.IdeologySteps
{
    /// <summary>
    /// Builds an Ideo from named memes and precepts, going through the game's own generator and its own acceptance
    /// test for a precept (IdeoFoundation.CanAdd), so that what this builds is what the ideoligion editor would allow.
    /// </summary>
    internal static class IdeoBuilder
    {
        public static Ideo Build(PickleContext ctx, List<MemeDef> memes, List<PreceptDef> precepts)
        {
            ctx.Require(ModsConfig.IdeologyActive, "ideoligions need the Ideology DLC, and it is not active in this run");
            ctx.Require(memes.Count > 0, "an ideoligion needs at least one meme");
            ctx.Require(Faction.OfPlayer != null, "no player faction: load a save first with 'the save ... is loaded'");

            RequireCompatibleMemes(ctx, memes);

            FactionDef factionDef = Faction.OfPlayer.def;
            var parms = new IdeoGenerationParms
            {
                forFaction = factionDef,
                forcedMemes = memes.ToList(),
                requiredPreceptsOnly = true,
            };
            Ideo ideo = IdeoGenerator.GenerateIdeo(parms);

            // The generator completes the forced memes with random ones. Keep only the memes asked for, and let the game
            // drop the precepts that no longer fit and add the ones the memes require, as the editor does on a meme change.
            List<MemeDef> generated = ideo.memes.ToList();
            ideo.memes.Clear();
            ideo.memes.AddRange(memes);
            ideo.SortMemesInDisplayOrder();
            ideo.foundation.EnsurePreceptsCompatibleWithMemes(generated, ideo.memes, parms);

            foreach (PreceptDef def in precepts)
            {
                AddPrecept(ctx, ideo, def, factionDef);
            }

            Pair<Precept, Precept> clash = ideo.FirstIncompatiblePreceptPair();
            ctx.Require(
                clash.First == null,
                clash.First == null
                    ? string.Empty
                    : $"the precepts '{clash.First.def.defName}' and '{clash.Second?.def.defName}' cannot be in the same ideoligion");

            return ideo;
        }

        private static void RequireCompatibleMemes(PickleContext ctx, List<MemeDef> memes)
        {
            for (int i = 0; i < memes.Count; i++)
            {
                for (int j = i + 1; j < memes.Count; j++)
                {
                    string tag = memes[i].exclusionTags?.FirstOrDefault(t => memes[j].exclusionTags != null && memes[j].exclusionTags.Contains(t));
                    ctx.Require(
                        tag == null,
                        $"the memes '{memes[i].defName}' and '{memes[j].defName}' exclude each other (exclusion tag '{tag}')");
                }
            }
        }

        private static void AddPrecept(PickleContext ctx, Ideo ideo, PreceptDef def, FactionDef factionDef)
        {
            AcceptanceReport report = ideo.foundation.CanAdd(def, false);
            ctx.Require(
                report.Accepted,
                $"the game refuses the precept '{def.defName}' for an ideoligion with the memes {string.Join(", ", ideo.memes.Select(m => m.defName))}: {report.Reason}");

            // An issue holds one precept, except the kinds that come in numbers (rituals, roles, buildings).
            if (!IsMultiple(def))
            {
                foreach (Precept old in ideo.PreceptsListForReading.Where(p => p.def.issue == def.issue).ToList())
                {
                    ideo.RemovePrecept(old, true);
                }
            }

            ideo.AddPrecept(PreceptMaker.MakePrecept(def), true, factionDef, null);
        }

        private static bool IsMultiple(PreceptDef def)
        {
            Type type = def.preceptClass;
            return type != null
                && (typeof(Precept_Ritual).IsAssignableFrom(type) || typeof(Precept_Role).IsAssignableFrom(type) || typeof(Precept_Building).IsAssignableFrom(type));
        }


        public static string Describe(Ideo ideo)
        {
            return ideo == null
                ? "(none)"
                : $"'{ideo.name}' with the memes {string.Join(", ", ideo.memes.Select(m => m.defName))} and the precepts {string.Join(", ", ideo.PreceptsListForReading.Select(p => p.def.defName))}";
        }
    }
}
