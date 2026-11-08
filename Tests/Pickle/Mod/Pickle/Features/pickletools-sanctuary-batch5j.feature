# Batch 5j (NSB, 2026-11-08, regression: batches 3a to 5i despawned every animal map-wide before saving, so -k to -v lack Yuki, Shogun, Atticus and Rain). Nelims-tribe-decor-mods-w = -v with the four pawn blocks of -j copied in unchanged (same ids, names, kinds, genders, bonds, apparel, cells of -j), made by a splice script, not by the game. This scenario only loads -w and proves it: each name counted exactly once, one shot of each animal. No edit, no save, no despawn.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Sanctuary decor batch 5j

  Scenario: sanctuary-batch5j: the four named animals are back in the fixture w and each one is photographed
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    Then Nelim's Pickle Tools: the animals named "Yuki" are counted
    And Nelim's Pickle Tools: the animals named "Shogun" are counted
    And Nelim's Pickle Tools: the animals named "Atticus" are counted
    And Nelim's Pickle Tools: the animals named "Rain" are counted
    When Nelim's Pickle Tools: the area and zone overlays are hidden
    And Nelim's Pickle Tools: I frame the animal "Yuki" at zoom 12
    And I take a screenshot "back-yuki-w"
    And Nelim's Pickle Tools: I frame the animal "Shogun" at zoom 12
    And I take a screenshot "back-shogun-w"
    And Nelim's Pickle Tools: I frame the animal "Atticus" at zoom 12
    And I take a screenshot "back-atticus-w"
    And Nelim's Pickle Tools: I frame the animal "Rain" at zoom 12
    And I take a screenshot "back-rain-w"
