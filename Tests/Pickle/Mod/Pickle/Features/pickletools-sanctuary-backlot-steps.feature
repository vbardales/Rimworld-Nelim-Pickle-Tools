# The Backlot's own copies of the place steps (prefix "Nelim's Sanctuary Backlot:"): frame, empty, animals kept out. Both sets of steps are loaded together.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary Backlot steps beside the Pickle Tools steps

  Scenario: backlot-steps: the Backlot place steps work next to the Pickle Tools ones
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Sanctuary Backlot: the animals are kept out of the sanctuary "barn"
    And Nelim's Sanctuary Backlot: the sanctuary "barn" is emptied
    When Nelim's Sanctuary Backlot: I frame the sanctuary "barn"
    And I take a screenshot "backlot-barn-emptied"
