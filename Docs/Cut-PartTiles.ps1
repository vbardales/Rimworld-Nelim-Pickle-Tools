<#
.SYNOPSIS
  One-off (idempotent): cuts the tiles of the old single face-part contact sheets (6 columns, 220 px tiles, 22 px labels, values sorted by name) into the tile cache
  ColonistRace/docs/img/looks/tiles/<block>00-<kind>-<defName>.jpg (200 px), because the run folders of that gallery are gone. Make-LookSheets.ps1 then builds
  one sheet per mod from the cache. Kinds: mouth (0601), brow (0602), lid (0603), faceskin (0604), skinclose (0605), eyeball (0606).
  The names are the values of the tables of catalogues/face-parts.md, sorted; the number of tiles must match the number of cells of the sheet.
  The head shapes (0607) and face tattoos (0609) sheets are not cut: the same values are on the Facial Animation head sheet and the face tattoo sheets.
#>
Add-Type -AssemblyName System.Drawing
$root = Split-Path $PSScriptRoot -Parent
$looks = Join-Path $root 'ColonistRace/docs/img/looks'
$tiles = Join-Path $looks 'tiles'
$md = Get-Content (Join-Path $root 'ColonistRace/docs/catalogues/face-parts.md') -Encoding UTF8
function Section-Names($title) {
    $names = @(); $in = $false
    foreach ($line in $md) {
        if ($line -match '^## ') { $in = $line -match $title; continue }
        if ($in -and $line -match '^\| (?!Mod|---)') { $names += (($line.Trim().Trim('|').Split('|')[-1].Trim() -replace '^\(\d+\) ', '') -split ', ') }
    }
    @($names | Sort-Object)
}
# kind, block, sheet, names. The closeup sheet shows 8 of the 22 skins (the ones with a visible mark), read from the sheet itself.
$jobs = @(
    @{ kind = 'mouth'; block = 30; sheet = '0601 Parties du visage - Bouches.jpg'; names = (Section-Names '^## Mouths') },
    @{ kind = 'brow'; block = 31; sheet = '0602 Parties du visage - Sourcils.jpg'; names = (Section-Names '^## Brows') },
    @{ kind = 'lid'; block = 32; sheet = '0603 Parties du visage - Paupieres.jpg'; names = (Section-Names '^## Lids') },
    @{ kind = 'faceskin'; block = 33; sheet = '0604 Parties du visage - Peaux.jpg'; names = (Section-Names '^## Skins') },
    @{ kind = 'skinclose'; block = 35; sheet = '0605 Parties du visage - Peaux en gros plan.jpg'; names = @('AKN_SkinSnoot', 'SkinDecrepit', 'SkinFreckles2', 'SkinFreckles3', 'SkinFurrows', 'SkinLeftChin', 'SkinRightEye', 'SkinTiredEyes') },
    @{ kind = 'eyeball'; block = 34; sheet = '0606 Parties du visage - Yeux.jpg'; names = (Section-Names '^## Eyeballs') }
)
$enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object MimeType -eq 'image/jpeg'
$p = New-Object System.Drawing.Imaging.EncoderParameters 1
$p.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), 80L
foreach ($j in $jobs) {
    $path = Join-Path $looks $j.sheet
    if (-not (Test-Path $path)) { Write-Output "$($j.kind): sheet gone, skipped"; continue }
    $img = [System.Drawing.Image]::FromFile($path)
    $cells = [Math]::Floor($img.Height / 242) * 6; $rowsUsed = [Math]::Ceiling($j.names.Count / 6)
    if ([Math]::Ceiling($img.Height / 242.0) -ne $rowsUsed) { throw "$($j.kind): $($j.names.Count) names do not fit the sheet height $($img.Height)" }
    for ($i = 0; $i -lt $j.names.Count; $i++) {
        $src = New-Object System.Drawing.Rectangle (($i % 6) * 220), ([Math]::Floor($i / 6) * 242), 220, 220
        $tb = New-Object System.Drawing.Bitmap 200, 200
        $g = [System.Drawing.Graphics]::FromImage($tb); $g.InterpolationMode = 'HighQualityBicubic'
        $g.DrawImage($img, (New-Object System.Drawing.Rectangle 0, 0, 200, 200), $src, [System.Drawing.GraphicsUnit]::Pixel); $g.Dispose()
        $tb.Save((Join-Path $tiles ("{0}00-{1}-{2}.jpg" -f $j.block, $j.kind, $j.names[$i])), $enc, $p); $tb.Dispose()
    }
    $img.Dispose()
    Write-Output "$($j.kind): $($j.names.Count) tiles cut"
}
