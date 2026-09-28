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

        /// <summary>
        /// At least K of the N animals carry an extra coat (index 0 or more). Counts animals, not different coats: the
        /// step for rare coats, where the chance is 5 percent and asking for several distinct ones would be luck.
        /// </summary>
        public static string AtLeastCarrying(string kind, IList<int?> coats, int wanted)
        {
            if (wanted < 1)
            {
                return "asking for " + wanted + " animals with an extra coat says nothing: ask for at least 1";
            }

            int carrying = coats.Count(c => c.HasValue);
            if (carrying >= wanted)
            {
                return null;
            }

            return "of " + coats.Count + " animals of kind " + kind + ", " + carrying + " carry an extra coat and " + wanted
                + " were wanted (" + Describe(coats) + "). At a low chance a red with few animals may be bad luck; raise the number of animals before suspecting the patch.";
        }

        /// <summary>No animal of the kind carries an extra coat: for a pass where a patch must not apply.</summary>
        public static string NoneCarrying(string kind, IList<int?> coats)
        {
            int carrying = coats.Count(c => c.HasValue);
            if (carrying == 0)
            {
                return null;
            }

            return carrying + " of " + coats.Count + " animals of kind " + kind + " carry an extra coat where none was expected (" + Describe(coats) + ")";
        }


        /// <summary>The resolved graphic's path against the coat's own texPath; case is ignored, as ContentFinder keys are not case-folded but a mismatch by case is still a typo worth naming.</summary>
        public static string DrawnPath(string label, int coat, string expected, string drawn)
        {
            if (string.Equals(expected, drawn, System.StringComparison.OrdinalIgnoreCase))
            {
                return null;
            }

            return label + " carries coat " + coat + " whose texture is '" + expected + "' but the renderer built a graphic from '" + drawn + "'";
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
