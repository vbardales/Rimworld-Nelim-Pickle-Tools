using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A step that gives a free colonist a fixed nickname by its place in the colony, written 2026-11-17 for BetweenSus: a new colony generates
    /// random names, so a scenario cannot address a colonist by name until it names it. Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class PawnNameSteps
    {
        /// <summary>
        /// Renames the Nth free colonist (1 is the first, in the order the game lists the player's colonists, the order the scenario spawned them)
        /// with a single name, so that every later step finds it by that nickname. Fails when there are fewer colonists or when another colonist
        /// already has that nickname.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist number {int} is named {string}")]
        public void NameColonistByIndex(PickleContext ctx, int index, string nickname)
        {
            var colonists = PawnsFinder.AllMaps_FreeColonists.ToList();
            ctx.Require(index >= 1 && index <= colonists.Count, $"there is no colonist number {index}: the colony has {colonists.Count}");
            Pawn pawn = colonists[index - 1];
            Pawn other = ColonistLookup.Find(nickname);
            ctx.Require(other == null || other == pawn, $"another colonist is already named '{nickname}'");
            string before = pawn.Name?.ToStringShort ?? "(none)";
            pawn.Name = new NameSingle(nickname);
            Log.Message($"[colonist-named] number {index}: {before} is now {pawn.Name.ToStringShort}");
        }
    }
}
