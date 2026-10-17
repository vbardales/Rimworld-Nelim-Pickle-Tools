# Lists the buildings the player can build from an Architect tab, by mod and tab (defName, size, research needed or not) in the log, for
# ArchitectStudio's staged gallery scenes. Not a test: it never fails on a value, it makes the list.
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.building-catalogue.map -Filter pickletools-building-catalogue   (read the lines [look-building] of Player.log)
@requires:nelim.pickletools.colonistrace
Feature: PickleTools building catalogue
  Scenario: the building options are listed
    Given the save "Nelims-tribe" is loaded
    And Nelim's Pickle Tools: the building options are listed
