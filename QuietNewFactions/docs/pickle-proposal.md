# Proposing this to Pickle

Posted 2026-09-20 as [RimWorks/Rimworld-Pickle#25](https://github.com/RimWorks/Rimworld-Pickle/issues/25),
asking Pickle to answer VEF's new faction window itself during a run, with this mod offered as
a reference implementation rather than as something to install. The text below is what was sent,
without this preamble.

The run behind its results is in [../Tests/RESULTS.md](../Tests/RESULTS.md).

---

**Title:** VEF's "new faction" window comes back on every fixture load — suppression drops it, but never answers it

---

### What happens

On a mod list with Vanilla Expanded Framework, VEF checks at every load whether the save is
missing a faction that an active mod provides, and opens its "new faction" window for each one
it finds. A fixture is rarely built on the exact mod list it is later replayed on, so this fires
on essentially every fixture load.

The window's *skip* button records nothing; only *ignore* is remembered, and VEF stores that in
the save. So skipping does not end it: the same window is back on the next load, and the one
after that.

### Where this meets Pickle

`AutorunDialogSuppression` already covers part of this, and its summary says what it does:

> Drops every window opened while autorun loads a fixture, so popups cannot block
> headless progress. Blanket rather than an allowlist, which would need maintaining.

Two gaps remain for this particular window:

1. **Dropping is not answering.** VEF asked a question and got no reply, so nothing is recorded
   and the check runs again at the next load. Worse, the window it opens is also what advances
   its own enumerator, one faction per dialog: dropped, the rest of the list is never walked.
2. **It is bounded to autorun loading a fixture** (`IsAutorunning && SuppressingFixtureLoad`).
   A run driven from a live game gets the window on the stack. VEF also opens it from a
   `LongEventHandler.ExecuteWhenFinished` callback queued after the load, so I am not sure it is
   still inside that window even under autorun — you would know better than I do.

Separately, #21 suppresses foreign windows for the length of a scenario, rather than only while
autorun loads a fixture. It has the same blind spot: it keeps the screen clear without ever
answering what was asked. The two fit together, and I am happy to sequence this after it, or to
fold it in.

### What I'm suggesting

That Pickle answer VEF's check with *ignore* while a run is in progress, rather than only dropping
the window it opens. Two details matter:

- **A faction its own mod marks as required** (`forcePlayerToAddFactionIfMissing`) must be left
  alone. VEF's window refuses both *skip* and *ignore* for such a faction, so answering for it
  would defeat the mod that asked for it.
- **The answer is stored by VEF in the save**, not by whoever gives it. Harmless for a fixture
  that is loaded and discarded, but a scenario that saves writes the ignore list into the fixture.
  Worth deciding deliberately, and a reason to do this only while a run is active.

One log line per ignored faction makes a run report explain itself.

### A reference implementation, if it's useful

I wrote this as a standalone mod before realising it belongs on this side of the line:
[Rimworld-Nelim-Quiet-New-Factions](https://github.com/vbardales/Rimworld-Nelim-Quiet-New-Factions)
(`nelim.quietnewfactions`, 1.6). One Harmony patch on the VEF check, plus the required-faction
exception above. Take the code, the approach, or neither — I'm happy to open a PR putting it
behind the run state, in whatever shape suits you.

It carries five Pickle scenarios of its own (`Tests/Pickle/` in that repo), including
`VEF's check ignores the faction instead of asking`, `loading the fixture leaves no window open`
and `the choice is kept in the save, and the next load asks nothing`. They port over with the code.

All five pass on 1.6 against VEF, run headless with Pickle on a minimal mod list
(Harmony, RimLogging, Pickle, VEF, the mod and its test companion): no failures, no skips.
The log shows the factions actually ignored, one line each.

If you'd rather Pickle stayed out of other mods' decisions, that's fair — in that case a line in
the docs for people running suites with VEF would still save them the hunt.
