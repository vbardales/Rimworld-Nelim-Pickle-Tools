# Drum Bath Hygiene

Live: every step below in named repo, named file, played in run (or says not).
Nothing here staged from PickleTools with `path:` line: assembly references mod under test, so suite wanting a step **copies method**, gives own prefix.

Repository: `vbardales/Rimworld-Drum-Bath-Hygiene` (in monorepo, `DrumBathHygiene/`).
Steps: `Tests/Pickle/Source/DrumBathHygieneSteps.cs`, one class, no dependency on Dubs Bad Hygiene (hygiene need found by defName, read through vanilla `Need.CurLevel`). Suite's own notes, run by run, in `Tests/Pickle/README.md`; passes needed in `TESTING.md`.

All texts start with `Drum Bath Hygiene: `, left out of table below.

## Small and generic, candidates to move if a second mod wants them

State per step: *played* names real run, *not yet played* = step compiled and resolved, nothing more.
Updated 2026-09-23 after code review of suite; table below is that date's. The 9 steps added since are in "Declared 2026-10-11" after it: 32 declarations total (`INVENTORY.md`).

| Step | What it does | State | Why it stays | Move it when |
|---|---|---|---|---|
| `{string} is chilled to severity {float}` | Adds **Hypothermia** at chosen severity | played, run 5 | one hediff | second mod needs hediff at severity. Generalise to `{string} is given hediff {string} at severity {float}`: Pickle's `is given hediff` gives def's starting severity, which bath or fire can remove before first tick |
| `{string} hygiene rose`, `did not rise`, `is above {float}`, and `I remember {string} hygiene` | Read **Hygiene** need level (0 to 1), compare with remembered one. `rose` needs margin 0.02, because Dubs Bad Hygiene moves need by itself. Remembered readings cleared before every scenario by `[BeforeScenario]` hook: static in step assembly outlives Pickle's reload of save | played, run 5 (reset not yet played) | hard-coded to `Hygiene` need def | any other need. **Pickle ships `needs {string} is below {int} percent`, no `is above`**, no rise/remember for needs: gap of Pickle's, so candidate for `Upstream/PENDING.md`, not for tool. (`is below` removed: built-in does it) |
| `{string} has no hygiene need`, `{string} loses the hygiene need` | Assert need absent; second removes it from pawn's need list, to reach branch of mod that must cope with pawn lacking it. Scenario asserts absence again after bath, in case game gave need back | `has no …` played, run 5; `loses …` **not yet played** | need def hard-coded | any other need def |
| `{string} is carrying filth`, `carries filth`, `carries no filth` | Give pawn `Filth_Dirt` through filth tracker, read `Pawn_FilthTracker.CarriedFilthListForReading` | played, run 5 | three small steps | second mod touches carried filth |
| `{string} has at least {int} memories of {string}`, `{string} forgets {string}` | Count stacks of memory (`NumMemoriesOfDef`), remove every memory of def. First asserts memory **stacked**; second proves second occurrence re-grants it, instead of passing on what first left behind | **not yet played** | two short steps | second mod asserts stacking memory |
| `{string} stands {int} cells east of the drum at x=.. z=..`, `no one but {string} stands within 6 cells of the drum at x=.. z=..` | Teleport pawn to cell some distance from thing, check it lands inside radius; and **loud precondition** that no other humanlike pawn within it. Drafting pawn does not move it, so baseline "nobody watching" only true if this says so | **not yet played** | written around drum's cell, idea general | second mod has effect depending on who is nearby |

