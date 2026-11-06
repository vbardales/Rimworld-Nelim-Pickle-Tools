using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// A read-only probe of map cells: what the ground and the things on a cell are, to find what draws a patch on a shot (another terrain, a paint colour, Biotech
    /// pollution, thin snow, a zone, a filth). Written 2026-11-06 for AnimalsNaturally (a grey patch under an elephant in the enclosure). NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class CellProbeSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private const int MaxCells = 400;

        private static string Probe(Map map, IntVec3 c)
        {
            var parts = new List<string>();
            TerrainGrid grid = map.terrainGrid;
            TerrainDef top = grid.TerrainAt(c);
            parts.Add("terrain " + (top?.defName ?? "none") + " (" + (top?.label ?? "") + ", mod " + (top?.modContentPack?.Name ?? "?") + ")");
            TerrainDef under = grid.UnderTerrainAt(c);
            parts.Add("under " + (under?.defName ?? "none"));
            try { parts.Add("paint " + (grid.ColorAt(c)?.defName ?? "none")); } catch (Exception) { parts.Add("paint (unreadable)"); }
            parts.Add("polluted " + (ModsConfig.BiotechActive ? map.pollutionGrid.IsPolluted(c).ToString() : "(no Biotech)"));
            parts.Add("snow " + map.snowGrid.GetDepth(c).ToString("0.000"));
            parts.Add("roof " + (map.roofGrid.RoofAt(c)?.defName ?? "none"));
            parts.Add("fogged " + c.Fogged(map));
            Zone zone = map.zoneManager.ZoneAt(c);
            parts.Add("zone " + (zone?.label ?? "none"));
            List<Thing> things = c.GetThingList(map).Where(t => !(t is Mote)).ToList();
            if (things.Count == 0)
            {
                parts.Add("things: none");
            }
            else
            {
                parts.Add("things: " + string.Join(", ", things.Select(t =>
                {
                    bool forbidden = false;
                    try { forbidden = t.IsForbidden(Faction.OfPlayer); } catch (Exception) { }
                    return t.def.defName + " (" + t.GetType().Name + (forbidden ? ", forbidden" : "") + ")";
                })));
            }

            return "(" + c.x + ", " + c.z + "): " + string.Join("; ", parts);
        }

        /// <summary>Logs ([cell-probe] and the attachment <c>cell-probe</c>) for one cell: the terrain and the one under it, the paint colour, Biotech pollution, snow depth, roof, fog, zone, and every thing on it (def, class, forbidden). Reads only; never fails except for a cell outside the map.</summary>
        [Given(Prefix + "the cell \\({int}, {int}\\) is probed")]
        public void ProbeCell(PickleContext ctx, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map");
            var c = new IntVec3(x, 0, z);
            ctx.Require(c.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            string line = Probe(map, c);
            Log.Message("[cell-probe] " + line);
            ctx.Attach("cell-probe", line);
        }

        /// <summary>The same for every cell of a rectangle, one line each (at most 400 cells). Compare a cell inside a patch with one outside.</summary>
        [Given(Prefix + "the cells from \\({int}, {int}\\) to \\({int}, {int}\\) are probed")]
        public void ProbeArea(PickleContext ctx, int x0, int z0, int x1, int z1)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map");
            CellRect rect = CellRect.FromLimits(x0, z0, x1, z1);
            ctx.Require(rect.Area <= MaxCells, $"the rectangle holds {rect.Area} cells, the limit is {MaxCells}");
            var lines = new List<string>();
            foreach (IntVec3 c in rect)
            {
                if (c.InBounds(map)) lines.Add(Probe(map, c));
            }

            foreach (string line in lines) Log.Message("[cell-probe] " + line);
            ctx.Attach("cell-probe", string.Join("\n", lines));
        }
    }
}
