using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using HarmonyLib;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Stops the game from throwing the small status icons of a fleck def (the sleeping Z above an animal, the heart of a bond, ...) for the rest of
    /// the scenario. Written 2026-11-09 for AncientChineseBeastAndGeneExpandedRenew (scene 1, a rooster at dawn shows SleepZ). In 1.6 these are flecks
    /// (FleckDef SleepZ, SleepZ_Small, SleepZ_Tiny in Core Defs/Effects/Fleck_MetaStatus.xml), not Mote things. Harmony prefix on every
    /// FleckMaker.ThrowMetaIcon and FleckMaker.Static overload that takes a FleckDef; a flag decides, so the patch is inert after the scenario.
    /// Compiled, not played.
    /// </summary>
    [PickleSteps]
    public class FleckHideSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";
        private static Harmony harmony;
        private static readonly HashSet<string> Hidden = new HashSet<string>();

        /// <summary>
        /// Hides the flecks of a def: they are no longer thrown until the scenario ends. For the sleeping Z use <c>SleepZ</c>, <c>SleepZ_Small</c> and
        /// <c>SleepZ_Tiny</c> (one step each; an animal throws the size that fits it). Fails when no fleck def has that name.
        /// </summary>
        [Given(Prefix + "the flecks of def {string} are not thrown")]
        public void HideFlecks(PickleContext ctx, string defName)
        {
            ctx.Require(DefDatabase<FleckDef>.GetNamedSilentFail(defName) != null, "no FleckDef named '" + defName + "' is loaded");
            if (harmony == null)
            {
                Harmony h = new Harmony("nelim.pickletools.fleckhide");
                int patched = 0;
                foreach (MethodInfo m in typeof(FleckMaker).GetMethods(BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.DeclaredOnly)
                    .Where(m => (m.Name == "ThrowMetaIcon" || m.Name == "Static") && m.ReturnType == typeof(void) && m.GetParameters().Any(p => p.ParameterType == typeof(FleckDef))))
                {
                    h.Patch(m, prefix: new HarmonyMethod(typeof(FleckHideSteps), nameof(Prefix_Throw)));
                    patched++;
                }
                if (patched == 0)
                {
                    h.UnpatchAll(h.Id);
                    ctx.Require(false, "no FleckMaker method taking a FleckDef was found: the game changed");
                }
                harmony = h;
                Log.Message("[fleck-hide] " + patched + " FleckMaker methods patched");
            }
            Hidden.Add(defName);
        }

        private static bool Prefix_Throw(object[] __args)
        {
            if (Hidden.Count == 0) return true;
            foreach (object a in __args)
                if (a is FleckDef def && Hidden.Contains(def.defName)) return false;
            return true;
        }

        [AfterScenario]
        public void ReleaseFlecks()
        {
            Hidden.Clear();
        }
    }
}
