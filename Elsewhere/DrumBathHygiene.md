# Drum Bath Hygiene

Live: every step below is in the repository named, in the file named, and was played in a run (or says it was not).
Nothing here is staged from PickleTools with a `path:` line: the assembly references the mod under test, so a suite
that wants a step **copies the method** and gives it its own prefix.

Repository: `vbardales/Rimworld-Drum-Bath-Hygiene` (in the monorepo, `DrumBathHygiene/`).
Steps: `Tests/Pickle/Source/DrumBathHygieneSteps.cs`, one class, no dependency on Dubs Bad Hygiene (the hygiene need is
found by its defName and read through vanilla `Need.CurLevel`). The suite's own notes, run by run, are in
`Tests/Pickle/README.md`; the passes it needs are in `TESTING.md`.

All texts start with `Drum Bath Hygiene: `, left out of the table below.

## Small and generic, candidates to move if a second mod wants them

State is per step: *played* names a real run, *not yet played* says the step compiled and resolved and nothing more.
Updated 2026-09-23 after a code review of the suite; the steps below are those in `DrumBathHygieneSteps.cs` at that date.

| Step | What it does | State | Why it stays | Move it when |
|---|---|---|---|---|
| `{string} is chilled to severity {float}` | Adds **Hypothermia** at a chosen severity | played, run 5 | one hediff | a second mod needs a hediff at a severity. Generalise it to `{string} is given hediff {string} at severity {float}`: Pickle's `is given hediff` gives the def's starting severity, which a bath or a fire can remove before the first tick |
| `{string} hygiene rose`, `did not rise`, `is above {float}`, and `I remember {string} hygiene` | Read the **Hygiene** need level (0 to 1) and compare it with a remembered one. `rose` needs a margin of 0.02, because Dubs Bad Hygiene moves the need by itself. The remembered readings are cleared before every scenario by a `[BeforeScenario]` hook: a static in the step assembly outlives Pickle's reload of the save | played, run 5 (the reset is not yet played) | hard-coded to the `Hygiene` need def | any other need. **Pickle ships `needs {string} is below {int} percent` and no `is above`**, and no rise/remember for needs: this is a gap of Pickle's, so it is a candidate for `Upstream/PENDING.md` rather than for a tool. (`is below` was removed: the built-in does it) |
| `{string} has no hygiene need`, `{string} loses the hygiene need` | Assert the need is absent; the second removes it from the pawn's need list, to reach the branch of a mod that has to cope with a pawn lacking it. The scenario asserts the absence again after the bath, in case the game gave the need back | `has no …` played, run 5; `loses …` **not yet played** | need def hard-coded | any other need def |
| `{string} is carrying filth`, `carries filth`, `carries no filth` | Give a pawn `Filth_Dirt` through its filth tracker, and read `Pawn_FilthTracker.CarriedFilthListForReading` | played, run 5 | three small steps | a second mod touches carried filth |
| `{string} has at least {int} memories of {string}`, `{string} forgets {string}` | Count the stacks of a memory (`NumMemoriesOfDef`) and remove every memory of a def. The first is how to assert that a memory **stacked**; the second is how to prove a second occurrence re-grants it, instead of passing on what the first left behind | **not yet played** | two short steps | a second mod asserts a stacking memory |
| `{string} stands {int} cells east of the drum at x=.. z=..`, `no one but {string} stands within 6 cells of the drum at x=.. z=..` | Teleport a pawn to a cell some distance from a thing and check it lands inside a radius; and a **loud precondition** that no other humanlike pawn is within it. Drafting a pawn does not move it, so a baseline of "nobody is watching" is only true if this says so | **not yet played** | written around the drum's cell, though the idea is general | a second mod has an effect that depends on who is nearby |

