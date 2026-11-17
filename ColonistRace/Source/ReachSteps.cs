using System.Text;
using RimWorks.Pickle;
using RimWorld;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Reach probes, written 2026-11-17 for AnimaSong (colonists that never reach a ring of cells on the 1.7 lane): does a colonist reach a cell from where
    /// it stands, and what do the game's regions say about both cells (region id, region type, room, walkable, fogged). Tells a map that is cut in two from
    /// ticks that are too slow. Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class ReachSteps
    {
        private static string DescribeCell(Map map, IntVec3 cell)
        {
            var sb = new StringBuilder();
            sb.Append($"({cell.x}, {cell.z}) inBounds={cell.InBounds(map)}");
            if (!cell.InBounds(map)) return sb.ToString();
            sb.Append($" walkable={cell.Walkable(map)} standable={cell.Standable(map)} fogged={cell.Fogged(map)} roofed={cell.Roofed(map)}");
            Region region = cell.GetRegion(map, RegionType.Set_All);
            if (region == null) sb.Append(" region=none");
            else sb.Append($" region={region.id} type={region.type} cells={region.CellCount} room={(region.Room != null ? region.Room.ID.ToString() : "none")} passable={region.type.Passable()}");
            return sb.ToString();
        }

        /// <summary>
        /// Logs what a colonist can reach: <c>[reach] Name at (x, z) to (x, z): canReach=True|False (OnCell, Danger.Deadly)</c> and, for the two cells, the
        /// walkable, standable, fogged and roofed flags and the region id, type, size and room (<c>[reach-cell]</c>). Two cells in the same region id are always
        /// connected; two different region ids are not proof of a cut.
        /// </summary>
        [When("Nelim's Pickle Tools: the reach of {string} to \\({int}, {int}\\) is written to the log")]
        public void LogReach(PickleContext ctx, string nickname, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.Spawned, $"{nickname} is not spawned on a map");
            var target = new IntVec3(x, 0, z);
            bool can = pawn.Map.reachability.CanReach(pawn.Position, target, PathEndMode.OnCell, TraverseParms.For(pawn, Danger.Deadly));
            Log.Message($"[reach] {nickname} at ({pawn.Position.x}, {pawn.Position.z}) to ({x}, {z}): canReach={can} (OnCell, Danger.Deadly)");
            Log.Message($"[reach-cell] from {DescribeCell(pawn.Map, pawn.Position)}");
            Log.Message($"[reach-cell] to {DescribeCell(pawn.Map, target)}");
            // Evidence lanes keep messages.ndjson and the report but not always Player.log: a passing Assert keeps its text in the report, so the data survives there too (AniS, 2026-11-17).
            ctx.Assert(true, $"[reach] {nickname} at ({pawn.Position.x}, {pawn.Position.z}) to ({x}, {z}): canReach={can}; from {DescribeCell(pawn.Map, pawn.Position)}; to {DescribeCell(pawn.Map, target)}");
        }

        /// <summary>Asserts that a colonist can reach a cell from where it stands (the game's reachability, OnCell, danger Deadly). The failure gives both cells' region data.</summary>
        [Then("Nelim's Pickle Tools: {string} can reach \\({int}, {int}\\)")]
        public void CanReachCell(PickleContext ctx, string nickname, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.Spawned, $"{nickname} is not spawned on a map");
            var target = new IntVec3(x, 0, z);
            bool can = pawn.Map.reachability.CanReach(pawn.Position, target, PathEndMode.OnCell, TraverseParms.For(pawn, Danger.Deadly));
            ctx.Assert(can, $"{nickname} cannot reach ({x}, {z}); from {DescribeCell(pawn.Map, pawn.Position)}; to {DescribeCell(pawn.Map, target)}");
        }

        /// <summary>Asserts that a colonist cannot reach a cell (a probe of a cut). The failure says it can.</summary>
        [Then("Nelim's Pickle Tools: {string} cannot reach \\({int}, {int}\\)")]
        public void CannotReachCell(PickleContext ctx, string nickname, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.Spawned, $"{nickname} is not spawned on a map");
            var target = new IntVec3(x, 0, z);
            bool can = pawn.Map.reachability.CanReach(pawn.Position, target, PathEndMode.OnCell, TraverseParms.For(pawn, Danger.Deadly));
            ctx.Assert(!can, $"{nickname} can reach ({x}, {z}) from ({pawn.Position.x}, {pawn.Position.z})");
        }
    }
}
