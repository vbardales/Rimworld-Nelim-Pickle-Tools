# PickleTools runtime checks

This companion owns the runtime probes for the aggregate bundle and the individual utilities.
Run it with `scripts/Run-PickleWsl.ps1 -Mod PickleTools` and select a `wsl-deps.*.map` file.

The aggregate minimal probe overlays `PickleTools/.build/aggregate-current/Mod`; generate that payload with
`Release/Prepare-Release.ps1` before running it. The other maps stage the named development companion.
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
