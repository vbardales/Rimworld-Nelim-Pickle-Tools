# Work Studio

`WorkStudio/Tests/Pickle/Source/`: `ColonySteps.cs`, `ModSteps.cs`, `EditorSteps.cs`, `IconSteps.cs`, plus helpers `Driver.cs`,
`PriorityProbe`, `SettingsSandbox`. Step texts no prefix, most name mod. Built into
`WorkStudio/Tests/Pickle/Mod/Pickle/Assemblies/WorkStudio.PickleSteps.dll` (committed), against `Mod/Assemblies/WorkStudio.dll`.

`EditorSteps.cs` ~40 steps driving Work Studio's own work type editor (create, rename, hide, drag, arrows, order
assertions). Specific to that window: **not worth promoting.**

## What is general, and where it lives

Three already have **second taker**: Harmony-patch assertion, settings window naming its mod, interface hidden around mod's own windows exist, nearly word for word, in TailorMade Waistlines suite
(`TailorMadeWaistlines.md`). That is condition ledger names for promotion.

Promoted step takes `Nelim's Pickle Tools:` prefix, drops mod name.

| Step text | What it actually reads or does | Why it stays, and what to change to lift it |
|---|---|---|
| `{nick} is given backstories that disable no work type` / `{nick} can do the work types {a} and {b}` (`ColonySteps.cs`) | First replaces generated backstories with ones whose `workDisables` forbid nothing. Second asks `Pawn.WorkTypeIsDisabled` **after dropping disabled-work-type caches**, because cached answer said "no problem" for colonist who could not clean (2026-09-20): scenario set priority game later took away, correctly. Any scenario naming a work type has that coin flip, since fixture colonists get random backstories. | Generic. Resolves names through suite's `Driver.WorkType`, taking defName or label of type Work Studio created: keep defName half. |
| `I set {nick} to priority {n} for {type}` / `{nick} has priority {n} for {type}` / `{nick} does nothing but the work type {type}` (`ColonySteps.cs`) | Setter turns on `useWorkPriorities`, writes through `Pawn_WorkSettings.SetPriority`, reads value back through `GetPriority` and again from private `DefMap` by reflection, so write that never landed is told apart from getter another mod answers for (Enhanced Work Tab keeps own per-pawn store, 2026-09-17). Watcher `PriorityProbe` records who writes zero. | Generic, for any work-priority mod. `Describe` names `WorkStudioMod.Settings` (its hidden types); drop that. |
| `I hide the interface around Work Studio's windows` / `I bring the interface back around Work Studio's windows` (`ModSteps.cs`) | Turns on game's screenshot mode, clears `drawInScreenshotMode` on Pickle's own windows, found by assembly name (Pickle draws more than one), so runner panel not in corner of every `@review` capture. `[AfterScenario]` restores it even when scenario dies between the two. | Generic; only text names mod. **Second taker: TailorMade.** Close to `ClearScreen/` in purpose, opposite in mechanism: that closes other mods' windows, this leaves them, hides chrome. |
| `Work Studio patched {Type::Member}` / `Work Studio patched the draw method of the window the Work tab really uses` (`ModSteps.cs`) | `Harmony.GetPatchInfo(...).Owners` against mod's Harmony id (`WorkStudioMod.HarmonyId`). Second walks up `MainButtonDef("Work").tabWindowClass` to class that **declares** `DoWindowContents`, because patch on class not declaring it never runs (mod met that twice). | Generic, passing id. **Second taker: TailorMade.** |
| `I open Work Studio's settings through Mod options` / `the Mod options window is drawing Work Studio's own settings` (`ModSteps.cs`) | First adds `Dialog_ModSettings` built with mod instance, so closing runs `PreClose`, which writes settings. Second reads private `mod` field of dialog, compares by reference. | Generic; mod class only specific part. **Second taker: TailorMade.** |
| `I wait for Work Studio's confirmation to become clickable` / `Work Studio asks to confirm first` (`ModSteps.cs`) | Reads `Dialog_MessageBox.TimeUntilInteractive` by reflection, waits on dialog's own countdown, beats guessed frame count; second asserts `Dialog_MessageBox` open. | Generic, for any mod whose action asks first. |
| `the game log holds nothing from Work Studio since startup` (`ModSteps.cs`) | Matches `[Work Studio]` or `WorkStudio.` namespace prefix in log. RimLogging attributes line by mod's display name, also why Pickle's `no warnings from mod {string}` passed vacuously by packageId (Pickle PR #28). Related to idea in `Upstream/PENDING.md` about errors logged since startup. | Generic; two strings to parameterise. |
| `I save the Work Studio test game as {string}` / `I load the Work Studio test game {string}` (`ColonySteps.cs`) | Save written mid-scenario under prefixed name, read back later, 130 s timeout: case where save written under one set of defs is read under another. | Half. Check Pickle's own `I save and reload` first; this one exists for set-changing case. Prefix comes from `SettingsSandbox`, this mod's. |
| `I start counting the icons Work Studio draws` / `Work Studio drew a skill icon` / `... drew no work type icon` / `Work Studio left the Work tab header of {string} to the game` / `the Work Studio tooltip of the Work tab header of {string} starts with the name the game gives that work type` (`IconSteps.cs`, 16 declarations with settings and Character tab steps) | Three Harmony probes installed by counting step, removed after: prefix on every `GUI.DrawTexture` overload counts draws keyed by texture; postfix on mod's header worker (here `WorkTypeIcons.HeaderPrefix`, read from `__args`) tells which header mod drew; postfix on `TooltipHandler.TipRegion(Rect, Func<string>, int)` calls getter, stores text by region's unique id, so step can assert tooltip's first line (header's id is its type's `shortHash`). | Half. Draw counter and tooltip probe name no mod: lift as `Nelim's Pickle Tools: I start counting the textures drawn` and `... the tooltip with id {int} starts with {string}`. Header-worker postfix and settings and Character tab steps Work Studio specific. Promote only when second mod needs one (ask workstudio). Known limit: Compact Work Tab and Fluffy's Work Tab draw own table, so header probe sees nothing there. |

## What is specific, do not look here

`I export the Work Studio setup as`, `I import ...`, `the Work Studio import is refused`, `the exported Work Studio file ... does
not contain`, `I remember Work Studio's whole setup` / `... is as remembered`, `Work Studio runs its startup check`, `Work Studio
opens {int} warning dialog(s)`, `the last startup saw a work type {string} that is gone now`, `in the raw save {string}, the custom
types sit at the end of ...`, `the Work Studio button is not drawn`, `I click the Work Studio button keyed {string}`. They read
and write mod's own config file, drift warning, saved priority lists, tied to `ConfigFile`,
`SettingsSandbox`, `WorkStudioMod`.

## Already promoted

`ClickDiagnostics/` came out of this suite 2026-09-21: button probe, wait for button to stand still, window-stack dump. `WarnIfCovered` and `DescribeStack` still stay in `ModSteps.cs` for keyed click above, so `DescribeStack`
exists twice.