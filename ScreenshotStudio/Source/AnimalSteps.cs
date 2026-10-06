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
