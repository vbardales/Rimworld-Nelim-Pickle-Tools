using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.IdeologySteps
{
    /// <summary>
    /// Steps that build a prison cell on the current map and put a prisoner in it, set the prisoner's interaction mode,
    /// and switch one work type of a colonist. The cell is 3 by 3 inside, ringed by walls, with a door in the middle of
    /// the south wall and a prisoner bed; it lives in the loaded game only, and an [AfterScenario] removes what a scenario
    /// built.
    /// </summary>
    [PickleSteps]
    public class PrisonSteps
    {
        private const int Inside = 3;

        // The field the prisoner tab sets; the game exposes only a getter (ExclusiveInteractionMode).
        private static readonly System.Reflection.FieldInfo InteractionModeField = HarmonyLib.AccessTools.Field(typeof(Pawn_GuestTracker), "interactionMode");

        // Things this tool made, to remove them after the scenario. After a reload they belong to the game that was replaced:
        // only a thing still spawned on the current map is touched.
        private static readonly List<Thing> Made = new List<Thing>();

        /// <summary>
        /// Builds a prison cell whose south-west inside cell is (x, z): walls around a 3 by 3 inside, a door in the middle of the
        /// south wall, a prisoner bed, and a roof, then waits for the game to class the room as a prison cell. Plants and filth
        /// in the way are cleared. Fails naming the first cell that is outside the map, cannot carry a wall, or holds a building,
        /// a pawn or an item.
        /// </summary>
        [Given("Nelim's Pickle Tools: a prison cell is built at \\({int}, {int}\\) with a bed and a door", TimeoutSeconds = 15f)]
        public async Task BuildCell(PickleContext ctx, int x, int z)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map is loaded; load a save first with 'the save ... is loaded'");

            CellRect inside = new CellRect(x, z, Inside, Inside);
            CellRect footprint = inside.ExpandedBy(1);
            IntVec3 doorCell = new IntVec3(x + 1, 0, z - 1);

            foreach (IntVec3 c in footprint)
            {
                ThingDef building = c == doorCell ? ThingDefOf.Door : (inside.Contains(c) ? ThingDefOf.Bed : ThingDefOf.Wall);
                string blocked = WhyBlocked(map, c, building);
                ctx.Require(blocked == null, $"the cell ({c.x}, {c.z}) is blocked: {blocked}");
            }

            foreach (IntVec3 c in footprint)
            {
                foreach (Thing t in c.GetThingList(map).Where(t => t.def.category == ThingCategory.Plant || t.def.category == ThingCategory.Filth || IsChunk(t)).ToList())
                {
                    t.Destroy();
                }
            }

            foreach (IntVec3 c in footprint.Cells.Where(c => !inside.Contains(c)))
            {
                ThingDef def = c == doorCell ? ThingDefOf.Door : ThingDefOf.Wall;
                Made.Add(GenSpawn.Spawn(ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def)), c, map, WipeMode.Vanish));
            }

            Building_Bed bed = SpawnBed(ctx, map, inside);
            bed.ForPrisoners = true;
            Made.Add(bed);

            foreach (IntVec3 c in inside)
            {
                map.roofGrid.SetRoof(c, RoofDefOf.RoofConstructed);
            }

            map.regionAndRoomUpdater.RebuildAllRegionsAndRooms();

            IntVec3 probe = inside.CenterCell;
            await ctx.WaitUntil(() => probe.GetRoom(map)?.IsPrisonCell == true, 10f);
            Room room = probe.GetRoom(map);
            ctx.Assert(
                room != null && room.IsPrisonCell,
                $"the room at ({probe.x}, {probe.z}) should be a prison cell; the game classes it as {room?.Role?.defName ?? "(no room)"}, proper room: {room?.ProperRoom}");
        }

        /// <summary>
        /// Spawns a prisoner of the colony in the cell built at (x, z), assigns it the bed, and leaves it in restraints:
        /// <c>RestraintsUtility.InRestraints</c> is true, and the step fails if it is not.
        /// </summary>
        [Given("Nelim's Pickle Tools: a prisoner {string} exists in the cell at \\({int}, {int}\\), in restraints")]
        public void PrisonerInRestraints(PickleContext ctx, string nickname, int x, int z)
        {
            Prisoner(ctx, nickname, x, z, false);
        }

        /// <summary>
        /// The negative control of the step in restraints: the prisoner is released to roam (the "free" setting of the prisoner
        /// tab), so <c>RestraintsUtility.InRestraints</c> is false, and the step fails if it is not.
        /// </summary>
        [Given("Nelim's Pickle Tools: a prisoner {string} exists in the cell at \\({int}, {int}\\), not in restraints")]
        public void PrisonerFree(PickleContext ctx, string nickname, int x, int z)
        {
            Prisoner(ctx, nickname, x, z, true);
        }

        private static void Prisoner(PickleContext ctx, string nickname, int x, int z, bool released)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map is loaded; load a save first with 'the save ... is loaded'");
            CellRect inside = new CellRect(x, z, Inside, Inside);
            Building_Bed bed = inside.Cells
                .SelectMany(c => c.GetThingList(map).OfType<Building_Bed>())
                .FirstOrDefault(b => b.ForPrisoners);
            ctx.Require(
                bed != null,
                $"no prisoner bed in the cell at ({x}, {z}); build it first with 'a prison cell is built at ({x}, {z}) with a bed and a door'");

            ctx.Require(
                Lookups.AllSpawnedPawns().All(p => !string.Equals(p.Name?.ToStringShort, nickname, StringComparison.OrdinalIgnoreCase)),
                $"a pawn named '{nickname}' already exists on the map");

            IntVec3 cell = inside.Cells.FirstOrDefault(c => c.Standable(map) && !bed.OccupiedRect().Contains(c));
            if (!cell.IsValid)
            {
                cell = bed.Position;
            }

            Pawn pawn = PawnGenerator.GeneratePawn(PawnKindDefOf.Villager, null);
            pawn.Name = new NameTriple(nickname, nickname, nickname);
            GenSpawn.Spawn(pawn, cell, map, WipeMode.Vanish);
            Made.Add(pawn);

            pawn.guest.SetGuestStatus(Faction.OfPlayer, GuestStatus.Prisoner);
            pawn.guest.Released = released;
            bed.CompAssignableToPawn.TryAssignPawn(pawn);

            ctx.Assert(
                pawn.IsPrisonerOfColony,
                $"pawn '{nickname}' should be a prisoner of the colony; guest status {pawn.guest.GuestStatus}, host faction {pawn.HostFaction?.Name ?? "(none)"}");
            ctx.Assert(
                RestraintsUtility.InRestraints(pawn) == !released,
                $"pawn '{nickname}' should {(released ? "not " : string.Empty)}be in restraints; RestraintsUtility.InRestraints says {RestraintsUtility.InRestraints(pawn)}");
        }

        /// <summary>
        /// Sets the exclusive interaction mode of a prisoner of the colony (Ideology's Convert, Reduce resistance, Recruit,
        /// Release, or a mode a mod adds) by PrisonerInteractionModeDef name, then reads it back. It sets the same field the
        /// prisoner tab sets, without the tab's warnings.
        /// </summary>
        [Given("Nelim's Pickle Tools: the prisoner {string} interaction mode is {string}")]
        public void SetInteractionMode(PickleContext ctx, string nickname, string modeName)
        {
            Pawn pawn = Lookups.RequirePawn(ctx, nickname);
            ctx.Require(pawn.IsPrisonerOfColony, $"pawn '{nickname}' is not a prisoner of the colony, so it has no interaction mode");
            PrisonerInteractionModeDef mode = Lookups.RequireDef<PrisonerInteractionModeDef>(ctx, modeName, "interaction mode");
            ctx.Require(InteractionModeField != null, "Pawn_GuestTracker.interactionMode is not there in this game build: the field moved, this tool has to follow");

            InteractionModeField.SetValue(pawn.guest, mode);
            ctx.Assert(
                pawn.guest.ExclusiveInteractionMode == mode,
                $"the prisoner '{nickname}' should have the interaction mode '{modeName}'; it has '{pawn.guest.ExclusiveInteractionMode?.defName}'");
        }

        /// <summary>Enables one work type of a colonist (priority 3, or 1 when the colony does not use priorities) and leaves the others as they are.</summary>
        [Given("Nelim's Pickle Tools: the colonist {string} has the work type {string} enabled")]
        public void EnableWorkType(PickleContext ctx, string nickname, string workTypeName)
        {
            SetWorkType(ctx, nickname, workTypeName, true);
        }

        /// <summary>Disables one work type of a colonist (priority 0) and leaves the others as they are.</summary>
        [Given("Nelim's Pickle Tools: the colonist {string} has the work type {string} disabled")]
        public void DisableWorkType(PickleContext ctx, string nickname, string workTypeName)
        {
            SetWorkType(ctx, nickname, workTypeName, false);
        }

        private static void SetWorkType(PickleContext ctx, string nickname, string workTypeName, bool enabled)
        {
            Pawn pawn = Lookups.RequirePawn(ctx, nickname);
            WorkTypeDef def = Lookups.RequireDef<WorkTypeDef>(ctx, workTypeName, "work type");
            ctx.Require(pawn.workSettings != null, $"pawn '{nickname}' has no work settings (not a colonist?)");
            pawn.workSettings.EnableAndInitializeIfNotAlreadyInitialized();
            ctx.Require(
                !pawn.WorkTypeIsDisabled(def),
                $"pawn '{nickname}' is incapable of the work type '{workTypeName}' (a trait, a backstory or a gene forbids it), so it cannot be enabled");

            pawn.workSettings.SetPriority(def, enabled ? (Current.Game.playSettings.useWorkPriorities ? 3 : 1) : 0);
            int priority = pawn.workSettings.GetPriority(def);
            ctx.Assert(
                (priority > 0) == enabled,
                $"the work type '{workTypeName}' of '{nickname}' should be {(enabled ? "enabled" : "disabled")}; its priority is {priority}");
        }

        [AfterScenario]
        public void CleanUp(PickleContext ctx)
        {
            Map current = Find.CurrentMap;
            foreach (Thing t in Made.ToList())
            {
                if (current != null && t.Spawned && t.Map == current && !t.Destroyed)
                {
                    t.Destroy();
                }
            }

            Made.Clear();
        }

        private static Building_Bed SpawnBed(PickleContext ctx, Map map, CellRect inside)
        {
            ThingDef bedDef = ThingDefOf.Bed;
            foreach (IntVec3 c in inside)
            {
                CellRect rect = GenAdj.OccupiedRect(c, Rot4.North, bedDef.size);
                if (inside.Contains(new IntVec3(rect.minX, 0, rect.minZ)) && inside.Contains(new IntVec3(rect.maxX, 0, rect.maxZ)))
                {
                    return (Building_Bed)GenSpawn.Spawn(ThingMaker.MakeThing(bedDef, GenStuff.DefaultStuffFor(bedDef)), c, map, Rot4.North, WipeMode.Vanish);
                }
            }

            ctx.Require(false, "no place for a bed inside the cell");
            return null;
        }

        // A rock chunk is natural debris, not something a scenario placed: it is cleared with the plants and the filth.
        private static bool IsChunk(Thing t)
        {
            return t.def.thingCategories != null && t.def.thingCategories.Contains(ThingCategoryDefOf.StoneChunks);
        }

        /// <summary>Why a building cannot go on this cell, or null.</summary>
        private static string WhyBlocked(Map map, IntVec3 c, ThingDef building)
        {
            if (!c.InBounds(map))
            {
                return "it is outside the map";
            }

            if (building != ThingDefOf.Bed && !GenConstruct.CanBuildOnTerrain(building, c, map, Rot4.North))
            {
                return $"the terrain '{c.GetTerrain(map).defName}' cannot carry a {building.defName}";
            }

            foreach (Thing t in c.GetThingList(map))
            {
                if (t is Building)
                {
                    return $"it holds a {t.def.defName}";
                }

                if (t is Pawn)
                {
                    return $"{t.LabelShort} stands on it";
                }

                if (t.def.category == ThingCategory.Item && !IsChunk(t))
                {
                    return $"it holds an item, {t.def.defName}";
                }
            }

            return null;
        }
    }
}
