<# Creates local candidate archives; never tags, uploads or publishes. #>
[CmdletBinding()]
param([string]$Version = '0.1.0-rc.1', [switch]$IncludeScreenshotStudio)
$ErrorActionPreference = 'Stop'
if ($Version -notmatch '^\d+\.\d+\.\d+(-[A-Za-z0-9.]+)?$') { throw 'Invalid version' }
$root = Split-Path $PSScriptRoot
$tools = @('ClearScreen','ClickDiagnostics','ColonistRace','ExpansionSteps','FilmTicks','InspectTabs','InterfaceScale','KeyedClick','ResearchSteps','RimmsqolSteps','ScreenshotMode','TextureOwner','VefFactionSteps')
$out = Join-Path $root ('.build/releases/' + $Version + '-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
if (Test-Path $out) { throw "Output already exists: $out" }
$tree = Join-Path $out 'PickleTools'
New-Item -ItemType Directory -Path $tree -Force | Out-Null
$bundle = Join-Path $tree 'Mod'
New-Item -ItemType Directory -Path "$bundle/About","$bundle/Pickle/Assemblies" -Force | Out-Null
Copy-Item "$root/Mod/About/About.xml","$root/Mod/About/ModIcon.png","$root/Mod/About/Preview.png" "$bundle/About/"
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
foreach ($doc in @('README.md','LICENSE','ATTRIBUTION.md','STATUS.md','CHANGELOG.md','TESTING.md')) { Copy-Item "$root/$doc" $tree }
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
Compress-Archive -Path $tree -DestinationPath "$out/PickleTools-$Version-github.zip"
Get-ChildItem $out -Filter '*.zip' | ForEach-Object { '{0}  {1}' -f (Get-FileHash $_.FullName -Algorithm SHA256).Hash,$_.Name } | Set-Content "$out/SHA256SUMS.txt" -Encoding ASCII
Write-Output "Candidate packages: $out"