Removed 2026-09-23, worth knowing before writing again: `is bored` (unused: Pickle's `{string} needs {string} is
set to {int} percent` sets Joy on colonist), `has a hygiene need` (unused), `is easily embarrassed` (replaced by Pickle's
own `I take the trait {string} from {string}`, does nothing if pawn lacks trait).

## Dedicated to the drum mod, no reuse expected outside it

| Step | What it does | State |
|---|---|---|
| `a drum bath stands at x={int} z={int}` | Spawns `DrumBath` building made of Steel. Arrives lit, as built one does | played, run 5 |
| `the drum at x={int} z={int} is burning` / `has burnt out` | Fills or drains its `CompRefuelable`, what drum mod's own fuel reading looks at | played, run 5 |
| `{string} climbs into the drum at x={int} z={int}` | **Teleports** pawn onto drum's cell. For scenarios giving hediff by hand, wanting component isolated from pathing | played, run 5 |
| `{string} is ordered to bathe in the drum at x={int} z={int}` | Orders drum mod's **real job**, `Job_BathingAtDrumBath`, so its driver walks pawn over, places them, applies hediff | played, run 5 |
| `{string} is bathing in the drum at x={int} z={int}` | Waits up to 90 s for bath job running, hediff on pawn, and **drum among things on pawn's cell** (mod's own hot-or-cold question). Polls once per frame against deadline. **On timeout reports job trace**: every job change with position and hediff, driver, whether drum reachable, pawn's state | played in run 5, **then changed twice** (demanded `CurJob.targetA.Thing == drum`, which driver rewrites; then 2.5-cell radius, which accepts pawn beside drum); current one **not yet played** |
| `{string} has climbed out of the drum` | Waits up to 120 s until pawn has neither bath job nor bathing hediff, so second bath can be ordered, component shown to start afresh | **not yet played** |
| `the bathing hediff of {string} carries the component` | Asserts loaded `Hed_BathingAtDrumBathPassive` is `HediffWithComps` carrying this mod's comp | played, run 5 |

### Declared 2026-10-11: steps added since the table above (all in `DrumBathHygieneSteps.cs`)

| Step | What it does | State | Why it stays | Move it when |
|---|---|---|---|---|
| `{string} is given the bathing hediff, then loses the hygiene need` | Hediff and missing need in ONE step, in that order: game hands pawn needs back whenever hediff changes, so removing need first proved nothing about branch for pawn without it | played, French pass 2026-09-23 | hediff is this mod's | never: specific to drum mod |
| `the bathing hediff of {string} bound no clean action` | Reads component's two private fields (`cleanBound`, `clean`) by reflection, says whether no-need branch really taken | played | reads this mod's own fields | never |
| `the letters and the alerts are cleared from the screen` | Empties letter stack and every `List<Alert>` of alerts readout (by reflection), so shot keeping Needs tab not cluttered | played, 2026-10 gallery runs | PickleTools' screenshot mode hides tab with the clutter | **now a candidate**: any mod capturing interface tab needs it; belongs in ScreenshotMode |
| `the drum's light is switched off at x={int} z={int}` | Deregisters drum's `CompGlower` so game's light square not drawn behind drum | played | one building | never |
| `the drum's motes are cleared at x={int} z={int}` | Destroys `Mote_Bombardment` within 4 cells of cell: drum mod's own motes draw square like light | played | one mote def | never |
| `the camera looks at the drum at x={int} z={int}, shifted {int} cells west, at zoom {int}` and `the camera's zoom limits are restored` | Centres camera west of cell, lowers game's closest zoom (root size 11) for shot, reads root size back, fails with number if stopped short; second step puts limit back | played | shot specific | **candidate** with PickleTools' studio presets, which set same root size |
| `the game is saved as {string}` and `the saved game {string} is handed to the mod {string}` | Saves running game, copies `.rws` into `Pickle/Fixtures` of companion mod not depending on this one, for second launch without this mod (`-ThenWithout`) | played, run 28cc, 2026-10-08 | none | **already a second consumer**: AnimalApparelCollarsAndKitRenew uses same mechanism. Promote to PickleTools (AGENTS.md, "Local scripts": second use = one shared step, both callers migrated, duplicate deleted) |
| `I list what is around the drum at x={int} z={int}` | **Temporary diagnostic** (2026-09-26): logs what shines or floats near drum with `[DBH-DIAG]` prefix | played once | nothing reads it now | **remove**: `99-diagnostic.feature` already gone, step orphaned (cause it found handled by motes step) |

Only last specific to this mod; others specific to drum mod, would serve any mod patching its bath.

## Traps met while writing them

These cost runs, none specific to drum:

1. **`ctx.AssertEventually(...)` returns `Task`.** `void` step calling it and dropping result never waits, never fails. Three runs went green over it. Waiting step is `async Task` with `await ctx.WaitUntil(...)`, then `ctx.Assert(...)`, as AnimaSong's are.
2. **`WaitUntil` throws `System.TimeoutException` on timeout, before your message can run.** Bare timeout says nothing, run costs ticket in queue, so step wants trace in failure. Do not `catch (Exception)` around it to build one: also swallows `NullReferenceException` in own condition and scenario abort. Poll instead, with
   `await ctx.WaitFrames(1)` against own deadline, so timeout is ordinary `false`, anything thrown is real.
   Trace in `is bathing` is the pattern.
3. **Test colonist arrives with joy full.** Real joy job ends at once through `JoyUtility.JoyTickCheckEnd`, removes what it added. Set Joy low before ordering one. (AnimaSong met same.)
4. **Colonist left free at low hygiene gets own job** from Dubs Bad Hygiene one tick later. Pawn teleported into place must be drafted, or every reading depends on something else.
5. **Pickle's own pawn steps find colonists by nickname only.** `is given hediff` on animal fails with "no pawn
   nicknamed …". Resolve name yourself, as `PawnNamed` does.
6. **Green `@review` scenario has shown nothing.** Assert state right before shot, film it if still cannot say why it looks wrong.
7. **`Log.WarningOnce` prints once per key for whole game session, one Pickle run = one session.** Mod reporting
   failures that way only visible to FIRST scenario triggering one. `no warnings from mod {string}` therefore must
   end every scenario exercising the code, not a few, and `no errors were logged` cannot see warning at all.
8. **Absence only a test if something proves code ran.** `has no thought X` as true when component never
   started as when it worked. Put positive marker only running component can produce in same scenario.
9. **`TryTakeOrderedJob` returns true for job ending inside `StartJob`.** Build ordered job the way mod
   under test builds its own (which target index holds thing, which cell; read its job giver), not
   way `MakeJob(def, thing)` suggests: driver whose first toil fails on null target or refused reservation
   ends job at once, order step passes, colonist still ends up doing the thing when mod's joy giver
   or work giver sends them on own schedule. Looks like slow success, passes or fails scenario by scenario
   from one run to next. Step ordering a job should also note, at that instant, pawn's current job
   and target's reservations, so wait failing ninety seconds later can say why.
10. **Game gives pawn needs back when hediffs change** (`Pawn_NeedsTracker.AddOrRemoveNeedsAsAppropriate`).
    A need taken off a pawn by hand before an action that adds a hediff is back afterwards. Add the hediff first and
    take the need off second, in the same step, or assert the precondition again after the action.
