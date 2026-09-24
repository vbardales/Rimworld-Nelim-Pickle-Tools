<#
.SYNOPSIS
  Rewrites docs/runs/aggregate.md from the reports kept on disk in evidence/aggregate/.

.DESCRIPTION
  The reports themselves (Player.log, screenshots, junit.xml, report.html) are not in git: evidence/ is ignored.
  This keeps the one thing worth reading later, a table of what each pass said, in a text file that is.
  A folder without a summary.json is listed as NO REPORT with the first line of its no-report.txt, never as a result.
  Rows already in aggregate.md whose folder is no longer on disk are KEPT: deleting a superseded report (the disk
  rule in AGENTS.md) must not delete its line. A folder still on disk overwrites its own row.
  A -Then chain keeps one folder per launch (seq1, seq2, ...): each is a row.

.EXAMPLE
  powershell.exe -ExecutionPolicy Bypass -File PickleTools/docs/runs/Summarize-Aggregate.ps1
#>
$ErrorActionPreference = 'Stop'
$root = Split-Path (Split-Path $PSScriptRoot -Parent) -Parent
$dir  = Join-Path $root 'evidence\aggregate'
$out  = Join-Path $PSScriptRoot 'aggregate.md'

function Row($name, $folder) {
    $sj = Join-Path $folder 'summary.json'
    if (-not (Test-Path -LiteralPath $sj)) {
        $why = 'no summary.json'
        $nr = Join-Path $folder 'no-report.txt'
        if (Test-Path -LiteralPath $nr) { $why = ((Get-Content -LiteralPath $nr -TotalCount 1) -replace '[\|\r\n]', ' ').Trim() }
        return "| $name | NO REPORT | - | $why |"
    }
    $j = Get-Content -LiteralPath $sj -Raw | ConvertFrom-Json
    $names = ($j.scenarios | ForEach-Object { $_.name -replace '\|', '/' }) -join '; '
    if ($names.Length -gt 150) { $names = $names.Substring(0, 147) + '...' }
    # A scenario that passed only on a retry is counted as flaky, not passed: it is not a clean pass.
    $flaky = if ($null -ne $j.flaky) { ", flaky $($j.flaky)" } else { '' }
    "| $name | $($j.exitReason) | $($j.passed)/$($j.total) (failed $($j.failed), skipped $($j.skipped)$flaky) | $names |"
}

$byFolder = [ordered]@{}
if (Test-Path -LiteralPath $out) {
    foreach ($line in Get-Content -LiteralPath $out) {
        if ($line -match '^\| (20\d\d-\d\d-\d\d[^ ]*) \|') { $byFolder[$Matches[1]] = $line }
    }
}
foreach ($d in Get-ChildItem -LiteralPath $dir -Directory | Sort-Object Name) {
    $chain = Get-ChildItem -LiteralPath $d.FullName -Directory -Filter 'seq*' -ErrorAction SilentlyContinue | Sort-Object Name
    if ($chain) { foreach ($s in $chain) { $byFolder["$($d.Name)/$($s.Name)"] = Row "$($d.Name)/$($s.Name)" $s.FullName } }
    else { $byFolder[$d.Name] = Row $d.Name $d.FullName }
}
$rows = $byFolder.Keys | Sort-Object | ForEach-Object { $byFolder[$_] }

$text = @(
    '# Aggregate passes: what each report said',
    '',
    "Generated $(Get-Date -Format 'yyyy-MM-dd HH:mm') by ``Summarize-Aggregate.ps1`` from ``evidence/aggregate/`` on the machine that ran them.",
    'The reports are not in git and the superseded ones are deleted (AGENTS.md, Test evidence); their rows stay. Read `exitReason` before the counts; a NO REPORT row is an infrastructure record, not a result.',
    'The Pickle version is in the folder name (`v4.8.4`, `v4.9.1`); a folder without one ran against the staged Workshop copy.',
    '',
    '| Folder | exitReason | Scenarios passed/total | Scenarios |',
    '|---|---|---|---|'
) + $rows
[IO.File]::WriteAllText($out, (($text -join "`n") + "`n"), (New-Object Text.UTF8Encoding($false)))
"wrote $out ($(@($rows).Count) rows)"
