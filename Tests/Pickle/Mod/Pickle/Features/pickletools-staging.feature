# A staged capture end to end, with no screenshot: a colonist stands where it is put, facing where it is told, in a dyed garment; animals are
# placed in a row and around a cell; a rectangle is framed; the decor comes off. (32, 32) and around are inside the thing-free 9 by 9 square
# from (30, 30) of test-colony (docs/FIXTURES.md). Terrain was not decoded: a blocked spot fails naming the cell.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.staging.map -Filter pickletools-staging
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.stagedecor
Feature: PickleTools staged capture

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused

  Scenario: a colonist is placed, turned and dressed
    Given a colonist "Mara" exists
    And "Mara" is 30 years old
    And Nelim's Pickle Tools: "Mara" stands at (32, 32) facing East
    And Nelim's Pickle Tools: "Mara" wears "Apparel_BasicShirt" dyed rgb (30, 90, 160)
    Then "Mara" is wearing "Apparel_BasicShirt"
    When Nelim's Pickle Tools: "Mara" gets back the clothes it had

  Scenario: a rectangle is framed and the decor is removed
    Given Nelim's Pickle Tools: I place the decor "Campfire" at (34, 34)
    When Nelim's Pickle Tools: I frame the cells (32, 32) to (36, 36) filling 50 percent of the screen
    And Nelim's Pickle Tools: the decor is removed
    Then no "Campfire" is at (34, 34)

  Scenario: a lamp is lit, the roof comes off, the studio actors leave, a head is chosen
    Given Nelim's Pickle Tools: I place the decor "TorchLamp" at (33, 33)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (33, 33) is lit
    And Nelim's Pickle Tools: the roof is removed from (31, 31) to (35, 35)
    And a colonist "Ned" exists
    And Nelim's Pickle Tools: "Ned" stands at (32, 31)
    When Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the camera is centered on "Ned" at root size 8
    Then Nelim's Pickle Tools: the decor is removed