Removed on 2026-09-23, and worth knowing before writing them again: `is bored` (unused: Pickle's `{string} needs {string} is
set to {int} percent` sets Joy on a colonist), `has a hygiene need` (unused), and `is easily embarrassed` (replaced by Pickle's
own `I take the trait {string} from {string}`, which does nothing if the pawn lacks the trait).

## Dedicated to the drum mod, no reuse expected outside it

| Step | What it does | State |
|---|---|---|
| `a drum bath stands at x={int} z={int}` | Spawns the `DrumBath` building made of Steel. It arrives lit, as a built one does | played, run 5 |
| `the drum at x={int} z={int} is burning` / `has burnt out` | Fills or drains its `CompRefuelable`, the thing the drum mod's own fuel reading looks at | played, run 5 |
| `{string} climbs into the drum at x={int} z={int}` | **Teleports** a pawn onto the drum's cell. For scenarios that give the hediff by hand and want the component isolated from pathing | played, run 5 |
| `{string} is ordered to bathe in the drum at x={int} z={int}` | Orders the drum mod's **real job**, `Job_BathingAtDrumBath`, so its driver walks the pawn over, places them and applies the hediff | played, run 5 |
| `{string} is bathing in the drum at x={int} z={int}` | Waits up to 90 s for the bath job to be running, the hediff on the pawn, and **the drum among the things on the pawn's cell** (the mod's own hot-or-cold question). Polls once per frame against a deadline. **On timeout it reports a job trace**: every change of job with position and hediff, the driver, whether the drum is reachable, the pawn's state | played in run 5, **then changed twice** (it demanded `CurJob.targetA.Thing == drum`, which the driver rewrites; then a 2.5-cell radius, which accepts a pawn beside the drum); the current one is **not yet played** |
| `{string} has climbed out of the drum` | Waits up to 120 s until the pawn has neither the bath job nor the bathing hediff, so that a second bath can be ordered and the component can be shown to start afresh | **not yet played** |
| `the bathing hediff of {string} carries the component` | Asserts the loaded `Hed_BathingAtDrumBathPassive` is a `HediffWithComps` carrying this mod's comp | played, run 5 |

Only the last is specific to this mod; the others are specific to the drum mod and would serve any mod that patches
its bath.

## Traps met while writing them

These cost runs, and none of them is specific to a drum:

1. **`ctx.AssertEventually(...)` returns a `Task`.** A `void` step that calls it and drops the result never waits and
   can never fail. Three runs went green over it. A step that waits is `async Task` with `await ctx.WaitUntil(...)`,
   then `ctx.Assert(...)`, as AnimaSong's are.
2. **`WaitUntil` throws `System.TimeoutException` on timeout, before your message can run.** A bare timeout says nothing, and a run
   costs a ticket in the queue, so a step wants a trace in its failure. Do not `catch (Exception)` around it to build one:
   that also swallows a `NullReferenceException` in your own condition and a scenario abort. Poll instead, with
   `await ctx.WaitFrames(1)` against your own deadline, so that a timeout is an ordinary `false` and anything thrown is real.
   The trace in `is bathing` is the pattern.
3. **A test colonist arrives with joy full.** A real joy job ends at once through `JoyUtility.JoyTickCheckEnd`
   and removes what it added. Set Joy low before ordering one. (AnimaSong met the same.)
4. **A colonist left free at low hygiene is given a job of its own** by Dubs Bad Hygiene one tick later. A pawn
   teleported into place has to be drafted, or every reading depends on something else.
5. **Pickle's own pawn steps find colonists by nickname only.** `is given hediff` on an animal fails with "no pawn
   nicknamed …". Resolve the name yourself, as `PawnNamed` does.
6. **A `@review` scenario that is green has shown nothing.** Assert the state right before the shot, and film it if a
   still cannot say why it looks wrong.
7. **`Log.WarningOnce` prints once per key for the whole game session, and one Pickle run is one session.** A mod that reports
   failures that way is only visible to the FIRST scenario that triggers one. `no warnings from mod {string}` therefore has
   to end every scenario that exercises the code, not a few of them, and `no errors were logged` cannot see a warning at all.
8. **An absence is only a test if something proves the code ran.** `has no thought X` is as true when the component never
   started as when it worked. Put a positive marker that only a running component can produce in the same scenario.
