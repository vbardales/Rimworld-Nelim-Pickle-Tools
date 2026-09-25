using System.Linq;
using Nelim.PickleTools.LoadAudit;
using Xunit;

namespace Nelim.PickleTools.LoadAudit.Tests
{
    public class LoadLogTests
    {
        private const string Color = "<color=#B2B2B2>";
        private const string End = "</color>";

        private static string Line(string level, string source, string message)
        {
            return $"{Color}[2026-09-25 15:27:37.769] [{level}] [{source}] {End}{message}";
        }

        private static ModProfile Mod()
        {
            var mod = new ModProfile { PackageId = "nelim.example" };
            mod.TypeNames.Add("Nelim.Example.Worker");
            mod.TypeNames.Add("Nelim.Example.Worker+<Run>d__3");
            mod.AssemblyNames.Add("Nelim.Example");
            mod.DefNames.Add("NelimExampleThing");
            return mod;
        }

        [Fact]
        public void ReadsTheHeadOfAMessageAndTheFramesThatFollowIt()
        {
            var entries = LoadLog.Parse(new[]
            {
                "Total: 345.706345 ms (FindLiveObjects: 3.591779 ms)",
                "",
                Line("ERROR", "Vanilla", "Failed to find any textures at Things/X"),
                "at Verse.Graphic_Multi.Init",
                "at Verse.GraphicDatabase.Get",
                "(Filename: ./Runtime/Export/Debug/Debug.bindings.h Line: 39)",
                Line("INFO", "Mod.nelim.example", "Loaded"),
            });

            Assert.Equal(2, entries.Count);
            Assert.Equal("ERROR", entries[0].Level);
            Assert.Equal("Vanilla", entries[0].Source);
            Assert.Equal(3, entries[0].Line);
            Assert.Equal(new[] { "Verse.Graphic_Multi.Init", "Verse.GraphicDatabase.Get" }, entries[0].Frames.ToArray());
            Assert.Equal("Mod.nelim.example", entries[1].Source);
        }

        [Fact]
        public void ACleanLogGivesNoFinding()
        {
            var entries = LoadLog.Parse(new[]
            {
                Line("INFO", "Mod.nelim.example", "Loaded"),
                Line("WARN", "Vanilla", "A hidden ritual precept was missing, adding: Funeral (no corpse)"),
                Line("ERROR", "Vanilla", "Failed to find any textures at Things/X"),
                "at Verse.Graphic_Multi.Init",
            });

            Assert.Empty(LoadLog.Audit(entries, Mod()));
        }

        [Fact]
        public void AnErrorTheGameTaggedToTheModIsAFindingAndItsInfoIsNot()
        {
            var entries = LoadLog.Parse(new[]
            {
                Line("INFO", "Mod.nelim.example", "Loaded"),
                Line("ERROR", "Mod.nelim.example", "Could not patch Foo"),
                Line("WARN", "Mod.NELIM.EXAMPLE", "Odd value"),
            });

            var findings = LoadLog.Audit(entries, Mod());
            Assert.Equal(new[] { "error", "warning" }, findings.Select(f => f.Kind).ToArray());
            Assert.Equal(2, findings[0].Line);
        }

        [Fact]
        public void AnExceptionWhoseStackHoldsATypeOfTheModIsAFindingWhateverItsTag()
        {
            var entries = LoadLog.Parse(new[]
            {
                Line("ERROR", "Vanilla", "Exception ticking Thing: System.NullReferenceException"),
                "at Verse.Thing.Tick",
                "at Nelim.Example.Worker.DoStuff (Verse.Pawn p) [0x00001] in <abc>:0",
            });

            var findings = LoadLog.Audit(entries, Mod());
            Assert.Single(findings);
            Assert.Contains("Nelim.Example.Worker", findings[0].Text);
        }

        [Fact]
        public void ACompilerGeneratedTypeOfTheModIsFoundByItsFullName()
        {
            var entries = LoadLog.Parse(new[]
            {
                Line("ERROR", "Vanilla", "Exception"),
                "at Nelim.Example.Worker+<Run>d__3.MoveNext",
            });

            Assert.Single(LoadLog.Audit(entries, Mod()));
        }

