# Shots only (no change): the sanctuary frames Virginie lacks photos of, same state as pickletools-sanctuary-places-shots (save Nelims-tribe-decor-mods, hour 12, Clear, presentation mode). NSB request 2026-11-06.
# A frame that shows nothing useful (wrong centre) is reported to NSB, who fixes the coordinates in SanctuarySites.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
Feature: Sanctuary places: more frames, current state

  Scenario: sanctuary-places-shots-2 A
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "infirmary-animals"
    And I take a screenshot "now-infirmary-animals"
    And Nelim's Sanctuary: I frame the sanctuary "river-bridge"
    And I take a screenshot "now-river-bridge"
    And Nelim's Sanctuary: I frame the sanctuary "left-bank"
    And I take a screenshot "now-left-bank"
    And Nelim's Sanctuary: I frame the sanctuary "right-bank"
    And I take a screenshot "now-right-bank"
    And Nelim's Sanctuary: I frame the sanctuary "barn"
    And I take a screenshot "now-barn"
    And Nelim's Sanctuary: I frame the sanctuary "rice-paddies"
    And I take a screenshot "now-rice-paddies"
    And Nelim's Sanctuary: I frame the sanctuary "rice-paddy"
    And I take a screenshot "now-rice-paddy"
    And Nelim's Sanctuary: I frame the sanctuary "hearth-hall"
    And I take a screenshot "now-hearth-hall"
    And Nelim's Sanctuary: I frame the sanctuary "fire-pit"
    And I take a screenshot "now-fire-pit"
    And Nelim's Sanctuary: I frame the sanctuary "sleeping-nook"
    And I take a screenshot "now-sleeping-nook"

  Scenario: sanctuary-places-shots-2 B
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "sofa-corner"
    And I take a screenshot "now-sofa-corner"
    And Nelim's Sanctuary: I frame the sanctuary "dining-nook"
    And I take a screenshot "now-dining-nook"
    And Nelim's Sanctuary: I frame the sanctuary "prestige-hall"
    And I take a screenshot "now-prestige-hall"
    And Nelim's Sanctuary: I frame the sanctuary "plant-garden"
    And I take a screenshot "now-plant-garden"
    And Nelim's Sanctuary: I frame the sanctuary "fishing-zone"
    And I take a screenshot "now-fishing-zone"
    And Nelim's Sanctuary: I frame the sanctuary "gravel-yard"
    And I take a screenshot "now-gravel-yard"
    And Nelim's Sanctuary: I frame the sanctuary "emerald-clearing"
    And I take a screenshot "now-emerald-clearing"
    And Nelim's Sanctuary: I frame the sanctuary "enclosure"
    And I take a screenshot "now-enclosure"
    And Nelim's Sanctuary: I frame the sanctuary "enclosure-south"
    And I take a screenshot "now-enclosure-south"
    And Nelim's Sanctuary: I frame the sanctuary "enclosure-north"
    And I take a screenshot "now-enclosure-north"

  Scenario: sanctuary-places-shots-2 C
    Given the save "Nelims-tribe-decor-mods" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Sanctuary: I frame the sanctuary "cotton-field"
    And I take a screenshot "now-cotton-field"
    And Nelim's Sanctuary: I frame the sanctuary "exhibition-zone"
    And I take a screenshot "now-exhibition-zone"
    And Nelim's Sanctuary: I frame the sanctuary "calm-zone"
    And I take a screenshot "now-calm-zone"
    And Nelim's Sanctuary: I frame the sanctuary "calm-zone-close"
    And I take a screenshot "now-calm-zone-close"
    And Nelim's Sanctuary: I frame the sanctuary "bare-clearing"
    And I take a screenshot "now-bare-clearing"
    And Nelim's Sanctuary: I frame the sanctuary "dump"
    And I take a screenshot "now-dump"
    And Nelim's Sanctuary: I frame the sanctuary "workshops"
    And I take a screenshot "now-workshops"
    And Nelim's Sanctuary: I frame the sanctuary "preindustrial-workshop"
    And I take a screenshot "now-preindustrial-workshop"
    And Nelim's Sanctuary: I frame the sanctuary "postindustrial-workshop"
    And I take a screenshot "now-postindustrial-workshop"

