# A closed roofed room with a bookcase of Good novels, its ReadingBonus read, then everything removed (written 2026-11-03 for ReadingBonusAndBookshelfRenew).
# 1.016 is the value read for 2 Good novels (ticket 704d).
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.stagedecor.map -Filter pickletools-stagedecor-room
@requires:nelim.pickletools.stagedecor
Feature: PickleTools stage decor room

  Background:
    Given the save "test-colony" is loaded

  Scenario: a roofed room holds a bookcase of quality books and has a reading bonus
    Given Nelim's Pickle Tools: a closed roofed room is built at (144, 149) of 4 by 3
    And Nelim's Pickle Tools: I place the decor "Bookcase" at (145, 150)
    When Nelim's Pickle Tools: I fill the storage building "Bookcase" at (145, 150) with 2 things "Novel" of quality Good
    Then Nelim's Pickle Tools: the storage building "Bookcase" at (145, 150) holds 2 things
    And Nelim's Pickle Tools: the room at (145, 150) has the stat "ReadingBonus" at 1.016
    When Nelim's Pickle Tools: the decor is removed
    Then no "Bookcase" is at (145, 150)
