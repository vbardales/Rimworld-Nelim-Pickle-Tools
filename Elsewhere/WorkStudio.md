# Work Studio

`WorkStudio/Tests/Pickle/Source/`: `ColonySteps.cs`, `ModSteps.cs`, `EditorSteps.cs`, plus the helpers `Driver.cs`,
`PriorityProbe`, `SettingsSandbox`. Step texts carry no prefix and most of them name the mod. Built into
`WorkStudio/Tests/Pickle/Mod/Pickle/Assemblies/WorkStudio.PickleSteps.dll` (committed), against `Mod/Assemblies/WorkStudio.dll`.

`EditorSteps.cs` is about 40 steps that drive Work Studio's own work type editor (create, rename, hide, drag, arrows, order
assertions). Specific to that window: **not worth promoting.**

## What is general, and where it lives

Three of these have a **second taker already**: the Harmony-patch assertion, the settings window that names its mod, and the
interface hidden around a mod's own windows exist, nearly word for word, in the TailorMade Waistlines suite
(`TailorMadeWaistlines.md`). That is the condition this ledger names for promotion.

A promoted step takes the `Nelim's Pickle Tools:` prefix and leaves the mod's name out.

| Step text | What it actually reads or does | Why it stays, and what to change to lift it |
|---|---|---|
| `{nick} is given backstories that disable no work type` / `{nick} can do the work types {a} and {b}` (`ColonySteps.cs`) | The first replaces the generated backstories with ones whose `workDisables` forbid nothing. The second asks `Pawn.WorkTypeIsDisabled` **after dropping the disabled-work-type caches**, because the cached answer said "no problem" for a colonist who could not clean (2026-09-20): a scenario set a priority the game later took away, correctly. Any scenario that names a work type has that coin flip, since the fixture's colonists are generated with random backstories. | Generic. It resolves names through the suite's `Driver.WorkType`, which takes a defName or the label of a type Work Studio created: keep the defName half. |
| `I set {nick} to priority {n} for {type}` / `{nick} has priority {n} for {type}` / `{nick} does nothing but the work type {type}` (`ColonySteps.cs`) | The setter turns on `useWorkPriorities`, writes through `Pawn_WorkSettings.SetPriority`, reads the value back through `GetPriority` and again from the private `DefMap` by reflection, so a write that never landed is told apart from a getter another mod answers for (Enhanced Work Tab keeps its own per-pawn store, 2026-09-17). A watcher, `PriorityProbe`, records who writes a zero. | Generic, for any work-priority mod. `Describe` names `WorkStudioMod.Settings` (its hidden types); drop that. |
| `I hide the interface around Work Studio's windows` / `I bring the interface back around Work Studio's windows` (`ModSteps.cs`) | Turns on the game's screenshot mode and clears `drawInScreenshotMode` on Pickle's own windows, found by assembly name (Pickle draws more than one), so the runner panel is not in the corner of every `@review` capture. An `[AfterScenario]` restores it even when a scenario dies between the two. | Generic; only the text names the mod. **Second taker: TailorMade.** Close to `ClearScreen/` in purpose and opposite in mechanism: that closes other mods' windows, this leaves them and hides the chrome. |
| `Work Studio patched {Type::Member}` / `Work Studio patched the draw method of the window the Work tab really uses` (`ModSteps.cs`) | `Harmony.GetPatchInfo(...).Owners` against the mod's Harmony id (`WorkStudioMod.HarmonyId`). The second walks up `MainButtonDef("Work").tabWindowClass` to the class that **declares** `DoWindowContents`, because a patch on a class that does not declare it never runs (this mod met that twice). | Generic, passing an id. **Second taker: TailorMade.** |
| `I open Work Studio's settings through Mod options` / `the Mod options window is drawing Work Studio's own settings` (`ModSteps.cs`) | The first adds a `Dialog_ModSettings` built with the mod instance, so closing it runs `PreClose`, which writes the settings. The second reads the private `mod` field of that dialog and compares by reference. | Generic; the mod class is the only specific part. **Second taker: TailorMade.** |
| `I wait for Work Studio's confirmation to become clickable` / `Work Studio asks to confirm first` (`ModSteps.cs`) | Reads `Dialog_MessageBox.TimeUntilInteractive` by reflection and waits on the dialog's own countdown, which beats a guessed number of frames; the second asserts a `Dialog_MessageBox` is open. | Generic, for any mod whose action asks first. |
| `the game log holds nothing from Work Studio since startup` (`ModSteps.cs`) | Matches `[Work Studio]` or the `WorkStudio.` namespace prefix in the log. RimLogging attributes a line by the mod's display name, which is also why Pickle's `no warnings from mod {string}` passed vacuously by packageId (Pickle PR #28). Related to the idea in `Upstream/PENDING.md` about errors logged since startup. | Generic; two strings to parameterise. |
| `I save the Work Studio test game as {string}` / `I load the Work Studio test game {string}` (`ColonySteps.cs`) | A save written mid-scenario under a prefixed name and read back later, with a 130 s timeout: the case where a save written under one set of defs is read under another. | Half. Check Pickle's own `I save and reload` first; this one exists for the set-changing case. The prefix comes from `SettingsSandbox`, which is this mod's. |

## What is specific, do not look here

`I export the Work Studio setup as`, `I import ...`, `the Work Studio import is refused`, `the exported Work Studio file ... does
not contain`, `I remember Work Studio's whole setup` / `... is as remembered`, `Work Studio runs its startup check`, `Work Studio
opens {int} warning dialog(s)`, `the last startup saw a work type {string} that is gone now`, `in the raw save {string}, the custom
types sit at the end of ...`, `the Work Studio button is not drawn`, `I click the Work Studio button keyed {string}`. They read
and write the mod's own config file, its drift warning and its saved priority lists, and are tied to `ConfigFile`,
`SettingsSandbox` and `WorkStudioMod`.

## Already promoted

`ClickDiagnostics/` came out of this suite on 2026-09-21: the button probe, the wait for a button to stand still and the
window-stack dump. `WarnIfCovered` and `DescribeStack` still stay in `ModSteps.cs` for the keyed click above, so `DescribeStack`
exists twice.
