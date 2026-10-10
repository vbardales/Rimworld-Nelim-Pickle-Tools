using System;
using System.Linq;
using System.Threading.Tasks;
using RimWorks.Pickle;
using RimWorld;
using Verse;

namespace Nelim.PickleTools.TradeSteps
{
    /// <summary>
    /// Steps that bring a trader to the map, open the trade window with the first free colonist as negotiator, and buy from it, for a
    /// capture of the trade window or a test of a mod that sells through traders.
    ///
    /// Written on 2026-10-02 for ContentedLivestock (its session, at Virginie's request). NOT PLAYED: the member names were read from the
    /// game's own Assembly-CSharp (1.6) by reflection, not from Pickle. The sign of a Tradeable's count is not assumed: the buy step tries
    /// one sign and checks the game's own <c>ActionToDo</c> says "PlayerBuys", then the other.
    /// </summary>
    [PickleSteps]
    public class TradeSteps
    {
        /// <summary>Prefix of the failure message of a step that found no stock: greppable, and what a flaky-stock tag filters on.</summary>
        public const string NoStockPrefix = "[no-stock] ";

        private static ITrader trader;

        /// <summary>
        /// Fires the trader-caravan incident with a forced trader kind (a TraderKindDef name such as Caravan_Outlander_BulkGoods) and waits
        /// up to 30 seconds for a pawn of that kind to stand on the map. Fails if the incident declines or nobody of that kind arrives.
        /// </summary>
        [Given("Nelim's Pickle Tools: a trader of kind {string} has arrived", TimeoutSeconds = 45f)]
        public async Task TraderArrives(PickleContext ctx, string kindName)
        {
            Map map = CurrentMap(ctx);
            TraderKindDef kind = DefDatabase<TraderKindDef>.GetNamedSilentFail(kindName);
            ctx.Require(kind != null, $"no trader kind '{kindName}' in this game");

            if (kind.orbital)
            {
                // An orbital trader is a TradeShip in the passing-ship manager, not a pawn on the map.
                IncidentDef orbital = IncidentDefOf.OrbitalTraderArrival;
                IncidentParms oparms = StorytellerUtility.DefaultParmsNow(orbital.category, map);
                oparms.forced = true;
                oparms.traderKind = kind;
                ctx.Require(orbital.Worker.TryExecute(oparms), $"the orbital trader incident did not fire for '{kindName}'");
                await ctx.WaitUntil(() => FindShip(map, kind) != null, 10f);
                trader = FindShip(map, kind);
                ctx.Assert(trader != null, $"no orbital trader ship of kind '{kindName}' is in range after the incident");
                return;
            }

            IncidentDef incident = IncidentDefOf.TraderCaravanArrival;
            IncidentParms parms = StorytellerUtility.DefaultParmsNow(incident.category, map);
            parms.forced = true;
            parms.traderKind = kind;
            parms.faction = Find.FactionManager.AllFactionsListForReading
                .FirstOrDefault(f => !f.IsPlayer && !f.HostileTo(Faction.OfPlayer) && f.def.caravanTraderKinds != null && f.def.caravanTraderKinds.Contains(kind))
                ?? Find.FactionManager.AllFactionsListForReading.FirstOrDefault(f => !f.IsPlayer && !f.HostileTo(Faction.OfPlayer) && f.def.caravanTraderKinds != null && f.def.caravanTraderKinds.Count > 0);
            ctx.Require(parms.faction != null, "no non-hostile faction can send a trader caravan on this map");

            bool fired = incident.Worker.TryExecute(parms);
            ctx.Require(fired, $"the trader-caravan incident did not fire for '{kindName}'");

            await ctx.WaitUntil(() => FindTrader(map, kind) != null, 30f);
            trader = FindTrader(map, kind);
            ctx.Assert(trader != null, $"no pawn with trader kind '{kindName}' stands on the map 30 seconds after the incident");
        }

        /// <summary>
        /// Opens the game's trade window between the first free colonist and the trader that arrived, and waits for the session to be active.
        /// </summary>
        [When("Nelim's Pickle Tools: the trade window is open", TimeoutSeconds = 20f)]
        public async Task OpenWindow(PickleContext ctx)
        {
            Map map = CurrentMap(ctx);
            ctx.Require(IsHere(trader), "no trader is on the map: use 'a trader of kind ... has arrived' first");
            Pawn negotiator = map.mapPawns.FreeColonistsSpawned.FirstOrDefault(p => !p.Downed && !p.Dead);
            ctx.Require(negotiator != null, "no free colonist is on the map to negotiate");

            Find.WindowStack.Add(new Dialog_Trade(negotiator, trader));
            await ctx.WaitUntil(() => TradeSession.Active, 10f);
            ctx.Assert(TradeSession.Active, "the trade session is not active after the window was added");
        }

