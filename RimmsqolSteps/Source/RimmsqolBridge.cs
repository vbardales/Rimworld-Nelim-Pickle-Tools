using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Xml.Linq;
using RIMMSqol;
using RIMMSqol.genericSettings;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.Rimmsqol
{
    /// <summary>What RIMMSQOL's settings file says about one main button.</summary>
    public enum Recorded
    {
        /// <summary>No file, no entry for the button, or an entry that says nothing about Visible.</summary>
        NoChoice,
        Hidden,
        Visible,
    }

    /// <summary>
    /// The only file of this assembly that names a RIMMSqol type. Every public member takes and returns
    /// BCL, game and Pickle types only, so a step class that calls it never has RIMMSqol in a signature:
    /// in a pass where RIMMSqol is not staged the assembly still loads, and the first step that needs it
    /// stops on <see cref="RequireReady"/> with a sentence instead of a TypeLoadException.
    ///
    /// WHAT RIMMSQOL DOES (read from its shipped source and confirmed against the 1.6 RIMMSqol.dll):
    ///
    /// * There is no Harmony patch on the main bar and none on MainButtonWorker.Visible. Its only patch
    ///   on MainButtonsRoot is a Postfix on MainButtonsOnGUI for its own key bindings.
    /// * The choice lives in RIMMSqol's generic settings store: SettingsStorage keeps, for the property
    ///   set "mainButtons", one SettingsInstance per MainButtonDef, keyed by defName, with the fields
    ///   Label, IconPath, Description, Visible, Minimized, Order and Buttons. An instance is written to
    ///   its mod settings file (Config/Mod_&lt;folder&gt;_QOLMod.xml) only while it is active, and it becomes
    ///   active when a field is edited.
    /// * The merger registered for "mainButtons" writes <c>MainButtonDef.buttonVisible</c> directly, the
    ///   same field the game's own worker reads. It runs from SettingsStorage.ApplySettings, which
    ///   QOLMod.WriteSettings calls when its window closes, and once at startup from HarmonyBootstrap.
    /// * Its window is Dialog_ModSettings built for the QOLMod instance. Its menu button "Main Buttons"
    ///   opens a list of ALL MainButtonDefs (hidden ones too), then an edit page whose Visible checkbox is
    ///   <c>instance.set("Visible", value)</c>. The reset cross beside each list entry, and on the Summary
    ///   page, is <c>setActive(false); reset()</c>.
    ///
    /// The steps do exactly those calls instead of moving pixels, then call QOLMod.WriteSettings, which
    /// is what Dialog_ModSettings.PreClose does when the window closes.
    /// </summary>
    public static class RimmsqolBridge
    {
        public const string PackageId = "MalteSchulze.RIMMSqol";
        private const string PropsId = "mainButtons";
        private const string VisibleField = "Visible";

        // ---- presence -------------------------------------------------------------------------

        public static bool IsLoaded() =>
            LoadedModManager.RunningModsListForReading
                .Any(m => string.Equals(m.PackageId, PackageId, StringComparison.OrdinalIgnoreCase));

        /// <summary>
        /// Everything a step needs from RIMMSQOL, checked once and named when missing. A report keeps no
        /// stack trace, so each hop that could be null says which one it was.
        /// </summary>
        public static void RequireReady(PickleContext ctx)
        {
            ctx.Require(IsLoaded(),
                $"{PackageId} is not loaded in this pass, so no RIMMSQOL step can run. Name it in the pass map "
                + "(see PickleTools/RimmsqolSteps/README.md) and play these features in that pass only");
            ctx.Require(LoadedModManager.GetMod<QOLMod>() != null,
                "RIMMSqol is loaded but LoadedModManager.GetMod<QOLMod>() returned nothing: its Mod class did not start");
            ctx.Require(SettingsInit.IsInitialized,
                "RIMMSqol's SettingsInit has not run (SettingsInit.IsInitialized is false): its settings properties do not exist yet");
            ctx.Require(SettingsStorage.getSettingsProperties(PropsId) != null,
                $"RIMMSqol registers no settings property set called '{PropsId}': the main-button editor has moved or been renamed");
        }

        private static QOLMod Mod(PickleContext ctx)
        {
            RequireReady(ctx);
            return LoadedModManager.GetMod<QOLMod>();
        }

        private static MainButtonDef Button(PickleContext ctx, string defName)
        {
            var def = DefDatabase<MainButtonDef>.GetNamedSilentFail(defName);
            ctx.Require(def != null, $"no MainButtonDef named '{defName}' is loaded");
            return def;
        }

        /// <summary>
        /// The instance RIMMSQOL's own list would hand to the edit page for this button. Built by the same
        /// call the list page makes, so a def the list would not show is not found here either.
        /// </summary>
        private static ISettingsInstance Instance(PickleContext ctx, string defName)
        {
            Button(ctx, defName);
            var props = SettingsStorage.getSettingsProperties(PropsId);
            var list = SettingsStorage.generateListForSelection(props);
            ctx.Require(list != null, "RIMMSQOL's main-button list could not be built (generateListForSelection returned null)");
            var found = list.FirstOrDefault(si => string.Equals(si.getKey(), defName, StringComparison.Ordinal));
            ctx.Require(found != null,
                $"RIMMSQOL's own list of main buttons offers no entry for '{defName}'. It offers {list.Count}: "
                + string.Join(", ", list.Select(si => si.getKey()).Take(40).ToArray()));
            return found;
        }

        // ---- what its interface lists and shows ------------------------------------------------

        /// <summary>The label a player reads on the list button, its own second and third lines included.</summary>
        public static string ListEntryLabel(PickleContext ctx, string defName)
        {
            RequireReady(ctx);
            var inst = Instance(ctx, defName);
            return (inst as SettingsInstance)?.getLongLabel() ?? inst.getLabel();
        }

        /// <summary>What the Visible checkbox on the edit page reads.</summary>
        public static bool ShowsVisible(PickleContext ctx, string defName)
        {
            RequireReady(ctx);
            return Instance(ctx, defName).get<bool>(VisibleField);
        }

        /// <summary>Whether RIMMSQOL holds an active (that is, saved and applied) choice for the button.</summary>
        public static bool HoldsChoice(PickleContext ctx, string defName)
        {
            RequireReady(ctx);
            return Instance(ctx, defName).getActive();
        }

        // ---- what its interface does -----------------------------------------------------------

        /// <summary>
        /// Ticks or unticks the Visible checkbox of the button's edit page, then closes the window's
        /// write path. Refuses a change that would change nothing: <c>set</c> only marks an instance
        /// active when the value differs, so a "reveal" of a button that already reads visible would
        /// store nothing and prove nothing.
        /// </summary>
        public static void SetVisible(PickleContext ctx, string defName, bool visible)
        {
            var mod = Mod(ctx);
            var inst = Instance(ctx, defName);
            var verb = visible ? "reveal" : "hide";
            ctx.Require(inst.get<bool>(VisibleField) != visible,
                $"RIMMSQOL already shows '{defName}' as {(visible ? "visible" : "hidden")}: a {verb} would change nothing and store nothing. "
                + "If the button shipped visible, that breaks MOD_SETTINGS.md before RIMMSQOL is involved");

            // Entering the edit page calls OnStartEditing, leaving it OnStopEditing.
            inst.OnStartEditing();
            try { inst.set(VisibleField, visible); }
            finally { inst.OnStopEditing(); }
            RimmsqolSession.Touch(defName);

            // What Dialog_ModSettings.PreClose does. Merges the choice into MainButtonDef.buttonVisible
            // and writes Config/Mod_<folder>_QOLMod.xml.
            mod.WriteSettings();
            Log.Message($"[RIMMSQOL steps] {verb}d '{defName}' through RIMMSQOL's own settings instance; buttonVisible is now {Button(ctx, defName).buttonVisible}");
        }

        /// <summary>
        /// The reset cross beside a list entry: deactivate, reset, and let the write restore the def to
        /// what it was before RIMMSQOL touched it. The entry then leaves the file, which hiding it
        /// again does not do.
        /// </summary>
        public static void Forget(PickleContext ctx, string defName)
        {
            var mod = Mod(ctx);
            var inst = Instance(ctx, defName);
            inst.setActive(false);
            inst.reset();
            mod.WriteSettings();
            Log.Message($"[RIMMSQOL steps] forgot RIMMSQOL's choice for '{defName}'; buttonVisible is now {Button(ctx, defName).buttonVisible}");
        }

        /// <summary>Best effort, for a hook that must not throw. Returns what went wrong, or null.</summary>
        public static string ForgetQuietly(IEnumerable<string> defNames)
        {
            try
            {
                if (!IsLoaded() || LoadedModManager.GetMod<QOLMod>() == null || !SettingsInit.IsInitialized) return null;
                var props = SettingsStorage.getSettingsProperties(PropsId);
                if (props == null) return null;
                var list = SettingsStorage.generateListForSelection(props);
                if (list == null) return "RIMMSQOL's list could not be built";
                foreach (var name in defNames)
                {
                    var inst = list.FirstOrDefault(si => si.getKey() == name);
                    if (inst == null) continue;
                    inst.setActive(false);
                    inst.reset();
                }
                LoadedModManager.GetMod<QOLMod>().WriteSettings();
                return null;
            }
            catch (Exception ex)
            {
                return ex.GetType().Name + ": " + ex.Message;
            }
        }

        // ---- its own window --------------------------------------------------------------------

        /// <summary>
        /// Queues RIMMSQOL's own window, pointing at the button's edit page or, with a null name, at the
        /// "Main Buttons" list. The pointer is consumed by DoSettingsWindowContents on a later frame,
        /// which is what <see cref="NavigationPending"/> reports.
        /// </summary>
        public static void OpenWindow(PickleContext ctx, string defNameOrNull)
        {
            var mod = Mod(ctx);
            var props = SettingsStorage.getSettingsProperties(PropsId);
            MainButtonDef def = defNameOrNull == null ? null : Button(ctx, defNameOrNull);
            if (def != null) Instance(ctx, defNameOrNull); // the list must offer it, as the page will need it
            QOLMod.NavigateToEditing(props, def);
            Find.WindowStack.Add(new Dialog_ModSettings(mod));
        }

        /// <summary>
        /// True while RIMMSQOL still holds a navigation it has not yet applied. If the field has been
        /// renamed this says false and the caller falls back on frames, which is why the step also waits
        /// a few of them. Looked up here and not in a static field: a static initializer naming QOLMod
        /// would run the first time ANY member of this class is touched, the teardown's IsLoaded included,
        /// and fail there in a pass where RIMMSqol is not staged.
        /// </summary>
        public static bool NavigationPending()
        {
            var field = typeof(QOLMod).GetField("navigateToProps", BindingFlags.Static | BindingFlags.NonPublic | BindingFlags.Public);
            return field != null && field.GetValue(null) != null;
        }

        public static bool WindowIsOpen()
        {
            var mod = LoadedModManager.GetMod<QOLMod>();
            if (mod == null || Find.WindowStack == null) return false;
            return Find.WindowStack.Windows.OfType<Dialog_ModSettings>().Any(d => ModOf(d) == mod);
        }

        /// <summary>Dialog_ModSettings keeps the mod in a private field; the first Mod-typed one is taken.</summary>
        private static Mod ModOf(Dialog_ModSettings dialog)
        {
            var field = typeof(Dialog_ModSettings)
                .GetFields(BindingFlags.Instance | BindingFlags.Public | BindingFlags.NonPublic)
                .FirstOrDefault(f => typeof(Mod).IsAssignableFrom(f.FieldType));
            return field?.GetValue(dialog) as Mod;
        }

        // ---- what is on disk -------------------------------------------------------------------

        public static string SettingsFilePath(PickleContext ctx)
        {
            var mod = Mod(ctx);
            var method = typeof(LoadedModManager).GetMethod("GetSettingsFilename",
                BindingFlags.Static | BindingFlags.Public | BindingFlags.NonPublic);
            if (method != null) return (string)method.Invoke(null, new object[] { mod.Content.FolderName, mod.GetType().Name });
            return Path.Combine(GenFilePaths.ConfigFolderPath,
                GenText.SanitizeFilename($"Mod_{mod.Content.FolderName}_{mod.GetType().Name}.xml"));
        }

        /// <summary>
        /// Reads the file the game wrote, not the memory RIMMSQOL keeps: it is the file the next launch
        /// will read. The parsing, and what is assumed about the layout, is <see cref="SettingsFileReader"/>.
        /// </summary>
        public static Recorded ReadFile(PickleContext ctx, string defName, out string detail)
        {
            var path = SettingsFilePath(ctx);
            if (!File.Exists(path)) { detail = "there is no settings file at " + path; return Recorded.NoChoice; }

            XDocument doc;
            try { doc = XDocument.Load(path); }
            catch (Exception ex) { detail = path + " does not parse: " + ex.Message; return Recorded.NoChoice; }
            return SettingsFileReader.Read(doc, defName, out detail);
        }
    }
}