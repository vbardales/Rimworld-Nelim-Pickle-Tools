# Writing a Pickle suite for a new mod

This is the entry point for suite authors in this collection. The collection's `AUDIT.md` defines the
workflow gates; [Headless](../Headless/README.md) defines how runs are launched. The [tool catalogue](../README.md)
and [suite catalogue](../Elsewhere/README.md) say which steps already exist. Read those before writing C#.

Reviewed against the local launcher, staging script, companion sources and local Pickle source on 2026-09-22.
This is a documentation/source review, not a run of the examples or a claim about the latest upstream release.

## 1. Decide what needs a running game

Keep calculations, configuration validation, XML contracts and translation-resource coverage in offline tests.
Use Pickle for what those cannot establish: the rendered UI, an interaction, behavior through game callbacks,
save/reload or a real process restart, and captures that somebody will inspect. Do not duplicate an offline
assertion in Gherkin simply to fill a suite. Do not test the game's reaction to a dependency declaration or
its language-switch mechanism; test the mod's declaration offline and its own behavior in the relevant pass.

`done` requires applicable offline tests to pass and justified Pickle scenarios to be written.
Executing them and reviewing their captures belongs to `done -> tested`, including interactive settings and
English/French checks. The explicit clarification in `AUDIT.md` takes precedence over older wording in
`MOD_SETTINGS.md` or a suite README. Missing runtime evidence is `unverified`, not a defect or a pass.

In the mod's `TESTING.md` or equivalent, identify each behavior, setup, action, expected result and evidence.
Separate assertions from `@review` captures: a green screenshot step says that a file was captured, not that
the garment was worn, the correct window was visible, the translation fit or a sound was audible.

## 2. Keep tests outside the distributed mod

```text
ExampleMod/
  Mod/                                  the player-facing mod
  Tests/Pickle/
    README.md                           scope, pass matrix, commands and evidence
    wsl-ids.map                         optional packageId -> Workshop id lookup
    wsl-deps.sans-facultatifs.map        only if the minimal pass needs shared test tools
    wsl-deps.avec-integration.map        explicit additional mod set
    config/<pass>/Mod_<folder>_<Class>.xml  optional documented settings seed
    Source/                             optional: local step sources and build project
    Mod/
      About/About.xml                   identity of the test companion
      Pickle/
        Features/*.feature
        Fixtures/*.rws                  only if a suitable supplied fixture is unavailable
        Assemblies/*.dll                only if local C# steps are needed
```

The test companion's `About.xml` has a unique packageId, a clear display name such as
`Example Mod - Pickle tests`, supported versions, and dependencies/loadAfter for Pickle and the mod under
test. Copy the structure, not the identity, from an existing companion such as
`PickleTools/QuietNewFactions/Tests/Pickle/Mod/About/About.xml`. Test-only dependencies must not become gameplay dependencies.
Keep the companion and PickleTools out of the Workshop payload.

Use the actual capitalization shown by the filesystem, especially on Linux. The shared staging script expects
`Tests/Pickle` and `Mod/About/About.xml`; its `--list` only enumerates top-level suites and is not a complete
inventory of nested repositories. The [local inventory](../Elsewhere/INVENTORY.md) includes those.

In this checkout, `FlavorText/FlavorTextExtended` and `FlavorText/FlavorTextExtendedFR` are the real Git
roots. The same names at collection level are Windows junctions, not duplicate mods. Record canonical paths
in inventories and check aliases before moving a repository. Existing scripts, maps and project references
may depend on either spelling; a flattening requires migrating those references and checking WSL resolution.

## 3. Define the pass matrix before the features

| Pass | What it establishes |
|---|---|
| Minimal | The mod and hard dependencies work without optional gameplay mods |
| Optional integration | Behavior beside each claimed optional integration; split mutually incompatible combinations |
| Declared incompatibility | The documented conflict symptom still occurs; assert that symptom, not an expected red |
| DLC absent, when relevant | The mod's own guard/fallback works without that DLC |
| English and French | The same mod UI/behavior in each startup language |
| Restart sequence, when relevant | Writer and reader run in separate processes under one lock |

Account for every applicable pass in the audit. If there are no optional integrations or a pass is irrelevant,
record the justification rather than inventing a duplicate run with a different name.

`wsl-ids.map` resolves Workshop ids in every pass and activates nothing by itself. `wsl-deps.<name>.map`
adds the mods/tools for one explicitly selected pass. Maps are not merged automatically. Without `-DepMap`,
the launcher sets `PICKLE_DEPMAP=none`, including when `wsl-deps.map` exists.

