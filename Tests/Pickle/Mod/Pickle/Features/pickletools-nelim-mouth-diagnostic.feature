# Nelim mouth past the face outline in side view (EnG capture 4-pain-field, NSB request 2026-11-08, owner). Diagnostic, NO fixture saved. Loads Nelims-tribe-decor-mods-s (Nelim and the sanctuary), gives her the canon face with PickleTools steps (NSB's "has her own face" is not in this repository: brows BrowNormal, mouth MouthLipsSmirk, hair Roo_HD_Hair_Highpony), frames her head close facing East then West. A: FA head shape untouched (the head def she has is logged). B: face head shape HeadPointy (nals.facialanimationexperimentals 2581693737, in the map wsl-deps.nelim-mouth.map only). Answer wanted: does B keep the lower lip inside the outline?
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.colonistrace
Feature: Nelim mouth in profile

  Background:
    Given the save "Nelims-tribe-decor-mods-s" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthLipsSmirk"
    And Nelim's Pickle Tools: "Nelim" stands at (196, 112) facing East
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the animals are kept out of the area from (0, 0) to (249, 249)
    And Nelim's Pickle Tools: the area and zone overlays are hidden

  Scenario: nelim-mouth-A: face head shape untouched, east then west
    Given Nelim's Pickle Tools: the face parts of "Nelim" are logged
    And Nelim's Pickle Tools: "Nelim" waits in place
    And I wait 60 ticks
    When Nelim's Pickle Tools: the camera frames the head of "Nelim" at root size 2
    And I wait 30 ticks
    And I take a screenshot "mouth-A-east"
    And Nelim's Pickle Tools: "Nelim" faces West
    And I wait 30 ticks
    And I take a screenshot "mouth-A-west"

  Scenario: nelim-mouth-B: face head shape HeadPointy, east then west
    Given Nelim's Pickle Tools: "Nelim" face head shape is "HeadPointy"
    And Nelim's Pickle Tools: the face parts of "Nelim" are logged
    And Nelim's Pickle Tools: "Nelim" waits in place
    And I wait 60 ticks
    When Nelim's Pickle Tools: the camera frames the head of "Nelim" at root size 2
    And I wait 30 ticks
    And I take a screenshot "mouth-B-east"
    And Nelim's Pickle Tools: "Nelim" faces West
    And I wait 30 ticks
    And I take a screenshot "mouth-B-west"
