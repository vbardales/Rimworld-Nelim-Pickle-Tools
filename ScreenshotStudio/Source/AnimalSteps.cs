using System;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// An animal staged for a photograph: a chosen kind, a chosen life stage, a nickname, a cell. Pickle's own pawn steps resolve a pawn by nickname
    /// among free colonists only, so an animal needs its own lookup.
    /// </summary>
    [PickleSteps]
    public class AnimalSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private const float TicksPerYear = 3600000f;

        // Life stage by index (0 = the youngest stage the kind has, the last = the adult).
        [Given(Prefix + "an animal of kind {string} named {string} is spawned at \\({int}, {int}\\) at life stage {int}")]
        public void SpawnAtStageIndex(PickleContext ctx, string kindName, string nickname, int x, int z, int stageIndex) => Spawn(ctx, kindName, nickname, x, z, stageIndex, null);

        // Life stage by the name of its LifeStageDef (for example "AnimalBaby").
        [Given(Prefix + "an animal of kind {string} named {string} is spawned at \\({int}, {int}\\) at the life stage {string}")]
        public void SpawnAtStageName(PickleContext ctx, string kindName, string nickname, int x, int z, string stageDefName) => Spawn(ctx, kindName, nickname, x, z, -1, stageDefName);

        [Given(Prefix + "an adult animal of kind {string} named {string} is spawned at \\({int}, {int}\\)")]
        public void SpawnAdult(PickleContext ctx, string kindName, string nickname, int x, int z) => Spawn(ctx, kindName, nickname, x, z, int.MaxValue, null);

        // Centres the camera on a spawned animal, found by its nickname, at the given camera root size.
        [When(Prefix + "I frame the animal {string} at zoom {int}")]
        public async Task FrameAnimal(PickleContext ctx, string nickname, int size)
        {
            var pawn = Find.CurrentMap?.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p.RaceProps.Animal && p.Name != null && p.Name.ToStringShort == nickname);
            ctx.Require(pawn != null, "No spawned animal named " + nickname);
            Find.Selector.ClearSelection();
            Find.CameraDriver.JumpToCurrentMapLoc(pawn.Position);
            Find.CameraDriver.SetRootSize(size);
            await ctx.WaitFrames(3);
        }

        // A cell a pawn can be photographed on: standable, no building, plant, tree, fence or other pawn, and not enclosed by a wall-like edifice.
        private static bool FreeCell(Map map, IntVec3 c) =>
            c.InBounds(map) && c.Standable(map) && c.GetEdifice(map) == null && c.GetPlant(map) == null
            && !c.GetThingList(map).Any(t => t is Pawn || t.def.passability != Traversability.Standable && t.def.category != ThingCategory.Item && t.def.category != ThingCategory.Filth && t.def.category != ThingCategory.Mote);

        // The nearest free cell around (x, z), nearest first by true distance, up to 15 cells away.
        private static void StandOnNearestFree(PickleContext ctx, Pawn pawn, string who, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            ctx.Require(pawn != null && pawn.Spawned, "No spawned " + who);
            var centre = new IntVec3(x, 0, z);
            ctx.Require(centre.InBounds(map), "Cell (" + x + ", " + z + ") is outside the map");
            IntVec3 best = IntVec3.Invalid; float bestDist = float.MaxValue;
            for (int dx = -15; dx <= 15; dx++)
                for (int dz = -15; dz <= 15; dz++)
                {
                    var c = new IntVec3(x + dx, 0, z + dz);
                    float d = dx * dx + dz * dz;
                    if (d < bestDist && (c == pawn.Position || FreeCell(map, c)) && !map.mapPawns.AllPawnsSpawned.Any(p => p != pawn && p.Position == c)) { best = c; bestDist = d; }
                }
            ctx.Require(best.IsValid, "No free cell within 15 cells of (" + x + ", " + z + ") for " + who);
            pawn.Position = best;
            pawn.Notify_Teleported(true, true);
            ctx.Assert(pawn.Position == best, who + " is at " + pawn.Position + " instead of " + best);
        }

        /// <summary>Moves a spawned animal (by nickname) to the free cell nearest (x, z): standable, with no building, plant, tree, fence or pawn. Fails when none is within 15 cells.</summary>
        [Given(Prefix + "the animal {string} stands on the nearest free cell around \\({int}, {int}\\)")]
        public void AnimalOnNearestFree(PickleContext ctx, string nickname, int x, int z)
        {
            var pawn = Find.CurrentMap?.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p.RaceProps.Animal && p.Name != null && p.Name.ToStringShort == nickname);
            StandOnNearestFree(ctx, pawn, "animal " + nickname, x, z);
        }

        /// <summary>The same for a colonist found by nickname.</summary>
        [Given(Prefix + "the colonist {string} stands on the nearest free cell around \\({int}, {int}\\)")]
        public void ColonistOnNearestFree(PickleContext ctx, string nickname, int x, int z)
        {
            var pawn = Find.CurrentMap?.mapPawns.FreeColonistsSpawned.FirstOrDefault(p => p.Name != null && p.Name.ToStringShort == nickname);
            StandOnNearestFree(ctx, pawn, "colonist " + nickname, x, z);
        }

        /// <summary>Puts N things of a def (by defName) in the inventory of a spawned animal found by nickname (pawn.inventory, not the transport tracker), so a pack animal draws its pack. Fails when the animal or def is unknown or the stack does not fit.</summary>
        [Given(Prefix + "the animal {string} carries {int} {string} in its pack")]
        public void AnimalCarriesInPack(PickleContext ctx, string nickname, int count, string defName)
        {
            var pawn = Find.CurrentMap?.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p.RaceProps.Animal && p.Name != null && p.Name.ToStringShort == nickname);
            ctx.Require(pawn != null, "No spawned animal named " + nickname);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, "No thing def named " + defName);
            ctx.Require(count >= 1 && count <= def.stackLimit, "count runs from 1 to the stack limit " + def.stackLimit + " of " + defName);
            Thing thing = ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
            thing.stackCount = count;
            ctx.Require(pawn.inventory.innerContainer.TryAdd(thing, count) == count, nickname + "'s inventory did not take " + count + " " + defName);
            ctx.Assert(pawn.inventory.innerContainer.TotalStackCountOfDef(def) >= count, nickname + " does not carry " + count + " " + defName + " after the step");
        }

        private static void Spawn(PickleContext ctx, string kindName, string nickname, int x, int z, int stageIndex, string stageDefName)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null && kind.RaceProps != null && kind.RaceProps.Animal, "No animal PawnKindDef named " + kindName);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), "Cell (" + x + ", " + z + ") is outside the map");
            var stages = kind.RaceProps.lifeStageAges;
            ctx.Require(stages != null && stages.Count > 0, kindName + " has no life stages");
            int index = stageIndex;
            if (stageDefName != null)
            {
                index = stages.FindIndex(s => s.def != null && s.def.defName == stageDefName);
                ctx.Require(index >= 0, kindName + " has no life stage " + stageDefName + "; it has: " + string.Join(", ", stages.Select(s => s.def.defName)));
            }
            if (index == int.MaxValue) index = stages.Count - 1;
            ctx.Require(index >= 0 && index < stages.Count, kindName + " has " + stages.Count + " life stages (0 to " + (stages.Count - 1) + "), not " + index);

            Pawn pawn = PawnGenerator.GeneratePawn(new PawnGenerationRequest(kind, Faction.OfPlayer));
            // Half-way into the stage, or a quarter year past the start of the last one.
            float years = index == stages.Count - 1 ? stages[index].minAge + 0.25f : (stages[index].minAge + stages[index + 1].minAge) * 0.5f;
            if (index == 0 && stages.Count > 1) years = Math.Min(years, stages[1].minAge * 0.5f);
            long ticks = (long)(years * TicksPerYear);
            pawn.ageTracker.AgeBiologicalTicks = ticks;
            pawn.ageTracker.AgeChronologicalTicks = ticks;
            pawn.Name = new NameSingle(nickname);
            GenSpawn.Spawn(pawn, cell, map);
            ctx.Require(pawn.ageTracker.CurLifeStageIndex == index, nickname + " is at life stage " + pawn.ageTracker.CurLifeStageIndex + " instead of " + index);
        }
    }
}
