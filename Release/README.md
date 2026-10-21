# Release

## Notice required in GitHub release notes and the Workshop description

Some utilities have been submitted upstream to Pickle. If integrated and released with equivalent
functionality in a supported Pickle version, those utilities will be removed from PickleTools in favor
of the upstream implementation. This does not imply acceptance or retirement of the entire bundle.
Verify and link the relevant submissions using `Upstream/PENDING.md` before publication. Each removal
must document the minimum Pickle version and migration of step names, feature requirements and pass maps.
A merge alone is insufficient if the change is not shipped or does not cover the local variants.

## The committed payload

The publish workflow uploads `Mod/` exactly as committed and has no build step (a DLL built on the runner differed from the tested
one in another mod). So `Mod/Pickle/Assemblies` holds the fourteen tool DLLs, each a byte-for-byte copy of the DLL tracked in its
tool's `Mod/Pickle/Assemblies` (the one the tests played):

```powershell
powershell.exe -ExecutionPolicy Bypass -File PickleTools/Release/Sync-Payload.ps1 -SyncMod   # copy them, and ATTRIBUTION.md, into Mod/
powershell.exe -ExecutionPolicy Bypass -File PickleTools/Release/Sync-Payload.ps1 -Check     # before every release: exit 1 on any difference
```

`-Check` also runs `docs/Generate-Steps.ps1 -Check` (the step catalogue must be current). The local build check is `scripts/Build-Mod.ps1` of the protocols, one tool at a time (`-Mod PickleTools -Project <Tool>/Source/<X>.csproj`): the package references float, so a rebuild is not byte-identical to the tracked DLL and is never the gate; the gate is the hash comparison of `-Check`. Rebuilding a tool means committing its new DLL in the tool's folder first, then `-SyncMod`. Keep `Source/`, `.build/` and any evidence out of `Mod/`.

## Distribution

One GitHub release and **one Steam Workshop item**.
The bundle is `nelim.pickletools`, with fourteen modules in `Pickle/Assemblies`. Pickle is its only direct
hard dependency. RIMMSQOL and other targets of particular tests stay optional, including in Steam's
required-items list. RIMMSQOL scenarios require `@requires:MalteSchulze.RIMMSqol`; VEF faction scenarios
require `@requires:OskarPotocki.VanillaFactionsExpanded.Core`.

Pickle scans the root Pickle directory directly, not conditional RimWorld load folders. The RIMMSQOL
bridge has presence guards, including teardown; startup/reflection/JIT without RIMMSQOL still requires
the minimal runtime pass in [TESTING.md](../TESTING.md). Do not claim conditional DLL loading.

The repository holds the aggregate `Mod` plus separate `<Tool>/Mod` development companions.
Never activate the aggregate and individual companions together: they duplicate the same steps.
For the bundle, use `nelim.pickletools path:PickleTools/Mod` after cloning the repository and change
feature requirements to `@requires:nelim.pickletools`, plus the actual optional target requirements.
Standalone packageIds are not aliases supplied by the bundle. Migrate tags and maps together.

Quiet New Factions is an optional companion, outside the Workshop aggregate (it requires VEF and Harmony, so it is never merged into the payload). ScreenshotStudio has no separate archive.

## Publication

The CI/CD owns everything after the payload: the checks of `.github/publish.config.json` (`requirePaths`, `forbidPaths`, Preview, description), the change note, the tag, the GitHub release and the Steam upload (`Rimworld-Release-Admin/docs/OPERATIONS.md`, `PUBLISHING-CI.md`). Nothing is packaged locally.

Before publication: complete the ordered PUBLISHING.md audit, review presentation, run the aggregate minimal/integration probes and `Sync-Payload.ps1 -Check`. The Workshop item is `3806142401`; `About/PublishedFileId.txt` stays in `Mod/` so an update cannot create a duplicate item.
