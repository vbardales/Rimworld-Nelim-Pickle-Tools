<#
.SYNOPSIS
  Read the REAL RIMMSqol.dll and the game's Assembly-CSharp.dll without loading them, and check the
  facts the steps rest on. No game, no RimWorld process, a few seconds.

.DESCRIPTION
  The C# compiler already proves every member the steps call by name (dotnet build, against the real
  RIMMSqol.dll). What it cannot prove is what those members DO, and the three strings the bridge looks up
  by reflection. This script covers both, with Mono.Cecil reading the binaries:

    1. The strings: MainButtonsRoot.allButtonsInOrder, QOLMod.navigateToProps (both private or protected,
       so the compiler could not check them) and LoadedModManager.GetSettingsFilename.
    2. The game side: Dialog_ModSettings.PreClose really calls Mod.WriteSettings, which is why the steps
       call WriteSettings where a player would close the window.
    3. The RIMMSQOL side: the only code in RIMMSqol.dll that writes MainButtonDef.buttonVisible lives in
       SettingsInit, next to the "mainButtons" and "Visible" literals, and no Harmony patch of RIMMSqol
       targets MainButtonWorker, MainButtonDef or the bar's Visible: the only patched member of
       MainButtonsRoot is MainButtonsOnGUI. This is the evidence that RIMMSQOL reveals a button by moving
       that field and by nothing else.

  A binary read is not a run. It shows what RIMMSqol contains, not that it works in a game.

.EXAMPLE
  powershell.exe -ExecutionPolicy Bypass -File PickleShared/RimmsqolSteps/Check-Bridge.ps1
#>
param(
    [string]$Rimmsqol = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\1084452457\1.6\Assemblies\RIMMSqol.dll',
    [string]$Game = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\RimWorldWin64_Data\Managed\Assembly-CSharp.dll',
    [string]$Cecil = "$env:USERPROFILE\.nuget\packages\mono.cecil\0.11.5\lib\net40\Mono.Cecil.dll"
)
$ErrorActionPreference = 'Stop'
foreach ($p in $Rimmsqol, $Game, $Cecil) { if (-not (Test-Path -LiteralPath $p)) { throw "not found: $p" } }
Add-Type -Path $Cecil

$bad = 0
function Check($ok, $what, $detail = '') {
    if ($ok) { Write-Host "ok    $what" -ForegroundColor Green }
    else { Write-Host "FAIL  $what  $detail" -ForegroundColor Red; $script:bad++ }
}

# Reading a copy would be tidier, but the files are only opened for reading, never locked for write.
$rq = [Mono.Cecil.AssemblyDefinition]::ReadAssembly($Rimmsqol)
$gm = [Mono.Cecil.AssemblyDefinition]::ReadAssembly($Game)

function TypeOf($asm, $full) { $asm.MainModule.GetTypes() | Where-Object { $_.FullName -eq $full } | Select-Object -First 1 }
function IL($method) { if ($method.HasBody) { $method.Body.Instructions } else { @() } }

# --- 1. the three strings -------------------------------------------------------------------------

$root = TypeOf $gm 'RimWorld.MainButtonsRoot'
$f = $root.Fields | Where-Object { $_.Name -eq 'allButtonsInOrder' -and -not $_.IsStatic -and -not $_.IsPublic }
Check ($null -ne $f -and $f.FieldType.FullName -eq 'System.Collections.Generic.List`1<RimWorld.MainButtonDef>') 'MainButtonsRoot.allButtonsInOrder is a private List<MainButtonDef>'

$qol = TypeOf $rq 'RIMMSqol.QOLMod'
$n = $qol.Fields | Where-Object { $_.Name -eq 'navigateToProps' -and $_.IsStatic }
Check ($null -ne $n) 'QOLMod.navigateToProps exists and is static'

$lmm = TypeOf $gm 'Verse.LoadedModManager'
$g = $lmm.Methods | Where-Object { $_.Name -eq 'GetSettingsFilename' -and $_.IsStatic -and $_.Parameters.Count -eq 2 }
Check ($null -ne $g) 'LoadedModManager.GetSettingsFilename(string, string) exists and is static'

# --- 2. the game closes the window by writing the settings ----------------------------------------

