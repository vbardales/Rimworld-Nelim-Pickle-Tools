using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A batched "watch": advances the game tick by tick like "the game is advanced by N ticks" (ticks in a loop, about 40 ms per frame, so a slow lane still finishes) and, after EACH
    /// tick, looks at the things of one def: how many stand on the map, and the value of one field of each. Written 2026-11-17 for ACBaGE (firecracker chain on the slow 1.7 lane,
    /// 240 ticks one by one over 90 s). What it saw is kept for the assertions that follow. Played 2026-11-17: vanilla 1.6 and the 1.7 lane (ACBaGE, firecracker chain, 47 s).
    /// </summary>
    [PickleSteps]
    public class WatchSteps
    {
        private class Seen
        {
            public string DefName;
            public string Field;
            public readonly HashSet<string> Values = new HashSet<string>();
            public readonly HashSet<int> Things = new HashSet<int>();
            public int MostAtOnce;
            public int TicksDone;
        }

        private static readonly Dictionary<string, Seen> Watched = new Dictionary<string, Seen>();

        [AfterScenario]
        public void ForgetWatched() => Watched.Clear();

        private static string ValueOf(Thing thing, string field)
        {
            if (string.IsNullOrEmpty(field)) return "";
            const BindingFlags all = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance;
            object value = null;
            for (var type = thing.GetType(); type != null && value == null; type = type.BaseType)
            {
                FieldInfo f = type.GetField(field, all | BindingFlags.DeclaredOnly);
                if (f != null) { value = f.GetValue(thing); break; }
                PropertyInfo p = type.GetProperty(field, all | BindingFlags.DeclaredOnly);
                if (p != null && p.GetIndexParameters().Length == 0) { value = p.GetValue(thing, null); break; }
            }

            return value is Def def ? def.defName : value?.ToString() ?? "unset";
        }

        /// <summary>
        /// Advances the game by N ticks in batches (the main thread, about 40 ms of ticks per frame, 280 s at most, like "the game is advanced by N ticks") and after every tick reads the things of a
        /// def on the current map: the most standing at once, every thing seen (by id) and, when a field name is given (a public or private field or property of the thing, found by name up its class
        /// chain; a def is read as its defName), every value of that field seen. Pass an empty string as the field to count only. Logs <c>[ticks-watched]</c>.
        /// </summary>
        [When("Nelim's Pickle Tools: the game is advanced by {int} ticks watching the field {string} of the things of def {string}", TimeoutSeconds = 295f)]
        public async System.Threading.Tasks.Task AdvanceWatching(PickleContext ctx, int ticks, string field, string defName)
        {
            await LookSteps.OnMainThread(ctx);
            ctx.Require(ticks > 0, "the number of ticks must be above 0");
            ctx.Require(Current.ProgramState == ProgramState.Playing && Find.TickManager != null && Find.CurrentMap != null, "no game is playing");
            ThingDef def = DefDatabase<ThingDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no thing def '{defName}' in this game");
            var seen = new Seen { DefName = defName, Field = field };
            Watched[defName] = seen;
            int start = Find.TickManager.TicksGame;
            var clock = Stopwatch.StartNew();
            while (Find.TickManager.TicksGame - start < ticks && clock.Elapsed.TotalSeconds < 280)
            {
                await LookSteps.OnMainThread(ctx);
                var slice = Stopwatch.StartNew();
                while (Find.TickManager.TicksGame - start < ticks && slice.ElapsedMilliseconds < 40)
                {
                    Find.TickManager.DoSingleTick();
                    List<Thing> present = Find.CurrentMap.listerThings.ThingsOfDef(def).ToList();
                    if (present.Count > seen.MostAtOnce) seen.MostAtOnce = present.Count;
                    foreach (Thing t in present)
                    {
                        seen.Things.Add(t.thingIDNumber);
                        if (!string.IsNullOrEmpty(field)) seen.Values.Add(ValueOf(t, field));
                    }
                }

                await ctx.WaitFrames(1);
            }

            await LookSteps.OnMainThread(ctx);
            TickSteps.SnapPawnDrawPositions();
            seen.TicksDone = Find.TickManager.TicksGame - start;
            string values = seen.Values.Count == 0 ? "none" : string.Join(", ", seen.Values.OrderBy(v => v));
            Log.Message($"[ticks-watched] {defName}: {seen.TicksDone} of {ticks} ticks in {clock.Elapsed.TotalSeconds:0.0} s; seen {seen.Things.Count} thing(s), most at once {seen.MostAtOnce}; field '{field}' values: {values}");
            ctx.Attach("ticks watched", $"{defName}: {seen.TicksDone} ticks; seen {seen.Things.Count}, most at once {seen.MostAtOnce}; field '{field}' values: {values}");
            ctx.Assert(seen.TicksDone >= ticks, $"only {seen.TicksDone} of {ticks} ticks were run in {clock.Elapsed.TotalSeconds:0} s");
        }

        private static Seen Get(PickleContext ctx, string defName)
        {
            ctx.Require(Watched.TryGetValue(defName, out Seen seen), $"nothing was watched for '{defName}': add 'the game is advanced by N ticks watching the field ... of the things of def \"{defName}\"' before");
            return seen;
        }

        /// <summary>Asserts that the watched things of a def showed a value of the watched field at some tick.</summary>
        [Then("Nelim's Pickle Tools: the watched things of def {string} showed the value {string}")]
        public void ShowedValue(PickleContext ctx, string defName, string value)
        {
            Seen seen = Get(ctx, defName);
            ctx.Assert(seen.Values.Contains(value), $"no '{value}' was seen in field '{seen.Field}' of {defName}; values seen: {(seen.Values.Count == 0 ? "none" : string.Join(", ", seen.Values.OrderBy(v => v)))}");
        }

        /// <summary>Asserts that the watched things of a def never showed a value of the watched field.</summary>
        [Then("Nelim's Pickle Tools: the watched things of def {string} never showed the value {string}")]
        public void NeverShowedValue(PickleContext ctx, string defName, string value)
        {
            Seen seen = Get(ctx, defName);
            ctx.Assert(!seen.Values.Contains(value), $"'{value}' was seen in field '{seen.Field}' of {defName}; values seen: {string.Join(", ", seen.Values.OrderBy(v => v))}");
        }

        /// <summary>Asserts that at most N of the watched things of a def stood on the map at once.</summary>
        [Then("Nelim's Pickle Tools: at most {int} of the watched things of def {string} stood at once")]
        public void AtMostAtOnce(PickleContext ctx, int max, string defName)
        {
            Seen seen = Get(ctx, defName);
            ctx.Assert(seen.MostAtOnce <= max, $"{seen.MostAtOnce} of {defName} stood at once, more than {max}");
        }

        /// <summary>Asserts that the watched things of a def were seen in a number of distinct things (by id) between two bounds.</summary>
        [Then("Nelim's Pickle Tools: between {int} and {int} distinct things of def {string} were seen while watching")]
        public void DistinctSeen(PickleContext ctx, int min, int max, string defName)
        {
            Seen seen = Get(ctx, defName);
            ctx.Assert(seen.Things.Count >= min && seen.Things.Count <= max, $"{seen.Things.Count} distinct {defName} were seen, not between {min} and {max}");
        }
    }
}
