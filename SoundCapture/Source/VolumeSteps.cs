using System;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.SoundCapture
{
    /// <summary>
    /// Sets the game's master volume for a scenario. The WSL staging writes <c>volumeMaster 0</c> into the profile's
    /// Prefs.xml (scripts/stage-pickle-wsl.sh), so the headless game is muted by design and a recording of its sound
    /// reads silence, which is what the first measurement (-91 dB, 2026-09-24) probably was. <c>Prefs.VolumeMaster</c> is a
    /// property that stores the value and applies it at once; it is not saved to disk here, and the value found is put
    /// back after the scenario.
    ///
    /// Every pattern starts with "Nelim's Pickle Tools:" so that it cannot be ambiguous with a step of Pickle's own.
    /// </summary>
    [PickleSteps]
    public class VolumeSteps
    {
        private static float? original;
        private static float? originalMusic;
        private static float? originalAmbient;

        [Given("Nelim's Pickle Tools: the game volume is {int} percent")]
        public void SetVolume(PickleContext ctx, int percent)
        {
            ctx.Assert(percent >= 0 && percent <= 100, $"a volume between 0 and 100 percent, not {percent}");
            if (original == null)
            {
                original = Prefs.VolumeMaster;
            }

            float wanted = percent / 100f;
            Prefs.VolumeMaster = wanted;
            ctx.Assert(
                Math.Abs(Prefs.VolumeMaster - wanted) < 0.001f,
                $"the master volume should read {wanted} after the step; it reads {Prefs.VolumeMaster} " +
                $"(it was {original} before; game {Prefs.VolumeGame}, music {Prefs.VolumeMusic}, ambient {Prefs.VolumeAmbient}, UI {Prefs.VolumeUI})");
        }

        /// <summary>
        /// The game's background music and its ambience, apart from the master volume: a recording that must hear only what a mod plays
        /// cannot use the master volume, which would cut the effects it wants to hear. <c>Prefs.VolumeMusic</c> and
        /// <c>Prefs.VolumeAmbient</c> store and apply at once, are not saved to disk here, and are put back after the scenario.
        /// </summary>
        [Given("Nelim's Pickle Tools: the game music volume is {int} percent")]
        public void SetMusicVolume(PickleContext ctx, int percent)
        {
            ctx.Assert(percent >= 0 && percent <= 100, $"a volume between 0 and 100 percent, not {percent}");
            if (originalMusic == null)
            {
                originalMusic = Prefs.VolumeMusic;
            }

            float wanted = percent / 100f;
            Prefs.VolumeMusic = wanted;
            ctx.Assert(Math.Abs(Prefs.VolumeMusic - wanted) < 0.001f, $"the music volume should read {wanted} after the step; it reads {Prefs.VolumeMusic}");
        }

        [Given("Nelim's Pickle Tools: the game ambient volume is {int} percent")]
        public void SetAmbientVolume(PickleContext ctx, int percent)
        {
            ctx.Assert(percent >= 0 && percent <= 100, $"a volume between 0 and 100 percent, not {percent}");
            if (originalAmbient == null)
            {
                originalAmbient = Prefs.VolumeAmbient;
            }

            float wanted = percent / 100f;
            Prefs.VolumeAmbient = wanted;
            ctx.Assert(Math.Abs(Prefs.VolumeAmbient - wanted) < 0.001f, $"the ambient volume should read {wanted} after the step; it reads {Prefs.VolumeAmbient}");
        }

        [Given("Nelim's Pickle Tools: the game music and ambience are muted")]
        public void MuteMusicAndAmbience(PickleContext ctx)
        {
            SetMusicVolume(ctx, 0);
            SetAmbientVolume(ctx, 0);
        }

        [AfterScenario]
        public void RestoreVolume()
        {
            if (original != null)
            {
                Prefs.VolumeMaster = original.Value;
                original = null;
            }

            if (originalMusic != null)
            {
                Prefs.VolumeMusic = originalMusic.Value;
                originalMusic = null;
            }

            if (originalAmbient != null)
            {
                Prefs.VolumeAmbient = originalAmbient.Value;
                originalAmbient = null;
            }
        }
    }
}
