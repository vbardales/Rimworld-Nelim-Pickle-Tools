# PickleTools runtime checks

This companion owns the runtime probes for the aggregate bundle and the individual utilities.
Run it with `scripts/Run-PickleWsl.ps1 -Mod PickleTools` and select a `wsl-deps.*.map` file.

The aggregate minimal probe plays the bundle committed under `PickleTools/Mod` (the mod under test; keep it in step with `Release/Sync-Payload.ps1 -SyncMod`). The maps no longer overlay a generated payload (`.build/aggregate-current`, retired 2026-09-25). The other maps stage the named development companion.
`wsl-deps.aggregate-no-biotech.map` stages the same payload with Biotech inactive; run
`aggregate-no-biotech.feature` against it to check startup and step discovery without that DLC.
`wsl-deps.aggregate-rimmsqol.map` adds optional RIMMSQOL to the aggregate payload; run
`aggregate-rimmsqol.feature` against it to exercise the bridge without changing user settings.
`aggregate-rimmsqol-settings.feature` checks a temporary choice and its after-scenario cleanup
using vanilla's normally hidden `Inspect` button. It refuses to edit an existing choice.
`lost-click-probe` is no longer a feature of this suite (deleted 2026-09-25: its probe windows leave Pickle no tag to click, see TESTING.md); `wsl-deps.lostclickprobe.map` remains for the diagnostic copy in Upstream/tests. The diagnostic copy, which fails on purpose to show the report a lost click prints, is `Upstream/tests/lost-click-probe.feature`.

**A pass that stages one tool on its own ends with the `StandaloneBase` overlay.** The staging activates the mod under test,
`PickleTools/Mod`, and since 2026-09-25 that folder carries the fourteen bundle DLLs (they are what the publish workflow uploads). A
pass that also stages `PickleTools/<Tool>/Mod` would load every step of that tool twice and Pickle would refuse the scenario as
"Ambiguous step" (seen in the first play of the hover steps, 2026-09-25). So each single-tool map ends with
`nelim.pickletools   path:PickleTools/Tests/Pickle/StandaloneBase/Mod`, an empty shell with the same packageId that takes the
bundle's place. The aggregate maps overlay the generated payload instead and need nothing.

**Bundle and standalone modules exclude each other (2026-11-11).** `About.xml` of the bundle (`nelim.pickletools`) lists its 14 standalone modules as `incompatibleWith`, and each module lists the bundle. A map that stages the bundle (a Workshop id or `path:PickleTools/Mod`) must not also stage one of the 14 (`clearscreen`, `clickdiagnostics`, `colonistrace`, `expansions`, `filmticks`, `hoversteps`, `inspecttabs`, `interfacescale`, `keyedclick`, `research`, `rimmsqol`, `screenshotmode`, `textureowner`, `veffactions`): the load-order sort stops with `INCOMPATIBLE ... both active`. Since 2026-11-12 `stage-pickle-wsl.sh` drops those lines with a warning when the bundle is staged; remove them from the map anyway. The `StandaloneBase` shell is not the bundle (no DLLs, same packageId): with it, the standalone tool stays. Optional tools outside the bundle (`newcolony`, `camerazoom`, `screenshotstudio`, ...) are staged next to the bundle as usual. The bundle line must point to `PickleTools/Mod` (14 DLLs), never to `StandaloneBase/Mod`, if the scenario uses bundle steps.

## Removal check

`removal-check.feature` plays a saved game with a mod removed, for any mod: the mod under test cannot host that pass itself (it depends on the removed mod). Pass 1 (mod present): the mod's own test saves the game and copies it to the run folder (`the saved game {name} is copied to the run folder`, SaveSteps; the hand-over to a mod is lost with the container). Between passes copy `<run>/<name>.rws` to `Tests/Pickle/Mod/Pickle/Fixtures/removal-check.rws` (not versioned). Pass 2: file `-Mod PickleTools -Filter removal-check` with a copy of `wsl-deps.removal-check.map` that lists the mods the save still needs and not the removed one. Pass 3 (mod re-added) is the mod's own load test of the same save. Not played yet: whether Pickle loads a save naming a missing mod is unverified.
