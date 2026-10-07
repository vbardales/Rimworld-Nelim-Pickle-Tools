# Checks the bare clearing (podium square without its green carpet) at its default frame.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: bare clearing

  Scenario: bare-clearing: the named scene
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: all animals are removed
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I am at the sanctuary "bare-clearing"
    And I take a screenshot "bare-clearing"
