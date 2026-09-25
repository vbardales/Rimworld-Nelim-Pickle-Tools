<#
.SYNOPSIS
  Compile the step patterns of the shared RIMMSQOL steps with Pickle's own expression engine, and check
  that none of them is ambiguous against any other suite in the repository or against Pickle's vocabulary.
  No game, a few seconds.

.DESCRIPTION
  Same purpose as FlavorText/FlavorTextExtendedFR/Tests/Pickle/Check-Steps.ps1, which was written after a
  run played zero scenarios because of one character class. This one adds what a SHARED assembly needs:

    1. Every pattern declared under Source\ COMPILES with the PickleParameterTypeRegistry the game uses.
       Parentheses mean optional text and a slash means alternation in a Cucumber Expression, so a text
       such as "reveals/hides" or "at (x, y)" is not what it looks like.
    2. No pattern is declared twice.
    3. AMBIGUITY, which is what sharing makes possible. Pickle loads the steps of every suite installed in
       a run into one namespace and matches on the text alone: two expressions that both match a line make
       it an "Ambiguous step" and fail a healthy scenario. So every step line of every feature in the
       repository is matched against (this assembly's expressions + every other suite's expressions +
       Pickle's own vocabulary, read from RimWorks.Pickle.Vanilla.dll), and a line that one of THIS
       assembly's expressions matches together with any other is reported. Lines that only other suites
       and Pickle match are their business and are not reported here.
    4. Every step line of the feature files that use this vocabulary matches one expression.

  A pattern no feature in the repository uses is reported as weight, not as an error.

.EXAMPLE
  powershell.exe -ExecutionPolicy Bypass -File PickleTools/RimmsqolSteps/Check-Steps.ps1
#>
param(
    [string]$PickleAssemblies = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\3791648678\Assemblies',
    [string]$Cecil = "$env:USERPROFILE\.nuget\packages\mono.cecil\0.11.5\lib\net40\Mono.Cecil.dll"
)
$ErrorActionPreference = 'Stop'
$here = $PSScriptRoot
$repo = Split-Path (Split-Path $here -Parent) -Parent      # ...\rimworld

foreach ($dll in 'CucumberExpressions.dll', 'RimWorks.Pickle.Core.dll') {
    $path = Join-Path $PickleAssemblies $dll
    if (-not (Test-Path $path)) { throw "$dll not found under $PickleAssemblies" }
    [Reflection.Assembly]::LoadFrom($path) | Out-Null
}
Add-Type -Path $Cecil
$core = [AppDomain]::CurrentDomain.GetAssemblies() | Where-Object { $_.GetName().Name -eq 'RimWorks.Pickle.Core' }
$registryType = $core.GetType('RimWorks.Pickle.Core.Steps.PickleParameterTypeRegistry')
if (-not $registryType) { throw 'PickleParameterTypeRegistry no longer exists: Pickle renamed it, update this script.' }
$registry = [Activator]::CreateInstance($registryType)

function New-Expr($pattern) { New-Object CucumberExpressions.CucumberExpression($pattern, $registry) }

# The attribute argument is a C# literal: undo its escaping to get the pattern Pickle sees.
$attr = '\[(?:Given|When|Then)\("((?:[^"\\]|\\.)*)"'
function Read-Patterns($dir, $source) {
    foreach ($f in Get-ChildItem -LiteralPath $dir -Filter *.cs -ErrorAction SilentlyContinue) {
        $text = [IO.File]::ReadAllText($f.FullName)
        foreach ($m in [regex]::Matches($text, $attr)) {
            [pscustomobject]@{ Source = $source; File = $f.Name; Pattern = ($m.Groups[1].Value -replace '\\\\', '\' -replace '\\"', '"') }
        }
        # A file that declares `const string Prefix = "..."` and writes its attributes as Prefix + "..." (ScreenshotStudio).
        $pre = [regex]::Match($text, 'const string Prefix\s*=\s*"((?:[^"\\]|\\.)*)"')
        if ($pre.Success) {
            foreach ($m in [regex]::Matches($text, '\[(?:Given|When|Then)\(Prefix\s*\+\s*"((?:[^"\\]|\\.)*)"')) {
                [pscustomobject]@{ Source = $source; File = $f.Name; Pattern = (($pre.Groups[1].Value + $m.Groups[1].Value) -replace '\\\\', '\' -replace '\\"', '"') }
            }
        }
    }
}

$bad = 0

# --- 1 and 2. this assembly ------------------------------------------------------------------------

$mine = @(Read-Patterns (Join-Path $here 'Source') 'shared:RimmsqolSteps')
if ($mine.Count -eq 0) { throw "no step patterns under $here\Source: the attribute shape this script looks for has changed" }

foreach ($g in ($mine | Group-Object Pattern | Where-Object { $_.Count -gt 1 })) {
    Write-Host "DUPLICATE  $($g.Name)  (declared $($g.Count) times)" -ForegroundColor Red; $bad++
}
$myExprs = @()
foreach ($d in $mine) {
    try { $myExprs += [pscustomobject]@{ Source = $d.Source; Pattern = $d.Pattern; Regex = (New-Expr $d.Pattern).Regex; Used = $false } }
    catch {
        $e = $_.Exception; while ($e.InnerException) { $e = $e.InnerException }
        Write-Host "INVALID  $($d.File): $($d.Pattern)`n         $($e.Message.Split("`n")[0])" -ForegroundColor Red; $bad++
    }
}

# --- everything else that shares the namespace -----------------------------------------------------

$others = @()

# Pickle's own vocabulary, read from the attributes of RimWorks.Pickle.Vanilla.dll.
# Two assemblies carry steps: Vanilla, and the runner itself (the save steps, "no errors were logged").
foreach ($name in 'RimWorks.Pickle.Vanilla.dll', 'RimWorks.Pickle.dll') {
    $asm = [Mono.Cecil.AssemblyDefinition]::ReadAssembly((Join-Path $PickleAssemblies $name))
    foreach ($t in $asm.MainModule.GetTypes()) {
        foreach ($m in $t.Methods) {
            foreach ($a in $m.CustomAttributes | Where-Object { $_.AttributeType.Name -in 'GivenAttribute', 'WhenAttribute', 'ThenAttribute' }) {
                $others += [pscustomobject]@{ Source = 'pickle'; Pattern = [string]$a.ConstructorArguments[0].Value }
            }
        }
    }
}
# Handled by the runner without an attribute the extraction sees. Not derived: the evidence is that the
# features Pickle ships (Pickle\Features\*.feature) use it verbatim, and that FlavorTextExtendedFR's own
# English pass, which begins every scenario with it, ran to its end on 2026-09-21.
foreach ($p in 'the save {string} is loaded') { $others += [pscustomobject]@{ Source = 'pickle-engine'; Pattern = $p } }
$vanillaCount = $others.Count

# Every other suite of the repository. A top-level junction (FlavorTextExtendedFR points at the nested
# repository) would count its suite twice.
$suiteDirs = @()
foreach ($top in Get-ChildItem -LiteralPath $repo -Directory) {
    if ($top.Attributes -band [IO.FileAttributes]::ReparsePoint) { continue }
    $suiteDirs += $top.FullName
    foreach ($sub in Get-ChildItem -LiteralPath $top.FullName -Directory -ErrorAction SilentlyContinue) {
        if ($sub.Name -in 'Tests', 'Mod', 'Source', '.git', '.build') { continue }
        if (Test-Path -LiteralPath (Join-Path $sub.FullName 'Tests\Pickle')) { $suiteDirs += $sub.FullName }
    }
}
$suites = 0
foreach ($dir in $suiteDirs | Sort-Object -Unique) {
    $src = Join-Path $dir 'Tests\Pickle\Source'
    if (-not (Test-Path -LiteralPath $src)) { continue }
    $suites++
    foreach ($p in Read-Patterns $src ('suite:' + (Split-Path $dir -Leaf))) { $others += $p }
}
# The sibling tools of this repository (FilmTicks, ColonistRace, ...) are steps assemblies too, and a pass
# may stage several of them together: their expressions share the namespace with these.
$toolsRoot = Split-Path $here -Parent
foreach ($d in Get-ChildItem -LiteralPath $toolsRoot -Directory -ErrorAction SilentlyContinue |
         Where-Object { $_.FullName -ne $here -and (Test-Path -LiteralPath (Join-Path $_.FullName 'Source')) }) {
    foreach ($p in Read-Patterns (Join-Path $d.FullName 'Source') ('tool:' + $d.Name)) { $others += $p }
}
$otherExprs = @()
foreach ($o in $others) {
    try { $otherExprs += [pscustomobject]@{ Source = $o.Source; Pattern = $o.Pattern; Regex = (New-Expr $o.Pattern).Regex } } catch { }   # their own check reports those
}

# --- 3 and 4. every step line of every feature ------------------------------------------------------

$featureFiles = @()
foreach ($dir in $suiteDirs | Sort-Object -Unique) {
    $fd = Join-Path $dir 'Tests\Pickle\Mod\Pickle\Features'
    if (Test-Path -LiteralPath $fd) { $featureFiles += Get-ChildItem -LiteralPath $fd -Filter *.feature }
}

$lines = 0; $ambiguous = @{}; $unresolved = @()
foreach ($file in $featureFiles) {
    foreach ($raw in [IO.File]::ReadAllLines($file.FullName)) {
        if ($raw.Trim() -notmatch '^(Given|When|Then|And|But)\s+(.+)$') { continue }
        $step = $Matches[2].Trim(); $lines++
        $mineHit = @($myExprs | Where-Object { $_.Regex.IsMatch($step) })
        if ($mineHit.Count -eq 0) { continue }
        foreach ($h in $mineHit) { $h.Used = $true }
        $otherHit = @($otherExprs | Where-Object { $_.Regex.IsMatch($step) })
        if ($mineHit.Count -gt 1 -or $otherHit.Count -gt 0) {
            $key = "$step"
            $names = @($mineHit | ForEach-Object { 'shared "' + $_.Pattern + '"' }) + @($otherHit | ForEach-Object { "$($_.Source) `"$($_.Pattern)`"" })
            $ambiguous[$key] = "$($file.Name): matches " + ($names -join ' AND ')
        }
    }
}

# The features that use this vocabulary must resolve completely: any RIMMSQOL line no expression matches.
foreach ($file in $featureFiles | Where-Object { $_.Name -like '*rimmsqol*' }) {
    foreach ($raw in [IO.File]::ReadAllLines($file.FullName)) {
        if ($raw.Trim() -notmatch '^(Given|When|Then|And|But)\s+(.+)$') { continue }
        $step = $Matches[2].Trim()
        $all = @($myExprs + $otherExprs | Where-Object { $_.Regex.IsMatch($step) })
        if ($all.Count -eq 0) { $unresolved += "$($file.Name): $step" }
    }
}

# --- report --------------------------------------------------------------------------------------

Write-Host ''
Write-Host "$($mine.Count) shared patterns, $($myExprs.Count) compile. Compared against $($otherExprs.Count) others: $vanillaCount from Pickle, $($otherExprs.Count - $vanillaCount) from $suites suites and the sibling tools. $lines step lines in $($featureFiles.Count) feature files."

foreach ($k in $ambiguous.Keys) { Write-Host "AMBIGUOUS  $k`n           $($ambiguous[$k])" -ForegroundColor Red; $bad++ }

$unused = @($myExprs | Where-Object { -not $_.Used })
if ($unused.Count -gt 0) {
    Write-Host ''
    Write-Host "$($unused.Count) shared pattern(s) no feature in the repository uses - weight, not coverage:" -ForegroundColor Yellow
    foreach ($u in $unused) { Write-Host "  $($u.Pattern)" -ForegroundColor Yellow }
}

if ($unresolved.Count -gt 0) {
    Write-Host ''
    Write-Host "$($unresolved.Count) step line(s) of the rimmsqol features match no expression at all (shared, other suites, Pickle):" -ForegroundColor Red
    $unresolved | Sort-Object -Unique | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
    $bad++
}

Write-Host ''
if ($bad -gt 0) {
    Write-Host "$bad PROBLEM(S). An invalid pattern makes a run play zero scenarios (infrastructure-error); an ambiguous line fails a healthy scenario." -ForegroundColor Red
    exit 1
}
Write-Host 'ALL PATTERNS COMPILE, NONE DECLARED TWICE, NONE AMBIGUOUS, EVERY RIMMSQOL LINE RESOLVES' -ForegroundColor Green
exit 0
