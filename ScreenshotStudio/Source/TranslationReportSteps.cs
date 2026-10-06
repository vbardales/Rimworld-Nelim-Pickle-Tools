using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;
using RimWorks.Pickle;
using UnityEngine;
using Verse;

namespace Nelim.PickleTools.ScreenshotStudio
{
    /// <summary>
    /// "The translation report has no problem for this mod": the game writes its own translation report (Dev menu, "Save translation report"), the
    /// report is global to the loaded mod list, so only the lines that belong to the mod count. Ownership of a keyed translation is its source
    /// file under the mod's folder; ownership of a def injection is the def's own mod.
    /// </summary>
    [PickleSteps]
    public partial class TranslationReportSteps
    {
        private const string Prefix = "Nelim's Pickle Tools: ";

        [Then(Prefix + "the translation report has no problem for the mod {string}", TimeoutSeconds = 300f)]
        public Task NoProblem(PickleContext ctx, string packageId) => Check(ctx, packageId, null);

        [Then(Prefix + "the translation report has no problem for the mod {string}, apart from {string}", TimeoutSeconds = 300f)]
        public Task NoProblemApartFrom(PickleContext ctx, string packageId, string apartFrom) => Check(ctx, packageId, apartFrom);

        private async Task Check(PickleContext ctx, string packageId, string apartFrom)
        {
            var mod = LoadedModManager.RunningMods.FirstOrDefault(m => string.Equals(m.PackageId, packageId, StringComparison.OrdinalIgnoreCase)
                || string.Equals(m.PackageIdPlayerFacing, packageId, StringComparison.OrdinalIgnoreCase));
            ctx.Require(mod != null, "The mod " + packageId + " is not loaded; loaded: " + string.Join(", ", LoadedModManager.RunningMods.Select(m => m.PackageIdPlayerFacing)));

            ctx.Require(LanguageDatabase.activeLanguage != LanguageDatabase.defaultLanguage, "The game writes a translation report only for a language other than English; start the run with -Language <name>");
            string text = await WriteReport(ctx);
            var all = TranslationReportParser.Parse(text);
            ctx.Require(all.Count > 0, "The translation report holds no section: unexpected format");

            string root = Norm(mod.RootDir);
            string folder = Path.GetFileName(root.TrimEnd('/'));
            var keys = new HashSet<string>();
            foreach (var lang in new[] { LanguageDatabase.defaultLanguage, LanguageDatabase.activeLanguage }.Where(l => l != null).Distinct())
                foreach (var kv in lang.keyedReplacements)
                    if (kv.Value.fileSourceFullPath != null && Norm(kv.Value.fileSourceFullPath).StartsWith(root, StringComparison.OrdinalIgnoreCase)) keys.Add(kv.Key);
            var defs = new HashSet<string>(mod.AllDefs.Select(d => d.GetType().Name + ":" + d.defName));

            TranslationReportParser.Filter(all, k => keys.Contains(k), (t, n) => defs.Contains(t + ":" + n),
                line => line.IndexOf(root, StringComparison.OrdinalIgnoreCase) >= 0 || line.IndexOf(folder, StringComparison.OrdinalIgnoreCase) >= 0 || line.IndexOf(mod.PackageIdPlayerFacing, StringComparison.OrdinalIgnoreCase) >= 0,
                out var findings, out var notes, out var global);

            // Kept in the run report like the captures, since the desktop copy is deleted: the whole report (capped), then the lines retained for this mod.
            const int MaxRaw = 1500000;
            ctx.Attach("translation-report-raw", text.Length <= MaxRaw ? text : text.Substring(0, MaxRaw) + "\n[cut: " + (text.Length - MaxRaw) + " more characters]");
            if (!string.IsNullOrEmpty(apartFrom)) findings = findings.Where(f => f.Text.IndexOf(apartFrom, StringComparison.OrdinalIgnoreCase) < 0).ToList();
            ctx.Attach("translation-report-mod", packageId + " (" + LanguageDatabase.activeLanguage.FriendlyNameEnglish + "): " + findings.Count + " findings, " + notes.Count + " notes, " + global.Count + " global load errors\n"
                + string.Join("\n", findings.Select(f => "[" + f.Section + "] " + f.Text.Replace("\n", " "))));
            Log.Message("[translation report] " + packageId + " (" + LanguageDatabase.activeLanguage.FriendlyNameEnglish + "): " + findings.Count + " findings, " + notes.Count + " notes, " + global.Count + " global load errors (not this mod's)");
            foreach (var g in global) Log.Message("[translation report] global: " + g.Text.Split('\n')[0]);
            foreach (var n in notes) Log.Message("[translation report] note: " + n.Text.Split('\n')[0]);
            await Task.Yield();
            ctx.Assert(findings.Count == 0, "The translation report has " + findings.Count + " problem(s) for " + packageId + ":\n"
                + string.Join("\n", findings.Take(40).Select(f => "  [" + f.Section + "] " + f.Text.Replace("\n", " "))));
        }

