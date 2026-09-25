# Release preparation for 1.0.0

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
powershell.exe -ExecutionPolicy Bypass -File PickleTools/Release/Prepare-Release.ps1 -SyncMod   # copy them, and ATTRIBUTION.md, into Mod/
powershell.exe -ExecutionPolicy Bypass -File PickleTools/Release/Prepare-Release.ps1 -Check     # before every release: exit 1 on any difference
```n
`-Check -Rebuild` also rebuilds each tool and lists (NOTE, never a failure) those that are not byte-identical: the package references float, so
they all were on 2026-09-25 and a rebuild is not the gate. Rebuilding a tool means committing its new DLL in the tool's folder first,
then `-SyncMod`. Keep `Source/`, `.build/` and any evidence out of `Mod/`.

## Distribution

One GitHub release and **one Steam Workshop item**; local preparation only, not published.
The bundle is `nelim.pickletools`, with fourteen modules in `Pickle/Assemblies`. Pickle is its only direct
hard dependency. RIMMSQOL and other targets of particular tests stay optional, including in Steam's
required-items list. RIMMSQOL scenarios require `@requires:MalteSchulze.RIMMSqol`; VEF faction scenarios
require `@requires:OskarPotocki.VanillaFactionsExpanded.Core`.

Pickle scans the root Pickle directory directly, not conditional RimWorld load folders. The RIMMSQOL
bridge has presence guards, including teardown; startup/reflection/JIT without RIMMSQOL still requires
the minimal runtime pass in [TESTING.md](../TESTING.md). Do not claim conditional DLL loading.

The GitHub archive supplies the aggregate `Mod` plus separate `<Tool>/Mod` development companions.
Never activate the aggregate and individual companions together: they duplicate the same steps.
For the bundle, use `nelim.pickletools path:PickleTools/Mod` after extracting the archive and change
feature requirements to `@requires:nelim.pickletools`, plus the actual optional target requirements.
Standalone packageIds are not aliases supplied by the bundle. Migrate tags and maps together.

In source checkouts, the root Mod holds metadata; the generated aggregate is under `.build/releases`.
Point a local bundle test map at that generated Mod directory. Existing per-tool source paths remain valid.
ScreenshotStudio and Quiet New Factions are optional companions, excluded from the Workshop aggregate and
default archives. Use `-IncludeScreenshotStudio` and `-IncludeQuietNewFactions` to add their separate GitHub
archives. ScreenshotStudio packaging refuses to proceed until the zen fixture and matching export evidence exist;
its DLC requirements do not affect the bundle. Quiet New Factions requires VEF and Harmony, so it must never be
merged into the aggregate payload. See the respective companion statuses for validation limits.

## Prepare

Build/check using TESTING.md, then from the collection root:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File PickleTools/Release/Prepare-Release.ps1 -Version 1.0.0
```

Each invocation produces a fresh `.build/releases/<version>-<timestamp>` containing one Workshop zip,
one GitHub zip, SHA256SUMS and a manifest with DLL hashes, source revision and dirty-tree flag.
The script packages current DLLs; it does not rebuild or certify them. Extract the Workshop zip into
one upload directory with About directly underneath. Earlier per-tool archives are superseded.

Before publication: complete the ordered PUBLISHING.md audit, review presentation and run the aggregate
minimal/integration probes. Commit the
final source, rebuild/check and regenerate before tagging. Publish one Workshop item, record its real id,
and attach the regenerated assets to the verified GitHub tag. The private Workshop item is `3806142401`;
`About/PublishedFileId.txt` must remain in every upload so an update cannot create a duplicate item.
