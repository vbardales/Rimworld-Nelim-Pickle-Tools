using System.Collections.Generic;
using System.Linq;
using RimWorld;
using RimWorks.Pickle;
using Verse;

namespace Nelim.PickleTools.ColonistRace
{
    /// <summary>
    /// An animal of any mod, spawned under an alias of the scenario, tamed, named, offered a training, read on its information card. Ported
    /// 2026-11-03 from DalmatiansRenew's AnimalSteps (generic wording, kind and stat names in the step) for RedWolvesRenew, at Audit's order
    /// (Virginie arbitrated: animal steps live in PickleTools, not in a copy per mod). Coats, butchering, rot and camera steps of the original
    /// are not ported. NOT PLAYED: compiled against the reference assemblies only.
    /// </summary>
    [PickleSteps]
    public class AnimalSteps
    {
        private static readonly Dictionary<string, Pawn> Aliases = new Dictionary<string, Pawn>(System.StringComparer.OrdinalIgnoreCase);

        [BeforeScenario]
        public void ResetAliases(PickleContext ctx) => Aliases.Clear();

        /// <summary>The animal spawned under the alias, else any spawned animal whose short name is the text (a tamed animal takes the name the game gave it).</summary>
        private static Pawn Named(PickleContext ctx, string alias)
        {
            Pawn pawn;
            return Aliases.TryGetValue(alias, out pawn) ? pawn : AnimalGeneSteps.FindAnimal(ctx, alias);
        }

        private static Pawn Spawn(PickleContext ctx, string alias, string kindName, Faction faction)
        {
            PawnKindDef kind = DefDatabase<PawnKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no PawnKindDef named '{kindName}' is loaded in this pass");
            ctx.Require(kind.race?.race != null && kind.race.race.Animal, $"the pawn kind '{kindName}' is not an animal");
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no map is loaded");
            IntVec3 cell;
            ctx.Require(CellFinder.TryFindRandomCellNear(map.Center, map, 20, c => c.Standable(map) && c.GetEdifice(map) == null && c.GetFirstPawn(map) == null, out cell),
                $"no free standable cell was found near {map.Center}");
            Pawn pawn = PawnGenerator.GeneratePawn(new PawnGenerationRequest(kind, faction, forceGenerateNewPawn: true, fixedBiologicalAge: 3f));
            GenSpawn.Spawn(pawn, cell, map);
            Aliases[alias] = pawn;
            return pawn;
        }

        /// <summary>
        /// Spawns an adult (3 years) wild animal of the pawn kind under the alias, on a free cell within 20 of the map centre. It is left unnamed on
        /// purpose: a wild animal has no name, and giving it one would make a "takes a name when tamed" scenario pass whatever the race says.
        /// Fails when the kind is not loaded or is not an animal. NOT PLAYED when written.
        /// </summary>
        [Given("Nelim's Pickle Tools: the wild animal {string} of kind {string} is spawned")]
        public void SpawnWild(PickleContext ctx, string alias, string kindName) => Spawn(ctx, alias, kindName, null);

        /// <summary>Spawns an adult (3 years) animal of the pawn kind, owned by the player, under the alias. NOT PLAYED when written.</summary>
        [Given("Nelim's Pickle Tools: the player animal {string} of kind {string} is spawned")]
        public void SpawnPlayer(PickleContext ctx, string alias, string kindName) => Spawn(ctx, alias, kindName, Faction.OfPlayer);

        /// <summary>
        /// Recruits the wild animal as the game does after a successful taming (InteractionWorker_RecruitAttempt.DoRecruit by the first free colonist),
        /// which joins the faction and gives the name the race asks for. Fails when there is no free colonist or the animal already has a faction. NOT PLAYED when written.
        /// </summary>
        [When("Nelim's Pickle Tools: the animal {string} is tamed")]
        public void Tame(PickleContext ctx, string alias)
        {
            Pawn animal = Named(ctx, alias);
            Pawn tamer = animal.Map?.mapPawns.FreeColonistsSpawned.FirstOrDefault();
            ctx.Require(tamer != null, "the map has no free colonist to do the taming");
            ctx.Require(animal.Faction == null, $"{alias} already belongs to {animal.Faction?.Name}");
            InteractionWorker_RecruitAttempt.DoRecruit(tamer, animal);
        }

