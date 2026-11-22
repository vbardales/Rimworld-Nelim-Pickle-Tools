# Ratkin Anomaly+ plant shot, third attempt (Cat 2026-11-22). Diagnosis (ticket af38 log): RA_MetalBeanSmall ("Small bean vine") spawns a vine on EVERY cell around it as soon as it is placed (192 of them in the frame, 3 RA_MetalBean), with no tick needed. So the two target plants are spawned first, then every other cell of the grid is cleared, keeping only the two target cells.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: plant catalogue 3293914637 clean

  Scenario: things-3293914637-plantclean-01: the two beans alone
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (132, 140) to (162, 164) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (132, 140) to (162, 164)
    And Nelim's Pickle Tools: I place the decor "RA_MetalBean" at (141, 155) fully grown
    And Nelim's Pickle Tools: I place the decor "RA_MetalBeanSmall" at (144, 155) fully grown
    And Nelim's Pickle Tools: the area from (132, 140) to (140, 164) is cleared
    And Nelim's Pickle Tools: the area from (142, 140) to (143, 164) is cleared
    And Nelim's Pickle Tools: the area from (145, 140) to (162, 164) is cleared
    And Nelim's Pickle Tools: the area from (141, 140) to (141, 154) is cleared
    And Nelim's Pickle Tools: the area from (141, 156) to (141, 164) is cleared
    And Nelim's Pickle Tools: the area from (144, 140) to (144, 154) is cleared
    And Nelim's Pickle Tools: the area from (144, 156) to (144, 164) is cleared
    And Nelim's Pickle Tools: the things on the area from (138, 150) to (150, 160) are logged
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (143, 155) at root size 2.2
    And I take a screenshot "things-3293914637-plant-01"
    Then no errors were logged
