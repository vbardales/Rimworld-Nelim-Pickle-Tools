using System;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using RimWorld.Planet;
using Verse;

namespace Nelim.PickleTools.NewColony
{
    /// <summary>
    /// Starts a NEW colony from the main menu, so a suite can play what no saved game reaches: the first minutes of a colony.
    ///
    /// How: it does what the game's own developer quick start does (<c>Root_Play.SetupForQuickTestPlay</c>, read from
    /// Assembly-CSharp on 2026-09-25) with the choices fixed instead of random, then hands over to the same path the last
    /// page of the new-colony screens takes (<c>PageUtility.InitGameStart</c>): the scene "Play" is loaded and
    /// <c>Game.InitNewGame</c> generates the map. The world, the starting tile and the colonists are drawn under a seeded
    /// random state, so the same seed gives the same world and the same starting tile.
    ///
    /// Choices are set by their own steps before the start step and put back after the scenario: scenario (default
    /// Crashlanded), storyteller (Cassandra), difficulty (Rough), map size (75), seed. Nothing is written to disk.
    ///
    /// Every pattern starts with "Nelim's Pickle Tools:" so that it cannot be ambiguous with a step of Pickle's own.
    /// </summary>
    [PickleSteps]
    public class NewColonySteps
    {
        private const string DefaultSeed = "picklecolony";
        private const int DefaultMapSize = 75;

        // A small world: the game's quick start asks for 30 percent, which is far more than a map needs and slow under the
        // software renderer of the WSL install.
        private const float WorldCoverage = 0.05f;

        private static string seed = DefaultSeed;
        private static int mapSize = DefaultMapSize;
        private static string scenario = "Crashlanded";
        private static string storyteller = "Cassandra";
        private static string difficulty = "Rough";

        [Given("Nelim's Pickle Tools: the new colony's seed is {string}")]
        public void SetSeed(PickleContext ctx, string value)
        {
            ctx.Assert(!string.IsNullOrWhiteSpace(value), "a seed is a word, not an empty text");
            seed = value;
        }

        [Given("Nelim's Pickle Tools: the new colony's map size is {int}")]
        public void SetMapSize(PickleContext ctx, int size)
        {
            ctx.Assert(size >= 25 && size <= 500, $"a map size between 25 and 500 cells a side, not {size}");
            mapSize = size;
        }

        [Given("Nelim's Pickle Tools: the new colony's scenario is {string}")]
        public void SetScenario(PickleContext ctx, string defName)
        {
            scenario = defName;
        }

        [Given("Nelim's Pickle Tools: the new colony's storyteller is {string}")]
        public void SetStoryteller(PickleContext ctx, string defName)
        {
            storyteller = defName;
        }

        [Given("Nelim's Pickle Tools: the new colony's difficulty is {string}")]
        public void SetDifficulty(PickleContext ctx, string defName)
        {
            difficulty = defName;
        }

        [Given("Nelim's Pickle Tools: a new colony is started", TimeoutSeconds = 300)]
        public async Task Start(PickleContext ctx)
        {
            ctx.Require(
                Current.ProgramState == ProgramState.Entry,
                $"a new colony starts from the main menu, and the game is at {Current.ProgramState}: begin the scenario with 'the main menu is open'");

            ScenarioDef scenarioDef = Lookup<ScenarioDef>(ctx, scenario, "scenario");
            StorytellerDef storytellerDef = Lookup<StorytellerDef>(ctx, storyteller, "storyteller");
            DifficultyDef difficultyDef = Lookup<DifficultyDef>(ctx, difficulty, "difficulty");

            Game.ClearCaches();
            Current.Game = new Game();
            Current.Game.InitData = new GameInitData();
            Current.Game.InitData.startedFromEntry = true;
            Current.Game.Scenario = scenarioDef.scenario;
            Find.Scenario.PreConfigure();
            Current.Game.storyteller = new Storyteller(storytellerDef, difficultyDef);

            // The random state is seeded for everything that draws: the world (which also takes the seed as text), the tile,
            // and the colonists the scenario generates while it is chosen.
            Rand.PushState(GenText.StableStringHash(seed));
            try
            {
                Current.Game.World = WorldGenerator.GenerateWorld(
                    WorldCoverage, seed, OverallRainfall.Normal, OverallTemperature.Normal, OverallPopulation.Normal, LandmarkDensity.Normal);
                Find.GameInitData.ChooseRandomStartingTile();
                Find.GameInitData.mapSize = mapSize;
                Find.Scenario.PostIdeoChosen();
            }
            finally
            {
                Rand.PopState();
            }

            // The last page of the new-colony screens does exactly this: it queues the scene change and the map generation.
            PageUtility.InitGameStart();

            var clock = Stopwatch.StartNew();
            while (!IsPlayable())
            {
                ctx.Assert(
                    clock.Elapsed.TotalSeconds < 280,
                    $"the new colony was not playable after {clock.Elapsed.TotalSeconds:0} s: program state {Current.ProgramState}, " +
                    $"map {(Current.Game?.CurrentMap != null ? "present" : "absent")}, long event {(LongEventHandler.AnyEventNowOrWaiting ? "still running" : "over")}");
                await ctx.WaitFrames(5);
            }

            Find.TickManager.CurTimeSpeed = TimeSpeed.Paused;

            string colonists = string.Join(", ", Find.CurrentMap.mapPawns.FreeColonists.Select(pawn => pawn.LabelShortCap));
            ctx.Attach(
                "new-colony",
                $"scenario {scenarioDef.defName}, storyteller {storytellerDef.defName}, difficulty {difficultyDef.defName}, seed \"{seed}\", " +
                $"map {mapSize} by {mapSize}, tile {Find.GameInitData?.startingTile.ToString() ?? Find.CurrentMap.Tile.ToString()}, " +
                $"{Find.CurrentMap.mapPawns.FreeColonistsCount} colonists ({colonists}), paused, generated in {clock.Elapsed.TotalSeconds:0.0} s");
        }

        // The choices are the scenario's own: what one scenario sets does not reach the next.
        [AfterScenario]
        public void Reset()
        {
            seed = DefaultSeed;
            mapSize = DefaultMapSize;
            scenario = "Crashlanded";
            storyteller = "Cassandra";
            difficulty = "Rough";
        }

        private static bool IsPlayable()
        {
            return Current.ProgramState == ProgramState.Playing
                   && Current.Game != null
                   && Current.Game.CurrentMap != null
                   && !LongEventHandler.AnyEventNowOrWaiting;
        }

        private static T Lookup<T>(PickleContext ctx, string defName, string what) where T : Def
        {
            T def = DefDatabase<T>.GetNamedSilentFail(defName);
            ctx.Assert(
                def != null,
                $"no {what} named \"{defName}\"; the game has: " + string.Join(", ", DefDatabase<T>.AllDefsListForReading.Select(d => d.defName).Take(30)));
            return def;
        }
    }
}
