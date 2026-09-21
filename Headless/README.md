# Running a Pickle suite without taking her screen

> **Where this lives.** This is the guide to testing a mod in the headless WSL install. It sits in PickleTools because it
> is Pickle tooling; the SCRIPTS it describes (`Run-PickleWsl.ps1`, `stage-pickle-wsl.sh`, `run-pickle-wsl.sh`,
> `stop-game-wsl.sh`, `Pickle-Status.ps1`, `Pickle-Reserve.ps1`, `Use-Wsl.ps1`, `download-workshop-wsl.sh`) still live in the
> monorepo's `scripts/`. Every `scripts/...` path below is relative to the monorepo root, `Documents\rimworld`.

A second RimWorld lives in WSL2, at `~/rimworld`: the Linux depot, downloaded with steamcmd, with
Core and the five DLC. A suite runs there under Xvfb — real rendering, real clicks, real
screenshots — while she keeps using the machine. The Windows install is hers and no session ever
launches it, `Tests/Pickle/Run-Pickle.ps1 -Launch` included, which refuses.

## Running one

`powershell.exe`, not `pwsh`: PowerShell 7 is not installed here, and a session following a
`pwsh` line gets "pwsh n est pas reconnu" before anything else happens. Nothing here needs 7.

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod SkillIcons
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod ArchitectStudio -Language French -IncludeWip
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod SkillIcons -Filter '::changed values'
```

This is the only entry point. It takes the machine lock, archives the previous report, stages,
launches under `xvfb-run`, and releases the lock in a `finally`.

| Option | Effect |
|---|---|
| `-Mod` | The mod whose `Tests/Pickle/` suite runs. `--list` on the staging script names them |
| `-Filter` | A Pickle filter. Default: the companion mod's display name, read from its About.xml |
| `-Language` | A prefix — `English`, `French`, `German`. Resolved against the install, see below |
| `-Then` | More filters, played after `-Filter`: one game launch each, under one hold of the lock. A restart test is `-Filter write.feature -Then read.feature` |
| `-IncludeWip` | Play `@wip` scenarios too, see below |
| `-KeepArchives` | Dated report archives kept, 5 by default; older ones removed, hand-named ones never |
| `-PickleSrc` | A locally built Pickle mod folder instead of the Workshop copy |
| `-Extra` | Extra Pickle flags, e.g. `-pickle-no-http` |
| `-RunTimeoutMinutes` | Pickle's own deadline, 45 by default |
| `-StallMinutes` | Kill a start that never finishes, 5 by default |

Exit codes: Pickle's own 0/1/2, then 3 stalled, 4 reserved, 5 (in `Run-Pickle.ps1`) the Windows
launch is refused, 6 the game relaunched under a held lock.

## The lock is about the machine, not about RimWorld

What the lock protects is **occupancy of the WSL machine**, not a game. A build, a steamcmd
download, a long copy into `~/rimworld` - anything that would disturb a run, or be disturbed by
one - belongs under the same lock, and under the same queue.

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Use-Wsl.ps1 -Reason 'build Pickle' -Command 'cd ~/pickle && dotnet build'
```

It queues, takes the lock, runs the command in WSL, and releases - writing `LOCK`, `WORK` and
`UNLOCK` to the shared log like a run does. The lock file is still named
`rimworld-pickle-run.lock` for the sessions and scripts that already read it by that name; the
name is historical, its meaning is the machine.

## Hard dependencies the shared table does not know

The staging places a mod's hard dependencies from its About.xml, and it needs each one's Workshop
id. The table in the script knows six (Harmony, Pickle, RimLogging, VFE Core, VE Skills, Alpha
Skills). Any other hard dependency - a framework, a library - has to be named somewhere, and the
per-pass maps are **not read in the bare pass**, so without another place the bare pass was
impossible for such a mod: it stopped with `no Workshop id known for ...`.

`<Mod>/Tests/Pickle/wsl-ids.map` is that place. It is read in **every** pass, the bare one
included, and it only *resolves*: one `packageId workshopId` per line, and nothing on it is
activated. What gets activated stays what About.xml declares, plus what a named pass adds.

```
# TailorMadeWaistlines/Tests/Pickle/wsl-ids.map
astryl.tailormade   3756915448
```

Do not name a map for the bare pass to carry these. Three suites did, and it mislabels the pass
and stages the dependency twice. An id put here does no harm if it is never needed.

## A pass can carry a settings file

A mod whose defaults are only created when its settings file is *read* behaves differently on a
clean profile than for a player who has ever opened its options. AB's Visible Pants builds its
five categories in `ExposeData`, so with no file it is installed and **inert**: nothing is drawn,
and a pass naming it as an optional reports green for a mod that never ran.

