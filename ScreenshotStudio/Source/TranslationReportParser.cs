using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// Reads the text the game's "Save translation report" writes (TranslationReport.txt) and keeps the lines that belong to one mod.
    /// No game types here, so the same file runs in a plain console to check a real report.
    /// </summary>
    public static class TranslationReportParser
    {
        public sealed class Entry { public string Section; public string Text; }

        // Sections whose lines are findings when they belong to the mod. "matching English (maybe ok)" is a note, never a finding.
        private static readonly string[] FindingSections =
        {
            "General load errors", "Def-injected translations load errors", "Missing keyed translations", "Def-injected translations missing",
            "Unnecessary def-injected translations", "Def-injected translations using old, renamed defs", "Argument count mismatches", "Unnecessary keyed translations",
            "Backstories translation using obsolete format",
        };
        private const string NoteSection = "Keyed translations matching English";

        private static readonly Regex Heading = new Regex(@"^=+\s*(?<t>.*?)\s*\((?<n>\d+)\)\s*=+\s*$", RegexOptions.Compiled);
        private static readonly Regex Key = new Regex(@"^(?<k>[A-Za-z0-9_.\-]+)\s", RegexOptions.Compiled);
        private static readonly Regex DefLine = new Regex(@"^(?<type>[A-Za-z0-9_]+):\s*(?<def>[^.\s']+)", RegexOptions.Compiled);

        /// <summary>Every entry (a heading's lines; an indented "- 'text'" line belongs to the entry above it), by section title.</summary>
        public static List<Entry> Parse(string report)
        {
            var entries = new List<Entry>();
            string section = null;
            Entry last = null;
            foreach (var raw in (report ?? "").Replace("\r", "").Split('\n'))
            {
                var m = Heading.Match(raw.Trim());
                if (m.Success) { section = m.Groups["t"].Value; last = null; continue; }
                if (section == null || raw.Trim().Length == 0) continue;
                if (char.IsWhiteSpace(raw[0]) && last != null) { last.Text += "\n" + raw.TrimEnd(); continue; }
                last = new Entry { Section = section, Text = raw.TrimEnd() };
                entries.Add(last);
            }
            return entries;
        }

        /// <summary>
        /// The findings and the notes of one mod, and the load errors of nobody in particular. ownsKey tells whether a keyed translation key is the mod's,
        /// ownsDef whether a (Type, defName) is, mentionsMod whether a free line (a load error) names a file or a def of the mod.
        /// </summary>
        public static void Filter(IEnumerable<Entry> entries, Func<string, bool> ownsKey, Func<string, string, bool> ownsDef, Func<string, bool> mentionsMod,
            out List<Entry> findings, out List<Entry> notes, out List<Entry> globalErrors)
        {
            findings = new List<Entry>(); notes = new List<Entry>(); globalErrors = new List<Entry>();
            foreach (var e in entries)
            {
                bool isNote = e.Section.StartsWith(NoteSection, StringComparison.OrdinalIgnoreCase);
                bool isFinding = FindingSections.Any(s => e.Section.StartsWith(s, StringComparison.OrdinalIgnoreCase));
                if (!isNote && !isFinding) continue;
                string first = e.Text.Split('\n')[0];
                bool owned;
                if (e.Section.StartsWith("General load errors") || e.Section.StartsWith("Def-injected translations load errors") || e.Section.StartsWith("Backstories"))
                {
                    owned = mentionsMod(e.Text);
                    if (!owned) { globalErrors.Add(e); continue; }
                }
                else if (e.Section.StartsWith("Def-injected"))
                {
                    var d = DefLine.Match(first);
                    owned = (d.Success && ownsDef(d.Groups["type"].Value, d.Groups["def"].Value)) || mentionsMod(first);
                }
                else
                {
                    var k = Key.Match(first);
                    owned = k.Success && ownsKey(k.Groups["k"].Value);
                }
                if (!owned) continue;
                if (isNote) notes.Add(e); else findings.Add(e);
            }
        }
    }
}
