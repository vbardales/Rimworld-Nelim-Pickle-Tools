<#
Creates local candidate archives; never tags, uploads or publishes.

  -SyncMod    copies the fourteen tool DLLs (each tool's tracked Mod/Pickle/Assemblies) and ATTRIBUTION.md into the
              repository's own Mod/, which is what the publish workflow uploads as committed. Commit the result.
  -Check      changes nothing: fails if Mod/Pickle/Assemblies is not exactly the fourteen tool DLLs, byte for byte, or
              if Mod/ATTRIBUTION.md differs from the root one. Run it before every release.
              -Check also runs docs/Generate-Steps.ps1 -Check: the step catalogue must be current.
  -Rebuild    with -Check: also rebuilds each tool from Source/ into a temporary folder and REPORTS (NOTE, never a failure)
              the tools whose rebuild is not byte-identical to the tracked DLL. It is informational: the package references
              float (RimWorks.Pickle.Ref 4.*, Krafs.Rimworld.Ref 1.6.*), so a rebuild differs even when the source did not
              change (all thirteen differed on 2026-09-25, the tracked DLLs being those the tests played). The gate is the
              hash comparison of -Check, not the rebuild. -DotNet names the dotnet to use (the .NET 10 SDK is at
              C:\Users\nelim\.dotnet10\dotnet.exe).
#>
[CmdletBinding()]
param([string]$Version = '0.1.0-rc.1', [switch]$IncludeScreenshotStudio, [switch]$IncludeQuietNewFactions,
      [switch]$SyncMod, [switch]$Check, [switch]$Rebuild, [string]$DotNet = 'dotnet')
$ErrorActionPreference = 'Stop'
if ($Version -notmatch '^\d+\.\d+\.\d+(-[A-Za-z0-9.]+)?$') { throw 'Invalid version' }
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
    if ($Rebuild) {
        $temp = Join-Path ([IO.Path]::GetTempPath()) ('pickletools-rebuild-' + [guid]::NewGuid().ToString('N'))
        New-Item -ItemType Directory -Path $temp | Out-Null
        try {
            foreach ($tool in $tools) {
                $proj = @(Get-ChildItem "$root/$tool/Source" -Filter '*.csproj')[0]
                $outDir = Join-Path $temp $tool
                & $DotNet build $proj.FullName -c Release "-p:OutputPath=$outDir\" -v q --nologo | Out-Null
                if ($LASTEXITCODE -ne 0) { $problems += "rebuild failed: $tool"; continue }
                foreach ($built in Get-ChildItem $outDir -Filter 'Nelim.PickleTools.*.dll') {
                    if (-not $expected.Contains($built.Name)) { continue }
                    if ((Get-FileHash $built.FullName -Algorithm SHA256).Hash -ne (Get-FileHash $expected[$built.Name] -Algorithm SHA256).Hash) { Write-Output "NOTE     rebuild is not byte-identical to the tracked DLL: $($built.Name)" }
                }
            }
        } finally { Remove-Item $temp -Recurse -Force -ErrorAction SilentlyContinue }
    }
    if ($problems.Count) { $problems | ForEach-Object { Write-Output "PROBLEM  $_" }; exit 1 }
    Write-Output "Mod/ payload OK: $($expected.Count) DLLs identical to the tracked tool DLLs."
    return
}
$out = Join-Path $root ('.build/releases/' + $Version + '-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
if (Test-Path $out) { throw "Output already exists: $out" }
$tree = Join-Path $out 'PickleTools'
New-Item -ItemType Directory -Path $tree -Force | Out-Null
$bundle = Join-Path $tree 'Mod'
New-Item -ItemType Directory -Path "$bundle/About","$bundle/Pickle/Assemblies" -Force | Out-Null
Copy-Item "$root/Mod/About/About.xml","$root/Mod/About/ModIcon.png","$root/Mod/About/Preview.png" "$bundle/About/"
if (Test-Path "$root/Mod/About/PublishedFileId.txt") { Copy-Item "$root/Mod/About/PublishedFileId.txt" "$bundle/About/" }
Copy-Item "$root/LICENSE","$root/ATTRIBUTION.md" $bundle
$manifest = @()
$ids = @{}
foreach ($tool in $tools) {
    $source = Join-Path $root "$tool/Mod"
    [xml]$about = Get-Content -LiteralPath "$source/About/About.xml"
    $id = [string]$about.ModMetaData.packageId
    if (-not $id.StartsWith('nelim.pickletools.') -or $ids.ContainsKey($id)) { throw "Invalid/duplicate package: $id" }
    $ids[$id] = $true
    if (@($about.ModMetaData.modDependencies.li.packageId) -notcontains 'rimworks.pickle') { throw "$tool lacks Pickle dependency" }
    if (-not (Test-Path "$source/LICENSE")) { throw "$tool lacks LICENSE" }
    $dlls = @(Get-ChildItem "$source/Pickle/Assemblies" -Filter '*.dll')
    if ($dlls.Count -ne 1 -or $dlls[0].Name -notlike 'Nelim.PickleTools.*.dll') { throw "Unexpected assemblies: $tool" }
    $dest = Join-Path $tree $tool
    New-Item -ItemType Directory -Path $dest | Out-Null
    # Explicit payload allowlist: no fixtures, user settings, build debris or third-party DLLs.
    New-Item -ItemType Directory -Path "$dest/Mod/About","$dest/Mod/Pickle/Assemblies" -Force | Out-Null
    Copy-Item "$source/About/About.xml" "$dest/Mod/About/"
    Copy-Item "$root/Mod/About/ModIcon.png","$root/Mod/About/Preview.png" "$dest/Mod/About/"
    Copy-Item "$source/LICENSE" "$dest/Mod/"
    Copy-Item $dlls[0].FullName "$dest/Mod/Pickle/Assemblies/"
    Copy-Item "$root/$tool/README.md" "$dest/README.md"
    Copy-Item "$root/ATTRIBUTION.md" "$dest/Mod/ATTRIBUTION.md"
    $manifest += [pscustomobject]@{ tool=$tool; packageId=$id; assembly=$dlls[0].Name; sha256=(Get-FileHash $dlls[0].FullName -Algorithm SHA256).Hash; dependencies=@($about.ModMetaData.modDependencies.li.packageId) }
    Copy-Item $dlls[0].FullName "$bundle/Pickle/Assemblies/"
}
Compress-Archive -Path "$bundle/*" -DestinationPath "$out/PickleTools-$Version-workshop.zip"
foreach ($doc in @('README.md','LICENSE','ATTRIBUTION.md','STATUS.md','CHANGELOG.md','TESTING.md','PUBLICATION.md')) { Copy-Item "$root/$doc" $tree }
foreach ($folder in @('Authoring','Headless','Elsewhere','Release')) { Copy-Item "$root/$folder" $tree -Recurse }
New-Item -ItemType Directory -Path "$tree/Upstream" | Out-Null
Copy-Item "$root/Upstream/README.md","$root/Upstream/PENDING.md","$root/Upstream/LICENSE-Pickle" "$tree/Upstream/"
Copy-Item "$PSScriptRoot/README.md" "$tree/RELEASE.md"
$revision = (& git -C $root rev-parse HEAD).Trim()
[pscustomobject]@{ version=$Version; candidate=$true; sourceRevision=$revision; workingTreeDirty=[bool](& git -C $root status --porcelain); runtimeValidated=$false; tools=$manifest } | ConvertTo-Json -Depth 6 | Set-Content "$tree/manifest.json" -Encoding UTF8
if ($IncludeScreenshotStudio) {
    & "$PSScriptRoot/Package-ScreenshotStudio.ps1" -Destination "$tree/ScreenshotStudio"
    Compress-Archive -Path "$tree/ScreenshotStudio" -DestinationPath "$out/PickleTools-$Version-screenshot-studio.zip"
}
if ($IncludeQuietNewFactions) {
    & "$PSScriptRoot/Package-QuietNewFactions.ps1" -Destination "$tree/QuietNewFactions"
    Compress-Archive -Path "$tree/QuietNewFactions" -DestinationPath "$out/PickleTools-$Version-quiet-new-factions.zip"
}
Compress-Archive -Path $tree -DestinationPath "$out/PickleTools-$Version-github.zip"
Get-ChildItem $out -Filter '*.zip' | ForEach-Object { '{0}  {1}' -f (Get-FileHash $_.FullName -Algorithm SHA256).Hash,$_.Name } | Set-Content "$out/SHA256SUMS.txt" -Encoding ASCII
Write-Output "Candidate packages: $out"
