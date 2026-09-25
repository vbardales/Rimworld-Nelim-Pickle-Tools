# Load audit - Pickle steps (optional)

Two Pickle steps for the criterion every mod shares, "the load is clean": nothing wrong in the game's log that comes from the mod. It is
what a suite otherwise does by hand with `no errors were logged`, which does not say which mod an error comes from, does not cover a
definition that does not resolve, and does not see a missing translation. Optional companion: nothing runs unless a scenario asks for
it, nothing in Pickle changes, and it is **not part of the aggregate bundle**.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the load of the mod {string} is clean` | `{string}` is the mod's packageId. Reads the game log **from the start of the game to now** and fails, listing the lines, when it holds what the four checks below find; also compares the mod's keyed translations with the active language. Attaches `load-audit`, a line saying what was read |
| `Nelim's Pickle Tools: the load of the mod {string} is clean, apart from {string}` | The same, leaving out every message whose text or stack contains the second text (ignoring case): a known message the owner justifies. Say why in the feature, next to the step |

## What it checks

1. **An error, an exception or a warning that belongs to the mod.** A message belongs to the mod when the game's logger tagged it
   `Mod.<packageId>` (Pickle's runs carry RimWorks.RimLogging, which tags the messages), when a frame of its stack is a type of the
   mod's assemblies, or when its text names one of the mod's assemblies. Errors and warnings are findings; the mod's own info messages are not.
2. **A definition or a reference that does not resolve.** The game's own texts (`Could not resolve cross-reference`, `Config error in`,
   `Faulty MayRequire`, `Duplicate def`) count when one of the mod's defs is in the message, or when the message belongs to the mod as above.
3. **A translation missing from the active language.** The game logs no missing key, it returns the key, so the log cannot say. The
   step reads the data instead: every keyed string the mod defines in the default language that the active language has not (or has
   as a placeholder), and the errors the active language recorded in the mod's files. With the default language active there is nothing to compare.
4. **The same message five or more times** from the mod (its numbers taken out, so `pawn 3` and `pawn 4` are the same message). Five is a choice: the
   game's own debug log groups repeats for the same reason, and a message that fires once per tick would show at 5 as at 500. It is the
   constant `LoadLog.RepeatThreshold`.

The game's words in the log are constants of its code, not translations, so nothing here depends on the language of the pass.

## What it does not prove

- **A key that is never displayed.** Check 3 compares keys the mod defines; a key the code builds at run time, a key missing from the
  default language too, and def injections (`DefInjected`) are not seen. It shows nothing about what is on screen.
- **A def that is never loaded, a code path that never runs.** It reads what the log holds; a mod whose faulty code was not reached passes.
- **A message that comes from the mod but carries none of its marks** (the logger did not tag it, no frame of its stack is in its assemblies,
  and it names no def) is not attributed to it. Errors from a Harmony patch of the mod are tagged only if the game's logger says so.
- **The log as it stands.** It is read when the step runs: what the game has not written yet is not in it, and it holds **the whole run**,
  including the scenarios that came before in the same process (Pickle fails those on an error of their own anyway).
- **That a warning is a defect.** A mod's own warnings are findings; a mod that logs a benign warning is set aside with the `apart from` variant.
- **A negative control in game.** The scenario that plays it audits the tool's own mod, which logs nothing: a positive control. The failing side is
  proved by the unit tests on sample log lines.

## Using it from a suite

```
nelim.pickletools.loadaudit   path:PickleTools/LoadAudit/Mod
```

in the suite's pass map, and tag the feature `@requires:nelim.pickletools.loadaudit`:

```gherkin
Given the save "test-colony" is loaded
Then Nelim's Pickle Tools: the load of the mod "nelim.manyhappyreturns" is clean
Then Nelim's Pickle Tools: the load of the mod "nelim.manyhappyreturns" is clean, apart from "SteamAPI.Init() failed"
```

Put it at the end of the scenario, after the steps that open the screens: what the mod logs when it is used is in the log by then.

## Tests

- `Tests/` (xunit, net8.0, no game): the reading of the log, the four checks, the failing cases, the threshold, the `apart from` variant.
  `dotnet test` in `LoadAudit/Tests`.
- `Check-Steps.ps1`: the patterns compile with Pickle's own engine, none is declared twice or ambiguous.
- In game: `Tests/Pickle/.../pickletools-loadaudit.feature`, pass map `wsl-deps.loadaudit.map`. **Played once, 2026-09-25, in English: 1 of 1.** It audited the tool's own mod: the step
  read the game log (314 lines, through `Application.consoleLogPath`), found no finding, and had no translation to compare (English active). That mod has **0 types and 0 defs** (the game does not
  load an assembly from `Pickle/Assemblies/`; Pickle does), so this run showed neither the reading of a mod's assemblies and defs nor the failing side.
- **Played on a real mod by another suite, 2026-09-25 (Many Happy Returns, first real run):** the attachment read `542 log lines read, 14 types, 6 defs; 1 finding(s), 0 translation problem(s)`. So the profile
  of assemblies and defs works on a mod with code, and **the failing side was seen**: the step reported `[warning] line 63: Mod Many Happy Returns - Pickle tests dependency (nelim.manyhappyreturns) needs to have
  <downloadUrl> and/or <steamWorkshopUrl> specified`, a real warning (a test dependency with no URL), which the suite then fixed at the source. The `Mod X did not load any content` lines of mods without content
  did not trigger it, as documented. Two things that run showed, to know:
  1. **The warning was attributed because its text names the mod's assembly**, and it was about the mod's *test companion*, which it named by its display name. The mod under test is therefore blamed for a defect of
     the companion that stages it: defensible, since the warning comes from the mod's own test setup, but it can surprise. Read the line before fixing the wrong mod.
  2. **Attribution by a word of the message is coarse**: a message that names an assembly of the mod, whoever logged it, is the mod's. A companion or another mod that mentions it will be attributed to it.
## Build

```powershell
dotnet build LoadAudit/Source/Nelim.PickleTools.LoadAudit.csproj -c Release   # net48, output in Mod/Pickle/Assemblies
```

Intermediates go to `LoadAudit/.build/`, never inside `Mod/`, since the staging copies `Mod/` verbatim.