Put the file in `<Mod>/Tests/Pickle/config/<pass>/`, named as the game names it:

```
TailorMadeWaistlines/Tests/Pickle/config/wdi-ab/Mod_2986402536_ABsVisiblePantsMod.xml
```

`<pass>` is the pass name: `wdi-ab` for `-DepMap wsl-deps.wdi-ab.map`, `sans-facultatifs` for none.
Only the pass that names the mod carries its file, so the bare pass stays bare. The staging copies
it into the profile and **removes it at the next staging** - the Config folder is not wiped
between passes, so without that a seed would leak into whichever mod is staged next.

Two refusals, so a seed cannot be inert in silence either: its name must be
`Mod_<folder>_<Class>.xml` with `<folder>` a staged mod's folder (a Workshop dependency's folder is
its Workshop id), and it must be well-formed XML. The seed decides the outcome of the pass, so the
mod's `TESTING.md` should say what it contains and where it came from.

## One mod, several passes

A mod is not validated by one run. The sets live in the mod's `Tests/Pickle/` as
`wsl-deps.<name>.map`, and `-DepMap` picks one:

```powershell
... -File scripts/Run-PickleWsl.ps1 -Mod SkillIcons                                  # sans-facultatifs
... -File scripts/Run-PickleWsl.ps1 -Mod SkillIcons -DepMap wsl-deps.avec-oracle.map
... -File scripts/Run-PickleWsl.ps1 -Mod SkillIcons -DepMap wsl-deps.incompat-x.map
```

The set name is engraved in the report by `-pickle-set-name`, so two passes can be compared with
`merge-reports.py` instead of one replacing the meaning of the other. Without `-DepMap` the pass
is called `sans-facultatifs`.

The third kind is the one people forget: a pass **with a mod declared incompatible**, to go and
look at whether the incompatibility is still true. An `incompatibleWith` ages - the other mod can
be fixed, rewritten, or stop patching what it patched - and one never replayed forbids a
coexistence that might work, which costs players both mods for nothing.

Write those scenarios so that **green still means passed**. Assert the documented symptom rather
than expecting a red: `an error matching "..." was logged`, `mod "..." is not loaded` (which
proves a conflict guard fired), `no def "..." was patched`, with `@allow-errors` so the expected
error does not fail the scenario by itself. A suite where some reds are wanted and others are not
cannot be read at a glance, and that is the only way anyone reads a suite.

## Waiting your turn

A run that finds the machine busy joins a queue rather than being refused: a ticket named after
the time it was taken lands in `%LOCALAPPDATA%\rimworld-pickle-queue`, and the oldest live ticket
goes first. Polling was not fairness - whoever retried in the right second won, and a session
retrying every two minutes could wait behind one retrying every thirty seconds forever. A ticket whose owning process is gone is ignored and removed by the next session to look, and one
older than `-TicketStaleMinutes` (120) is treated as dead whatever its pid says, since Windows
reuses pids and a dead session could otherwise hold the queue under a stranger process. `-NoWait` keeps
the old behaviour (refuse at once), `-MaxWaitMinutes` gives up rather than queue forever, exit 7.
Her reservation still outranks the whole queue.

`-IncludeWip` plays the `@wip` scenarios too. Pair it with `-Filter` when you can, so the run stays on
the feature you mean:

```powershell
... -File scripts/Run-PickleWsl.ps1 -Mod ArchitectStudio -Filter '13-without-optional-mods.feature' -IncludeWip
```

The launcher used to refuse the flag without a filter, on the strength of RimWorks/Rimworld-Pickle#26
("truncates a run to its first feature and reports passed"). That diagnosis was wrong: the run it rested on
was frozen by the machine going to sleep, and Pickle's watchdog, counting real time, killed it on waking.
`run finished` is written once per feature, so a run cut short shows one line where a full one shows one
per feature. See AUDIT.md for the signs that tell a sleep freeze from a defect.

## The machine stays awake, and the archive stays small

While it holds the lock, the launcher asks Windows not to sleep (`SetThreadExecutionState`,
`ES_SYSTEM_REQUIRED`) and gives that back in its `finally`. Whether modern standby honours the request is
not verified: if a report ever shows a multi-hour hole in `Player.log`, suspect the sleep before the code.

What the machine's own log says so far (2026-09-21, this laptop is S0 modern standby, `powercfg /a`), read
from `Microsoft-Windows-Kernel-Power` events 506/507 (`Get-WinEvent`, no sleeping needed; the exit event
carries `SleepEntered`, `DripsResidencyInUs`, and the entry a `Reason`), against the lock in
`%LOCALAPPDATA%\rimworld-pickle-machine.log`:

