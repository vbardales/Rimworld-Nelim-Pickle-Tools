# DIAGNOSIS for Cat (be51 rejected): same scene as the plant shot, then terrain and things logs of the frame, then 600 ticks later: do the beans spread plants and pink soil by themselves?
# A def sits at the centre of its 3 x 3 cell, 5 per row from the north-west corner (140, 148); the key of each shot is Tests/Pickle/things-3293914637-plant.key.md.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: plant catalogue 3293914637 diagnosis

  Scenario: things-3293914637-plantdiag: what spreads around the two beans
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (132, 140) to (162, 164) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (132, 140) to (162, 164)
    And Nelim's Pickle Tools: I place the decor "RA_MetalBean" at (141, 155) fully grown
    And Nelim's Pickle Tools: I place the decor "RA_MetalBeanSmall" at (144, 155) fully grown
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (143, 155) at root size 2.2

    And Nelim's Pickle Tools: the terrain of the cell (143, 155) is logged
    And Nelim's Pickle Tools: the terrain of the cell (150, 155) is logged
    And Nelim's Pickle Tools: the things on the area from (138, 150) to (150, 160) are logged
    And I take a screenshot "things-3293914637-plantdiag"
    And I wait 600 ticks
    And Nelim's Pickle Tools: the things on the area from (138, 150) to (150, 160) are logged
    And I take a screenshot "things-3293914637-plantdiag-later"
    Then no errors were logged
