# Embellishing the Sanctuary (NSB plan SanctuaryBacklot/docs/EMBELLISSEMENT-LIEUX.md, 2026-11-04): one before/after photograph per place, same frame, noon, clear.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.stagedecor
Feature: Sanctuary decor: before and after

  Scenario: sanctuary-decor-before: the places as the fixture holds them
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    When I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "terrace"
    And I take a screenshot "before-terrace"
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-pawns"
    And I take a screenshot "before-infirmary-pawns"
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "before-pediatrics"
    And Nelim's Sanctuary: I frame the sanctuary "ritual-hall"
    And I take a screenshot "before-ritual-hall"
    And Nelim's Sanctuary: I frame the sanctuary "hut"
    And I take a screenshot "before-hut"
    And Nelim's Sanctuary: I frame the sanctuary "river-bridge"
    And I take a screenshot "before-river-bridge"
    And Nelim's Sanctuary: I frame the sanctuary "left-bank"
    And I take a screenshot "before-left-bank"
    And Nelim's Sanctuary: I frame the sanctuary "right-bank"
    And I take a screenshot "before-right-bank"
    And Nelim's Sanctuary: I frame the sanctuary "water-garden"
    And I take a screenshot "before-water-garden"
    And Nelim's Sanctuary: I frame the sanctuary "statue-garden"
    And I take a screenshot "before-statue-garden"
    And Nelim's Sanctuary: I frame the sanctuary "flower-garden"
    And I take a screenshot "before-flower-garden"
    And Nelim's Sanctuary: I frame the sanctuary "cloister"
    And I take a screenshot "before-cloister"
    And Nelim's Sanctuary: I frame the sanctuary "barn"
    And I take a screenshot "before-barn"
