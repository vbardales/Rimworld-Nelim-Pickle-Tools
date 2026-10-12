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
            JoyKindDef kind = thing.def.ingestible?.joyKind;
            if (kind != null && pawn.needs?.joy != null)
            {
                lines.Add($"tolerance for {kind.defName}: {pawn.needs.joy.tolerances[kind]}");
            }

            Log.Message("[joy] " + string.Join("; ", lines));
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
