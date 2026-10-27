# Lists every weather of the loaded game (vanilla, DLC and the mods of the map) in the log as [look-weather] lines, for the weather catalogue
# (ColonistRace/docs/catalogues/weather.md). Not a test: it never fails on a value, it makes the list. Written 2026-10-25, NOT PLAYED.
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-catalogue.map -Filter 'pickletools-weather-catalogue'
@requires:nelim.pickletools.colonistrace
Feature: PickleTools weather catalogue
  Scenario: the weather options are listed
    Given the save "Nelims-tribe" is loaded
    And Nelim's Pickle Tools: the weather options are listed
