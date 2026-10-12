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

        /// <summary>
        /// Asserts that the active language recorded no load error: the active language's <c>loadErrors</c> and the <c>loadErrors</c> of each of its DefInjected packages are empty
        /// (the English fallback is not read). The failure message lists every error, by package. Written 2026-10-11 from Animal Ark's own step (its <c>NoLanguageLoadError</c>), for the
        /// French load errors the game reports on vanilla defs (Biotech, Odyssey, Vacstone, Mechanoid) that a pass without the tested mod
        /// has to be compared with. It does not say which mod an error comes from. Main menu, no save needed. Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: the active language recorded no load error")]
        public void ActiveLanguageHasNoLoadError(PickleContext ctx)
        {
            LoadedLanguage active = LanguageDatabase.activeLanguage;
            ctx.Assert(active != null, "no active language");
            var report = new List<string>();
            foreach (LoadedLanguage language in new[] { active })
            {
                if (language.loadErrors != null && language.loadErrors.Count > 0)
                {
                    report.Add($"{language.folderName} ({language.loadErrors.Count} load errors):\n" +
                               string.Join("\n", language.loadErrors.Select((e, i) => $"{i + 1}. {e}")));
                }

                foreach (DefInjectionPackage package in language.defInjections)
                {
                    if (package.loadErrors != null && package.loadErrors.Count > 0)
                    {
                        report.Add($"{language.folderName} DefInjected {package.defType?.Name} ({package.loadErrors.Count} errors):\n" +
                                   string.Join("\n", package.loadErrors.Select((e, i) => $"{i + 1}. {e}")));
                    }
                }
            }

            ctx.Assert(report.Count == 0, $"active language {active.folderName}; " + string.Join("\n", report));
        }

        /// <summary>
        /// Waits (up to 120 s) until the game has no long event running or waiting (<c>LongEventHandler.AnyEventNowOrWaiting</c> is false), so
        /// that the load is over before the log is read. Written 2026-10-11 from the same step in three mods (Chinese Animals, Ebbbs Renew,
        /// Moa Renew). Not played here.
        /// </summary>
        [Given("Nelim's Pickle Tools: the game has finished starting", TimeoutSeconds = 125f)]
        public async System.Threading.Tasks.Task GameHasFinishedStarting(PickleContext ctx)
        {
            await ctx.WaitUntil(() => !LongEventHandler.AnyEventNowOrWaiting, 120f);
        }

        /// <summary>
        /// Asserts the game log, read from its start to now, holds this text. For a message the mod is expected to log (a positive check),
        /// as opposed to <c>the load of the mod ... is clean</c>, which fails on messages that should not be there. Written 2026-10-11 from
        /// the same step in two mods (Funny Creatures Renew, Megabees Renew). Not played here.
        /// </summary>
        [Then("Nelim's Pickle Tools: the game log holds the text {string}")]
        public void LogHoldsText(PickleContext ctx, string fragment)
        {
            string path = Application.consoleLogPath;
            ctx.Require(!string.IsNullOrEmpty(path) && File.Exists(path), "the game log is not readable at '" + path + "'");
            string text = string.Join("\n", ReadLines(path));
            ctx.Assert(text.Contains(fragment),
                $"the game log ({text.Length} characters, read from the start) does not contain '{fragment}'");
        }

        /// <summary>
        /// Asserts the About.xml of the first mod (by packageId, installed, active or not) declares the second in <c>incompatibleWith</c>
        /// (the plain list and the block of the running game version), read through <c>ModMetaData</c>. For a pass that stages both on
        /// purpose, where the game only warns and loads both. Written 2026-10-12 for A Perfect Mind in a Perfect Body. Not played.
        /// </summary>
        [Then("Nelim's Pickle Tools: the mod {string} declares itself incompatible with {string}")]
        public void DeclaresIncompatible(PickleContext ctx, string packageId, string otherPackageId)
        {
            ModMetaData meta = ModLister.AllInstalledMods.FirstOrDefault(
                m => string.Equals(m.PackageId, packageId, StringComparison.OrdinalIgnoreCase) ||
                     string.Equals(m.PackageIdPlayerFacing, packageId, StringComparison.OrdinalIgnoreCase));
            ctx.Require(meta != null, $"no installed mod has the packageId \"{packageId}\"");
            List<string> declared = meta.IncompatibleWith.ToList();
            bool found = declared.Any(
                id => string.Equals(id, otherPackageId, StringComparison.OrdinalIgnoreCase) ||
                      string.Equals(id.Replace("_steam", string.Empty).Replace("_copy", string.Empty), otherPackageId, StringComparison.OrdinalIgnoreCase));
            ctx.Assert(
                found,
                $"the mod {meta.PackageId} does not declare itself incompatible with \"{otherPackageId}\"; its incompatibleWith is: " +
                (declared.Count == 0 ? "(empty)" : string.Join(", ", declared)));
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
