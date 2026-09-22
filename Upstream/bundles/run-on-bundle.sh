#!/usr/bin/env bash
# Play one filter of a mod's suite against a local Pickle bundle on the headless WSL install, and
# report what THIS run wrote, not what is in the shared report folder.
#
#   MOD=ArchitectStudio run-on-bundle.sh <bundle-folder> <filter> [Run-PickleWsl.ps1 arguments...]
#   MOD=ArchitectStudio run-on-bundle.sh ~/pickle-bundles/out/picker_bundle_23 16-language-review.feature
#
# The filter is what -pickle-run takes: a mod name, a feature file, a tag. Extra arguments go to the
# launcher (-Language French, -DepMap wsl-deps.avec-facultatifs.map ...).
#
# Why it does not trust the report folder: pickle-reports is one folder for the whole machine and
# every run overwrites it. Reading the newest summary.json after waiting in the queue returned another
# session's suite twice in one day (Bill Autopilot's failures under my filename; two unrelated
# suites). A report is taken as ours only when its Player.log carries OUR command line.
#
# Environment:  MOD (required)  REPO (monorepo root)  OUT (where copies go)  WAIT (max queue minutes, 240)
set -uo pipefail

BUNDLE="${1:?usage: MOD=<Mod> run-on-bundle.sh <bundle-folder> <filter> [launcher args]}"
FILTER="${2:?usage: MOD=<Mod> run-on-bundle.sh <bundle-folder> <filter> [launcher args]}"
shift 2
: "${MOD:?set MOD to the mod whose suite is played, e.g. MOD=ArchitectStudio}"

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO="${REPO:-$(cd "$HERE/../../.." && pwd)}"
OUT="${OUT:-$HOME/pickle-bundles/runs}"
WAIT="${WAIT:-240}"
[ -d "$BUNDLE/About" ] || { echo "error: $BUNDLE is not a mod folder (no About/)" >&2; exit 1; }
[ -f "$REPO/scripts/Run-PickleWsl.ps1" ] || { echo "error: no launcher at $REPO/scripts" >&2; exit 1; }
mkdir -p "$OUT"

label="$(basename "$BUNDLE")--${FILTER//[^A-Za-z0-9._-]/_}"
raw="$OUT/$label.txt"
start="$(date +%s)"

cd "$REPO"
powershell -NoProfile -ExecutionPolicy Bypass -File scripts/Run-PickleWsl.ps1 \
  -Mod "$MOD" -PickleSrc "$(cygpath -w "$BUNDLE")" -Filter "$FILTER" -MaxWaitMinutes "$WAIT" "$@" > "$raw" 2>&1
code=$?

echo "=== $label  (launcher exit $code) ==="
grep -aE "^(total|passed|failed|skipped|exitReason)|mods :|error:|abandonne|aucun rapport" "$raw" | cut -c1-200

log="$REPO/pickle-reports/Player.log"
if [ -f "$log" ] && grep -a "Command line arguments" "$log" | grep -aq -- "-pickle-run=$FILTER" \
   && [ "$(stat -c %Y "$log")" -ge "$start" ]; then
  cp "$REPO/pickle-reports/junit.xml" "$OUT/$label.junit.xml" 2>/dev/null
  cp "$log" "$OUT/$label.Player.log"
  # The captures of THIS run only: the screenshots folder is never emptied, so a file older than the
  # launch belongs to an earlier run, and reading it as this run's is the same mistake as the report.
  mkdir -p "$OUT/$label.screenshots"
  find "$REPO/pickle-reports/screenshots" -type f -newermt "@$start" -exec cp -t "$OUT/$label.screenshots" {} + 2>/dev/null
  echo "captures of this run: $(ls "$OUT/$label.screenshots" 2>/dev/null | wc -l) in $OUT/$label.screenshots"
  echo "report: ours (its command line is -pickle-run=$FILTER), kept in $OUT/$label.*"
  grep -B3 "<failure" "$OUT/$label.junit.xml" 2>/dev/null | grep -o 'testcase name="[^"]*"' | sed 's/^/  failed: /'
else
  echo "report: NONE of ours - this run wrote nothing; whatever is in pickle-reports belongs to another run, do not read it"
fi
echo
echo "limit: the bundle is proved staged only by the launcher's 'override:' line, which its own output"
echo "       truncates. A scenario that can only pass on the patched Pickle is the real proof."
exit "$code"