- Before the fix (the guard threw, so nothing was held), a locked stretch did go to sleep: 14:22 exit,
  `SleepEntered=true`, 4 352 s in DRIPS.
- After the fix, the idle-timeout entry at 18:30:29 held while locks were taken and released by other
  sessions: the screen went off, but the exit at 18:37:08 says `SleepEntered=false`, 0 s in DRIPS, 399 s
  active. That is what the request is meant to do, and it is the only idle-timeout case seen with the fix.
- The other post-fix sleep (18:08:21, 21 min in DRIPS) was `SleepButton`, a user action, which
  `SetThreadExecutionState` never overrides. Not a counter-example, not a confirmation either.

One case is a hint, not a proof: something else on the machine could have held the request, and
`powercfg /requests` (admin) is the direct check while a run is live. Treat it as unverified until that or
a second idle-timeout case under a lock says the same.

Each launch archives the previous report, ~200 MB of screenshots. On 2026-09-21 a day and a half of runs
held 16 GB on a disk with 20 MB free. `-KeepArchives` (default 5) keeps the newest folders the launcher
named itself (`MMdd-HHmm`, optional `-n`) and removes the older ones. A folder named by hand is never
touched: to keep a report, rename its folder. An archive is a reprieve, not storage.

## A pass without a DLC, and a mod that has no Workshop id

Two more lines a pass map (`wsl-deps.<pass>.map`, chosen with `-DepMap`) understands:

```
!ludeon.rimworld.odyssey                       # this pass leaves Odyssey out
nelim.flavortextextended.fr path:FlavorText/FlavorTextExtendedFR/Mod    # a folder of the repository
```

`!<packageId>` removes one of the five DLCs from `ModsConfig.xml` for that pass. Its `Data` folder stays; the
absence from the list is what switches it off, and `knownExpansions` is unchanged so no "new expansion"
dialog greets the run. Core cannot be left out and only a DLC can be named: anything else stops the staging,
since a typo would otherwise drop nothing and prove the wrong thing. `path:<folder>` stages a mod that has no
Workshop id, relative to the repository, forward slashes, no spaces. The folder's own `packageId` must match
the one written, or the staging stops. Local mods are activated in the order of the file: put a mod's
dependencies above it. The report carries the pass name, taken from the map's file name.
Tested in a sandbox with a fake game and repository (a DLC out, two out, Core refused, a typo refused, a local
mod, a local mod with the wrong packageId); not yet seen in a real run, and whether the game really leaves the
DLC out of a loaded save is what the first real pass has to show.

`-Label` names the run in the queue and in the status (`Run-PickleWsl.ps1 ... -Label 'PR #22 language test'`).
Without it the label is the Pickle build folder and the filter, so a ticket never reads just "05".

## Two launches under one lock: a restart test

A restart is two processes, and a hand-off between them cannot cross two queue tickets: any run that
mounts the same test mod in between can erase what the first left (2026-09-21, SkillIcons: one of my
own runs did). `-Then` takes the lock once, **stages once**, and launches the game once per filter, in
order. Staging again would rewrite the config and the settings the first launch left for the second, so
the later launches skip it. A launch that does not pass ends the sequence with its own code. Each
launch's report, `Player.log` included, is kept in `pickle-reports-archive\MMdd-HHmm-seq<n>`, because the
next launch overwrites `pickle-reports`. `-Then` without `-Filter` is refused (exit 9).

Seen working on 2026-09-21: `-Filter warning-steps.feature -Then warning-steps.feature` ran two launches under
one lock, the second said it skipped the staging, both 5/5 passed, exit 0. What that shows is the mechanism, not
that a hand-off of settings survives it: that is SkillIcons' restart test to show. A stray bug of the first
version put each launch's kept report beside the archive instead of inside it (a lost backslash); fixed.

## A game that hangs at shutdown

`Stop-WslGame` sent SIGTERM only. On 2026-09-21 a game hung in its shutdown, ignored it, and outlived the
launcher for 37 minutes with the lock released: every waiter saw the WSL as busy and the queue stood
still. It now follows with SIGKILL three seconds later. If `Pickle-Status.ps1` shows the lock free, a
queue, and `WSL : run en cours`, look for that process before anything else.

The orphans of that evening had one root cause, found later the same night: the stall guard kept the hung
run's log in a folder whose name held a stray backspace character (a backslash-b written as an escape), `New-Item`
threw, and the launcher died BEFORE `Stop-WslGame`. Every stalled run left its game alive with the lock released.
The keeping is now in a `try`, and the kill no longer depends on it; kept logs go to
`pickle-reports-archive\stalled-<Mod>-MMdd-HHmm`, which the retention never touches.

