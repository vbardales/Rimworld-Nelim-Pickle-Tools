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
`lost-click-probe.feature` asserts the two lost-click symptoms (the page does not open) and a control, so it is green when the click is lost as it should be; the copy that fails on purpose, to read the report's text, is `Upstream/tests/lost-click-probe.feature`.
