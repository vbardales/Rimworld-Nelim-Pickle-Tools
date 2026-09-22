# ScreenshotStudio status — 2026-09-22

Scope: optional screenshot scenery companion in PickleTools. Release packaging supports an explicit
`-IncludeScreenshotStudio` switch and separate archive; the Workshop aggregate remains unchanged.
The optional archive is blocked until the zen save and matching export evidence are present.

- Compiles in Release against RimWorld 1.6.4871 and Pickle 4.8.3: zero warnings, zero errors.
- The first meadow version passed construction, save/reload, mosaic checks and direct fixture loading
  in a new WSL/Xvfb game process. Evidence: `evidence/2026-09-22/`.
- The Japanese-garden variant passed the construction/save/reload scenario, and its actual overview,
  pond and dry-garden captures were visually inspected. The seed logged an inherited pawn hauling
  job referencing a removed object. The seed and generator have since been corrected to clear old jobs;
  this latest correction is compiled but its final replay is waiting for the owner's WSL reservation.
- Final zen fixture export and independent load verification are pending; do not claim them complete.
- The component declares Pickle and Ideology dependencies. All five DLC are used in the tested profile;
  operation without individual DLC is unverified.
- This is a paused photographic set, not a tested long-running survival colony. Roofs are deliberately omitted.
- No publication, push or workflow stage promotion is claimed.

Code/documents: OpenAI Codex under Nelim's direction. Mosaic: owner's supplied `queue.png` sampled into
33x33 vanilla painted tiles. Seed: adapted privately from Pickle's `test-colony.rws`, with its MIT notice retained.

The final queued replay was cancelled while still reserved (no game started). Resume explicitly after the release reservation is lifted. The prior zen preview report is retained in evidence/2026-09-22-zen-preview/.
