# Anima Song

Repository: `vbardales/Rimworld-Anima-Song` (in monorepo, `AnimaSong/`).
Steps: `Tests/Pickle/Source/AnimaSongSteps.cs`, one class, **21 steps**, compiled to
`Tests/Pickle/Mod/Pickle/Assemblies/AnimaSong.PickleSteps.dll`. Reference `AnimaSong.dll` (mod under test) and
read two private fields of `CompAnimaSong` by reflection. Suite's own notes, run by run, in
`Tests/Pickle/README.md` and `STATUS.md`; passes in `Tests/Pickle/wsl-deps.*.map`.

All texts start with `Anima Song: `, left out of tables below. **Every step below was played** on 2026-09-21 in WSL,
on fixture's own anima tree at (70, 132), in English and French; "played" only says a scenario using it
ran, not that what it asserts was correct in every case.

### Generic: would move here if a second mod needs them

| Step | What it does | State | Why it stays | Move it when |
|---|---|---|---|---|
| `{string} is made deaf` | Give missing-body-part hediff to every body part named `Ear`, then assert pawn's Hearing capacity gone | played, four runs | one hediff on part whose defName hard-coded | second mod needs pawn without a capacity. Generalise to capacity and body parts that carry it |
| `{string} is ordered to listen to the tree at x={int} z={int}`, `the order offered to {string} for the tree at x={int} z={int} is available`, `... is refused because {string}` | **Drive thing's right-click order without clicking**: call comp's `CompFloatMenuOptions(pawn)`, expect one entry, refuse if greyed out, run with `Chosen(true, null)`. Refusal step compares entry's label with **translation of a key**, so holds in any language. Pickle has no float-menu step (checked in shipped step list) | played, four runs; refusal reasons `AnimaSong_OrderForbidden`, `_OrderCannotHear`, `_OrderFull` each seen | calls name `CompAnimaSong` | second mod adds order to thing through comp. Pass thing and key |
| `I select the tree at x={int} z={int}`, `I press the toggle of the selected tree`, `the toggle of the selected tree is on` / `is off` | Find `Command_Toggle` among selected thing's gizmos **by translation of its label key**, read its `isActive()`, call its `toggleAction` (click not simulated) | played, four runs | select step looks for mod's tree by defName | second mod has toggle gizmo. Generalise to `I press the gizmo keyed {string}` |
| `the halo of the tree at x={int} z={int} is followed tick by tick for {int} ticks` | After **every tick** for N ticks, read whether private `Mote` field null, destroyed or alive and how long ago owner last pinged it; attach distribution and assert 90 % alive. Found halo alive only on tick of a ping | played, four runs | two private fields of `CompAnimaSong` by reflection | second mod maintains `needsMaintenance` mote. Pass field names |
| `the halo of the tree ... is alive` / `stays alive` | Wait up to 10 s for field to hold live mote; or sample over 40 frames and ask 90 %. **Superseded by tick-by-tick step** as diagnosis: frame sampler cannot see phase | played, four runs | same reflection | with step above |

### Dedicated: only make sense with this mod

| Step | What it does | State |
|---|---|---|
| `the song and the toggle icon come from the loaded mods` | Read `ModsConfig`, expect Phytokin's `VRE_AnimaSongSound` and `UI/Abilities/AnimaSong` when active, Royalty's `AnimaTreeLink` and ritual icon when not; compare def and texture mod resolved | played, passes A and B |
| `the tree at x={int} z={int} carries the song comp`, `allows listening`, `forbids listening` | Read `CompAnimaSong` and its toggle on tree at a cell | played |
| `the tree at x={int} z={int} is singing` / `is not singing` | Wait for comp's `Singing` to become true or false | played |
| `{string} is listening to the tree at x={int} z={int}` / `is not listening ...` | Colonist's current job is `AnimaSong_Listen` on that tree, wait up to 30 s | played |
| `{string} sits in the ring of the tree at x={int} z={int}` | Wait up to 90 s for pawn to listen, stand still, be 2 to 5 cells from trunk; on failure say how far | played |
| `{int} listeners sit on {int} different cells around the tree at x={int} z={int}` | Wait up to 120 s for N pawns seated in ring, assert N listening and on M distinct cells. Waiting is part worth copying | played |

### Traps met while writing them

1. **Step with no timeout of its own gets scenario's `@timeout:` tag, then five seconds.** Fixture's colonists
   stand about sixty cells from tree, so every scenario that walks needs a tag: three scenarios failed at "sits in the
   ring" after exactly 5 s on first run, three that carried a tag passed.
2. **Comma in `-Filter` is list of terms, not one phrase.** Filter written as sentence with comma ran a second
   scenario too.
3. **Where a wait returns, relative to pawn's tick, changes run to run.** State read after `WaitTicks(1)` may
   come before or after that tick's work, so mote "up on 0 of 300 ticks" and "up on 300 of 300" were same mote.
   Read phase (ping age) beside state.
4. **Linux game renders in software, ran about 16 ticks a second.** Film asked for one picture per tick took
   one per 1.6. Picture not proof of a tick.
5. **Test colonists arrive with joy full**, and real joy job ends at once through `JoyUtility.JoyTickCheckEnd`. Set Joy low
   before ordering one, or scenario needing long sitting fails for reason that is not a fault.