using System;
using System.Collections;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>Diagnostic step for the red focus lines drawn around a selected meditation focus object (an anima tree). Written 2026-10-10 for Anima Song. Not played when written.</summary>
    [PickleSteps]
    public class MeditationSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";

        /// <summary>
        /// Logs (lines starting <c>[focus]</c>) how the thing at the cell gets its meditation focus: each offset of its focus component with its type, radius and the buildings
        /// the game counts for it (read from the same proximity lister the red lines and the inspector use), with each building's def, cell and whether it is spawned.
        /// Fails when no thing on the cell carries a focus component.
        /// </summary>
        [Given(Prefix + "the meditation focus of the thing at \\({int}, {int}\\) is logged")]
        public void LogFocus(PickleContext ctx, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "Load a map first");
            var cell = new IntVec3(x, 0, z);
            Thing thing = cell.GetThingList(map).FirstOrDefault(t => t.TryGetComp<CompMeditationFocus>() != null);
            ctx.Require(thing != null, "No thing with a meditation focus on (" + x + ", " + z + ")");
            CompMeditationFocus comp = thing.TryGetComp<CompMeditationFocus>();
            Log.Message("[focus] " + thing.def.defName + " at (" + x + ", " + z + ") focusTypes=" + string.Join(",", comp.Props.focusTypes.Select(t => t.defName)));
            foreach (FocusStrengthOffset o in comp.Props.offsets.OfType<FocusStrengthOffset>())
            {
                string line = "[focus] offset " + o.GetType().Name + " offset=" + o.offset;
                var art = o as FocusStrengthOffset_ArtificialBuildings;
                if (art != null) line += " radius=" + art.radius;
                var defs = o as FocusStrengthOffset_BuildingDefs;
                if (defs != null)
                {
                    line += " radius=" + defs.radius + " maxBuildings=" + defs.maxBuildings + " defs=" + string.Join(",", defs.defs.Select(d => d.building.defName + "(" + d.offset + ")"));
                    var list = map.listerBuldingOfDefInProximity.GetForCell(thing.Position, defs.radius, defs.defs, thing);
                    line += " buildings=[" + string.Join(", ", list.Select(b => b.def.defName + "@" + b.Position.x + "," + b.Position.z + (b.Spawned ? "" : " DESPAWNED"))) + "]";
                }
                Log.Message(line);
            }
        }
    }
}
