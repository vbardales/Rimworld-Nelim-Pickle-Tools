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
            object owner; MemberInfo member;
            ctx.Require(FindMember(handle, option, out owner, out member), $"no member '{option}' in the settings of {pack.Name}; members: " + Members(handle));
            Type t = member is FieldInfo f ? f.FieldType : ((PropertyInfo)member).PropertyType;
            object parsed = t == typeof(bool) ? (object)bool.Parse(value) : t == typeof(int) ? int.Parse(value) : t == typeof(float) ? float.Parse(value, System.Globalization.CultureInfo.InvariantCulture) : value;
            if (member is FieldInfo ff) ff.SetValue(owner, parsed); else ((PropertyInfo)member).SetValue(owner, parsed);
            handle.WriteSettings();
        }

        [Then("Nelim's Pickle Tools: the option {string} of the mod {string} is {string}")]
        public void OptionIs(PickleContext ctx, string option, string packageId, string expected)
        {
            ModContentPack pack = PackOf(ctx, packageId);
            Mod handle = PageOf(pack);
            ctx.Require(handle != null, $"{pack.Name} has no entry in Mod options");
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
            string path = (string)typeof(LoadedModManager).GetMethod("GetSettingsFilename", BindingFlags.Public | BindingFlags.Static)?.Invoke(null, new object[] { handle.Content.FolderName, handle.GetType().Name });
            ctx.Require(path != null && File.Exists(path), $"no settings file for {pack.Name} at '{path}'");
            XElement el = XDocument.Load(path).Descendants().FirstOrDefault(e => string.Equals(e.Name.LocalName, option, StringComparison.OrdinalIgnoreCase));
            ctx.Require(el != null, $"{path} holds no element '{option}'; its elements: " + string.Join(", ", XDocument.Load(path).Descendants().Select(e => e.Name.LocalName)));
            ctx.Assert(string.Equals(el.Value, expected, StringComparison.OrdinalIgnoreCase), $"{path}: '{option}' is '{el.Value}', not '{expected}'");
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
            foreach (MemberInfo m in o.GetType().GetMembers(AnyMember).Where(m => m is FieldInfo || (m is PropertyInfo p && p.GetIndexParameters().Length == 0 && p.CanRead && p.CanWrite)))
            {
                if (string.Equals(m.Name, name, StringComparison.OrdinalIgnoreCase)) { owner = o; member = m; return true; }
            }
            foreach (MemberInfo m in o.GetType().GetMembers(AnyMember).Where(m => m is FieldInfo || (m is PropertyInfo p && p.GetIndexParameters().Length == 0 && p.CanRead)))
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
            foreach (MemberInfo m in root.GetType().GetMembers(AnyMember).Where(m => m is FieldInfo || m is PropertyInfo))
                names.Add(m.DeclaringType.Name + "." + m.Name);
            return string.Join(", ", names);
        }
    }
}
