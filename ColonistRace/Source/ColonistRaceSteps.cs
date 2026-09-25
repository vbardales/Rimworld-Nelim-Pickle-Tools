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
            Pawn pawn = ColonistLookup.Require(nickname);
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
        /// Gives a pawn a body type the game cannot draw at random: <c>Thin</c>, <c>Fat</c> or <c>Hulk</c>, or
        /// <c>Male</c> / <c>Female</c> (the plain body of that gender). The game keeps every body-type gene a pawn
        /// has and picks one at random each time the genes change, so a pawn with two of them (Hussar: Body_Standard
        /// and Body_Hulk) has no fixed body type. This step removes ALL the pawn's body-type genes, xenogenes and
        /// endogenes, adds the one gene of the type asked for (Body_Standard for Male and Female, whose body follows
        /// the gender; leaving the pawn with no body-type gene is not certain either, the game then takes the body type
        /// from the adulthood backstory or draws Thin one time in two), redraws the pawn and reads the body type back, failing with what it found if it is not the
        /// one asked for. The gender is set beforehand: nothing here recomputes it. An adult word (Thin, Fat, Hulk, Male,
        /// Female) refuses a child or a baby, whose body follows its age whatever its genes; <c>Child</c> and <c>Baby</c> are
        /// the words for those, see SetJuvenileBodyType. Without Biotech there are no genes and the body type is set directly.
        /// </summary>
        [Given("Nelim's Pickle Tools: {string} body type is {word}")]
        public void SetBodyType(PickleContext ctx, string nickname, string bodyType)
        {
            Pawn pawn = ColonistLookup.Require(nickname);
            ctx.Require(pawn.story != null, $"pawn '{nickname}' has no story, so it has no body type");

            string word = bodyType.ToLowerInvariant();
            if (word == "child" || word == "baby")
            {
                SetJuvenileBodyType(ctx, pawn, nickname, word == "child" ? BodyTypeDefOf.Child : BodyTypeDefOf.Baby);
                return;
            }

            BodyTypeDef wanted;
            GeneticBodyType? geneType = null;
            switch (bodyType.ToLowerInvariant())
            {
                case "male":
                    wanted = BodyTypeDefOf.Male;
                    geneType = GeneticBodyType.Standard;
                    break;
                case "female":
                    wanted = BodyTypeDefOf.Female;
                    geneType = GeneticBodyType.Standard;
                    break;
                case "thin":
                    wanted = BodyTypeDefOf.Thin;
                    geneType = GeneticBodyType.Thin;
                    break;
                case "fat":
                    wanted = BodyTypeDefOf.Fat;
                    geneType = GeneticBodyType.Fat;
                    break;
                case "hulk":
                    wanted = BodyTypeDefOf.Hulk;
                    geneType = GeneticBodyType.Hulk;
                    break;
                default:
                    throw new ArgumentException($"unknown body type '{bodyType}'; supported: Male, Female, Thin, Fat, Hulk (adults), Child, Baby (children)");
            }

            ctx.Require(
                pawn.DevelopmentalStage == DevelopmentalStage.Adult,
                $"pawn '{nickname}' is at the {pawn.DevelopmentalStage} stage of life, and the game gives a child or a baby " +
                "the body type of its age whatever its genes; set an adult age first");

            if (geneType == GeneticBodyType.Standard)
            {
                BodyTypeDef ofGender = pawn.gender == Gender.Female ? BodyTypeDefOf.Female : BodyTypeDefOf.Male;
                ctx.Require(
                    wanted == ofGender,
                    $"pawn '{nickname}' is {pawn.gender}, so with the standard body gene its body type is {ofGender.defName}, " +
                    $"not {wanted.defName}; set its gender first");
            }

            if (pawn.genes == null)
            {
                pawn.story.bodyType = wanted;
            }
            else
            {
                foreach (Gene gene in pawn.genes.GenesListForReading.Where(g => g.def.bodyType != null).ToList())
                {
                    pawn.genes.RemoveGene(gene);
                }

                if (geneType != null)
                {
                    GeneDef def = DefDatabase<GeneDef>.GetNamedSilentFail("Body_" + geneType)
                        ?? DefDatabase<GeneDef>.AllDefsListForReading.FirstOrDefault(g => g.bodyType == geneType);
                    ctx.Require(def != null, $"the game has no gene for the {bodyType} body type");
                    pawn.genes.AddGene(def, true);
                }
            }

            pawn.Drawer.renderer.SetAllGraphicsDirty();

            string actual = pawn.story.bodyType?.defName ?? "(none)";
            ctx.Assert(
                pawn.story.bodyType == wanted,
                $"pawn '{nickname}' should have body type {wanted.defName} after this step; it has {actual}, with the genes " +
                (pawn.genes == null ? "(none, no Biotech)" : string.Join(", ", pawn.genes.GenesListForReading.Select(g => g.def.defName))));
        }

        /// <summary>
        /// A child's or a baby's body is decided by its age, not by a gene, and setting the age of a pawn (<c>"Name" is N years
        /// old</c>) does not recompute it: a pawn made an adult and aged to eight keeps its adult body. So <c>body type is
        /// Child</c> and <c>body type is Baby</c> ask the game for the body type of the pawn's CURRENT stage of life
        /// (<c>PawnGenerator.GetBodyTypeFor</c>, which returns Baby or Child for a juvenile), store it, redraw and read it back:
        /// it fails, saying what it found, if the pawn's stage is not the one asked for. The pawn must already be a child or a
        /// baby (set the age first) and Biotech must be active, since there are no children without it.
        /// </summary>
        private static void SetJuvenileBodyType(PickleContext ctx, Pawn pawn, string nickname, BodyTypeDef wanted)
        {
            ctx.Require(ModsConfig.BiotechActive, "a child's or a baby's body type needs Biotech, and it is not active in this run");
            ctx.Require(
                pawn.DevelopmentalStage != DevelopmentalStage.Adult,
                $"pawn '{nickname}' is an adult; make it a child first with '\"{nickname}\" is 8 years old'");

            // What the pawn wears was chosen for an adult, and a piece with no texture for a child's body (the vanilla button-down shirt
            // has no ShirtButton_Child) makes the redraw log an error that fails the scenario. The game does the same when a pawn
            // grows into a stage: it takes off what that stage may not wear. Nothing is destroyed; it goes to the inventory.
            if (pawn.apparel != null)
            {
                DevelopmentalStage stage = pawn.DevelopmentalStage;
                pawn.apparel.DropAllOrMoveAllToInventory(apparel => (apparel.def.apparel.developmentalStageFilter & stage) == 0);
            }

            pawn.story.bodyType = PawnGenerator.GetBodyTypeFor(pawn);
            pawn.Drawer.renderer.SetAllGraphicsDirty();

            ctx.Assert(
                pawn.story.bodyType == wanted,
                $"pawn '{nickname}' should have body type {wanted.defName} after this step; it has {pawn.story.bodyType?.defName ?? "(none)"}, " +
                $"being at the {pawn.DevelopmentalStage} stage of life, aged {pawn.ageTracker?.AgeBiologicalYears} years");
        }

        /// <summary>
        /// Generates a colonist from a humanlike PawnKindDef, the way "a colonist exists" does from the plain
        /// colonist kind, and does nothing if a colonist by that nickname already exists. The race is the
        /// kind's, so a kind from a race mod gives a pawn of that race, with that race's body types.
        /// </summary>
        [Given("Nelim's Pickle Tools: a colonist {string} of kind {string} exists")]
        public void ColonistOfKindExists(PickleContext ctx, string nickname, string kindDefName)
        {
            if (ColonistLookup.Find(nickname) != null)
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
