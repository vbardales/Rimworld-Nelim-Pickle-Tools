using System;
using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// Two steps that give a scenario a colonist whose body is not the plain human one: a Biotech xenotype on
    /// an existing pawn, and a colonist generated from any humanlike PawnKindDef, which is how a race a mod
    /// adds (Humanoid Alien Races, for one) is reached, since a pawn's race cannot be swapped in place.
    ///
    /// Written to sit beside Pickle's own ColonistSteps and WorldSteps, and meant to go there. Until then
    /// they live here, see ../README.md.
    /// </summary>
    [PickleSteps]
    public class ColonistRaceSteps
    {
        private const string None = "(none)";

        /// <summary>
        /// Gives a pawn a Biotech xenotype and redraws it. The game removes the pawn's xenogenes and adds the
        /// xenotype's genes one by one, so a gene that carries a body type (Body_Thin, Body_Hulk...) sets the
        /// body type as it goes. The endogenes the pawn was born with are kept, so a pawn already carrying
        /// one of those keeps it alongside the new ones.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} xenotype is {string}")]
        public void SetXenotype(PickleContext ctx, string nickname, string xenotypeDefName)
        {
            ctx.Require(ModsConfig.BiotechActive, "xenotypes need Biotech, and it is not active in this run");
            Pawn pawn = RequireColonist(nickname);
            ctx.Require(pawn.genes != null, $"pawn '{nickname}' has no genes, so it has no xenotype");

            List<XenotypeDef> all = DefDatabase<XenotypeDef>.AllDefsListForReading;
            XenotypeDef def = all.FirstOrDefault(
                x => string.Equals(x.defName, xenotypeDefName, StringComparison.OrdinalIgnoreCase));
            ctx.Require(
                def != null,
                $"no xenotype '{xenotypeDefName}'; the xenotypes are {string.Join(", ", all.Select(x => x.defName))}");

            pawn.genes.SetXenotype(def);
            pawn.Drawer.renderer.SetAllGraphicsDirty();
        }

        /// <summary>
        /// Generates a colonist from a humanlike PawnKindDef, the way "a colonist exists" does from the plain
        /// colonist kind, and does nothing if a colonist by that nickname already exists. The race is the
        /// kind's, so a kind from a race mod gives a pawn of that race, with that race's body types.
        /// </summary>
        [Given("Nelim's Pickle Tools: a colonist {string} of kind {string} exists")]
        public void ColonistOfKindExists(PickleContext ctx, string nickname, string kindDefName)
        {
            if (FindColonist(nickname) != null)
            {
                return;
            }

            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map is loaded; load a save first with 'the save ... is loaded'");

            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindDefName);
            if (kind == null)
            {
                List<string> humanlike = DefDatabase<PawnKindDef>.AllDefsListForReading
                    .Where(k => k.RaceProps != null && k.RaceProps.Humanlike)
                    .Select(k => k.defName)
                    .ToList();
                ctx.Require(
                    false,
                    $"no pawn kind '{kindDefName}'; {humanlike.Count} humanlike kinds exist, the first ones being " +
                    string.Join(", ", humanlike.Take(30)));
            }

            ctx.Require(
                kind.RaceProps.Humanlike,
                $"pawn kind '{kindDefName}' is a {kind.race.defName}, which is not humanlike, so it cannot be a colonist");

            IntVec3 cell = FindSpawnCell(ctx, map);

            // Seeded here, not at scenario start, like the colonist step: Rand is one stream the game draws
            // from every tick, and Pop puts the game's own back.
            Rand.PushState(Gen.HashCombineInt(ctx.ScenarioSeed, GenText.StableStringHash(nickname)));
            try
            {
                Pawn pawn = PawnGenerator.GeneratePawn(kind, Faction.OfPlayer);
                pawn.Name = new NameTriple(nickname, nickname, nickname);
                GenSpawn.Spawn(pawn, cell, map, WipeMode.Vanish);
            }
            finally
            {
                Rand.PopState();
            }
        }

        private static Pawn FindColonist(string nickname)
        {
            return PawnsFinder.AllMaps_FreeColonists.FirstOrDefault(
                p => string.Equals(p.Name?.ToStringShort, nickname, StringComparison.OrdinalIgnoreCase));
        }

        private static Pawn RequireColonist(string nickname)
        {
            Pawn pawn = FindColonist(nickname);
            if (pawn != null)
            {
                return pawn;
            }

            string known = string.Join(", ", PawnsFinder.AllMaps_FreeColonists.Select(p => p.Name?.ToStringShort ?? None));
            throw new InvalidOperationException($"no colonist named '{nickname}'; the colonists are {known}");
        }

        private static IntVec3 FindSpawnCell(PickleContext ctx, Map map)
        {
            IntVec3 origin = map.mapPawns.FreeColonistsSpawned.FirstOrDefault()?.Position ?? map.Center;
            if (CellFinder.TryFindRandomCellNear(origin, map, 20, c => c.Standable(map), out IntVec3 near, 200))
            {
                return near;
            }

            ctx.Require(
                CellFinder.TryFindRandomCellNear(map.Center, map, 80, c => c.Standable(map), out IntVec3 wide, 500),
                "no standable cell found on this map to spawn a colonist into");
            return wide;
        }
    }
}
