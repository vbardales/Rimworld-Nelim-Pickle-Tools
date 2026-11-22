# SaB request 2026-11-22 (owner chose LP_PlayFence on Cat's photo things-bridge-railings-set-02): oak picket fence on the river-bridge deck, rows z 123 and z 125 only, x 128..139, never z 124 (walkway), nothing at (127, 122). Loads Nelims-tribe-decor-mods-z3, saves Nelims-tribe-decor-mods-z4. Cells from Rimworld-Catalog/docs/bridge-terrain-grid-2026-11-18.md: deck at z 122..125 over x 128..139, open water only at z 126. NOT PLAYED when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
Feature: bridge railings LP_PlayFence

  Scenario: bridge-railings-playfence: LP_PlayFence on both sides of the bridge walkway, photographed, then the fixture saved
    Given the save "Nelims-tribe-decor-mods-z3" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the terrain of the area from (128, 123) to (139, 125) is logged
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (128, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (129, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (130, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (131, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (132, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (133, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (134, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (135, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (136, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (137, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (138, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (139, 123)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (128, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (129, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (130, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (131, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (132, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (133, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (134, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (135, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (136, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (137, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (138, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (139, 125)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (135, 124) at root size 8.5
    And I take a screenshot "river-bridge-playfence"
    And Nelim's Pickle Tools: the game is saved as "Nelims-tribe-decor-mods-z4"
    And Nelim's Pickle Tools: the saved game "Nelims-tribe-decor-mods-z4" is copied to the run folder
    Then no errors were logged
