using System;
using System.Collections.Generic;
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
    /// Steps for a mod that hands a colonist a thing to use on an animal (a serum, a genepack) and checks the outcome: a genepack of chosen genes, a
    /// thing spawned with a field set from a def, a job on a pawn with a thing as second target, the float-menu options of a colonist on a pawn, a
    /// hediff that is absent, a thing that exists or is gone, and a mark on the error log. Asked for by ACG (Animal Cosmetic Genes) on 2026-10-31.
    /// NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class SerumChainSteps
    {
        private static int errorsSeen;
        private static readonly List<string> errorTexts = new List<string>();
        private static int mark;
        private static bool hooked;

        private static void Hook()
        {
            if (hooked) return;
            hooked = true;
            Application.logMessageReceived += (text, stack, type) =>
            {
                if (type != LogType.Error && type != LogType.Exception && type != LogType.Assert) return;
                errorsSeen++;
                errorTexts.Add(text.Length > 200 ? text.Substring(0, 200) : text);
            };
        }

        /// <summary>
        /// Starts counting the errors the game logs (Log.Error and exceptions) from this point. Put it right after the save is loaded. The step
        /// 'no error was logged since the error log was marked' then reads the count. Several marks: the last one counts.
        /// </summary>
        [Given("Nelim's Pickle Tools: the error log is marked")]
        public void MarkErrorLog(PickleContext ctx)
        {
            Hook();
            mark = errorsSeen;
        }

        /// <summary>Fails when the game logged an error after the last mark; the failure quotes the first three. Fails too when nothing was marked.</summary>
        [Then("Nelim's Pickle Tools: no error was logged since the error log was marked")]
        public void NoErrorSinceMark(PickleContext ctx)
        {
            ctx.Require(hooked, "the error log was never marked: add 'the error log is marked' after the save is loaded");
            int n = errorsSeen - mark;
            ctx.Assert(n == 0, $"{n} error(s) logged since the mark: " + string.Join(" | ", errorTexts.Skip(mark).Take(3)));
        }

        /// <summary>
        /// Fails when the game's own message queue (<c>Log.Messages</c>, the last 1000 messages the in-game debug log keeps) holds an error: config
        /// errors, XML errors, exceptions raised while the defs and the save loaded. Put it first in the scenario, after the save is loaded. The
        /// failure quotes the first three and says how many there are. A queue that already overflowed may have dropped the oldest.
        /// </summary>
        [Then("Nelim's Pickle Tools: no error was logged while the game loaded")]
        public void NoErrorWhileLoading(PickleContext ctx)
        {
            List<string> errors = Log.Messages.Where(m => m.type == LogMessageType.Error).Select(m => m.text).ToList();
            ctx.Assert(errors.Count == 0, $"{errors.Count} error(s) in the game's message queue ({Log.Messages.Count()} messages kept): "
                + string.Join(" | ", errors.Take(3).Select(e => e.Length > 200 ? e.Substring(0, 200) : e)));
        }

        /// <summary>Asserts a pawn (colonist or animal, by short name) holds no hediff of that def.</summary>
        [Then("Nelim's Pickle Tools: {string} does not hold the hediff {string}")]
        public void DoesNotHoldHediff(PickleContext ctx, string name, string hediffName)
        {
            Pawn pawn = RequirePawn(ctx, name);
            ctx.Assert(!pawn.health.hediffSet.hediffs.Any(h => h.def.defName == hediffName),
                $"pawn '{name}' holds the hediff '{hediffName}'");
        }

        /// <summary>Asserts a thing of a def (by defName) lies on a cell of the current map.</summary>
        [Then("Nelim's Pickle Tools: the thing {string} exists at \\({int}, {int}\\)")]
        public void ThingExists(PickleContext ctx, string defName, int x, int z)
        {
            Map map = RequireMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            ctx.Assert(cell.GetThingList(map).Any(t => t.def.defName == defName),
                $"no {defName} at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
        }

        /// <summary>Asserts no thing of a def (by defName) lies on a cell of the current map.</summary>
        [Then("Nelim's Pickle Tools: the thing {string} is gone from \\({int}, {int}\\)")]
        public void ThingGone(PickleContext ctx, string defName, int x, int z)
        {
            Map map = RequireMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            ctx.Assert(!cell.GetThingList(map).Any(t => t.def.defName == defName), $"a {defName} still lies at ({x}, {z})");
        }

        /// <summary>
        /// Puts a genepack (Biotech) holding the genes of a comma list of GeneDef defNames on a cell, near it when the cell is taken. Fails when
        /// Biotech is not loaded, a gene is unknown, or the pack cannot be placed.
        /// </summary>
        [Given("Nelim's Pickle Tools: a genepack with the genes {string} is spawned at \\({int}, {int}\\)")]
        public void GenepackSpawned(PickleContext ctx, string geneList, int x, int z)
        {
            Map map = RequireMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            ThingDef packDef = DefDatabase<ThingDef>.GetNamedSilentFail("Genepack");
            ctx.Require(packDef != null, "no ThingDef 'Genepack': Biotech is not loaded");
            var genes = new List<GeneDef>();
            foreach (string name in geneList.Split(',').Select(s => s.Trim()).Where(s => s.Length > 0))
            {
                GeneDef gene = DefDatabase<GeneDef>.GetNamedSilentFail(name);
                ctx.Require(gene != null, $"no GeneDef named '{name}'");
                genes.Add(gene);
            }
            ctx.Require(genes.Count > 0, "the gene list is empty");
            var pack = ThingMaker.MakeThing(packDef) as Genepack;
            ctx.Require(pack != null, "the Genepack def does not make a Genepack");
            pack.Initialize(genes);
            GenPlace.TryPlaceThing(pack, cell, map, ThingPlaceMode.Near);
            ctx.Assert(pack.Spawned, $"the genepack could not be placed near ({x}, {z})");
        }

        /// <summary>
        /// Puts a thing of a def (by defName, default stuff) on a cell and sets one field of it (looked for on its class and its base classes,
        /// private fields included) to a def of the field's type, by defName, before it is placed. For a thing that keeps a GeneDef or a ThingDef
        /// in a field. Fails when the def or the field is unknown (the failure names the class), the field is not of a Def type, or the def does not exist.
        /// </summary>
        [Given("Nelim's Pickle Tools: the item {string} is spawned at \\({int}, {int}\\) with the field {string} set to the def {string}")]
        public void SpawnedWithField(PickleContext ctx, string defName, int x, int z, string fieldName, string valueName)
        {
            Map map = RequireMap(ctx);
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            Thing thing = ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def));
            FieldInfo field = null;
            for (Type t = thing.GetType(); t != null && field == null; t = t.BaseType)
            {
                field = t.GetField(fieldName, BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly);
            }
            ctx.Require(field != null, $"the class {thing.GetType().FullName} and its base classes have no field '{fieldName}'");
            ctx.Require(typeof(Def).IsAssignableFrom(field.FieldType), $"the field '{fieldName}' is a {field.FieldType.Name}, not a Def");
            MethodInfo lookup = typeof(DefDatabase<>).MakeGenericType(field.FieldType).GetMethod("GetNamedSilentFail", BindingFlags.Public | BindingFlags.Static);
            object value = lookup.Invoke(null, new object[] { valueName });
            ctx.Require(value != null, $"no {field.FieldType.Name} named '{valueName}'");
            field.SetValue(thing, value);
            GenPlace.TryPlaceThing(thing, cell, map, ThingPlaceMode.Near);
            ctx.Assert(thing.Spawned, $"{defName} could not be placed near ({x}, {z})");
        }

        /// <summary>
        /// Spawns a fully built building of a def (by defName, default stuff, facing north) of the player faction, not a blueprint, with the cell as
        /// its position (the centre cell of its footprint; a 3x1 bench lies on x-1, x, x+1). Fails, naming the cells, when the def is not a building,
        /// or when a cell of the footprint is outside the map, impassable, bears another building or cannot be built on. Asked for by ACG (the serum
        /// bench of its chain scenario). NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the building {string} is spawned at \\({int}, {int}\\)")]
        public void BuildingSpawned(PickleContext ctx, string defName, int x, int z)
        {
            Map map = RequireMap(ctx);
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no ThingDef named '{defName}'");
            ctx.Require(def.category == ThingCategory.Building && def.thingClass != null && !def.IsBlueprint && !def.IsFrame, $"{defName} is not a building def");
            var cell = new IntVec3(x, 0, z);
            Rot4 rot = Rot4.North;
            var blocked = new List<string>();
            foreach (IntVec3 c in GenAdj.OccupiedRect(cell, rot, def.size))
            {
                if (!c.InBounds(map)) { blocked.Add($"({c.x}, {c.z}) outside the map"); continue; }
                if (c.Impassable(map)) { blocked.Add($"({c.x}, {c.z}) impassable"); continue; }
                Building edifice = c.GetEdifice(map);
                if (edifice != null) { blocked.Add($"({c.x}, {c.z}) holds {edifice.def.defName}"); continue; }
                if (!GenConstruct.CanBuildOnTerrain(def, c, map, rot)) blocked.Add($"({c.x}, {c.z}) terrain {c.GetTerrain(map).defName} cannot carry it");
            }
            ctx.Require(blocked.Count == 0, $"{defName} does not fit at ({x}, {z}) (size {def.size.x}x{def.size.z}): " + string.Join("; ", blocked));
            Thing thing = ThingMaker.MakeThing(def, GenStuff.DefaultStuffFor(def));
            thing.SetFactionDirect(Faction.OfPlayer);
            GenSpawn.Spawn(thing, cell, map, rot);
            Log.Message($"[serum] {defName} spawned at ({x}, {z}), footprint {GenAdj.OccupiedRect(cell, rot, def.size)}");
            ctx.Assert(thing.Spawned && thing.Faction == Faction.OfPlayer, $"{defName} did not spawn at ({x}, {z}) as a player building");
        }

        /// <summary>
        /// Starts a job by force on a colonist with a pawn (colonist or animal, by short name) as the first target and the first thing of a def lying
        /// at a cell as the second. The colonist is not moved. Fails when the colonist, the pawn, the job or the thing is unknown, or the job does not
        /// become the current job (refused for these targets: reserved, unreachable, a fail condition).
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} is forced into the job {string} on {string} with the item {string} at \\({int}, {int}\\)")]
        public void ForcedJobWithItem(PickleContext ctx, string nickname, string jobName, string targetName, string defName, int x, int z)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Map map = RequireMap(ctx);
            Pawn target = RequirePawn(ctx, targetName);
            JobDef jobDef = DefDatabase<JobDef>.GetNamedSilentFail(jobName);
            ctx.Require(jobDef != null, $"no JobDef named '{jobName}'");
            var cell = new IntVec3(x, 0, z);
            ctx.Require(cell.InBounds(map), $"the cell ({x}, {z}) is outside the map");
            Thing item = cell.GetThingList(map).FirstOrDefault(t => t.def.defName == defName);
            ctx.Require(item != null, $"no {defName} lies at ({x}, {z}); there is " + string.Join(", ", cell.GetThingList(map).Select(t => t.def.defName)));
            ctx.Require(pawn.jobs != null && pawn.Spawned, $"{nickname} is not a spawned pawn with a job tracker");
            pawn.jobs.StartJob(JobMaker.MakeJob(jobDef, target, item), JobCondition.InterruptForced);
            Log.Message($"[serum] {nickname} forced into {jobDef.defName} on {targetName} with {defName}, job now {pawn.CurJob?.def.defName ?? "none"}");
            ctx.Assert(pawn.CurJob != null && pawn.CurJob.def == jobDef,
                $"{nickname}'s job is {pawn.CurJob?.def.defName ?? "none"}, not {jobDef.defName} (the job did not start: refused for these targets)");
        }

        /// <summary>
        /// Logs the float-menu options a colonist gets on a right-click on a pawn: one line <c>[float-menu] label | enabled</c> or <c>| disabled</c>
        /// per option (a disabled option carries its reason in the label). Fails when the colonist or the pawn is unknown.
        /// </summary>
        [Then("Nelim's Pickle Tools: the float menu options of {string} on {string} are listed")]
        public void FloatMenuListed(PickleContext ctx, string nickname, string targetName)
        {
            foreach (FloatMenuOption o in Options(ctx, nickname, targetName))
            {
                Log.Message($"[float-menu] {o.Label.StripTags()} | {(o.Disabled ? "disabled" : "enabled")}");
            }
        }

        /// <summary>
        /// Picks the float-menu option of a colonist on a pawn by its label text (exact first, then the first label that contains the text, tags
        /// ignored) and runs it. Fails when no label matches (the failure lists them) or the option is disabled (the failure gives its label).
        /// </summary>
        [When("Nelim's Pickle Tools: {string} picks the float menu option {string} on {string}")]
        public void FloatMenuPick(PickleContext ctx, string nickname, string label, string targetName)
        {
            List<FloatMenuOption> options = Options(ctx, nickname, targetName);
            FloatMenuOption o = Match(options, label);
            ctx.Require(o != null, $"{nickname} has no float menu option '{label}' on {targetName}; options: " + string.Join(" | ", options.Select(x => x.Label.StripTags())));
            ctx.Require(!o.Disabled, $"the option '{o.Label.StripTags()}' is disabled for {nickname} on {targetName}");
            o.Chosen(true, null);
        }

        /// <summary>Passes when the option exists and is disabled; logs its label, which carries the reason in brackets.</summary>
        [Then("Nelim's Pickle Tools: {string} cannot pick the float menu option {string} on {string}")]
        public void FloatMenuDisabled(PickleContext ctx, string nickname, string label, string targetName)
        {
            List<FloatMenuOption> options = Options(ctx, nickname, targetName);
            FloatMenuOption o = Match(options, label);
            ctx.Require(o != null, $"{nickname} has no float menu option '{label}' on {targetName}; options: " + string.Join(" | ", options.Select(x => x.Label.StripTags())));
            Log.Message($"[float-menu] {o.Label.StripTags()} | {(o.Disabled ? "disabled" : "enabled")}");
            ctx.Assert(o.Disabled, $"the option '{o.Label.StripTags()}' is enabled for {nickname} on {targetName}");
        }

        private static FloatMenuOption Match(List<FloatMenuOption> options, string label)
        {
            return options.FirstOrDefault(o => string.Equals(o.Label.StripTags(), label, StringComparison.OrdinalIgnoreCase))
                ?? options.FirstOrDefault(o => o.Label.StripTags().IndexOf(label, StringComparison.OrdinalIgnoreCase) >= 0);
        }

        private static List<FloatMenuOption> Options(PickleContext ctx, string nickname, string targetName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            Pawn target = RequirePawn(ctx, targetName);
            ctx.Require(pawn.Spawned, $"{nickname} is not spawned");
            return FloatMenuMakerMap.GetOptions(new List<Pawn> { pawn }, target.DrawPos, out FloatMenuContext _);
        }

        private static Map RequireMap(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            return map;
        }

        private static Pawn RequirePawn(PickleContext ctx, string name)
        {
            Map map = RequireMap(ctx);
            Pawn pawn = map.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p.Name != null && string.Equals(p.LabelShort, name, StringComparison.OrdinalIgnoreCase));
            ctx.Require(pawn != null, $"no pawn named '{name}' is on the current map");
            return pawn;
        }
    }
}
