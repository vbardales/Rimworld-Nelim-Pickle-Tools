# Pending at Pickle

State as last seen, 2026-09-21. A row says what was actually done, not what is hoped.

| Item | Upstream | State | Proof | Next |
|---|---|---|---|---|
| `no warnings from mod {string}` compared the packageId to a display name and passed vacuously; plus the positive step `a warning from mod {string} was logged` | issue #27, PR #28 | PR open | `warning-steps.feature` played in the headless WSL install, 5 scenarios, 5 passed; `dotnet test` green; step docs check clean | wait for review |
| Dashboard translated with no active language (NRE) and a snapshot guard | PR #22 | PR open; local branch diverged from the rewritten remote one | its language scenario is still `@wip`: two earlier runs failed for reasons of my own test (reference comparison of `LoadedLanguage`, then an empty language list at the first scenario). A rerun on the fixed build is queued | prove the scenario on a fixed and an unfixed build, then decide: remove `@wip` or remove the scenario. Rebase onto the remote branch before any push |
| `-pickle-fail-fast`: stop at the first failed scenario, report the rest as skipped, exit 1 | none yet | patch `0001`, compiled, **never played** | `tests/fail-fast-probe.feature` (pass, fail, pass) run with and without the flag: two runs queued | play both; expect 1 passed, 1 failed, 1 skipped against 2 passed and 1 failed. Then an issue first, not a PR |
| `-pickle-include-wip` "truncates a run to its first feature" | issue #26 | diagnosis **retracted** by its author: the run measured had been frozen by the machine sleeping | AUDIT.md lines on the signs of a sleep freeze | close when Virginie says so |
| A step for errors logged since startup (`no errors were logged` only covers the scenario) | none | idea, from the Flavor Text Extended session | its Player.log shows a load-time `[ERROR]` while that step passes; Pickle itself logs "N error(s) were logged outside any scenario and failed nothing" | read `LogWatch` to see whether it keeps errors from before it is armed |
| Wait until a tag's rect has stood still for N frames before clicking | none | idea, optional | WorkStudio's Work Tab case: the button moved between press and release, so no click counted | Work Studio already solved it locally (`WaitForButtonToSettle`). Virginie decides whether it earns an issue |
| Tag rect recorded 773 px off for `btn:Work types...` | none | **closed, not a defect** | trace build: Pickle's and the probe's raw and converted rects agreed frame by frame; the layout changed mid-click | nothing |

## Not here

Recording unnamed controls (`ButtonImage`, `ButtonInvisible`, `Checkbox`) so a click lost to one can be
explained: a design choice for upstream, raised once as a suspicion for the Work Tab case and not supported by
that case's numbers. It stays a possible issue for Virginie to decide.
