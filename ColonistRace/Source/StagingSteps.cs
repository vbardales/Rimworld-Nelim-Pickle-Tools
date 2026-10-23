using System;
using System.Linq;
using System.Reflection;
using RimWorld;
using RimWorks.Pickle;
using UnityEngine;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps that stage a colonist for a gallery picture of a mod's furniture: a skin colour, playing a musical instrument, sitting on a chair,
    /// and a read of the role of the room at a cell. Written 2026-10-20 for ImperialFurnishings' gallery plan. NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class StagingSteps
    {
        /// <summary>
        /// Gives a colonist a skin colour of their own (the skin colour override of the story, the one a gene or the melanin gives way to), by red,
        /// green and blue out of 255, and redraws the pawn. Fails when the colonist has no story.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} skin colour is rgb \\({int}, {int}, {int}\\)")]
        public void SetSkinColour(PickleContext ctx, string nickname, int r, int g, int b)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"{nickname} has no story");
            ctx.Require(r >= 0 && r <= 255 && g >= 0 && g <= 255 && b >= 0 && b <= 255, "red, green and blue run from 0 to 255");
            pawn.story.skinColorOverride = new Color(r / 255f, g / 255f, b / 255f);
            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
            Color read = pawn.story.SkinColor;
            ctx.Assert(Mathf.Abs(Mathf.RoundToInt(read.r * 255f) - r) <= 3 && Mathf.Abs(Mathf.RoundToInt(read.g * 255f) - g) <= 3 && Mathf.Abs(Mathf.RoundToInt(read.b * 255f) - b) <= 3,
                $"{nickname}'s skin colour reads {Mathf.RoundToInt(read.r * 255f)}, {Mathf.RoundToInt(read.g * 255f)}, {Mathf.RoundToInt(read.b * 255f)} after the step, not {r}, {g}, {b}");
        }

        /// <summary>
        /// Puts a colonist on the interaction cell of the first building of a def (an instrument: harp, piano, organ), turned towards it, and starts the
        /// job Play_MusicalInstrument on it by force. The job is held as the current job; the playing pose is drawn only while the game ticks, so with the
        /// game paused the capture shows the colonist at the instrument. Fails when the colonist is unknown, no such building stands on the current map, its
        /// interaction cell is not standable, or the job does not become the current job.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} plays the instrument {string}")]
        public void PlaysInstrument(PickleContext ctx, string nickname, string defName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            Building building = map.listerThings.ThingsOfDef(def).OfType<Building>().FirstOrDefault();
            ctx.Require(building != null, $"no {defName} stands on the current map");
            JobDef jobDef = DefDatabase<JobDef>.GetNamedSilentFail("Play_MusicalInstrument");
            ctx.Require(jobDef != null, "no JobDef Play_MusicalInstrument (Royalty is not active)");
            IntVec3 cell = building.InteractionCell;
            ctx.Require(cell.IsValid && cell.InBounds(map) && cell.Standable(map), $"the interaction cell {cell} of {defName} at {building.Position} is not standable");

            PlaceAt(pawn, map, cell, null);
            pawn.Rotation = Rot4.FromAngleFlat((building.DrawPos - cell.ToVector3Shifted()).AngleFlat());
            Job job = JobMaker.MakeJob(jobDef, building);
            pawn.jobs.StartJob(job, JobCondition.InterruptForced);
            Log.Message($"[stage] {nickname} plays {defName} at {building.Position} from {cell}, facing {pawn.Rotation}, job now {pawn.CurJob?.def.defName ?? "none"}");
            ctx.Assert(pawn.CurJob != null && pawn.CurJob.def == jobDef, $"{nickname}'s job is {pawn.CurJob?.def.defName ?? "none"}, not Play_MusicalInstrument (the job did not start: reserved or unreachable)");
        }

        /// <summary>
        /// Puts a colonist on a standable cell beside a pawn (colonist or animal, by short name), turned towards it, and starts a job on it by force
        /// (a JobDef by defName with the pawn as target: Tame, Train, a nuzzle or feed job a mod adds). The job is held as the current job; the
        /// animation is drawn only while the game ticks. Fails when the colonist or the target is unknown, the JobDef does not exist (the failure lists
        /// the jobs whose name contains the text), no cell beside the target is standable, or the job does not become the current job.
        /// Written 2026-10-23 for AlphaMythology's gallery (hands towards the animal). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is forced into the job {string} on {string}")]
        public void ForcedJobOn(PickleContext ctx, string nickname, string jobName, string targetName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            Pawn target = map.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p != pawn && p.Name != null && string.Equals(p.LabelShort, targetName, StringComparison.OrdinalIgnoreCase));
            ctx.Require(target != null, $"no pawn named '{targetName}' is on the current map");
            JobDef jobDef = DefDatabase<JobDef>.GetNamedSilentFail(jobName);
            ctx.Require(jobDef != null, $"no JobDef named '{jobName}'; jobs containing it: " + string.Join(", ",
                DefDatabase<JobDef>.AllDefsListForReading.Where(j => j.defName.IndexOf(jobName, StringComparison.OrdinalIgnoreCase) >= 0).Select(j => j.defName).Take(30)));
            IntVec3 cell = GenAdj.CellsAdjacent8Way(target).Where(c => c.InBounds(map) && c.Standable(map) && !c.GetThingList(map).OfType<Pawn>().Any())
                .OrderBy(c => c.DistanceToSquared(pawn.Position)).FirstOrDefault();
            ctx.Require(cell.IsValid, $"no standable free cell beside {targetName} at {target.Position}");

            PlaceAt(pawn, map, cell, null);
            pawn.Rotation = Rot4.FromAngleFlat((target.DrawPos - cell.ToVector3Shifted()).AngleFlat());
            pawn.jobs.StartJob(JobMaker.MakeJob(jobDef, target), JobCondition.InterruptForced);
            Log.Message($"[stage] {nickname} forced into {jobDef.defName} on {targetName} from {cell}, facing {pawn.Rotation}, job now {pawn.CurJob?.def.defName ?? "none"}");
            ctx.Assert(pawn.CurJob != null && pawn.CurJob.def == jobDef, $"{nickname}'s job is {pawn.CurJob?.def.defName ?? "none"}, not {jobDef.defName} (the job did not start: reserved, unreachable or refused for this target)");
        }

        /// <summary>
        /// The same job, targeting the first building of a def (by defName) at a cell: the colonist is put beside it and the job started by force.
        /// For Refuel the job is the one the game's own work giver builds (the target plus the nearest fuel it finds), since the driver needs the fuel as
        /// a second target; it fails saying so when the building is full or no fuel can be reached. Written 2026-10-23 for AlphaMythology. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is forced into the job {string} on the building {string} at \\({int}, {int}\\)")]
        public void ForcedJobOnBuilding(PickleContext ctx, string nickname, string jobName, string defName, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            Thing target = cell.GetThingList(map).OfType<Building>().FirstOrDefault(b => b.def.defName == defName);
            ctx.Require(target != null, $"no {defName} stands at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            StartForced(ctx, nickname, pawn, map, RequireJob(ctx, jobName), target, true);
        }

        /// <summary>
        /// The same job, targeting the plant at a cell (Harvest, CutPlant...): the colonist is put beside it and the job started by force. Fails when no
        /// plant stands there.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is forced into the job {string} on the plant at \\({int}, {int}\\)")]
        public void ForcedJobOnPlant(PickleContext ctx, string nickname, string jobName, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            Thing target = cell.GetPlant(map);
            ctx.Require(target != null, $"no plant stands at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            StartForced(ctx, nickname, pawn, map, RequireJob(ctx, jobName), target, true);
        }

        /// <summary>
        /// Makes a stack of an item (by defName, made of its default stuff) on the colonist's cell and starts the job HaulToCell by force: the colonist
        /// picks it up and carries it to the cell, so the item is drawn in the hands while the game ticks. The colonist is not moved: stand it where the
        /// walk should start. Fails when the def is unknown or the job does not become the current job (cell unreachable).
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is forced to haul {int} of the item {string} to \\({int}, {int}\\)")]
        public void ForcedHaul(PickleContext ctx, string nickname, int count, string defName, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Map map = Find.CurrentMap;
            ctx.Require(map != null && pawn.Spawned, "no map is loaded or the colonist is not spawned");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map) && cell.Standable(map), $"the cell ({x}, {z}) is outside the map or not standable");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            ctx.Require(count >= 1 && count <= def.stackLimit, $"{defName} stacks to {def.stackLimit}, not {count}");
            JobDef jobDef = RequireJob(ctx, "HaulToCell");
            Thing item = ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def));
            item.stackCount = count;
            GenPlace.TryPlaceThing(item, pawn.Position, map, ThingPlaceMode.Near);
            ctx.Require(item.Spawned, $"the {defName} could not be placed near {nickname}");
            Job job = JobMaker.MakeJob(jobDef, item, cell);
            job.count = count;
            pawn.jobs.StartJob(job, JobCondition.InterruptForced);
            Log.Message($"[stage] {nickname} forced to haul {count} {defName} to {cell} from {pawn.Position}, job now {pawn.CurJob?.def.defName ?? "none"}");
            ctx.Assert(pawn.CurJob != null && pawn.CurJob.def == jobDef, $"{nickname}'s job is {pawn.CurJob?.def.defName ?? "none"}, not HaulToCell (unreachable cell or the item is reserved)");
        }

        /// <summary>
        /// Starts the job Goto on a pawn (an animal or a colonist, by short name) by force: it walks from where it stands to a cell. The pawn is not moved.
        /// The walk is drawn only while the game ticks, so let ticks pass after this step and pause only then. Fails when the pawn is unknown or not
        /// spawned, the cell is outside the map, not standable or unreachable for it, or Goto does not become the current job.
        /// Written 2026-10-23 for AACaK's shotlist v6. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is forced to walk to \\({int}, {int}\\)")]
        public void ForcedToWalk(PickleContext ctx, string name, int x, int z)
        {
            Pawn pawn = RequireSpawnedPawn(ctx, name);
            Map map = pawn.Map;
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map) && cell.Standable(map), $"the cell ({x}, {z}) is outside the map or not standable");
            ctx.Require(pawn.CanReach(cell, PathEndMode.OnCell, Danger.Deadly), $"{name} at {pawn.Position} cannot reach ({x}, {z})");
            JobDef jobDef = RequireJob(ctx, "Goto");
            StartJob(ctx, name, pawn, jobDef, JobMaker.MakeJob(jobDef, cell));
        }

        /// <summary>
        /// Starts the job FollowClose on a pawn (an animal, by short name) by force: it walks after a colonist and keeps within about three cells of
        /// them, for as long as the game runs. The pawn is not moved. The following is drawn only while the game ticks. Fails when either pawn is
        /// unknown or not spawned, or FollowClose does not become the current job.
        /// Written 2026-10-23 for AACaK's shotlist v6. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} follows {string}")]
        public void Follows(PickleContext ctx, string followerName, string leaderName)
        {
            FollowWithin(ctx, followerName, leaderName, 3);
        }

        /// <summary>
        /// The same, keeping within the given number of cells of the leader instead of about three.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} follows {string} within {int} cells")]
        public void FollowsWithin(PickleContext ctx, string followerName, string leaderName, int cells)
        {
            FollowWithin(ctx, followerName, leaderName, cells);
        }

        private static void FollowWithin(PickleContext ctx, string followerName, string leaderName, int cells)
        {
            ctx.Require(cells >= 1, "the follow distance is at least 1 cell");
            Pawn follower = RequireSpawnedPawn(ctx, followerName);
            Pawn leader = RequireSpawnedPawn(ctx, leaderName);
            ctx.Require(follower != leader, "a pawn cannot follow itself");
            JobDef jobDef = RequireJob(ctx, "FollowClose");
            Job job = JobMaker.MakeJob(jobDef, leader);
            job.followRadius = cells;
            job.expiryInterval = 600000;
            StartJob(ctx, followerName, follower, jobDef, job);
        }

        /// <summary>
        /// Starts the job LayDown on the cell a pawn (an animal, by short name) stands on, forced to sleep, as the game's own rest giver does for an
        /// animal without a bed. The pawn is not moved. The lying pose is drawn only while the game ticks. Fails when the pawn is unknown or not
        /// spawned, or LayDown does not become the current job.
        /// Written 2026-10-23 for AACaK's shotlist v6. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} lies down")]
        public void LiesDown(PickleContext ctx, string name)
        {
            Pawn pawn = RequireSpawnedPawn(ctx, name);
            JobDef jobDef = RequireJob(ctx, "LayDown");
            Job job = JobMaker.MakeJob(jobDef, pawn.Position);
            job.forceSleep = true;
            StartJob(ctx, name, pawn, jobDef, job);
        }

        private static Pawn RequireSpawnedPawn(PickleContext ctx, string name)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            Pawn pawn = map.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p.Name != null && string.Equals(p.LabelShort, name, StringComparison.OrdinalIgnoreCase));
            ctx.Require(pawn != null, $"no pawn named '{name}' is on the current map");
            return pawn;
        }

        private static void StartJob(PickleContext ctx, string name, Pawn pawn, JobDef jobDef, Job job)
        {
            pawn.jobs.StartJob(job, JobCondition.InterruptForced);
            Log.Message($"[stage] {name} forced into {jobDef.defName} from {pawn.Position}, job now {pawn.CurJob?.def.defName ?? "none"}");
            ctx.Assert(pawn.CurJob != null && pawn.CurJob.def == jobDef, $"{name}'s job is {pawn.CurJob?.def.defName ?? "none"}, not {jobDef.defName} (the job did not start: refused for this pawn)");
        }

        private static JobDef RequireJob(PickleContext ctx, string jobName)
        {
            JobDef jobDef = DefDatabase<JobDef>.GetNamedSilentFail(jobName);
            ctx.Require(jobDef != null, $"no JobDef named '{jobName}'; jobs containing it: " + string.Join(", ",
                DefDatabase<JobDef>.AllDefsListForReading.Where(j => j.defName.IndexOf(jobName, StringComparison.OrdinalIgnoreCase) >= 0).Select(j => j.defName).Take(30)));
            return jobDef;
        }

        private static void StartForced(PickleContext ctx, string nickname, Pawn pawn, Map map, JobDef jobDef, Thing target, bool placeBeside)
        {
            if (placeBeside)
            {
                IntVec3 cell = GenAdj.CellsAdjacent8Way(target).Where(c => c.InBounds(map) && c.Standable(map) && !c.GetThingList(map).OfType<Pawn>().Any())
                    .OrderBy(c => c.DistanceToSquared(pawn.Position)).FirstOrDefault();
                ctx.Require(cell.IsValid, $"no standable free cell beside {target.LabelShort} at {target.Position}");
                PlaceAt(pawn, map, cell, null);
                pawn.Rotation = Rot4.FromAngleFlat((target.DrawPos - cell.ToVector3Shifted()).AngleFlat());
            }

            Job job;
            if (jobDef.defName == "Refuel" || jobDef.defName == "RefuelAtomic")
            {
                job = RefuelWorkGiverUtility.RefuelJob(pawn, target, true);
                ctx.Require(job != null, $"the game builds no refuel job for {target.LabelShort}: it is full, or no fuel it accepts can be reached");
            }
            else
            {
                job = JobMaker.MakeJob(jobDef, target);
            }

            pawn.jobs.StartJob(job, JobCondition.InterruptForced);
            Log.Message($"[stage] {nickname} forced into {job.def.defName} on {target.LabelShort} at {target.Position}, job now {pawn.CurJob?.def.defName ?? "none"}");
            ctx.Assert(pawn.CurJob != null && pawn.CurJob.def == job.def, $"{nickname}'s job is {pawn.CurJob?.def.defName ?? "none"}, not {job.def.defName} (the job did not start: reserved, unreachable or refused for this target)");
        }

        /// <summary>
        /// Puts a colonist on the cell of a building of a def (a chair, a stool) and turns them the way the building faces, as a seated guest. Stops the
        /// colonist's jobs. The seated posture is the game's own and is drawn only when the colonist has a job that sits; here the colonist is placed on
        /// the seat, in the seat's direction. Fails when the colonist is unknown or no building of that def stands on that cell.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} sits on the building {string} at \\({int}, {int}\\)")]
        public void SitsOn(PickleContext ctx, string nickname, string defName, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            Building seat = cell.GetThingList(map).OfType<Building>().FirstOrDefault(b => b.def.defName == defName);
            ctx.Require(seat != null, $"no {defName} stands at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            PlaceAt(pawn, map, cell, seat.Rotation);
            Log.Message($"[stage] {nickname} on {defName} at ({x}, {z}), facing {pawn.Rotation}");
            ctx.Assert(pawn.Position == cell, $"{nickname} should be at ({x}, {z}); it is at {pawn.Position}");
        }

        /// <summary>
        /// Asserts the role of the room that holds a cell (RoomRoleDef by defName). The room's stats and role are recomputed first. The failure prints the
        /// role read and the score of every role for that room. Fails when the cell has no room (open air, a wall).
        /// </summary>
        [Then("Nelim's Pickle Tools: the room at \\({int}, {int}\\) has the role {string}")]
        public void RoomHasRole(PickleContext ctx, int x, int z, string roleName)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            Room room = cell.GetRoom(map);
            ctx.Require(room != null, $"no room holds ({x}, {z})");
            MethodInfo dirty = typeof(Room).GetMethod("Notify_RoomShapeChanged", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic);
            try
            {
                dirty?.Invoke(room, null);
            }
            catch (Exception e)
            {
                Log.Warning("[room] could not mark the room dirty: " + e.GetType().Name);
            }

            RoomRoleDef role = room.Role;
            string scores = string.Join(", ", DefDatabase<RoomRoleDef>.AllDefsListForReading
                .Select(r => r.defName + " " + SafeScore(r, room)).OrderBy(s => s));
            Log.Message($"[room] ({x}, {z}): role {role?.defName ?? "none"}, {room.CellCount} cells; scores: {scores}");
            ctx.Assert(role != null && role.defName == roleName, $"the room at ({x}, {z}) has the role {role?.defName ?? "none"}, not {roleName}; scores: {scores}");
        }

        private static string SafeScore(RoomRoleDef role, Room room)
        {
            try
            {
                return role.Worker.GetScore(room).ToString("0.##");
            }
            catch (Exception e)
            {
                return "threw " + e.GetType().Name;
            }
        }

        private static void PlaceAt(Pawn pawn, Map map, IntVec3 cell, Rot4? facing)
        {
            if (pawn.Spawned)
            {
                pawn.jobs?.StopAll();
                pawn.pather?.StopDead();
                pawn.Position = cell;
                pawn.Notify_Teleported(true, true);
            }
            else
            {
                GenSpawn.Spawn(pawn, cell, map);
            }

            if (facing.HasValue)
            {
                pawn.Rotation = facing.Value;
            }

            pawn.Drawer?.renderer?.SetAllGraphicsDirty();
        }
    }
}
