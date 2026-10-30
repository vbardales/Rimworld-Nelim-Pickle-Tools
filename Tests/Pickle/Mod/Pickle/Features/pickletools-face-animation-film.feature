@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.filmticks
Feature: One film per Facial Animation animation (blink, eye movements, jobs), to be turned into gifs
  # PROBE 2026-10-30: two animations first (blink, eyeMoving). The face is NOT held neutral here: that step would stop the animation. Map wsl-deps.face-animations.map.

  Scenario: face-animation-film-blink: film of the animation blink
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: I film every 3 ticks as "faceanim-blink"
    And Nelim's Pickle Tools: "Nelim" facial expression is "blink"
    And Nelim's Pickle Tools: I advance the paused game by exactly 60 ticks
    And Nelim's Pickle Tools: I stop filming

  Scenario: face-animation-film-eyeMoving: film of the animation eyeMoving
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: I film every 3 ticks as "faceanim-eyeMoving"
    And Nelim's Pickle Tools: "Nelim" facial expression is "eyeMoving"
    And Nelim's Pickle Tools: I advance the paused game by exactly 60 ticks
    And Nelim's Pickle Tools: I stop filming
