using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using HarmonyLib;
using VEF.Factions;

namespace QuietNewFactionsTests
{
    // Runs the shipped DLL against the installed game and VEF assemblies, without a game
    // session. It answers one question the Pickle suite used to spend a game launch on:
    // does the mod's patch land on the method VEF opens its new faction window from?
    public static class BehaviorTests
    {
        private const string HarmonyId = "nelim.quietnewfactions";

        private static int checks;

        private static void Check(bool condition, string message)
        {
            if (!condition) throw new Exception("FAIL: " + message);
            checks++;
            Console.WriteLine("PASS: " + message);
        }

        public static void Run()
        {
            MethodInfo target = AccessTools.Method(
                typeof(Dialog_NewFactionSpawning), nameof(Dialog_NewFactionSpawning.OpenDialog));
            Check(target != null, "VEF still has Dialog_NewFactionSpawning.OpenDialog to patch");

            Assembly mod = typeof(QuietNewFactions.QuietNewFactionsMod).Assembly;

            // PatchAll reads the same attributes the game reads at load, so a patch that would
            // not apply in game does not apply here either.
            var harmony = new Harmony(HarmonyId);
            harmony.PatchAll(mod);

            IEnumerable<string> owners = Harmony.GetPatchInfo(target)?.Owners ?? (IEnumerable<string>)new string[0];
            Check(owners.Contains(HarmonyId),
                $"OpenDialog carries the Quiet New Factions patch; owners: {string.Join(", ", owners)}");

            Patches info = Harmony.GetPatchInfo(target);
            Check(info.Prefixes.Any(p => p.owner == HarmonyId),
                "the patch is a prefix, so the window never opens for an ignored faction");
            Check(!info.Postfixes.Any(p => p.owner == HarmonyId)
                  && !info.Transpilers.Any(p => p.owner == HarmonyId),
                "the mod adds nothing else to that method");

            // The prefix reads the faction the dialog was given and decides for it; a signature
            // drift would silently stop it being called with what it needs.
            MethodInfo prefix = AccessTools.Method(
                AccessTools.TypeByName("QuietNewFactions.Dialog_NewFactionSpawning_OpenDialog"), "Prefix");
            Check(prefix != null && prefix.ReturnType == typeof(bool),
                "the prefix returns bool, so it can skip the original");
            Check(prefix.GetParameters().Select(p => p.ParameterType.Name).SequenceEqual(
                      new[] { "IEnumerator`1", "FactionDef" }),
                "the prefix takes VEF's enumerator and faction, the two names OpenDialog declares");

            harmony.UnpatchAll(HarmonyId);
            Console.WriteLine($"{checks} checks passed.");
        }
    }
}
