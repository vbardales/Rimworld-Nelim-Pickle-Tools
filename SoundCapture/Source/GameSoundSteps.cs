using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using RimWorks.Pickle;
using Verse;
using Verse.Sound;

namespace Nelim.PickleTools.SoundCapture
{
    /// <summary>
    /// Asserts on what the GAME holds as playing, not on what reaches an audio device. The two are different claims:
    /// the game keeps a live <c>Sustainer</c> for a looping sound, a list of playing one-shot samples, and, on the main
    /// menu, an <c>AudioSource</c> for its music. That any of them is there says the game STARTED a sound, whatever a
    /// loudspeaker then does with it; that is the check EponaInstrumentsRenew's suite makes for its instruments, and it
    /// works headless where the recorder of <see cref="SoundSteps"/> has measured silence. What it does not say is that
    /// a person can hear it: that stays by ear, or with the recorder.
    ///
    /// Every pattern starts with "Nelim's Pickle Tools:" so that it cannot be ambiguous with a step of Pickle's own.
    /// </summary>
    [PickleSteps]
    public class GameSoundSteps
    {
        private const int WaitSeconds = 10;

        /// <summary>
        /// Passes as soon as the game holds one sound that is playing, and waits up to ten real seconds for one: a
        /// menu's music and a click's sample do not start on the frame a scenario asks. The failure lists what the game
        /// held, so that "no sound" and "no way to look" are told apart.
        /// </summary>
        [Then("Nelim's Pickle Tools: the game is playing a sound", TimeoutSeconds = 30)]
        public async Task IsPlayingASound(PickleContext ctx)
        {
            await WaitFor(ctx, null, "a sound");
        }

        /// <summary>
        /// Passes when a live sustainer, or a playing one-shot, was started from the sound def of that name (for example
        /// <c>MIC_Ocarina_Play</c>). The menu's music is not a def, so it never satisfies this one.
        /// </summary>
        [Then("Nelim's Pickle Tools: the game is playing the sound {string}", TimeoutSeconds = 30)]
        public async Task IsPlayingTheSound(PickleContext ctx, string soundDefName)
        {
            await WaitFor(ctx, soundDefName, $"the sound {soundDefName}");
        }

        private static async Task WaitFor(PickleContext ctx, string defName, string what)
        {
            var clock = Stopwatch.StartNew();
            Snapshot last;
            while (true)
            {
                last = Snapshot.Take();
                if (last.Satisfies(defName))
                {
                    return;
                }

                if (clock.Elapsed.TotalSeconds >= WaitSeconds)
                {
                    break;
                }

                await ctx.WaitFrames(5);
            }

            ctx.Assert(false, $"the game is not playing {what} after {WaitSeconds} real seconds; it holds {last.Describe()}");
        }

        /// <summary>What the game holds as playing at one instant.</summary>
        private sealed class Snapshot
        {
            public string Problem;
            public readonly List<string> Sustainers = new List<string>();
            public readonly List<string> OneShots = new List<string>();
            public bool? MenuMusic;

            public static Snapshot Take()
            {
                var s = new Snapshot();
                SoundRoot soundRoot = Current.Root?.soundRoot;
                if (soundRoot == null)
                {
                    s.Problem = "no sound root (Current.Root has none)";
                }
                else
                {
                    foreach (Sustainer sustainer in soundRoot.sustainerManager?.AllSustainers ?? new List<Sustainer>())
                    {
                        if (sustainer != null && !sustainer.Ended)
                        {
                            s.Sustainers.Add(sustainer.def?.defName ?? "(no def)");
                        }
                    }

                    foreach (SampleOneShot sample in soundRoot.oneShotManager?.PlayingOneShots ?? Enumerable.Empty<SampleOneShot>())
                    {
                        if (sample != null)
                        {
                            s.OneShots.Add(sample.subDef?.parentDef?.defName ?? "(no def)");
                        }
                    }
                }

                if (Current.Root is Root_Entry entry && entry.musicManagerEntry != null)
                {
                    s.MenuMusic = MenuMusicIsPlaying(entry.musicManagerEntry);
                }

                return s;
            }

            // The music's AudioSource is a private field, read by reflection. Null when it cannot be read: the failure
            // then says the menu music was not applicable, not that it was silent.
            private static bool? MenuMusicIsPlaying(object musicManagerEntry)
            {
                object source = musicManagerEntry.GetType()
                    .GetField("audioSource", BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
                    ?.GetValue(musicManagerEntry);
                object playing = source?.GetType().GetProperty("isPlaying")?.GetValue(source, null);
                return playing as bool?;
            }

            public bool Satisfies(string defName)
            {
                if (defName == null)
                {
                    return Sustainers.Count > 0 || OneShots.Count > 0 || MenuMusic == true;
                }

                return Sustainers.Contains(defName) || OneShots.Contains(defName);
            }

            public string Describe()
            {
                var text = new StringBuilder();
                if (Problem != null)
                {
                    text.Append(Problem).Append("; ");
                }

                text.Append(Sustainers.Count).Append(" live sustainer(s)");
                if (Sustainers.Count > 0)
                {
                    text.Append(" (").Append(string.Join(", ", Sustainers.Distinct().Take(8))).Append(')');
                }

                text.Append(", ").Append(OneShots.Count).Append(" playing one-shot(s)");
                if (OneShots.Count > 0)
                {
                    text.Append(" (").Append(string.Join(", ", OneShots.Distinct().Take(8))).Append(')');
                }

                text.Append(", menu music ").Append(MenuMusic == null ? "not applicable (not the entry scene)" : MenuMusic.Value ? "playing" : "not playing");
                return text.ToString();
            }
        }
    }
}
