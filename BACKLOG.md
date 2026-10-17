# Backlog

Ideas for this repository's tools, not yet started. Moved here from protocols repository's `BACKLOG.md` on 2026-10-10.

## A sound at the end of a Pickle run

Proposed 2026-09-20 (owner). Short sound when Pickle run finishes, like mods that ring when RimWorld finished loading. Full run long enough (160 scenarios on 2026-09-17) that nobody stays watching window. Would be companion step mod of this repository if Pickle exposes end-of-run point; if not, upstream issue or pull request to `RimWorks/Rimworld-Pickle` (fork is `vbardales/Rimworld-Pickle`).

Not verified: whether Pickle (6.6.3 now) exposes end-of-run hook, event or result line, and whether it tells clean run from one with failures. Nothing of Pickle's assemblies read for this entry.

Before starting:
1. Read Pickle's `Docs/autorun.md`, look in its assemblies for run-finished point, then choose companion mod or upstream issue.
2. Two sounds, not one: run that passed, run with failures. Run that ends because Concord failed to start (https://github.com/ConcordLib/RimWorld/issues/1) is third case, or at least not "passed" one.
3. Check game plays sound while window in background.
4. Look at mods owner named ("ding on loading", "RimWorld is ready"; neither identified nor read) to see how they play sound at chosen moment.