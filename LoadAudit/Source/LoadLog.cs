using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Nelim.PickleTools.LoadAudit
{
    /// <summary>One message of the game log, with the stack frames that follow it.</summary>
    public sealed class LogEntry
    {
        public int Line;
        public string Level;
        public string Source;
        public string Message;
        public readonly List<string> Frames = new List<string>();
    }

    /// <summary>What the game holds of one mod, gathered by the step and handed to the analysis, which needs no game.</summary>
    public sealed class ModProfile
    {
        public string PackageId;
        public HashSet<string> TypeNames = new HashSet<string>(StringComparer.Ordinal);
        public HashSet<string> AssemblyNames = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        public HashSet<string> DefNames = new HashSet<string>(StringComparer.Ordinal);
    }

    public sealed class Finding
    {
        public string Kind;
        public int Line;
        public string Text;

        public override string ToString()
        {
            return $"[{Kind}] line {Line}: {Text}";
        }
    }

    /// <summary>
    /// The part of the load audit that needs no game: reading the log and deciding which messages belong to a mod. Kept apart from the
    /// step so plain .NET can test it, the way SoundCapture tests its analysis.
    ///
    /// The log this reads is the one Pickle's runs produce (RimWorks.RimLogging): each message is
    /// <c>&lt;color=#B2B2B2&gt;[time] [LEVEL] [Source] &lt;/color&gt;text</c>, where the source of a message that a mod logged is
    /// <c>Mod.&lt;packageId&gt;</c>, and the stack frames of an exception follow as lines that start with <c>at </c>. The words the game logs
    /// with are constants of its code, not translations, so nothing here depends on the language of the pass.
    /// </summary>
    public static class LoadLog
    {
        /// <summary>The same message this many times or more, from one mod, is a finding: the game's own debug log groups repeats for the same reason.</summary>
        public const int RepeatThreshold = 5;

        private static readonly Regex Head = new Regex(
            @"^(?:<color=[^>]*>)?\[(?<time>[^\]]*)\]\s+\[(?<level>[A-Z]+)\]\s+\[(?<source>[^\]]*)\]\s*(?:</color>)?(?<message>.*)$",
            RegexOptions.CultureInvariant);

        private static readonly Regex Word = new Regex(@"[A-Za-z0-9_]+", RegexOptions.CultureInvariant);
        private static readonly Regex Digits = new Regex(@"-?\d+(?:\.\d+)?", RegexOptions.CultureInvariant);

        // The game's own texts for a definition that does not hold together (Verse.DirectXmlCrossRefLoader, Def.ConfigErrors).
        private static readonly string[] DefProblems =
        {
            "Could not resolve cross-reference",
            "Config error in",
            "Faulty MayRequire",
            "Duplicate def",
        };

        public static List<LogEntry> Parse(IEnumerable<string> lines)
        {
            var entries = new List<LogEntry>();
            LogEntry last = null;
            int number = 0;
            foreach (string raw in lines)
            {
                number++;
                Match head = Head.Match(raw);
                if (head.Success)
                {
                    last = new LogEntry
                    {
                        Line = number,
                        Level = head.Groups["level"].Value,
                        Source = head.Groups["source"].Value,
                        Message = head.Groups["message"].Value.Trim(),
                    };
                    entries.Add(last);
                    continue;
                }

                string trimmed = raw.TrimStart();
                if (last != null && trimmed.StartsWith("at ", StringComparison.Ordinal))
                {
                    last.Frames.Add(trimmed.Substring(3));
                }
                // Any other line is Unity chatter or the rest of a message: it is not a message, and is never added to the one before it.
            }

            return entries;
        }

        /// <summary>Why the entry belongs to the mod, or null when it does not.</summary>
        public static string BelongsTo(LogEntry entry, ModProfile mod)
        {
            if (string.Equals(entry.Source, "Mod." + mod.PackageId, StringComparison.OrdinalIgnoreCase))
            {
                return "logged by the mod";
            }

            foreach (string frame in entry.Frames)
            {
                string type = TypeOfFrame(frame);
                for (string name = type; !string.IsNullOrEmpty(name); name = StripLastSegment(name))
                {
                    if (mod.TypeNames.Contains(name))
                    {
                        return "a frame of its stack is in the mod's assembly (" + name + ")";
                    }
                }
            }

            foreach (string assembly in mod.AssemblyNames)
            {
                if (NamesAssembly(entry.Message, assembly))
                {
                    return "its message names the mod's assembly " + assembly;
                }
            }

            return null;
        }

        // An assembly name has dots and hyphens ("Nelim.PickleTools.X"), which the word pattern splits: look for the whole name, between characters that cannot belong to a name.
        private static bool NamesAssembly(string message, string assembly)
        {
            if (string.IsNullOrEmpty(assembly))
            {
                return false;
            }

            for (int at = message.IndexOf(assembly, StringComparison.OrdinalIgnoreCase); at >= 0;
                 at = message.IndexOf(assembly, at + 1, StringComparison.OrdinalIgnoreCase))
            {
                int end = at + assembly.Length;
                bool before = at == 0 || !(char.IsLetterOrDigit(message[at - 1]) || message[at - 1] == '_');
                bool after = end >= message.Length || !(char.IsLetterOrDigit(message[end]) || message[end] == '_');
                if (before && after)
                {
                    return true;
                }
            }

            return false;
        }

        /// <summary>The game's message about a definition that does not resolve or does not hold together, and whether one of the mod's defs is in it.</summary>
        public static bool IsDefProblem(LogEntry entry)
        {
            return entry.Level != "INFO" && DefProblems.Any(text => entry.Message.IndexOf(text, StringComparison.Ordinal) >= 0);
        }

        public static bool MentionsADefOf(LogEntry entry, ModProfile mod)
        {
            foreach (Match word in Word.Matches(entry.Message))
            {
                if (mod.DefNames.Contains(word.Value))
                {
                    return true;
                }
            }

            return false;
        }

        /// <param name="entries">The parsed log.</param>
        /// <param name="mod">What the game holds of the mod.</param>
        /// <param name="apartFrom">A message the owner knows and justifies: any entry whose text contains this (ignoring case) is left out.</param>
        public static List<Finding> Audit(List<LogEntry> entries, ModProfile mod, string apartFrom = null)
        {
            var findings = new List<Finding>();
            var attributed = new List<LogEntry>();

            foreach (LogEntry entry in entries)
            {
                if (!string.IsNullOrEmpty(apartFrom) && (entry.Message.IndexOf(apartFrom, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    entry.Frames.Any(f => f.IndexOf(apartFrom, StringComparison.OrdinalIgnoreCase) >= 0)))
                {
                    continue;
                }

                string why = BelongsTo(entry, mod);

                if (IsDefProblem(entry) && (why != null || MentionsADefOf(entry, mod)))
                {
                    findings.Add(new Finding { Kind = "definition", Line = entry.Line, Text = entry.Level + " " + Short(entry.Message) });
                    attributed.Add(entry);
                    continue;
                }

                if (why == null)
                {
                    continue;
                }

                attributed.Add(entry);
                if (entry.Level == "ERROR" || entry.Level == "WARN")
                {
                    findings.Add(new Finding
                    {
                        Kind = entry.Level == "ERROR" ? "error" : "warning",
                        Line = entry.Line,
                        Text = Short(entry.Message) + " (" + why + ")",
                    });
                }
            }

            foreach (var group in attributed.GroupBy(e => Normalize(e.Message)).Where(g => g.Count() >= RepeatThreshold))
            {
                LogEntry first = group.First();
                findings.Add(new Finding
                {
                    Kind = "repeated",
                    Line = first.Line,
                    Text = $"{group.Count()} times: {Short(first.Message)}",
                });
            }

            return findings.OrderBy(f => f.Line).ToList();
        }

        /// <summary>The text of a message with its numbers taken out, so that the same message with another id or time is the same message.</summary>
        public static string Normalize(string message)
        {
            return Digits.Replace(message, "#").Trim();
        }

        private static string Short(string message)
        {
            string flat = message.Replace("\r", " ").Replace("\n", " ").Trim();
            return flat.Length <= 220 ? flat : flat.Substring(0, 217) + "...";
        }

        // "Ns.Type.Method (args) [0x0] in <hash>:0" -> "Ns.Type.Method"
        private static string TypeOfFrame(string frame)
        {
            int end = frame.IndexOfAny(new[] { ' ', '(' });
            string method = end < 0 ? frame : frame.Substring(0, end);
            return StripLastSegment(method);
        }

        private static string StripLastSegment(string name)
        {
            int dot = name.LastIndexOf('.');
            return dot <= 0 ? null : name.Substring(0, dot);
        }
    }
}
