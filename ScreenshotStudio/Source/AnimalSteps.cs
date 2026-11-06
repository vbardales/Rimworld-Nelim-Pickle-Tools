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

        /// <summary>The same adult with its sex fixed (word: female or male), for a mother and a father that must read as such. Written 2026-10-25 for Creatures of Ki. NOT PLAYED.</summary>
        [Given(Prefix + "a {word} adult animal of kind {string} named {string} is spawned at \\({int}, {int}\\)")]
        public void SpawnAdultOfSex(PickleContext ctx, string sex, string kindName, string nickname, int x, int z) => Spawn(ctx, kindName, nickname, x, z, int.MaxValue, null, RequireSex(ctx, sex));

        /// <summary>The same by life stage index (0 = youngest, last = adult), sex fixed. NOT PLAYED.</summary>
        [Given(Prefix + "a {word} animal of kind {string} named {string} is spawned at \\({int}, {int}\\) at life stage {int}")]
        public void SpawnAtStageIndexOfSex(PickleContext ctx, string sex, string kindName, string nickname, int x, int z, int stageIndex) => Spawn(ctx, kindName, nickname, x, z, stageIndex, null, RequireSex(ctx, sex));

        private static Gender RequireSex(PickleContext ctx, string sex)
        {
            ctx.Require(sex == "female" || sex == "male", "the sex is female or male, not '" + sex + "'");
            return sex == "female" ? Gender.Female : Gender.Male;
        }

        /// <summary>
        /// Names the animal the game's own hatcher (or birth) produced: the youngest spawned animal of that PawnKindDef that has no name yet. Then every
        /// step that takes an animal's nickname addresses it (stands at, forced to walk to, frame). Fails when none is found, or when two unnamed animals
        /// of the kind share the youngest age (the failure says so: name the other first). Written 2026-10-25 for Creatures of Ki. NOT PLAYED.
        /// </summary>
        [Given(Prefix + "the newborn animal of kind {string} is named {string}")]
        public void NameNewborn(PickleContext ctx, string kindName, string nickname)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var unnamed = AreaOps.SpawnedPawns(map).Where(p => p.RaceProps.Animal && p.kindDef != null && p.kindDef.defName == kindName && p.Name == null).OrderBy(p => p.ageTracker.AgeBiologicalTicks).ToList();
            ctx.Require(unnamed.Count > 0, "No unnamed spawned animal of kind " + kindName + " (a hatched or born animal that already has a name cannot be found this way)");
            ctx.Require(unnamed.Count == 1 || unnamed[0].ageTracker.AgeBiologicalTicks != unnamed[1].ageTracker.AgeBiologicalTicks, unnamed.Count + " unnamed animals of kind " + kindName + " and the two youngest have the same age: name the others first");
            unnamed[0].Name = new NameSingle(nickname);
            ctx.Assert(AnimalNamed(ctx, nickname) == unnamed[0], "the animal named " + nickname + " is not the newborn found");
        }

        // Centres the camera on a spawned animal, found by its nickname, at the given camera root size.
        [When(Prefix + "I frame the animal {string} at zoom {int}")]
        public async Task FrameAnimal(PickleContext ctx, string nickname, int size)
        {
            var pawn = AreaOps.SpawnedPawns(Find.CurrentMap).FirstOrDefault(p => p.RaceProps.Animal && p.Name != null && p.Name.ToStringShort == nickname);
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
                    if (d < bestDist && (c == pawn.Position || FreeCell(map, c)) && !AreaOps.SpawnedPawns(map).Any(p => p != pawn && p.Position == c)) { best = c; bestDist = d; }
                }
            ctx.Require(best.IsValid, "No free cell within 15 cells of (" + x + ", " + z + ") for " + who);
            pawn.Position = best;
            pawn.Notify_Teleported(true, true);
            ctx.Assert(pawn.Position == best, who + " is at " + pawn.Position + " instead of " + best);
        }

        /// <summary>
        /// Keeps a spawned animal (short name) at least N cells from a pawn (colonist or animal, short name): when it is closer, it is moved to the free cell
        /// (standable, no building, plant, tree, fence or pawn) nearest to where it stands that is N cells or more from that pawn by true distance (searched up to
        /// N + 15 cells around the animal); when it is far enough, it stays. Fails when no cell fits. The move is once: a free animal walks again when the game runs.
        /// Asked for by aSM (a baby asleep over Nelim), 2026-11-06. Compiled, not played.
        /// </summary>
        [Given(Prefix + "the animal {string} stands at least {int} cells from {string}")]
        public void AnimalAtLeastFrom(PickleContext ctx, string nickname, int cells, string otherName)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            Func<string, Pawn> find = n => AreaOps.SpawnedPawns(map).FirstOrDefault(p => p.Name != null && string.Equals(p.Name.ToStringShort, n, StringComparison.OrdinalIgnoreCase));
            Pawn animal = AreaOps.SpawnedPawns(map).FirstOrDefault(p => p.RaceProps.Animal && p.Name != null && string.Equals(p.Name.ToStringShort, nickname, StringComparison.OrdinalIgnoreCase));
            Pawn other = find(otherName);
            ctx.Require(animal != null, "No spawned animal named " + nickname);
            ctx.Require(other != null, "No spawned pawn named " + otherName);
            ctx.Require(cells >= 1 && cells <= 40, "cells run from 1 to 40");
            float dist = animal.Position.DistanceTo(other.Position);
            if (dist >= cells)
            {
                Log.Message("[animal-away] " + nickname + " is " + dist.ToString("0.0") + " cells from " + otherName + ", at least " + cells + ": left in place");
                return;
            }

            int reach = cells + 15;
            IntVec3 best = IntVec3.Invalid; float bestDist = float.MaxValue;
            for (int dx = -reach; dx <= reach; dx++)
                for (int dz = -reach; dz <= reach; dz++)
                {
                    var c = new IntVec3(animal.Position.x + dx, 0, animal.Position.z + dz);
                    float d = dx * dx + dz * dz;
                    if (d < bestDist && FreeCell(map, c) && c.DistanceTo(other.Position) >= cells && !AreaOps.SpawnedPawns(map).Any(p => p != animal && p.Position == c)) { best = c; bestDist = d; }
                }

            ctx.Require(best.IsValid, "No free cell " + cells + " cells or more from " + otherName + " within " + reach + " cells of " + nickname);
            animal.Position = best;
            animal.Notify_Teleported(true, true);
            ctx.Assert(animal.Position.DistanceTo(other.Position) >= cells, nickname + " is still closer than " + cells + " cells to " + otherName);
            Log.Message("[animal-away] " + nickname + " moved from " + dist.ToString("0.0") + " cells to " + animal.Position.DistanceTo(other.Position).ToString("0.0") + " cells from " + otherName + ", at (" + best.x + ", " + best.z + ")");
        }

        /// <summary>Moves a spawned animal (by nickname) to the free cell nearest (x, z): standable, with no building, plant, tree, fence or pawn. Fails when none is within 15 cells.</summary>
        [Given(Prefix + "the animal {string} stands on the nearest free cell around \\({int}, {int}\\)")]
        public void AnimalOnNearestFree(PickleContext ctx, string nickname, int x, int z)
        {
            var pawn = AreaOps.SpawnedPawns(Find.CurrentMap).FirstOrDefault(p => p.RaceProps.Animal && p.Name != null && p.Name.ToStringShort == nickname);
            StandOnNearestFree(ctx, pawn, "animal " + nickname, x, z);
        }

        /// <summary>The same for a colonist found by nickname.</summary>
        [Given(Prefix + "the colonist {string} stands on the nearest free cell around \\({int}, {int}\\)")]
        public void ColonistOnNearestFree(PickleContext ctx, string nickname, int x, int z)
        {
            var pawn = AreaOps.SpawnedPawns(Find.CurrentMap).Where(p => p.IsColonist && p.Faction == Faction.OfPlayer).FirstOrDefault(p => p.Name != null && p.Name.ToStringShort == nickname);
            StandOnNearestFree(ctx, pawn, "colonist " + nickname, x, z);
        }

        /// <summary>Puts N things of a def (by defName) in the inventory of a spawned animal found by nickname (pawn.inventory, not the transport tracker), so a pack animal draws its pack. Fails when the animal or def is unknown or the stack does not fit.</summary>
        [Given(Prefix + "the animal {string} carries {int} {string} in its pack")]
        public void AnimalCarriesInPack(PickleContext ctx, string nickname, int count, string defName)
        {
            var pawn = AreaOps.SpawnedPawns(Find.CurrentMap).FirstOrDefault(p => p.RaceProps.Animal && p.Name != null && p.Name.ToStringShort == nickname);
            ctx.Require(pawn != null, "No spawned animal named " + nickname);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, "No thing def named " + defName);
            ctx.Require(count >= 1 && count <= def.stackLimit, "count runs from 1 to the stack limit " + def.stackLimit + " of " + defName);
            Thing thing = ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
            thing.stackCount = count;
            ctx.Require(pawn.inventory.innerContainer.TryAdd(thing, count) == count, nickname + "'s inventory did not take " + count + " " + defName);
            ctx.Assert(pawn.inventory.innerContainer.TotalStackCountOfDef(def) >= count, nickname + " does not carry " + count + " " + defName + " after the step");
        }

        private static Pawn AnimalNamed(PickleContext ctx, string nickname)
        {
            Pawn pawn = AreaOps.SpawnedPawns(Find.CurrentMap).FirstOrDefault(p => p.RaceProps.Animal && p.Name != null && p.Name.ToStringShort == nickname);
            ctx.Require(pawn != null, "No spawned animal named " + nickname);
            return pawn;
        }

        // An animal has no apparel tracker until the Animal Apparel Framework (Ingendum) creates it; asked by name, so that no reference to that mod is needed.
        private static void EnsureApparelTracker(PickleContext ctx, Pawn pawn, string nickname)
        {
            if (pawn.apparel == null)
            {
                Type helper = GenTypes.AllTypes.FirstOrDefault(t => t.Name == "AnimalGearHelper");
                helper?.GetMethod("EnsureInitApparelTrackers", System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.Static)?.Invoke(null, new object[] { pawn });
            }

            ctx.Require(pawn.apparel != null, nickname + " has no apparel tracker, even after the framework's EnsureInitApparelTrackers (is a mod that lets animals wear apparel loaded?)");
        }

        /// <summary>
        /// Counts the animals of the current map whose short name is the one given (case ignored), spawned or not (a carried or stowed one counts), logs each
        /// (<c>[animal-count]</c>: name, kind, cell or "not spawned", faction) and asserts there is exactly one. Run it after a spawn step to see a duplicate that
        /// a save already carried (the keep-out step spares every animal of the name). Asked for by AnB, 2026-11-06. Compiled, not played.
        /// </summary>
        [Then(Prefix + "the animals named {string} are counted")]
        public void AnimalsCounted(PickleContext ctx, string name) => CountNamed(ctx, name, 1);

        /// <summary>The same with the number expected given (0 asserts that none is on the map).</summary>
        [Then(Prefix + "the animals named {string} are counted, {int} expected")]
        public void AnimalsCountedExpected(PickleContext ctx, string name, int expected) => CountNamed(ctx, name, expected);

        private static void CountNamed(PickleContext ctx, string name, int expected)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var found = map.mapPawns.AllPawns.Where(p => p.RaceProps.Animal && string.Equals(p.Name?.ToStringShort ?? p.LabelShort, name, StringComparison.OrdinalIgnoreCase)).ToList();
            string lines = string.Join("\n", found.Select(p => name + ": " + p.def.defName + ", " + (p.Spawned ? "cell (" + p.Position.x + ", " + p.Position.z + ")" : "not spawned") + ", faction " + (p.Faction?.Name ?? "none") + ", id " + p.ThingID));
            Log.Message("[animal-count] " + found.Count + " animal(s) named " + name + (found.Count > 0 ? "\n" + lines : string.Empty));
            ctx.Attach("animal-count", found.Count + " animal(s) named " + name + "\n" + lines);
            ctx.Assert(found.Count == expected, found.Count + " animal(s) named '" + name + "' on the map, " + expected + " expected" + (found.Count > 0 ? ":\n" + lines : string.Empty));
        }

        /// <summary>
        /// Takes every garment off a spawned animal found by nickname and redraws it: the bare shot, or the start of an outfit that must begin from nothing
        /// (an animal may wear something in the save). The garments are destroyed (not dropped on its cell, not stowed: an animal has no inventory to give them back
        /// to); the save on disk is not touched. An animal with no apparel tracker has nothing to remove and is left alone. Asked for by Sanctuary Backlot
        /// (Shogun), 2026-11-05. Compiled, not played.
        /// </summary>
        [Given(Prefix + "the animal {string} is undressed")]
        public void AnimalUndressed(PickleContext ctx, string nickname)
        {
            Pawn pawn = AnimalNamed(ctx, nickname);
            if (pawn.apparel != null)
            {
                foreach (Apparel garment in pawn.apparel.WornApparel.ToList())
                {
                    pawn.apparel.Remove(garment);
                    garment.Destroy();
                }
            }

            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            ctx.Assert(pawn.apparel == null || !pawn.apparel.WornApparel.Any(), nickname + " should wear nothing; it wears " + string.Join(", ", pawn.apparel.WornApparel.Select(a => a.def.defName)));
        }

        /// <summary>Puts a new apparel (by defName, made of its default stuff, undyed) on a spawned animal found by nickname, adult or young. Fails when the animal, the def or the apparel tracker is missing, or the game refuses the garment for that body.</summary>
        [Given(Prefix + "the animal {string} is dressed in {string}")]
        public void AnimalDressed(PickleContext ctx, string nickname, string apparelDefName) => Dress(ctx, nickname, apparelDefName, null);

        /// <summary>The same, dyed an HTML colour (#rrggbb): the colour of a collar for a capture.</summary>
        [Given(Prefix + "the animal {string} is dressed in {string} dyed {string}")]
        public void AnimalDressedDyed(PickleContext ctx, string nickname, string apparelDefName, string html) => Dress(ctx, nickname, apparelDefName, html);

        private static void Dress(PickleContext ctx, string nickname, string apparelDefName, string html)
        {
            Pawn pawn = AnimalNamed(ctx, nickname);
            EnsureApparelTracker(ctx, pawn, nickname);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(apparelDefName);
            ctx.Require(def != null && def.IsApparel, "No apparel def named " + apparelDefName);
            Color color = default;
            ctx.Require(html == null || ColorUtility.TryParseHtmlString(html, out color), "'" + html + "' is not an HTML colour");
            var apparel = (Apparel)ThingMaker.MakeThing(def, def.MadeFromStuff ? GenStuff.DefaultStuffFor(def) : null);
            if (html != null)
            {
                apparel.SetColor(color, false);
            }

            pawn.apparel.Wear(apparel, true, false);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();   // the render tree is built before the garment exists: rebuild it so the garment is drawn (Rain, 2026-10-26: worn but not drawn)
            ctx.Assert(pawn.apparel.WornApparel.Contains(apparel), nickname + " should wear '" + apparelDefName + "'; it wears " + string.Join(", ", pawn.apparel.WornApparel.Select(a => a.def.defName)) + "; " + WhyNotWorn(pawn, def));
        }

        // What the game says about this garment on this body, so that a refusal can be read from the failure alone.
        private static string WhyNotWorn(Pawn pawn, ThingDef def)
        {
            string tracker = pawn.apparel == null ? "none" : pawn.apparel.pawn == pawn ? "owned by the animal" : "owned by " + pawn.apparel.pawn;
            string wanted = def.apparel == null ? "no apparel properties" : string.Join(", ", def.apparel.bodyPartGroups.Select(g => g.defName)) + " on layers " + string.Join(", ", def.apparel.layers.Select(l => l.defName));
            string body = string.Join(", ", pawn.RaceProps.body.AllParts.SelectMany(p => p.groups).Select(g => g.defName).Distinct());
            return $"HasPartsToWear {ApparelUtility.HasPartsToWear(pawn, def)}; apparel tracker {tracker}; the garment covers {wanted}; the body of {pawn.def.defName} has the groups {body}";
        }

        /// <summary>Asserts the animal wears the apparel (by defName); the failure lists what it wears.</summary>
        [Then(Prefix + "the animal {string} is wearing {string}")]
        public void AnimalIsWearing(PickleContext ctx, string nickname, string apparelDefName)
        {
            Pawn pawn = AnimalNamed(ctx, nickname);
            ctx.Require(pawn.apparel != null, nickname + " has no apparel tracker");
            ctx.Assert(pawn.apparel.WornApparel.Any(a => a.def.defName == apparelDefName), nickname + " is not wearing '" + apparelDefName + "'; it wears " + string.Join(", ", pawn.apparel.WornApparel.Select(a => a.def.defName)));
        }

        /// <summary>
        /// Asks the game whether the animal's render tree holds a node for the apparel and whether that node resolves a real graphic (not null, not
        /// BadGraphic): the proof that a garment is DRAWN, not only worn. Pieces the game hides on animals have no node by design and fail here.
        /// Promoted 2026-10-18 from Animal Apparel Collars' own step, for Dalmatians Renew's red collar. Not played here.
        /// </summary>
        [Then(Prefix + "the render tree of the animal {string} draws {string}", TimeoutSeconds = 20f)]
        public async Task AnimalRenderTreeDraws(PickleContext ctx, string nickname, string apparelDefName)
        {
            Pawn pawn = AnimalNamed(ctx, nickname);
            await ctx.WaitFrames(5);
            PawnRenderTree tree = pawn.Drawer.renderer.renderTree;
            tree.EnsureInitialized(PawnRenderFlags.None);
            ctx.Require(tree.rootNode != null, nickname + " has no render tree root");
            var found = new System.Collections.Generic.List<PawnRenderNode>();
            var seen = new System.Collections.Generic.List<string>();
            var todo = new System.Collections.Generic.Stack<PawnRenderNode>();
            todo.Push(tree.rootNode);
            while (todo.Count > 0)
            {
                PawnRenderNode node = todo.Pop();
                if (node.apparel != null)
                {
                    seen.Add(node.apparel.def.defName);
                    if (node.apparel.def.defName == apparelDefName)
                    {
                        found.Add(node);
                    }
                }

                if (node.children != null)
                {
                    foreach (PawnRenderNode child in node.children)
                    {
                        todo.Push(child);
                    }
                }
            }

            ctx.Require(found.Count > 0, nickname + " has no render node for '" + apparelDefName + "'; apparel nodes present: " + string.Join(", ", seen));
            foreach (PawnRenderNode node in found)
            {
                Graphic graphic = node.PrimaryGraphic;
                ctx.Require(graphic != null && graphic != BaseContent.BadGraphic, "the render node of '" + apparelDefName + "' on " + nickname + " resolves no graphic (" + (graphic == null ? "null" : "BadGraphic") + ")");
            }
        }

        private static void Spawn(PickleContext ctx, string kindName, string nickname, int x, int z, int stageIndex, string stageDefName, Gender? sex = null)
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

            Pawn pawn = PawnGenerator.GeneratePawn(sex.HasValue ? new PawnGenerationRequest(kind, Faction.OfPlayer, fixedGender: sex.Value) : new PawnGenerationRequest(kind, Faction.OfPlayer));
            // Half-way into the stage, or a quarter year past the start of the last one.
            float years = index == stages.Count - 1 ? stages[index].minAge + 0.25f : (stages[index].minAge + stages[index + 1].minAge) * 0.5f;
            if (index == 0 && stages.Count > 1) years = Math.Min(years, stages[1].minAge * 0.5f);
            long ticks = (long)(years * TicksPerYear);
            pawn.ageTracker.AgeBiologicalTicks = ticks;
            pawn.ageTracker.AgeChronologicalTicks = ticks;
            pawn.Name = new NameSingle(nickname);
            GenSpawn.Spawn(pawn, cell, map);
            ctx.Require(pawn.ageTracker.CurLifeStageIndex == index, nickname + " is at life stage " + pawn.ageTracker.CurLifeStageIndex + " instead of " + index);
            ctx.Assert(!sex.HasValue || pawn.gender == sex.Value, nickname + " is " + pawn.gender + " instead of " + sex + " (a kind with no sex of its own cannot honour the request)");
        }
    }
}
