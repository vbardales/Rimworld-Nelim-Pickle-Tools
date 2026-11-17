using System.Collections.Generic;
using System.Linq;
using RimWorks.Pickle;
using RimWorld;
using RimWorld.Planet;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Names the game generates, written 2026-11-17 for APerfectMindInAPerfectBody (a xenotype whose names come from a RulePackDef through a name bank: is a raw rule key left in a name?).
    /// The pawns are generated the way the game does for a colonist of a xenotype and are NOT spawned, so the colony does not change. Compiled, NOT PLAYED.
    /// </summary>
    [PickleSteps]
    public class NameSteps
    {
        private static readonly List<string> Names = new List<string>();

        [AfterScenario]
        public void ForgetNames() => Names.Clear();

        /// <summary>
        /// Generates N pawns of a xenotype (a Colonist kind, the player faction, the xenotype forced, so the game draws their names from the xenotype's name bank), logs
        /// <c>[generated-name] Xenotype: Full name (nick) / Short</c> for each and keeps the names for the assertion that follows. The pawns are handed to the world pawns and not spawned.
        /// Needs Biotech.
        /// </summary>
        [When("Nelim's Pickle Tools: {int} pawns of xenotype {string} are generated and their names are written to the log")]
        public void GenerateNames(PickleContext ctx, int count, string xenotypeName)
        {
            ctx.Require(ModsConfig.BiotechActive, "Biotech is not active: a xenotype needs it");
            ctx.Require(count > 0 && count <= 200, "the number of pawns must be between 1 and 200");
            XenotypeDef xenotype = DefDatabase<XenotypeDef>.GetNamedSilentFail(xenotypeName);
            ctx.Require(xenotype != null, $"no xenotype '{xenotypeName}' in this game");
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail("Colonist") ?? PawnKindDefOf.Colonist;
            Names.Clear();
            var lines = new List<string>();
            for (int i = 0; i < count; i++)
            {
                var request = new PawnGenerationRequest(kind, Faction.OfPlayer, PawnGenerationContext.NonPlayer, -1, forceGenerateNewPawn: true, fixedBiologicalAge: null, fixedChronologicalAge: null,
                    fixedGender: null, fixedBirthName: null, fixedLastName: null, forcedXenotype: xenotype);
                Pawn pawn = PawnGenerator.GeneratePawn(request);
                string full = pawn.Name?.ToStringFull ?? "(no name)";
                string shortName = pawn.Name?.ToStringShort ?? "(no name)";
                Names.Add(full);
                Log.Message($"[generated-name] {xenotypeName}: {full} / {shortName}");
                lines.Add($"{full} / {shortName}");
                Find.WorldPawns.PassToWorld(pawn, PawnDiscardDecideMode.Discard);
            }
            ctx.Attach("generated names", $"{xenotypeName}: " + string.Join("; ", lines));
        }

        /// <summary>
        /// Asserts that none of the names of the last "pawns of xenotype ... are generated" step holds a raw rule key: no square bracket, no "(r_" (a RulePack symbol that was not resolved), no
        /// "r_" word, no brace, and not empty. The failure lists the bad names.
        /// </summary>
        [Then("Nelim's Pickle Tools: none of the generated names holds a raw rule key")]
        public void NoRawKey(PickleContext ctx)
        {
            ctx.Require(Names.Count > 0, "no names were generated in this scenario: add 'pawns of xenotype ... are generated' before");
            List<string> bad = Names.Where(n => string.IsNullOrWhiteSpace(n) || n.IndexOfAny(new[] { '[', ']', '{', '}' }) >= 0 || n.Contains("(r_") || n.Contains(" r_") || n.StartsWith("r_") || n.Contains("(no name)")).ToList();
            ctx.Assert(bad.Count == 0, $"{bad.Count} of {Names.Count} generated names hold a raw rule key or are empty: {string.Join(" | ", bad.Take(10))}");
        }
    }
}
