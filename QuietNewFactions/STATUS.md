---
mod:          Nelim's Quiet New Factions
packageId:    nelim.quietnewfactions
repo:         PickleTools/QuietNewFactions
visibility:   optional GitHub companion
detached:     no
stage:        done
licence:      original
dependencies: declared
tested_on:
workshop:
remaining:
  - resolved 2026-09-22: source, package, tests, historical reports and proposal moved from the former QuietNewFactions repository. The rebuilt companion was replayed from PickleTools/QuietNewFactions; the source repository is now redundant and may be deleted after this migration is pushed.
  - migrated 2026-09-22: the nine suite-owned steps moved to PickleTools/VefFactionSteps with prefixed phrases; Tests/Pickle now uses wsl-deps.pickletools.map and no longer ships source or a step DLL.
  - resolved 2026-09-22: the promoted Nelim.PickleTools.VefFactions.dll built cleanly, passed its offline expression check, and the migrated companion's five-scenario headless replay passed from PickleTools. This does not validate the aggregate Workshop bundle.
  - verified 2026-09-22: Tests/Pickle suite run headless on the WSL copy from PickleTools/QuietNewFactions, 5 scenarios passed, 0 failed, 0 skipped, exitReason passed. The report is in Tests/reports/2026-09-22-pickletools/.
  - verified 2026-09-20: Tests/Pickle suite run headless on the WSL copy, 5 scenarios, all
    passed, and Tests/BehaviorTests, 6 checks. Tests/RESULTS.md and Tests/reports/ hold them.
  - unverified: the same on a real playthrough save in the Windows game. The scenarios prove
    it on Pickle's test-colony fixture: no window, one "[Quiet New Factions]" line per faction,
    and nothing asked after a save and reload.
  - unverified: a faction a mod really marks required (forcePlayerToAddFactionIfMissing). The
    scenario sets that marker itself for its own duration, no such faction being guaranteed.
  - unverified: behaviour on a large mod list. On the Windows list an unrelated ReflectionOnly
    error at every fixture load fails the no-errors step; Dubs Performance Analyzer ruled out,
    Prepatcher and PurePatcher not separated.
updated:      2026-09-22, PickleTools absorption replay
---

# Nelim's Quiet New Factions — status

Kept beside PickleTools' aggregate `Mod/`, never inside it. The migrated companion and the shared
`VefFactionSteps` replacement were replayed in the WSL copy of the game on 2026-09-22: five scenarios
passed with no failure or skip. Neither version was run in the Windows install.
