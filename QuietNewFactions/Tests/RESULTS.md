# Test results — 2026-09-20

## Replay from PickleTools — 2026-09-22

The migrated companion was staged as `PickleTools/QuietNewFactions` through the shared WSL launcher,
with `wsl-deps.pickletools.map`. **5 scenarios passed, 0 failed, 0 skipped** (`exitReason: passed`).
The staged set loaded Harmony, the six Ludeon packages, RimLogging, Pickle, VEF, `VefFactionSteps`,
`nelim.quietnewfactions` and its Pickle companion. The result reports are retained in
`reports/2026-09-22-pickletools/`.

This validates this optional companion from its new path. It does not validate a Windows playthrough,
a large mod list, or the aggregate `nelim.pickletools` Workshop payload.

Revision base: `5063516`, the commit that added `Tests/BehaviorTests` and removed the patch
scenario from the Pickle suite. Shipped `Mod/Assemblies/QuietNewFactions.dll` unchanged since
its first build.

Shipped DLL SHA-256: `FC90E93EBCE84F7B414687768773BFA28AC1591D97341F5B750F4BC0E054AA4C`.

## Executed

- `pwsh Tests/Run-Behavior.ps1`: **6 checks passed** against the shipped DLL, the installed
  RimWorld 1.6.4871 assemblies and VEF's `VEF.dll`. Any failed check throws, so the command
  fails rather than reporting a green run.
- Pickle suite, headless, on the WSL copy of the game: **5 scenarios, 5 passed, 0 failed,
  0 skipped**. Report kept in `Tests/reports/`.
  ```
  xvfb-run -a -s "-screen 0 1920x1080x24" ./RimWorldLinux \
    -pickle-run="Quiet New Factions - Pickle tests" -pickle-no-browser \
    -pickle-report-dir=<out> -logfile <out>/Player.log
  ```
  Mod list for that run, written by `scripts/stage-pickle-wsl.sh QuietNewFactions`: Harmony,
  the six Ludeon packages, RimLogging, Pickle, VEF, the mod, its test companion. Nothing else.

| Check | Observed result |
| --- | --- |
| The patch lands (unit) | `Harmony.PatchAll` on the shipped assembly puts `nelim.quietnewfactions` in `OpenDialog`'s owners; the patch is a prefix, and the mod adds no postfix or transpiler to that method. |
| The prefix still fits VEF (unit) | Returns `bool`, takes `IEnumerator<FactionDef>` and `FactionDef` — the two parameters `Dialog_NewFactionSpawning.OpenDialog` declares. A signature drift on VEF's side fails here, in a second, instead of in a game. |
| The mod loads after VEF (Pickle) | Load order holds on a list where both are active. |
| A fixture load opens no window (Pickle) | Loading `test-colony` on a mod list it was not built with leaves the window stack empty. |
| VEF's check ignores instead of asking (Pickle) | The chosen faction lands on VEF's ignored list, one log line per faction, no window, no errors logged. |
| The choice survives a save (Pickle) | After save and reload the faction is still ignored and nothing is asked again. |
| A required faction is left alone (Pickle) | With `forcePlayerToAddFactionIfMissing` set, VEF's own window opens and nothing is ignored. |

Factions actually ignored during the run, from the log: `OutlanderRough (Core)`,
`TribeRough (Core)`, `TribeSavage (Core)`, `Pirate (Core)`, `TribeCannibal (Ideology)`.

## Headless environment boundaries

`Tests/BehaviorTests` runs under .NET 8, not Unity's Mono, and applies the patch itself through
`PatchAll`. It proves that the attributes resolve and that Harmony accepts the patch on the
method VEF opens its window from — not that a real load reaches that code. That part is what the
Pickle scenarios cover, by making VEF run its own check.

The Pickle run used the WSL copy of RimWorld (`~/rimworld`, steamcmd). The Windows install, its
configuration and its mod list were not touched.

## Known noise

`Mod Quiet New Factions - Pickle tests did not load any content` — **fixed, and gone from the
log.** Run of 2026-09-21 on the WSL copy: 5 scenarios, 5 passed, and `did not load any content`
appears zero times. So does `[ERROR]` — the whole run logs none.

It mattered more than its wording suggests: three of the five scenarios assert `no errors were
logged`, so the suite was writing an error into the very log it reads back looking for errors.

`LoadedModManager.LoadModContent` logs it for any active mod whose `ModContentPack
.AnyContentLoaded()` is false. That method is satisfied by a loaded texture, audio clip,
`Strings/` entry, assembly, asset bundle, a `Patches/` operation, a Def — or, through
`AnyTranslationsLoaded()`, *any file at all* under a `Languages/` folder:

```csharp
if (Directory.Exists(path) && Directory.EnumerateFiles(path, "*", SearchOption.AllDirectories).Any())
    return true;
```

The companion ships only `About/`, feature files and a steps assembly under `Pickle/`. RimWorld
loads none of those itself — Pickle does — so none of them count.

Every other way to satisfy the check puts something into a running game. `Tests/Pickle/Mod/
Languages/README.md` puts nothing anywhere: `LanguageDatabase.InitAllMetadata` and
`LoadedLanguage.AllDirectories` both enumerate *directories* under `Languages/`
(`SearchOption.TopDirectoryOnly`), never loose files, so it is never opened, never parsed, and no
translation key enters any database. The file says so, and says not to add a language subfolder.

The report above was checked to be this suite's own before it was read: its `Player.log` carries
`-pickle-run=Quiet New Factions - Pickle tests`. That check is not ceremony. Pickle writes into
one report folder shared by every suite on the machine, and three earlier attempts that day wrote
no report at all — two killed by a `SIGSEGV` before RimWorld opened its log, one refused by the
staging script. Each time the folder still held another mod's report, with another mod's
scenarios, ready to be read as this one's result.

### The same defect in the sibling companions

Every Pickle companion in the monorepo has it. `Tests/Pickle/Mod/` holds only `About/` and
`Pickle/` in each. Three are confirmed from real logs rather than folder listings:

| Companion | Evidence |
| --- | --- |
| Work Studio | run of 22:53, `Player.log` line 54 |
| TechLevelFixes | `pickle-reports-archive/0920-2304/Player.log` |
| Architect Studio | run of 23:05, `Player.log` line 54 |
| SkillIcons | folder layout only |
| Quiet New Factions | fixed here |

The one-file fix transfers as is. None of the others were changed.

## Not verified here

- In-game verification by a person (`done → tested`): interface in FR and EN, behaviour on an
  existing save of a real playthrough, and the mod's own settings — it has none.
- Behaviour on a large mod list. An earlier attempt on the Windows list failed on
  `no errors were logged`, from an unrelated `ReflectionOnly` error raised at every fixture load
  by one of Prepatcher, PurePatcher or Dubs Performance Analyzer; Dubs was ruled out by
  disabling it, the other two were not separated. That error does not appear on the list above.
