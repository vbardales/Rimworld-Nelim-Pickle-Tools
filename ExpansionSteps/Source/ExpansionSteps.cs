using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.Expansions
{
    /// <summary>
    /// Asserts whether an expansion (or any mod) is ACTIVE according to <c>ModsConfig</c>, the list the game
    /// itself keeps, by package id.
    ///
    /// Why a suite wants it. A pass can leave a DLC out of ModsConfig (a <c>!ludeon.rimworld.odyssey</c> line
    /// in its pass map), and nothing in the staging says whether the game then KEEPS it out once a save is
    /// loaded. Pickle's own <c>mod {string} is not loaded</c> reads the loaded mod list; this reads ModsConfig.
    /// A scenario that asserts both proves the two agree, which is what a DLC-off pass has to establish
    /// before anything else it says is worth reading.
    ///
    /// The pattern starts with "Nelim's Pickle Tools:". Pickle loads the steps of every installed suite into
    /// one namespace, and a repeated text is an "Ambiguous step" that fails healthy scenarios.
    /// </summary>
    [PickleSteps]
    public class ExpansionSteps
    {
        [Then("Nelim's Pickle Tools: the expansion {string} is active")]
        public void ExpansionIsActive(PickleContext ctx, string packageId)
        {
            ctx.Assert(ModsConfig.IsActive(packageId), $"{packageId} is not active in ModsConfig");
        }

        [Then("Nelim's Pickle Tools: the expansion {string} is not active")]
        public void ExpansionIsNotActive(PickleContext ctx, string packageId)
        {
            ctx.Assert(!ModsConfig.IsActive(packageId), $"{packageId} is active in ModsConfig");
        }
    }
}
