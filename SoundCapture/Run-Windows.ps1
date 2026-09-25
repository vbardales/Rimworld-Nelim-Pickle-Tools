<#
.SYNOPSIS
  Runs a Pickle test on the WINDOWS RimWorld, for the SoundCapture tests only, in a profile of its own. Nothing happens
  without -Go: the default is a dry run that checks and prints the plan.

.DESCRIPTION
  AUDIT.md's rule is that no session launches the Windows game. The owner made one exception on 2026-09-25: tests that use
  SoundCapture are played ALONE and on Windows, with the mod list changed for the run and put back after. This script is
  that exception's launcher and is not to be used for anything else.

  How the mod list is "changed then put back" without touching hers: the game is started with -savedatafolder pointing at
  a profile of this script's own (.build/windows-sound/profile). Its Config/ModsConfig.xml and Config/Prefs.xml are written
  there, so the owner's ModsConfig.xml, Prefs.xml, saves and settings are never opened. What does touch her install is
  the game's Mods/ folder: the test companion and the pass map's local mods are put there as junctions named
  zz-picklesound-*, and REMOVED in a finally block; the folder's listing before and after is compared and printed.

  Preconditions it checks, and refuses on: the Windows game already running; the WSL game running; Steam not running (the
  install has steam_appid.txt, so the exe starts by itself, but the Workshop copies need Steam's folder); a missing Workshop
  copy of Harmony or Pickle. It does not take the machine lock itself: RUN IT THROUGH scripts/Use-Wsl.ps1, which queues,
  takes the lock and writes LOCK/WORK/UNLOCK to the machine log, and pass -UnderLock to say so:

    powershell.exe -ExecutionPolicy Bypass -File scripts/Use-Wsl.ps1 -Reason 'SoundCapture on Windows (owner exception)' `
      -Command "powershell.exe -NoProfile -ExecutionPolicy Bypass -File C:/Users/nelim/Documents/rimworld/PickleTools/SoundCapture/Run-Windows.ps1 -Go -UnderLock"

  Only the owner asks for this run. The game ends itself (Pickle's autorun exits); if it outlives -RunTimeoutMinutes plus a
  margin, this script closes the process IT started, and says so.

.PARAMETER Filter    A Pickle filter (default: the SoundCapture scenarios).
.PARAMETER DepMap    A pass map of PickleTools/Tests/Pickle (default wsl-deps.soundcapture.map). Lines: `packageId workshopId`
                     (a Workshop copy that must be installed), `packageId path:<folder of the collection>`, `!packageId` (a DLC left out).
.PARAMETER Language  English, French... resolved against Data/Core/Languages.
.PARAMETER Watch     Pickle's watch mode: waits pass real time, for a run the owner listens to.
.PARAMETER Volume    The master volume written to the profile (0..1). The WSL staging writes 0.
.PARAMETER EvidenceDir  Where the report is copied (relative to the collection root), like the launcher's.
#>
[CmdletBinding()]
param(
    [switch]$Go,
    [switch]$UnderLock,
    [string]$Filter = 'pickletools-soundcapture',
    [string]$DepMap = 'wsl-deps.soundcapture.map',
    [string]$Language = 'English',
    [switch]$Watch,
    [double]$Volume = 0.8,
    [int]$RunTimeoutMinutes = 10,
    [string]$PickleSrc,
    [string]$EvidenceDir
)
$ErrorActionPreference = 'Stop'

$here      = $PSScriptRoot
$tools     = Split-Path $here -Parent
$repo      = Split-Path $tools -Parent
$game      = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld'
$workshop  = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100'
$modsDir   = Join-Path $game 'Mods'
$work      = Join-Path $tools '.build\windows-sound'
$profile   = Join-Path $work 'profile'
$report    = Join-Path $work 'report'
$prefix    = 'zz-picklesound-'

function Say($m) { Write-Output $m }
$script:blockers = @()
function Refuse($m) { throw "REFUSED: $m" }
# A check on the machine's state: it stops a run (-Go), and only lists what would stop one in a dry run.
function Block($m) { if ($Go) { throw "REFUSED: $m" } else { $script:blockers += $m } }

# --- checks (read-only) --------------------------------------------------------------------------------------------
if (Get-Process -Name RimWorldWin64 -ErrorAction SilentlyContinue) { Block 'the Windows game is already running. Never close a running game: wait, or ask the owner.' }
$wslGame = & wsl.exe -- bash -lc "pgrep -f '[.]/RimWorldLinux' || true" 2>$null
if ($wslGame) { Block "a WSL game is running (pid $($wslGame -join ',')). One RimWorld at a time on this machine." }
if (-not (Get-Process -Name steam -ErrorAction SilentlyContinue)) { Block 'Steam is not running on Windows.' }
if (-not (Test-Path (Join-Path $game 'RimWorldWin64.exe'))) { Refuse "no game at $game" }
if ($Go -and -not $UnderLock) { Refuse 'pass -UnderLock, and run this through scripts/Use-Wsl.ps1 so the machine lock is held (see the header).' }

# --- the mod set ---------------------------------------------------------------------------------------------------
$active = New-Object System.Collections.Generic.List[string]
$junctions = @()   # @{ Name; Target }
function Need-Workshop($id, $what) {
    $p = Join-Path $workshop $id
    if (-not (Test-Path (Join-Path $p 'About\About.xml'))) { Block "$what is not installed from the Workshop ($p)" }
}
Need-Workshop 2009463077 'Harmony'
$active.Add('brrainz.harmony')
$active.Add('ludeon.rimworld')
foreach ($dlc in 'royalty','ideology','biotech','anomaly','odyssey') {
    if (Test-Path (Join-Path $game "Data\$($dlc.Substring(0,1).ToUpper() + $dlc.Substring(1))")) { $active.Add("ludeon.rimworld.$dlc") }
}
if ($PickleSrc) {
    if (-not (Test-Path (Join-Path $PickleSrc 'About\About.xml'))) { Refuse "no mod at -PickleSrc $PickleSrc" }
    $junctions += @{ Name = "${prefix}pickle"; Target = (Resolve-Path $PickleSrc).Path }
} else { Need-Workshop 3791648678 'Pickle' }
$active.Add('rimworks.pickle')
$junctions += @{ Name = "${prefix}tests"; Target = (Join-Path $tools 'Tests\Pickle\Mod') }
$active.Add('nelim.pickletools.studiotests')

$mapPath = Join-Path $tools "Tests\Pickle\$DepMap"
if (-not (Test-Path $mapPath)) { Refuse "no pass map $mapPath" }
$n = 0
foreach ($raw in Get-Content $mapPath) {
    $line = ($raw -replace '#.*$', '').Trim()
    if (-not $line) { continue }
    if ($line.StartsWith('!')) { $out = $line.Substring(1).Trim(); [void]$active.Remove($out); continue }
    $first = $false
    if ($line.StartsWith('first:')) { $first = $true; $line = $line.Substring(6).Trim() }
    $parts = $line -split '\s+'
    if ($parts.Count -lt 2) { Refuse "map line not understood: $raw" }
    $id = $parts[0]; $where = $parts[1]
    if ($where.StartsWith('path:')) {
        $folder = Join-Path $repo ($where.Substring(5) -replace '/', '\')
        $abouts = Join-Path $folder 'About\About.xml'
        if (-not (Test-Path $abouts)) { Refuse "no mod at $folder" }
        [xml]$x = Get-Content $abouts
        if ([string]$x.ModMetaData.packageId -ne $id) { Refuse "$folder declares $($x.ModMetaData.packageId), the map says $id" }
        $n++; $junctions += @{ Name = "${prefix}map$n"; Target = $folder }
    } else { Need-Workshop $where $id }
    if ($first) { $active.Insert(0, $id) } elseif (-not $active.Contains($id)) { $active.Add($id) }
}

# --- files of the profile, and the command line -------------------------------------------------------------------
$langDir = Get-ChildItem (Join-Path $game 'Data\Core\Languages') | Where-Object { $_.Name -like "$Language*" } | Select-Object -First 1
if (-not $langDir) { Refuse "no language starting with '$Language' in Data/Core/Languages" }
$version = (Get-Content (Join-Path $game 'Version.txt') -TotalCount 1).Trim()
$prefs = @"
<?xml version="1.0" encoding="utf-8"?>
<PrefsData>
  <langFolderName>$($langDir.BaseName)</langFolderName>
  <devMode>True</devMode>
  <volumeMaster>$($Volume.ToString([Globalization.CultureInfo]::InvariantCulture))</volumeMaster>
  <screenWidth>1280</screenWidth>
  <screenHeight>720</screenHeight>
  <fullscreen>False</fullscreen>
  <uiScale>1</uiScale>
  <runInBackground>True</runInBackground>
  <testMapSizes>True</testMapSizes>
</PrefsData>
"@
$modsConfig = "<?xml version=`"1.0`" encoding=`"utf-8`"?>`n<ModsConfigData>`n  <version>$version</version>`n  <activeMods>`n" +
    (($active | ForEach-Object { "    <li>$_</li>" }) -join "`n") +
    "`n  </activeMods>`n  <knownExpansions>`n" +
    ((@('royalty','ideology','biotech','anomaly','odyssey') | ForEach-Object { "    <li>ludeon.rimworld.$_</li>" }) -join "`n") +
    "`n  </knownExpansions>`n</ModsConfigData>`n"
$args = @("-savedatafolder=`"$profile`"", "-pickle-run=`"$Filter`"", '-pickle-no-browser', '-pickle-http-port=27750',
          "-pickle-run-timeout=$RunTimeoutMinutes", "-pickle-set-name=soundcapture-windows", "-pickle-report-dir=`"$report`"",
          "-logfile `"$(Join-Path $report 'Player.log')`"")
if ($Watch) { $args += '-pickle-mode=watch' }

Say "PLAN (game $version, language $($langDir.BaseName), volume $Volume)"
Say "  profile      : $profile   (the owner's Config, Prefs and saves are not touched)"
Say "  report       : $report"
Say "  active mods  : $($active -join ', ')"
foreach ($j in $junctions) { Say "  junction     : $modsDir\$($j.Name) -> $($j.Target)   (removed afterwards)" }
Say "  command line : RimWorldWin64.exe $($args -join ' ')"
if ($blockers.Count) { Say 'WOULD BE REFUSED NOW:'; $blockers | ForEach-Object { Say "  - $_" } }
if (-not $Go) { Say 'DRY RUN: nothing was created or launched. Add -Go -UnderLock, through Use-Wsl.ps1, to run.'; return }

# --- the run: everything below changes something, and is undone in finally --------------------------------------------
$before = @(Get-ChildItem $modsDir -Force | ForEach-Object Name | Sort-Object)
$made = @()
$proc = $null
try {
    if (Test-Path $work) { Remove-Item $work -Recurse -Force }
    New-Item -ItemType Directory -Path "$profile\Config", $report -Force | Out-Null
    [IO.File]::WriteAllText("$profile\Config\Prefs.xml", $prefs, (New-Object Text.UTF8Encoding($false)))
    [IO.File]::WriteAllText("$profile\Config\ModsConfig.xml", $modsConfig, (New-Object Text.UTF8Encoding($false)))
    foreach ($j in $junctions) {
        $link = Join-Path $modsDir $j.Name
        if (Test-Path $link) { Refuse "$link already exists: a previous run did not clean up. Look before deleting." }
        New-Item -ItemType Junction -Path $link -Target $j.Target | Out-Null
        $made += $link
    }
    $psi = New-Object Diagnostics.ProcessStartInfo (Join-Path $game 'RimWorldWin64.exe')
    $psi.Arguments = ($args -join ' ')
    $psi.WorkingDirectory = $game
    $psi.UseShellExecute = $false
    $proc = [Diagnostics.Process]::Start($psi)
    Say "game started, pid $($proc.Id)"
    $limit = ($RunTimeoutMinutes + 3) * 60 * 1000
    if (-not $proc.WaitForExit($limit)) {
        Say "The game outlived the run timeout plus a margin: closing the process THIS script started (pid $($proc.Id))."
        $proc.Kill(); $proc.WaitForExit(15000) | Out-Null
    }
    Say "game exited, code $($proc.ExitCode)"
} finally {
    foreach ($link in $made) { if (Test-Path $link) { [IO.Directory]::Delete($link, $false) } }
    $after = @(Get-ChildItem $modsDir -Force | ForEach-Object Name | Sort-Object)
    if (($before -join '|') -eq ($after -join '|')) { Say "Mods folder restored: the same $($after.Count) entries as before." }
    else { Say "WARNING: the Mods folder differs from before. Added: $((Compare-Object $before $after | Where-Object SideIndicator -eq '=>' | ForEach-Object InputObject) -join ', ') Removed: $((Compare-Object $before $after | Where-Object SideIndicator -eq '<=' | ForEach-Object InputObject) -join ', ')"; exit 3 }
}
$summary = Join-Path $report 'summary.json'
if (Test-Path $summary) {
    $j = Get-Content $summary -Raw | ConvertFrom-Json
    Say "report: exitReason $($j.exitReason), $($j.passed)/$($j.total) passed, $($j.failed) failed, $($j.skipped) skipped"
} else { Say 'NO REPORT (no summary.json): read Player.log in the report folder; this is not a result.' }
if ($EvidenceDir) {
    $dest = Join-Path $repo $EvidenceDir
    if (Test-Path $dest) { Refuse "$dest already exists" }
    New-Item -ItemType Directory -Path $dest -Force | Out-Null
    Get-ChildItem $report -File | Copy-Item -Destination $dest
    Say "report copied to $dest"
}
