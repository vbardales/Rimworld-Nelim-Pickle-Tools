# Texture owner - two Pickle steps (shared)

Two steps that ask RimWorld **which running mod answers for a texture path**, and how many running mods ship it. No mod is
named in a step: the mod is a parameter, so any retexture can use them.

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: the texture {string} is answered by the mod {string}` | passes when the **last** running mod that ships the path is the one whose packageId is given |
| `Nelim's Pickle Tools: the texture {string} is shipped by at least {int} running mod(s)` | passes when at least that many running mods ship the path |

Developer tooling. GitHub and Workshop release preparation in progress; no Defs, no features: a suite stages the companion mod in `Mod/` and writes its
own scenarios.

## Why it exists

Two mods that write the same texture path are resolved by load order: the last one wins, and a `loadAfter` is what makes
the right one last. If that stopped winning (a packageId renamed upstream, a load order a player rearranged, a `loadAfter`
lost in an edit), **every scenario stays green**: the icons are still there, still the right shape in the right places, and
they are the other mod's. A pixel comparison would only say "different", never "whose", and needs readable textures. These
steps ask the content holders `ContentFinder` itself searches.

It came out of SkillIcons, whose `Tests/Pickle/Source/TextureOwnerSteps.cs` has two steps of this kind with the packageId
`nelim.skillicons` written into the first. SkillIcons and Oracle's Skill Icon Retextures write the same eleven paths. The
failure applies to any retexture mod, which is why it lives here and not in one suite.

## What "answers for" means, and where it is read from

`ContentFinder<Texture2D>.Get(path)` walks `LoadedModManager.RunningModsListForReading` from the **end**, asks each mod's
`ModContentHolder<Texture2D>.Get(path)` and returns the first non-null answer, so the last mod that ships the path wins.
That is read from the 1.6 IL of `Assembly-CSharp.dll` (2026-09-21), not from memory. The holder is a dictionary lookup
keyed by the path relative to the mod's `Textures` folder, without extension and **case-sensitive**; a miss logs nothing.

- **The packageId** in the first step is compared without regard to case or surrounding blanks, against
  `ModContentPack.PackageIdPlayerFacing` (what a person writes in a pass map or an `About.xml`), not the internal
  `PackageId`, which can carry a `_steam` suffix.
- **A path no running mod ships stops the step with a sentence** instead of passing: a claim about an empty set must not hold.
  The same for `at least 0`, which would hold for every path.
- **A failure says who took the path, and why the named mod did not.** It names the winner, lists every mod shipping the path
  in load order, and tells three cases apart: the named mod ships it and loads before the winner (with its position), it is
  running but ships nothing at that path, it is not among the running mods at all.
- **Not covered**: a texture a mod puts on screen by another route than `ContentFinder` (a Harmony patch that draws its own,
  a graphic built from a texture it holds), and the `Resources.Load` fallback `ContentFinder` tries when no mod ships the
  path. It says nothing about pixels.
- **It is only meaningful in a pass that stages the competing mod.** Without it the mod is the only shipper, and "answered by"
  passes trivially: which is what the second step is for. Play it first, in that pass, and the first step is worth reading.

## Using it from a suite

1. In the pass map (`<Mod>/Tests/Pickle/wsl-deps.<pass>.map`), after the mods it needs:

   ```
   nelim.pickletools.textureowner   path:PickleTools/TextureOwner/Mod
   ```

   Select it with `-DepMap <the map>`. The folder's own `About.xml` packageId must match the one written.
   **End the map with a newline.** The staging reads it with `while read`, which skips an unterminated last line without a
   word: the first map written for this tool lost its last mod that way, found only because the staging was dry-run.
2. Write the scenario. The path is the one the texture is filed under in a mod's `Textures` folder:

   ```gherkin
   Then Nelim's Pickle Tools: the texture "UI/Icons/PassionMajor" is shipped by at least 2 running mods
   And Nelim's Pickle Tools: the texture "UI/Icons/PassionMajor" is answered by the mod "nelim.skillicons"
   ```

   The first line is the one that makes the second mean something: an uncontested path means the competitor is not staged.
3. `Check-Steps.ps1` proves the two texts are unique, see below.

## Adopting it in SkillIcons (for the SkillIcons session; nothing there is changed from here)

**Pass map.** The line to add, the same in each pass that plays `15-texture-ownership.feature` or
`16-texture-contest.feature`:

```
nelim.pickletools.textureowner   path:PickleTools/TextureOwner/Mod
```

- `Tests/Pickle/wsl-deps.avec-oracle.map`: add it after `oracle.skills.retexture 3214465250`, and **end the file with a newline**.
- Without `-DepMap`, the launcher sets `PICKLE_DEPMAP=none`: it does **not** read `wsl-deps.map`, and no shared tool
  is added through a pass map. To play feature 15 without optional gameplay mods but with this tool, put only the
  tool line in `Tests/Pickle/wsl-deps.sans-facultatifs.map` and select it explicitly with
  `-DepMap wsl-deps.sans-facultatifs.map`. The report's set name remains `sans-facultatifs`, taken from that file name.
  This is an adoption instruction, **not a claim that this pass has been run for SkillIcons**.
  Every other pass that plays 15 or 16 needs the tool line too.

