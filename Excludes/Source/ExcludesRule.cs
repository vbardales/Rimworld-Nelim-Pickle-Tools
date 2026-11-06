using System;
using System.Collections.Generic;

namespace Nelim.PickleTools.Excludes
{
    /// <summary>
    /// The decision behind the <c>@excludes:&lt;mod&gt;</c> tag, the inverse of Pickle's own
    /// <c>@requires:&lt;mod&gt;</c>: a scenario carrying it must not run when that mod IS loaded.
    /// Kept free of any game type so it can be read, and tested, on its own.
    /// </summary>
    public static class ExcludesRule
    {
        private const string ExcludesPrefix = "@excludes:";

        /// <summary>
        /// Names the first <c>@excludes:</c> tag whose mod the caller reports as loaded, or null when
        /// the scenario can run. Same shape as Pickle's <c>RunOutcomes.MissingRequirement</c>: the
        /// caller decides what counts as loaded (name or packageId, case insensitive).
        /// </summary>
        public static string FirstExcluded(IEnumerable<string> tags, Func<string, bool> isLoaded)
        {
            if (tags == null || isLoaded == null)
            {
                return null;
            }

            foreach (string tag in tags)
            {
                if (tag == null || !tag.StartsWith(ExcludesPrefix, StringComparison.OrdinalIgnoreCase))
                {
                    continue;
                }

                string unwanted = tag.Substring(ExcludesPrefix.Length).Trim();
                if (unwanted.Length > 0 && isLoaded(unwanted))
                {
                    return unwanted;
                }
            }

            return null;
        }
    }
}