        [Fact]
        public void AFrameOfAnotherModWithACommonPrefixIsNotTheMods()
        {
            var entries = LoadLog.Parse(new[]
            {
                Line("ERROR", "Vanilla", "Exception"),
                "at Nelim.ExampleOther.Worker.DoStuff",
            });

            Assert.Empty(LoadLog.Audit(entries, Mod()));
        }

        [Fact]
        public void AnUnresolvedReferenceIsAFindingWhenADefOfTheModIsInIt()
        {
            var entries = LoadLog.Parse(new[]
            {
                Line("ERROR", "Vanilla", "Could not resolve cross-reference: No Verse.ThingDef named Missing found to give to RimWorld.CompProperties NelimExampleThing"),
                Line("ERROR", "Vanilla", "Could not resolve cross-reference: No Verse.ThingDef named Missing found to give to RimWorld.CompProperties SomeoneElsesThing"),
                Line("ERROR", "Vanilla", "Config error in NelimExampleThing: no label"),
            });

            var findings = LoadLog.Audit(entries, Mod());
            Assert.Equal(new[] { "definition", "definition" }, findings.Select(f => f.Kind).ToArray());
            Assert.Equal(new[] { 1, 3 }, findings.Select(f => f.Line).ToArray());
        }

        [Fact]
        public void ADefNameInAnOrdinaryMessageIsNotEnoughToBelongToTheMod()
        {
            var entries = LoadLog.Parse(new[]
            {
                Line("ERROR", "Vanilla", "Something failed for NelimExampleThing"),
            });

            Assert.Empty(LoadLog.Audit(entries, Mod()));
        }

        [Fact]
        public void TheSameMessageOfTheModFiveTimesIsRepeatedEvenWhenItsNumbersChange()
        {
            var lines = Enumerable.Range(1, LoadLog.RepeatThreshold)
                .Select(i => Line("INFO", "Mod.nelim.example", $"Refreshed pawn {i} in 0.{i} ms"))
                .ToList();
            var findings = LoadLog.Audit(LoadLog.Parse(lines), Mod());

            Assert.Single(findings);
            Assert.Equal("repeated", findings[0].Kind);
            Assert.StartsWith(LoadLog.RepeatThreshold + " times", findings[0].Text);
        }

        [Fact]
        public void OneLessThanTheThresholdIsNotRepeated()
        {
            var lines = Enumerable.Range(1, LoadLog.RepeatThreshold - 1)
                .Select(i => Line("INFO", "Mod.nelim.example", "Refreshed"));
            Assert.Empty(LoadLog.Audit(LoadLog.Parse(lines), Mod()));
        }

        [Fact]
        public void TheSameMessageOfVanillaIsNotCountedAgainstTheMod()
        {
            var lines = Enumerable.Range(1, 20).Select(i => Line("WARN", "Vanilla", "A hidden ritual precept was missing, adding: Funeral (no corpse)"));
            Assert.Empty(LoadLog.Audit(LoadLog.Parse(lines), Mod()));
        }

        [Fact]
        public void AKnownMessageIsLeftOutWithItsFramesAndOnlyIt()
        {
            var entries = LoadLog.Parse(new[]
            {
                Line("ERROR", "Mod.nelim.example", "Known: the Steam overlay is absent"),
                Line("ERROR", "Mod.nelim.example", "Another failure"),
            });

            var findings = LoadLog.Audit(entries, Mod(), "steam overlay");
            Assert.Single(findings);
            Assert.Equal(2, findings[0].Line);
        }

        [Fact]
        public void TheLineNumbersPointAtTheLogFile()
        {
            var entries = LoadLog.Parse(new[] { "chatter", "chatter", Line("ERROR", "Mod.nelim.example", "x") });
            Assert.Equal(3, LoadLog.Audit(entries, Mod()).Single().Line);
        }
    }
}
