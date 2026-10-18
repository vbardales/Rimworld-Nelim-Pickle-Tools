<#
.SYNOPSIS
  Builds the contact sheets of the look catalogues (hairstyles, beards, head types, face and body tattoos) into
  ColonistRace/docs/img/looks/<kind>-<mod>-<page>.jpg, in the order of the tables of ColonistRace/docs/CATALOGUE-LOOKS.md.
  A value with no photograph yet gets an empty hatched tile of the same size with its name and "not photographed": rerun the
  script once the photographs exist and the tile fills.
  Photographs: every Tests/Pickle/Evidence/look-gallery*/screenshots/manual--<kind>-<name>--step0.png (newest wins).
  Kinds and the name prefix of the capture: hair -> hair-, beard -> beard-, head -> head-, face tattoo -> facetattoo-, body tattoo -> bodytattoo-.
#>
Add-Type -AssemblyName System.Drawing
$root = Split-Path $PSScriptRoot -Parent
$out = Join-Path $root 'ColonistRace/docs/img/looks'
New-Item -ItemType Directory -Force $out | Out-Null

$files = @{}
Get-ChildItem (Join-Path $root 'Tests/Pickle/Evidence') -Directory -Filter 'look-gallery*' | Sort-Object LastWriteTime | ForEach-Object {
    $s = Join-Path $_.FullName 'screenshots'
    if (Test-Path $s) { Get-ChildItem $s -Filter 'manual--*--step0.png' | ForEach-Object { $files[($_.Name -replace '^manual--', '' -replace '--step0\.png$', '')] = $_.FullName } }
}

# Parse the catalogue: section title -> list of @{ mod; name; type }
$md = Get-Content (Join-Path $root 'ColonistRace/docs/CATALOGUE-LOOKS.md') -Encoding UTF8
$sections = @{}; $cur = $null
foreach ($line in $md) {
    if ($line -match '^## (Hairstyles|Beards|Head types|Tattoos)') { $cur = $Matches[1]; $sections[$cur] = @(); continue }
    if ($line -match '^## ') { $cur = $null; continue }
    if ($cur -and $line -match '^\| (.+?) \| \(\d+\) (.+) \|$') {
        $mod = $Matches[1]; $raw = $Matches[2] -split ', '
        foreach ($r in $raw) {
            $type = ''; if ($r -match '\((Face|Body)\)$') { $type = $Matches[1] }
            $name = ($r -replace ' \([A-Za-z]+\)$', '').Trim()
            $sections[$cur] += [pscustomobject]@{ mod = $mod; name = $name; type = $type }
        }
    }
}

$cols = 6; $tile = 200; $label = 20; $perPage = 30
$face = New-Object System.Drawing.Rectangle 810, 190, 300, 300
$body = New-Object System.Drawing.Rectangle 760, 320, 400, 400
$font = New-Object System.Drawing.Font 'Segoe UI', 8
$hatch = New-Object System.Drawing.Drawing2D.HatchBrush ([System.Drawing.Drawing2D.HatchStyle]::LightUpwardDiagonal), ([System.Drawing.Color]::FromArgb(225, 225, 225)), ([System.Drawing.Color]::White)
$enc = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object MimeType -eq 'image/jpeg'
$p = New-Object System.Drawing.Imaging.EncoderParameters 1
$p.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter ([System.Drawing.Imaging.Encoder]::Quality), 80L

$jobs = @(
    @{ kind = 'hair'; prefix = 'hair'; section = 'Hairstyles'; type = ''; crop = $face },
    @{ kind = 'beard'; prefix = 'beard'; section = 'Beards'; type = ''; crop = $face },
    @{ kind = 'head'; prefix = 'head'; section = 'Head types'; type = ''; crop = $face },
    @{ kind = 'facetattoo'; prefix = 'facetattoo'; section = 'Tattoos'; type = 'Face'; crop = $face },
    @{ kind = 'bodytattoo'; prefix = 'bodytattoo'; section = 'Tattoos'; type = 'Body'; crop = $body }
)
foreach ($j in $jobs) {
    $items = @($sections[$j.section] | Where-Object { $j.type -eq '' -or $_.type -eq $j.type })
    foreach ($modGroup in ($items | Group-Object mod)) {
        $slug = ($modGroup.Name -replace '[^A-Za-z0-9]+', '-').Trim('-').ToLower()
        $list = @($modGroup.Group)
        $pages = [Math]::Ceiling($list.Count / $perPage)
        for ($pg = 0; $pg -lt $pages; $pg++) {
            $part = @($list | Select-Object -Skip ($pg * $perPage) -First $perPage)
            $rows = [Math]::Ceiling($part.Count / $cols)
            $bmp = New-Object System.Drawing.Bitmap ($cols * $tile), ($rows * ($tile + $label))
            $g = [System.Drawing.Graphics]::FromImage($bmp)
            $g.Clear([System.Drawing.Color]::White)
            $have = 0
            for ($i = 0; $i -lt $part.Count; $i++) {
                $x = ($i % $cols) * $tile; $y = [Math]::Floor($i / $cols) * ($tile + $label)
                $key = "$($j.prefix)-$($part[$i].name)"
                $r = New-Object System.Drawing.Rectangle $x, $y, $tile, $tile
                if ($files.ContainsKey($key)) {
                    $img = [System.Drawing.Image]::FromFile($files[$key])
                    $g.DrawImage($img, $r, $j.crop, [System.Drawing.GraphicsUnit]::Pixel); $img.Dispose(); $have++
                    $txt = $part[$i].name
                } else {
                    $g.FillRectangle($hatch, $r)
                    $g.DrawRectangle([System.Drawing.Pens]::LightGray, $x, $y, $tile - 1, $tile - 1)
                    $txt = $part[$i].name + ' (not photographed)'
                }
                $g.DrawString($txt, $font, [System.Drawing.Brushes]::Black, [float]($x + 2), [float]($y + $tile + 3))
            }
            $g.Dispose()
            $path = Join-Path $out ("{0}-{1}-{2}.jpg" -f $j.kind, $slug, ($pg + 1))
            $bmp.Save($path, $enc, $p); $bmp.Dispose()
            Write-Output ("{0}: {1} of {2} photographed -> {3}" -f ("$($j.kind) $($modGroup.Name) p$($pg + 1)"), $have, $part.Count, $path)
        }
    }
}