A second hang, the same evening, showed that killing harder is not enough: the launcher itself can be gone
(its tool killed, its window closed) before it kills anything. A waiter now removes such a game itself
when no lock is held, a game is running, and its `Player.log` has been silent for `StallMinutes + 2`
(`ORPHAN` in the machine log). Tested on a decoy process in three situations: fresh log (kept), old
log with the lock held (kept), old log with no lock (removed).

## Where Pickle's own tooling lives

This folder is the launcher and the WSL harness. What sits ON Pickle lives in `PickleTools/` (a repository of its own,
development only): shared steps as companion mods, staged with `<packageId> path:PickleTools/<Tool>/Mod` in a pass map
(see "A pass without a DLC, and a mod that has no Workshop id" above), and `PickleTools/Upstream/`, the ledger and the
patches of what waits for a merge at Pickle. To test a patch on this machine, build it and pass the folder to
`-PickleSrc`; nothing goes to Pickle itself without Virginie's word.

## What happens to your report

Nothing is overwritten unarchived, with one exception that is now closed. Each launch copies the previous
`pickle-reports` into `pickle-reports-archive` before Pickle writes over it:

- a finished run: `MMdd-HHmm`, the folder of that run's report;
- a run that left a `Player.log` and **no report** (stalled, killed with its session, crashed): `MMdd-HHmm-nosummary`.
  Until 2026-09-21 the next launch deleted such a log unread;
- a run the stall guard killed: its log is also kept in `stalled-<Mod>-MMdd-HHmm`;
- a `-Then` sequence: one `MMdd-HHmm-seq<n>` per launch.

The launcher keeps the 5 newest `MMdd-HHmm*` folders and removes older ones. It never removes a folder named by
hand, one holding a `keep.txt`, or a `stalled-*` one. What has to outlive that (publication captures) belongs in the mod's
own repository: an archive is a reprieve, not storage. Still lost: the report of a run killed while the launcher
itself is dead and that never wrote a log, and anything older than the 5th.

## "verrou : libre" next to a running game: two views of AppData

The Claude desktop app is a packaged (MSIX) app. What its sessions write under `AppData\Local` lands
physically in `AppData\Local\Packages\Claude_*\LocalCache\Local`, and only processes inside the package see it at
the normal path. A terminal outside it reads an empty `AppData\Local`: on 2026-09-21 Virginie's
`Pickle-Status.ps1 -Watch` said `verrou : libre` for twenty minutes, with no queue, next to a running
game and 26 waiting tickets. Seen from WSL: no `rimworld-pickle-*` under the real `AppData\Local` at all,
the queue and the log under the package path.

`Pickle-Status.ps1` now reads every place a session could have written, and `Pickle-Reserve.ps1` posts
and lifts the reservation in every one. Tested on a fake split layout; not yet seen from her terminal.
If you write a script that reads the lock or the queue, use both places, or it will lie to whoever
runs it from outside.

## Looking without launching

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Pickle-Status.ps1          # -Watch to follow it
```

Four lines: the reservation, the lock and its holder, which game is running on which side, and
what the runner is doing right now, read from its own dashboard. It names a Pickle run on the
Windows install as what it is, in red, rather than calling it her game.

## Taking the machine back

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Pickle-Reserve.ps1 -Reason 'je joue'   # -Now to stop the run in flight
powershell.exe -ExecutionPolicy Bypass -File scripts/Pickle-Reserve.ps1 -Release
```

While it is posted, no session takes the lock, stages or launches: she is next, whatever was
waiting. The queue itself stays standing - a session already waiting keeps its place, its ticket
is kept fresh, and its own deadline stops running until she releases the machine. Cancelling the
queue on a reservation would punish exactly the sessions that queued properly. A run already in progress is left to write its report, because that report is the
whole point of it; `-Now` is for when the wait is worse than the loss. **Only she runs this
script.** A session never creates or removes that file.

## What a staging produces

`scripts/stage-pickle-wsl.sh <Mod>` wipes `~/rimworld/Mods` and copies Harmony, RimLogging,
Pickle, the hard dependencies declared in the mod's About.xml, the mod, and its `.pickletests`
companion. It then writes a `ModsConfig.xml` and a `Prefs.xml` of its own. `loadAfter` mods are
not copied: a suite must not depend on them, and their absence is what makes a screenshot clean.

One process runs one mod set, so staging is destructive by design, and the lock covers it as much
as the launch: it refuses without `--lock-held` when the lock is taken.

