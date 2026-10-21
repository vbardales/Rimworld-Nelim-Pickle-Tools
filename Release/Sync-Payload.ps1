<#
Keeps Mod/ (what the publish workflow uploads as committed) identical to the fourteen tool DLLs. Everything else of a release
(requirePaths, forbidPaths, Preview, description, change note, tag, GitHub release, Steam upload) is the CI/CD's, see
Rimworld-Release-Admin; the local build check is scripts/Build-Mod.ps1.

  -SyncMod    copies the fourteen tool DLLs (each tool's tracked Mod/Pickle/Assemblies) and ATTRIBUTION.md into the
              repository's own Mod/. Commit the result.
  -Check      changes nothing: fails if Mod/Pickle/Assemblies is not exactly the fourteen tool DLLs, byte for byte, or
              if Mod/ATTRIBUTION.md differs from the root one, or if docs/steps.md is not current. Run it before every release.
#>
[CmdletBinding()]
param([switch]$SyncMod, [switch]$Check)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot
$tools = @('ClearScreen','ClickDiagnostics','ColonistRace','ExpansionSteps','FilmTicks','HoverSteps','InspectTabs','InterfaceScale','KeyedClick','ResearchSteps','RimmsqolSteps','ScreenshotMode','TextureOwner','VefFactionSteps')

if ($SyncMod -or $Check) {
    $target = Join-Path $root 'Mod/Pickle/Assemblies'
    $expected = [ordered]@{}
    foreach ($tool in $tools) {
        $dlls = @(Get-ChildItem "$root/$tool/Mod/Pickle/Assemblies" -Filter '*.dll')
        if ($dlls.Count -ne 1 -or $dlls[0].Name -notlike 'Nelim.PickleTools.*.dll') { throw "Unexpected assemblies: $tool" }
        $expected[$dlls[0].Name] = $dlls[0].FullName
    }
    if ($SyncMod) {
        New-Item -ItemType Directory -Path $target -Force | Out-Null
        Get-ChildItem $target -File | Where-Object { -not $expected.Contains($_.Name) } | Remove-Item -Force
        foreach ($name in $expected.Keys) { Copy-Item $expected[$name] (Join-Path $target $name) -Force }
        Copy-Item "$root/ATTRIBUTION.md" "$root/Mod/ATTRIBUTION.md" -Force
        Write-Output "Mod/ synced: $($expected.Count) DLLs and ATTRIBUTION.md. Commit them."
        if (-not $Check) { return }
    }
    $problems = @()
    $present = @(Get-ChildItem $target -File -ErrorAction SilentlyContinue)
    foreach ($f in $present) { if (-not $expected.Contains($f.Name)) { $problems += "unexpected file in Mod/Pickle/Assemblies: $($f.Name)" } }
    foreach ($name in $expected.Keys) {
        $committed = Join-Path $target $name
        if (-not (Test-Path $committed)) { $problems += "missing from Mod/Pickle/Assemblies: $name"; continue }
        if ((Get-FileHash $committed -Algorithm SHA256).Hash -ne (Get-FileHash $expected[$name] -Algorithm SHA256).Hash) { $problems += "differs from the tool's tracked DLL: $name" }
    }
    if ((Get-FileHash "$root/ATTRIBUTION.md" -Algorithm SHA256).Hash -ne (Get-FileHash "$root/Mod/ATTRIBUTION.md" -Algorithm SHA256).Hash) { $problems += 'Mod/ATTRIBUTION.md differs from ATTRIBUTION.md' }
    foreach ($needed in 'About/About.xml','About/ModIcon.png','About/Preview.png','About/PublishedFileId.txt','LICENSE') { if (-not (Test-Path "$root/Mod/$needed")) { $problems += "missing from Mod/: $needed" } }
    $stepsDoc = & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $root 'docs/Generate-Steps.ps1') -Check
    if ($LASTEXITCODE -ne 0) { $problems += 'docs/steps.md is not current: run docs/Generate-Steps.ps1'; $stepsDoc | ForEach-Object { $problems += "  $_" } }
    if ($problems.Count) { $problems | ForEach-Object { Write-Output "PROBLEM  $_" }; exit 1 }
    Write-Output "Mod/ payload OK: $($expected.Count) DLLs identical to the tracked tool DLLs."
    return
}
throw 'Nothing to do: pass -SyncMod or -Check.'
