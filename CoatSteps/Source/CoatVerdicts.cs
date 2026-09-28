using System.Collections.Generic;
using System.Linq;

namespace Nelim.PickleTools.CoatSteps
{
    /// <summary>
    /// The decisions of the coat steps, apart from the game: each takes plain values and returns the sentence a
    /// failure prints, or null. Kept free of Verse so they can be read, and tested, without a running game.
    /// A coat is the index an animal drew into its kind's alternateGraphics; null means the graphic it hatched with.
    /// </summary>
    public static class CoatVerdicts
    {
        public static string Describe(IEnumerable<int?> coats)
        {
            var counts = coats
                .GroupBy(c => c)
                .OrderBy(g => g.Key ?? -1)
                .Select(g => (g.Key.HasValue ? "coat " + g.Key.Value : "original") + " x" + g.Count());
            return string.Join(", ", counts);
        }

        /// <summary>
        /// At least K different EXTRA coats (non-null indices) among N animals. The message carries N, K and what was
        /// seen, so a red from bad luck reads differently from a red from a broken patch: the chance of drawing any
        /// extra coat at all is alternateGraphicChance, and each single coat is rarer than that.
        /// </summary>
        public static string DistinctExtraCoats(string kind, IList<int?> coats, int wanted)
        {
            if (wanted < 1)
            {
                return "asking for " + wanted + " different coats says nothing: ask for at least 1";
            }

            int seen = coats.Where(c => c.HasValue).Select(c => c.Value).Distinct().Count();
            if (seen >= wanted)
            {
                return null;
            }

            return "of " + coats.Count + " animals of kind " + kind + ", " + seen + " different extra coats were drawn and "
                + wanted + " were wanted (" + Describe(coats) + "). A red with few animals may be bad luck; with many, a "
                + "patch that did not apply: check that its def was patched, then raise the number of animals.";
        }

        /// <summary>Null or in [0, count): an index past the list means the texPath list was edited under the code.</summary>
        public static string IndexInRange(string label, int? coat, int alternateCount)
        {
            if (!coat.HasValue || (coat.Value >= 0 && coat.Value < alternateCount))
            {
                return null;
            }

            return label + " drew coat " + coat.Value + " but its kind carries " + alternateCount + " alternate graphics";
        }

        /// <summary>The same coat before and after a reload, by name: a re-roll would reshuffle the pen.</summary>
        public static string SameCoat(string label, int? before, int? after)
        {
            if (before == after)
            {
                return null;
            }

            return label + " had " + Name(before) + " before the reload and " + Name(after) + " after it";
        }

        private static string Name(int? coat) => coat.HasValue ? "coat " + coat.Value : "the original graphic";
    }
}
