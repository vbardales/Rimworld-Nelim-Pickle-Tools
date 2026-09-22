<#
.SYNOPSIS
  Exercise TextureOwnership, the part of the steps that decides and words the verdict, against hand-made
  lists of providers. No game.

.DESCRIPTION
  The class is pure BCL, so the built assembly can be loaded here and called directly. What this pins down:

    1. A claim that holds returns nothing (null), and one that does not returns a sentence.
    2. Every failure names the WINNER (the last provider, which is what ContentFinder returns) and lists every
       mod shipping the path in load order: the person reading a report wants to know who took the path.
    3. The three reasons a named mod does not answer are told apart: it ships the path and loses, it is
       running and ships nothing there, it is not running at all.
    4. A path no mod ships is a sentence of its own, not a pass; a count below one is refused, not passed.
    5. Package ids compare without regard to case or surrounding blanks.

  WHAT THIS DOES NOT SHOW: that the running mods and their content holders answer this way in a game (the last
  wins is read from the IL of ContentFinder, and played only where the report says so), nor that Pickle stops a
  step with the sentence the way these cases assume. It shows the decisions and the wording, offline.
#>
param(
    [string]$Dll = (Join-Path $PSScriptRoot 'Mod\Pickle\Assemblies\Nelim.PickleTools.TextureOwner.dll')
)
$ErrorActionPreference = 'Stop'
[Reflection.Assembly]::LoadFrom($Dll) | Out-Null
$rules = [Nelim.PickleTools.TextureOwner.TextureOwnership]

$bad = 0
function Provider($id, $name = $null) {
    New-Object Nelim.PickleTools.TextureOwner.Provider -ArgumentList $id, $(if ($name) { $name } else { "Mod $id" })
}
function Providers([string[]]$ids) {
    $list = New-Object 'System.Collections.Generic.List[Nelim.PickleTools.TextureOwner.Provider]'
    foreach ($i in $ids) { $list.Add((Provider $i)) }
    , $list
}
function Running([string[]]$ids) {
    $list = New-Object 'System.Collections.Generic.List[string]'
    foreach ($i in $ids) { $list.Add($i) }
    , $list
}
# $expect: $null when the claim must hold, otherwise every fragment the sentence must contain.
function Case($name, $verdict, [string[]]$expect) {
    $ok = if ($null -eq $expect -or $expect.Count -eq 0) { $null -eq $verdict }
          else { ($null -ne $verdict) -and -not ($expect | Where-Object { $verdict.IndexOf($_, [StringComparison]::Ordinal) -lt 0 }) }
    if ($ok) { Write-Host "ok    $name" -ForegroundColor Green }
    else { Write-Host "FAIL  $name`n      got: $verdict`n      wanted: $(if ($expect) { $expect -join ' | ' } else { '(nothing)' })" -ForegroundColor Red; $script:bad++ }
}

$path = 'UI/Icons/PassionMajor'
$three = Providers 'ludeon.rimworld', 'oracle.skills.retexture', 'nelim.skillicons'
$allRunning = Running 'brrainz.harmony', 'ludeon.rimworld', 'oracle.skills.retexture', 'nelim.skillicons', 'rimworks.pickle'

# --- the owner claim -----------------------------------------------------------------------------
Case 'the last provider answers: the claim holds' `
     ($rules::OwnerVerdict($path, $three, 'nelim.skillicons', $allRunning)) $null
Case 'case and blanks in the packageId do not matter' `
     ($rules::OwnerVerdict($path, $three, '  Nelim.SkillIcons ', $allRunning)) $null
Case 'the only provider answers' `
     ($rules::OwnerVerdict($path, (Providers 'nelim.skillicons'), 'nelim.skillicons', $allRunning)) $null

Case 'ships it and loses: names the winner, lists all in load order, says where the named mod stands' `
     ($rules::OwnerVerdict($path, $three, 'oracle.skills.retexture', $allRunning)) `
     @("'$path' resolves to 'Mod nelim.skillicons' (nelim.skillicons), not to 'oracle.skills.retexture'",
       'Mods shipping it, in load order: ludeon.rimworld -> oracle.skills.retexture -> nelim.skillicons',
       'in position 2 of 3', 'loads before the winner', 'The mod that loads last wins')
Case 'ships it and loses, the first of the list' `
     ($rules::OwnerVerdict($path, $three, 'ludeon.rimworld', $allRunning)) @('in position 1 of 3')
Case 'running but ships nothing at that path' `
     ($rules::OwnerVerdict($path, $three, 'rimworks.pickle', $allRunning)) `
     @("resolves to 'Mod nelim.skillicons'", 'ludeon.rimworld -> oracle.skills.retexture -> nelim.skillicons', "'rimworks.pickle' is running but ships no texture at that path")
Case 'not running at all' `
     ($rules::OwnerVerdict($path, $three, 'someone.else', $allRunning)) `
     @("resolves to 'Mod nelim.skillicons'", 'ludeon.rimworld -> oracle.skills.retexture -> nelim.skillicons', "'someone.else' is not among the running mods at all")
Case 'not running, and the running list is unknown (null): still says it does not answer' `
     ($rules::OwnerVerdict($path, $three, 'someone.else', $null)) @('is not among the running mods at all')
Case 'a provider that is the winner but is named by a different case is still the winner' `
     ($rules::OwnerVerdict($path, (Providers 'A.b', 'C.d'), 'c.D', $null)) $null

# --- the contest claim ---------------------------------------------------------------------------
Case 'three ship it, three asked' ($rules::ContestVerdict($path, $three, 3)) $null
Case 'three ship it, two asked'   ($rules::ContestVerdict($path, $three, 2)) $null
Case 'one ships it, one asked'    ($rules::ContestVerdict($path, (Providers 'nelim.skillicons'), 1)) $null
Case 'one ships it, two asked: names the count, the shippers and the winner' `
     ($rules::ContestVerdict($path, (Providers 'nelim.skillicons'), 2)) `
     @("'$path' is shipped by 1 running mod(s), expected at least 2", 'Mods shipping it, in load order: nelim.skillicons',
       "It resolves to 'Mod nelim.skillicons' (nelim.skillicons)", 'not actually loaded')
Case 'three ship it, four asked: the list is complete' `
     ($rules::ContestVerdict($path, $three, 4)) @('shipped by 3 running mod(s), expected at least 4', 'ludeon.rimworld -> oracle.skills.retexture -> nelim.skillicons')

# --- what must not pass --------------------------------------------------------------------------
Case 'a path nobody ships is a sentence' ($rules::NoProvider($path)) @("no running mod ships the texture '$path' at all", 'case-sensitive')
Case 'at least 0 is refused'  ($rules::EmptyCount(0))  @('is not a claim')
Case 'at least -1 is refused' ($rules::EmptyCount(-1)) @('is not a claim')
Case 'at least 1 is a claim'  ($rules::EmptyCount(1))  $null
Case 'at least 2 is a claim'  ($rules::EmptyCount(2))  $null

Write-Host ''
if ($bad -gt 0) { Write-Host "$bad CASE(S) FAILED." -ForegroundColor Red; exit 1 }
Write-Host 'ALL CASES PASS' -ForegroundColor Green
exit 0
