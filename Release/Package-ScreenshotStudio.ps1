<# Packages the optional studio only; never adds it to the Workshop aggregate. #>
[CmdletBinding()]
param([Parameter(Mandatory)][string]$Destination)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot
$source = Join-Path $root 'ScreenshotStudio'
$fixture = Join-Path $source 'Mod/Pickle/Fixtures/nelim-zen-meadow-studio.rws'
$verification = Join-Path $source 'evidence/2026-09-22-zen/verification.json'
foreach ($file in @($fixture,$verification,"$source/Mod/Pickle/Fixtures/LICENSE-Pickle","$source/Mod/LICENSE","$source/README.md","$source/STATUS.md")) {
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) { throw "ScreenshotStudio is not ready: missing $file" }
}
$proof = Get-Content -LiteralPath $verification -Raw | ConvertFrom-Json
$hash = (Get-FileHash -LiteralPath $fixture -Algorithm SHA256).Hash
if ($proof.save_sha256 -ne $hash) { throw 'ScreenshotStudio fixture does not match its export evidence' }
[xml]$save = Get-Content -LiteralPath $fixture -Raw
if (-not $save.savegame.game.maps.li) { throw 'ScreenshotStudio fixture has no map' }
[xml]$about = Get-Content -LiteralPath "$source/Mod/About/About.xml"
if ($about.ModMetaData.packageId -ne 'nelim.pickletools.screenshotstudio') { throw 'Unexpected studio packageId' }
$dlls = @(Get-ChildItem "$source/Mod/Pickle/Assemblies" -Filter '*.dll')
if ($dlls.Count -ne 1 -or $dlls[0].Name -ne 'Nelim.PickleTools.ScreenshotStudio.dll') { throw 'Unexpected studio assemblies' }
if (Test-Path -LiteralPath $Destination) { throw "Destination already exists: $Destination" }
New-Item -ItemType Directory -Path "$Destination/Mod/About","$Destination/Mod/Pickle/Assemblies","$Destination/Mod/Pickle/Fixtures" -Force | Out-Null
Copy-Item "$source/Mod/About/About.xml" "$Destination/Mod/About/"
Copy-Item $dlls[0].FullName "$Destination/Mod/Pickle/Assemblies/"
Copy-Item $fixture,"$source/Mod/Pickle/Fixtures/LICENSE-Pickle" "$Destination/Mod/Pickle/Fixtures/"
Copy-Item "$source/Mod/LICENSE" "$Destination/Mod/"
Copy-Item "$source/README.md","$source/STATUS.md" $Destination
Copy-Item $verification "$Destination/verification.json"
[pscustomobject]@{
    packageId='nelim.pickletools.screenshotstudio'; optional=$true
    fixture='nelim-zen-meadow-studio'; save_sha256=$hash
    assembly_sha256=(Get-FileHash $dlls[0].FullName -Algorithm SHA256).Hash
    dependencies=@($about.ModMetaData.modDependencies.li.packageId)
    independentFixtureLoadValidated=$false
} | ConvertTo-Json -Depth 5 | Set-Content "$Destination/manifest.json" -Encoding UTF8
