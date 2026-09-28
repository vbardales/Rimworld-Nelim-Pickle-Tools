using System;
using System.Collections.Generic;
using System.Linq;
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

        /// <summary>
        /// Runs the gizmo of the current selection whose label is the translation of a key, the way Pickle's
        /// <c>I click gizmo {string}</c> runs the one whose label it is given as text (same lookup, same
        /// <c>ProcessInput</c>), so a scenario passes in every language. The label is the key's translation with no
        /// argument: a gizmo whose label is built with arguments ("{0} tiles") is not found by its key alone; the miss
        /// lists the gizmos the selection offers, so the difference shows.
        /// </summary>
        [When("Nelim's Pickle Tools: I click the gizmo keyed {string}")]
        public void ClickGizmoKeyed(PickleContext ctx, string key)
        {
            ctx.Require(
                key.CanTranslate(),
                $"no translation is loaded for '{key}', so no gizmo label can be built from it. "
                    + $"active language: {LanguageDatabase.activeLanguage?.FriendlyNameEnglish ?? Nothing}");

            string label = key.Translate().ToString();
            List<Gizmo> offered = Find.Selector.SelectedObjectsListForReading.OfType<Thing>().SelectMany(thing => thing.GetGizmos()).ToList();
            Command gizmo = offered.OfType<Command>().FirstOrDefault(
                command => string.Equals(command.LabelCap, label, StringComparison.OrdinalIgnoreCase));
            if (gizmo == null)
            {
                string names = string.Join(", ", offered.OfType<Command>().Select(command => command.LabelCap.ToString()).Where(text => !string.IsNullOrEmpty(text)).OrderBy(text => text, StringComparer.OrdinalIgnoreCase));
                ctx.Require(false, $"no gizmo labeled '{label}' (key '{key}') on the current selection. available gizmos: {(names.Length > 0 ? names : Nothing)}");
            }

            gizmo.ProcessInput(null);
        }
    }
}