        /// <summary>
        /// Buys a number of a thing from the trader: finds the tradeable whose def is the named ThingDef (an animal's def is its race, for
        /// example Muffalo), sets the count so the game reads it as a purchase, and executes the deal. Fails naming what is wrong: no such
        /// tradeable, not enough in stock, too little silver, or the game refused the deal.
        /// </summary>
        [When("Nelim's Pickle Tools: I buy {int} of {string} from the trader", TimeoutSeconds = 20f)]
        public void Buy(PickleContext ctx, int count, string defName)
        {
            ctx.Require(TradeSession.Active, "no trade window is open: use 'the trade window is open' first");
            ctx.Require(count > 0, $"a purchase buys at least one, not {count}");
            Tradeable item = TradeSession.deal.AllTradeables.FirstOrDefault(t => t.HasAnyThing && t.ThingDef != null && t.ThingDef.defName == defName);
            ctx.Require(item != null, $"the trader offers no '{defName}'");
            int stock = item.CountHeldBy(Transactor.Trader);
            ctx.Require(stock >= count, $"the trader holds {stock} '{defName}', fewer than {count}");

            item.AdjustTo(count);
            if (item.ActionToDo != TradeAction.PlayerBuys)
            {
                item.AdjustTo(-count);
            }

            ctx.Require(item.ActionToDo == TradeAction.PlayerBuys, $"the game reads the count for '{defName}' as {item.ActionToDo}, not a purchase");
            TradeSession.deal.UpdateCurrencyCount();
            bool traded = false;
            bool executed = TradeSession.deal.TryExecute(out traded);
            ctx.Assert(executed && traded, $"the deal for {count} '{defName}' was not executed (the colony may lack silver)");
        }

        /// <summary>Closes the trade window and forgets the trader, after every scenario.</summary>
        [AfterScenario]
        public void CleanUp(PickleContext ctx)
        {
            if (TradeSession.Active)
            {
                TradeSession.Close();
            }

            trader = null;
        }

        /// <summary>
        /// Asserts the open trade window lists a tradeable of the named ThingDef held by the TRADER (its stock). When there is none the step
        /// fails with a message that starts with <c>[no-stock] </c>: Pickle 6.6.3 has no runtime skip (its Skipped outcome comes from tags such as
        /// @wip and unmet @requires, decided before a scenario starts), so the closest is a distinct greppable prefix. Tag such a scenario
        /// @flaky-stock and read its failures by that prefix.
        /// </summary>
        [Then("Nelim's Pickle Tools: the trader offers {string}")]
        public void TraderOffers(PickleContext ctx, string defName)
        {
            ctx.Require(TradeSession.Active, "no trade window is open: use 'the trade window is open' first");
            Tradeable item = TradeSession.deal.AllTradeables.FirstOrDefault(t => t.HasAnyThing && t.ThingDef != null && t.ThingDef.defName == defName);
            int stock = item == null ? 0 : item.CountHeldBy(Transactor.Trader);
            ctx.Assert(stock > 0, NoStockPrefix + $"the trader holds no '{defName}' in this deal (its stock is random, and a kind that trades the tag may still have none)");
        }

        /// <summary>
        /// Asserts the trade window lists a tradeable of the named ThingDef held by the COLONY and that the trader would take it. A buy-side
        /// tag is not random: with an animal of that def in the colony this fails for a real reason (the trader's kind does not buy the tag).
        /// </summary>
        [Then("Nelim's Pickle Tools: the trader would buy {string}")]
        public void TraderWouldBuy(PickleContext ctx, string defName)
        {
            ctx.Require(TradeSession.Active, "no trade window is open: use 'the trade window is open' first");
            var mine = TradeSession.deal.AllTradeables.Where(t => t.ThingDef != null && t.ThingDef.defName == defName && t.CountHeldBy(Transactor.Colony) > 0).ToList();
            ctx.Assert(mine.Count > 0, $"no '{defName}' held by the colony is listed in the deal (spawn a tamed one first; the trader's kind may not buy that tag)");
            ctx.Assert(mine.Any(t => t.TraderWillTrade), $"the colony's '{defName}' is listed, but the trader will not trade it");
        }

        private static bool IsHere(ITrader t)
        {
            var pawn = t as Pawn;
            if (pawn != null)
            {
                return pawn.Spawned;
            }

            return t != null;
        }

        private static ITrader FindShip(Map map, TraderKindDef kind)
        {
            return map.passingShipManager.passingShips.OfType<TradeShip>().FirstOrDefault(sh => sh.def == kind);
        }

        private static Pawn FindTrader(Map map, TraderKindDef kind)
        {
            return map.mapPawns.AllPawnsSpawned.FirstOrDefault(p => p.TraderKind == kind);
        }

        private static Map CurrentMap(PickleContext ctx)
        {
            Map map = Find.CurrentMap;
            ctx.Require(map != null, "no current map is loaded; load a save first with 'the save ... is loaded'");
            return map;
        }
    }
}
