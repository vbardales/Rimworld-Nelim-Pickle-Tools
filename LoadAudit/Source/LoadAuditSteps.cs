using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.LoadAudit
{
    /// <summary>
    /// One assertion for the criterion every mod shares: that the game's log holds nothing wrong that comes from the mod. It reads the
    /// game log from the start of the game to now and fails, listing the lines, when it holds for the mod (1) an error, an exception or a
    /// warning that belongs to it, (2) a reference or a definition the game says does not resolve or hold together, one of the mod's defs
    /// being in it, (4) the same message five times or more, and it compares the mod's keyed translations with the active language
    /// (3), which the log cannot do since the game logs no missing key.
    ///
    /// A message belongs to the mod when the game's logger tagged it <c>Mod.&lt;packageId&gt;</c>, when a frame of its stack is a type of
    /// the mod's assemblies, or when its text names one of the mod's assemblies. The game's words are constants of its code, not
    /// translations, so the check does not depend on the language of the pass.
    ///
    /// Every pattern starts with "Nelim's Pickle Tools:" so that it cannot be ambiguous with a step of Pickle's own.
    /// </summary>
    [PickleSteps]
    public class LoadAuditSteps
    {
        private const int MaxLinesShown = 30;

        [Then("Nelim's Pickle Tools: the load of the mod {string} is clean")]
        public void IsClean(PickleContext ctx, string packageId)
        {
            Check(ctx, packageId, null);
        }

        [Then("Nelim's Pickle Tools: the load of the mod {string} is clean, apart from {string}")]
        public void IsCleanApartFrom(PickleContext ctx, string packageId, string known)
        {
            ctx.Assert(!string.IsNullOrWhiteSpace(known), "'apart from' names the message that is known and justified, not an empty text");
            Check(ctx, packageId, known);
        }

        private static void Check(PickleContext ctx, string packageId, string apartFrom)
        {
            ModContentPack pack = LoadedModManager.RunningMods.FirstOrDefault(
                m => string.Equals(m.PackageId, packageId, StringComparison.OrdinalIgnoreCase) ||
                     string.Equals(m.PackageIdPlayerFacing, packageId, StringComparison.OrdinalIgnoreCase));
            ctx.Assert(
                pack != null,
                $"the mod \"{packageId}\" is not loaded in this run; the {LoadedModManager.RunningMods.Count()} loaded mods include: " +
                string.Join(", ", LoadedModManager.RunningMods.Select(m => m.PackageId).Take(40)));

            ModProfile profile = ProfileOf(pack);

            string path = Application.consoleLogPath;
            ctx.Assert(!string.IsNullOrEmpty(path) && File.Exists(path), $"the game log cannot be read: no file at '{path}'");
            List<string> lines = ReadLines(path);
            List<Finding> findings = LoadLog.Audit(LoadLog.Parse(lines), profile, apartFrom);
            List<string> translation = TranslationProblems(pack);

            ctx.Attach(
                "load-audit",
                $"mod {pack.PackageId}: {lines.Count} log lines read from {path}, {profile.TypeNames.Count} types, {profile.DefNames.Count} defs; " +
                $"{findings.Count} finding(s) in the log, {translation.Count} translation problem(s)" +
                (apartFrom != null ? $", apart from \"{apartFrom}\"" : string.Empty));

            if (findings.Count == 0 && translation.Count == 0)
            {
                return;
            }

            var report = new StringBuilder();
            report.AppendLine($"the load of the mod {pack.PackageId} is not clean:");
            foreach (Finding finding in findings.Take(MaxLinesShown))
            {
                report.AppendLine("  " + finding);
            }

            if (findings.Count > MaxLinesShown)
            {
                report.AppendLine($"  ... and {findings.Count - MaxLinesShown} more in the log");
            }

            foreach (string problem in translation.Take(MaxLinesShown))
            {
                report.AppendLine("  [translation] " + problem);
            }

            if (translation.Count > MaxLinesShown)
            {
                report.AppendLine($"  ... and {translation.Count - MaxLinesShown} more");
            }

            ctx.Assert(false, report.ToString().TrimEnd());
        }

        private static ModProfile ProfileOf(ModContentPack pack)
        {
            var profile = new ModProfile { PackageId = pack.PackageId };
            foreach (System.Reflection.Assembly assembly in pack.assemblies.loadedAssemblies)
            {
                profile.AssemblyNames.Add(assembly.GetName().Name);
                Type[] types;
                try
                {
                    types = assembly.GetTypes();
                }
                catch (System.Reflection.ReflectionTypeLoadException exception)
                {
                    types = exception.Types.Where(t => t != null).ToArray();
                }

                foreach (Type type in types)
                {
                    if (type.FullName != null)
                    {
                        profile.TypeNames.Add(type.FullName);
                    }
                }
            }

            foreach (Def def in pack.AllDefs)
            {
                profile.DefNames.Add(def.defName);
            }

            return profile;
        }

        // The log is written while the game runs: it is opened for sharing, and read as it stands.
        private static List<string> ReadLines(string path)
        {
            var lines = new List<string>();
            using (var stream = new FileStream(path, FileMode.Open, FileAccess.Read, FileShare.ReadWrite | FileShare.Delete))
            using (var reader = new StreamReader(stream, Encoding.UTF8))
            {
                string line;
                while ((line = reader.ReadLine()) != null)
                {
                    lines.Add(line);
                }
            }

            return lines;
        }

        // The game logs no missing key, it returns the key. So this reads the data: every keyed string the mod defines in the default
        // language that the active language has not (or has as a placeholder), and the errors the active language recorded in the mod's files.
        private static List<string> TranslationProblems(ModContentPack pack)
        {
            var problems = new List<string>();
            LoadedLanguage active = LanguageDatabase.activeLanguage;
            LoadedLanguage fallback = LanguageDatabase.defaultLanguage;
            if (active == null || fallback == null)
            {
                return problems;
            }

            string root = pack.RootDir.Replace('\\', '/').TrimEnd('/') + "/";

            if (active != fallback)
            {
                foreach (LoadedLanguage.KeyedReplacement keyed in fallback.keyedReplacements.Values)
                {
                    string file = (keyed.fileSourceFullPath ?? string.Empty).Replace('\\', '/');
                    if (file.StartsWith(root, StringComparison.OrdinalIgnoreCase) && !active.HaveTextForKey(keyed.key, false))
                    {
                        problems.Add($"the key '{keyed.key}' ({keyed.fileSource}) has no text in {active.FriendlyNameEnglish}: the game shows the default language or the key");
                    }
                }
            }

            foreach (string error in active.loadErrors ?? new List<string>())
            {
                if (error.Replace('\\', '/').IndexOf(root, StringComparison.OrdinalIgnoreCase) >= 0)
                {
                    problems.Add("load error: " + error.Replace("\n", " "));
                }
            }

            return problems;
        }
    }
}
