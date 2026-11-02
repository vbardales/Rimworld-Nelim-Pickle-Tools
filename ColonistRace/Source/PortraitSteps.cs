using System;
using System.IO;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using RimWorks.Pickle.Evidence;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// A close face picture of a named colonist, drawn by the game's own portrait renderer instead of the camera. The camera cannot
    /// come closer than a root size of 2, which leaves a face about 150 px wide on a 1080 px screen: too small to read lids, brows and
    /// face skin marks. A portrait is rendered at the size asked, so the face fills it.
    ///
    /// Written 2026-10-31 at the request of SanctuaryBacklot (Miel's face parts). NOT PLAYED: compiled against the reference
    /// assemblies only. Facial Animation draws its parts through the pawn renderer, so they should appear; the first run says.
    /// </summary>
    [PickleSteps]
    public class PortraitSteps
    {
        // The picture lands next to Pickle's own frames, in the report's screenshots folder, under this feature folder.
        private const string FeatureFolder = "pickletools-portrait";

        /// <summary>
        /// Renders the colonist's portrait, south facing, at <paramref name="pixels"/> by <paramref name="pixels"/>, and saves it as a jpeg named
        /// <paramref name="name"/> in the screenshots folder of the report (<c>pickletools-portrait--&lt;name&gt;</c>). The zoom is the portrait
        /// camera's: 1 shows the whole body, about 3 the head. Hair, clothes and headgear are drawn as the pawn wears them: take them off
        /// with the existing steps first when only the face matters. NOT PLAYED when written.
        /// </summary>
        [When("Nelim's Pickle Tools: a portrait of {string} is saved as {string} at {int} pixels and zoom {float}")]
        public void SavePortrait(PickleContext ctx, string nickname, string name, int pixels, float zoom)
        {
            ctx.Assert(pixels >= 64 && pixels <= 2048, $"{pixels} pixels is out of range: ask for 64 to 2048");
            ctx.Assert(zoom >= 1f && zoom <= 8f, $"zoom {zoom} is out of range: ask for 1 to 8");
            // A colonist by nickname first; else an animal (or any pawn) spawned on the current map, by short label, as the camera steps do.
            Pawn pawn = ColonistLookup.Find(nickname)
                ?? Find.CurrentMap?.mapPawns.AllPawnsSpawned.FirstOrDefault(
                    p => string.Equals(p.LabelShort, nickname, StringComparison.OrdinalIgnoreCase));
            if (pawn == null)
            {
                ColonistLookup.Require(nickname);
            }

            PortraitsCache.SetDirty(pawn);
            RenderTexture portrait = PortraitsCache.Get(
                pawn, new Vector2(pixels, pixels), Rot4.South, new Vector3(0f, 0f, 0.3f), zoom);
            ctx.Require(portrait != null, $"the game returned no portrait for '{nickname}'");

            RenderTexture previous = RenderTexture.active;
            var picture = new Texture2D(portrait.width, portrait.height, TextureFormat.RGB24, false);
            try
            {
                RenderTexture.active = portrait;
                picture.ReadPixels(new Rect(0, 0, portrait.width, portrait.height), 0, 0);
                picture.Apply();
                string path = ScreenshotCapture.BuildFramePath(FeatureFolder, name, 0);
                Directory.CreateDirectory(Path.GetDirectoryName(path));
                File.WriteAllBytes(path, picture.EncodeToJPG(95));
                ctx.Attach("portrait", $"{nickname}: {portrait.width} x {portrait.height} px, zoom {zoom}, saved to {path}");
            }
            finally
            {
                RenderTexture.active = previous;
                UnityEngine.Object.Destroy(picture);
            }
        }
    }
}