A suite that needs to assert against mods the mod does not depend on — a mod whose whole job is
patching others declares no dependency on its targets — names them in
`<Mod>/Tests/Pickle/wsl-deps.map`, one `packageId workshopId` per line. Those are staged and
activated. Prefix a line with `first:` to load it ahead of Harmony.

## Traps this harness was built out of

- **The lock is invisible from WSL.** A file held open by its owner does not even appear in a
  listing through DrvFs. A guard on the Linux side must ask Windows, and refuse on "cannot tell".
- **A growing log is not a run that advances.** A game that relaunches inside a held lock keeps
  writing; that is how one run held the machine for eight hours. Hence Pickle's own deadline and
  the pid check.
- **A language must never degrade in silence.** `French (Français)` crossing PowerShell, WSLENV
  and bash arrived mangled, RimWorld fell back to English without a word, and a run reported a
  green French pass whose screenshots were English. Name a language by its ASCII prefix; the
  staging resolves the real folder, tarballs included — the game reads a `.tar` without extracting
  it — and stops if it cannot.
- **Never switch language inside a scenario.** `LanguageDatabase.SelectLanguage` does not finish
  inside the call, and every frame until it does has no active language at all. Run twice with
  `-Language` instead.
- **Pickle fails any step over five seconds.** A step that waits declares `TimeoutSeconds` on its
  attribute and waits with `ctx.WaitUntil`, or it dies with a bare timeout that names nothing.
- **The game logs in UTC.** A report's timestamps are two hours behind the machine in summer.
  Comparing them naively is how a fresh report reads as a stale one.
- **Screenshot names come from scenario titles** and reach 183 characters. Archiving goes through
  `robocopy`, because `Copy-Item` hits MAX_PATH and blames a missing path.
- **Building Pickle itself: the root `Pickle.slnx`, never `Source/Pickle.slnx`.** The latter omits
  the two backend projects, and what you get is not a missing file but `no tags recorded this
  frame` on every click - which reads exactly like Concord failing to start, so the hunt goes to
  the wrong place. Build with the .NET 10 SDK at `C:Users
elim.dotnet10dotnet.exe`: the one on
  PATH is 8 and dies on the C# 14 `field` keyword in RunnerWindow.cs. Then stage that build with
  `-PickleSrc <folder>`, which is also how a patched Pickle is A/B-tested against the Workshop copy.
- **Nothing is edited while a run is going.** Windows will not replace a `.sh` a running bash
  holds open, and a retry that is not idempotent applies a patch twice.
- **The built-in waits have their own limits, and they are not the five seconds of a custom step.** Measured on
  EponaInstrumentsRenew, 2026-09-21: `I wait N ticks` ran about 500 to 700 ticks per real second in the WSL
  install and dies with `Step 'When I wait 3500 ticks' timed out after 5s`: chain waits of about 1,800 instead.
  `I wait for bill "<recipe>" to finish` allows 120 real seconds and then trips the watchdog (`exitReason:
  watchdog-timeout`, exit 2, **no scenario written**): a craft of 65,000 work does not fit, so film the
  beginning of the work (a bill added, `a "UnfinishedSculpture" exists`) and show the finished product by a
  capture of a spawned item.
- **`I select {string}` is an exact match, not a substring.** It compares (case-insensitively) the thing's
  `LabelCap`, or a pawn's short name, so a stuffed item is `Steel uilleann pipes (normal)`: stuff and quality
  included. A miss lists the nearby candidates, which is how to learn the real label in another language.
  (`the inspect pane shows {string}`, by contrast, is a substring.) Source: `UiSteps.cs`.
- **A capture can name a thing in whatever language the pass runs in without the scenario knowing the word.**
  Centre the camera on the thing's cell (`I move the camera to (x, y)`): the pointer sits at the centre of the
  screen and the hover label at the bottom left names what is under it. One feature, run once per `-Language`,
  gives one set of captures per language to compare by eye. Nothing asserts the text; a person reads it.
- **`I spawn a "<def>" at (x, y)` works for a def made of stuff without naming one** (the game picks a default
  stuff; the label shows it). Two items one cell apart overlap if their `drawSize` is large.
- **A film is encoded by Pickle itself when `ffmpeg` is on the PATH** (`film.webm` in `screenshots/film/<feature>--<scenario>/`
  and the frames deleted); otherwise the frames stay. Copy the video out before the next run, and re-encode to
  mp4 for a viewer that does not play webm. The 3 MB full-resolution PNGs and hundreds of raw frames are not
  worth committing: keep JPEGs, a contact sheet and the mp4.
