# Inspect tabs - Pickle steps (shared)

Two Pickle steps that open a pawn's inspect tabs (Gear, Bio, Health, Social, Needs, Log) and check which one is open:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I open the {string} inspect tab` | Opens an inspect tab on the selected thing through `InspectPaneUtility.OpenTab`, which switches the main tabs root to Inspect on its own and toggles only a closed tab. Refuses a tab the selection carries but hides. |
| `Nelim's Pickle Tools: the {string} inspect tab is open` | Waits for the named tab to be the one the pane has open, then asserts it. |

Development only. Never published, no Defs, no features: a suite stages the companion mod in `Mod/` and writes its
own scenarios.

## Why it exists

Pickle's `I open the {string} tab` switches the MAIN tabs (Architect, Work, Schedule). Nothing in Pickle reaches the
tabs of the inspect pane, so a scenario could not show a pawn's gear, and the Gear tab is the one reliable way for a
scenario to state what a pawn wears at the moment of a capture rather than a few steps earlier.

## Two versions, kept in step

This is a copy of [RimWorks/Rimworld-Pickle#31](https://github.com/RimWorks/Rimworld-Pickle/pull/31), branch
`feat/inspect-tab-steps` on `vbardales/Rimworld-Pickle`. It exists so a suite can use the steps with the stock
Pickle, without a local build (`-PickleSrc`). **A change to one goes to the other.** Mirrored commit: `6eb53f4`.

| | Pull request | This folder |
| --- | --- | --- |
| Step text | `I open the {string} inspect tab` | `Nelim's Pickle Tools: I open the {string} inspect tab` |
| Style | Pickle's: 2 spaces, braces on the line, nullable annotations | This repository's: 4 spaces, braces on their own line, nullable off |
| Where | `UiSteps.cs` in `Pickle.Vanilla`, plus `Docs/steps.md` and a scenario in `Pickle/Features/ui-steps.feature` | `Source/InspectTabSteps.cs` |

The logic must not differ. The text of the steps does, on purpose: with the prefix, this mod and a Pickle that already
carries the pull request (the local integration build, or a later release) can be loaded together and no step is
ambiguous.

When the pull request merges and a Pickle release ships it: delete this folder and its row in `Upstream/PENDING.md`,
and change the suites' step text to the unprefixed one.

## Naming a tab

By its type name (`ITab_Pawn_Gear`), by its label key (`TabGear`), or by the short form of either (`Gear`). All three
are identifiers, so a scenario keeps working under a language mod. The label a player reads never matches. A name that
fits two tabs fails and asks for the full type name; a miss lists the tabs the selection has, hidden ones marked.

The Bio tab is `ITab_Pawn_Character` / `TabCharacter`, so `"Bio"` does not match: use `"Character"`.

Exactly one thing must be selected, because that selection decides which tabs exist.

## Using it from a suite

A pass map, in the suite's `Tests/Pickle/`, that stages the mod from this repository:

```
nelim.pickletools.inspecttabs   path:PickleTools/InspectTabs/Mod
```

The folder's own `About.xml` packageId must match the one written.

```gherkin
When I select "Tabby"
And Nelim's Pickle Tools: I open the "Gear" inspect tab
Then Nelim's Pickle Tools: the "Gear" inspect tab is open
```

## Building

```
dotnet build -c Release
```

in `Source/`. The DLL lands in `Mod/Pickle/Assemblies/` and is committed, as the other packages' are.
