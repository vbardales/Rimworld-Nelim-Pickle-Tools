using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using HarmonyLib;
using Verse;

namespace Nelim.PickleTools.Excludes
{
    /// <summary>
    /// Adds <c>@excludes:&lt;mod&gt;</c> to Pickle without touching Pickle. Pickle asks
    /// <c>RunOutcomes.MissingRequirement(tags, isLoaded)</c> before every scenario and skips it when
    /// the answer is a name. This postfix asks the same question the other way round, with the same
    /// <c>isLoaded</c> (so the same name-or-packageId rule as <c>@requires:</c>), and answers with the
    /// excluded mod's name when it is loaded. Pickle then reports the scenario as skipped.
    ///
    /// Pickle.Core is not referenced at build time (the reference package does not carry it), so the
    /// method is found by reflection at startup. If Pickle moves or renames it, nothing is patched,
    /// a warning is logged, and every scenario runs as if the tag did not exist: the probe feature
    /// <c>pickletools-excludes.feature</c> then fails loudly instead of the tag being silently ignored.
    ///
    /// RimWorld loads this assembly from <c>Mod/Assemblies</c>, not Pickle's step folder, because the
    /// patch must exist before the first scenario is filtered, and Pickle runs no code of a steps
    /// assembly before then.
    /// </summary>
    [StaticConstructorOnStartup]
    public static class ExcludesPatch
    {
        private const string HarmonyId = "nelim.pickletools.excludes";
        private const string TypeName = "RimWorks.Pickle.Core.Run.RunOutcomes";
        private const string MethodName = "MissingRequirement";

        static ExcludesPatch()
        {
            Install();
        }

        private static void Install()
        {
            try
            {
                Type outcomes = FindType();
                MethodInfo target = outcomes == null ? null : AccessTools.Method(outcomes, MethodName);
                if (target == null)
                {
                    Log.Warning("[Nelim's Pickle Tools: Excludes] " + TypeName + "." + MethodName
                        + " not found: the @excludes tag is NOT active.");
                    return;
                }

                new Harmony(HarmonyId).Patch(target, postfix: new HarmonyMethod(typeof(ExcludesPatch), nameof(Postfix)));
                Log.Message("[Nelim's Pickle Tools: Excludes] @excludes tag active.");
            }
            catch (Exception ex)
            {
                Log.Error("[Nelim's Pickle Tools: Excludes] patch failed, the @excludes tag is NOT active: " + ex);
            }
        }

        private static Type FindType()
        {
            foreach (Assembly assembly in AppDomain.CurrentDomain.GetAssemblies())
            {
                string name = assembly.GetName().Name;
                if (name == null || !name.StartsWith("RimWorks.Pickle", StringComparison.Ordinal))
                {
                    continue;
                }

                Type found = assembly.GetType(TypeName, false);
                if (found != null)
                {
                    return found;
                }
            }

            return null;
        }

        /// <summary>Postfix on <c>RunOutcomes.MissingRequirement</c>; parameter names are Pickle's.</summary>
        private static void Postfix(object tags, Func<string, bool> isPresent, ref string __result)
        {
            if (__result != null)
            {
                return;
            }

            string excluded = ExcludesRule.FirstExcluded(AsStrings(tags as IEnumerable), isPresent);
            if (excluded != null)
            {
                // Pickle logs "skipping '<scenario>', '<this>' is not loaded": the suffix says why.
                __result = excluded + " (@excludes)";
            }
        }

        private static IEnumerable<string> AsStrings(IEnumerable source)
        {
            if (source == null)
            {
                yield break;
            }

            foreach (object item in source)
            {
                yield return item as string ?? item?.ToString();
            }
        }
    }
}
