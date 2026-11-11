using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using RimWorld;
using Verse;
using Verse.AI;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps for a building a mod gives its own work givers and its own fields (a kiln that is filled by a hauling job, burns for a number of ticks and is emptied), with no reference to
    /// the mod: the work giver is named by its WorkGiverDef, the fields are read and set by name. Written 2026-11-11 for RolledUpSleeves (FK_FiringKiln, scenario 6). NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class ThingWorkSteps
    {
        private static readonly Dictionary<string, string> Remembered = new Dictionary<string, string>();

        /// <summary>
        /// A colonist is given the job the game's own work giver (a WorkGiverDef by defName) builds for a building (by defName) at a cell, and starts it by force: the colonist is put on a free cell
        /// beside the building and the job is the one the giver returns, so its targets (the building, the stack to carry, the count) are set as in play. The giver needs what it needs: items
        /// on the map within reach and not forbidden, the building in the state the giver accepts. Fails when the colonist or the building is unknown, the work giver is unknown or is not a
        /// scanner (it lists the givers whose name contains the text), the giver returns no job (it says what it was asked), or the job does not become the current job. The job runs only while
        /// the game ticks: <c>I let N ticks pass</c>. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is forced into the work of the giver {string} on the building {string} at \\({int}, {int}\\)")]
        public void ForcedWork(PickleContext ctx, string nickname, string giverName, string defName, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Map map = Find.CurrentMap;
            ctx.Require(map != null && pawn.Spawned, "no map is loaded or the colonist is not spawned");
            Thing building = ThingAt(ctx, map, defName, x, z);
            WorkGiverDef giverDef = DefDatabase<WorkGiverDef>.GetNamedSilentFail(giverName);
            ctx.Require(giverDef != null, $"no WorkGiverDef named '{giverName}'; givers containing it: " + string.Join(", ", DefDatabase<WorkGiverDef>.AllDefsListForReading.Where(g => g.defName.IndexOf(giverName, StringComparison.OrdinalIgnoreCase) >= 0).Select(g => g.defName).Take(30)));
            var scanner = giverDef.Worker as WorkGiver_Scanner;
            ctx.Require(scanner != null, $"the work giver {giverName} ({giverDef.giverClass?.Name}) is not a scanner: it gives jobs on no thing");
            IntVec3 beside = GenAdj.CellsAdjacent8Way(building).Where(c => c.InBounds(map) && c.Standable(map) && !c.GetThingList(map).OfType<Pawn>().Any())
                .OrderBy(c => c.DistanceToSquared(pawn.Position)).FirstOrDefault();
            ctx.Require(beside.IsValid, $"no standable free cell beside {defName} at ({x}, {z})");
            pawn.Position = beside;
            pawn.Notify_Teleported(true, true);
            pawn.Rotation = Rot4.FromAngleFlat((building.DrawPos - beside.ToVector3Shifted()).AngleFlat());
            Job job = null;
            try { job = scanner.JobOnThing(pawn, building, true); }
            catch (Exception e) { ctx.Require(false, $"the work giver {giverName} threw on {defName} at ({x}, {z}): {e}"); }
            ctx.Require(job != null, $"the work giver {giverName} gives {nickname} no job on {defName} at ({x}, {z}): what it needs is missing or out of reach (an item on the map, not forbidden), the building is not in the state it accepts, or the colonist cannot do that work type ({giverDef.workType?.defName ?? "none"})");
            pawn.jobs.StartJob(job, JobCondition.InterruptForced);
            ctx.Assert(pawn.CurJob != null && pawn.CurJob.def == job.def, $"{nickname}'s job is {pawn.CurJob?.def.defName ?? "none"}, not {job.def.defName} (reserved or refused)");
        }

        /// <summary>
        /// Ticks a thing (by defName, at a cell) a number of times by calling its own <c>DoTick</c> (the game's one call per tick), so a building that works by ticks (a burn, a bake, a fuel that runs down) advances with no wait.
        /// Only that thing ticks: its comps do (fuel burns, a flickable...), colonists and the rest of the map do not. At most 100000. Fails when the thing is gone before the end. NOT PLAYED when written.
        /// </summary>
        [When("Nelim's Pickle Tools: the thing {string} at \\({int}, {int}\\) is ticked {int} times")]
        public void Ticked(PickleContext ctx, string defName, int x, int z, int times)
        {
            ctx.Require(times >= 1 && times <= 100000, $"the number of ticks is 1 to 100000, not {times}");
            Thing thing = ThingAt(ctx, Find.CurrentMap, defName, x, z);
            for (int i = 0; i < times; i++)
            {
                ctx.Require(!thing.Destroyed, $"the {defName} at ({x}, {z}) was destroyed after {i} ticks");
                thing.DoTick();
            }
        }

        /// <summary>
        /// Asserts a field (or property) of the thing, found by name on its class or a base class, public or not, reads the expected text, ignoring case; two numbers compare within 0.0001, a
        /// bool is True or False. The failure shows the value and lists the fields of the thing. NOT PLAYED when written.
        /// </summary>
        [Then("Nelim's Pickle Tools: the field {string} of the thing {string} at \\({int}, {int}\\) is {string}")]
        public void FieldIs(PickleContext ctx, string member, string defName, int x, int z, string expected)
        {
            Thing thing = ThingAt(ctx, Find.CurrentMap, defName, x, z);
            string actual = Read(ctx, thing, member);
            bool same = string.Equals(actual, expected, StringComparison.OrdinalIgnoreCase)
                || (double.TryParse(actual, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out double a)
                    && double.TryParse(expected, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out double e) && Math.Abs(a - e) < 0.0001);
            ctx.Assert(same, $"the field {member} of the {defName} at ({x}, {z}) reads '{actual}', not '{expected}'");
        }

        /// <summary>The same, for a number: asserts the field is at least a value.</summary>
        [Then("Nelim's Pickle Tools: the field {string} of the thing {string} at \\({int}, {int}\\) is at least {float}")]
        public void FieldAtLeast(PickleContext ctx, string member, string defName, int x, int z, float minimum)
        {
            Thing thing = ThingAt(ctx, Find.CurrentMap, defName, x, z);
            string actual = Read(ctx, thing, member);
            ctx.Require(double.TryParse(actual, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out double value), $"the field {member} of the {defName} reads '{actual}', not a number");
            ctx.Assert(value >= minimum - 0.0001, $"the field {member} of the {defName} at ({x}, {z}) reads {value}, under {minimum}");
        }

        /// <summary>The same, for a number: asserts the field is at most a value.</summary>
        [Then("Nelim's Pickle Tools: the field {string} of the thing {string} at \\({int}, {int}\\) is at most {float}")]
        public void FieldAtMost(PickleContext ctx, string member, string defName, int x, int z, float maximum)
        {
            Thing thing = ThingAt(ctx, Find.CurrentMap, defName, x, z);
            string actual = Read(ctx, thing, member);
            ctx.Require(double.TryParse(actual, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out double value), $"the field {member} of the {defName} reads '{actual}', not a number");
            ctx.Assert(value <= maximum + 0.0001, $"the field {member} of the {defName} at ({x}, {z}) reads {value}, over {maximum}");
        }

        /// <summary>
        /// Remembers the value of a field of the thing in the run (not in a save), to compare it after a save and reload, which makes a new object of the thing: see
        /// <c>the field ... has kept its remembered value</c>. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the field {string} of the thing {string} at \\({int}, {int}\\) is remembered")]
        public void Remember(PickleContext ctx, string member, string defName, int x, int z)
        {
            Thing thing = ThingAt(ctx, Find.CurrentMap, defName, x, z);
            Remembered[Key(member, defName, x, z)] = Read(ctx, thing, member);
        }

        /// <summary>Asserts the field reads what <c>is remembered</c> stored for it, after a save and reload for instance. Fails when nothing was remembered for it.</summary>
        [Then("Nelim's Pickle Tools: the field {string} of the thing {string} at \\({int}, {int}\\) has kept its remembered value")]
        public void KeptRemembered(PickleContext ctx, string member, string defName, int x, int z)
        {
            ctx.Require(Remembered.TryGetValue(Key(member, defName, x, z), out string before), $"no value was remembered for the field {member} of the {defName} at ({x}, {z}): use 'is remembered' first");
            Thing thing = ThingAt(ctx, Find.CurrentMap, defName, x, z);
            string after = Read(ctx, thing, member);
            bool same = string.Equals(before, after, StringComparison.OrdinalIgnoreCase)
                || (double.TryParse(before, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out double a)
                    && double.TryParse(after, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out double b) && Math.Abs(a - b) < 0.0001);
            ctx.Assert(same, $"the field {member} of the {defName} at ({x}, {z}) read '{before}' before and reads '{after}' now");
        }

        /// <summary>
        /// Sets a field of the thing (an int, a float, a bool, a string or an enum, by name, public or not) to a value, to stage a state (a half loaded kiln) with no job. The value is read back and
        /// must match. A field a mod keeps for a save is changed in memory only. Fails when the field is unknown (it lists them) or of another type. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the field {string} of the thing {string} at \\({int}, {int}\\) is set to {string}")]
        public void SetField(PickleContext ctx, string member, string defName, int x, int z, string value)
        {
            Thing thing = ThingAt(ctx, Find.CurrentMap, defName, x, z);
            FieldInfo field = FindField(thing.GetType(), member);
            ctx.Require(field != null, $"the {thing.GetType().Name} has no field '{member}'; it has: {Members(thing.GetType())}");
            object converted;
            try
            {
                Type type = field.FieldType;
                converted = type.IsEnum ? Enum.Parse(type, value, true) : Convert.ChangeType(value, type, System.Globalization.CultureInfo.InvariantCulture);
            }
            catch (Exception e)
            {
                ctx.Require(false, $"'{value}' is not a {field.FieldType.Name} for the field {member}: {e.Message}");
                return;
            }

            field.SetValue(thing, converted);
            ctx.Assert(string.Equals(Read(ctx, thing, member), Convert.ToString(converted, System.Globalization.CultureInfo.InvariantCulture), StringComparison.OrdinalIgnoreCase), $"the field {member} reads '{Read(ctx, thing, member)}' after it was set to '{value}'");
        }

        private static string Key(string member, string defName, int x, int z) => $"{defName}|{x}|{z}|{member}";

        private static Thing ThingAt(PickleContext ctx, Map map, string defName, int x, int z)
        {
            ctx.Require(map != null, "no map is loaded");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            Thing thing = cell.GetThingList(map).FirstOrDefault(t => t.def.defName == defName);
            ctx.Require(thing != null, $"no {defName} stands at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            return thing;
        }

        private static FieldInfo FindField(Type type, string name)
        {
            for (Type t = type; t != null; t = t.BaseType)
            {
                FieldInfo f = t.GetField(name, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly);
                if (f != null) return f;
            }

            return null;
        }

        private static string Read(PickleContext ctx, Thing thing, string member)
        {
            FieldInfo field = FindField(thing.GetType(), member);
            if (field != null) return Convert.ToString(field.GetValue(thing), System.Globalization.CultureInfo.InvariantCulture);
            for (Type t = thing.GetType(); t != null; t = t.BaseType)
            {
                PropertyInfo p = t.GetProperty(member, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly);
                if (p != null && p.GetIndexParameters().Length == 0 && p.CanRead) return Convert.ToString(p.GetValue(thing, null), System.Globalization.CultureInfo.InvariantCulture);
            }

            ctx.Require(false, $"the {thing.GetType().Name} has no field or property '{member}'; it has: {Members(thing.GetType())}");
            return null;
        }

        private static string Members(Type type)
        {
            var names = new List<string>();
            for (Type t = type; t != null && t != typeof(object) && t.Namespace != "Verse" && t.Namespace != "RimWorld"; t = t.BaseType)
            {
                names.AddRange(t.GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly).Select(f => f.Name));
                names.AddRange(t.GetProperties(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly).Select(p => p.Name));
            }

            return names.Count == 0 ? "(none outside the game's own classes)" : string.Join(", ", names.Distinct().Take(60));
        }
    }
}
