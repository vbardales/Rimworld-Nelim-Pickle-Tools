# Backlog

Ideas for this repository's tools, not yet started. Moved here from the protocols repository's `BACKLOG.md` on 2026-10-10.

## A sound at the end of a Pickle run

Proposed 2026-09-20 (owner). A short sound when a Pickle run finishes, in the spirit of the mods that ring when RimWorld has finished loading. A full run takes long enough (160 scenarios on 2026-09-17) that nobody stays looking at the window. It would be a companion step mod of this repository if Pickle exposes an end-of-run point; if it does not, an upstream issue or pull request to `RimWorks/Rimworld-Pickle` (the fork is `vbardales/Rimworld-Pickle`).

Not verified: whether Pickle (6.6.3 now) exposes an end-of-run hook, event or result line, and whether it tells a clean run from one with failures. Nothing of Pickle's assemblies was read for this entry.

Before starting:
1. Read Pickle's `Docs/autorun.md` and look in its assemblies for a run-finished point, then choose between a companion mod and an upstream issue.
2. Two sounds, not one: a run that passed and a run with failures. A run that ends because Concord failed to start (https://github.com/ConcordLib/RimWorld/issues/1) is a third case, or at least not the "passed" one.
3. Check that the game plays sound while its window is in the background.
4. Look at the mods the owner named ("ding on loading", "RimWorld is ready"; neither identified nor read) to see how they play a sound at a chosen moment.
