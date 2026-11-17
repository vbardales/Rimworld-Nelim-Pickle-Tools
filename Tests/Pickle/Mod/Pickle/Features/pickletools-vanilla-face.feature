# The vanilla face (2026-11-17, Virginie): the Core heads on a pawn WITHOUT Facial Animation, to see the face the base game draws by itself (mouth, eyes, brows are in the head texture).
# Map: wsl-deps.vanilla-face.map (the tools and the empty base only: no Facial Animation, no body or hair mod). Written 2026-11-17, NOT PLAYED when written.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: vanilla face

  Scenario: vanilla-face-01: the twelve Core heads, six male then six female
    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: a colonist "Jet" exists
    And Nelim's Pickle Tools: "Jet" stands at (143, 151) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Jet" hairstyle is "Bald"
    And Nelim's Pickle Tools: I frame the cell (143, 151) at zoom 4
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    When Nelim's Pickle Tools: "Jet" sex is male
    And Nelim's Pickle Tools: "Jet" head type is "Male_AverageNormal"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Male_AverageNormal"
    And Nelim's Pickle Tools: "Jet" head type is "Male_AveragePointy"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Male_AveragePointy"
    And Nelim's Pickle Tools: "Jet" head type is "Male_AverageWide"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Male_AverageWide"
    And Nelim's Pickle Tools: "Jet" head type is "Male_NarrowNormal"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Male_NarrowNormal"
    And Nelim's Pickle Tools: "Jet" head type is "Male_NarrowPointy"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Male_NarrowPointy"
    And Nelim's Pickle Tools: "Jet" head type is "Male_NarrowWide"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Male_NarrowWide"
    When Nelim's Pickle Tools: "Jet" sex is female
    And Nelim's Pickle Tools: "Jet" head type is "Female_AverageNormal"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Female_AverageNormal"
    And Nelim's Pickle Tools: "Jet" head type is "Female_AveragePointy"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Female_AveragePointy"
    And Nelim's Pickle Tools: "Jet" head type is "Female_AverageWide"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Female_AverageWide"
    And Nelim's Pickle Tools: "Jet" head type is "Female_NarrowNormal"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Female_NarrowNormal"
    And Nelim's Pickle Tools: "Jet" head type is "Female_NarrowPointy"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Female_NarrowPointy"
    And Nelim's Pickle Tools: "Jet" head type is "Female_NarrowWide"
    And I wait 10 ticks
    And I take a screenshot "vanillaface-Female_NarrowWide"
    Then no errors were logged
