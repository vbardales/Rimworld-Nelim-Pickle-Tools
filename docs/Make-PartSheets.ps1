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
foreach ($d in 'evidence/face-parts-gallery-1', 'evidence/face-parts-gallery-23', 'evidence/face-parts-gallery-45', 'Tests/Pickle/Inbox/face-redo', 'Tests/Pickle/Inbox/face-redo-2', 'Tests/Pickle/Inbox/face-redo-5', 'Tests/Pickle/Inbox/face-redo-6', 'Tests/Pickle/Inbox/face-eyeballs-1', 'Tests/Pickle/Inbox/face-eyeballs-2', 'Tests/Pickle/Inbox/face-eyeballs-3', 'Tests/Pickle/Inbox/uw-fa-head-1', 'Tests/Pickle/Inbox/uw-fa-head-2', 'Tests/Pickle/Inbox/uw-fa-head-3', 'Tests/Pickle/Evidence/look-gallery-facetattoo-bald') {
    $s = Join-Path $root "$d/screenshots"
    if (Test-Path $s) { Get-ChildItem $s -File | Where-Object { $_.Name -match '^manual--.*--step0\.(png|jpg)$' } | ForEach-Object { $k = ($_.Name -replace '^manual--', '' -replace '--step0\.(png|jpg)$', ''); $files[$k] = $_.FullName; if ($k -like 'fahead-*') { $files['head-' + $k.Substring(7)] = $_.FullName } } }   # Evidence keeps minified 1280 x 720 JPEG; the Facial Animation head gallery (fahead-<def>) feeds the head shape sheet
}
$kinds = [ordered]@{ mouth = 'Mouths'; brow = 'Brows'; lid = 'Lids'; skin = 'Skins'; skinclose = 'Skin closeups';eyeball = 'Eyeballs'; facetattoo = 'Face tattoos'; head = 'Head shapes'; lidoption = 'Lid options'; emotion = 'Emotion marks' }
# Sheet names (block 28 of Make-LookSheets.ps1's numbering): the number, then a French label.
$sheetName = @{ mouth = '0601 Parties du visage - Bouches'; brow = '0602 Parties du visage - Sourcils'; lid = '0603 Parties du visage - Paupieres'; skin = '0604 Parties du visage - Peaux'; skinclose = '0605 Parties du visage - Peaux en gros plan'
    eyeball = '0606 Parties du visage - Yeux'; head = '0607 Parties du visage - Formes de tete'; facetattoo = '0609 Parties du visage - Tatouages visage'; lidoption = '0610 Parties du visage - Options de paupieres'; emotion = '0611 Parties du visage - Marques d emotion' }
$tile = 220; $label = 22; $cols = 6
$crop = New-Object System.Drawing.Rectangle 868, 118, 184, 184
$cropClose = New-Object System.Drawing.Rectangle 880, 110, 160, 160
$cropWide = New-Object System.Drawing.Rectangle 855, 72, 210, 210   # whole head with a margin (head shapes, face tattoos): the tight crop cut the top of the head (owner, 2026-10-31)
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
        $sc = $img.Width / 1920.0
        $g.DrawImage($img, (New-Object System.Drawing.Rectangle $x, $y, $tile, $tile), $($cr = if ($kind -eq 'skinclose') { $cropClose } elseif ($kind -eq 'head' -or $kind -eq 'facetattoo') { $cropWide } else { $crop }; New-Object System.Drawing.Rectangle ([int][Math]::Round($cr.X * $sc)), ([int][Math]::Round($cr.Y * $sc)), ([int][Math]::Round($cr.Width * $sc)), ([int][Math]::Round($cr.Height * $sc))), [System.Drawing.GraphicsUnit]::Pixel)
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
