using System;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    [PickleSteps]
    public partial class StudioSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private const int CX = 125, CZ = 125, Radius = 90;
        private bool? originalScreenshotMode;
        private bool[] originalOverlays;
        private bool? originalColonistBar, originalLearningHelper;
        private static readonly Color Amber = new Color(0.90f, 0.51f, 0.08f);
        private static readonly Color Dark = new Color(0.22f, 0.15f, 0.10f);
        private static T Def<T>(string name) where T : Def => DefDatabase<T>.GetNamed(name);
        private static IntVec3 Cell(int x, int z) => new IntVec3(CX + x, 0, CZ + z);

        [When(Prefix + "I frame the studio {string}")]
        public async Task Frame(PickleContext ctx, string shot)
        {
            int x = 0, z = 0; float size;
            switch (shot)
            {
                case "overview": size = 45; break;
                case "emblem": size = 20; break;
                case "workshop": x = -29; size = 12; break;
                case "kitchen": x = 29; size = 12; break;
                case "home": z = 29; size = 12; break;
                case "display": z = -29; size = 12; break;
                case "flowers": x = 29; z = -27; size = 12; break;
                case "pond": x = 28; z = 27; size = 16; break;
                case "zen": x = -28; z = 27; size = 15; break;
                default: throw new ArgumentException("Unknown studio shot: " + shot);
            }
            Find.Selector.ClearSelection();
            Find.CameraDriver.JumpToCurrentMapLoc(Cell(x,z));
            Find.CameraDriver.SetRootSize(size);
            await ctx.WaitFrames(3);
        }

        // The game keeps the camera root size between 11 and 60 (CameraMapConfig.sizeRange); SimpleCameraSetting and Camera+ widen it the same way. A tighter or wider frame needs the range widened first.
        private static void LiftZoomLimit()
        {
            object config = Find.CameraDriver?.config;
            var field = config?.GetType().GetField("sizeRange");
            if (field != null && field.FieldType == typeof(FloatRange)) field.SetValue(config, new FloatRange(2f, 130f));
            else Log.Warning("[frame] CameraMapConfig.sizeRange not found: the zoom stays limited to the game's own range");
        }

        // Pickle's own "I wait {int} ticks" keeps the default 5 s step deadline: on a loaded machine 800 to 1000 ticks overrun it (ACertainSeries gallery runs f885, bdf1). Same wait, long deadline.
        [When(Prefix + "I let {int} ticks pass", TimeoutSeconds = 240f)]
        public async Task LetTicksPass(PickleContext ctx, int ticks)
        {
            // Not ctx.WaitTicks: after Pickle's own "I wait N ticks" the game stayed paused and this wait never ended (ACertainSeries run 9b0c, 240 s for 208 ticks).
            // The game is set to its fastest speed, the tick counter is awaited, and the speed it had is put back.
            var tm = Find.TickManager;
            TimeSpeed before = tm.CurTimeSpeed;
            int target = tm.TicksGame + ticks;
            tm.CurTimeSpeed = TimeSpeed.Ultrafast;
            try { await ctx.WaitUntil(() => Find.TickManager.TicksGame >= target, 235f); }
            finally { Find.TickManager.CurTimeSpeed = before; }
        }

        // Any map: centre the camera on the rectangle and take the smallest root size that holds it whole (1080p frame: 2N cells tall, about 3.56N wide), plus one cell of margin on each side.
        [When(Prefix + "I frame the rectangle from \\({int}, {int}\\) to \\({int}, {int}\\)", TimeoutSeconds = 60f)]
        public async Task FrameRectangle(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            ctx.Require(Find.CurrentMap != null, "Load a map first");
            if (Find.CurrentMap.Size.x >= 250 && Find.CurrentMap.Size.z >= 250)
                Log.Warning("[frame] rectangle on the Sanctuary map: a suite names a place (Nelim's Sanctuary: I frame the sanctuary \"...\") and writes no coordinate. Add the place to SanctuaryBacklot or document why a raw rectangle is needed.");
            int minX = Math.Min(x1, x2), maxX = Math.Max(x1, x2), minZ = Math.Min(z1, z2), maxZ = Math.Max(z1, z2);
            float w = maxX - minX + 1 + 2, h = maxZ - minZ + 1 + 2;
            float size = Math.Max(h / 2f, w / 3.56f);
            LiftZoomLimit();
            Find.Selector.ClearSelection();
            Find.CameraDriver.JumpToCurrentMapLoc(new IntVec3((minX + maxX) / 2, 0, (minZ + maxZ) / 2));
            Find.CameraDriver.SetRootSize(size);
            await ctx.WaitFrames(90);
            Log.Message("[frame] rectangle (" + minX + ", " + minZ + ") to (" + maxX + ", " + maxZ + "): root size " + size.ToString("0.0") + ", camera at " + Find.CameraDriver.MapPosition);
        }

        // A flower border around a free square, for the photographs: two to four cells wide, thinning outwards, the square itself untouched.
        // Cells that hold a building, water or soil that grows nothing are skipped; an existing plant on a chosen cell is replaced.
        [Given(Prefix + "a flower border is planted around the square from \\({int}, {int}\\) to \\({int}, {int}\\)")]
        public void FlowerBorder(PickleContext ctx, int x1, int z1, int x2, int z2)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            string[] kinds = { "Plant_Dandelion", "Plant_Dandelion", "Plant_Daylily", "Plant_Rose" };

            for (int x = x1 - 4; x <= x2 + 4; x++)
                for (int z = z1 - 4; z <= z2 + 4; z++)
                {
                    int d = Math.Max(Math.Max(x1 - x, x - x2), Math.Max(z1 - z, z - z2));   // 1 = the ring touching the square
                    if (d < 1 || d > 4) continue;
                    if (Rand.Value > (d <= 2 ? 0.75f : 0.40f)) continue;
                    var c = new IntVec3(x, 0, z);
                    if (!c.InBounds(map) || c.GetFirstBuilding(map) != null || c.GetFirstItem(map) != null) continue;
                    var def = Def<ThingDef>(kinds[Rand.Range(0, kinds.Length)]);
                    if (c.GetTerrain(map).fertility <= 0f || c.GetTerrain(map).IsWater) continue;
                    var old = c.GetPlant(map);
                    if (old != null) old.Destroy();
                    var p = (Plant)ThingMaker.MakeThing(def);
                    p.Growth = 1f;
                    GenSpawn.Spawn(p, c, map);
                }
        }

        // Sends every animal on the map away (despawned, not killed): for a frame wider than a place's own area, or a place the animals keep wandering back to.
        [When(Prefix + "I remove all animals")]
        public void RemoveAllAnimals_Alt(PickleContext ctx) { RemoveAllAnimals(ctx); }
        [Given(Prefix + "all animals are removed")]
        public void RemoveAllAnimals(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            foreach (var a in map.mapPawns.AllPawnsSpawned.Where(p => p.RaceProps.Animal).ToList()) a.DeSpawn();
        }

        // Moves the player's colonists (Nelim) to a far corner of the map, for a frame that must hold only the set. They are not removed: they are
        // standing there when the scenario goes on. Pawns that cannot be placed stay where they are.
        [When(Prefix + "I send the colonists to the map corner")]
        public void SendColonistsAway_Alt(PickleContext ctx) { SendColonistsAway(ctx); }
        [Given(Prefix + "the colonists are sent to the map corner")]
        public void SendColonistsAway(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var corners = new[] { new IntVec3(4, 0, 4), new IntVec3(map.Size.x - 5, 0, 4), new IntVec3(4, 0, map.Size.z - 5), new IntVec3(map.Size.x - 5, 0, map.Size.z - 5) };
            foreach (var pawn in map.mapPawns.FreeColonistsSpawned.ToList())
            {
                IntVec3 cell = IntVec3.Invalid;
                foreach (var corner in corners)
                    if (CellFinder.TryFindRandomCellNear(corner, map, 40, c => c.Standable(map) && c.GetFirstPawn(map) == null, out cell)) break;
                ctx.Require(cell.IsValid, "No free standable cell near any map corner for " + pawn.LabelShort);
                pawn.jobs?.StopAll();
                pawn.pather?.StopDead();
                pawn.Position = cell;
                pawn.Notify_Teleported();
                Log.Message("[colonists away] " + pawn.LabelShort + " moved to (" + cell.x + ", " + cell.z + ")");
            }
        }

        // Lets the game build its power nets now. A loaded or freshly spawned map holds its connections as pending work that only a tick would do, and the
        // scenes run paused; connecting components by hand on top of that registers them twice, so the game is asked to do it itself.
        // A building spawned next to a transmitter by a scene is usually connected on spawn; this makes it certain, and a net that still
        // shows the unpowered icon after it is a real shortage (the supply is lower than the demand), not a missing connection.
        [Given(Prefix + "the power network is refreshed")]
        public async Task RefreshPower(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            map.powerNetManager.UpdatePowerNetsAndConnections_First();
            await ctx.WaitFrames(3);
        }

        // Two checks for what a mod does at load without a screen to read it from: a window of a given type on the stack, and a collection kept by a
        // world component. Both look by the type's simple name (the window) or full name (the component), so a scenario names what it means.
        [Then(Prefix + "no window of the type {string} is open")]
        public void NoWindowOfType(PickleContext ctx, string typeName)
        {
            var open = Find.WindowStack.Windows.Where(w => w.GetType().Name == typeName).ToList();
            ctx.Assert(open.Count == 0, "The window " + typeName + " is open (" + open.Count + ")");
        }

        [Then(Prefix + "the world component {string} holds at least {int} entries in its field {string}")]
        public void WorldComponentEntries(PickleContext ctx, string typeName, int atLeast, string field)
        {
            var comp = Find.World.components.FirstOrDefault(c => c.GetType().FullName == typeName);
            ctx.Require(comp != null, "No world component " + typeName + "; found: " + string.Join(", ", Find.World.components.Select(c => c.GetType().FullName).Where(n => n.IndexOf("Faction", StringComparison.OrdinalIgnoreCase) >= 0)));
            var f = comp.GetType().GetField(field, System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic);
            ctx.Require(f != null, "No field " + field + " on " + typeName);
            var value = f.GetValue(comp) as System.Collections.IEnumerable;
            int n = 0; if (value != null) foreach (var _ in value) n++;
            ctx.Assert(n >= atLeast, typeName + "." + field + " holds " + n + " entries, expected at least " + atLeast);
        }

        // Makes the map a one-colonist map: every humanlike pawn but the named one, and every humanlike corpse, vanishes. Animals stay.
        [Given(Prefix + "all humans but {string} are removed")]
        public void RemoveOtherHumans(PickleContext ctx, string keep)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            ctx.Require(map.mapPawns.AllPawnsSpawned.Any(p => p.Name != null && p.Name.ToStringShort == keep), "No pawn named " + keep + " on the map");
            foreach (var p in map.mapPawns.AllPawnsSpawned.Where(p => p.RaceProps.Humanlike && (p.Name == null || p.Name.ToStringShort != keep)).ToList()) p.Destroy(DestroyMode.Vanish);
            foreach (var c in map.listerThings.AllThings.OfType<Corpse>().Where(c => c.InnerPawn != null && c.InnerPawn.RaceProps.Humanlike).ToList()) c.Destroy(DestroyMode.Vanish);
            ctx.Assert(map.mapPawns.AllPawnsSpawned.Count(p => p.RaceProps.Humanlike) == 1, "Expected one human left");
        }

        // Tidies the map: every haulable item that lies outside a stockpile or a storage building is merged into full stacks and put into the
        // stockpile zones. Nothing is deleted; the stockpile must have room.
        [Given(Prefix + "all loose items are put away")]
        public void PutAwayLooseItems(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            var cells = map.zoneManager.AllZones.OfType<Zone_Stockpile>().SelectMany(z => z.Cells).ToList();
            ctx.Require(cells.Count > 0, "The map has no stockpile zone to put items into");
            var loose = map.listerThings.AllThings.Where(t => t.def.category == ThingCategory.Item && t.Spawned && t.def.EverHaulable
                && map.haulDestinationManager.SlotGroupAt(t.Position) == null).ToList();
            var toPlace = new System.Collections.Generic.List<Thing>();
            foreach (var g in loose.GroupBy(t => t.def))
            {
                var kept = new System.Collections.Generic.List<Thing>();
                foreach (var t in g)
                {
                    bool merged = false;
                    foreach (var s in kept)
                        if (s.stackCount < s.def.stackLimit && s.CanStackWith(t)) { s.TryAbsorbStack(t, true); if (t.Destroyed || t.stackCount <= 0) { merged = true; break; } }
                    if (!merged && !t.Destroyed) kept.Add(t);
                }
                toPlace.AddRange(kept);
            }
            var free = new System.Collections.Generic.Queue<IntVec3>(cells.Where(c => c.GetFirstItem(map) == null && c.GetFirstBuilding(map) == null));
            ctx.Require(free.Count >= toPlace.Count, "The stockpiles have " + free.Count + " free cells for " + toPlace.Count + " stacks");
            foreach (var t in toPlace)
            {
                if (t.Spawned) t.DeSpawn();
                GenPlace.TryPlaceThing(t, free.Dequeue(), map, ThingPlaceMode.Direct);
            }
            int left = map.listerThings.AllThings.Count(t => t.def.category == ThingCategory.Item && t.Spawned && t.def.EverHaulable && map.haulDestinationManager.SlotGroupAt(t.Position) == null);
            ctx.Assert(left == 0, left + " items are still outside a stockpile (" + toPlace.Count + " stacks were placed)");
        }

        // Sets a colonist's food need to full.
        [Given(Prefix + "the pawn {string} is fully fed")]
        public void FullyFed(PickleContext ctx, string name)
        {
            var p = Find.CurrentMap.mapPawns.AllPawnsSpawned.FirstOrDefault(x => x.Name != null && x.Name.ToStringShort == name);
            ctx.Require(p != null && p.needs != null && p.needs.food != null, "No pawn named " + name + " with a food need");
            p.needs.food.CurLevel = p.needs.food.MaxLevel;
        }

        // Removes every piece of filth on the map (blood, dirt, ash, vomit, insect jelly): it only spoils the photographs.
        [Given(Prefix + "all filth is cleaned")]
        public void CleanFilth(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            foreach (var f in map.listerThings.AllThings.OfType<Filth>().ToList()) if (!f.Destroyed) f.Destroy();
            ctx.Assert(!map.listerThings.AllThings.OfType<Filth>().Any(), "Some filth is still on the map");
        }

        // Puts the research tree back to nothing researched: the Sanctuaire is a blank colony, so a mod that tests a research gate sees the gate.
        [Given(Prefix + "all research is reset")]
        public void ResetResearch(PickleContext ctx)
        {
            Find.ResearchManager.ResetAllProgress();
            ctx.Assert(!DefDatabase<ResearchProjectDef>.AllDefsListForReading.Any(r => r.IsFinished && r.baseCost > 0f), "Some research is still finished");
        }

        // Interface kept (a menu capture), but without the colonist bar at the top centre (it shows the colonist's name and portrait).
        [When(Prefix + "I hide the colonist bar")]
        public void HideColonistBar_Alt(PickleContext ctx) { HideColonistBar(ctx); }
        [Given(Prefix + "the colonist bar is hidden")]
        public void HideColonistBar(PickleContext ctx)
        {
            if (!originalColonistBar.HasValue) originalColonistBar = Find.PlaySettings.showColonistBar;
            Find.PlaySettings.showColonistBar = false;
            // The bar draws from a cached list that only rebuilds when it is marked dirty: the flag alone leaves it on screen.
            Find.ColonistBar?.MarkColonistsDirty();
        }

        private static void ClearActiveConcepts()
        {
            var readout = Find.Tutor?.learningReadout;
            var field = readout == null ? null : typeof(LearningReadout).GetField("activeConcepts", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public);
            var value = field?.GetValue(readout);
            if (value is System.Collections.IList list) list.Clear();
            else if (value is System.Collections.IDictionary dict) dict.Clear();
        }

        // Interface kept, but without the mouse-over tooltips (a hover left on the subject). Needs Harmony; without it the scenario goes on with a warning.
        [When(Prefix + "I hide the tooltips")]
        public void HideTooltips_Alt(PickleContext ctx) { HideTooltips(ctx); }
        [Given(Prefix + "the tooltips are hidden")]
        public void HideTooltips(PickleContext ctx)
        {
            try { OverlaySuppression.HideTooltips(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[tooltips] stay drawn: Harmony is not loaded"); }
        }

        // Interface kept (tabs, buttons), but without the resource list on the left.
        [When(Prefix + "I hide the resource readout")]
        public void HideResourceReadout_Alt(PickleContext ctx) { HideResourceReadout(ctx); }
        [Given(Prefix + "the resource readout is hidden")]
        public void HideResourceReadout(PickleContext ctx)
        {
            try { OverlaySuppression.HideReadout(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[readout] stays drawn: Harmony is not loaded"); }
        }

        // Interface kept (tabs, buttons), but without the alert boxes at the bottom right.
        [When(Prefix + "I hide the alerts")]
        public void HideAlerts_Alt(PickleContext ctx) { HideAlerts(ctx); }
        [Given(Prefix + "the alerts are hidden")]
        public void HideAlerts(PickleContext ctx)
        {
            try { OverlaySuppression.HideAlerts(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[alerts] stay drawn: Harmony is not loaded"); }
        }

        // The white brackets the game draws around the selected thing. The selection stays (the inspect pane and its tab stay open).
        [When(Prefix + "I hide the selection brackets")]
        public void HideSelectionBrackets_Alt(PickleContext ctx) { HideSelectionBrackets(ctx); }
        [Given(Prefix + "the selection brackets are hidden")]
        public void HideSelectionBrackets(PickleContext ctx)
        {
            try { OverlaySuppression.HideBrackets(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[brackets] stay drawn: Harmony is not loaded"); }
        }

        // The stack counts under items and the name labels under pawns, without the screenshot mode (so the interface stays).
        [When(Prefix + "I hide the item and name labels")]
        public void HideNameLabels_Alt(PickleContext ctx) { HideNameLabels(ctx); }
        [Given(Prefix + "the item and name labels are hidden")]
        public void HideNameLabels(PickleContext ctx)
        {
            try { OverlaySuppression.Begin(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[labels] stay drawn: Harmony is not loaded"); }
        }

        // Interface kept, but without the learning helper's tip boxes (top right).
        [When(Prefix + "I hide the learning helper")]
        public void HideLearningHelper_Alt(PickleContext ctx) { HideLearningHelper(ctx); }
        [Given(Prefix + "the learning helper is hidden")]
        public void HideLearningHelper(PickleContext ctx)
        {
            if (!originalLearningHelper.HasValue) originalLearningHelper = Find.PlaySettings.showLearningHelper;
            Find.PlaySettings.showLearningHelper = false;
            // Without the patch a concept the game activates later (camera dolly, bills tab...) brings the box back: the readout shows itself while any concept is active.
            try { OverlaySuppression.HideHelper(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[learning helper] new cards are not blocked: Harmony is not loaded"); }
            ClearActiveConcepts();
        }

        [When(Prefix + "studio presentation mode is enabled")]
        public async Task Presentation(PickleContext ctx)
        {
            if (!originalScreenshotMode.HasValue) originalScreenshotMode = Find.UIRoot.screenshotMode.Active;
            Find.UIRoot.screenshotMode.Active = true;
            // Stack counts and name labels: no setting in the game, so a patch skips them. Without Harmony the scenario goes on and says so.
            try { OverlaySuppression.Begin(); }
            catch (Exception e) when (e is System.IO.FileNotFoundException || e is TypeLoadException || e is TypeInitializationException) { Log.Warning("[presentation] stack counts and name labels stay drawn: Harmony is not loaded (" + e.GetType().Name + ")"); }
            // Overlays the interface switch leaves on the map: zone markers, beauty and room numbers, the learning helper.
            if (originalOverlays == null) originalOverlays = new[] { Find.PlaySettings.showZones, Find.PlaySettings.showBeauty, Find.PlaySettings.showRoomStats, Find.PlaySettings.showLearningHelper };
            Find.PlaySettings.showZones = false; Find.PlaySettings.showBeauty = false; Find.PlaySettings.showRoomStats = false; Find.PlaySettings.showLearningHelper = false;
            await ctx.WaitFrames(2);
        }

        [AfterScenario]
        public void RestoreInterface()
        {
            if (originalScreenshotMode.HasValue && Find.UIRoot != null)
                Find.UIRoot.screenshotMode.Active = originalScreenshotMode.Value;
            originalScreenshotMode = null;
            OverlaySuppression.End();
            if (originalColonistBar.HasValue && Find.PlaySettings != null) { Find.PlaySettings.showColonistBar = originalColonistBar.Value; Find.ColonistBar?.MarkColonistsDirty(); }
            if (originalLearningHelper.HasValue && Find.PlaySettings != null) Find.PlaySettings.showLearningHelper = originalLearningHelper.Value;
            originalColonistBar = null; originalLearningHelper = null;
            if (originalOverlays != null && Find.PlaySettings != null)
            {
                var o = originalOverlays;
                Find.PlaySettings.showZones = o[0]; Find.PlaySettings.showBeauty = o[1]; Find.PlaySettings.showRoomStats = o[2]; Find.PlaySettings.showLearningHelper = o[3];
            }
            originalOverlays = null;
        }
    }
}
