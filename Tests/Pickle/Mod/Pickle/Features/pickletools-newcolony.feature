# The optional NewColony tool: a colony started from the main menu, with the choices fixed, up to a playable paused map.
#
# NOT PLAYED YET (2026-09-25). The first run is the probe: it answers whether the step can change the scene from Entry to Play and
# hand a normal scenario back. What it asserts is only what the game says of its own state; that the colonists are the same for the
# same seed is a second question (see NewColony/README.md).
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.newcolony.map -Filter pickletools-newcolony
@requires:nelim.pickletools.newcolony
Feature: PickleTools new colony

  Scenario: a colony started from the main menu reaches a playable paused map with no error
    Given the main menu is open
    And Nelim's Pickle Tools: the new colony's seed is "pickle-probe"
    When Nelim's Pickle Tools: a new colony is started
    Then no errors were logged
