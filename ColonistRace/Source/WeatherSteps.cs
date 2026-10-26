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
    }
}
