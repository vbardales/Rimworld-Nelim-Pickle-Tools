<# Packages the optional VEF companion only; it is never added to the Workshop aggregate. #>
[CmdletBinding()]
param([Parameter(Mandatory)][string]$Destination)
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot
$source = Join-Path $root 'QuietNewFactions'
foreach ($file in @("$source/Mod/About/About.xml", "$source/Mod/Assemblies/QuietNewFactions.dll", "$source/README.md", "$source/STATUS.md")) {
    if (-not (Test-Path -LiteralPath $file -PathType Leaf)) { throw "Quiet New Factions is not ready: missing $file" }
}
[xml]$about = Get-Content -LiteralPath "$source/Mod/About/About.xml"
if ($about.ModMetaData.packageId -ne 'nelim.quietnewfactions') { throw 'Unexpected Quiet New Factions packageId' }
$dependencies = @($about.ModMetaData.modDependencies.li.packageId)
foreach ($required in @('brrainz.harmony','OskarPotocki.VanillaFactionsExpanded.Core')) {
    if ($dependencies -notcontains $required) { throw "Quiet New Factions lacks $required" }
}
if (Test-Path -LiteralPath $Destination) { throw "Destination already exists: $Destination" }
New-Item -ItemType Directory -Path "$Destination/Mod/About", "$Destination/Mod/Assemblies" -Force | Out-Null
Copy-Item "$source/Mod/About/About.xml" "$Destination/Mod/About/"
Copy-Item "$source/Mod/Assemblies/QuietNewFactions.dll" "$Destination/Mod/Assemblies/"
Copy-Item "$source/README.md", "$source/STATUS.md" $Destination
[pscustomobject]@{
    packageId = 'nelim.quietnewfactions'; optional = $true
    assembly_sha256 = (Get-FileHash "$source/Mod/Assemblies/QuietNewFactions.dll" -Algorithm SHA256).Hash
    dependencies = $dependencies
} | ConvertTo-Json -Depth 5 | Set-Content "$Destination/manifest.json" -Encoding UTF8
