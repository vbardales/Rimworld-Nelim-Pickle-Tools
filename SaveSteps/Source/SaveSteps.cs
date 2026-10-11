using System.IO;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.SaveSteps
{
    /// <summary>
    /// Steps that save the running game under a name and hand the saved file to a mod as a Pickle fixture, so that the NEXT launch (a
    /// pass without the mod that wrote the save, or with another mod set) can load it. Pickle finds a saved game as a fixture: a
    /// <c>.rws</c> in the <c>Pickle/Fixtures</c> folder of an active mod.
    ///
    /// Written on 2026-10-11 from the same pair of steps that three mods had written alike (Animal Apparel Collars, Drum Bath Hygiene,
    /// Anima Song), after the rule that a step becomes shared when a second mod needs it. Not played.
    /// </summary>
    [PickleSteps]
    public class SaveSteps
    {
        /// <summary>
        /// Saves the game with the game's own saver (<c>GameDataSaveLoader.SaveGame</c>) under the given name and fails when the file is
        /// not written. The file is in the game's saves folder; hand it to a mod with the next step to load it in a later launch.
        /// </summary>
        [When("Nelim's Pickle Tools: the game is saved as {string}")]
        public void SaveAs(PickleContext ctx, string name)
        {
            ctx.Require(!string.IsNullOrWhiteSpace(name), "a saved game needs a name");
            GameDataSaveLoader.SaveGame(name);
            string path = GenFilePaths.FilePathForSavedGame(name);
            ctx.Assert(File.Exists(path), $"the game did not write {path}");
        }

        /// <summary>
        /// Copies the saved game of that name into <c>Pickle/Fixtures</c> of an active mod (found by packageId, any case), as
        /// <c>&lt;name&gt;.rws</c>, so that Pickle lists it as a fixture the next time that mod is loaded. Fails when no active mod has
        /// the packageId or the game was not saved under that name first.
        /// </summary>
        [When("Nelim's Pickle Tools: the saved game {string} is handed to the mod {string}")]
        public void HandOver(PickleContext ctx, string name, string packageId)
        {
            string path = GenFilePaths.FilePathForSavedGame(name);
            ctx.Require(File.Exists(path), $"no saved game named '{name}' ({path}): use 'the game is saved as' first");
            ModContentPack target = LoadedModManager.RunningModsListForReading
                .FirstOrDefault(m => m.PackageIdPlayerFacing.ToLowerInvariant() == packageId.ToLowerInvariant());
            ctx.Require(target != null, $"no active mod has the packageId '{packageId}'");
            string folder = Path.Combine(target.RootDir, "Pickle", "Fixtures");
            Directory.CreateDirectory(folder);
            string destination = Path.Combine(folder, name + ".rws");
            File.Copy(path, destination, true);
            ctx.Assert(File.Exists(destination), $"the saved game was not copied to {destination}");
        }
    }
}
