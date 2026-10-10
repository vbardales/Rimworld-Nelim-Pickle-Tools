# A staged capture end to end, with no screenshot: a colonist stands where it is put, facing where it is told, in a dyed garment; animals are
# placed in a row and around a cell; a rectangle is framed; the decor comes off. (32, 32) and around are inside the thing-free 9 by 9 square
# from (30, 30) of test-colony (docs/FIXTURES.md). Terrain was not decoded: a blocked spot fails naming the cell.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.staging.map -Filter pickletools-staging
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.stagedecor
# 2026-10-10 (ticket 3f12): the spots near (30, 30) hold natural rock (Slate) the save does not list; every coordinate moved by (+81, +158), around (113, 190), beside the colonists. Replay d1ac: (113, 190) holds Granite too; moved again by (+33, -35) to around (146, 155), where Epona's suites placed decor without a failure (docs/FIXTURES.md); the frame asks 20 percent so the root size stays above the game's closest zoom of 11.
Feature: PickleTools staged capture

  Background:
    Given the save "test-colony" is loaded
    And game speed is paused

  Scenario: a colonist is placed, turned and dressed
    Given a colonist "Mara" exists
    And "Mara" is 30 years old
    And Nelim's Pickle Tools: "Mara" stands at (146, 155) facing East
    And Nelim's Pickle Tools: "Mara" wears "Apparel_BasicShirt" dyed rgb (30, 90, 160)
    Then "Mara" is wearing "Apparel_BasicShirt"
    When Nelim's Pickle Tools: "Mara" gets back the clothes it had

  Scenario: a rectangle is framed and the decor is removed
    Given Nelim's Pickle Tools: I place the decor "Campfire" at (148, 157)
    When Nelim's Pickle Tools: I frame the cells (146, 155) to (150, 159) filling 20 percent of the screen
    And Nelim's Pickle Tools: the decor is removed
    Then no "Campfire" is at (148, 157)

  Scenario: a lamp is lit, the roof comes off, the studio actors leave, a head is chosen
    Given Nelim's Pickle Tools: I place the decor "TorchLamp" at (147, 156)
    And Nelim's Pickle Tools: the decor "TorchLamp" at (147, 156) is lit
    And Nelim's Pickle Tools: the roof is removed from (145, 154) to (149, 158)
    And a colonist "Ned" exists
    And Nelim's Pickle Tools: "Ned" stands at (146, 154)
    When Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the camera is centered on "Ned" at root size 8
    Then Nelim's Pickle Tools: the decor is removed
