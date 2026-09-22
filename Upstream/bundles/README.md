# Bundles: play a pull request before it is merged

A bundle is a Pickle built from upstream `main` plus the pull requests you name, laid out as a mod folder
that `Run-PickleWsl.ps1 -PickleSrc` stages in place of the Workshop copy. It is how a fix is *played* in a real
game, and not only unit-tested, before anyone merges it.

| Script | What |
|---|---|
| `make-bundle.sh <name> <PR>...` | Fetch upstream, merge the named PRs, build every project the game loads, run Pickle's unit tests, lay the folder out, and check it ships the same DLLs as the Workshop build |
| `run-on-bundle.sh <folder> <filter>` | Play one filter of a mod's suite against a bundle on the headless WSL install, and keep only a report that is provably that run's |

Run from **Git Bash on Windows** (the helpers use `cygpath` and Windows executables).
Set `REPO` explicitly to the collection root rather than relying on the relative default.

```bash
cd /c/Users/nelim/Documents/rimworld/PickleTools/Upstream/bundles
export REPO=/c/Users/nelim/Documents/rimworld
export DOTNET=/c/Users/nelim/.dotnet10/dotnet.exe
./make-bundle.sh picker_bundle_23 23               # PR 23 alone
./make-bundle.sh picker_bundle_19_21 19 21         # two together
MOD=ArchitectStudio ./run-on-bundle.sh ~/pickle-bundles/out/picker_bundle_23 16-language-review.feature
```

## One bundle per PR, and one of the lot

A green run on the merge of six PRs says they hold together, not which one fixed what. Build the PR alone for
the test that is about it; build the whole merge once, for the interactions. On 2026-09-21 the two answered
different questions: PR 23 alone turned the 150% scenario green, and all six together kept two other
features green.

## What the scripts will not do

- **Resolve a code conflict.** Two changes to the same lines are a decision. A conflict in `Docs/*.md` is a
  union (two PRs each add their row to the same table); anything else stops the build and names the file. On
  2026-09-21 PRs 31 and 33 stopped on `Pickle/Features/ui-steps.feature`.
- **Touch a clone it did not make.** `make-bundle.sh` resets and runs `git clean -fdx` in its clone, so it
  refuses any folder that lacks its own marker file. Point `CLONE` at nothing you care about.
- **Read the shared report folder.** `pickle-reports` is one folder for the machine and every run overwrites it.
  `run-on-bundle.sh` keeps a report only if its `Player.log` carries this run's own `-pickle-run=`; otherwise it
  says the run wrote nothing. Waiting in the queue and then reading "the newest report" returned another
  session's suite twice in one day.

## What they cannot prove

Check report freshness, `exitReason`, expected scenario counts and captures using the
[authoring guide](../../Authoring/README.md). A matching command line alone is not a complete-run verdict.

- **That the bundle was the Pickle the game loaded.** The launcher's `override:` line is the only trace and its
  own output truncates it. The real proof is a scenario that can only pass on the patched Pickle, which is what
  the PR's regression scenario is for.
- **That a merge of PRs is what upstream will ship.** Upstream `main` moves: PRs 19 and 21 conflicted in
  `UiSteps.cs` in the morning and merged cleanly in the evening, after a rebase.

## Requirements

- A **.NET 10 SDK.** Pickle uses C# 14 and targets `net10.0` for its tests. Verify the chosen executable with
  `"$DOTNET" --version`; the default `~/.dotnet/dotnet.exe` does not guarantee its version. The
  scripts build the projects individually, targeting `net472` for the game.
- The machine lock and queue: `run-on-bundle.sh` goes through `Run-PickleWsl.ps1`, so it waits its turn, up to
  `WAIT` minutes (240 by default) and never touches a game it did not start.
- A bundle run is a launch of the WSL game like any other. Do not run one on a machine that is about to sleep:
  a frozen game is reported as a failed run.

## Measured, 2026-09-21

Played with these scripts, on the headless WSL install, against Architect Studio's suite. Recorded in
`../PENDING.md` by the session that keeps the ledger.

- PR 23 alone: `16-language-review.feature`, 3 of 3 passed, the 150% scenario included, which failed on the
  Workshop Pickle in every run of the day with `the pointer never reached`.
- PRs 19, 21, 22, 23, 28 and 31 merged: `16-language-review.feature` 3 of 3 and `02-architect-buttons.feature`
  4 of 4; unit tests 181 of 181.
- Not measured: PRs 19 and 21 alone against `02-architect-buttons.feature`. The run was killed from outside
  a minute after it started.
