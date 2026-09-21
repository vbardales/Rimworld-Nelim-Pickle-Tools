using HarmonyLib;
using Verse;

namespace Nelim.PickleTools.ClearScreen
{
    /// <summary>
    /// Keeps foreign windows off the stack for the length of a scenario. Closing them once is not
    /// enough: a log viewer that tails errors, or a mod that reopens its notice, is back on the next
    /// frame and swallows the click the scenario was about to make.
    ///
    /// Upstream, RimWorks/Rimworld-Pickle pull request 21, this sits inside Pickle and is called from
    /// its own prefix on <c>WindowStack.Add</c>. A companion mod cannot reach into that code, so this
    /// copy installs a prefix of its own, on first use: a suite that never asks for a clear screen
    /// never has the game patched. When the pull request lands, this file goes with the rest.
    /// </summary>
    public static class WindowSuppression
    {
        private const string HarmonyId = "nelim.pickletools.clearscreen";

        private static readonly object Gate = new object();
        private static bool patched;

        /// <summary>Whether foreign windows are currently being dropped as they open.</summary>
        public static bool Active { get; private set; }

        /// <summary>Starts dropping foreign windows as they open.</summary>
        public static void Begin()
        {
            EnsurePatched();
            Active = true;
        }

        /// <summary>Stops dropping foreign windows, so the game behaves normally again.</summary>
        // Called from an [AfterScenario] hook as well as from the step, so a scenario that dies
        // between the two does not leave the player's game unable to open anything.
        public static void End()
        {
            Active = false;
        }

        /// <summary>Whether the runner owns the window, and so must never drop it.</summary>
        public static bool IsOwn(Window window)
        {
            return WindowSuppressionRule.IsOwn(AssemblyNameOf(window));
        }

        /// <summary>Whether a window opening right now should be allowed onto the stack.</summary>
        public static bool ShouldAdd(Window window)
        {
            return WindowSuppressionRule.Allows(Active, AssemblyNameOf(window));
        }

        /// <summary>The prefix on <c>WindowStack.Add</c>: <c>false</c> skips adding the window.</summary>
        public static bool AddPrefix(Window window)
        {
            return ShouldAdd(window);
        }

        private static string AssemblyNameOf(Window window)
        {
            return window?.GetType().Assembly.GetName().Name;
        }

        private static void EnsurePatched()
        {
            lock (Gate)
            {
                if (patched)
                {
                    return;
                }

                new Harmony(HarmonyId).Patch(
                    AccessTools.Method(typeof(WindowStack), nameof(WindowStack.Add), new[] { typeof(Window) }),
                    prefix: new HarmonyMethod(typeof(WindowSuppression), nameof(AddPrefix)));
                patched = true;
            }
        }
    }
}
