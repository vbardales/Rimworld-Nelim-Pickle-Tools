using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps about the things a colonist can use: carry some in the inventory, forbid or allow a thing on a cell, and say why a colonist
    /// does not take a thing for joy. Written 2026-10-12 for Fullzoon Cookies Renew (a joy giver that refuses a spawned cookie), the owner
    /// asking for them in the shared tools. Not played.
    /// </summary>
    [PickleSteps]
    public class ItemSteps
    {
        /// <summary>
        /// Puts N things of a def (by defName) in the colonist's inventory, made of the def's default stuff. Fails when the colonist or the
        /// def is unknown or the inventory refuses the count (the message says how many went in). Several stacks are made when the count
        /// exceeds the stack limit. A joy giver that looks first in the inventory (<c>JoyGiver_Ingest</c>) finds them there.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} carries {int} {string}")]
        public void Carries(PickleContext ctx, string nickname, int count, string defName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            ctx.Require(count > 0, "the count is 1 or more");
            ctx.Require(pawn.inventory != null, $"{nickname} has no inventory");
            int left = count;
            while (left > 0)
            {
                int n = System.Math.Min(left, def.stackLimit);
                Thing thing = ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def));
                thing.stackCount = n;
                int added = pawn.inventory.innerContainer.TryAdd(thing, n);
                ctx.Assert(added == n, $"{nickname}'s inventory took {count - left + added} of the {count} {defName}");
                left -= n;
            }
        }

        private static readonly List<Pawn> Holders = new List<Pawn>();

        /// <summary>
        /// Makes one thing of a def (by defName, made of its default stuff) and puts it in the colonist's hands (the carry tracker, drawn in the
        /// hand, not in the inventory). The colonist must carry nothing yet and be spawned on a map. The thing is destroyed at the end of the
        /// scenario. Written 2026-11-08 for AnimalCosmeticGenes (a serum in Nelim's hand, shot 4). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} holds {string} in hand")]
        public void HoldsInHand(PickleContext ctx, string nickname, string defName) => HoldInHand(ctx, nickname, defName, null, null);

        /// <summary>
        /// The same, and before it is held the named field of the thing (or, if the thing has none of that name, of one of its comps) is set from a
        /// text: a def field takes the def of that name (by its field type), a text field the text, a number, a flag or an enum the parsed value.
        /// Public and private instance fields are found, base classes included. Fails when no field of that name exists or the value does not fit.
        /// For a thing that carries a def in a field, such as a serum that holds a gene (<c>gene</c>). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} holds {string} in hand set with the field {string} to {string}")]
        public void HoldsInHandWithField(PickleContext ctx, string nickname, string defName, string field, string value) => HoldInHand(ctx, nickname, defName, field, value);

        private static void HoldInHand(PickleContext ctx, string nickname, string defName, string field, string value)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            ctx.Require(pawn.Spawned && pawn.Map != null, $"{nickname} is not spawned on a map");
            ctx.Require(pawn.carryTracker != null, $"{nickname} has no carry tracker");
            ctx.Require(pawn.carryTracker.CarriedThing == null, $"{nickname} already carries {pawn.carryTracker.CarriedThing?.LabelCap}");
            Thing thing = ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def));
            if (field != null)
            {
                SetField(ctx, thing, field, value);
            }

            bool added = pawn.carryTracker.innerContainer.TryAdd(thing, 1) == 1;
            ctx.Assert(added && pawn.carryTracker.CarriedThing == thing, $"{nickname}'s hands did not take '{defName}'");
            Holders.Add(pawn);
        }

        private static void SetField(PickleContext ctx, Thing thing, string field, string value)
        {
            const System.Reflection.BindingFlags flags = System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic;
            var targets = new List<object> { thing };
            if (thing is ThingWithComps withComps)
            {
                targets.AddRange(withComps.AllComps.Cast<object>());
            }

            foreach (object target in targets)
            {
                for (System.Type type = target.GetType(); type != null; type = type.BaseType)
                {
                    System.Reflection.FieldInfo info = type.GetField(field, flags | System.Reflection.BindingFlags.DeclaredOnly);
                    if (info == null)
                    {
                        continue;
                    }

                    object parsed;
                    if (typeof(Def).IsAssignableFrom(info.FieldType))
                    {
                        parsed = GenDefDatabase.GetDef(info.FieldType, value, false);
                        ctx.Require(parsed != null, $"no {info.FieldType.Name} named '{value}' for the field '{field}'");
                    }
                    else if (info.FieldType == typeof(string))
                    {
                        parsed = value;
                    }
                    else if (info.FieldType.IsEnum)
                    {
                        parsed = System.Enum.Parse(info.FieldType, value, true);
                    }
                    else
                    {
                        parsed = System.Convert.ChangeType(value, info.FieldType, System.Globalization.CultureInfo.InvariantCulture);
                    }

                    info.SetValue(target, parsed);
                    return;
                }
            }

            ctx.Require(false, $"'{thing.def.defName}' and its comps have no field named '{field}'");
        }

        [AfterScenario]
        public void DropHeldThings(PickleContext ctx)
        {
            foreach (Pawn pawn in Holders)
            {
                if (!pawn.Destroyed && pawn.carryTracker != null)
                {
                    pawn.carryTracker.innerContainer.ClearAndDestroyContents();
                }
            }

            Holders.Clear();
        }

        /// <summary>
        /// Puts N things of a def (by defName, made of its default stuff) on the ground at a cell, as one stack when N fits the stack limit and as
        /// several stacks next to each other otherwise (the game finds the nearest free cells). Fails when the def is unknown, the cell is outside
        /// the map, or a stack cannot be placed. Written 2026-10-25 for GeniusesCraftFastRenew (a stack of N on a bench). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {int} of the item {string} are spawned at \\({int}, {int}\\)")]
        public void SpawnedStack(PickleContext ctx, int count, string defName, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            ctx.Require(count > 0, "the count is 1 or more");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            int left = count;
            while (left > 0)
            {
                int n = System.Math.Min(left, def.stackLimit);
                Thing thing = ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def));
                thing.stackCount = n;
                GenPlace.TryPlaceThing(thing, cell, map, ThingPlaceMode.Near);
                ctx.Assert(thing.Spawned || thing.Destroyed, $"a stack of {n} {defName} could not be placed near ({x}, {z})");
                left -= n;
            }
        }

        /// <summary>Forbids the first thing of a def (by defName) on a cell of the current map.</summary>
        [Given("Nelim's Pickle Tools: the thing {string} at \\({int}, {int}\\) is forbidden")]
        public void Forbidden(PickleContext ctx, string defName, int x, int z)
        {
            SetForbidden(ctx, defName, x, z, true);
        }

        /// <summary>Allows (clears the forbidden flag of) the first thing of a def on a cell of the current map.</summary>
        [Given("Nelim's Pickle Tools: the thing {string} at \\({int}, {int}\\) is not forbidden")]
        public void NotForbidden(PickleContext ctx, string defName, int x, int z)
        {
            SetForbidden(ctx, defName, x, z, false);
        }

        /// <summary>
        /// Logs, test by test, why a colonist can or cannot take the first thing of a def on a cell for joy: the thing is ingestible, has
        /// a joy value and a joy kind, is forbidden for the colonist or not, the colonist is willing to eat it, can reserve it and can
        /// reach it, and the colonist's tolerance for that joy kind. Never fails: the verdict is in the log (lines starting
        /// <c>[joy]</c>), for a scenario that is red and says nothing about the cause.
        /// </summary>
        [Given("Nelim's Pickle Tools: the reasons why {string} cannot take {string} at \\({int}, {int}\\) for joy are logged")]
        public void WhyNotForJoy(PickleContext ctx, string nickname, string defName, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Thing thing = ThingAt(ctx, defName, x, z);
            var lines = new List<string>
            {
                $"ingestible: {thing.def.IsIngestible}",
                $"joy: {thing.def.ingestible?.joy}, joy kind: {thing.def.ingestible?.joyKind?.defName ?? "none"}",
                $"forbidden for {nickname}: {thing.IsForbidden(pawn)} (flag on the thing: {thing.IsForbidden(Faction.OfPlayer)})",
                $"{nickname} will eat it: {pawn.WillEat(thing)}",
                $"{nickname} can reserve it: {pawn.CanReserve(thing)}",
                $"{nickname} can reach it: {pawn.CanReach(thing, PathEndMode.OnCell, Danger.None)}",
            };
            FoodPolicy policy = pawn.foodRestriction?.CurrentFoodPolicy;
            lines.Add(policy == null
                ? $"{nickname} follows no food policy"
                : $"{nickname}'s food policy: '{policy.label}' (id {policy.id}), allows {thing.def.defName}: {policy.filter.Allows(thing.def)}");
            JoyKindDef kind = thing.def.ingestible?.joyKind;
            if (kind != null && pawn.needs?.joy != null)
            {
                lines.Add($"tolerance for {kind.defName}: {pawn.needs.joy.tolerances[kind]}");
            }

            Log.Message("[joy] " + string.Join("; ", lines));
        }

        /// <summary>
        /// Asks a joy giver (a JoyGiverDef, by defName) directly what it would do for a colonist, and logs it (lines starting <c>[joy-giver]</c>), without
        /// starting the job: the def is loaded, its worker can be given to the colonist (required capacities, outdoors, the joy kind), the colonist's
        /// tolerance for the kind and whether bored of it, the joy level, and the job the worker returns (the job def, or none). Never fails on a
        /// verdict, only when the colonist is unknown; for a scenario that is red because a colonist never takes the joy job.
        /// </summary>
        [Given("Nelim's Pickle Tools: the joy giver {string} is asked what it would give {string}")]
        public void JoyGiverAsked(PickleContext ctx, string giverDefName, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            JoyGiverDef giver = DefDatabase<JoyGiverDef>.GetNamedSilentFail(giverDefName);
            Log.Message($"[joy-giver] {giverDefName} loaded: {giver != null}");
            if (giver == null)
            {
                return;
            }

            JoyKindDef kind = giver.joyKind;
            Log.Message($"[joy-giver] worker {giver.Worker?.GetType().Name ?? "none"}; joy kind {kind?.defName ?? "none"}");
            Log.Message($"[joy-giver] CanBeGivenTo {nickname}: {Try(() => giver.Worker.CanBeGivenTo(pawn))}");
            if (kind != null && pawn.needs?.joy != null)
            {
                Log.Message($"[joy-giver] tolerance for {kind.defName}: {pawn.needs.joy.tolerances[kind]}; bored of it: {pawn.needs.joy.tolerances.BoredOf(kind)}");
            }

            Log.Message($"[joy-giver] joy level of {nickname}: {pawn.needs?.joy?.CurLevel.ToString("0.000") ?? "no joy need"}");
            Log.Message($"[joy-giver] {nickname} in bed: {Try(() => pawn.InBed())}; {(pawn.InBed() ? "TryGiveJobWhileInBed" : "TryGiveJob")}: {Try(() => GiveJob(pawn, giver)?.def.defName ?? "null")}");
            Log.Message("[joy-giver] " + WatchLines(pawn, giver));
        }

        /// <summary>
        /// Takes the job a joy giver (a JoyGiverDef, by defName) returns for a colonist and starts it on them by force (StartJob, interrupt
        /// forced, so it replaces what they do), and logs the job taken (lines starting <c>[joy-giver]</c>). Fixes the giver's job, for a scenario
        /// that must not depend on the game's random pick between joy givers. Fails when the def is unknown, the colonist has no job tracker, or
        /// the giver returns no job.
        /// </summary>
        [Given("Nelim's Pickle Tools: the joy giver {string} job is forced on {string}")]
        public void JoyGiverJobForced(PickleContext ctx, string giverDefName, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            JoyGiverDef giver = DefDatabase<JoyGiverDef>.GetNamedSilentFail(giverDefName);
            ctx.Require(giver != null, $"no joy giver '{giverDefName}'");
            ctx.Require(pawn.jobs != null, $"{nickname} has no job tracker");
            Job job = GiveJob(pawn, giver);
            ctx.Require(job != null, $"joy giver {giverDefName} gives no job to {nickname}{(pawn.InBed() ? " (in bed: TryGiveJobWhileInBed)" : string.Empty)}; " + WhyNoJoyJob(pawn, giver) + WatchLines(pawn, giver));
            pawn.jobs.StartJob(job, JobCondition.InterruptForced);
            Log.Message($"[joy-giver] forced {job.def.defName} on {nickname} from {giverDefName}; current job now {pawn.CurJob?.def.defName ?? "none"}");
        }


        /// <summary>
        /// Asserts a joy giver (a JoyGiverDef, by defName) returns no job for a colonist, asked the way the game asks: <c>TryGiveJobWhileInBed</c> when the
        /// colonist lies in a bed, <c>TryGiveJob</c> otherwise. Never starts the job. For "no use through a wall". Written 2026-11-10 for RetroJoyRenew.
        /// Compiled, NOT PLAYED.
        /// </summary>
        [Then("Nelim's Pickle Tools: the joy giver {string} gives no job to {string}")]
        public void JoyGiverGivesNoJob(PickleContext ctx, string giverDefName, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            JoyGiverDef giver = DefDatabase<JoyGiverDef>.GetNamedSilentFail(giverDefName);
            ctx.Require(giver != null, $"no joy giver '{giverDefName}'");
            Job job = GiveJob(pawn, giver);
            ctx.Assert(job == null, $"joy giver {giverDefName} gives {job?.def.defName} to {nickname}, none was expected; " + WatchLines(pawn, giver));
        }

        // The game asks a pawn lying in a bed for TryGiveJobWhileInBed (watching a building from the bed needs no chair), any other pawn for TryGiveJob.
        private static Job GiveJob(Pawn pawn, JoyGiverDef giver)
        {
            return pawn.InBed() ? giver.Worker.TryGiveJobWhileInBed(pawn) : giver.Worker.TryGiveJob(pawn);
        }

        // For a building giver: where the pawn is (its bed spot when in bed) and whether each building could be watched from there, with the watch cells.
        private static string WatchLines(Pawn pawn, JoyGiverDef giver)
        {
            if (giver.thingDefs == null || pawn.Map == null) return string.Empty;
            var sb = new System.Text.StringBuilder($"pawn at {pawn.Position}, in bed {Try(() => pawn.InBed())}, bed {Try(() => pawn.CurrentBed()?.Position.ToString() ?? "none")}; ");
            sb.Append("capacities: " + Try(() => string.Join(", ", new[] { PawnCapacityDefOf.Consciousness, PawnCapacityDefOf.Sight, PawnCapacityDefOf.Manipulation, PawnCapacityDefOf.Moving }.Select(c => c.defName + " " + pawn.health.capacities.GetLevel(c).ToString("0.00") + " (capable " + pawn.health.capacities.CapableOf(c) + ")"))) + "; ");
            sb.Append("giver requiredCapacities: " + Try(() => giver.requiredCapacities == null || giver.requiredCapacities.Count == 0 ? "none" : string.Join(", ", giver.requiredCapacities.Select(c => c.defName + " capable " + pawn.health.capacities.CapableOf(c)))) + "; ");
            sb.Append($"joy kind {giver.joyKind?.defName ?? "none"} tolerance {Try(() => pawn.needs.joy.tolerances[giver.joyKind].ToString("0.000"))} bored {Try(() => pawn.needs.joy.tolerances.BoredOf(giver.joyKind))}; ");
            foreach (ThingDef td in giver.thingDefs)
                foreach (Thing t in pawn.Map.listerThings.ThingsOfDef(td).Take(3))
                {
                    sb.Append("{bed check of " + td.defName + " at " + t.Position + ": " +
                        $"building room {Try(() => t.GetRoom() == null ? "none" : t.GetRoom().ID + " (" + t.GetRoom().CellCount + " cells)")}, pawn room {Try(() => pawn.GetRoom() == null ? "none" : pawn.GetRoom().ID + " (" + pawn.GetRoom().CellCount + " cells)")}, same room {Try(() => t.GetRoom() == pawn.GetRoom())}, " +
                        $"watchBuildingInSameRoom {td.building?.watchBuildingInSameRoom}, pawn cell roofed {Try(() => pawn.Position.Roofed(pawn.Map))}, building powered {Try(() => t.TryGetComp<CompPowerTrader>()?.PowerOn.ToString() ?? "no power comp")}, " +
                        $"bed {Try(() => pawn.CurrentBed()?.def.defName ?? "none")} medical {Try(() => pawn.CurrentBed()?.Medical.ToString() ?? "n/a")}, can reserve the building {Try(() => pawn.CanReserve(t, 1))}, " +
                        $"line of sight pawn cell to building {Try(() => GenSight.LineOfSight(pawn.Position, t.Position, pawn.Map, true))}, cells between {Try(() => string.Join(" ", GenSight.PointsOnLineOfSight(pawn.Position, t.Position).Select(c => c + ":" + (c.CanBeSeenOver(pawn.Map) ? "clear" : "BLOCKS") + "[" + string.Join("/", c.GetThingList(pawn.Map).Where(x => !(x is Mote)).Select(x => x.def.defName)) + "]")))}" + "} ");
                    sb.Append($"[{td.defName} at {t.Position} facing {t.Rotation}: EverPossibleToWatchFrom(bed allowed) {Try(() => typeof(WatchBuildingUtility).GetMethod("EverPossibleToWatchFrom").Invoke(null, new object[] { pawn.Position, t.Position, pawn.Map, true, td }))}, watch rect per allowed direction {Try(() => string.Join(" ", ((System.Collections.IEnumerable)typeof(WatchBuildingUtility).GetMethod("CalculateAllowedDirections").Invoke(null, new object[] { td, t.Rotation })).Cast<object>().Select(d => { CellRect r = (CellRect)typeof(WatchBuildingUtility).GetMethod("GetWatchCellRect").Invoke(null, new object[] { td, t.Position, t.Rotation, d }); return "dir " + d + " " + r + " has pawn " + r.Contains(pawn.Position); })))}, building occupies {Try(() => GenAdj.OccupiedRect(t.Position, t.Rotation, td.size).ToString())}, can watch from bed {Try(() => pawn.CurrentBed() != null && WatchBuildingUtility.CanWatchFromBed(pawn, pawn.CurrentBed(), t))}; pawn cell is a watch cell {Try(() => WatchBuildingUtility.CalculateWatchCells(td, t.Position, t.Rotation, pawn.Map).Any(c => c.ToString() == pawn.Position.ToString()))}; watch cells {Try(() => string.Join(" ", WatchBuildingUtility.CalculateWatchCells(td, t.Position, t.Rotation, pawn.Map)))}] ");
                }

            return sb.ToString();
        }

        // Why a joy giver of buildings returns no job: the checks of JoyGiver_InteractBuilding.CanInteractWith and of the two TryGivePlayJob variants, per candidate thing.
        // Time, the Joy need, weather and temperature are NOT checked by TryGiveJob (they belong to JobGiver_GetJoy), so they never explain a null here.
        private static string WhyNoJoyJob(Pawn pawn, JoyGiverDef giver)
        {
            var sb = new System.Text.StringBuilder();
            sb.Append($"giver class {giver.giverClass?.Name}, requireChair {giver.requireChair}, unroofedOnly {giver.unroofedOnly}, CanBeGivenTo {Try(() => giver.Worker.CanBeGivenTo(pawn))}; ");
            if (giver.thingDefs == null) return sb.Append("no thingDefs on the giver (not a building giver)").ToString();
            Map map = pawn.Map;
            foreach (ThingDef td in giver.thingDefs)
                foreach (Thing t in map.listerThings.ThingsOfDef(td).Take(3))
                {
                    sb.Append($"[{td.defName} at {t.Position}: ");
                    sb.Append($"canReserve {Try(() => pawn.CanReserve(t, giver.jobDef?.joyMaxParticipants ?? 1))}, forbidden {Try(() => t.IsForbidden(pawn))}, fogged {Try(() => t.Fogged())}, ");
                    sb.Append($"sociallyProper {Try(() => t.IsSociallyProper(pawn))}, politicallyProper {Try(() => t.IsPoliticallyProper(pawn))}, ");
                    CompPowerTrader power = t.TryGetComp<CompPowerTrader>();
                    sb.Append($"power {(power == null ? "none needed" : power.PowerOn.ToString())}, roofed {t.Position.Roofed(map)}, ");
                    sb.Append("cardinal cells: " + string.Join(" ", GenAdj.CellsAdjacentCardinal(t).Select(c =>
                    {
                        Building e = c.GetEdifice(map);
                        return $"{c}(sittable {e != null && e.def.building.isSittable}, forbidden {c.IsForbidden(pawn)}, reservable {Try(() => pawn.CanReserveSittableOrSpot(c))})";
                    })));
                    sb.Append("] ");
                }
            if (sb.ToString().IndexOf('[') < 0) sb.Append("no such thing on this map");
            return sb.ToString();
        }

        private static string Try<T>(System.Func<T> read)
        {
            try
            {
                return read()?.ToString();
            }
            catch (System.Exception e)
            {
                return "threw " + e.GetType().Name + ": " + e.Message;
            }
        }

        /// <summary>
        /// Gives the colonist a new food policy of their own that allows every food and drink, so a food the colonist's saved policy
        /// refuses (a policy saved before a mod added its foods does not list them) is eaten. The policy is named "Pickle: everything"
        /// and is made for this call; the colonist's earlier policy is left as it was. Fails when the colonist follows no food policy tracker.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} follows a food policy that allows everything")]
        public void FollowsEverythingPolicy(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.foodRestriction != null, $"{nickname} has no food restriction tracker");
            FoodPolicy policy = Current.Game.foodRestrictionDatabase.MakeNewFoodRestriction();
            policy.label = "Pickle: everything";
            policy.filter.SetAllowAll(null);
            pawn.foodRestriction.CurrentFoodPolicy = policy;
            ctx.Assert(pawn.foodRestriction.CurrentFoodPolicy == policy, $"{nickname} still follows '{pawn.foodRestriction.CurrentFoodPolicy?.label}' after the step");
        }

        /// <summary>
        /// Gives the colonist a new food policy of their own: a copy of the one they follow now, with one more def allowed (by defName). Everything
        /// else stays as the earlier policy had it. The earlier policy is left as it was. Fails when the def is unknown or is not a thing a policy can hold.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} follows a food policy that also allows {string}")]
        public void FollowsPolicyAlsoAllowing(PickleContext ctx, string nickname, string defName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.foodRestriction != null, $"{nickname} has no food restriction tracker");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            FoodPolicy before = pawn.foodRestriction.CurrentFoodPolicy;
            FoodPolicy policy = Current.Game.foodRestrictionDatabase.MakeNewFoodRestriction();
            policy.label = "Pickle: " + (before == null ? "default" : before.label) + " + " + defName;
            if (before != null)
            {
                policy.filter.CopyAllowancesFrom(before.filter);
            }

            policy.filter.SetAllow(def, true);
            pawn.foodRestriction.CurrentFoodPolicy = policy;
            ctx.Assert(policy.filter.Allows(def), $"the new food policy still refuses {defName}: the def is not one a food policy can hold");
        }

        /// <summary>
        /// Gives the colonist a new apparel policy of their own that allows every garment, so a garment the colonist's saved policy refuses
        /// (a policy saved before a mod added its garments does not list them, so the colonist drops them) is kept. The policy is named
        /// "Pickle: everything" and is made for this call; the colonist's earlier policy is left as it was. Fails when the colonist has no outfit tracker.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} follows an apparel policy that allows everything")]
        public void FollowsEverythingApparelPolicy(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.outfits != null, $"{nickname} has no outfit tracker");
            ApparelPolicy policy = Current.Game.outfitDatabase.MakeNewOutfit();
            policy.label = "Pickle: everything";
            policy.filter.SetAllowAll(null);
            pawn.outfits.CurrentApparelPolicy = policy;
            ctx.Assert(pawn.outfits.CurrentApparelPolicy == policy, $"{nickname} still follows '{pawn.outfits.CurrentApparelPolicy?.label}' after the step");
        }

        /// <summary>
        /// Gives the colonist a new apparel policy of their own: a copy of the one they follow now, with one more def allowed (by defName). Everything
        /// else stays as the earlier policy had it. The earlier policy is left as it was. Fails when the def is unknown or is not a garment a policy can hold.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} follows an apparel policy that also allows {string}")]
        public void FollowsApparelPolicyAlsoAllowing(PickleContext ctx, string nickname, string defName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.outfits != null, $"{nickname} has no outfit tracker");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            ApparelPolicy before = pawn.outfits.CurrentApparelPolicy;
            ApparelPolicy policy = Current.Game.outfitDatabase.MakeNewOutfit();
            policy.label = "Pickle: " + (before == null ? "default" : before.label) + " + " + defName;
            if (before != null)
            {
                policy.filter.CopyAllowancesFrom(before.filter);
            }

            policy.filter.SetAllow(def, true);
            pawn.outfits.CurrentApparelPolicy = policy;
            ctx.Assert(policy.filter.Allows(def), $"the new apparel policy still refuses {defName}: the def is not one an apparel policy can hold");
        }

        private static Thing ThingAt(PickleContext ctx, string defName, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "there is no current map: a save has to be loaded first");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"cell ({x}, {z}) is outside the map");
            List<Thing> here = cell.GetThingList(map);
            Thing thing = here.FirstOrDefault(t => t.def.defName == defName);
            ctx.Require(
                thing != null,
                $"no thing of def '{defName}' at ({x}, {z}); the cell holds: {(here.Count == 0 ? "nothing" : string.Join(", ", here.Select(t => t.def.defName)))}");
            return thing;
        }

        private static void SetForbidden(PickleContext ctx, string defName, int x, int z, bool forbidden)
        {
            Thing thing = ThingAt(ctx, defName, x, z);
            ctx.Require(thing.TryGetComp<CompForbiddable>() != null, $"the {defName} at ({x}, {z}) cannot be forbidden (no forbiddable component)");
            ForbidUtility.SetForbidden(thing, forbidden, false);
            ctx.Assert(thing.IsForbidden(Faction.OfPlayer) == forbidden, $"the {defName} at ({x}, {z}) is {(forbidden ? "not forbidden" : "still forbidden")} after the step");
        }
    }
}
