# The RIMMSQOL restart chain of the aggregate bundle, launch 1 of 3: reveal. A choice made in RIMMSQOL is written to its
# settings file when its window closes; only a second process shows that the file is the one the next launch reads at startup.
# Reading it back in the same process shows nothing, the values are still in memory.
#
# The chain is three launches under ONE hold of the lock (-Then stages once and keeps the profile). From PowerShell, with a
# real array for -Then (a comma string would be one filter in one process):
#   & scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.aggregate-rimmsqol.map `
#       -Filter 'aggregate-rimmsqol-restart-1-reveal' `
#       -Then @('aggregate-rimmsqol-restart-2-hide', 'aggregate-rimmsqol-restart-3-forget')
#
# It uses vanilla's normally hidden "Inspect" main button, in the main menu, so it needs no save and no other mod. THIS LAUNCH
# LEAVES THE CHOICE BEHIND ON PURPOSE: the last step says so, and it comes last, so a scenario that fails before it leaves
# nothing (the bundle's after-scenario hook forgets the choice and the launcher stops the chain). If the chain is cut after that
# step, the choice stays in the WSL profile's Config/Mod_1084452457_QOLMod.xml; the next run that stages the bundle puts it back,
# and RimmsqolSteps/README.md, "Leftovers", gives the files to delete by hand.
@requires:nelim.pickletools
@requires:MalteSchulze.RIMMSqol
Feature: the bundle's RIMMSQOL choice is written for the next launch (1 of 3, reveal)

  Scenario: RIMMSQOL reveals a hidden vanilla button and the choice is kept
    Given the main menu is open
    Then RIMMSQOL is ready to be driven
    And RIMMSQOL holds no choice for the main button "Inspect"
    And RIMMSQOL shows the main button "Inspect" as hidden
    When RIMMSQOL reveals the main button "Inspect"
    Then RIMMSQOL shows the main button "Inspect" as visible
    And RIMMSQOL's settings file records the main button "Inspect" as visible
    And no errors were logged
    And RIMMSQOL's choices are kept for the next launch
