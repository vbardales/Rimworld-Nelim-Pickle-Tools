using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.IdeologySteps
{
    /// <summary>
    /// Steps that give the colony an ideoligion built from named memes and precepts, give one colonist another, and read
    /// the precepts back. The ideoligion is made by the game's own generator and checked by its own acceptance test, and
    /// it lives in the loaded game only: nothing here writes a save.
    /// </summary>
    [PickleSteps]
    public class IdeoSteps
    {
        /// <summary>
        /// Builds an ideoligion from the memes (comma-separated MemeDef names) and the precepts (comma-separated PreceptDef names,
        /// added to the ones the memes require), gives it to every free colonist and makes it the primary ideoligion of the player
        /// faction. Fails naming the def when a meme or a precept does not exist, when two memes exclude each other, or when the
        /// game refuses a precept for these memes.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colony adopts an ideoligion with the memes {string} and the precepts {string}")]
        public void ColonyAdopts(PickleContext ctx, string memeNames, string preceptNames)
        {
            List<MemeDef> memes = Lookups.RequireDefs<MemeDef>(ctx, memeNames, "meme");
            List<PreceptDef> precepts = Lookups.RequireDefs<PreceptDef>(ctx, preceptNames, "precept");
            Ideo ideo = IdeoBuilder.Build(ctx, memes, precepts);

            Find.IdeoManager.Add(ideo);
            foreach (Pawn colonist in PawnsFinder.AllMaps_FreeColonists.ToList())
            {
                colonist.ideo.SetIdeo(ideo);
            }

            Faction.OfPlayer.ideos.SetPrimary(ideo);
            ctx.Assert(
                Faction.OfPlayer.ideos.PrimaryIdeo == ideo,
                $"the player faction should have the new ideoligion as its primary one; it has {IdeoBuilder.Describe(Faction.OfPlayer.ideos.PrimaryIdeo)}");
        }

        /// <summary>
        /// Gives one pawn (a colonist or a prisoner) an ideoligion of its own, built from the memes of the colony's primary
        /// ideoligion and the precepts asked for, so it follows a different faith from the colony's. Fails if the game would
        /// then change the colony's primary ideoligion, which happens when too few colonists follow the colony's.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} follows an ideoligion with the precepts {string}")]
        public void FollowsWithPrecepts(PickleContext ctx, string nickname, string preceptNames)
        {
            Ideo primary = Faction.OfPlayer.ideos.PrimaryIdeo;
            ctx.Require(primary != null, "the colony has no primary ideoligion; adopt one first with 'the colony adopts an ideoligion with the memes ...'");
            Follow(ctx, nickname, primary.memes.ToList(), Lookups.RequireDefs<PreceptDef>(ctx, preceptNames, "precept"));
        }

        /// <summary>
        /// Like the step without memes, for a faith whose memes differ from the colony's: the pawn follows an ideoligion made
        /// from exactly these memes and precepts.
        /// </summary>
        [Given("Nelim's Pickle Tools: the colonist {string} follows an ideoligion with the memes {string} and the precepts {string}")]
        public void FollowsWithMemes(PickleContext ctx, string nickname, string memeNames, string preceptNames)
        {
            Follow(
                ctx,
                nickname,
                Lookups.RequireDefs<MemeDef>(ctx, memeNames, "meme"),
                Lookups.RequireDefs<PreceptDef>(ctx, preceptNames, "precept"));
        }

        private static void Follow(PickleContext ctx, string nickname, List<MemeDef> memes, List<PreceptDef> precepts)
        {
            Pawn pawn = Lookups.RequirePawn(ctx, nickname);
            ctx.Require(pawn.ideo != null, $"pawn '{nickname}' has no ideoligion tracker (a mechanoid or an animal?)");
            Ideo before = Faction.OfPlayer.ideos.PrimaryIdeo;
            Ideo ideo = IdeoBuilder.Build(ctx, memes, precepts);

            Find.IdeoManager.Add(ideo);
            pawn.ideo.SetIdeo(ideo);

            ctx.Assert(
                pawn.Ideo == ideo,
                $"pawn '{nickname}' should follow the new ideoligion; it follows {IdeoBuilder.Describe(pawn.Ideo)}");
            ctx.Assert(
                before == null || Faction.OfPlayer.ideos.PrimaryIdeo == before,
                $"giving '{nickname}' another ideoligion changed the colony's primary one, from {IdeoBuilder.Describe(before)} to " +
                $"{IdeoBuilder.Describe(Faction.OfPlayer.ideos.PrimaryIdeo)}: the colony has too few followers of its own for the primary ideoligion to hold");
        }

        /// <summary>Asserts that the primary ideoligion of the colony holds a precept.</summary>
        [Then("Nelim's Pickle Tools: the colony ideoligion has the precept {string}")]
        public void ColonyHas(PickleContext ctx, string preceptName)
        {
            AssertColony(ctx, preceptName, true);
        }

        /// <summary>Asserts that the primary ideoligion of the colony does not hold a precept.</summary>
        [Then("Nelim's Pickle Tools: the colony ideoligion does not have the precept {string}")]
        public void ColonyHasNot(PickleContext ctx, string preceptName)
        {
            AssertColony(ctx, preceptName, false);
        }

        /// <summary>Asserts that the ideoligion a colonist (or a prisoner) follows holds a precept.</summary>
        [Then("Nelim's Pickle Tools: the colonist {string} has the precept {string}")]
        public void ColonistHas(PickleContext ctx, string nickname, string preceptName)
        {
            PreceptDef def = Lookups.RequireDef<PreceptDef>(ctx, preceptName, "precept");
            Pawn pawn = Lookups.RequirePawn(ctx, nickname);
            Ideo ideo = pawn.Ideo;
            ctx.Assert(
                ideo != null && ideo.HasPrecept(def),
                $"pawn '{nickname}' should follow an ideoligion with the precept '{preceptName}'; it follows {IdeoBuilder.Describe(ideo)}");
        }

        private static void AssertColony(PickleContext ctx, string preceptName, bool expected)
        {
            PreceptDef def = Lookups.RequireDef<PreceptDef>(ctx, preceptName, "precept");
            Ideo ideo = Faction.OfPlayer.ideos.PrimaryIdeo;
            ctx.Require(ideo != null, "the colony has no primary ideoligion");
            ctx.Assert(
                ideo.HasPrecept(def) == expected,
                $"the colony ideoligion should {(expected ? string.Empty : "not ")}have the precept '{preceptName}'; it is {IdeoBuilder.Describe(ideo)}");
        }
    }
}
