using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.CoatSteps
{
    /// <summary>
    /// Spawns animals of a kind and reads which alternate coat each drew, for any mod that adds alternateGraphics to
    /// a PawnKindDef. No mod, no def and no number is written in a pattern: all of them come from the feature.
    ///
    /// The coat is <c>Pawn.overrideGraphicIndex</c>, a Nullable&lt;int&gt; read by reflection (its name and type were
    /// checked against 1.6's Assembly-CSharp.dll by the Dodos suite's author). Null is the graphic the animal hatched
    /// with; a value indexes into <c>PawnKindDef.alternateGraphics</c>. If the field is renamed the steps stop with a
    /// sentence naming it: they do not pass on a null.
    ///
    /// NOT PLAYED YET. Whether the index is set at spawn or the first time the animal is drawn is not established, so
    /// every step that reads it waits some frames first; a run must confirm that is enough.
    ///
    /// Animals are named "coat-1", "coat-2"... so they can be found again after a reload, when every kept reference
    /// belongs to the game that was replaced. An [AfterScenario] removes what a scenario left.
    /// </summary>
    [PickleSteps]
    public class CoatSteps
    {
        private const string Prefix = "coat-";
        private const int SettleFrames = 30;

        private static readonly FieldInfo IndexField =
            typeof(Pawn).GetField("overrideGraphicIndex", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);

        /// <summary>Coats noted by a step, per animal name, kept for the comparison after a reload.</summary>
        private sealed class NotedCoats
        {
            public readonly Dictionary<string, int?> ByName = new Dictionary<string, int?>();
        }

        [Given("Nelim's Pickle Tools: {int} animals of kind {string} are spawned")]
        public void Spawn(PickleContext ctx, int count, string kindDefName) => SpawnAnimals(ctx, count, kindDefName, false);

        [Given("Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned")]
        public void SpawnAdults(PickleContext ctx, int count, string kindDefName) => SpawnAnimals(ctx, count, kindDefName, true);

        private static void SpawnAnimals(PickleContext ctx, int count, string kindDefName, bool adults)
        {
            ctx.Require(count > 0, "spawning " + count + " animals says nothing: ask for at least 1");
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindDefName);
            ctx.Require(kind != null, "no pawn kind '" + kindDefName + "'");
            ctx.Require(kind.RaceProps != null && kind.RaceProps.Animal, "pawn kind '" + kindDefName + "' is not an animal");
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map: load a save first");

            // Room for a big animal: a cell counts only when every cell around it is standable and free.
            var placed = new List<IntVec3>();
            for (int i = 1; i <= count; i++)
            {
                IntVec3 cell = FindCell(map, placed);
                ctx.Require(
                    cell.IsValid,
                    "could not place animal " + i + " of " + count + " of kind " + kindDefName + ": no clear area within 60 cells of the map centre; "
                    + placed.Count + " were placed. Clear the area or ask for fewer.");

                PawnGenerationRequest request = adults
                    ? new PawnGenerationRequest(kind, Faction.OfPlayer, PawnGenerationContext.NonPlayer, -1, forceGenerateNewPawn: true,
                        fixedBiologicalAge: AdultAge(kind))
                    : new PawnGenerationRequest(kind, Faction.OfPlayer, PawnGenerationContext.NonPlayer, -1, forceGenerateNewPawn: true);
                Pawn pawn = PawnGenerator.GeneratePawn(request);
                pawn.Name = new NameSingle(Prefix + i);
                GenSpawn.Spawn(pawn, cell, map, WipeMode.Vanish);
                ctx.Require(pawn.Spawned, "animal " + i + " of kind " + kindDefName + " could not be placed at " + cell);
                placed.Add(cell);
            }
        }

        private static float AdultAge(PawnKindDef kind)
        {
            var ages = kind.RaceProps.lifeStageAges;
            return ages != null && ages.Count > 0 ? ages[ages.Count - 1].minAge : 0f;
        }

        private static IntVec3 FindCell(Map map, List<IntVec3> taken)
        {
            for (int radius = 4; radius <= 60; radius += 4)
            {
                if (CellFinder.TryFindRandomCellNear(map.Center, map, radius, c => Clear(map, c, taken), out IntVec3 found, 400))
                {
                    return found;
                }
            }

            return IntVec3.Invalid;
        }

        private static bool Clear(Map map, IntVec3 cell, List<IntVec3> taken)
        {
            foreach (IntVec3 c in GenAdj.CellsAdjacent8Way(new TargetInfo(cell, map)).Concat(new[] { cell }))
            {
                if (!c.InBounds(map) || !c.Standable(map) || c.GetFirstPawn(map) != null)
                {
                    return false;
                }
            }

            return taken.All(t => (t - cell).LengthHorizontalSquared > 4);
        }

        private static List<Pawn> Animals(PickleContext ctx, string kindDefName)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map");
            var animals = map.mapPawns.AllPawnsSpawned
                .Where(p => p.kindDef != null && p.kindDef.defName == kindDefName && p.Name != null && p.LabelShort.StartsWith(Prefix))
                .OrderBy(p => p.LabelShort)
                .ToList();
            ctx.Require(animals.Count > 0, "no animal of kind " + kindDefName + " named " + Prefix + "N is on the map: spawn some first");
            return animals;
        }

        private static int? Coat(PickleContext ctx, Pawn pawn)
        {
            ctx.Require(
                IndexField != null && IndexField.FieldType == typeof(int?),
                "Verse.Pawn.overrideGraphicIndex as a Nullable<int> is gone in this build: the coat cannot be read, and this must not pass on a null");
            return (int?)IndexField.GetValue(pawn);
        }

        private static async Task<List<Pawn>> Settled(PickleContext ctx, string kindDefName)
        {
            await ctx.WaitFrames(SettleFrames);
            return Animals(ctx, kindDefName);
        }

        [Then("Nelim's Pickle Tools: among the animals of kind {string}, at least {int} different extra coats were drawn")]
        public async Task DistinctExtraCoats(PickleContext ctx, string kindDefName, int wanted)
        {
            List<Pawn> animals = await Settled(ctx, kindDefName);
            List<int?> coats = animals.Select(p => Coat(ctx, p)).ToList();
            string problem = CoatVerdicts.DistinctExtraCoats(kindDefName, coats, wanted);
            ctx.Assert(problem == null, problem);
        }

        [Then("Nelim's Pickle Tools: every animal of kind {string} has a coat within its kind's alternate graphics")]
        public async Task CoatsInRange(PickleContext ctx, string kindDefName)
        {
            List<Pawn> animals = await Settled(ctx, kindDefName);
            foreach (Pawn pawn in animals)
            {
                int count = pawn.kindDef.alternateGraphics?.Count ?? 0;
                string problem = CoatVerdicts.IndexInRange(pawn.LabelShort, Coat(ctx, pawn), count);
                ctx.Assert(problem == null, problem);
            }
        }

        [When("Nelim's Pickle Tools: I note the coats of the animals of kind {string}")]
        public async Task NoteCoats(PickleContext ctx, string kindDefName)
        {
            List<Pawn> animals = await Settled(ctx, kindDefName);
            var noted = new NotedCoats();
            foreach (Pawn pawn in animals)
            {
                noted.ByName[pawn.LabelShort] = Coat(ctx, pawn);
            }

            ctx.Set(noted);
        }

        [Then("Nelim's Pickle Tools: each animal of kind {string} still has the coat noted for it")]
        public async Task SameCoats(PickleContext ctx, string kindDefName)
        {
            NotedCoats noted = null;
            try
            {
                noted = ctx.Get<NotedCoats>();
            }
            catch (InvalidOperationException)
            {
            }

            ctx.Require(noted != null, "no coats were noted in this scenario: use 'I note the coats of the animals of kind ...' before the reload");

            // After a reload every kept reference is stale: animals are found again by name on the current map.
            List<Pawn> animals = await Settled(ctx, kindDefName);
            ctx.Assert(
                animals.Count == noted.ByName.Count,
                "the map holds " + animals.Count + " animals of kind " + kindDefName + " named " + Prefix + "N and " + noted.ByName.Count + " were noted");
            foreach (Pawn pawn in animals)
            {
                ctx.Assert(noted.ByName.ContainsKey(pawn.LabelShort), pawn.LabelShort + " was not among the animals noted");
                string problem = CoatVerdicts.SameCoat(pawn.LabelShort, noted.ByName[pawn.LabelShort], Coat(ctx, pawn));
                ctx.Assert(problem == null, problem);
            }
        }

        // A scenario that dies leaves its animals on the map for the next one. Only what is spawned NOW is touched,
        // never a kept reference: after a reload those belong to the game that was replaced.
        [AfterScenario]
        public void CleanUp(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            if (map == null)
            {
                return;
            }

            foreach (Pawn pawn in map.mapPawns.AllPawnsSpawned.Where(p => p.Name != null && p.LabelShort.StartsWith(Prefix) && p.RaceProps.Animal).ToList())
            {
                if (!pawn.Destroyed)
                {
                    pawn.Destroy();
                }
            }
        }
    }
}
