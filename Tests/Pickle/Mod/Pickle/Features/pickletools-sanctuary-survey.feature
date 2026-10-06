# Survey of the final save "Nelims-tribe" (2026-10-04 22:39): one frame, one screenshot per smiley, the finished river and the house with its animals,
# to confirm from the pictures what docs/SANCTUAIRE-LIEUX.md reads in the file. Not a regression test: it only moves the camera and takes screenshots.
# The save is ScreenshotStudio/Mod/Pickle/Fixtures/Nelims-tribe.rws (a copy of Virginie's "Nelim's tribe" of 2026-10-04, Git LFS, staged by the studio map).
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.sanctuary.map -Filter pickletools-sanctuary-survey
@requires:nelim.pickletools.camerazoom
Feature: Survey of the Sanctuaire save

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused

  Scenario: each candidate site is framed and photographed
    When Nelim's Pickle Tools: I frame the cell (139, 56) at zoom 15
    And I take a screenshot "site-smiley-bas-ouest"
    And Nelim's Pickle Tools: I frame the cell (185, 56) at zoom 15
    And I take a screenshot "site-smiley-bas-centre"
    And Nelim's Pickle Tools: I frame the cell (230, 56) at zoom 15
    And I take a screenshot "site-smiley-bas-est"
    And Nelim's Pickle Tools: I frame the cell (93, 100) at zoom 15
    And I take a screenshot "site-smiley-ouest"
    And Nelim's Pickle Tools: I frame the cell (113, 160) at zoom 15
    And I take a screenshot "site-smiley-riviere"
    And Nelim's Pickle Tools: I frame the cell (176, 202) at zoom 15
    And I take a screenshot "site-smiley-nord"
    And Nelim's Pickle Tools: I frame the cell (67, 177) at zoom 15
    And I take a screenshot "site-smiley-sud-ouest"
    And Nelim's Pickle Tools: I frame the cell (223, 168) at zoom 25
    And I take a screenshot "site-smiley-grand-est-sud"
    And Nelim's Pickle Tools: I frame the cell (114, 30) at zoom 20
    And I take a screenshot "site-riviere-amont"
    And Nelim's Pickle Tools: I frame the cell (114, 8) at zoom 14
    And I take a screenshot "site-riviere-bord-de-carte"
    And Nelim's Pickle Tools: I frame the cell (190, 115) at zoom 15
    And I take a screenshot "site-maison-et-faune"
    And Nelim's Pickle Tools: I frame the cell (177, 173) at zoom 17
    And I take a screenshot "site-bassins"
