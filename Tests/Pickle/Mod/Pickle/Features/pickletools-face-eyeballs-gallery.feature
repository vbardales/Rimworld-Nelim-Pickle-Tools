@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: The ten eyeballs of Facial Animation, one photograph per value (rebuild of the Eyeballs sheet)

  Scenario: face-eyeballs-gallery: seven eyeballs
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    When Nelim's Pickle Tools: "Nelim" eyeballs are "BIGEYE"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-BIGEYE"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeBig"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-EyeBig"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNone"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-EyeNone"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeNormal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-EyeNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeSmall"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-EyeSmall"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeThin"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-EyeThin"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeWide"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-EyeWide"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "Courageous"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-Courageous"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "Empathetic"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-Empathetic"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "Swift"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyeball-Swift"
