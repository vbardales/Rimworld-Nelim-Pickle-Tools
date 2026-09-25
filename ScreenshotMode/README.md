# Screenshot mode - Pickle steps (shared)

Reusable steps for a publication or review capture that keep the intended game window while
hiding RimWorld's HUD, developer controls and every Pickle-owned window.

| Step | Effect |
| --- | --- |
| `Nelim's Pickle Tools: screenshot mode is enabled around the open windows` | Keeps open non-Pickle windows, hides the HUD and Pickle panels. Fails when there is no non-Pickle window to review. |
| `Nelim's Pickle Tools: screenshot mode is disabled` | Restores the prior window flags and screenshot-mode state. |
| `Nelim's Pickle Tools: developer mode is turned off for the capture` | Sets `Prefs.DevMode` to false and waits three frames. For a capture that must keep the full interface (a main tab and its tab bar), which screenshot mode would hide: the runner starts the game with developer mode on, and its toolbar would show. |
| `Nelim's Pickle Tools: developer mode is restored` | Puts developer mode back. Optional: the `AfterScenario` hook does it. |

The second step is optional: an `AfterScenario` hook restores the state even if the scenario
fails. A scenario must open and assert its subject before enabling the mode, then wait for frames
rather than ticks when its window pauses the simulation, and finally take its screenshot or film.
The media remains a human-review artifact; a green scenario proves that it was produced, not that
the composition, text or visual effect is acceptable.

## Use from a suite

Add this line to every selected pass map that runs a capture scenario:

```text
nelim.pickletools.screenshotmode   path:PickleTools/ScreenshotMode/Mod
```

Tag the feature or scenario `@requires:nelim.pickletools.screenshotmode`. The tool is
development-only and must never appear in the mod's distributed `About.xml` dependencies.
