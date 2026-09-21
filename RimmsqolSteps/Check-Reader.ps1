<#
.SYNOPSIS
  Exercise SettingsFileReader, the part of the steps that reads RIMMSQOL's settings file, against
  hand-made XML. No game.

.DESCRIPTION
  The reader is pure BCL, so the built assembly can be loaded here and called directly.

  WHAT THIS DOES NOT SHOW: that the XML below is what RIMMSQOL writes. Its layout was derived from
  RIMMSqol's code (SettingsInstance.ExposeData, Scribe_Values.Look leaving out a value equal to its
  default) and has not been seen in a game. These cases pin the reader's rules, in particular the two
  that a wrong guess would break: a configured `Visible` of false is an ABSENT node plus
  `Visible;t;` in isConfigured, and only an entry under an element named "mainButtons" counts.
  The first real run writes the entry into its report, which is what confirms or corrects this.
#>
param(
    [string]$Dll = (Join-Path $PSScriptRoot 'Mod\Pickle\Assemblies\Nelim.PickleTools.Rimmsqol.dll')
)
$ErrorActionPreference = 'Stop'
[Reflection.Assembly]::LoadFrom($Dll) | Out-Null
$reader = [Nelim.PickleTools.Rimmsqol.SettingsFileReader]

$bad = 0
function Case($name, $xml, $key, $expected, $detailPattern = $null) {
    $detail = $null
    $got = $reader::Read($xml, $key, [ref]$detail).ToString()
    $ok = ($got -eq $expected) -and (-not $detailPattern -or $detail -match $detailPattern)
    if ($ok) { Write-Host "ok    $name -> $got" -ForegroundColor Green }
    else { Write-Host "FAIL  $name -> $got (expected $expected)`n      $detail" -ForegroundColor Red; $script:bad++ }
}

function Entry($key, $configured, $extra) {
    $c = if ($null -ne $configured) { "<isConfigured>$configured</isConfigured>" } else { '' }
    "<li><id>mainButtons</id>$c<baseObjectKey>$key</baseObjectKey><baseObjectReferenceKey>-2</baseObjectReferenceKey>$extra</li>"
}
function Doc($inner, $list = 'mainButtons') { "<?xml version=`"1.0`" encoding=`"utf-8`"?><SettingsBlock><ModSettings><$list>$inner</$list></ModSettings></SettingsBlock>" }

$all = 'Label;f;IconPath;f;Description;f;Visible;t;Minimized;f;Order;f;Buttons;f;'

Case 'revealed'                       (Doc (Entry 'FTFR_Settings' $all '<Visible>True</Visible>')) 'FTFR_Settings' 'Visible'  'reads visible'
Case 'hidden: Visible configured, node absent (false is the default, so it is not written)' `
                                      (Doc (Entry 'FTFR_Settings' $all ''))                       'FTFR_Settings' 'Hidden'   'reads hidden'
Case 'hidden: explicit False node'    (Doc (Entry 'FTFR_Settings' $all '<Visible>False</Visible>')) 'FTFR_Settings' 'Hidden'
Case 'lowercase true'                 (Doc (Entry 'FTFR_Settings' $all '<Visible>true</Visible>')) 'FTFR_Settings' 'Visible'
Case 'entry exists, Visible NOT configured (only Minimized was edited)' `
                                      (Doc (Entry 'FTFR_Settings' 'Label;f;Visible;f;Minimized;t;' '<Minimized>True</Minimized>')) 'FTFR_Settings' 'NoChoice' 'does not record a Visible choice'
Case 'no entry for this def'          (Doc (Entry 'MainButton_Other' $all '<Visible>True</Visible>')) 'FTFR_Settings' 'NoChoice' 'no mainButtons entry'
Case 'empty list'                     (Doc '' 'mainButtons')                                       'FTFR_Settings' 'NoChoice'
Case 'same key under another property set does not count' `
                                      (Doc (Entry 'FTFR_Settings' $all '<Visible>True</Visible>') 'architectButtons') 'FTFR_Settings' 'NoChoice'
Case 'ours is the second entry'       (Doc ((Entry 'Architect' $all '') + (Entry 'FTFR_Settings' $all '<Visible>True</Visible>'))) 'FTFR_Settings' 'Visible'
Case 'no isConfigured node, Visible True: every field counts' `
                                      (Doc (Entry 'FTFR_Settings' $null '<Visible>True</Visible>')) 'FTFR_Settings' 'Visible'
Case 'no isConfigured node, no Visible node' `
                                      (Doc (Entry 'FTFR_Settings' $null ''))                      'FTFR_Settings' 'Hidden'
Case 'a key that only CONTAINS the defName is not a match' `
                                      (Doc (Entry 'FTFR_Settings_Old' $all '<Visible>True</Visible>')) 'FTFR_Settings' 'NoChoice'
Case 'malformed file'                 '<SettingsBlock><ModSettings>'                               'FTFR_Settings' 'NoChoice' 'does not parse'

Write-Host ''
if ($bad -gt 0) { Write-Host "$bad CASE(S) FAILED" -ForegroundColor Red; exit 1 }
Write-Host 'ALL CASES PASS (the reader follows its rules; the layout itself is unverified until a run)' -ForegroundColor Green
exit 0
