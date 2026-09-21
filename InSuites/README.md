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

---

## Anima Song

Repository: `vbardales/Rimworld-Anima-Song` (in the monorepo, `AnimaSong/`).
Steps: `Tests/Pickle/Source/AnimaSongSteps.cs`, one class, **21 steps**, compiled to
`Tests/Pickle/Mod/Pickle/Assemblies/AnimaSong.PickleSteps.dll`. They reference `AnimaSong.dll` (the mod under test) and
read two private fields of `CompAnimaSong` by reflection. The suite's own notes, run by run, are in
`Tests/Pickle/README.md` and in `STATUS.md`; the passes are in `Tests/Pickle/wsl-deps.*.map`.

All texts start with `Anima Song: `, left out of the tables below. **Every step below was played** on 2026-09-21 in the
WSL, on the fixture's own anima tree at (70, 132), in English and in French; "played" says only that a scenario using it
ran, not that what it asserts was correct in every case.

### Generic: would move here if a second mod needs them

| Step | What it does | State | Why it stays | Move it when |
|---|---|---|---|---|
| `{string} is made deaf` | Gives a missing-body-part hediff to every body part named `Ear`, then asserts the pawn's Hearing capacity is gone | played, four runs | one hediff on a part whose defName is hard-coded | a second mod needs a pawn without a capacity. Generalise it to a capacity and the body parts that carry it |
| `{string} is ordered to listen to the tree at x={int} z={int}`, `the order offered to {string} for the tree at x={int} z={int} is available`, `... is refused because {string}` | **Drive a thing's right-click order without clicking**: call the comp's `CompFloatMenuOptions(pawn)`, expect one entry, refuse it if greyed out, run it with `Chosen(true, null)`. The refusal step compares the entry's label with the **translation of a key**, so it holds in any language. Pickle has no float-menu step (checked in its shipped step list) | played, four runs; the refusal reasons `AnimaSong_OrderForbidden`, `_OrderCannotHear`, `_OrderFull` each seen | the calls name `CompAnimaSong` | a second mod adds an order to a thing through a comp. Pass the thing and the key |
| `I select the tree at x={int} z={int}`, `I press the toggle of the selected tree`, `the toggle of the selected tree is on` / `is off` | Find a `Command_Toggle` among the selected thing's gizmos **by the translation of its label key**, read its `isActive()`, and call its `toggleAction` (the click is not simulated) | played, four runs | the select step looks for the mod's tree by defName | a second mod has a toggle gizmo. Generalise to `I press the gizmo keyed {string}` |
| `the halo of the tree at x={int} z={int} is followed tick by tick for {int} ticks` | After **every tick** for N ticks, read whether a private `Mote` field is null, destroyed or alive and how long ago the owner last pinged it; attach the distribution and assert 90 % alive. Found that the halo is alive only on the tick of a ping | played, four runs | two private fields of `CompAnimaSong` by reflection | a second mod maintains a `needsMaintenance` mote. Pass the field names |
| `the halo of the tree ... is alive` / `stays alive` | Wait up to 10 s for the field to hold a live mote; or sample it over 40 frames and ask for 90 %. **Superseded by the tick-by-tick step** as a diagnosis: a frame sampler cannot see the phase | played, four runs | same reflection | with the step above |

### Dedicated: only make sense with this mod

| Step | What it does | State |
|---|---|---|
| `the song and the toggle icon come from the loaded mods` | Reads `ModsConfig` and expects Phytokin's `VRE_AnimaSongSound` and `UI/Abilities/AnimaSong` when it is active, Royalty's `AnimaTreeLink` and ritual icon when it is not; compares the def and the texture the mod resolved | played, passes A and B |
| `the tree at x={int} z={int} carries the song comp`, `allows listening`, `forbids listening` | Read `CompAnimaSong` and its toggle on the tree at a cell | played |
| `the tree at x={int} z={int} is singing` / `is not singing` | Wait for the comp's `Singing` to become true or false | played |
| `{string} is listening to the tree at x={int} z={int}` / `is not listening ...` | The colonist's current job is `AnimaSong_Listen` on that tree, waiting up to 30 s | played |
| `{string} sits in the ring of the tree at x={int} z={int}` | Waits up to 90 s for the pawn to listen, stand still, and be 2 to 5 cells from the trunk; on failure says how far it is | played |
| `{int} listeners sit on {int} different cells around the tree at x={int} z={int}` | Waits up to 120 s for N pawns seated in the ring, asserts N are listening and on M distinct cells. The waiting is the part worth copying | played |

### Traps met while writing them

1. **A step with no timeout of its own gets the scenario's `@timeout:` tag, then five seconds.** The fixture's colonists
   stand about sixty cells from the tree, so every scenario that walks needs a tag: three scenarios failed at "sits in the
   ring" after exactly 5 s on the first run, and the three that carried a tag passed.
2. **A comma in `-Filter` is a list of terms, not one phrase.** A filter written as a sentence with a comma ran a second
   scenario as well.
3. **Where a wait returns, relative to the pawn's tick, changes from run to run.** A state read after `WaitTicks(1)` may
   come before or after that tick's work, so a mote "up on 0 of 300 ticks" and "up on 300 of 300" were the same mote.
   Read the phase (the ping age) beside the state.
4. **The Linux game renders in software and ran about 16 ticks a second.** A film asked to take one picture per tick took
   one per 1.6. A picture is not a proof of a tick.
5. **Test colonists arrive with joy full**, and a real joy job ends at once through `JoyUtility.JoyTickCheckEnd`. Set Joy low
   before ordering one, or a scenario that needs a long sitting fails for a reason that is not a fault.
