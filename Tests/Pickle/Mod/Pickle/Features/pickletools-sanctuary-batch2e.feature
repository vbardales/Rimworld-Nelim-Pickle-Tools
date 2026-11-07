# Batch 2e (NSB 2026-11-07, after 2d): the gate path laid in Gravel (NSB: the copy of (144, 116) laid plain moss, that cell is not a path; the hash-47861 cells are a closed ring x145-166 z102-122, not a path), the ring probed for the record and left alone, the gate frame reshot, plus a whole-play-area frame (centre (100, 117), root size 11, wild animals kept out; Virginie: part of the area was cut in 2d). The bridge-east link of 2c/2d changed nothing (moss on moss) and is dropped. Chained: loads Nelims-tribe-decor-mods-g, saves Nelims-tribe-decor-mods-h in the run folder; validated fixtures untouched. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 2e

  Scenario: sanctuary-batch2e: gate path in gravel, ring probed, gate frame, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-g" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the terrain of the cell (146, 116) is logged
    And Nelim's Pickle Tools: the terrain of the cell (145, 110) is logged
    And Nelim's Pickle Tools: the terrain of the cell (144, 116) is logged
    And Nelim's Pickle Tools: the area from (113, 117) to (126, 117) is emptied
    And Nelim's Pickle Tools: the area from (126, 118) to (126, 123) is emptied
    And Nelim's Pickle Tools: I lay the floor "Gravel" from (113, 117) to (126, 117)
    And Nelim's Pickle Tools: I lay the floor "Gravel" from (126, 118) to (126, 123)
    And Nelim's Pickle Tools: the terrain of the cell (120, 117) is logged
    And Nelim's Pickle Tools: the terrain of the cell (126, 120) is logged
    And Nelim's Pickle Tools: the animals are kept out of the area from (78, 104) to (124, 130)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Pickle Tools: I frame the area centred on (100, 117) at root size 11
    And I take a screenshot "after-play-area-whole-e"
    And Nelim's Pickle Tools: I frame the area centred on (110, 118) at root size 10
    And I take a screenshot "after-play-area-gate-e"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-h"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-h" is copied to the run folder
