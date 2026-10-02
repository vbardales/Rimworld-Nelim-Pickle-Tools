# TradeSteps

Pickle steps that bring a trader to the map, open the game's trade window and buy from it. Developer test companion; stage it with one line in a pass map: `nelim.pickletools.tradesteps   path:PickleTools/TradeSteps/Mod`.

Written 2026-10-02 for ContentedLivestock. **Not played yet.** Member names were read from the game's own Assembly-CSharp (1.6).

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: a trader of kind {string} has arrived` | Fires the trader-caravan incident with a forced `TraderKindDef`, waits up to 30 s for the trader pawn |
| `Nelim's Pickle Tools: the trade window is open` | Opens `Dialog_Trade` between the first free colonist and that trader |
| `Nelim's Pickle Tools: I buy {int} of {string} from the trader` | Sets the count of the tradeable whose def is the named ThingDef (an animal: its race def) and executes the deal. The sign of the count is checked against the game's `ActionToDo`. The colony needs silver |

The trade window and the trader are cleaned up after every scenario. `Check-Steps.ps1` compiles the patterns and checks they are not ambiguous.
