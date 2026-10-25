@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: One wide photograph per weather of the game (the weather catalogue)

  Scenario: weather-gallery-1: weather 1 to 12 of 24
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And I set the hour to 12
    And Nelim's Pickle Tools: "Nelim" stands at (170, 141) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the area centred on (170, 143) at root size 9
    When I set the weather to "BloodRain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-BloodRain"
    When I set the weather to "GrayPall"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-GrayPall"
    When I set the weather to "MetalHell"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-MetalHell"
    When I set the weather to "Undercave"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Undercave"
    When I set the weather to "UnnaturalDarkness_Stage1"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-UnnaturalDarkness_Stage1"
    When I set the weather to "UnnaturalDarkness_Stage2"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-UnnaturalDarkness_Stage2"
    When I set the weather to "UnnaturalFog"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-UnnaturalFog"
    When I set the weather to "Clear"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Clear"
    When I set the weather to "DryThunderstorm"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-DryThunderstorm"
    When I set the weather to "Fog"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Fog"
    When I set the weather to "FoggyRain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-FoggyRain"
    When I set the weather to "Rain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Rain"

  Scenario: weather-gallery-2: weather 13 to 24 of 24
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And I set the hour to 12
    And Nelim's Pickle Tools: "Nelim" stands at (170, 141) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the area centred on (170, 143) at root size 9
    When I set the weather to "RainyThunderstorm"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-RainyThunderstorm"
    When I set the weather to "SnowGentle"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-SnowGentle"
    When I set the weather to "SnowHard"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-SnowHard"
    When I set the weather to "Underground"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Underground"
    When I set the weather to "BlindFog"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-BlindFog"
    When I set the weather to "Blizzard"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Blizzard"
    When I set the weather to "Orbit"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Orbit"
    When I set the weather to "Overcast"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Overcast"
    When I set the weather to "Sandstorm"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Sandstorm"
    When I set the weather to "TorrentialRain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-TorrentialRain"
    When I set the weather to "ToxRain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-ToxRain"
    When I set the weather to "Windy"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Windy"
