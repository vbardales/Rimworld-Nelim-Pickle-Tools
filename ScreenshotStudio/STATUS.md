# ScreenshotStudio status — 2026-09-22

Scope: optional screenshot scenery companion in PickleTools. Release packaging supports an explicit
`-IncludeScreenshotStudio` switch and separate archive; the Workshop aggregate remains unchanged.
The optional archive is blocked until the zen save and matching export evidence are present.

- Compiles in Release against RimWorld 1.6.4871 and Pickle 4.8.3: zero warnings, zero errors.
- The first meadow version passed construction, save/reload, mosaic checks and direct fixture loading
  in a new WSL/Xvfb game process. Evidence: `evidence/2026-09-22/`.
- An earlier Japanese-garden run exposed an inherited pawn hauling job referencing a removed object.
  The seed and generator now clear old jobs; the final replay below validates that correction.
- The zen fixture was exported after the final 1/1 construction/save/reload run, then loaded directly in a separate WSL/Xvfb process: 1/1 passed in 14.178 seconds. Evidence: `evidence/2026-09-22-zen/`.
- After moving presentation captures to the direct-load scenario, that scenario passed again: 1/1,
  `exitReason: passed`, 51.976 seconds. All nine interface-free views were visually inspected together;
  the captures (JPEG since 2026-09-23, minified from the PNG originals), report and contact sheet are in `evidence/2026-09-22-zen/presentation-captures/`.
- The component declares Pickle and Ideology dependencies. All five DLC are used in the tested profile;
  operation without individual DLC is unverified.
- This is a paused photographic set, not a tested long-running survival colony. Roofs are deliberately omitted.
- No publication, push or workflow stage promotion is claimed.

Code/documents: OpenAI Codex under Nelim's direction. Mosaic: owner's supplied `queue.png` sampled into
33x33 vanilla painted tiles. Seed: adapted privately from Pickle's `test-colony.rws`, with its MIT notice retained.

The earlier cancelled queue attempt remains documented. The final run completed after the reservation was lifted; the prior zen preview report is retained in evidence/2026-09-22-zen-preview/.
