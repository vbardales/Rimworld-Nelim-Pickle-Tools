# Shots only (no change): the places Virginie reviews next, from the validated save (mods-k + ritual hall, fa7a). NSB request 2026-11-06.
# The modded decor of these places was already placed by pickletools-sanctuary-decor-mods-after (entrance, pediatrics, statue and flower gardens, water garden): this shows the current state.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: Sanctuary places: current state

  Scenario: sanctuary-places-shots: pediatrics, entrance, statue garden, flower garden, water garden
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the things within 8 cells of (178, 132) are listed
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "now-pediatrics"
    And Nelim's Pickle Tools: I frame the area centred on (178, 132) at root size 7
    And I take a screenshot "now-entrance"
    And Nelim's Sanctuary: I frame the sanctuary "statue-garden"
    And I take a screenshot "now-statue-garden"
    And Nelim's Sanctuary: I frame the sanctuary "flower-garden"
    And I take a screenshot "now-flower-garden"
    And Nelim's Sanctuary: I frame the sanctuary "water-garden"
    And I take a screenshot "now-water-garden"
