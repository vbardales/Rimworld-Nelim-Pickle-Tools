# Probe only (no shot): what are the green block of the statue garden and the red marks above the cloister doors (NSB request 2026-11-06). Reads Player.log lines of the probe.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary places: probe

  Scenario: sanctuary-places-probe: statue garden block and entrance door row
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the cells from (149, 99) to (153, 103) are probed
    And Nelim's Pickle Tools: the cells from (172, 121) to (185, 123) are probed
