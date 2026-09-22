# Anima Song

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
