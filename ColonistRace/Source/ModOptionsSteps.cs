using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Xml.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps on the Mod options page of a mod (the Dialog_ModSettings of its settings handle), written 2026-10-28 for Seren Biotech Extended scenario 6
    /// (page of Mod Settings Framework, option SerenFaceSetVTE, restart-chain read-back). NOT PLAYED when written: the page is found the way the mod's own
    /// shortcut finds it (handle named after the mod); a value is read from the handle's settings by member name (diagnostic lists the members when none
    /// matches) and from the settings file on disk, which is what survives a restart.
    /// </summary>
    [PickleSteps]
    public class ModOptionsSteps
    {
        private const BindingFlags AnyMember = BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Instance;

        private static ModContentPack PackOf(PickleContext ctx, string packageId)
        {
            ModContentPack pack = LoadedModManager.RunningModsListForReading.Find(p => string.Equals(p.PackageIdPlayerFacing, packageId, StringComparison.OrdinalIgnoreCase));
            ctx.Require(pack != null, $"mod '{packageId}' is not running; running mods: " + string.Join(", ", LoadedModManager.RunningModsListForReading.Select(p => p.PackageIdPlayerFacing)));
            return pack;
        }

        private static Mod PageOf(ModContentPack pack)
        {
            foreach (Mod handle in LoadedModManager.ModHandles)
            {
                string category = handle.SettingsCategory();
                if (!string.IsNullOrEmpty(category) && category == pack.Name) return handle;
            }

            // The category is the mod's own text, not always its name ("Repossessed Furniture: contents"): the handle's content pack tells which mod it belongs to.
            foreach (Mod handle in LoadedModManager.ModHandles)
            {
                if (ReferenceEquals(handle.Content, pack) && !string.IsNullOrEmpty(handle.SettingsCategory())) return handle;
            }

            return null;
        }

        /// <summary>The page exists: a handle of the mod gives a non-empty entry in the Mod options list.</summary>
        [Then("Nelim's Pickle Tools: the mod options page of the mod {string} exists")]
        public void PageExists(PickleContext ctx, string packageId)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            ctx.Assert(PageOf(pack) != null, $"{pack.Name} has no entry in Mod options; the entries are " + string.Join(", ", LoadedModManager.ModHandles.Select(h => h.SettingsCategory()).Where(c => !string.IsNullOrEmpty(c))));
        }

        /// <summary>No page and no empty entry: no handle of the mod gives an entry, whatever the handle class.</summary>
        [Then("Nelim's Pickle Tools: the mod options page of the mod {string} does not exist")]
        public void PageAbsent(PickleContext ctx, string packageId)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Assert(handle == null, $"{pack.Name} has an entry in Mod options (handle {handle?.GetType().FullName}), none expected");
        }

        [When("Nelim's Pickle Tools: I open the mod options page of the mod {string}")]
        public void OpenPage(PickleContext ctx, string packageId)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            Find.WindowStack.Add(new Dialog_ModSettings(handle));
            ctx.Assert(Find.WindowStack.Windows.OfType<Dialog_ModSettings>().Any(), "the Mod options window did not open");
        }

        [When("Nelim's Pickle Tools: I close the mod options window")]
        public void ClosePage(PickleContext ctx)
        {
            Dialog_ModSettings window = Find.WindowStack.Windows.OfType<Dialog_ModSettings>().FirstOrDefault();
            ctx.Require(window != null, "no Mod options window is open");
            window.Close(true);
            ctx.Assert(!Find.WindowStack.Windows.OfType<Dialog_ModSettings>().Any(), "the Mod options window is still open");
        }

        /// <summary>Sets the member to the text, parsed as bool, int, float or string by the member's type, then writes the mod's settings to disk (what closing the window does).</summary>
        [When("Nelim's Pickle Tools: I set the option {string} of the mod {string} to {string}")]
        public void SetOption(PickleContext ctx, string option, string packageId, string value)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            if (IsMsf(handle)) { MsfSet(ctx, handle, pack, option, value); return; }
            object owner; MemberInfo member;
            ctx.Require(FindMember(handle, option, out owner, out member), $"no member '{option}' in the settings of {pack.Name}; members: " + Members(handle));
            Type t = member is FieldInfo f ? f.FieldType : ((PropertyInfo)member).PropertyType;
            object parsed = ParseValue(ctx, t, value, option);
            if (member is FieldInfo ff) ff.SetValue(owner, parsed); else ((PropertyInfo)member).SetValue(owner, parsed);
            handle.WriteSettings();
            LogWrite(handle, option, owner, member, parsed);
        }

        // Diagnostic (2026-11-07, BiB b7c4): which object got the value, whether it is the one WriteSettings saves (Mod.modSettings), and the file as it is on disk right after the write.
        private static void LogWrite(Mod handle, string option, object owner, MemberInfo member, object parsed)
        {
            try
            {
                object saved = typeof(Mod).GetField("modSettings", AnyMember)?.GetValue(handle);
                string path = SettingsPath(handle);
                Log.Message($"[mod-options] set {option}={parsed} on {owner?.GetType().FullName}#{System.Runtime.CompilerServices.RuntimeHelpers.GetHashCode(owner)} ({member?.DeclaringType?.Name}.{member?.Name}); saved settings {saved?.GetType().FullName}#{(saved == null ? 0 : System.Runtime.CompilerServices.RuntimeHelpers.GetHashCode(saved))}; same={ReferenceEquals(owner, saved)}; file {path} after write:\n" + (File.Exists(path) ? File.ReadAllText(path) : "(absent)"));
            }
            catch (Exception e) { Log.Warning("[mod-options] write diagnostic failed: " + e.Message); }
        }

        // bool, int, float, an enum (name, case ignored), else the text. Enum added 2026-11-06 for Biotech Bodies (globalBody Auto/Vanilla).
        private static object ParseValue(PickleContext ctx, Type t, string value, string what)
        {
            if (t == typeof(bool)) return bool.Parse(value);
            if (t == typeof(int)) return int.Parse(value);
            if (t == typeof(float)) return float.Parse(value, System.Globalization.CultureInfo.InvariantCulture);
            if (t.IsEnum)
            {
                ctx.Require(Enum.GetNames(t).Any(n => string.Equals(n, value, StringComparison.OrdinalIgnoreCase)), $"'{value}' is not a value of {t.Name} ({what}); values: " + string.Join(", ", Enum.GetNames(t)));
                return Enum.Parse(t, value, true);
            }

            return value;
        }

        /// <summary>
        /// Sets one entry of an option that is a dictionary with text keys (a <c>Dictionary&lt;string, T&gt;</c> field or property of the settings), the value parsed by T as for
        /// a plain option (bool, int, float, enum, text); adds the key when absent. Then writes the mod's settings (what closing the window does). Compiled, not played;
        /// asked for by BiB (raceBody keyed by race defName), 2026-11-06.
        /// </summary>
        [When("Nelim's Pickle Tools: I set the entry {string} of the option {string} of the mod {string} to {string}")]
        public void SetOptionEntry(PickleContext ctx, string key, string option, string packageId, string value)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            ctx.Require(!IsMsf(handle), $"{pack.Name} keeps its options in Mod Settings Framework: no dictionary options");
            object owner; MemberInfo member;
            ctx.Require(FindMember(handle, option, out owner, out member), $"no member '{option}' in the settings of {pack.Name}; members: " + Members(handle));
            object dict = member is FieldInfo f ? f.GetValue(owner) : ((PropertyInfo)member).GetValue(owner);
            ctx.Require(dict != null, $"'{option}' of {pack.Name} is null");
            Type dictType = dict.GetType();
            Type iface = dictType.GetInterfaces().Concat(new[] { dictType }).FirstOrDefault(i => i.IsGenericType && i.GetGenericTypeDefinition() == typeof(IDictionary<,>));
            ctx.Require(iface != null && iface.GetGenericArguments()[0] == typeof(string), $"'{option}' of {pack.Name} is a {dictType.Name}, not a dictionary with text keys");
            object parsed = ParseValue(ctx, iface.GetGenericArguments()[1], value, option);
            iface.GetProperty("Item").SetValue(dict, parsed, new object[] { key });
            Log.Message($"[mod-options] {option}[{key}] of {pack.Name} set to {parsed}");
            handle.WriteSettings();
            LogWrite(handle, option + "[" + key + "]", owner, member, parsed);
        }

        [Then("Nelim's Pickle Tools: the entry {string} of the option {string} of the mod {string} is {string}")]
        public void OptionEntryIs(PickleContext ctx, string key, string option, string packageId, string expected)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            object owner; MemberInfo member;
            ctx.Require(FindMember(handle, option, out owner, out member), $"no member '{option}' in the settings of {pack.Name}; members: " + Members(handle));
            object dict = member is FieldInfo f ? f.GetValue(owner) : ((PropertyInfo)member).GetValue(owner);
            var entries = (dict as System.Collections.IDictionary);
            ctx.Require(entries != null, $"'{option}' of {pack.Name} is not a dictionary");
            ctx.Require(entries.Contains(key), $"'{option}' of {pack.Name} has no entry '{key}'; keys: " + string.Join(", ", entries.Keys.Cast<object>()));
            string read = Convert.ToString(entries[key], System.Globalization.CultureInfo.InvariantCulture);
            ctx.Assert(string.Equals(read, expected, StringComparison.OrdinalIgnoreCase), $"entry '{key}' of option '{option}' of {pack.Name} is '{read}', not '{expected}'");
        }

        /// <summary>
        /// Adds a text entry to an option that is a set or list of text (a <c>HashSet&lt;string&gt;</c> of defNames, say), then writes the mod's settings (what
        /// closing the window does). Does nothing more when the entry is already there. Written 2026-11-10 for RepossessedFurniture. Compiled, NOT PLAYED.
        /// </summary>
        [When("Nelim's Pickle Tools: I add {string} to the set option {string} of the mod {string}")]
        public void AddToSetOption(PickleContext ctx, string entry, string option, string packageId)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ICollection<string> set = SetOption(ctx, pack, handle, option, out object owner, out MemberInfo member);
            set.Add(entry);
            Log.Message($"[mod-options] {entry} added to {option} of {pack.Name} ({set.Count} entries)");
            handle.WriteSettings();
            LogWrite(handle, option + "+" + entry, owner, member, entry);
        }

        /// <summary>The same, removing the entry (fails when it was not in the set, so a scenario cannot pass on a typo).</summary>
        [When("Nelim's Pickle Tools: I remove {string} from the set option {string} of the mod {string}")]
        public void RemoveFromSetOption(PickleContext ctx, string entry, string option, string packageId)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ICollection<string> set = SetOption(ctx, pack, handle, option, out object owner, out MemberInfo member);
            ctx.Require(set.Remove(entry), $"'{entry}' was not in the set option '{option}' of {pack.Name}; it holds: " + string.Join(", ", set.Take(40)));
            Log.Message($"[mod-options] {entry} removed from {option} of {pack.Name} ({set.Count} entries)");
            handle.WriteSettings();
            LogWrite(handle, option + "-" + entry, owner, member, entry);
        }

        private static ICollection<string> SetOption(PickleContext ctx, ModContentPack pack, Mod handle, string option, out object owner, out MemberInfo member)
        {
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            ctx.Require(!IsMsf(handle), $"{pack.Name} keeps its options in Mod Settings Framework: no set options");
            ctx.Require(FindMember(handle, option, out owner, out member), $"no member '{option}' in the settings of {pack.Name}; members: " + Members(handle));
            object value = member is FieldInfo f ? f.GetValue(owner) : ((PropertyInfo)member).GetValue(owner);
            ctx.Require(value != null, $"'{option}' of {pack.Name} is null");
            var set = value as ICollection<string>;
            ctx.Require(set != null, $"'{option}' of {pack.Name} is a {value.GetType().Name}, not a set or list of text");
            return set;
        }

        /// <summary>
        /// Reads the settings file on disk (the one a restart loads): the element named like the option must hold a <c>&lt;li&gt;</c> child with the entry text
        /// (case ignored). Written 2026-11-10 for RepossessedFurniture. Compiled, NOT PLAYED.
        /// </summary>
        [Then("Nelim's Pickle Tools: the settings file of the mod {string} lists {string} in the set option {string}")]
        public void FileListsInSet(PickleContext ctx, string packageId, string entry, string option)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            string path = SettingsPath(handle);
            ctx.Require(path != null && File.Exists(path), $"no settings file for {pack.Name} at '{path}'");
            XElement el = XDocument.Load(path).Descendants().FirstOrDefault(e => string.Equals(e.Name.LocalName, option, StringComparison.OrdinalIgnoreCase));
            ctx.Require(el != null, $"{path} holds no element '{option}'; its elements: " + string.Join(", ", XDocument.Load(path).Descendants().Select(e => e.Name.LocalName).Distinct()));
            var items = el.Elements("li").Select(e => e.Value).ToList();
            ctx.Assert(items.Contains(entry, StringComparer.OrdinalIgnoreCase), $"{path}: '{option}' does not list '{entry}'; it lists " + string.Join(", ", items.Take(40)));
        }

        [Then("Nelim's Pickle Tools: the option {string} of the mod {string} is {string}")]
        public void OptionIs(PickleContext ctx, string option, string packageId, string expected)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            if (IsMsf(handle))
            {
                string read = MsfRead(ctx, handle, pack, option);
                ctx.Assert(string.Equals(read, expected, StringComparison.OrdinalIgnoreCase), $"option '{option}' of {pack.Name} (Mod Settings Framework) is '{read}', not '{expected}'");
                return;
            }
            object owner; MemberInfo member;
            ctx.Require(FindMember(handle, option, out owner, out member), $"no member '{option}' in the settings of {pack.Name}; members: " + Members(handle));
            object v = member is FieldInfo f ? f.GetValue(owner) : ((PropertyInfo)member).GetValue(owner);
            ctx.Assert(string.Equals(Convert.ToString(v, System.Globalization.CultureInfo.InvariantCulture), expected, StringComparison.OrdinalIgnoreCase), $"option '{option}' of {pack.Name} is '{v}', not '{expected}'");
        }

        /// <summary>
        /// Reads the settings file on disk (Config/Mod_{id}_{handle class}.xml), the one a restart loads: the first element named like the option must hold the text.
        /// </summary>
        [Then("Nelim's Pickle Tools: the settings file of the mod {string} holds {string} as {string}")]
        public void FileHolds(PickleContext ctx, string packageId, string option, string expected)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            if (IsMsf(handle)) { MsfFileHolds(ctx, pack, option, expected); return; }
            string path = SettingsPath(handle);
            ctx.Require(path != null && File.Exists(path), $"no settings file for {pack.Name} at '{path}'");
            XElement el = XDocument.Load(path).Descendants().FirstOrDefault(e => string.Equals(e.Name.LocalName, option, StringComparison.OrdinalIgnoreCase));
            if (el == null && DefaultIs(handle, option, expected))
            {
                Log.Message($"[mod-options] {path} holds no '{option}': Scribe skips a value equal to its code default, and the default is '{expected}'; accepted");
                return;
            }
            ctx.Require(el != null, $"{path} holds no element '{option}'; its elements: " + string.Join(", ", XDocument.Load(path).Descendants().Select(e => e.Name.LocalName)) + "; content:\n" + File.ReadAllText(path));
            ctx.Assert(string.Equals(el.Value, expected, StringComparison.OrdinalIgnoreCase), $"{path}: '{option}' is '{el.Value}', not '{expected}'");
        }

        // Scribe_Values.Look writes nothing when the value equals its default: an absent element means "default". True when a fresh settings object of the mod's type holds the expected text for the option.
        private static bool DefaultIs(Mod handle, string option, string expected)
        {
            try
            {
                object current = typeof(Mod).GetField("modSettings", AnyMember)?.GetValue(handle);
                if (current == null) return false;
                object fresh = Activator.CreateInstance(current.GetType(), true);
                object owner; MemberInfo member;
                if (!FindMember(fresh, option, out owner, out member) || member == null) return false;
                object v = member is FieldInfo f ? f.GetValue(owner) : ((PropertyInfo)member).GetValue(owner);
                return string.Equals(Convert.ToString(v, System.Globalization.CultureInfo.InvariantCulture), expected, StringComparison.OrdinalIgnoreCase);
            }
            catch { return false; }
        }

        // ---- Sandbox: the mod's settings file is backed up, removed and the settings reset to the code defaults; an [AfterScenario] puts the file back.
        // The backup sits next to the file (.pickle-sandbox-bak, "absent" marker when there was no file), so a run killed mid-scenario is repaired by the next sandbox step.
        private const string BackupSuffix = ".pickle-sandbox-bak";
        private const string AbsentSuffix = ".pickle-sandbox-absent";
        private static readonly List<Mod> Sandboxed = new List<Mod>();

        // GetSettingsFilename is not public in every game version: look at non-public statics too, else build the name the game builds.
        private static string SettingsPath(Mod handle)
        {
            MethodInfo method = typeof(LoadedModManager).GetMethod("GetSettingsFilename", BindingFlags.Public | BindingFlags.NonPublic | BindingFlags.Static, null, new[] { typeof(string), typeof(string) }, null);
            if (method != null) return (string)method.Invoke(null, new object[] { handle.Content.FolderName, handle.GetType().Name });
            return Path.Combine(GenFilePaths.ConfigFolderPath, GenText.SanitizeFilename($"Mod_{handle.Content.FolderName}_{handle.GetType().Name}.xml"));
        }

        // Forgets the settings object so the next GetSettings reads the file again (the default instance when there is none), as a restart does.
        private static void Reload(Mod handle)
        {
            FieldInfo field = typeof(Mod).GetField("modSettings", AnyMember);
            if (field == null) throw new InvalidOperationException("Verse.Mod has no field 'modSettings' in this game version");
            ModSettings current = (ModSettings)field.GetValue(handle);
            if (current == null) throw new InvalidOperationException($"{handle.Content.Name} has no settings object; it declares no settings");
            Type type = current.GetType();
            field.SetValue(handle, null);
            object fresh = typeof(Mod).GetMethod("GetSettings", AnyMember | BindingFlags.Public).MakeGenericMethod(type).Invoke(handle, null);
            // A mod keeps the object GetSettings returned in its own field (RimScent Extended: static Settings): point it at the new one, else the page edits an orphan and WriteSettings saves defaults.
            foreach (FieldInfo own in handle.GetType().GetFields(AnyMember | BindingFlags.Static | BindingFlags.FlattenHierarchy).Where(x => x.FieldType.IsAssignableFrom(type)))
                if (ReferenceEquals(own.GetValue(own.IsStatic ? null : handle), current)) own.SetValue(own.IsStatic ? null : handle, fresh);
        }

        private static void RestoreFile(string path)
        {
            string bak = path + BackupSuffix, absent = path + AbsentSuffix;
            if (File.Exists(bak)) { File.Copy(bak, path, true); File.Delete(bak); }
            else if (File.Exists(absent)) { if (File.Exists(path)) File.Delete(path); }
            if (File.Exists(absent)) File.Delete(absent);
        }

        /// <summary>Backs up the settings file of the mod, deletes it and resets its settings to the defaults of its code; the file is restored after the scenario.</summary>
        [Given("Nelim's Pickle Tools: the settings of the mod {string} are sandboxed at their defaults")]
        public void SandboxDefaults(PickleContext ctx, string packageId)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            ctx.Require(!IsMsf(handle), $"{pack.Name} keeps its options in Mod Settings Framework: its file is shared with other mods, not sandboxed");
            string path = SettingsPath(handle);
            ctx.Require(path != null, $"no settings file name for {pack.Name}");
            if (File.Exists(path + BackupSuffix) || File.Exists(path + AbsentSuffix)) RestoreFile(path);
            if (File.Exists(path)) File.Copy(path, path + BackupSuffix, true);
            else File.WriteAllText(path + AbsentSuffix, "no settings file before the sandbox");
            if (File.Exists(path)) File.Delete(path);
            Reload(handle);
            if (!Sandboxed.Contains(handle)) Sandboxed.Add(handle);
        }

        /// <summary>Drops the settings in memory and reads the file again, what a restart does.</summary>
        [When("Nelim's Pickle Tools: the settings of the mod {string} are re-read from the file")]
        public void Reread(PickleContext ctx, string packageId)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
            string path = SettingsPath(handle);
            ctx.Require(path != null && File.Exists(path), $"no settings file for {pack.Name} at '{path}'; a value must be written before it is re-read");
            Reload(handle);
        }

        [AfterScenario]
        public void RestoreSandboxes()
        {
            foreach (Mod handle in Sandboxed)
            {
                string path = SettingsPath(handle);
                if (path == null) continue;
                RestoreFile(path);
                try { Reload(handle); } catch (Exception e) { Log.Warning("[mod-options] sandbox restore of " + handle.Content.Name + ": " + e.Message); }
            }
            Sandboxed.Clear();
        }

        // ---- Mod Settings Framework (bundled in Vanilla Expanded Framework): its options are not members of the handle's settings. Read by reflection, no reference to it.
        // The handle is a ModSettingsFramework.ModSettingsFrameworkMod (field modPackOverride = the mod the page belongs to); the values live in the container
        // ModSettingsFrameworkSettings.GetModSettingsContainer(packageId): patchOperationStates (id -> bool, checkboxes) and patchOperationValues (id -> float, sliders).
        // An option never touched is absent there and reads as the defaultValue of its patch operation. The file is Config/ModSettingsFrameworkMod_Settings.xml.
        private static bool IsMsf(Mod handle) => handle.GetType().FullName == "ModSettingsFramework.ModSettingsFrameworkMod";

        private static ModContentPack MsfTarget(Mod handle, ModContentPack pack) => handle.GetType().GetField("modPackOverride", AnyMember)?.GetValue(handle) as ModContentPack ?? pack;

        private static object MsfContainer(PickleContext ctx, Mod handle, ModContentPack pack)
        {
            ModContentPack target = MsfTarget(handle, pack);
            Type settings = handle.GetType().Assembly.GetType("ModSettingsFramework.ModSettingsFrameworkSettings");
            ctx.Require(settings != null, "ModSettingsFramework.ModSettingsFrameworkSettings not found in the assembly of the handle");
            object container = settings.GetMethod("GetModSettingsContainer", BindingFlags.Public | BindingFlags.Static, null, new[] { typeof(string) }, null)?.Invoke(null, new object[] { target.PackageIdPlayerFacing });
            ctx.Require(container != null, $"Mod Settings Framework has no settings container for {target.PackageIdPlayerFacing}");
            return container;
        }

        // The patch operation of the mod whose id is the option (null when none), and the ids of every patch operation of the mod that has one.
        private static object MsfPatch(Mod handle, ModContentPack pack, string option, out List<string> ids)
        {
            ids = new List<string>();
            object found = null;
            foreach (var patch in MsfTarget(handle, pack).Patches)
            {
                string id = patch.GetType().GetField("id", AnyMember)?.GetValue(patch) as string;
                if (id == null) continue;
                ids.Add(id);
                if (id == option) found = patch;
            }
            return found;
        }

        private static string MsfRead(PickleContext ctx, Mod handle, ModContentPack pack, string option)
        {
            object container = MsfContainer(ctx, handle, pack);
            var states = (IDictionary<string, bool>)container.GetType().GetField("patchOperationStates").GetValue(container);
            var values = (IDictionary<string, float>)container.GetType().GetField("patchOperationValues").GetValue(container);
            if (states.TryGetValue(option, out bool state)) return state ? "True" : "False";
            if (values.TryGetValue(option, out float number)) return number.ToString(System.Globalization.CultureInfo.InvariantCulture);
            object patch = MsfPatch(handle, pack, option, out List<string> ids);
            ctx.Require(patch != null, $"no option '{option}' of Mod Settings Framework in {pack.Name}; the options of its patches: " + string.Join(", ", ids) + "; stored: " + string.Join(", ", states.Keys.Concat(values.Keys)));
            object def = patch.GetType().GetField("defaultValue", AnyMember)?.GetValue(patch);
            Log.Message($"[mod-options] {option} of {pack.Name} was never set: reads the default {def}");
            return def is bool b ? (b ? "True" : "False") : Convert.ToString(def, System.Globalization.CultureInfo.InvariantCulture);
        }

        private static void MsfSet(PickleContext ctx, Mod handle, ModContentPack pack, string option, string value)
        {
            object container = MsfContainer(ctx, handle, pack);
            MsfPatch(handle, pack, option, out List<string> ids);
            ctx.Require(ids.Contains(option), $"no option '{option}' of Mod Settings Framework in {pack.Name}; the options of its patches: " + string.Join(", ", ids));
            var states = (IDictionary<string, bool>)container.GetType().GetField("patchOperationStates").GetValue(container);
            var values = (IDictionary<string, float>)container.GetType().GetField("patchOperationValues").GetValue(container);
            bool isBool = bool.TryParse(value, out bool state);
            if (isBool) states[option] = state;
            else
            {
                ctx.Require(float.TryParse(value, System.Globalization.NumberStyles.Float, System.Globalization.CultureInfo.InvariantCulture, out float number), $"'{value}' is neither true, false nor a number");
                values[option] = number;
            }
            handle.WriteSettings();
            string read = MsfRead(ctx, handle, pack, option);
            ctx.Assert(string.Equals(read, isBool ? (state ? "True" : "False") : value, StringComparison.OrdinalIgnoreCase), $"option '{option}' reads '{read}' after the step, not '{value}'");
        }

        // The file keeps one container per mod: modSettingsPerModId/{keys,values}/li; a container holds packageID and the dictionaries patchOperationStates and patchOperationValues as {keys,values}/li.
        private static void MsfFileHolds(PickleContext ctx, ModContentPack pack, string option, string expected)
        {
            string path = Path.Combine(GenFilePaths.ConfigFolderPath, "ModSettingsFrameworkMod_Settings.xml");
            ctx.Require(File.Exists(path), $"no Mod Settings Framework settings file at '{path}' (it is written when a setting is changed and saved)");
            XDocument doc = XDocument.Load(path);
            XElement container = doc.Descendants("packageID").Where(e => string.Equals(e.Value, pack.PackageIdPlayerFacing, StringComparison.OrdinalIgnoreCase)).Select(e => e.Parent).FirstOrDefault();
            ctx.Require(container != null, $"{path} holds no container for {pack.PackageIdPlayerFacing}; its packageIDs: " + string.Join(", ", doc.Descendants("packageID").Select(e => e.Value)));
            foreach (string dictName in new[] { "patchOperationStates", "patchOperationValues" })
            {
                XElement dict = container.Element(dictName);
                if (dict == null) continue;
                var keys = dict.Element("keys")?.Elements("li").Select(e => e.Value).ToList() ?? new List<string>();
                var vals = dict.Element("values")?.Elements("li").Select(e => e.Value).ToList() ?? new List<string>();
                int i = keys.IndexOf(option);
                if (i < 0 || i >= vals.Count) continue;
                ctx.Assert(string.Equals(vals[i], expected, StringComparison.OrdinalIgnoreCase), $"{path}: '{option}' is '{vals[i]}', not '{expected}'");
                return;
            }
            ctx.Require(false, $"{path} holds no value for '{option}' (an option never changed from its default is not written); the leaf values of the container: " + string.Join(", ", container.Descendants("li").Where(e => !e.HasElements).Select(e => e.Value).Take(40)));
        }

        private static bool FindMember(object root, string name, out object owner, out MemberInfo member)
        {
            var seen = new HashSet<object>();
            return Walk(root, name, 0, seen, out owner, out member);
        }

        private static bool Walk(object o, string name, int depth, HashSet<object> seen, out object owner, out MemberInfo member)
        {
            owner = null; member = null;
            if (o == null || depth > 3 || !seen.Add(o)) return false;
            foreach (MemberInfo m in o.GetType().GetMembers(AnyMember | BindingFlags.Static).Where(m => m is FieldInfo || (m is PropertyInfo p && p.GetIndexParameters().Length == 0 && p.CanRead && p.CanWrite)))
            {
                if (string.Equals(m.Name, name, StringComparison.OrdinalIgnoreCase)) { owner = o; member = m; return true; }
            }
            // GetMembers hides the private fields of base classes: the settings object GetSettings<T>() keeps in Mod.modSettings is read directly; a mod's own static settings field is read at the root.
            var children = new List<MemberInfo>(o.GetType().GetMembers(depth == 0 ? AnyMember | BindingFlags.Static : AnyMember).Where(m => m is FieldInfo || (m is PropertyInfo p && p.GetIndexParameters().Length == 0 && p.CanRead)));
            if (o is Mod) { FieldInfo stored = typeof(Mod).GetField("modSettings", AnyMember); if (stored != null) children.Add(stored); }
            foreach (MemberInfo m in children)
            {
                Type t = m is FieldInfo f ? f.FieldType : ((PropertyInfo)m).PropertyType;
                if (t.IsPrimitive || t == typeof(string) || t.IsEnum || t.Namespace?.StartsWith("UnityEngine") == true || typeof(Mod).IsAssignableFrom(t) == false && t.Namespace?.StartsWith("System") == true && !typeof(System.Collections.IDictionary).IsAssignableFrom(t)) continue;
                object child;
                try { child = m is FieldInfo ff ? ff.GetValue(o) : ((PropertyInfo)m).GetValue(o); } catch { continue; }
                if (child is System.Collections.IDictionary d)
                {
                    foreach (object key in d.Keys)
                        if (string.Equals(Convert.ToString(key), name, StringComparison.OrdinalIgnoreCase)) { owner = d; member = null; return false; }
                    continue;
                }
                if (Walk(child, name, depth + 1, seen, out owner, out member)) return true;
            }
            return false;
        }

        private static string Members(object root)
        {
            var names = new List<string>();
            foreach (MemberInfo m in root.GetType().GetMembers(AnyMember | BindingFlags.Static).Where(m => m is FieldInfo || m is PropertyInfo))
                names.Add(m.DeclaringType.Name + "." + m.Name);
            return string.Join(", ", names);
        }
    }
}
