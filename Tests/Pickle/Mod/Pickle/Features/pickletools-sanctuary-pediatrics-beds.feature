# Rework (owner via NSB, 2026-11-07): the six pediatrics beds face the wrong way, the head (pillow) must be against the north wall, pillow at the top. Before = now-pediatrics of ticket 2e61 (pillows at the bottom). Cribs and toy boxes stay.
# Which Rot4 puts the pillow at the top is not known (NSB reads South, the bed art may say North): both are played, the step logs the old rotation ([decor-turned] ... was rot X); the shot that differs from the before is the answer. Not played when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: Sanctuary pediatrics: beds head to the wall

  Scenario: sanctuary-pediatrics-beds: six beds turned south
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: the buildings "Bed" from (196, 57) to (216, 70) are turned to face south
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "beds-turned-south"

  Scenario: sanctuary-pediatrics-beds: six beds turned north
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: the buildings "Bed" from (196, 57) to (216, 70) are turned to face north
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "pediatrics"
    And I take a screenshot "beds-turned-north"
