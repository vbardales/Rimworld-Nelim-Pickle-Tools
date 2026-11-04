<#
.SYNOPSIS
  Contact sheet of the lower-body garments on the Hulk and Fat bodies (NSB request 2026-11-04): reads Tests/Pickle/Inbox/clothes-bodies-2 photographs
  manual--bodygarment-<hulk|fat>-<def>--step0.png and writes ColonistRace/docs/img/looks/bodygarments-<hulk|fat>.jpg (5 columns, tile cropped around the pawn).
  Usage: powershell -File docs/Make-BodyGarmentSheets.ps1 [-Dir <screenshots folder>]
#>
param([string]$Dir = 'Tests/Pickle/Inbox/clothes-bodies-2/screenshots')
Add-Type -AssemblyName System.Drawing
$root = Split-Path $PSScriptRoot -Parent
$out = Join-Path $root 'ColonistRace/docs/img/looks'
$cw = 400; $ch = 560; $x0 = 760; $y0 = 230; $tw = 280; $th = 392; $label = 22; $cols = 5
foreach ($body in 'hulk', 'fat') {
    $files = Get-ChildItem (Join-Path $root $Dir) -Filter "manual--bodygarment-$body-*--step0.png" | Sort-Object Name
    if (-not $files) { continue }
    $rows = [math]::Ceiling($files.Count / $cols)
    $bmp = New-Object System.Drawing.Bitmap ($tw * $cols), (($th + $label) * $rows)
    $g = [System.Drawing.Graphics]::FromImage($bmp); $g.Clear([System.Drawing.Color]::White)
    $g.InterpolationMode = 'HighQualityBicubic'
    $font = New-Object System.Drawing.Font 'Segoe UI', 9
    for ($i = 0; $i -lt $files.Count; $i++) {
        $img = [System.Drawing.Image]::FromFile($files[$i].FullName)
        $cx = ($i % $cols) * $tw; $cy = [math]::Floor($i / $cols) * ($th + $label)
        $g.DrawImage($img, (New-Object System.Drawing.Rectangle $cx, $cy, $tw, $th), (New-Object System.Drawing.Rectangle $x0, $y0, $cw, $ch), [System.Drawing.GraphicsUnit]::Pixel)
        $name = $files[$i].Name -replace "^manual--bodygarment-$body-", '' -replace '--step0\.png$', ''
        $g.DrawString($name, $font, [System.Drawing.Brushes]::Black, [float]($cx + 2), [float]($cy + $th + 3))
        $img.Dispose()
    }
    $g.Dispose()
    $path = Join-Path $out "bodygarments-$body.jpg"
    $bmp.Save($path, [System.Drawing.Imaging.ImageFormat]::Jpeg); $bmp.Dispose()
    Write-Host "$body : $($files.Count) tiles -> $path"
}