For a minimal gameplay set needing a shared test tool:

```text
# Tests/Pickle/wsl-deps.sans-facultatifs.map
nelim.pickletools.research path:PickleTools/ResearchSteps/Mod
```

Select it with `-DepMap wsl-deps.sans-facultatifs.map`. List required tools in every pass that uses them.
For integrations, put prerequisites before their consumers. `path:` is relative to the collection root,
uses forward slashes and no spaces; the packageId must match the folder's own About.xml. End maps with a newline.
Use `!ludeon.rimworld.odyssey` to omit that DLC, not to remove an arbitrary mod. Never stage Prepatcher.

Before queuing, check that the selected map actually exists: the current staging script silently ignores a
missing map. It copies the main mod's direct `modDependencies`; it is not a recursive dependency resolver and
does not discover every dependency of an added tool or optional mod. Its dependency extraction is line-based:
keep dependency packageIds on separate lines and inspect the staged and actually loaded lists. Resolve hard
dependency ids in `wsl-ids.map`; explicitly arrange additional prerequisites rather than assuming they appear.

## 4. Write isolated scenarios and select them correctly

Tag an integration/tool feature with its actual requirements, for example
`@requires:nelim.pickletools.research`. `@requires:<packageId>` skips when that package is absent; it does not
install it. A skipped integration is not validated: check that it actually ran in its intended pass.

`@wip` means unfinished/explicitly opted in, not dependency selection. `@rimmsqol` or `@pickletools` are useful
filter labels but do not check mod presence. `-IncludeWip` lifts the wip exclusion for the selected scenarios;
pair it with a narrow filter while developing. It is not currently forbidden without a filter.

The following is an illustrative feature for a mod that adds a research tab and project. Replace the defNames,
establish the fixture's research prerequisites, and use it only if this is behavior the mod needs to verify.
The shared research step invokes the tab action; it is not proof of a physical mouse click.

```gherkin
@requires:nelim.pickletools.research
Feature: Example Mod research interface

  @review
  Scenario: the custom research project is visible in its own tab
    Given the save "test-colony" is loaded
    When Nelim's Pickle Tools: I open the research tab "ExampleResearchTab"
    Then Nelim's Pickle Tools: the research window is on the tab "ExampleResearchTab"
    And Nelim's Pickle Tools: the research window lists the project "ExampleResearchProject"
    When I take a screenshot "example-research"
    Then no errors were logged
```

`test-colony` is supplied by the installed Pickle used by existing suites; verify the fixture exists in the
build being staged. For presentation or screenshot scenarios, PickleTools' default is instead the packaged
`nelim-zen-meadow-studio`: stage ScreenshotStudio and ClearScreen through `wsl-deps.studio.map` and load it
explicitly. A functional scenario keeps `test-colony` or another custom fixture when it needs specific
preconditions. A custom fixture belongs in the test companion and needs documented DLC/mod requirements.
Reload before independent scenarios. Reacquire pawns/windows after a load: old object references are stale.
Use `@same-world` only for an intentional dependency on the preceding scenario, not as a general speed trick.

Use defNames/type names for Def-based UI and translation keys for keyed buttons. A DefInjected path is not a
Keyed key. Set `-Language English` or `-Language French` at launch; never switch language within a scenario.

## 5. Add C# only for a missing observation or action

Inspect the relevant shared tool and suite notes first. A new class uses `[PickleSteps]`; each method takes
`PickleContext` first and a `[Given]`, `[When]` or `[Then]` Cucumber expression. Prefix every local phrase with
the mod's name. C# namespaces and Gherkin keywords do not separate the global step vocabulary.

Compile expressions with Pickle's expression engine before a run. Parentheses mean optional text and `/`
means alternatives; do not paste regex syntax into a Cucumber expression. Reuse the approach of
`PickleTools/ResearchSteps/Check-Steps.ps1`, adapting its tool-specific source paths and vocabulary filters.
Such checks cover the expressions and feature lines they scan, not every possible collision or runtime branch.

Build against the version actually staged. Existing companions use net48 reference packages with
`ExcludeAssets="runtime"`/`PrivateAssets="all"`, and external assembly references with `Private=false`.
Put only the intended step DLL and genuinely required helper assemblies under `Mod/Pickle/Assemblies/`;
do not ship game/reference stubs or a second Pickle/Harmony there. Keep obj/bin under `.build/` and verify the
delivered DLL after building. A suite with only built-in/shared steps needs no local step project.

