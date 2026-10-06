using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>Reads the light of the current map so that a dark capture can be explained: the local hour, the sun glow, the weather, and whether the sky is dark.</summary>
    [PickleSteps]
    public class LightSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";

        [Then(Prefix + "the light of the map is logged")]
        public void LogLight(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            float glow = GenCelestial.CurCelestialSunGlow(map);
            Log.Message("[light] hour " + GenLocalDate.HourInteger(map) + " (day " + GenLocalDate.DayOfYear(map) + "), game ticks " + Find.TickManager.TicksGame
                + ", sun glow " + glow.ToString("0.00") + ", sky glow " + map.skyManager.CurSkyGlow.ToString("0.00") + ", weather " + map.weatherManager.curWeather.defName
                + ", eclipse " + map.gameConditionManager.ConditionIsActive(GameConditionDefOf.Eclipse) + ", active conditions " + string.Join(", ", map.gameConditionManager.ActiveConditions.ConvertAll(c => c.def.defName)));
        }

        // An eclipse darkens the whole map for days: end it so that noon is bright (the draft save carries one that the game rolled while Virginie played).
        [Given(Prefix + "the eclipse of the map is ended")]
        public void EndEclipse(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            // The eclipse can live on the map or on the world (a condition of the world reaches every map): end both, and say which one carried it.
            foreach (var manager in new[] { map.gameConditionManager, Find.World.gameConditionManager })
                foreach (GameCondition c in manager.ActiveConditions.ToList())
                    if (c.def == GameConditionDefOf.Eclipse)
                    {
                        Log.Message("[light] ending the eclipse held by the " + (manager == map.gameConditionManager ? "map" : "world") + ", permanent " + c.Permanent + ", ticks left " + c.TicksLeft);
                        c.Permanent = false;
                        c.End();
                    }
            ctx.Assert(!map.gameConditionManager.ConditionIsActive(GameConditionDefOf.Eclipse), "The eclipse is still active");
        }

        [Then(Prefix + "the sun glow of the map is at least {float}")]
        public void SunGlowAtLeast(PickleContext ctx, float minimum)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "No loaded map");
            float glow = map.skyManager.CurSkyGlow;
            ctx.Assert(glow >= minimum, "The sky glow is " + glow.ToString("0.00") + " at hour " + GenLocalDate.HourInteger(map) + " with the weather " + map.weatherManager.curWeather.defName + "; expected at least " + minimum);
        }
    }
}
