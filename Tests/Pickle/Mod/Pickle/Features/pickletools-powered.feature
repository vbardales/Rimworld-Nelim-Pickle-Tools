# The shared "the building ... is powered" step (StageDecor): a lamp is placed on open ground, switched on with no power net, then removed.
# (146, 155) is the cell the stagedecor feature places a Campfire on (test-colony, ticket 12c5). NOT PLAYED before 2026-10-15.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.stagedecor.map -Filter pickletools-powered
@requires:nelim.pickletools.stagedecor
Feature: PickleTools powered building

  Background:
    Given the save "test-colony" is loaded

  Scenario: a placed lamp is switched on with no power net
    Given Nelim's Pickle Tools: I place the decor "StandingLamp" at (146, 155)
    And Nelim's Pickle Tools: the building "StandingLamp" at (146, 155) is powered
    When Nelim's Pickle Tools: the decor is removed