Use `ctx.Set`/`ctx.Get` for scenario-local state. `ctx.Require` reports a broken precondition; it is not a
successful check or a justification to skip missing setup. Assertions must include actual values on failure.
Await every `WaitUntil`, `WaitFrames`, `WaitTicks` and `AssertEventually` from an `async Task` method.
A discarded Task can make a test pass without waiting for its assertion. Do not use Thread.Sleep or Task.Delay
to wait for game behavior.

The default step deadline is five seconds unless overridden. A step waiting up to 30 seconds needs an
attribute such as `[Then("Example Mod: ...", TimeoutSeconds = 35f)]`, and the scenario/run deadline must also
allow it. Modal settings windows pause ticks: use frames to wait for layout. A timeout is not a reason to
increase every deadline; first inspect the required state, paused simulation, covering windows and job trace.

Restore mutations through AfterScenario hooks even on failure: windows/screenshot flags, settings files,
temporary Def edits, patches and other shared state. A settings sandbox should preserve existing files and
identify interrupted backups. In-process rereading is not a full restart. For a restart test, preserve the
writer's file deliberately and read it in a later process via `-Then`, with no intervening staging.

## 6. Launch only through the shared harness

From the collection root, substituting a real mod and existing map/filter:

```powershell
powershell.exe -ExecutionPolicy Bypass -File scripts/Pickle-Status.ps1
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod ExampleMod -DepMap wsl-deps.sans-facultatifs.map -Language English
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod ExampleMod -DepMap wsl-deps.sans-facultatifs.map -Language French
```

The status call is read-only. Follow the [Headless guide](../Headless/README.md) and the machine rules in
`AUDIT.md`: no Windows launch, no second game, no manual staging, no removal of somebody else's run or
reservation. Shared WSL builds/downloads also go through `Use-Wsl.ps1`.

Filters accept the companion's **display name**, a feature filename, `file.feature::scenario name`, `::name`
or a tag. Commas combine selections with OR; they are not an intersection. A filter does not stage its tools.
For a two-process restart test use `-Filter write.feature -Then read.feature`. For more than one continuation,
call the PowerShell script from PowerShell with an actual string array, for example
`& ./scripts/Run-PickleWsl.ps1 -Mod ExampleMod -Filter write.feature -Then @('read.feature', 'reset.feature')`.
Do not assume `powershell.exe -File ... -Then read.feature,reset.feature` creates two launches: a single comma
string is one Pickle filter and can select both features inside one process.

Rebuild before launch: Pickle loads step DLLs when the game starts. Changing a DLL during a run does not change
the code that run is testing. A patched Pickle needs the complete root `Pickle.slnx` build and its dependencies,
staged with `-PickleSrc`; a step mentioned in an open PR is not automatically present in the Workshop build.

## 7. Read evidence before changing STATUS.md

Verify the report timestamp and command line identify this launch, then read `exitReason` before the counts.
Compare expected scenarios with executed/skipped ones for the chosen features, requirements and wip tags.
A partial run, missing report, missing optional mod or skipped required scenario is not a pass.
Check `Player.log` from startup as well: `no errors were logged` covers its scenario, not all startup errors.
Review any `dropped-mods.txt` against the intended set; the launcher reports dropped mods without failing every run.

Open each required `@review` capture or film. Assert the subject's state before capture. Screenshot mode hides
the HUD while retaining chosen windows; ClearScreen instead closes non-Pickle windows and can remove the very
settings window being tested. A film samples rendered frames, not every simulated tick; headless audio is not
human listening evidence.

Copy the useful report, log and media into the mod's own evidence directory before another run overwrites the
shared folder. Keep pass name, language, filter, revision/local changes, staged build identity, expected/actual
counts, verdict and human review outcome together. Five retained archives are temporary storage, not evidence
preservation. A `-Then` sequence leaves its final report in `pickle-reports`; preserve that one too.

Record cleanup and residual state. Update STATUS.md with validated, defective, unverified or justified
not-applicable findings, without promoting an earlier blocked gate on the strength of a later isolated check.
Add new local steps to [Elsewhere](../Elsewhere/README.md) and regenerate its inventory. A contribution to Pickle
goes in [Upstream/PENDING.md](../Upstream/PENDING.md); public issues/PRs/comments require the owner's approval.
