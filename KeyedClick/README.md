# Keyed click - a Pickle step (shared)

One Pickle step that clicks a button **by the translation key its label comes from**:

| Step | What it does |
| --- | --- |
| `Nelim's Pickle Tools: I click button keyed {string}` | resolves the key with the game's own `Translate()`, then clicks the button drawn under that label |

Development only. Never published, no Defs, no features: a suite stages the companion mod in `Mod/` and writes
its own scenarios.

## Why it exists

The game draws a button under the label of the language the player runs in, and Pickle records it under that
label. A scenario that spells the English text out, `I click button "New colony"`, only passes on an English game:
on a French one the tag is `btn:Nouvelle colonie` and the step reports `known tags: btn:Nouvelle colonie, ...`.
Naming the key (`NewColony`) is what survives a change of language.

A key nothing translates fails with a message that names the key and the active language, instead of building a
label from the key itself and reporting a dead button.

## This is a copy, and it is kept in step

The same step is proposed to Pickle itself: **RimWorks/Rimworld-Pickle pull request 19**, branch
`feat/click-button-by-translation-key` on the fork, as `I click button keyed {string}`. The patch series is in
`Upstream/patches/pr-19/`, the ledger row in `Upstream/PENDING.md`.

Until it merges, **both versions are maintained**: a change asked for in review is made in the pull request and
here, in the same sitting. The two differ in exactly one thing, the `Nelim's Pickle Tools:` prefix, which is what
keeps them from being an "Ambiguous step" when they meet in one run.

**When the pull request lands and a Pickle release carries it**, delete this folder and `Upstream/patches/pr-19/`,
and change the one prefix in the scenarios that used it.

## Using it from a suite

1. A pass map, in the suite's `Tests/Pickle/`, that stages the mod from this repository:

   ```
   nelim.pickletools.keyedclick   path:PickleTools/KeyedClick/Mod
   ```

   Select it with `-DepMap <the map>`. The folder's own `About.xml` packageId must match the one written.
2. Write the scenario:

   ```gherkin
   Given the main menu is open
   When Nelim's Pickle Tools: I click button keyed "NewColony"
   Then window "Page_SelectScenario" is open
   ```

3. Play it in a language other than English to see what it is for (`Run-PickleWsl.ps1 ... -Language French`).

## Checking it

```
powershell.exe -ExecutionPolicy Bypass -File PickleTools/KeyedClick/Check-Steps.ps1
```

Compiles the pattern with Pickle's own expression engine and checks that it is not ambiguous against any other
suite in the repository or against Pickle's vocabulary. No game, a few seconds.

## What has and has not been played

The **upstream** step was played: `entry-flow.feature` on a Linux RimWorld 1.6 under Xvfb, once in English (3
passed) and once in French, where the two scenarios that spell `New colony` out failed and the keyed one passed.
**This copy has not been played**: it is compiled with 0 warnings and its pattern is checked, and no suite stages
it yet.

The build is `Source/`, net48, against `Krafs.Rimworld.Ref` and `RimWorks.Pickle.Ref`; the DLL is committed in
`Mod/Pickle/Assemblies/`, as for the other tools.
