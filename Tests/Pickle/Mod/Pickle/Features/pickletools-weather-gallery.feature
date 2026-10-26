@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: One wide photograph per weather of the game (the weather catalogue)

  Scenario: weather-gallery-1: weather 1 to 4 of 24
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
    When Nelim's Pickle Tools: the weather is set at once to "BloodRain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-BloodRain"
    When Nelim's Pickle Tools: the weather is set at once to "GrayPall"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-GrayPall"
    When Nelim's Pickle Tools: the weather is set at once to "MetalHell"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-MetalHell"
    When Nelim's Pickle Tools: the weather is set at once to "Undercave"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Undercave"

  Scenario: weather-gallery-2: weather 5 to 8 of 24
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
    When Nelim's Pickle Tools: the weather is set at once to "UnnaturalDarkness_Stage1"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-UnnaturalDarkness_Stage1"
    When Nelim's Pickle Tools: the weather is set at once to "UnnaturalDarkness_Stage2"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-UnnaturalDarkness_Stage2"
    When Nelim's Pickle Tools: the weather is set at once to "UnnaturalFog"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-UnnaturalFog"
    When Nelim's Pickle Tools: the weather is set at once to "Clear"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Clear"

  Scenario: weather-gallery-3: weather 9 to 12 of 24
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
    When Nelim's Pickle Tools: the weather is set at once to "DryThunderstorm"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-DryThunderstorm"
    When Nelim's Pickle Tools: the weather is set at once to "Fog"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Fog"
    When Nelim's Pickle Tools: the weather is set at once to "FoggyRain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-FoggyRain"
    When Nelim's Pickle Tools: the weather is set at once to "Rain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Rain"

  Scenario: weather-gallery-4: weather 13 to 16 of 24
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
    When Nelim's Pickle Tools: the weather is set at once to "RainyThunderstorm"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-RainyThunderstorm"
    When Nelim's Pickle Tools: the weather is set at once to "SnowGentle"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-SnowGentle"
    When Nelim's Pickle Tools: the weather is set at once to "SnowHard"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-SnowHard"
    When Nelim's Pickle Tools: the weather is set at once to "Underground"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Underground"

  Scenario: weather-gallery-5: weather 17 to 20 of 24
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
    When Nelim's Pickle Tools: the weather is set at once to "BlindFog"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-BlindFog"
    When Nelim's Pickle Tools: the weather is set at once to "Blizzard"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Blizzard"
    When Nelim's Pickle Tools: the weather is set at once to "Orbit"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Orbit"
    When Nelim's Pickle Tools: the weather is set at once to "Overcast"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Overcast"

  Scenario: weather-gallery-6: weather 21 to 24 of 24
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
    When Nelim's Pickle Tools: the weather is set at once to "Sandstorm"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Sandstorm"
    When Nelim's Pickle Tools: the weather is set at once to "TorrentialRain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-TorrentialRain"
    When Nelim's Pickle Tools: the weather is set at once to "ToxRain"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-ToxRain"
    When Nelim's Pickle Tools: the weather is set at once to "Windy"
    And Nelim's Pickle Tools: I let 60 frames pass
    And I take a screenshot "weather-Windy"
