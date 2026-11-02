using System.IO;
using System.Linq;
using RimWorks.Pickle;
using RimWorks.Pickle.Evidence;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.TextureOwner
{
    /// <summary>
    /// Saves a texture the running game holds as a PNG in the report, for a texture that has no loose file (vanilla body
    /// textures live in the game's resources, only the running game can read them).
    ///
    /// Written 2026-11-02 at the request of VenusTouchWaistlines (the vanilla Naked_* bodies, to compare with a WDI body).
    /// NOT PLAYED: compiled against the reference assemblies only.
    /// </summary>
    [PickleSteps]
    public class TextureSaveSteps
    {
        private const string FeatureFolder = "pickletools-texture-save";

        /// <summary>
        /// Saves the texture at <paramref name="path"/> (relative to a Textures folder, no extension, case-sensitive) at full size
        /// with its alpha, as <paramref name="name"/>.png in the screenshots folder of the report
        /// (<c>pickletools-texture-save--&lt;name&gt;</c>). The texture is the one the game answers with: the last running mod that
        /// ships the path wins, the same rule as <c>ContentFinder</c> and the ownership steps. A path nobody ships stops the step.
        /// The file is read through a render texture, so a texture that is not marked readable still comes out. Any number of
        /// paths per scenario, one name each.
        /// </summary>
        [When("Nelim's Pickle Tools: the texture {string} is saved as {string}")]
        public void SaveTexture(PickleContext ctx, string path, string name)
        {
            ctx.Assert(!string.IsNullOrWhiteSpace(name), "the name of the saved picture is empty");

            Texture2D source = LoadedModManager.RunningModsListForReading
                .Select(mod => mod.GetContentHolder<Texture2D>().Get(path))
                .LastOrDefault(texture => texture != null);
            ctx.Require(source != null, TextureOwnership.NoProvider(path));

            RenderTexture copy = RenderTexture.GetTemporary(
                source.width, source.height, 0, RenderTextureFormat.ARGB32, RenderTextureReadWrite.Default);
            RenderTexture previous = RenderTexture.active;
            var picture = new Texture2D(source.width, source.height, TextureFormat.RGBA32, false);
            try
            {
                Graphics.Blit(source, copy);
                RenderTexture.active = copy;
                picture.ReadPixels(new Rect(0, 0, source.width, source.height), 0, 0);
                picture.Apply();

                // The frame path is Pickle's, the extension is ours: a texture keeps its alpha only in a png.
                string file = Path.ChangeExtension(ScreenshotCapture.BuildFramePath(FeatureFolder, name, 0), ".png");
                Directory.CreateDirectory(Path.GetDirectoryName(file));
                File.WriteAllBytes(file, picture.EncodeToPNG());
                ctx.Attach("texture", $"{path}: {source.width} x {source.height} px, saved to {file}");
            }
            finally
            {
                RenderTexture.active = previous;
                RenderTexture.ReleaseTemporary(copy);
                Object.Destroy(picture);
            }
        }
    }
}
