# Lists the utility items of the loaded game (not weapons, not apparel) in the log, for ColonistRace/docs/catalogues/items.md: the [look-item] lines of Player.log.
# Not a test: it never fails on a value, it makes the list. Priority 2026-10-18 (owner): utility items first, then buildings, then weapons.
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-catalogue.map -Filter 'item-catalogue'
@requires:nelim.pickletools.colonistrace
Feature: PickleTools item catalogue
  Scenario: the utility item options are listed
    Given the save "Nelims-tribe" is loaded
    And Nelim's Pickle Tools: the utility item options are listed
