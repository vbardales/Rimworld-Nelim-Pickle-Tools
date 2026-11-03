# Generic "a mod was removed from a save" check, hosted here because the mod under test cannot host its own removal pass (it depends on the removed mod).
# The caller's pass 1 saves its game and copies the .rws to the run folder (SaveSteps: "the saved game {name} is copied to the run folder"); between the
# passes the caller copies that file to PickleTools/Tests/Pickle/Mod/Pickle/Fixtures/removal-check.rws (ignored by git); this pass loads it WITHOUT the
# removed mod (a pass map that does not stage it, plus the mods the save still needs) and reads the log. See Tests/Pickle/README.md "Removal check".
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap <map without the removed mod> -Filter removal-check
Feature: a saved game loads with a mod removed

  Background:
    Given the save "removal-check" is loaded

  Scenario: the save of a removed mod loads without a logged error
    When I wait 60 ticks
    Then Nelim's Pickle Tools: no error was logged while the game loaded
    And Nelim's Pickle Tools: the active language recorded no load error
