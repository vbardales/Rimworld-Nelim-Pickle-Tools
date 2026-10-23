# ScreenshotMode and ScreenshotStudio on the Sanctuary map (Nelims-tribe), replacing the flower meadow scenarios deleted on 2026-10-08.
# Written 2026-10-23 (owner: rewrite on SanctuaryBacklot). NOT PLAYED when written. The map is the look-gallery map.
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-gallery.map -Filter pickletools-screenshotmode
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.screenshotmode
@requires:nelim.pickletools.camerazoom
Feature: ScreenshotMode and ScreenshotStudio on the Sanctuary

  Scenario: screenshotmode-1: the map alone, then the interface again
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the temperature of the map reads 20 degrees
    And Nelim's Pickle Tools: the letters and the alerts are cleared from the screen
    And Nelim's Pickle Tools: the messages are cleared from the screen
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 12
    When Nelim's Pickle Tools: the map is shown alone for a capture
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "map-alone"
    And Nelim's Pickle Tools: the interface is shown again
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "interface-again"

  Scenario: screenshotmode-2: studio presentation mode hides the overlays
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 12
    When Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "presentation-mode"
