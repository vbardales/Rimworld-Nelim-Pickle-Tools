# In suites: Pickle steps that live in a mod's own repository

Not a tool. An index of the steps that were **not** moved into a shared companion mod here, because they are tied to
one mod or too small to justify a folder of their own, and where each one lives. If a suite needs something like them,
look here first: the code exists, it has been played, and it says what it learned.

## What this is, and what it is not

- **Not stageable.** A step assembly in a suite (`<Mod>/Tests/Pickle/Mod/Pickle/Assemblies/`) references the mod under
  test. Another suite cannot load it, and should not try. To reuse a step, **copy the method** and give it the new
  suite's prefix; do not depend on the path.
- **A step text is unique per suite.** Pickle loads the steps of every active suite into one namespace, so two suites
  declaring the same text make healthy scenarios fail with "Ambiguous step". Every step listed here starts with the
  name of its suite. A copy takes its own prefix.
- **Promotion.** A step listed as *generic* moves into a tool here the day a **second** mod needs it: this index is how
  the second mod finds out the first one already wrote it. Move it, prefix it, delete the copy and its row.

To add a suite: a section with the repository, the file, and a table of *text, what it does, state, why it stays, move
it when*. State says whether the step has actually been played in a run, and which; a step that has only compiled is
written as such.

---

## Drum Bath Hygiene

Repository: `vbardales/Rimworld-Drum-Bath-Hygiene` (in the monorepo, `DrumBathHygiene/`).
Steps: `Tests/Pickle/Source/DrumBathHygieneSteps.cs`, one class, no dependency on Dubs Bad Hygiene (the hygiene need is
found by its defName and read through vanilla `Need.CurLevel`). The suite's own notes, run by run, are in
`Tests/Pickle/README.md`; the passes it needs are in `TESTING.md`.

All texts start with `Drum Bath Hygiene: `, left out of the table below.

### Generic: would move here if a second mod needs them

| Step | What it does | State | Why it stays | Move it when |
|---|---|---|---|---|
| `{string} is bored` | Sets a pawn's **Joy** need to 10 %, on **any** pawn by the name a scenario gave it (colonist nickname, single name or label), and does nothing if the pawn has no Joy need | played, run 5 | five lines, and Pickle's `{string} needs {string} is set to {int} percent` already does it for **colonists** | a suite needs it on a non-colonist. **Read the trap below first** |
| `{string} is chilled to severity {float}` | Adds **Hypothermia** at a chosen severity | played, run 5 | one hediff | a second mod needs a hediff at a severity. Generalise it to `{string} is given hediff {string} at severity {float}`: Pickle's `is given hediff` gives the def's starting severity, which a bath or a fire can remove before the first tick |
| `{string} hygiene rose`, `did not rise`, `is above {float}`, `is below {float}`, and `I remember {string} hygiene` | Read the **Hygiene** need level (0 to 1) and compare it with a remembered one. `rose` needs a margin of 0.02, because Dubs Bad Hygiene moves the need by itself | `rose`, `did not rise`, `is above` and `I remember` played, run 5; **`is below` is defined and used by no scenario** | hard-coded to the `Hygiene` need def | any other need. **Pickle ships `needs {string} is below {int} percent` and no `is above`**, and no rise/remember for needs: this is a gap of Pickle's, so it is a candidate for `Upstream/PENDING.md` rather than for a tool |
| `{string} has a hygiene need`, `has no hygiene need`, `loses the hygiene need` | Assert the need is there or absent; the last removes it from the pawn's need list, to reach the branch of a mod that has to cope with a pawn lacking it | `has no …` played, run 5; **`has a …` is defined and used by no scenario**; `loses …` **written, not yet played** | need def hard-coded | any other need def |
| `{string} is carrying filth`, `carries filth`, `carries no filth` | Give a pawn `Filth_Dirt` through its filth tracker, and read `Pawn_FilthTracker.CarriedFilthListForReading` | played, run 5 | three small steps | a second mod touches carried filth |

### Dedicated: only make sense with MMDrumcanMOD

| Step | What it does | State |
|---|---|---|
| `a drum bath stands at x={int} z={int}` | Spawns the `DrumBath` building made of Steel. It arrives lit, as a built one does | played, run 5 |
| `the drum at x={int} z={int} is burning` / `has burnt out` | Fills or drains its `CompRefuelable`, the thing the drum mod's own fuel reading looks at | played, run 5 |
| `{string} climbs into the drum at x={int} z={int}` | **Teleports** a pawn onto the drum's cell. For scenarios that give the hediff by hand and want the component isolated from pathing | played, run 5 |
| `{string} is ordered to bathe in the drum at x={int} z={int}` | Orders the drum mod's **real job**, `Job_BathingAtDrumBath`, so its driver walks the pawn over, places them and applies the hediff | played, run 5 |
| `{string} is bathing in the drum at x={int} z={int}` | Waits up to 90 s for the job to be running, the hediff on the pawn, and the pawn standing on the drum. **On timeout it reports a job trace**: every change of job with position and hediff, the driver, whether the drum is reachable, the pawn's state | played in run 5, **then changed** (it used to demand `CurJob.targetA.Thing == drum`, which the driver rewrites); the changed one is **not yet played** |
| `the bathing hediff of {string} carries the component` | Asserts the loaded `Hed_BathingAtDrumBathPassive` is a `HediffWithComps` carrying this mod's comp | played, run 5 |

Only the last is specific to this mod; the others are specific to the drum mod and would serve any mod that patches
its bath.

### Traps met while writing them

These cost runs, and none of them is specific to a drum:

1. **`ctx.AssertEventually(...)` returns a `Task`.** A `void` step that calls it and drops the result never waits and
   can never fail. Three runs went green over it. A step that waits is `async Task` with `await ctx.WaitUntil(...)`,
   then `ctx.Assert(...)`, as AnimaSong's are.
2. **`WaitUntil` throws on timeout, before your message can run.** Catch it and `Assert` with the evidence: a bare
   timeout says nothing, and a run costs a ticket in the queue. The trace in `is bathing` is the pattern.
3. **A test colonist arrives with joy full.** A real joy job ends at once through `JoyUtility.JoyTickCheckEnd`
   and removes what it added. Set Joy low before ordering one. (AnimaSong met the same.)
4. **A colonist left free at low hygiene is given a job of its own** by Dubs Bad Hygiene one tick later. A pawn
   teleported into place has to be drafted, or every reading depends on something else.
5. **Pickle's own pawn steps find colonists by nickname only.** `is given hediff` on an animal fails with "no pawn
   nicknamed …". Resolve the name yourself, as `PawnNamed` does.
6. **A `@review` scenario that is green has shown nothing.** Assert the state right before the shot, and film it if a
   still cannot say why it looks wrong.
