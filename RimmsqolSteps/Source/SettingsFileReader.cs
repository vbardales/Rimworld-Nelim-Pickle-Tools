using System;
using System.Linq;
using System.Text;
using System.Xml.Linq;

namespace Nelim.PickleShared.Rimmsqol
{
    /// <summary>
    /// Reads what RIMMSQOL wrote about one main button out of its settings file. Pure BCL, so it can be
    /// exercised offline against hand-made XML (Check-Reader.ps1).
    ///
    /// The layout was NOT seen in a game when this was written. It is derived from RIMMSqol's code:
    /// <c>Scribe_Collections.Look&lt;SettingsInstance&gt;(ref list, "mainButtons")</c> writes one <c>li</c> per
    /// active instance, and <c>SettingsInstance.ExposeData</c> writes <c>id</c>, <c>isConfigured</c> (a string
    /// "field;t;field;f;..."), <c>baseObjectKey</c>, <c>baseObjectReferenceKey</c>, then each CONFIGURED field
    /// under its own id, with <c>Scribe_Values.Look(ref value, id, default, false)</c>, which leaves a value
    /// out when it equals the default. So the search does not assume where the list sits: the entry is
    /// the element that has a <c>baseObjectKey</c> child equal to the defName, under an element named
    /// "mainButtons"; a missing <c>Visible</c> node with <c>Visible;t;</c> in <c>isConfigured</c> means a
    /// configured false. The raw entry is returned in the detail so the first real run shows the truth.
    /// </summary>
    public static class SettingsFileReader
    {
        private const string PropsId = "mainButtons";
        private const string VisibleField = "Visible";

        public static Recorded Read(string xml, string defName, out string detail)
        {
            XDocument doc;
            try { doc = XDocument.Parse(xml); }
            catch (Exception ex) { detail = "the settings file does not parse: " + ex.Message; return Recorded.NoChoice; }
            return Read(doc, defName, out detail);
        }

        public static Recorded Read(XDocument doc, string defName, out string detail)
        {
            var entry = doc.Descendants("baseObjectKey")
                .Where(k => string.Equals(k.Value == null ? null : k.Value.Trim(), defName, StringComparison.Ordinal))
                .Select(k => k.Parent)
                .FirstOrDefault(p => p != null && p.Ancestors().Any(a => a.Name.LocalName == PropsId));
            if (entry == null)
            {
                detail = $"the settings file has no mainButtons entry for '{defName}'";
                return Recorded.NoChoice;
            }

            var raw = Compact(entry.ToString());
            var configured = entry.Element("isConfigured") == null ? null : entry.Element("isConfigured").Value;
            // No isConfigured node means the instance predates per-field status: every field counts.
            if (configured != null && configured.IndexOf(VisibleField + ";t;", StringComparison.Ordinal) < 0)
            {
                detail = $"the entry for '{defName}' does not record a Visible choice: {raw}";
                return Recorded.NoChoice;
            }

            var node = entry.Element(VisibleField);
            var visible = node != null && string.Equals(node.Value.Trim(), "True", StringComparison.OrdinalIgnoreCase);
            detail = $"the entry for '{defName}' reads {(visible ? "visible" : "hidden")}: {raw}";
            return visible ? Recorded.Visible : Recorded.Hidden;
        }

        private static string Compact(string xml)
        {
            var sb = new StringBuilder();
            // Split(new[] { '\n' }), not Split('\n'): the char overload compiles against the game's
            // reference assemblies but is not on .NET Framework, where Check-Reader.ps1 runs.
            foreach (var line in xml.Split(new[] { '\n' })) sb.Append(line.Trim());
            return sb.Length > 600 ? sb.ToString(0, 600) + "..." : sb.ToString();
        }
    }
}
