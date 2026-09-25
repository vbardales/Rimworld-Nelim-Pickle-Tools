<#
.SYNOPSIS
  Writes docs/steps.md, the catalogue of the Pickle steps this repository ships, from the attributes in the tools' Source/.

.DESCRIPTION
  Pickle documents its own steps in Docs/steps.md (https://github.com/RimWorks/Rimworld-Pickle/blob/main/Docs/steps.md); this
  is the same thing for the steps of PickleTools. Nothing in it is written by hand: for each tool folder it reads every
  [Given(...)], [When(...)] and [Then(...)] attribute of Source/*.cs (a pattern written as Prefix + "..." is resolved from
  the file's `const string Prefix`), and takes the first sentences of the XML summary above it as the description. With no
  summary, it takes the description from the row of the tool's README table that names the same step. A step found in neither is
  listed with "(no description yet)", and the run says so.

  -Check changes nothing: it exits 1 if docs/steps.md is not what the sources would give, and lists the steps that are
  missing or that no longer exist, so a step added without regenerating the catalogue is caught.

.EXAMPLE
  powershell.exe -ExecutionPolicy Bypass -File PickleTools/docs/Generate-Steps.ps1          # rewrite docs/steps.md
  powershell.exe -ExecutionPolicy Bypass -File PickleTools/docs/Generate-Steps.ps1 -Check   # verify it is current
#>
[CmdletBinding()]
param([switch]$Check)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$out  = Join-Path $PSScriptRoot 'steps.md'
$utf8 = New-Object Text.UTF8Encoding($false)

$attr = [regex]'\[(Given|When|Then)\(\s*((?:[A-Za-z_]+\s*\+\s*)?)"((?:[^"\\]|\\.)*)"[^\]]*\]'

function Get-Summary([string]$text, [int]$index) {
    $lines = $text.Substring(0, $index).Split("`n")
    $doc = @()
    for ($i = $lines.Count - 2; $i -ge 0; $i--) {
        $l = $lines[$i].TrimEnd("`r")
        if ($l -match '^\s*///') { $doc = @($l) + $doc; continue }
        if ($l -match '^\s*\[' -or $l -match '^\s*//[^/]') { continue }
        break
    }
    if (-not $doc) { return '' }
    $body = ($doc | ForEach-Object { $_ -replace '^\s*///\s?', '' }) -join ' '
    $m = [regex]::Match($body, '<summary>(.*?)</summary>')
    if (-not $m.Success) { return '' }
    $s = $m.Groups[1].Value
    $s = [regex]::Replace($s, '<c>(.*?)</c>', '`$1`')
    $s = [regex]::Replace($s, '<see cref="([^"]*)"\s*/>', '$1')
    $s = [regex]::Replace($s, '<paramref name="([^"]*)"\s*/>', '$1')
    $s = [regex]::Replace($s, '<[^>]+>', '')
    $s = ($s -replace '\s+', ' ').Trim()
    $s = $s -replace '&lt;', '<' -replace '&gt;', '>' -replace '&amp;', '&'
    # the first sentences, up to about 340 characters
    $sent = [regex]::Matches($s, '[^.]*\.(?:\s|$)') | ForEach-Object { $_.Value.Trim() }
    if (-not $sent) { return $s }
    $take = ''
    foreach ($x in $sent) { if (($take + ' ' + $x).Length -gt 340 -and $take) { break }; $take = ($take + ' ' + $x).Trim() }
    return $take
}

$readmeRows = @{}
function Get-ReadmeRow([string]$toolDir, [string]$pattern) {
    if (-not $readmeRows.ContainsKey($toolDir)) {
        $rows = @{}
        $rm = Join-Path $toolDir 'README.md'
        if (Test-Path $rm) {
            foreach ($line in [IO.File]::ReadAllLines($rm)) {
                $m = [regex]::Match($line, '^\|\s*`([^`]+)`\s*\|\s*(.+?)\s*\|\s*$')
                if ($m.Success -and -not $rows.ContainsKey($m.Groups[1].Value)) { $rows[$m.Groups[1].Value] = $m.Groups[2].Value }
            }
        }
        $readmeRows[$toolDir] = $rows
    }
    $d = $readmeRows[$toolDir][$pattern]
    if (-not $d) { return '' }
    $d = [regex]::Replace($d, '\s+', ' ').Trim()
    if ($d.Length -gt 340) { $d = $d.Substring(0, 337) + '...' }
    return $d
}

$bundleDlls = @()
$modAsm = Join-Path $root 'Mod\Pickle\Assemblies'
if (Test-Path $modAsm) { $bundleDlls = @(Get-ChildItem $modAsm -Filter '*.dll' | ForEach-Object Name) }

