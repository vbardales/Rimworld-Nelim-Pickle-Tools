using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Takes filth (dirt, blood, ash, vomit...) off the map, so a mod that reacts to the filth around a colonist (a scent mod that keeps one scent per pawn) is tested without
    /// the map's own dirt. The texts differ from ScreenshotStudio's <c>all filth is cleaned</c> on purpose: that tool is a companion, and two steps with one text are Ambiguous when both are staged.
    /// Written 2026-11-12 for RimScentExtendedImprovedExpansion (Larson held 4 DirtScent from map dirt). Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class FilthSteps
    {
        /// <summary>Destroys every piece of filth on the current map. Pawns, items and buildings stay. Fails when some filth is left.</summary>
        [Given("Nelim's Pickle Tools: the filth of the whole map is removed")]
        public void RemoveAllFilth(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "Load a map first");
            int count = DestroyFilth(map, null, 0);
            Log.Message($"[filth-removed] {count} piece(s) of filth removed from the whole map");
            ctx.Assert(!map.listerThings.AllThings.OfType<Filth>().Any(), "some filth is still on the map");
        }

        /// <summary>Destroys the filth on every cell within this many cells (a circle) of a colonist's cell. Logs the count. Fails when some is left in range or the colonist is not on a map.</summary>
        [Given("Nelim's Pickle Tools: the filth within {int} cells of the colonist {string} is removed")]
        public void RemoveFilthAroundColonist(PickleContext ctx, int radius, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.Spawned, $"the colonist {nickname} is not on a map");
            RemoveAround(ctx, pawn.Map, pawn.Position, radius);
        }

        /// <summary>Destroys the filth on every cell within this many cells (a circle) of a cell of the current map. Logs the count. Fails when some is left in range or the cell is off the map.</summary>
        [Given("Nelim's Pickle Tools: the filth within {int} cells of \\({int}, {int}\\) is removed")]
        public void RemoveFilthAroundCell(PickleContext ctx, int radius, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "Load a map first");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map, which is {map.Size.x} by {map.Size.z}");
            RemoveAround(ctx, map, cell, radius);
        }

        private static void RemoveAround(PickleContext ctx, Map map, IntVec3 center, int radius)
        {
            ctx.Require(radius >= 0 && radius <= 200, "the radius must be from 0 to 200 cells");
            int count = DestroyFilth(map, center, radius);
            Log.Message($"[filth-removed] {count} piece(s) of filth removed within {radius} cells of ({center.x}, {center.z})");
            bool left = GenRadial.RadialCellsAround(center, radius, true).Where(c => c.InBounds(map)).Any(c => c.GetThingList(map).OfType<Filth>().Any());
            ctx.Assert(!left, $"some filth is still within {radius} cells of ({center.x}, {center.z})");
        }

        private static int DestroyFilth(Map map, IntVec3? center, int radius)
        {
            var filth = center == null
                ? map.listerThings.AllThings.OfType<Filth>().ToList()
                : GenRadial.RadialCellsAround(center.Value, radius, true).Where(c => c.InBounds(map)).SelectMany(c => c.GetThingList(map).OfType<Filth>()).ToList();
            foreach (Filth f in filth)
            {
                if (!f.Destroyed)
                {
                    f.Destroy();
                }
            }

            return filth.Count;
        }
    }
}
