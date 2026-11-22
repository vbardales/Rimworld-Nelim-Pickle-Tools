# SaB A refile (Cat 2026-11-22): Yuran_Enclosure and LP_PlayFence on bridge deck cells next to shallow water, Sanctuary save, same zoom as bridge-railings shot 1 (root size 5.5), no Concrete.
# Cells from Rimworld-Catalog/docs/bridge-terrain-grid-2026-11-18.md: deck at z 125, shallow water directly south at z 126, x 128..131 (placement OK in ticket a660).
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.colonistrace
Feature: bridge railings on the deck

  Scenario: bridge-railings-deck-01: two fence defs on deck cells beside shallow water
    Given the save "Nelims-tribe-decor-mods-z3" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the terrain of the area from (128, 125) to (131, 126) is logged
    And Nelim's Pickle Tools: the building "Yuran_Enclosure" is spawned at (128, 125)
    And Nelim's Pickle Tools: the building "Yuran_Enclosure" is spawned at (129, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (130, 125)
    And Nelim's Pickle Tools: the building "LP_PlayFence" is spawned at (131, 125)
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (130, 125) at root size 5.5
    And I take a screenshot "things-bridge-railings-02"
    Then no errors were logged
