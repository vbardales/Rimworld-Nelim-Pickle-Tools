using System;

namespace Nelim.PickleTools.ClearScreen
{
    /// <summary>
    /// Decides whether a window opening right now is allowed onto the stack. Split from the
    /// Verse-facing side so the rule itself stays a pure function: getting this wrong in the "drop"
    /// direction leaves the game unable to open anything at all.
    ///
    /// A copy of <c>Source/Pickle.Core/Ui/WindowSuppressionRule.cs</c> from RimWorks/Rimworld-Pickle
    /// pull request 21 (head 9ab3686), which carries the five unit tests of this rule. The logic is the
    /// same; only the namespace and the nullable annotations differ. Keep them in step.
    /// </summary>
    public static class WindowSuppressionRule
    {
        private const string OwnAssemblyPrefix = "RimWorks.Pickle";

        /// <summary>Whether a window from the named assembly may open.</summary>
        // An unknown assembly is let through. A window whose origin cannot be read is far more likely
        // to be something the player needs than something worth dropping, and the cost of the two
        // mistakes is not symmetric.
        public static bool Allows(bool active, string assemblyName)
        {
            if (!active || assemblyName == null)
            {
                return true;
            }

            return IsOwn(assemblyName);
        }

        /// <summary>Whether the runner itself owns the assembly, and so must never have its windows dropped.</summary>
        public static bool IsOwn(string assemblyName)
        {
            return assemblyName != null
                && assemblyName.StartsWith(OwnAssemblyPrefix, StringComparison.Ordinal);
        }
    }
}
