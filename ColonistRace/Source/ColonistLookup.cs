using System;
using System.Linq;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>Finds a player colonist by nickname, the way Pickle's own steps do.</summary>
    internal static class ColonistLookup
    {
        public static Pawn Find(string nickname)
        {
            return PawnsFinder.AllMaps_FreeColonists.FirstOrDefault(
                p => string.Equals(p.Name?.ToStringShort, nickname, StringComparison.OrdinalIgnoreCase));
        }

        public static Pawn Require(string nickname)
        {
            Pawn pawn = Find(nickname);
            if (pawn != null)
            {
                return pawn;
            }

            string known = string.Join(", ", PawnsFinder.AllMaps_FreeColonists.Select(p => p.Name?.ToStringShort ?? "(none)"));
            throw new InvalidOperationException($"no colonist named '{nickname}'; the colonists are {known}");
        }
    }
}
