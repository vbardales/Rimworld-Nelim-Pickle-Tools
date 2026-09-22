# Builds and runs the headless checks on the shipped assembly.
#   pwsh Tests/Run-Behavior.ps1
# Override -Managed / -VefDir on a machine where the game or VEF lives elsewhere.
param(
  [string]$Managed = 'C:\Program Files (x86)\Steam\steamapps\common\RimWorld\RimWorldWin64_Data\Managed',
  [string]$VefDir  = 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\2023507013\1.6\Assemblies'
)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent

dotnet build "$root\Tests\BehaviorTests.csproj" -c Release --nologo /p:Managed=$Managed /p:VefDir=$VefDir
if ($LASTEXITCODE -ne 0) { throw 'build failed' }

& dotnet "$root\.build\bin-tests\Release\net8.0\BehaviorTests.dll" $Managed $VefDir
exit $LASTEXITCODE