**The two step phrases**, in `15-texture-ownership.feature` and `16-texture-contest.feature`:

| Today (SkillIcons' own assembly) | Replace with |
| --- | --- |
| `SkillIcons owns the texture "X"` | `Nelim's Pickle Tools: the texture "X" is answered by the mod "nelim.skillicons"` |
| `the texture "X" is contested by at least 2 mods` | `Nelim's Pickle Tools: the texture "X" is shipped by at least 2 running mods` |

Then delete `Tests/Pickle/Source/TextureOwnerSteps.cs` and rebuild the suite's assembly. What changes for a reader of a report:

- The failure sentence no longer ends with SkillIcons' own text ("The loadAfter in About.xml is no longer winning, and every icon
  a player sees for this passion is that mod's"); it says instead which of the three cases it is. If `TESTING.md` quotes the old
  sentence, it needs the new one.
- The packageId is compared against `PackageIdPlayerFacing`. The old step compared `PackageId`. They differ only for a copy that
  carries a `_steam` suffix.
- `at least 0` is refused; the old step passed it.

## Checking it

```
powershell.exe -ExecutionPolicy Bypass -File PickleTools/TextureOwner/Check-Steps.ps1
powershell.exe -ExecutionPolicy Bypass -File PickleTools/TextureOwner/Check-Ownership.ps1
```

`Check-Steps.ps1` compiles the two patterns with Pickle's own expression engine and checks that neither is declared twice nor
ambiguous against any other suite in the repository, against the sibling tools, or against Pickle's vocabulary (read from
its DLLs); it also resolves every step line of the features that use the vocabulary. No game, a few seconds. It is the same
proof as `RimmsqolSteps/Check-Steps.ps1`, which is the version it was made from.

`Check-Ownership.ps1` loads the built assembly and exercises the decisions and the wording with hand-made lists of providers:
19 cases, listed in the script. No game.

## What has and has not been played

**Offline, 2026-09-21:** `dotnet build -c Release` in `Source/` (net48, against `Krafs.Rimworld.Ref` and `RimWorks.Pickle.Ref`): 0 warnings,
0 errors. `Check-Steps.ps1` passes (2 patterns, none ambiguous against 649 others). `Check-Ownership.ps1` passes its 19 cases, and fails
when an expectation is broken on purpose. The staging accepted the pass map below in a dry run into a throwaway game directory (14
mods, the load order written in the map); that dry run is what found the missing-newline trap above.

**In a game: NOT played.** No Pickle pass has run these steps, so they have not been shown to work. A run was queued
(`Run-PickleWsl.ps1 -Mod PickleToolsCheckTextureOwner -DepMap wsl-deps.textureowner.map`, 2026-09-21, 17 tickets ahead); when this was written it had not started and no report existed. If one exists now, it is not described here. What it would show, and the suite it needs, is in `evidence/suite/`: one feature of claims
that hold (3 scenarios), one `@wip` feature of eight refusals, each expected red, to read the failure sentence of each case; the map;
and the three fixture mods, which ship known paths so the load order is known. That throwaway suite lives beside the repository as
`PickleToolsCheckTextureOwner/` (untracked in the monorepo, like `PickleToolsCheck`); recreate it from `evidence/suite/` if it is gone.
Until a report says otherwise, also unverified: that `GetContentHolder<Texture2D>().Get(path)` answers for a mod's textures as read
from the IL, that `PackageIdPlayerFacing` equals the id written in the pass map, and that Pickle stops a step with the sentence `Require`
is given.

The play command, once the machine is free (read `AUDIT.md`, "Tests Pickle", first; a report is yours only if it names a scenario of
this suite):

```
powershell.exe -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 -Mod PickleToolsCheckTextureOwner -DepMap wsl-deps.textureowner.map -Filter 'pickletools-textureowner.feature,pickletools-textureowner-refusals.feature' -IncludeWip -Label 'PickleTools TextureOwner first play' -MaxWaitMinutes 600
```

## Files

- `Source/` the C# project. `TextureOwnership.cs` decides and words every verdict (pure BCL, tested offline); `TextureOwnerSteps.cs`
  reads the running mods and calls it.
- `Mod/` the companion mod the staging copies (`About/About.xml`, `Pickle/Assemblies/Nelim.PickleTools.TextureOwner.dll`, `LICENSE`).
  Nothing else may be put here. Like the other tools it logs `did not load any content` at start, harmless.
- `Check-Steps.ps1`, `Check-Ownership.ps1` the offline checks.
- `evidence/suite/` the throwaway suite that plays the steps (see above), not part of anything staged.
- `.build/` intermediates.
- Rebuild after any change to `Source/`, then run both checks; the DLLs of steps are loaded at game start.
