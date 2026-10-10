# TradeSteps

Pickle steps that bring a trader to the map, open the game's trade window and buy from it. Developer test companion; stage it with one line in a pass map: `nelim.pickletools.tradesteps   path:PickleTools/TradeSteps/Mod`.

Written 2026-10-02 for ContentedLivestock. **Not played yet.** Member names were read from the game's own Assembly-CSharp (1.6).

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: a trader of kind {string} has arrived` | Fires the trader-caravan incident with a forced `TraderKindDef`, waits up to 30 s for the trader pawn |
| `Nelim's Pickle Tools: the trade window is open` | Opens `Dialog_Trade` between the first free colonist and that trader |
| `Nelim's Pickle Tools: I buy {int} of {string} from the trader` | Sets the count of the tradeable whose def is the named ThingDef (an animal: its race def) and executes the deal. The sign of the count is checked against the game's `ActionToDo`. The colony needs silver |
| `Nelim's Pickle Tools: the trader offers {string}` | Asserts the trader holds at least one of the named ThingDef. No stock fails with a message starting `[no-stock] `: Pickle 6.6.3 has no runtime skip (its Skipped outcome comes from tags such as `@wip` and unmet `@requires`, set before the scenario starts), so tag such a scenario `@flaky-stock` and read its failures by that prefix. Compiled, not played |
| `Nelim's Pickle Tools: the trader would buy {string}` | Asserts the deal lists a tradeable of that ThingDef held by the colony, and that the trader will trade it (a tamed animal spawned in the colony first). Buy-side tags are not random: a failure is real. Compiled, not played |

An orbital kind (`TraderKindDef.orbital`, for example `Orbital_Exotic`) fires `OrbitalTraderArrival` and trades with the `TradeShip` instead of a pawn; a caravan kind fires `TraderCaravanArrival`. Compiled, not played for the orbital path.

The trade window and the trader are cleaned up after every scenario. `Check-Steps.ps1` compiles the patterns and checks they are not ambiguous.
