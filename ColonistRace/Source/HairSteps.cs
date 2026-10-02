using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Shows a hairstyle in the colours its texture was drawn in. The game multiplies the hairstyle's texture by the pawn's hair
    /// colour, so a brown pawn lays brown over a hairstyle that is white-tipped or multicoloured (Accelerator's white spikes
    /// come out chestnut). A hair colour of white multiplies by one and leaves the texture as its artist drew it.
    ///
    /// Ported on 2026-10-02 from ACertainSeriesCreaturesAndHairRenew's local steps (its session, at Virginie's request), for the
    /// hairstyle gallery captures of any mod. NOT PLAYED: compiled against the reference assemblies only.
    /// </summary>
    [PickleSteps]
    public class HairSteps
    {
        /// <summary>
        /// Sets the colonist's hair colour to white and redraws the pawn, so its hairstyle is drawn in its own colours. The colour is the
        /// pawn's for the rest of the scenario (the scenario's pawn is not saved unless the scenario saves). A hair colour an effect
        /// forces on top of it, such as a gene, is not undone: the read-back step says what the game reports.
        /// </summary>
        [When("Nelim's Pickle Tools: I let the hairstyle of {string} show its own colours")]
        public void ShowOwnColours(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story, so it has no hair colour");
            pawn.story.HairColor = Color.white;
            pawn.Drawer.renderer.SetAllGraphicsDirty();
        }

        /// <summary>Asserts that the colonist's hair colour reads white, to 0.01; the failure prints the colour and the hairstyle.</summary>
        [Then("Nelim's Pickle Tools: the hairstyle of {string} is drawn in its own colours")]
        public void OwnColours(PickleContext ctx, string nickname)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story, so it has no hair colour");
            Color colour = pawn.story.HairColor;
            ctx.Assert(
                colour.r > 0.99f && colour.g > 0.99f && colour.b > 0.99f,
                $"{nickname}'s hair colour is {colour}, not white, so the hairstyle '{pawn.story.hairDef?.defName ?? "(none)"}' is tinted by it");
        }
    }
}
