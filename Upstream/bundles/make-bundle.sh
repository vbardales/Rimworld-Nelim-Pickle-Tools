#!/usr/bin/env bash
# Build a local Pickle from upstream main plus the named pull requests, and lay it out as a mod
# folder that Run-PickleWsl.ps1 -PickleSrc can stage.
#
#   make-bundle.sh <name> <PR> [<PR>...]
#   make-bundle.sh picker_bundle_23 23
#   make-bundle.sh picker_bundle_19_21 19 21        # two PRs together
#
# Why one bundle per PR and not one bundle of everything: a green run on the merge of six PRs says
# they hold together, not which one fixed what. Build the PR alone for the test that is about it, and
# the whole merge once, for the interactions.
#
# Environment:
#   CLONE    a THROWAWAY clone of Pickle, default ~/pickle-bundles/src. Created if absent. The script
#            resets and cleans it (git clean -fdx), so it refuses any folder it did not create.
#   OUT      where the bundle folders go, default ~/pickle-bundles/out
#   DOTNET   a .NET 10 SDK. Pickle uses C# 14 (`field`) and net10.0 for its tests, and the machine's
#            default SDK is 8: default here is ~/.dotnet/dotnet.exe, which is a 10.
#   WORKSHOP_PICKLE  the Workshop copy of Pickle, to compare its DLL list against (see below)
set -euo pipefail

die() { echo "error: $*" >&2; exit 1; }
NAME="${1:?usage: make-bundle.sh <name> <PR> [<PR>...]}"; shift
[ "$#" -ge 1 ] || die "name at least one pull request"

UPSTREAM="https://github.com/RimWorks/Rimworld-Pickle.git"
CLONE="${CLONE:-$HOME/pickle-bundles/src}"
OUT="${OUT:-$HOME/pickle-bundles/out}"
DOTNET="${DOTNET:-$HOME/.dotnet/dotnet.exe}"
WORKSHOP_PICKLE="${WORKSHOP_PICKLE:-/c/Program Files (x86)/Steam/steamapps/workshop/content/294100/3791648678}"
MARK=".pickle-bundle-clone"

[ -x "$DOTNET" ] || die "no dotnet at $DOTNET. Pickle needs the .NET 10 SDK; set DOTNET."
case "$("$DOTNET" --version)" in 10.*|1[1-9].*) ;; *) die "$DOTNET is $("$DOTNET" --version), Pickle needs 10 or later" ;; esac

if [ ! -d "$CLONE/.git" ]; then
  mkdir -p "$(dirname "$CLONE")"
  git clone -q "$UPSTREAM" "$CLONE"
  : > "$CLONE/$MARK"
fi
[ -f "$CLONE/$MARK" ] || die "$CLONE is not a clone this script made (no $MARK): it would be reset and cleaned"
cd "$CLONE"

git fetch -q "$UPSTREAM" "main:refs/bundle/main" --force
for pr in "$@"; do
  git fetch -q "$UPSTREAM" "pull/$pr/head:refs/bundle/pr-$pr" --force || die "cannot fetch pull request $pr"
done

GIT=(git -c user.email=bundle@local -c user.name=bundle)
git checkout -q -f -B "bundle/$NAME" refs/bundle/main
git clean -fdxq -e "$MARK"

# Two PRs often add their rows to the same table of Docs/steps.md; that conflict is a union.
# Anything else stops the build: a code conflict is a decision, not a chore.
for pr in "$@"; do
  "${GIT[@]}" merge --no-ff -q -m "$NAME: PR $pr" "refs/bundle/pr-$pr" >/dev/null 2>&1 || true
  conflicts="$(git diff --name-only --diff-filter=U)"
  [ -z "$conflicts" ] && continue
  for f in $conflicts; do
    case "$f" in
      Docs/*.md) sed -i '/^<<<<<<< /d;/^=======$/d;/^>>>>>>> /d' "$f"; git add "$f" ;;
      *) git merge --abort 2>/dev/null || true
         die "PR $pr conflicts in $f. Resolve it by hand: the two changes touch the same code." ;;
    esac
  done
  "${GIT[@]}" commit -q -m "$NAME: PR $pr (documentation conflict resolved by union)"
done

# Build every project the game loads, not only the one that names the others: a build made after
# switching branches once came out without Gherkin and the runner played no scenario.
for p in Pickle.Vanilla Pickle.Patches.Harmony Pickle.Patches.Concord; do
  "$DOTNET" build "Source/$p/$p.csproj" -c Release 2>&1 | grep -E " error |Erreur\(s\)|error\(s\)" | tail -2
  "$DOTNET" build "Source/$p/$p.csproj" -c Release >/dev/null 2>&1 || die "$p does not build"
done
tests="$("$DOTNET" test Source/Pickle.Tests/Pickle.Tests.csproj -c Release 2>&1 | grep -aE "Réussi|Échec|Passed|Failed" | tail -1 | sed 's/- Pickle.*//')"
echo "$tests" | grep -qiE "Réussi|Passed" || die "unit tests: ${tests:-no result}"

dest="$OUT/$NAME"; rm -rf "$dest"; mkdir -p "$dest"
for x in About Assemblies Concord Harmony Defs Languages Patches Pickle LICENSE loadFolders.xml; do cp -r "$x" "$dest/"; done

# A bundle must ship what the Workshop build ships, or the game loads a Pickle that cannot load its
# own types. Compared with the Workshop copy rather than a fixed list.
if [ -d "$WORKSHOP_PICKLE/Assemblies" ]; then
  missing=""
  for f in "$WORKSHOP_PICKLE"/Assemblies/*.dll; do [ -f "$dest/Assemblies/$(basename "$f")" ] || missing="$missing $(basename "$f")"; done
  [ -z "$missing" ] || die "the bundle lacks the DLLs the Workshop build ships:$missing"
fi

echo "$NAME  (PR $*)  $(git log --oneline refs/bundle/main..HEAD | wc -l) commits over main  |  $tests"
echo "folder: $dest"
echo "next:   run-on-bundle.sh \"$dest\" <feature-or-filter>"
