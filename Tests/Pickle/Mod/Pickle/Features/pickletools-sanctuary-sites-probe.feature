# Diagnostic, no change: what lies at the centres of the frames NSB doubts (rice-paddies, rice-paddy, cotton-field, dump, gravel-yard) in the decor-mods save.
# Logs the things within 10 cells and the terrain of each centre. NSB question 2026-11-06.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary sites probe

  Scenario: sanctuary-sites-probe: what is at the doubted centres
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the things within 10 cells of (229, 114) are listed
    And Nelim's Pickle Tools: the cell (229, 114) is probed
    And Nelim's Pickle Tools: the things within 10 cells of (230, 122) are listed
    And Nelim's Pickle Tools: the cell (230, 122) is probed
    And Nelim's Pickle Tools: the things within 10 cells of (214, 109) are listed
    And Nelim's Pickle Tools: the cell (214, 109) is probed
    And Nelim's Pickle Tools: the things within 10 cells of (49, 236) are listed
    And Nelim's Pickle Tools: the cell (49, 236) is probed
    And Nelim's Pickle Tools: the things within 10 cells of (170, 143) are listed
    And Nelim's Pickle Tools: the cell (170, 143) is probed