$sections = @()
$empty = @()
$total = 0
foreach ($dir in Get-ChildItem $root -Directory | Sort-Object Name) {
    $src = Join-Path $dir.FullName 'Source'
    if (-not (Test-Path $src)) { continue }
    $steps = @()
    foreach ($f in Get-ChildItem $src -Filter '*.cs' -File | Sort-Object Name) {
        $text = [IO.File]::ReadAllText($f.FullName)
        $prefix = ''
        $pm = [regex]::Match($text, 'const string Prefix\s*=\s*"((?:[^"\\]|\\.)*)"')
        if ($pm.Success) { $prefix = $pm.Groups[1].Value }
        foreach ($m in $attr.Matches($text)) {
            $pattern = $m.Groups[3].Value
            if ($m.Groups[2].Value.Trim()) { $pattern = $prefix + $pattern }
            $pattern = $pattern -replace '\\\\', '\' -replace '\\"', '"'
            $desc = Get-Summary $text $m.Index
            if (-not $desc) { $desc = Get-ReadmeRow $dir.FullName $pattern }
            if (-not $desc) { $empty += "$($dir.Name): $pattern"; $desc = '(no description yet)' }
            $steps += [pscustomobject]@{ Keyword = $m.Groups[1].Value; Pattern = $pattern; Desc = $desc }
        }
    }
    if (-not $steps) { continue }
    $about = Join-Path $dir.FullName 'Mod\About\About.xml'
    $pkg = ''
    if (Test-Path $about) { [xml]$x = [IO.File]::ReadAllText($about); $pkg = [string]$x.ModMetaData.packageId }
    $dll = @(Get-ChildItem (Join-Path $dir.FullName 'Mod\Pickle\Assemblies') -Filter '*.dll' -ErrorAction SilentlyContinue | ForEach-Object Name)
    $inBundle = ($dll.Count -gt 0) -and ($bundleDlls -contains $dll[0])
    $total += $steps.Count
    $lines = @()
    $lines += "## $($dir.Name)"
    $lines += ''
    $lines += ("Package ``{0}``. {1}. [README](../{2}/README.md).  " -f $pkg, $(if ($inBundle) { 'In the bundle (`Mod/Pickle/Assemblies`)' } else { 'Not in the bundle: a companion staged by a pass map' }), $dir.Name)
    $lines += ''
    $lines += '| Step | Does |'
    $lines += '| --- | --- |'
    foreach ($s in $steps) {
        $p = ($s.Pattern -replace '\|', '\|')
        $d = ($s.Desc -replace '\|', '\|')
        $lines += "| ``$p`` ($($s.Keyword)) | $d |"
    }
    $sections += ($lines -join "`n")
}

$head = @"
# Steps of Nelim's Pickle Tools

The Pickle steps this repository ships, one table per tool. **Pickle's own steps are in its catalogue:
[Docs/steps.md](https://github.com/RimWorks/Rimworld-Pickle/blob/main/Docs/steps.md)** (defs, mods, fixtures, pawns,
simulation, interface...); look there first, and here for what Pickle does not have. Every step here starts with
``Nelim's Pickle Tools:`` so it can never be ambiguous with one of Pickle's, and is staged with one line of a pass map
("Using a tool from a suite" in the [README](../README.md)).

This file is **generated** from the ``[Given]``, ``[When]`` and ``[Then]`` attributes of each tool's ``Source/`` and the first
sentences of the summary above them: do not edit it, run ``docs/Generate-Steps.ps1`` (``-Check`` verifies that it is current).
$total steps. The keyword in brackets is the one the source declares; Pickle matches on the text alone, so a scenario may
use ``Given``, ``When``, ``Then`` or ``And`` as it reads best. What a step does not say here (its limits, what was played and what
was not) is in the tool's README.

"@
$head = $head.TrimEnd() + "`n`n"
$doc = ($head.Replace("`r`n", "`n")) + ($sections -join "`n`n") + "`n"

if ($Check) {
    $current = if (Test-Path $out) { [IO.File]::ReadAllText($out).Replace("`r`n", "`n") } else { '' }
    if ($current -eq $doc) { Write-Output "docs/steps.md is current: $total steps."; exit 0 }
    $have = @([regex]::Matches($current, '(?m)^\| `([^`]+)` ') | ForEach-Object { $_.Groups[1].Value })
    $want = @([regex]::Matches($doc, '(?m)^\| `([^`]+)` ') | ForEach-Object { $_.Groups[1].Value })
    foreach ($m in ($want | Where-Object { $have -notcontains $_ })) { Write-Output "MISSING from docs/steps.md: $m" }
    foreach ($m in ($have | Where-Object { $want -notcontains $_ })) { Write-Output "NO LONGER IN THE SOURCES: $m" }
    Write-Output 'docs/steps.md is not current: run docs/Generate-Steps.ps1'
    exit 1
}
[IO.File]::WriteAllText($out, $doc, $utf8)
Write-Output "wrote $out ($total steps in $($sections.Count) tools)"
if ($empty.Count) { Write-Output "$($empty.Count) step(s) with no summary above them:"; $empty | ForEach-Object { Write-Output "  $_" } }
