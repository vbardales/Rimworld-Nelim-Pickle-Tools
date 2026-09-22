using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.TextureOwner
{
    /// <summary>
    /// Asserts WHICH running mod answers for a texture path, for any retexture mod that shares paths with another.
    ///
    /// The failure this catches is silent everywhere else. Two mods that write the same texture path are resolved
    /// by load order, the last one winning, and a loadAfter is what makes the right one last. If that stopped
    /// winning (a packageId renamed upstream, a load order a player rearranged, a loadAfter lost in an edit)
    /// every scenario would stay green: the icons would still be present, still the right shape in the right
    /// places, and they would be the other mod's. Comparing pixels would not say whose. So these ask RimWorld's
    /// own content holders, the ones <c>ContentFinder</c> itself searches.
    ///
    /// Only meaningful in a pass that stages the competing mod. Without it the mod is the only candidate and
    /// "answered by" passes trivially, which is why the second step exists: it proves the pass really has a
    /// contest before the first one is worth reading.
    ///
    /// The step patterns start with "Nelim's Pickle Tools:". Pickle loads the steps of every installed suite into
    /// one namespace, and a repeated text is an "Ambiguous step" that fails healthy scenarios. No mod name is
    /// written in a pattern: the mod is a parameter.
    /// </summary>
    [PickleSteps]
    public class TextureOwnerSteps
    {
        /// <summary>
        /// Every running mod that ships this texture path, in load order. The winner is the tail. A path nobody
        /// ships stops the step here with a sentence: a claim about an empty set must not pass.
        /// </summary>
        private static List<ModContentPack> Providers(PickleContext ctx, string path)
        {
            var providers = LoadedModManager.RunningModsListForReading
                .Where(mod => mod.GetContentHolder<Texture2D>().Get(path) != null)
                .ToList();
            ctx.Require(providers.Count > 0, TextureOwnership.NoProvider(path));
            return providers;
        }

        // The id a person writes in a pass map or an About.xml, not the internal one (which can carry a
        // "_steam" suffix for a Workshop copy that a local copy shares its id with).
        private static Provider Describe(ModContentPack mod) => new Provider(mod.PackageIdPlayerFacing, mod.Name);

        [Then("Nelim's Pickle Tools: the texture {string} is answered by the mod {string}")]
        public void AnsweredBy(PickleContext ctx, string path, string packageId)
        {
            var providers = Providers(ctx, path).Select(Describe).ToList();
            var running = LoadedModManager.RunningModsListForReading.Select(mod => mod.PackageIdPlayerFacing).ToList();

            var problem = TextureOwnership.OwnerVerdict(path, providers, packageId, running);
            ctx.Assert(problem == null, problem);
        }

        [Then("Nelim's Pickle Tools: the texture {string} is shipped by at least {int} running mod(s)")]
        public void ShippedByAtLeast(PickleContext ctx, string path, int count)
        {
            var empty = TextureOwnership.EmptyCount(count);
            ctx.Require(empty == null, empty);

            var providers = Providers(ctx, path).Select(Describe).ToList();

            var problem = TextureOwnership.ContestVerdict(path, providers, count);
            ctx.Assert(problem == null, problem);
        }
    }
}
