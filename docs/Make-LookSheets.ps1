<#
.SYNOPSIS
  Builds the contact sheets of the look catalogues into ColonistRace/docs/img/looks/<kind>-<mod>-<page>.jpg, in the order of the
  tables of ColonistRace/docs/CATALOGUE-*.md: hairstyles, beards, head types, face and body tattoos, garments, hair and ideology colours,
  the other colours (flat swatches, nothing to photograph), body types (Fat, Hulk, Thin on both sexes), weapons.
  A value with no photograph yet gets an empty hatched tile of the same size with its name and "not photographed": rerun the script
  once the photographs exist and the tile fills. Recipes (craftable items) have no photograph: no sheet.
  Photographs: every Tests/Pickle/Evidence/look-gallery*/screenshots/manual--<prefix>-<name>--step0.png (newest wins).
  Prefixes: hair, beard, head, facetattoo, bodytattoo, garment, haircolour, ideocolour, body (body-<type> or body-<type>-female|male), weapon.
#>
Add-Type -AssemblyName System.Drawing
$root = Split-Path $PSScriptRoot -Parent
$out = Join-Path $root 'ColonistRace/docs/img/looks'
$docs = Join-Path $root 'ColonistRace/docs'
New-Item -ItemType Directory -Force $out | Out-Null

$files = @{}
Get-ChildItem (Join-Path $root 'Tests/Pickle/Evidence') -Directory -Filter 'look-gallery*' | Sort-Object LastWriteTime | ForEach-Object {
    $s = Join-Path $_.FullName 'screenshots'
    if (Test-Path $s) { Get-ChildItem $s -Filter 'manual--*--step0.png' | ForEach-Object { $files[($_.Name -replace '^manual--', '' -replace '--step0\.png$', '')] = $_.FullName } }
}

# Items of one section of a catalogue: @{ mod; group; name; type; hex }
function Read-Section($file, $titleRegex) {
    $items = @(); $in = $false
    foreach ($line in (Get-Content (Join-Path $docs $file) -Encoding UTF8)) {
        if ($line -match '^## ') { $in = $line -match $titleRegex; continue }
        if (-not $in -or $line -notmatch '^\| ' -or $line -match '^\| (Mod|---)') { continue }
        $cells = @($line.Trim().Trim('|').Split('|') | ForEach-Object { $_.Trim() })
        if ($cells.Count -lt 2) { continue }
        $names = ($cells[-1] -replace '^\(\d+\) ', '') -split ', '
        $group = if ($cells.Count -gt 2) { $cells[1] -replace ' \(\d+\)$', '' } else { '' }
        foreach ($r in $names) {
            $type = ''; if ($r -match '\((Face|Body)\)$') { $type = $Matches[1] }
            $hex = ''; if ($r -match '#([0-9A-Fa-f]{6})$') { $hex = $Matches[1]; $r = $r -replace '#[0-9A-Fa-f]{6}$', '' }
            $slot = ''; if ($r -match '\[(.*)\]$') { $slot = $Matches[1] }
            $name = ($r -replace ' \([A-Za-z]+\)$', '' -replace '\[.*\]$', '').Trim()
            $items += [pscustomobject]@{ mod = ($cells[0] -replace ' \(continued\)$', ''); group = $group; name = $name; type = $type; hex = $hex; slot = $slot }
        }
    }
    return $items
}

$cols = 6; $tile = 200; $label = 32; $perPage = 30
$face = New-Object System.Drawing.Rectangle 810, 190, 300, 300
$body = New-Object System.Drawing.Rectangle 760, 320, 400, 400
$font = New-Object System.Drawing.Font 'Segoe UI', 8
$hatch = New-Object System.Drawing.Drawing2D.HatchBrush ([System.Drawing.Drawing2D.HatchStyle]::LightUpwardDiagonal), ([System.Drawing.Color]::FromArgb(225, 225, 225)), ([System.Drawing.Color]::White)
$enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object MimeType -eq 'image/jpeg'
$p = New-Object System.Drawing.Imaging.EncoderParameters 1
$p.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), 80L

