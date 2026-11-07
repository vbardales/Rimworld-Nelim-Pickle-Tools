# Shots only, no decor change (NSB order, Virginie 2026-11-07): the infirmary as a whole and the free zones, one shot per SanctuarySites frame, noon, clear, wild animals kept out, overlays hidden. State: Nelims-tribe-decor-mods-i (2g not played when written). Two scenarios so that one run stays under the 300 s watchdog.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: Sanctuary zones and infirmary: shots

  Scenario: sanctuary-zone-shots A
    Given the save "Nelims-tribe-decor-mods-i" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And Nelim's Sanctuary: I am at the sanctuary "infirmary"
    And I take a screenshot "after-infirmary"
    And Nelim's Sanctuary: I am at the sanctuary "emerald-clearing"
    And I take a screenshot "after-emerald-clearing"
    And Nelim's Sanctuary: I am at the sanctuary "bare-clearing"
    And I take a screenshot "after-bare-clearing"
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And I take a screenshot "after-calm-zone"
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone-close"
    And I take a screenshot "after-calm-zone-close"
    And Nelim's Sanctuary: I am at the sanctuary "exhibition-zone"
    And I take a screenshot "after-exhibition-zone"
    And Nelim's Sanctuary: I am at the sanctuary "fishing-zone"
    And I take a screenshot "after-fishing-zone"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-southwest"
    And I take a screenshot "after-smiley-southwest"

  Scenario: sanctuary-zone-shots B
    Given the save "Nelims-tribe-decor-mods-i" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And Nelim's Sanctuary: I am at the sanctuary "smiley-bottom-west"
    And I take a screenshot "after-smiley-bottom-west"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-bottom-centre"
    And I take a screenshot "after-smiley-bottom-centre"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-bottom-east"
    And I take a screenshot "after-smiley-bottom-east"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-west"
    And I take a screenshot "after-smiley-west"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-river"
    And I take a screenshot "after-smiley-river"
    And Nelim's Sanctuary: I am at the sanctuary "smiley-north"
    And I take a screenshot "after-smiley-north"
    And Nelim's Sanctuary: I am at the sanctuary "window-backdrop-for-width"
    And I take a screenshot "after-window-backdrop-for-width"
    And Nelim's Sanctuary: I am at the sanctuary "window-backdrop-for-height"
    And I take a screenshot "after-window-backdrop-for-height"
