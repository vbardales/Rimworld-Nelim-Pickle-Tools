using System;
using System.Collections.Generic;

namespace Nelim.PickleShared.Rimmsqol
{
    /// <summary>
    /// What this game process has asked RIMMSQOL to change and not yet put back. Plain strings and a
    /// flag: nothing here names a RIMMSqol type.
    /// </summary>
    internal static class RimmsqolSession
    {
        /// <summary>Names this game process. Two launches never share it, which is what lets a marker
        /// written by one be recognised as inherited by the other.</summary>
        internal static readonly string ProcessId = Guid.NewGuid().ToString("N");

        /// <summary>defNames of the main buttons a step changed and the teardown has not yet restored.</summary>
        internal static readonly HashSet<string> Touched = new HashSet<string>(StringComparer.Ordinal);

        /// <summary>Set by a step in the scenario that WANTS its choices to outlive the process.</summary>
        internal static bool KeepForNextLaunch;

        internal static void Touch(string defName) => Touched.Add(defName);
    }
}