# $items: @{ key; name; hex } per tile. $swatchOnly: flat colour tiles, nothing to photograph.
function Build-Sheets($kind, $modName, $items, $crop, $swatchOnly) {
    $slug = ($modName -replace '[^A-Za-z0-9]+', '-').Trim('-').ToLower()
    $pages = [Math]::Ceiling($items.Count / $perPage)
    for ($pg = 0; $pg -lt $pages; $pg++) {
        $part = @($items | Select-Object -Skip ($pg * $perPage) -First $perPage)
        $rows = [Math]::Ceiling($part.Count / $cols)
        $bmp = New-Object System.Drawing.Bitmap ($cols * $tile), ($rows * ($tile + $label))
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.Clear([System.Drawing.Color]::White)
        $have = 0
        for ($i = 0; $i -lt $part.Count; $i++) {
            $x = ($i % $cols) * $tile; $y = [Math]::Floor($i / $cols) * ($tile + $label)
            $r = New-Object System.Drawing.Rectangle $x, $y, $tile, $tile
            $txt = $part[$i].name
            if ($swatchOnly) {
                $c = [System.Drawing.ColorTranslator]::FromHtml('#' + $part[$i].hex)
                $br = New-Object System.Drawing.SolidBrush $c; $g.FillRectangle($br, $r); $br.Dispose(); $have++
                $txt += ' #' + $part[$i].hex
            } elseif ($files.ContainsKey($part[$i].key)) {
                $img = [System.Drawing.Image]::FromFile($files[$part[$i].key])
                $g.DrawImage($img, $r, $crop, [System.Drawing.GraphicsUnit]::Pixel); $img.Dispose(); $have++
            } else {
                $g.FillRectangle($hatch, $r)
                $g.DrawRectangle([System.Drawing.Pens]::LightGray, $x, $y, $tile - 1, $tile - 1)
                $txt += ' (not photographed)'
            }
            if ($part[$i].hex -and -not $swatchOnly) {
                $c = [System.Drawing.ColorTranslator]::FromHtml('#' + $part[$i].hex)
                $br = New-Object System.Drawing.SolidBrush $c; $g.FillRectangle($br, $x + $tile - 40, $y + $tile - 40, 40, 40); $br.Dispose()
                $txt += ' #' + $part[$i].hex
            }
            $box = New-Object System.Drawing.RectangleF ([float]($x + 2)), ([float]($y + $tile + 2)), ([float]($tile - 4)), ([float]($label - 2))
            $g.DrawString($txt, $font, [System.Drawing.Brushes]::Black, $box)
        }
        $g.Dispose()
        $path = Join-Path $out ("{0}-{1}-{2}.jpg" -f $kind, $slug, ($pg + 1))
        $bmp.Save($path, $enc, $p); $bmp.Dispose()
        Write-Output ("{0} {1} p{2}: {3} of {4} -> {5}" -f $kind, $modName, ($pg + 1), $have, $part.Count, ((Split-Path $path -Leaf)))
    }
}
function Run-Job($kind, $prefix, $items, $crop, $swatchOnly, $byGroup) {
    $keyOf = { if ($byGroup) { "$($_.mod) $($_.group)" } else { $_.mod } }
    foreach ($grp in ($items | Group-Object -Property $keyOf)) {
        $tiles = @($grp.Group | ForEach-Object { [pscustomobject]@{ key = "$prefix-$($_.name)"; name = $_.name; hex = $_.hex } })
        Build-Sheets $kind $grp.Name $tiles $crop $swatchOnly
    }
}

$looks = 'CATALOGUE-LOOKS.md'
Run-Job 'hair' 'hair' (Read-Section $looks '^## Hairstyles') $face $false $false
Run-Job 'beard' 'beard' (Read-Section $looks '^## Beards') $face $false $false
Run-Job 'head' 'head' (Read-Section $looks '^## Head types') $face $false $false
$tat = Read-Section $looks '^## Tattoos'
Run-Job 'facetattoo' 'facetattoo' @($tat | Where-Object type -eq 'Face') $face $false $false
Run-Job 'bodytattoo' 'bodytattoo' @($tat | Where-Object type -eq 'Body') $body $false $false
$app = Read-Section 'CATALOGUE-APPAREL.md' '^## Garments'
$isHat = { $_.slot -match '^(UpperHead|FullHead)(/|$)' }
Run-Job 'garment' 'garment' @($app | Where-Object { -not (& $isHat) }) $body $false $false
Run-Job 'hat' 'hat' @($app | Where-Object { & $isHat }) $face $false $false

$col = Read-Section 'CATALOGUE-COLOURS.md' '^## Colours'
Run-Job 'haircolour' 'haircolour' @($col | Where-Object { $_.group -eq 'Hair' }) $face $false $false
Run-Job 'ideocolour' 'ideocolour' @($col | Where-Object { $_.group -eq 'Ideo' }) $body $false $false
$flat = @($col | Where-Object { $_.group -in 'Misc', 'Planning', 'Structure', 'Weapon' })
Run-Job 'colour' 'colour' $flat $body $true $true

# Body types: Fat, Hulk, Thin differ by sex with Female Body Variants, so one tile per sex for them.
$bt = Read-Section $looks '^## Body types'
$tiles = @()
foreach ($b in $bt) {
    if ($b.name -in 'Fat', 'Hulk', 'Thin') { foreach ($sx in 'female', 'male') { $tiles += [pscustomobject]@{ key = "body-$($b.name)-$sx"; name = "$($b.name) ($sx)"; hex = '' } } }
    else { $tiles += [pscustomobject]@{ key = "body-$($b.name)"; name = $b.name; hex = '' } }
}
Build-Sheets 'body' 'all' $tiles $body $false

Run-Job 'weapon' 'weapon' (Read-Section 'CATALOGUE-WEAPONS-CRAFTS.md' '^## Weapons') $body $false $true
