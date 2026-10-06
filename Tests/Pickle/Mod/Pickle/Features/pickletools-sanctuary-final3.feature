# Turns Virginie's own save (2026-10-05, 17:42 local, copied as the fixture "Nelims-tribe-draft") into the fixture the mods load: one colonist (Nelim, fed),
# no filth, every loose item put away in the stockpile, research reset, noon with a clear sky. Saved as "nelims-tribe-final3".
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuaire final3: Virginie's save made ready for the mods

  Background:
    Given the save "Nelims-tribe-draft" is loaded
    And game speed is paused

  Scenario: final3-shot: one colonist, clean, tidy, fed, at noon
    Given Nelim's Pickle Tools: all humans but "Nelim" are removed
    And Nelim's Pickle Tools: all filth is cleaned
    And Nelim's Pickle Tools: all loose items are put away
    And Nelim's Pickle Tools: the pawn "Nelim" is fully fed
    And Nelim's Pickle Tools: all research is reset
    And Nelim's Pickle Tools: the eclipse of the map is ended
    When I set the hour to 12
    And I set the weather to "Clear"
    And I save and reload as "nelims-tribe-final3"
    And game speed is paused
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I am at the sanctuary "overview-north"
    And I take a screenshot "final3-overview-north"
    And Nelim's Pickle Tools: I am at the sanctuary "overview-south"
    And I take a screenshot "final3-overview-south"
    And Nelim's Pickle Tools: I am at the sanctuary "grand-place"
    And I take a screenshot "final3-grand-place"
    And Nelim's Pickle Tools: I am at the sanctuary "hearth-hall"
    And I take a screenshot "final3-hearth-hall"
    And Nelim's Pickle Tools: I am at the sanctuary "house"
    And I take a screenshot "final3-house"
