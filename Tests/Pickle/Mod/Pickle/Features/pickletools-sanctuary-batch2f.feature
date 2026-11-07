# Batch 2f (NSB 2026-11-07, Virginie: ok for limestone): the gate path relaid in FlagstoneLimestone over the Gravel of 2e, same cells; the play-area frame is now centre (100, 117) root size 11 (taken with the explicit frame step: the sanctuary frame "play-area" is still (93, 117) zoom 10 in SanctuaryBacklot/Source/SanctuarySteps.cs line 27, NSB owns it). Wild animals kept out. Chained: loads Nelims-tribe-decor-mods-h, saves Nelims-tribe-decor-mods-i in the run folder; validated fixtures untouched. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.savesteps
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary decor batch 2f

  Scenario: sanctuary-batch2f: gate path in limestone, whole and gate frames, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-h" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I lay the floor "FlagstoneLimestone" from (113, 117) to (126, 117)
    And Nelim's Pickle Tools: I lay the floor "FlagstoneLimestone" from (126, 118) to (126, 123)
    And Nelim's Pickle Tools: the terrain of the cell (120, 117) is logged
    And Nelim's Pickle Tools: the terrain of the cell (126, 120) is logged
    And Nelim's Pickle Tools: the animals are kept out of the area from (78, 104) to (124, 130)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Pickle Tools: I frame the area centred on (100, 117) at root size 11
    And I take a screenshot "after-play-area-whole-f"
    And Nelim's Pickle Tools: I frame the area centred on (110, 118) at root size 10
    And I take a screenshot "after-play-area-gate-f"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-i"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-i" is copied to the run folder
