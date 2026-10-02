using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.IdeologySteps
{
    /// <summary>Finds a pawn by nickname and a def by name, and fails saying what exists.</summary>
    internal static class Lookups
    {
        /// <summary>Every pawn on a map of the running game, spawned, colonist or prisoner or neither.</summary>
        public static IEnumerable<Pawn> AllSpawnedPawns()
        {
            return Find.Maps.SelectMany(m => m.mapPawns.AllPawnsSpawned);
        }

        public static Pawn RequirePawn(PickleContext ctx, string nickname)
        {
            List<Pawn> all = AllSpawnedPawns().ToList();
            Pawn pawn = all.FirstOrDefault(p => string.Equals(p.Name?.ToStringShort, nickname, StringComparison.OrdinalIgnoreCase));
            ctx.Require(
                pawn != null,
                $"no pawn named '{nickname}' on any map; the named pawns are {string.Join(", ", all.Where(p => p.Name != null).Select(p => p.Name.ToStringShort))}");
            return pawn;
        }

        public static T RequireDef<T>(PickleContext ctx, string defName, string what) where T : Def
        {
            T def = DefDatabase<T>.GetNamedSilentFail(defName);
            ctx.Require(
                def != null,
                $"no {what} '{defName}' in this game; the {what}s are {string.Join(", ", DefDatabase<T>.AllDefsListForReading.Select(d => d.defName))}");
            return def;
        }

        /// <summary>A comma-separated list of def names, each one required to exist.</summary>
        public static List<T> RequireDefs<T>(PickleContext ctx, string csv, string what) where T : Def
        {
            var result = new List<T>();
            foreach (string name in csv.Split(',').Select(s => s.Trim()).Where(s => s.Length > 0))
            {
                T def = RequireDef<T>(ctx, name, what);
                if (!result.Contains(def))
                {
                    result.Add(def);
                }
            }

            return result;
        }
    }
}
