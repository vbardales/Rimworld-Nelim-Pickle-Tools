using System;
using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using RimWorld.Planet;
using Verse;
using HarmonyLib;
using Verse.Grammar;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Steps for a culture (Ideology's CultureDef) and the names it gives. Written 2026-11-11 at the request of RisingSunCulture (one CultureDef whose pawnNameMaker rule packs hold the word
    /// lists of first and family names). NOT PLAYED when written: compiled against the reference assemblies only.
    /// </summary>
    [PickleSteps]
    public class CultureSteps
    {
        /// <summary>
        /// Generates a number of names with the name maker of a culture (a CultureDef by defName: its <c>pawnNameMaker</c>, or <c>pawnNameMakerFemale</c> for <c>female</c> when it has one) and asserts
        /// that each name is a first part and a family part, the first part found in the word list <c>first</c> and the rest in the word list <c>family</c>: a word list is the set of
        /// plain text rules of the rule pack and of the packs it includes under that keyword, and the lines of a rulesFiles entry (`keyword->Names/File`, one name per line in the active language) (a rule <c>r_firstname-&gt;Aiko</c> belongs to the list <c>r_firstname</c>), compared ignoring case. The name is the game's own
        /// output for the pack (<c>NameGenerator.GenerateName</c>), one word for the first part and the remaining words for the family part. Fails with the names that do not match and the
        /// keywords the pack holds. Needs Ideology (cultures). Does not create pawns. NOT PLAYED when written.
        /// </summary>
        /// <param name="count">how many names to generate</param>
        /// <param name="cultureName">a CultureDef defName</param>
        /// <param name="gender"><c>male</c>, <c>female</c> or <c>any</c> (the plain name maker)</param>
        /// <param name="firstList">the keyword of the word list of first names</param>
        /// <param name="familyList">the keyword of the word list of family names</param>
        [Then("Nelim's Pickle Tools: {int} {word} names of the culture {string} come from the word lists {string} and {string}")]
        public void NamesComeFromLists(PickleContext ctx, int count, string gender, string cultureName, string firstList, string familyList)
        {
            ctx.Require(count >= 1 && count <= 500, $"the count is 1 to 500, not {count}");
            ctx.Require(gender == "male" || gender == "female" || gender == "any", $"the gender is male, female or any, not '{gender}'");
            CultureDef culture = RequireCulture(ctx, cultureName);
            RulePackDef pack = gender == "female" && culture.pawnNameMakerFemale != null ? culture.pawnNameMakerFemale : culture.pawnNameMaker;
            ctx.Require(pack != null, $"the culture {cultureName} has no pawnNameMaker rule pack");
            List<Rule> rules = pack.RulesPlusIncludes;
            HashSet<string> first = WordList(rules, firstList);
            HashSet<string> family = WordList(rules, familyList);
            ctx.Require(first.Count > 0, $"the rule pack {pack.defName} has no plain text rule under the keyword '{firstList}'; it holds the keywords: {string.Join(", ", Keywords(rules))}");
            ctx.Require(family.Count > 0, $"the rule pack {pack.defName} has no plain text rule under the keyword '{familyList}'; it holds the keywords: {string.Join(", ", Keywords(rules))}");

            var bad = new List<string>();
            for (int i = 0; i < count; i++)
            {
                string name = NameGenerator.GenerateName(pack, null, false, null, null);
                string[] words = (name ?? "").Split(new[] { ' ' }, StringSplitOptions.RemoveEmptyEntries);
                bool ok = words.Length >= 2 && first.Contains(words[0]) && family.Contains(string.Join(" ", words.Skip(1)));
                if (!ok) bad.Add("'" + name + "'");
            }

            ctx.Assert(bad.Count == 0, $"{bad.Count} of {count} names of the culture {cultureName} are not a '{firstList}' word then a '{familyList}' word: {string.Join(", ", bad.Distinct().Take(10))} (first list {first.Count} words, family list {family.Count} words)");
        }

        /// <summary>
        /// Asserts the culture of a colonist (the culture of its ideoligion, <c>pawn.Ideo.culture</c>) is a CultureDef by defName. Fails with the culture it has, or says there is no ideoligion (the
        /// Ideology DLC off, or a pawn without one). NOT PLAYED when written.
        /// </summary>
        [Then("Nelim's Pickle Tools: {string} belongs to the culture {string}")]
        public void BelongsToCulture(PickleContext ctx, string nickname, string cultureName)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            RequireCulture(ctx, cultureName);
            ctx.Require(ModsConfig.IdeologyActive, "cultures need the Ideology DLC, and it is not active in this run");
            Ideo ideo = pawn.Ideo;
            ctx.Require(ideo != null, $"{nickname} has no ideoligion, so no culture");
            ctx.Assert(ideo.culture != null && ideo.culture.defName == cultureName, $"{nickname}'s culture is {ideo.culture?.defName ?? "none"}, not {cultureName}");
        }

        /// <summary>Asserts a CultureDef of that defName is loaded (the mod that defines it is in the pass); the failure lists the cultures the game has.</summary>
        [Then("Nelim's Pickle Tools: the culture {string} is loaded")]
        public void CultureLoaded(PickleContext ctx, string cultureName)
        {
            RequireCulture(ctx, cultureName);
        }

        private static CultureDef RequireCulture(PickleContext ctx, string cultureName)
        {
            CultureDef culture = DefDatabase<CultureDef>.GetNamedSilentFail(cultureName);
            ctx.Require(culture != null, $"no CultureDef '{cultureName}' (is the mod that defines it loaded, and Ideology active?); the cultures are: {string.Join(", ", DefDatabase<CultureDef>.AllDefsListForReading.Select(c => c.defName))}");
            return culture;
        }

        private static HashSet<string> WordList(List<Rule> rules, string keyword)
        {
            var set = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
            foreach (Rule rule in rules.Where(r => string.Equals(r.keyword, keyword, StringComparison.OrdinalIgnoreCase)))
            {
                if (rule is Rule_String)
                {
                    string text = rule.Generate();
                    if (!string.IsNullOrEmpty(text)) set.Add(text);
                }
                else if (rule is Rule_File file)
                {
                    // A rulesFiles entry (keyword->Names/File): one entry per line of the file in the active language, as the game reads it.
                    foreach (string line in FileLines(file)) if (!string.IsNullOrWhiteSpace(line)) set.Add(line.Trim());
                }
            }

            return set;
        }

        private static IEnumerable<string> FileLines(Rule_File file)
        {
            string path = Traverse.Create(file).Field("path").GetValue<string>();
            var lines = new List<string>();
            // The language's own reader of a strings file, found by name: it is not in the reference assembly under one fixed name in every version.
            System.Reflection.MethodInfo reader = typeof(LoadedLanguage).GetMethods(System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic)
                .FirstOrDefault(m => m.Name.IndexOf("StringsFromFile", StringComparison.OrdinalIgnoreCase) >= 0 && m.GetParameters().Length == 1 && m.GetParameters()[0].ParameterType == typeof(string));
            if (path != null && reader != null && reader.Invoke(LanguageDatabase.activeLanguage, new object[] { path }) is IEnumerable<string> read) lines.AddRange(read);
            if (lines.Count == 0)
            {
                // The game keeps the lines it read in a list of the rule; take it when the path gave none (a fallback language).
                foreach (var field in typeof(Rule_File).GetFields(System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Public))
                    if (field.FieldType == typeof(List<string>) && field.GetValue(file) is List<string> held) lines.AddRange(held);
            }

            return lines;
        }

        private static IEnumerable<string> Keywords(List<Rule> rules)
        {
            return rules.Select(r => r.keyword).Distinct();
        }
    }
}
