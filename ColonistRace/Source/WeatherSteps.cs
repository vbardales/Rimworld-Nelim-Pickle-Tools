using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Sets the weather of the current map so that it shows at once. The game fades a new weather in over 4000 ticks (WeatherManager.TransitionTicks,
    /// curWeatherAge) and a paused game never ticks, so after Pickle's <c>I set the weather to</c> the picture and the status line still show the
    /// PREVIOUS weather (found 2026-10-26: each weather photograph of the gallery showed the weather before it). This step starts the transition, then
    /// makes the new weather the last one and the age full. Written 2026-10-26. NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class WeatherSteps
    {
        [Given("Nelim's Pickle Tools: the weather is set at once to {string}")]
        public void SetWeatherAtOnce(PickleContext ctx, string defName)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            WeatherDef def = DefDatabase<WeatherDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no weather '{defName}'");
            WeatherManager wm = map.weatherManager;
            wm.TransitionTo(def);
            wm.lastWeather = def;
            wm.curWeather = def;
            wm.curWeatherAge = (int)WeatherManager.TransitionTicks;
            ctx.Assert(wm.curWeather == def && wm.CurWeatherPerceived == def, $"the weather reads {wm.CurWeatherPerceived?.defName} after the step, not {defName}");
        }

        /// <summary>Starts a game condition (HeatWave, ColdSnap, Drought, ...) on the current map for 3 days, like an incident would. Does nothing new when the condition is already active; fails when the def does not exist or the map is not loaded.</summary>
        [Given("Nelim's Pickle Tools: the game condition {string} is started")]
        public void StartGameCondition(PickleContext ctx, string defName)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            GameConditionDef def = DefDatabase<GameConditionDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no game condition '{defName}'");
            if (!map.gameConditionManager.ConditionIsActive(def))
                map.gameConditionManager.RegisterCondition(GameConditionMaker.MakeCondition(def, 3 * GenDate.TicksPerDay));
            ctx.Assert(map.gameConditionManager.ConditionIsActive(def), $"the game condition {defName} is not active after the step");
        }

        /// <summary>Ends every active condition of a def on the current map (PsychicSoothe, HeatWave, ...), so its sky tint and effects are gone. Fails when the def does not exist or the map is not loaded; does nothing when the condition is not active. Written 2026-11-12, NOT PLAYED.</summary>
        [Given("Nelim's Pickle Tools: the game condition {string} is ended")]
        public void EndGameCondition(PickleContext ctx, string defName)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            GameConditionDef def = DefDatabase<GameConditionDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no game condition '{defName}'");
            GameCondition cond;
            while ((cond = map.gameConditionManager.GetActiveCondition(def)) != null)
                cond.End();
            ctx.Assert(!map.gameConditionManager.ConditionIsActive(def), $"the game condition {defName} is still active after the step");
        }

        /// <summary>Marks every graphic of a colonist dirty so the game rebuilds the body, head, hair and apparel nodes on the next draw (after a gene, body type or def change made in a paused game). Written 2026-11-12, NOT PLAYED.</summary>
        [Given("Nelim's Pickle Tools: the graphics of {string} are refreshed")]
        public void RefreshGraphics(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.Drawer?.renderer != null, $"pawn '{nickname}' has no renderer");
            pawn.Drawer.renderer.SetAllGraphicsDirty();
        }
    }
}
