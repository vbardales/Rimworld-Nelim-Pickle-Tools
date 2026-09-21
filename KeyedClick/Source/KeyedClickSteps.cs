using System.Threading.Tasks;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.KeyedClick
{
    /// <summary>
    /// Clicks a button by the translation key its label comes from, instead of by the label. The game draws
    /// a button under the label of the language the player runs in, and Pickle records it under that label,
    /// so a scenario that spells the English text out only passes on an English game: on a French one the
    /// tag is <c>btn:Nouvelle colonie</c> and <c>btn:New colony</c> is not found.
    ///
    /// This is the same step as the one proposed to Pickle itself, RimWorks/Rimworld-Pickle pull request 19
    /// (<c>I click button keyed {string}</c>, branch <c>feat/click-button-by-translation-key</c> on the fork).
    /// **When it lands, this mod's step can go**, and a scenario written against it changes one prefix.
    /// Until then the two are kept in step: a change asked for in review is made in both places.
    ///
    /// The pattern starts with "Nelim's Pickle Tools:". Pickle loads the steps of every installed suite into
    /// one namespace, and a repeated text is an "Ambiguous step" that fails healthy scenarios. Once Pickle
    /// ships the step under its own words, the prefix is what keeps the two apart.
    /// </summary>
    [PickleSteps]
    public class KeyedClickSteps
    {
        private const string Nothing = "(none)";

        // A key nothing translates would build the label "NewColony" itself and look for a button that
        // does not exist, so the miss would read as a dead button. Naming the missing translation and the
        // active language says what is actually wrong.
        [When("Nelim's Pickle Tools: I click button keyed {string}")]
        public async Task ClickButtonKeyed(PickleContext ctx, string key)
        {
            ctx.Require(
                key.CanTranslate(),
                $"no translation is loaded for '{key}', so no label can be built from it. "
                    + $"active language: {LanguageDatabase.activeLanguage?.FriendlyNameEnglish ?? Nothing}");

            await ctx.Click($"btn:{key.Translate()}");
        }
    }
}
