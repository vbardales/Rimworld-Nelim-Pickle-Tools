using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using HarmonyLib;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.LoadAudit
{
    /// <summary>
    /// Reads the messages the game posted on screen since the scenario began. The text of a message is compared through its
    /// translation key, never as an English sentence, so the same step holds in every language.
    /// </summary>
    [PickleSteps]
    public class MessageSteps
    {
        private const float WaitSeconds = 10f;

        /// <summary>
        /// Asserts that the game posted a message whose text is the translation of the key, since the scenario began. The key is
        /// compared, not an English sentence: the fixed text around the placeholders of the translation must appear in the
        /// message, in order, whatever the language and whatever fills the placeholders.
        /// </summary>
        [Then("Nelim's Pickle Tools: a message {string} appeared", TimeoutSeconds = 15f)]
        public async Task MessageAppeared(PickleContext ctx, string key)
        {
            ctx.Require(MessageLog.Installed, "the message log is not installed: its [BeforeScenario] did not run, or the game has no Messages.Message(Message, bool)");
            ctx.Require(
                key.CanTranslate(),
                $"no translation is loaded for \"{key}\"; active language: {LanguageDatabase.activeLanguage?.FriendlyNameEnglish ?? "(none)"}");
            string template = key.Translate().Resolve();
            Regex pattern = MessageLog.PatternOf(template);

            await ctx.AssertEventually(
                () => MessageLog.Texts().Any(t => pattern.IsMatch(t)),
                () => $"no message matching the translation of \"{key}\" ({template}) appeared within {WaitSeconds} seconds; the messages were: " +
                    (MessageLog.Texts().Count == 0 ? "(none)" : string.Join(" | ", MessageLog.Texts())),
                WaitSeconds);
        }

        [BeforeScenario]
        public void InstallMessageLog(PickleContext ctx)
        {
            MessageLog.Install();
            MessageLog.Clear();
        }

        /// <summary>
        /// Keeps the text of every message the game was asked to show since the scenario began. All the Messages.Message overloads end in
        /// Messages.Message(Message, bool), so one prefix there sees them all, including a message the game then drops as a duplicate.
        /// </summary>
        internal static class MessageLog
        {
            private static readonly List<string> Seen = new List<string>();
            private static bool installed;

            public static bool Installed { get { return installed; } }

            public static void Install()
            {
                if (installed)
                {
                    return;
                }

                MethodInfo target = AccessTools.Method(typeof(Messages), "Message", new[] { typeof(Message), typeof(bool) });
                if (target == null)
                {
                    return;
                }

                new Harmony("nelim.pickletools.loadaudit").Patch(target, prefix: new HarmonyMethod(typeof(MessageLog), nameof(Record)));
                installed = true;
            }

            public static void Clear()
            {
                lock (Seen)
                {
                    Seen.Clear();
                }
            }

            public static List<string> Texts()
            {
                lock (Seen)
                {
                    return Seen.ToList();
                }
            }

            /// <summary>The fixed parts of a translation (the text between its {placeholders}), in order, as a pattern.</summary>
            public static Regex PatternOf(string template)
            {
                IEnumerable<string> parts = Regex.Split(template, @"\{[^}]*\}").Where(s => s.Trim().Length > 0).Select(Regex.Escape);
                return new Regex(string.Join(".*", parts), RegexOptions.Singleline | RegexOptions.IgnoreCase);
            }

            private static void Record(Message msg)
            {
                if (msg?.text == null)
                {
                    return;
                }

                lock (Seen)
                {
                    Seen.Add(msg.text);
                }
            }
        }
    }
}
