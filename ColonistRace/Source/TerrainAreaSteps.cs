using System.Linq;
using System.Text;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Reads the terrain of a rectangle of the map, one line per cell, to decide where a building can stand (a bridge deck, a ford, water). Written 2026-11-18
    /// for the railings of the Sanctuary bridge (CaT, SaB). Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class TerrainAreaSteps
    {
        /// <summary>
        /// Logs ([terrain-area], and the attachment <c>terrain-area</c>) for every cell of the rectangle: the terrain def, the terrain under it (a bridge deck lies on water),
        /// whether the terrain is water, and the affordances it gives (Light, Medium, Heavy). Cells are written row by row from the highest z down.
        /// </summary>
        [Given("Nelim's Pickle Tools: the terrain of the area from \\({int}, {int}\\) to \\({int}, {int}\\) is logged")]
        public void LogArea(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            Run(ctx, x1, z1, x2, z2, null);
        }

        /// <summary>
        /// The same, and for every cell the answer of the game's own placement rule for the building def (<c>GenConstruct.CanPlaceBlueprintAt</c>, facing north):
        /// <c>place=OK</c> or <c>place=refused: reason</c>. The same rule decides "I place the decor ... exactly at".
        /// </summary>
        [Given("Nelim's Pickle Tools: the terrain of the area from \\({int}, {int}\\) to \\({int}, {int}\\) is logged with the placement of {string}")]
        public void LogAreaWithPlacement(PickleContext ctx, int x1, int z1, int x2, int z2, string defName)
        {
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, "no ThingDef '" + defName + "' in the loaded game");
            Run(ctx, x1, z1, x2, z2, def);
        }

        private static void Run(PickleContext ctx, int x1, int z1, int x2, int z2, ThingDef def)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            int xa = System.Math.Min(x1, x2), xb = System.Math.Max(x1, x2), za = System.Math.Min(z1, z2), zb = System.Math.Max(z1, z2);
            var sb = new StringBuilder();
            for (int z = zb; z >= za; z--)
                for (int x = xa; x <= xb; x++)
                {
                    var c = new IntVec3(x, 0, z);
                    if (!c.InBounds(map)) { sb.AppendLine($"[terrain-area] ({x}, {z}) outside the map"); continue; }
                    TerrainDef t = map.terrainGrid.TerrainAt(c);
                    TerrainDef under = map.terrainGrid.UnderTerrainAt(c);
                    string aff = string.Join("+", new[] { TerrainAffordanceDefOf.Light, TerrainAffordanceDefOf.Medium, TerrainAffordanceDefOf.Heavy }
                        .Where(a => a != null && t.affordances.Contains(a)).Select(a => a.defName));
                    string line = $"[terrain-area] ({x}, {z}) terrain={t.defName} under={(under == null ? "none" : under.defName)} water={t.IsWater} affordances={aff}";
                    if (def != null)
                    {
                        AcceptanceReport r = GenConstruct.CanPlaceBlueprintAt(def, c, Rot4.North, map);
                        line += " place=" + (r.Accepted ? "OK" : "refused: " + r.Reason);
                    }
                    sb.AppendLine(line);
                }
            Log.Message(sb.ToString());
            ctx.Attach("terrain-area", sb.ToString());
        }
    }
}
