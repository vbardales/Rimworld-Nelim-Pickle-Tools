using System;
using System.Collections.Generic;
using System.Linq;
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
    /// The coat is what <c>PawnGraphicUtils.GetGraphicIndex(pawn)</c> returns: the index the renderer itself draws,
    /// computed on demand from the pawn's thingIDNumber and the kind's alternateGraphicChance, -1 for the original
    /// graphic. Nothing is stored, so nothing has to settle after a spawn. Pawn.overrideGraphicIndex is a different
    /// thing (declared on Thing, unread by the renderer, null for an ordinary animal): reading it counted no coat.
    /// After a reload the same coat comes back only while the animal's thingIDNumber and the kind's alternateGraphics
    /// list are unchanged, which is what "still has the coat noted" therefore asserts.
    ///
    /// NOT PLAYED YET: compiled against the reference stubs only.
    ///
    /// Animals are named "coat-1", "coat-2"... so they can be found again after a reload, when every kept reference
    /// belongs to the game that was replaced. An [AfterScenario] removes what a scenario left.
    /// </summary>
    [PickleSteps]
    public class CoatSteps
    {
        private const string Prefix = "coat-";

        /// <summary>Coats noted by a step, per animal name, kept for the comparison after a reload.</summary>
        private sealed class NotedCoats
        {
            public readonly Dictionary<string, int?> ByName = new Dictionary<string, int?>();
        }

        [Given("Nelim's Pickle Tools: {int} animals of kind {string} are spawned")]
        public void Spawn(PickleContext ctx, int count, string kindDefName) => SpawnAnimals(ctx, count, kindDefName, false);

        [Given("Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned")]
        public void SpawnAdults(PickleContext ctx, int count, string kindDefName) => SpawnAnimals(ctx, count, kindDefName, true);

        // For a review capture: the batch packed within four cells of the map centre so one frame can hold it. The wide
        // spawns above are for the statistics, which need no picture. Wording from ColorfulCoatsCatsAndDogsRenew.
        [Given("Nelim's Pickle Tools: {int} animals of kind {string} are spawned close together")]
        public void SpawnClose(PickleContext ctx, int count, string kindDefName) => SpawnAnimals(ctx, count, kindDefName, false, CloseRadius);

        [Given("Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned close together")]
        public void SpawnAdultsClose(PickleContext ctx, int count, string kindDefName) => SpawnAnimals(ctx, count, kindDefName, true, CloseRadius);

        // Paused first, so nothing wanders out of frame between the jump and the picture. The zoom is the one the
        // Dalmatians suite settled on (8) after its first captures showed a dog a few pixels wide; Cats and Dogs uses 9.
        // The 2-cell offset in z is not decoration: the pointer stays at the screen centre and the tooltip of what is
        // under it is drawn into the picture, so the camera looks slightly past the batch and leaves the batch above it.
        [When("Nelim's Pickle Tools: I frame the animals of kind {string}", TimeoutSeconds = 15f)]
        public async Task Frame(PickleContext ctx, string kindDefName)
        {
            List<Pawn> animals = Animals(ctx, kindDefName);
            int x = (int)animals.Average(p => p.Position.x);
            int z = (int)animals.Average(p => p.Position.z);
            Find.TickManager.CurTimeSpeed = TimeSpeed.Paused;
            Find.Selector.ClearSelection();
            Find.CameraDriver.JumpToCurrentMapLoc(new IntVec3(x, 0, z - 2));
            Find.CameraDriver.SetRootSize(9f);
            await ctx.WaitFrames(5);
        }

        private const int WideRadius = 60;
        private const int CloseRadius = 4;

        private static void SpawnAnimals(PickleContext ctx, int count, string kindDefName, bool adults, int radius = WideRadius, IntVec3? around = null, IntVec3[] cells = null, int firstNumber = 1)
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
                IntVec3 cell = cells != null ? cells[i - 1] : FindCell(map, placed, radius, around ?? map.Center);
                ctx.Require(
                    cell.IsValid,
                    "could not place animal " + i + " of " + count + " of kind " + kindDefName + ": no clear area within " + radius + " cells of " + (around ?? map.Center) + "; "
                    + placed.Count + " were placed. Clear the area or ask for fewer.");

                PawnGenerationRequest request = adults
                    ? new PawnGenerationRequest(kind, Faction.OfPlayer, PawnGenerationContext.NonPlayer, -1, forceGenerateNewPawn: true,
                        fixedBiologicalAge: AdultAge(kind))
                    : new PawnGenerationRequest(kind, Faction.OfPlayer, PawnGenerationContext.NonPlayer, -1, forceGenerateNewPawn: true);
                Pawn pawn = PawnGenerator.GeneratePawn(request);
                pawn.Name = new NameSingle(Prefix + (firstNumber + i - 1));
                GenSpawn.Spawn(pawn, cell, map, WipeMode.Vanish);
                ctx.Require(pawn.Spawned, "animal " + i + " of kind " + kindDefName + " could not be placed at " + cell);
                placed.Add(cell);
            }
        }

        private const int AroundRadius = 16;

        private static int NextNumber(Map map)
        {
            return map.mapPawns.AllPawnsSpawned.Count(p => p.Name != null && p.LabelShort.StartsWith(Prefix)) + 1;
        }

        // Centred on a cell the author picks (free ground of the fixture), not on the map centre, and with a clear 3 by 3 around each
        // animal so a large one fits. Names continue after the coat-N animals already there instead of starting again at 1.
        [Given("Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned around \\({int}, {int}\\)")]
        public void SpawnAdultsAround(PickleContext ctx, int count, string kindDefName, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map: load a save first");
            SpawnAnimals(ctx, count, kindDefName, true, AroundRadius, new IntVec3(x, 0, z), null, NextNumber(map));
        }

        // A row on the z of the first cell, one animal every N cells towards +x: a specimen plate, small to large. Every cell is asked for
        // before any animal is made, so a blocked row fails without leaving half of it on the map.
        [Given("Nelim's Pickle Tools: {int} adult animals of kind {string} are spawned in a row from \\({int}, {int}\\), spacing {int}")]
        public void SpawnAdultsInRow(PickleContext ctx, int count, string kindDefName, int x, int z, int spacing)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map: load a save first");
            ctx.Require(spacing >= 1, "the spacing between animals is at least 1 cell, not " + spacing);
            var cells = new IntVec3[count];
            for (int i = 0; i < count; i++)
            {
                cells[i] = new IntVec3(x + i * spacing, 0, z);
                ctx.Require(
                    cells[i].InBounds(map) && cells[i].Standable(map) && cells[i].GetFirstPawn(map) == null,
                    "the cell " + cells[i] + " of the row is outside the map, not standable, or already holds a pawn");
            }

            SpawnAnimals(ctx, count, kindDefName, true, WideRadius, null, cells, NextNumber(map));
        }

        // The need as a percentage, so a hungry animal can be staged (a mod that makes animals dig for food when hungry shows it).
        [Given("Nelim's Pickle Tools: the animals of kind {string} have food at {int} percent")]
        public void SetFood(PickleContext ctx, string kindDefName, int percent)
        {
            ctx.Require(percent >= 0 && percent <= 100, "food is 0 to 100 percent, not " + percent);
            foreach (Pawn animal in Animals(ctx, kindDefName))
            {
                ctx.Require(animal.needs?.food != null, animal.LabelShort + " has no food need");
                animal.needs.food.CurLevelPercentage = percent / 100f;
                ctx.Assert(
                    System.Math.Abs(animal.needs.food.CurLevelPercentage - percent / 100f) < 0.02f,
                    animal.LabelShort + " should have food at " + percent + " percent; it has " + (int)(animal.needs.food.CurLevelPercentage * 100f));
            }
        }

        // The coat is computed from the pawn's thingIDNumber and the kind's chance (nothing is stored), so it cannot be written; a thing ID
        // that gives the index asked for is searched instead, among IDs above anything the game hands out in a short run, and the index
        // is read back. -1 is the original graphic.
        [Given("Nelim's Pickle Tools: the animal {string} is given coat {int}")]
        public void GiveCoat(PickleContext ctx, string animalName, int coat)
        {
            Pawn animal = Find.CurrentMap?.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p.Name != null && p.LabelShort == animalName);
            ctx.Require(animal != null, "no animal named " + animalName + " is on the map: spawn it first");
            int available = animal.kindDef.alternateGraphics?.Count ?? 0;
            ctx.Require(coat >= -1 && coat < available, animal.LabelShort + " has " + available + " alternate coats (0 to " + (available - 1) + ", or -1 for the original), not " + coat);
            int original = animal.thingIDNumber;
            for (int id = 5000000; id < 5000000 + 20000; id++)
            {
                animal.thingIDNumber = id;
                if (animal.GetGraphicIndex() == coat)
                {
                    animal.Drawer.renderer.SetAllGraphicsDirty();
                    return;
                }
            }

            animal.thingIDNumber = original;
            ctx.Require(false, "no thing ID in 20000 tries gives " + animal.LabelShort + " the coat " + coat + "; the kind's alternateGraphicChance may make it unreachable");
        }

        private static float AdultAge(PawnKindDef kind)
        {
            var ages = kind.RaceProps.lifeStageAges;
            return ages != null && ages.Count > 0 ? ages[ages.Count - 1].minAge : 0f;
        }

        private static IntVec3 FindCell(Map map, List<IntVec3> taken, int maxRadius, IntVec3 center)
        {
            for (int radius = 4; radius <= maxRadius; radius += 4)
            {
                if (CellFinder.TryFindRandomCellNear(center, map, radius, c => Clear(map, c, taken), out IntVec3 found, 400))
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

        // What the renderer itself draws: PawnGraphicUtils.TryGetAlternate computes the coat on demand from the pawn's
        // thingIDNumber and the kind's alternateGraphicChance, and stores nothing. -1 is the original graphic.
        // Pawn.overrideGraphicIndex is NOT this: it is declared on Thing, read by no renderer, and stays null for an
        // animal spawned normally. Decompiled from 1.6's Assembly-CSharp.dll by the Megafauna session.
        private static int? Coat(PickleContext ctx, Pawn pawn)
        {
            int index = pawn.GetGraphicIndex();
            return index >= 0 ? (int?)index : null;
        }

        // The coat is computed, not stored, so nothing has to settle: a frame is enough for a spawn to be visible.
        private static async Task<List<Pawn>> Settled(PickleContext ctx, string kindDefName)
        {
            await ctx.WaitFrames(1);
            return Animals(ctx, kindDefName);
        }

        // Names the def type: "RG_Dodo" is both a ThingDef and a PawnKindDef, so Pickle's own field step refuses it.
        [Then("Nelim's Pickle Tools: the pawn kind {string} keeps {int} alternate graphics at a chance of {string}")]
        public void KindKeeps(PickleContext ctx, string kindDefName, int count, string chance)
        {
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindDefName);
            ctx.Require(kind != null, "no pawn kind '" + kindDefName + "'");
            ctx.Require(
                float.TryParse(chance, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out float wanted),
                "'" + chance + "' is not a number: write the chance with a dot, like 0.8");
            int actual = kind.alternateGraphics?.Count ?? 0;
            ctx.Assert(actual == count, "pawn kind " + kindDefName + " carries " + actual + " alternate graphics and " + count + " were expected");
            ctx.Assert(
                System.Math.Abs(kind.alternateGraphicChance - wanted) < 0.0001f,
                "pawn kind " + kindDefName + " has alternateGraphicChance " + kind.alternateGraphicChance.ToString(System.Globalization.CultureInfo.InvariantCulture) + " and " + chance + " was expected");
        }

        [Then("Nelim's Pickle Tools: among the animals of kind {string}, at least {int} different extra coats were drawn")]
        public async Task DistinctExtraCoats(PickleContext ctx, string kindDefName, int wanted)
        {
            List<Pawn> animals = await Settled(ctx, kindDefName);
            List<int?> coats = animals.Select(p => Coat(ctx, p)).ToList();
            string problem = CoatVerdicts.DistinctExtraCoats(kindDefName, coats, wanted);
            ctx.Assert(problem == null, problem);
        }

        [Then("Nelim's Pickle Tools: among the animals of kind {string}, at least {int} carry an extra coat")]
        public async Task AtLeastExtra(PickleContext ctx, string kindDefName, int wanted)
        {
            List<Pawn> animals = await Settled(ctx, kindDefName);
            List<int?> coats = animals.Select(p => Coat(ctx, p)).ToList();
            string problem = CoatVerdicts.AtLeastCarrying(kindDefName, coats, wanted);
            ctx.Assert(problem == null, problem);
        }

        [Then("Nelim's Pickle Tools: no animal of kind {string} carries an extra coat")]
        public async Task NoExtra(PickleContext ctx, string kindDefName)
        {
            List<Pawn> animals = await Settled(ctx, kindDefName);
            List<int?> coats = animals.Select(p => Coat(ctx, p)).ToList();
            string problem = CoatVerdicts.NoneCarrying(kindDefName, coats);
            ctx.Assert(problem == null, problem);
        }

        // The deterministic check: the graphic the renderer BUILT for the pawn, read from its render tree, against the
        // texture path of the coat the index names. Not the def looked up by index twice, which would be true by
        // construction. PawnRenderer.BodyGraphic is public and needs no drawn frame once the tree is initialised;
        // Graphic.path is a public field and survives GetColoredVersion (decompiled from 1.6, not played).
        // AlternateGraphic.texPath is private, so it is read by reflection and the step stops with a sentence if that
        // field is renamed.
        private static readonly System.Reflection.FieldInfo AlternateTexPath =
            typeof(AlternateGraphic).GetField("texPath", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public);

        [Then("Nelim's Pickle Tools: each animal of kind {string} that carries an extra coat is drawn with that coat's own texture")]
        public async Task DrawnWithItsCoat(PickleContext ctx, string kindDefName)
        {
            ctx.Require(AlternateTexPath != null && AlternateTexPath.FieldType == typeof(string),
                "Verse.AlternateGraphic.texPath as a string is gone in this build: the coat's texture cannot be read");
            List<Pawn> animals = await Settled(ctx, kindDefName);
            int checkedCount = 0;
            foreach (Pawn pawn in animals)
            {
                int index = pawn.GetGraphicIndex();
                if (index < 0)
                {
                    continue;
                }

                pawn.Drawer.renderer.renderTree.EnsureInitialized(PawnRenderFlags.None);
                Graphic drawn = pawn.Drawer.renderer.BodyGraphic;
                ctx.Require(drawn != null, pawn.LabelShort + " has no resolved body graphic: the render tree did not produce one, so the coat drawn cannot be read");
                var alternates = pawn.kindDef.alternateGraphics;
                ctx.Require(alternates != null && index < alternates.Count, pawn.LabelShort + " reports coat " + index + " but its kind carries " + (alternates?.Count ?? 0));
                string expected = (string)AlternateTexPath.GetValue(alternates[index]);
                string problem = CoatVerdicts.DrawnPath(pawn.LabelShort, index, expected, drawn.path);
                ctx.Assert(problem == null, problem);
                checkedCount++;
            }

            ctx.Assert(checkedCount > 0, "none of the " + animals.Count + " animals of kind " + kindDefName + " carries an extra coat, so nothing was compared: spawn more, or use 'no animal ... carries an extra coat' where that is the claim");
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
