# Excludes - the `@excludes:` tag for Pickle (shared)

Pickle's own `@requires:<mod>` skips a scenario when a mod is **absent**. This companion adds the inverse:

| Tag | Effect |
| --- | --- |
| `@excludes:<mod>` | the scenario is reported **skipped** when `<mod>` is **loaded** |

`<mod>` is a mod name or a packageId, case insensitive: the same rule as `@requires:` (it is Pickle's own
`ModLookup`, handed to the patch). Several `@excludes:` tags on one scenario all apply: the first loaded one skips it.
Combine freely with `@requires:`, `@wip`, `@skip`.

```gherkin
@excludes:nelim.scaledworld
Scenario: the nine dragons keep their size when Scaled World is absent
```

A skipped scenario is not a pass (AUDIT.md 8.f): the pass that loads the excluded mod has to cover that case
some other way, and the pass without it has to play the scenario.

## How it works

Pickle asks `RunOutcomes.MissingRequirement(tags, isLoaded)` before each scenario and skips it when the answer
is a name. `Source/ExcludesPatch.cs` installs a Harmony postfix on that method: when Pickle found nothing missing,
the postfix asks the inverse question with the same `isLoaded`, and returns the excluded mod's name followed by
` (@excludes)`. Pickle then skips the scenario and logs `skipping '<scenario>', '<mod> (@excludes)' is not loaded`:
the wording is Pickle's, the suffix says why. The decision itself is `Source/ExcludesRule.cs`, free of any game type.

- **It loads as a RimWorld assembly** (`Mod/Assemblies/`, `[StaticConstructorOnStartup]`), not from `Mod/Pickle/Assemblies/`
  like the step companions. The patch must exist before the first scenario is filtered, and Pickle runs no code of a
  steps assembly before then. The mod loads after Pickle and Harmony.
- **No build-time reference to Pickle.Core** (the reference package carries only `RimWorks.Pickle.dll`), so the
  method is found by reflection. Written against Pickle `1af08c0` (`Source/Pickle.Core/Run/RunOutcomes.cs`,
  called from `Source/Pickle/Run/RunSession.cs`).
- **If Pickle moves the method**, nothing is patched, the game log says `[Nelim's Pickle Tools: Excludes] ... NOT active`,
  and tagged scenarios run as if the tag did not exist. The probe feature below fails in that case.

## Use it

Add one line to the pass map:

```
nelim.pickletools.excludes   path:PickleTools/Excludes/Mod
```

## Status and proof

Compiled, 0 warnings; **played green 2026-11-06 (ticket 46b3, azure, 1 passed + 1 skipped as expected)**. The probe is `Tests/Pickle/Mod/Pickle/Features/pickletools-excludes.feature`,
pass map `Tests/Pickle/wsl-deps.excludes.map`. Two scenarios: `@excludes:rimworks.pickle` (always loaded, so the
scenario must be SKIPPED: its only step would fail if it ran) and `@excludes:nelim.no.such.mod` (never loaded, so it
must RUN and pass: the control, without which a tag that skips everything would look right). Read the report for
1 passed + 1 skipped.

Not covered: a unit test of `ExcludesRule` (this repository has no test project for the companions; the rule is
a dozen lines, the probe plays it). Upstream, a `RunOutcomesTests.cs` case would be the natural home if the tag is
ever proposed to Pickle (Virginie's word first).
