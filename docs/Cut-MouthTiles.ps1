<#
.SYNOPSIS
  One-off: cuts the 38 mouth tiles out of the old single contact sheet "0601 Parties du visage - Bouches.jpg" (6 columns, 220 px tiles, 22 px labels, values sorted by name)
  into the tile cache ColonistRace/docs/img/looks/tiles/3000-mouth-<defName>.jpg (200 px), because the run folders of that gallery are gone. Make-LookSheets.ps1 then builds
  one sheet per mod from the cache (kind mouth, block 30). Run it once, then delete the old sheet.
#>
Add-Type -AssemblyName System.Drawing
$root = Split-Path $PSScriptRoot -Parent
$sheet = Join-Path $root 'ColonistRace/docs/img/looks/0601 Parties du visage - Bouches.jpg'
$tiles = Join-Path $root 'ColonistRace/docs/img/looks/tiles'
$names = @(); $in = $false
foreach ($line in (Get-Content (Join-Path $root 'ColonistRace/docs/catalogues/face-parts.md') -Encoding UTF8)) {
    if ($line -match '^## ') { $in = $line -match '^## Mouths'; continue }
    if ($in -and $line -match '^\| (?!Mod|---)' ) { $names += (($line.Trim().Trim('|').Split('|')[-1].Trim() -replace '^\(\d+\) ', '') -split ', ') }
}
$names = @($names | Sort-Object)
if ($names.Count -ne 38) { throw "expected 38 mouths, found $($names.Count)" }
$enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object MimeType -eq 'image/jpeg'
$p = New-Object System.Drawing.Imaging.EncoderParameters 1
$p.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), 80L
$img = [System.Drawing.Image]::FromFile($sheet)
for ($i = 0; $i -lt $names.Count; $i++) {
    $src = New-Object System.Drawing.Rectangle (($i % 6) * 220), ([Math]::Floor($i / 6) * 242), 220, 220
    $tb = New-Object System.Drawing.Bitmap 200, 200
    $g = [System.Drawing.Graphics]::FromImage($tb); $g.InterpolationMode = 'HighQualityBicubic'
    $g.DrawImage($img, (New-Object System.Drawing.Rectangle 0, 0, 200, 200), $src, [System.Drawing.GraphicsUnit]::Pixel); $g.Dispose()
    $tb.Save((Join-Path $tiles ("3000-mouth-$($names[$i]).jpg")), $enc, $p); $tb.Dispose()
}
$img.Dispose()
Write-Output "$($names.Count) tiles cut"
