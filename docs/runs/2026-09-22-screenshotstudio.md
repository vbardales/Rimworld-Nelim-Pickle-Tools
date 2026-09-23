# ScreenshotStudio, 2026-09-22

The optional companion that builds a zen meadow, saves and reloads it, then takes presentation captures, headless in
WSL under Xvfb. Local files: `ScreenshotStudio/evidence/` (no longer tracked, except the two JSON files named in
[`README.md`](README.md)).

| Folder | What | Result |
|---|---|---|
| `2026-09-22` | Build the meadow and verify that the studio survives a save reload (`initial-reload/` holds the reload report) | passed, 1/1 |
| `2026-09-22-zen-preview` | The same scenario, kept as the earlier zen preview run | passed, 1/1 |
| `2026-09-22-zen` | The final construction, save and reload run, on which the fixture `nelim-zen-meadow-studio.rws` (11 709 575 bytes, SHA256 `eb292c3e2f8d8975209bc1cfaa9a01618b368bb40e2895384962b9cab0c28230`) was exported. RimWorld 1.6.4871, WSL Ubuntu-24.04, Xvfb | passed, 1/1, 86 711 ms |
| `2026-09-22-zen/fixture-load-*` | The exported fixture loaded directly in a separate process | passed, 1/1, 14.2 s |
| `2026-09-22-zen/presentation-captures/` | Nine PNGs (`studio-overview`, `-flowers`, `-zen`, `-pond`, `-emblem`, `-display`, `-workshop`, `-kitchen`, `-home`), each 4 to 5.5 MB, and a contact sheet | one report, passed |

**Not shown here**: what the captures look like, and whether they were reviewed; `ScreenshotStudio/STATUS.md` is
where that is claimed. This file carries neither the images nor a judgement of them.