        [Then("Nelim's Pickle Tools: the animal {string} belongs to the player")]
        public void BelongsToPlayer(PickleContext ctx, string alias) =>
            ctx.Assert(Named(ctx, alias).Faction == Faction.OfPlayer, $"{alias} is not a player animal");

        [Then("Nelim's Pickle Tools: the animal {string} has a name")]
        public void HasName(PickleContext ctx, string alias) =>
            ctx.Assert(Named(ctx, alias).Name != null, $"{alias} has no name (a tamed animal gets one when the race's nameOnTameChance allows it)");

        [Then("Nelim's Pickle Tools: the animal {string} has no name")]
        public void HasNoName(PickleContext ctx, string alias)
        {
            Name name = Named(ctx, alias).Name;
            ctx.Assert(name == null, $"{alias} is already named {name}");
        }

        /// <summary>
        /// Asks Pawn_TrainingTracker.CanAssignToTrain, the call the Training tab itself makes: the training must be visible there and accepted.
        /// The failure gives the game's reason. Fails when the TrainableDef is not loaded. NOT PLAYED when written.
        /// </summary>
        [Then("Nelim's Pickle Tools: the animal {string} offers the training {string}")]
        public void OffersTraining(PickleContext ctx, string alias, string trainableName)
        {
            Pawn animal = Named(ctx, alias);
            TrainableDef trainable = DefDatabase<TrainableDef>.GetNamedSilentFail(trainableName);
            ctx.Require(trainable != null, $"no TrainableDef named '{trainableName}' is loaded in this pass");
            ctx.Require(animal.training != null, $"{alias} has no training tracker");
            AcceptanceReport accepted = animal.training.CanAssignToTrain(trainable, out bool visible);
            ctx.Assert(visible, $"{alias}'s Training tab does not offer {trainableName}");
            ctx.Assert(accepted.Accepted, $"{alias} cannot be assigned to {trainableName}: {accepted.Reason}");
        }

        /// <summary>
        /// Reads the line the information card shows for a stat (StatsReportUtility.StatsToDraw, the list the Stats tab draws), as text with the
        /// unit, compared after trimming. The failure gives the value found, or says the card does not list the stat. Fails when the StatDef is not loaded. NOT PLAYED when written.
        /// </summary>
        [Then("Nelim's Pickle Tools: the information card of the animal {string} lists the stat {string} at {string}")]
        public void CardLists(PickleContext ctx, string alias, string statName, string value)
        {
            StatDef stat = DefDatabase<StatDef>.GetNamedSilentFail(statName);
            ctx.Require(stat != null, $"no StatDef named '{statName}'");
            Pawn animal = Named(ctx, alias);
            // StatsToDraw is not in the public surface of every game build: found by name, public or not, with a Thing parameter.
            System.Reflection.MethodInfo draw = typeof(StatsReportUtility).GetMethods(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Static)
                .FirstOrDefault(m => m.Name == "StatsToDraw" && m.GetParameters().Length == 1 && m.GetParameters()[0].ParameterType.IsAssignableFrom(typeof(Pawn)));
            ctx.Require(draw != null, "StatsReportUtility has no StatsToDraw(Thing) in this game build; its statics: "
                + string.Join(", ", typeof(StatsReportUtility).GetMethods(System.Reflection.BindingFlags.Public | System.Reflection.BindingFlags.NonPublic | System.Reflection.BindingFlags.Static).Select(m => m.Name).Distinct()));
            var entries = ((IEnumerable<StatDrawEntry>)draw.Invoke(null, new object[] { animal })).ToList();
            StatDrawEntry entry = entries.FirstOrDefault(e => e.stat == stat);
            ctx.Assert(entry != null, $"the information card of {alias} does not list {statName}");
            ctx.Assert(entry.ValueString.Trim() == value, $"the card lists {statName} at '{entry.ValueString}', expected '{value}'");
        }
    }
}
