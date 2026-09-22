# Migration from the former QuietNewFactions repository

On 2026-09-22, this optional companion was moved into PickleTools with its source, package, tests, historical
reports and VEF proposal intact. Its packageId remains `nelim.quietnewfactions` so existing saves and pass maps
continue to identify the same mod.

The companion is intentionally separate from the aggregate `nelim.pickletools` payload: it references VEF at
load time and therefore requires both Harmony and Vanilla Expanded Framework. The separate `VefFactionSteps`
module carries the nine reusable Pickle assertions used by this companion's test suite.

The fresh WSL headless replay from this location passed on 2026-09-22: five scenarios passed, with no failure
or skip. Its source reports are preserved in `Tests/reports/2026-09-22-pickletools/`. The former repository is
therefore redundant and can be removed once this migration is pushed.