$dlg = TypeOf $gm 'RimWorld.Dialog_ModSettings'
$pre = $dlg.Methods | Where-Object { $_.Name -eq 'PreClose' }
$calls = @(IL $pre | Where-Object { $_.OpCode.Name -like 'call*' -and $_.Operand -is [Mono.Cecil.MethodReference] } | ForEach-Object { $_.Operand.FullName })
Check ($calls | Where-Object { $_ -like '*Verse.Mod::WriteSettings*' }) 'Dialog_ModSettings.PreClose calls Mod.WriteSettings'
Check ($null -ne ($dlg.Fields | Where-Object { $_.FieldType.FullName -eq 'Verse.Mod' })) 'Dialog_ModSettings holds a Verse.Mod field (ModOf reads the first one)'

# --- 3. how RIMMSQOL moves the button -------------------------------------------------------------

# Every method of RIMMSqol.dll that stores MainButtonDef.buttonVisible.
$writers = @()
foreach ($t in $rq.MainModule.GetTypes()) {
    foreach ($m in $t.Methods) {
        foreach ($i in (IL $m)) {
            if ($i.OpCode.Name -eq 'stfld' -and $i.Operand.FullName -like '*RimWorld.MainButtonDef::buttonVisible') { $writers += "$($t.FullName)::$($m.Name)"; break }
        }
    }
}
Write-Host "      stores MainButtonDef.buttonVisible in: $($writers -join ', ')"
Check ($writers.Count -ge 1 -and @($writers | Where-Object { $_ -notlike 'RIMMSqol.SettingsInit*' }).Count -eq 0) 'the only code that stores buttonVisible is inside SettingsInit (the mainButtons merger)'

$strings = @{}
foreach ($t in $rq.MainModule.GetTypes() | Where-Object { $_.FullName -like 'RIMMSqol.SettingsInit*' }) {
    foreach ($m in $t.Methods) { foreach ($i in (IL $m)) { if ($i.OpCode.Name -eq 'ldstr') { $strings[$i.Operand] = $true } } }
}
Check ($strings.ContainsKey('mainButtons') -and $strings.ContainsKey('Visible')) 'SettingsInit names the property set "mainButtons" and the field "Visible"'

# Which types does a HarmonyPatch attribute point at?
function PatchTargets($type) {
    foreach ($a in $type.CustomAttributes | Where-Object { $_.AttributeType.Name -eq 'HarmonyPatch' }) {
        foreach ($arg in $a.ConstructorArguments) {
            if ($arg.Value -is [Mono.Cecil.TypeReference]) { $arg.Value.FullName }
            elseif ($arg.Value -is [string]) { "'" + $arg.Value + "'" }
        }
    }
}
$hitsBar = @()
foreach ($t in $rq.MainModule.GetTypes()) {
    $targets = @(PatchTargets $t)
    if ($targets | Where-Object { $_ -like 'RimWorld.MainButton*' -or $_ -like 'RimWorld.MainTabsRoot' }) { $hitsBar += "$($t.FullName) -> $($targets -join ' ')" }
}
$hitsBar | ForEach-Object { Write-Host "      Harmony patch on the bar: $_" }
$hitsWorker = @($hitsBar | Where-Object { $_ -like '*MainButtonWorker*' -or $_ -like '*MainButtonDef*' -or $_ -like '*Visible*' })
Check ($hitsWorker.Count -eq 0) 'no Harmony patch of RIMMSqol targets MainButtonWorker, MainButtonDef or a Visible member'
Check ($hitsBar.Count -eq 1 -and $hitsBar[0] -like 'RIMMSqol.MainButtonsRoot_MainButtonsOnGUI*MainButtonsOnGUI*') 'the only patch on the bar is MainButtonsRoot.MainButtonsOnGUI (its key bindings)'

$prefixOrPostfix = (TypeOf $rq 'RIMMSqol.MainButtonsRoot_MainButtonsOnGUI').Methods | Where-Object { $_.Name -in 'Postfix', 'Prefix', 'Transpiler' } | ForEach-Object { $_.Name }
Check (@($prefixOrPostfix) -contains 'Postfix' -and @($prefixOrPostfix).Count -eq 1) 'that patch is a Postfix only'

Write-Host ''
if ($bad -gt 0) { Write-Host "$bad CHECK(S) FAILED: the bridge rests on something RIMMSqol or the game no longer does." -ForegroundColor Red; exit 1 }
Write-Host 'ALL CHECKS PASS' -ForegroundColor Green
exit 0
