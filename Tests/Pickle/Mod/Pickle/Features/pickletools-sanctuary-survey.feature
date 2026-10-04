# Survey of the save "Nelims-tribe" (the Sanctuaire de Nelim): one frame, one screenshot per candidate site of docs/SANCTUAIRE-LIEUX.md,
# to check from the pictures what the save's cells say. Not a regression test: it only moves the camera and takes screenshots.
# The save is ScreenshotStudio/Mod/Pickle/Fixtures/Nelims-tribe.rws (a copy of Virginie's "Nelim's tribe" of 2026-10-04, Git LFS, staged by the studio map).
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.sanctuary.map -Filter pickletools-sanctuary-survey
@requires:nelim.pickletools.camerazoom
Feature: Survey of the Sanctuaire save

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused

  Scenario: each candidate site is framed and photographed
    When Nelim's Pickle Tools: I frame the cell (190, 115) at zoom 15
    And I take a screenshot "site-home"
    And Nelim's Pickle Tools: I frame the cell (140, 73) at zoom 12
    And I take a screenshot "site-hut"
    And Nelim's Pickle Tools: I frame the cell (128, 110) at zoom 16
    And I take a screenshot "site-river-middle"
    And Nelim's Pickle Tools: I frame the cell (125, 20) at zoom 18
    And I take a screenshot "site-river-south"
    And Nelim's Pickle Tools: I frame the cell (177, 173) at zoom 17
    And I take a screenshot "site-water-pools"
    And Nelim's Pickle Tools: I frame the cell (170, 143) at zoom 17
    And I take a screenshot "site-gravel-yard"
    And Nelim's Pickle Tools: I frame the cell (190, 153) at zoom 12
    And I take a screenshot "site-clearings"
    And Nelim's Pickle Tools: I frame the cell (230, 120) at zoom 23
    And I take a screenshot "site-plantation-east"
    And Nelim's Pickle Tools: I frame the cell (20, 118) at zoom 25
    And I take a screenshot "site-smiley-west"
    And Nelim's Pickle Tools: I frame the cell (223, 168) at zoom 25
    And I take a screenshot "site-smiley-east-sud"
    And Nelim's Pickle Tools: I frame the cell (67, 177) at zoom 15
    And I take a screenshot "site-smiley-southwest"
    And Nelim's Pickle Tools: I frame the cell (46, 55) at zoom 17
    And I take a screenshot "site-bamboo-west"
    And Nelim's Pickle Tools: I frame the cell (170, 35) at zoom 17
    And I take a screenshot "site-bamboo-south"
