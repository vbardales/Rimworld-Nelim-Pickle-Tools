# Photographs every named place of the Sanctuaire (smileys excepted: they are not gallery places), in three scenarios so that none runs for more than a few minutes. Generated from the SanctuarySites table of StudioSteps.cs.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuaire places: one photograph per named place

  Background:
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: all humans but "Nelim" are removed
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: all filth is cleaned
    And Nelim's Pickle Tools: all loose items are put away
    And Nelim's Pickle Tools: studio presentation mode is enabled

  Scenario: named-places-shot: interiors
    Given Nelim's Sanctuary: I am at the sanctuary "overview-north"
    And I take a screenshot "sanctuary-overview-north"
    And Nelim's Sanctuary: I am at the sanctuary "overview-south"
    And I take a screenshot "sanctuary-overview-south"
    And Nelim's Sanctuary: I am at the sanctuary "house"
    And I take a screenshot "sanctuary-house"
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And I take a screenshot "sanctuary-hearth-hall"
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And I take a screenshot "sanctuary-sleeping-nook"
    And Nelim's Sanctuary: I am at the sanctuary "sofa-corner"
    And I take a screenshot "sanctuary-sofa-corner"
    And Nelim's Sanctuary: I am at the sanctuary "dining-nook"
    And I take a screenshot "sanctuary-dining-nook"
    And Nelim's Sanctuary: I am at the sanctuary "fire-pit"
    And I take a screenshot "sanctuary-fire-pit"
    And Nelim's Sanctuary: I am at the sanctuary "cloister"
    And I take a screenshot "sanctuary-cloister"
    And Nelim's Sanctuary: I am at the sanctuary "statue-garden"
    And I take a screenshot "sanctuary-statue-garden"
    And Nelim's Sanctuary: I am at the sanctuary "prestige-hall"
    And I take a screenshot "sanctuary-prestige-hall"
    And Nelim's Sanctuary: I am at the sanctuary "ritual-hall"
    And I take a screenshot "sanctuary-ritual-hall"
    And Nelim's Sanctuary: I am at the sanctuary "terrace"
    And I take a screenshot "sanctuary-terrace"
    And Nelim's Sanctuary: I am at the sanctuary "plant-garden"
    And I take a screenshot "sanctuary-plant-garden"
    And Nelim's Sanctuary: I am at the sanctuary "hut"
    And I take a screenshot "sanctuary-hut"

  Scenario: named-places-shot: outdoors
    Given Nelim's Sanctuary: I am at the sanctuary "river-bridge"
    And I take a screenshot "sanctuary-river-bridge"
    And Nelim's Sanctuary: I am at the sanctuary "left-bank"
    And I take a screenshot "sanctuary-left-bank"
    And Nelim's Sanctuary: I am at the sanctuary "right-bank"
    And I take a screenshot "sanctuary-right-bank"
    And Nelim's Sanctuary: I am at the sanctuary "fishing-zone"
    And I take a screenshot "sanctuary-fishing-zone"
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And I take a screenshot "sanctuary-water-garden"
    And Nelim's Sanctuary: I am at the sanctuary "gravel-yard"
    And I take a screenshot "sanctuary-gravel-yard"

  Scenario: named-places-shot: north-east
    Given Nelim's Sanctuary: I am at the sanctuary "emerald-clearing"
    And I take a screenshot "sanctuary-emerald-clearing"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure"
    And I take a screenshot "sanctuary-enclosure"
    And Nelim's Sanctuary: I am at the sanctuary "workshops"
    And I take a screenshot "sanctuary-workshops"
    And Nelim's Sanctuary: I am at the sanctuary "barn"
    And I take a screenshot "sanctuary-barn"
    And Nelim's Sanctuary: I am at the sanctuary "preindustrial-workshop"
    And I take a screenshot "sanctuary-preindustrial-workshop"
    And Nelim's Sanctuary: I am at the sanctuary "postindustrial-workshop"
    And I take a screenshot "sanctuary-postindustrial-workshop"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "sanctuary-enclosure-south"
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-north"
    And I take a screenshot "sanctuary-enclosure-north"
    And Nelim's Sanctuary: I am at the sanctuary "rice-paddies"
    And I take a screenshot "sanctuary-rice-paddies"
    And Nelim's Sanctuary: I am at the sanctuary "cotton-field"
    And I take a screenshot "sanctuary-cotton-field"
    And Nelim's Sanctuary: I am at the sanctuary "rice-paddy"
    And I take a screenshot "sanctuary-rice-paddy"
    And Nelim's Sanctuary: I am at the sanctuary "flower-garden"
    And I take a screenshot "sanctuary-flower-garden"
    And Nelim's Sanctuary: I am at the sanctuary "exhibition-zone"
    And I take a screenshot "sanctuary-exhibition-zone"
    And Nelim's Sanctuary: I am at the sanctuary "dump"
    And I take a screenshot "sanctuary-dump"
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And I take a screenshot "sanctuary-calm-zone"
