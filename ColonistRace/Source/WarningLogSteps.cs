using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using UnityEngine;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A warning check that cannot lose a message. Pickle's own step <c>no warning matching "X" was logged</c> reads a fixed-size buffer, and a save that logs hundreds of
    /// warnings while it loads (Nelims-tribe: about 207 "Could not find think node") pushes everything else out of it, so the step refuses to answer ("N warning(s) rolled
    /// out of the buffer"). These two steps count live from <c>Application.logMessageReceived</c> instead: mark the log right after the save is loaded, then assert.
    /// Asked for by SanctuaryBacklot (NSB) on 2026-11-07. Compiled, NOT PLAYED when written.
    /// </summary>
    [PickleSteps]
    public class WarningLogSteps
    {
        private const int Cap = 50000;          // warnings kept (text cut to 300 characters); beyond it the check says it cannot answer instead of guessing
        private static readonly List<string> warnings = new List<string>();
        private static int mark;
        private static int dropped;
        private static bool hooked;
        private static bool marked;

        private static void Hook()
        {
            if (hooked) return;
            hooked = true;
            Application.logMessageReceived += (text, stack, type) =>
            {
                if (type != LogType.Warning) return;
                if (warnings.Count >= Cap) { dropped++; return; }
                warnings.Add(text.Length > 300 ? text.Substring(0, 300) : text);
            };
        }

        /// <summary>Starts counting the warnings the game logs from this point. Put it right after the save is loaded (after the Background). Several marks: the last one counts.</summary>
        [Given("Nelim's Pickle Tools: the warning log is marked")]
        public void MarkWarningLog(PickleContext ctx)
        {
            Hook();
            marked = true;
            mark = warnings.Count;
            dropped = 0;
        }

        /// <summary>
        /// Fails when a warning logged after the last mark contains the text (case-sensitive substring, like the message you read in Player.log); the failure quotes the first
        /// three and says how many. Fails too when the log was never marked, and when more than 50 000 warnings came after the mark (then an absence cannot be proved).
        /// </summary>
        [Then("Nelim's Pickle Tools: no warning matching {string} was logged since the warning log was marked")]
        public void NoWarningSinceMark(PickleContext ctx, string pattern)
        {
            ctx.Require(marked, "the warning log was never marked: add 'the warning log is marked' after the save is loaded");
            ctx.Require(dropped == 0, dropped + " warning(s) came after the cap of " + Cap + " kept warnings: cannot tell an absent warning from a dropped one");
            var hits = warnings.Skip(mark).Where(w => w.Contains(pattern)).ToList();
            ctx.Assert(hits.Count == 0, hits.Count + " warning(s) matching \"" + pattern + "\" since the mark (" + (warnings.Count - mark) + " warnings in all): " + string.Join(" | ", hits.Take(3)));
        }
    }
}