        // Asks the game for its own report, then reads the newest TranslationReport.txt under its data folder.
        private static async Task<string> WriteReport(PickleContext ctx)
        {
            var type = GenTypes.GetTypeInAnyAssembly("LanguageReportGenerator") ?? GenTypes.GetTypeInAnyAssembly("Verse.LanguageReportGenerator");
            ctx.Require(type != null, "The game has no LanguageReportGenerator type");
            var method = type.GetMethod("SaveTranslationReport", BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Static);
            ctx.Require(method != null, "LanguageReportGenerator has no SaveTranslationReport method");
            // The game writes the report on the desktop; a Linux home without a Desktop folder makes it fail with DirectoryNotFoundException, so make the folder.
            string desktop = Environment.GetFolderPath(Environment.SpecialFolder.Desktop);
            if (!string.IsNullOrEmpty(desktop)) Directory.CreateDirectory(desktop);
            var before = DateTime.UtcNow.AddSeconds(-2);
            // Run the generator itself on this thread when it can be found: the public method hands it to a worker thread that never finished within four minutes under WSL.
            var direct = type.GetMethod("DoSaveTranslationReport", BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Static);
            try { (direct ?? method).Invoke(null, null); }
            catch (TargetInvocationException e) { ctx.Require(false, "The translation report generator threw: " + e.InnerException); }
            // The game may write the report from a long event, on a background thread (the def-injection scan took over 30 s under WSL): poll for it, up to four minutes.
            var roots = new[] { desktop, Application.persistentDataPath, GenFilePaths.SaveDataFolderPath, GenFilePaths.ConfigFolderPath }.Where(p => !string.IsNullOrEmpty(p) && Directory.Exists(p)).Distinct().ToList();
            for (int i = 0; i < 240; i++)
            {
                var files = roots.SelectMany(p => Directory.GetFiles(p, "TranslationReport*.txt", SearchOption.AllDirectories)).Select(f => new FileInfo(f)).OrderByDescending(f => f.LastWriteTimeUtc).ToList();
                if (files.Count > 0 && files[0].LastWriteTimeUtc >= before)
                {
                    string text = File.ReadAllText(files[0].FullName);
                    // Do not leave the report on the desktop (the game gives no choice of folder): it is read, so it goes.
                    if (!string.IsNullOrEmpty(desktop) && Norm(files[0].DirectoryName).Equals(Norm(desktop), StringComparison.OrdinalIgnoreCase)) files[0].Delete();
                    return text;
                }
                await Task.Delay(500);
            }
            ctx.Require(false, "SaveTranslationReport ran but no fresh TranslationReport*.txt appeared under: " + string.Join(", ", roots));
            return null;
        }

        private static string Norm(string path) => (path ?? "").Replace('\\', '/');
    }
}
