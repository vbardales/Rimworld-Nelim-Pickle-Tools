using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using HarmonyLib;
using RimWorld;
using RimWorks.Pickle;
using VEF.Factions;
using Verse;

namespace Nelim.PickleTools.VefFactions
{
    /// <summary>
    /// Steps around Vanilla Expanded Framework's new faction window. The scenarios do not rely on a
    /// fixture that happens to lack a faction: they pick one the loaded world lacks, take it off
    /// VEF's ignored list, and run VEF's own load check again — the method its
    /// GameComponentUtility.LoadedGame postfix queues after every load.
    /// </summary>
    [PickleSteps]
    public class FactionSteps
    {
        private const string LoadedGamePatch = "VEF.Factions.VanillaExpandedFramework_GameComponentUtility_LoadedGame_Patch+LoadedGame";

        private sealed class Chosen
        {
            public FactionDef Def;
        }

        // A required marker a scenario put on a def, taken off again whatever happens. Static: the
        // def outlives the game, so a failed scenario must not leave the marker for the next one.
        private static FactionDef markedDef;
        private static FactionDefExtension markedExtension;

        [When("Nelim's Pickle Tools: the load has settled")]
        public async Task Settled(PickleContext ctx)
        {
            // VEF runs its check through LongEventHandler.ExecuteWhenFinished, after the load itself.
            await ctx.WaitUntil(() => !LongEventHandler.AnyEventNowOrWaiting, 60f);
            await ctx.WaitFrames(3);
        }

        // ---------------------------------------------------------------- the chosen faction

        [Given("Nelim's Pickle Tools: a faction the world lacks is chosen")]
        public void Choose(PickleContext ctx)
        {
            ctx.Require(Current.Game != null && Find.World != null, "load a save first");
            var present = new HashSet<FactionDef>(Find.FactionManager.AllFactions.Select(f => f.def));
            var def = DefDatabase<FactionDef>.AllDefs
                .Where(d => !d.isPlayer && !d.hidden && !present.Contains(d) && !NewFactionSpawningUtility.NeverSpawn(d))
                .Where(d =>
                {
                    var forced = FactionDefExtension.Get(d).forcedFactionData;
                    return !forced.forceAddFactionIfMissing && !forced.forcePlayerToAddFactionIfMissing;
                })
                .OrderBy(d => d.defName)
                .FirstOrDefault();
            ctx.Require(def != null, "every visible faction of this mod list is already in the world: nothing for VEF to offer");

            // Loading the fixture already ran the check, and the mod ignored the faction then.
            IgnoredSet().Remove(def);
            ctx.Set(new Chosen { Def = def });
        }

        [Given("Nelim's Pickle Tools: the chosen faction is marked required by its mod")]
        public void MarkRequired(PickleContext ctx)
        {
            var def = ctx.Get<Chosen>().Def;
            ctx.Require(def.GetModExtension<FactionDefExtension>() == null,
                $"{def.defName} already carries a FactionDefExtension; marking it would overwrite its mod's own");
            markedExtension = new FactionDefExtension();
            markedExtension.forcedFactionData.forcePlayerToAddFactionIfMissing = true;
            def.modExtensions ??= new List<DefModExtension>();
            def.modExtensions.Add(markedExtension);
            markedDef = def;
        }

        [AfterScenario]
        public void Unmark(PickleContext ctx)
        {
            markedDef?.modExtensions?.Remove(markedExtension);
            markedDef = null;
            markedExtension = null;
        }

        [When("Nelim's Pickle Tools: VEF runs its new faction check")]
        public async Task RunCheck(PickleContext ctx)
        {
            var method = AccessTools.Method(AccessTools.TypeByName(LoadedGamePatch), "OnGameLoaded");
            ctx.Require(method != null, $"{LoadedGamePatch}.OnGameLoaded not found: VEF changed");
            method.Invoke(null, null);
            await ctx.WaitFrames(3);
        }

        // ---------------------------------------------------------------- outcomes

        [Then("Nelim's Pickle Tools: no new faction window is open")]
        public void NoWindow(PickleContext ctx)
        {
            var open = Windows().Select(DefOf).ToList();
            ctx.Assert(open.Count == 0, $"new faction windows open for: {string.Join(", ", open.Select(d => d?.defName))}");
        }

        [Then("Nelim's Pickle Tools: a new faction window is open for the chosen faction")]
        public void WindowForChosen(PickleContext ctx)
        {
            var def = ctx.Get<Chosen>().Def;
            var open = Windows().Select(DefOf).ToList();
            ctx.Assert(open.Contains(def), $"no window for {def.defName}; open for: {string.Join(", ", open.Select(d => d?.defName))}");
        }

        [Then("Nelim's Pickle Tools: the chosen faction is ignored in this save")]
        public void Ignored(PickleContext ctx)
        {
            var def = ctx.Get<Chosen>().Def;
            ctx.Assert(NewFactionSpawningState.Instance.IsIgnored(def), $"{def.defName} is not on VEF's ignored list");
        }

        [Then("Nelim's Pickle Tools: the chosen faction is not ignored")]
        public void NotIgnored(PickleContext ctx)
        {
            var def = ctx.Get<Chosen>().Def;
            ctx.Assert(!NewFactionSpawningState.Instance.IsIgnored(def), $"{def.defName} is on VEF's ignored list");
        }

        [Then("Nelim's Pickle Tools: the game log says the chosen faction was ignored")]
        public void Logged(PickleContext ctx)
        {
            var needle = $"[Quiet New Factions] {ctx.Get<Chosen>().Def.defName} (";
            ctx.Assert(Log.Messages.Any(m => m.text != null && m.text.Contains(needle)), $"no log line starting '{needle}'");
        }

        // ---------------------------------------------------------------- helpers

        private static IEnumerable<Dialog_NewFactionSpawning> Windows() =>
            Find.WindowStack.Windows.OfType<Dialog_NewFactionSpawning>();

        private static FactionDef DefOf(Dialog_NewFactionSpawning w) =>
            Traverse.Create(w).Field("factionDef").GetValue<FactionDef>();

        private static HashSet<FactionDef> IgnoredSet() =>
            Traverse.Create(NewFactionSpawningState.Instance).Field("ignoredFactions").GetValue<HashSet<FactionDef>>();
    }
}
