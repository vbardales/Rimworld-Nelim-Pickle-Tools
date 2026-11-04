using System.Linq;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.TextureOwner
{
    /// <summary>
    /// Asserts that a texture is reachable in the game's own base resources (<c>Resources.Load</c>), whatever the running mods answer.
    ///
    /// Written 2026-11-04 at the request of Biotech Bodies: a mod that re-skins the vanilla paths (WDI ships only textures under the vanilla
    /// body paths) hides the vanilla art from <c>ContentFinder</c>, which asks the running mods first and calls <c>Resources.Load</c> only
    /// after; the question is whether the vanilla body is still reachable by <c>Resources.Load</c> while such a mod is loaded.
    /// NOT PLAYED: compiled against the reference assemblies only.
    /// </summary>
    [PickleSteps]
    public class BaseResourceSteps
    {
        private static Texture2D LoadBase(string path) => Resources.Load<Texture2D>("Textures/" + path);

        /// <summary>
        /// Passes when <c>Resources.Load&lt;Texture2D&gt;("Textures/" + path)</c> returns a texture; fails with a sentence when it returns null.
        /// The path is relative to a Textures folder, no extension, case-sensitive (for example <c>Things/Pawn/Humanlike/Bodies/Naked_Male_south</c>).
        /// </summary>
        [Then("Nelim's Pickle Tools: the texture {string} loads from the game's base resources")]
        public void LoadsFromBaseResources(PickleContext ctx, string path)
        {
            Texture2D texture = LoadBase(path);
            ctx.Assert(texture != null, "Resources.Load<Texture2D>(\"Textures/" + path + "\") returned null: the game's base resources hold no texture at this path"
                + " (check the case and that the path has no extension).");
            ctx.Attach("texture", path + ": base resource " + texture.width + " x " + texture.height + " px");
        }

        /// <summary>
        /// Passes when the base resource of this path is NOT the texture the running mods answer with (<c>ContentFinder&lt;Texture2D&gt;.Get</c>,
        /// compared by reference): a running mod hides the vanilla art at this path. Fails with a sentence when the two are the same texture
        /// (no running mod ships the path, the finder fell back to the base resource) or when the base resource does not exist.
        /// </summary>
        [Then("Nelim's Pickle Tools: the texture {string} from the base resources is not the one a running mod answers")]
        public void BaseIsNotTheModAnswer(PickleContext ctx, string path)
        {
            Texture2D baseTexture = LoadBase(path);
            ctx.Require(baseTexture != null, "Resources.Load<Texture2D>(\"Textures/" + path + "\") returned null: the game's base resources hold no texture at this path.");
            Texture2D answered = ContentFinder<Texture2D>.Get(path, false);
            ctx.Require(answered != null, "ContentFinder<Texture2D>.Get(\"" + path + "\") returned null: nothing answers this path, the contest cannot be judged.");
            bool modShips = LoadedModManager.RunningModsListForReading.Any(mod => mod.GetContentHolder<Texture2D>().Get(path) != null);
            ctx.Assert(!ReferenceEquals(baseTexture, answered) && modShips,
                "the texture at " + path + " answered by the running mods is the base resource itself: no running mod ships this path"
                + (modShips ? " with a different texture" : "") + ", so nothing hides the vanilla art here.");
        }
    }
}
