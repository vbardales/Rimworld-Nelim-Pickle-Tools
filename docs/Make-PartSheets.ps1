<#
.SYNOPSIS
  Builds the contact sheets of the face parts gallery (ColonistRace/docs/img/looks/28NN Parties du visage - <name>.jpg) from the photographs of
  evidence/face-parts-gallery-1, -23 and -45, then Tests/Pickle/Inbox/face-redo and face-redo-2 (a later folder replaces the earlier tile of the same value): the face of Nelim cropped out of each 1920 x 1080 capture, with the name of the
  value under it. The captures are gitignored; the sheets are what the documentation keeps.
#>
Add-Type -AssemblyName System.Drawing
$root = Split-Path $PSScriptRoot -Parent
$out = Join-Path $root 'ColonistRace/docs/img/looks'   # no subfolders (owner, 2026-10-28): numbered like the look sheets, block 28
New-Item -ItemType Directory -Force $out | Out-Null
$files = @{}
foreach ($d in 'evidence/face-parts-gallery-1', 'evidence/face-parts-gallery-23', 'evidence/face-parts-gallery-45', 'Tests/Pickle/Inbox/face-redo', 'Tests/Pickle/Inbox/face-redo-2', 'Tests/Pickle/Inbox/face-redo-5', 'Tests/Pickle/Inbox/face-redo-6') {
    $s = Join-Path $root "$d/screenshots"
    if (Test-Path $s) { Get-ChildItem $s -Filter 'manual--*--step0.png' | ForEach-Object { $files[($_.Name -replace '^manual--', '' -replace '--step0\.png$', '')] = $_.FullName } }
}
$kinds = [ordered]@{ mouth = 'Mouths'; brow = 'Brows'; lid = 'Lids'; skin = 'Skins'; skinclose = 'Skin closeups';eyeball = 'Eyeballs'; facetattoo = 'Face tattoos'; head = 'Head shapes'; lidoption = 'Lid options'; emotion = 'Emotion marks'; kit = 'Kits' }
# Sheet names (block 28 of Make-LookSheets.ps1's numbering): the number, then a French label.
$sheetName = @{ mouth = '2801 Parties du visage - Bouches'; brow = '2802 Parties du visage - Sourcils'; lid = '2803 Parties du visage - Paupieres'; skin = '2804 Parties du visage - Peaux'; skinclose = '2805 Parties du visage - Peaux en gros plan'
    eyeball = '2806 Parties du visage - Yeux'; head = '2807 Parties du visage - Formes de tete'; kit = '2808 Parties du visage - Kits'; facetattoo = '2809 Parties du visage - Tatouages visage'; lidoption = '2810 Parties du visage - Options de paupieres'; emotion = '2811 Parties du visage - Marques d emotion' }
$tile = 220; $label = 22; $cols = 6
$crop = New-Object System.Drawing.Rectangle 868, 118, 184, 184
$cropClose = New-Object System.Drawing.Rectangle 880, 110, 160, 160
$font = New-Object System.Drawing.Font 'Segoe UI', 9
foreach ($kind in $kinds.Keys) {
    $names = @($files.Keys | Where-Object { $_ -like "$kind-*" } | Sort-Object)
    if (-not $names) { continue }
    $rows = [Math]::Ceiling($names.Count / $cols)
    $bmp = New-Object System.Drawing.Bitmap ($cols * $tile), ($rows * ($tile + $label))
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.Clear([System.Drawing.Color]::White)
    for ($i = 0; $i -lt $names.Count; $i++) {
        $x = ($i % $cols) * $tile; $y = [Math]::Floor($i / $cols) * ($tile + $label)
        $img = [System.Drawing.Image]::FromFile($files[$names[$i]])
        $g.DrawImage($img, (New-Object System.Drawing.Rectangle $x, $y, $tile, $tile), $(if ($kind -eq 'skinclose') { $cropClose } else { $crop }), [System.Drawing.GraphicsUnit]::Pixel)
        $img.Dispose()
        $text = $names[$i].Substring($kind.Length + 1)
        $g.DrawString($text, $font, [System.Drawing.Brushes]::Black, [float]($x + 2), [float]($y + $tile + 3))
    }
    $g.Dispose()
    $path = Join-Path $out ($sheetName[$kind] + ".jpg")
    $enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object MimeType -eq 'image/jpeg'
    $p = New-Object System.Drawing.Imaging.EncoderParameters 1
    $p.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), 82L
    $bmp.Save($path, $enc, $p); $bmp.Dispose()
    Write-Output ("{0}: {1} photos -> {2}" -f $kind, $names.Count, $path)
}
