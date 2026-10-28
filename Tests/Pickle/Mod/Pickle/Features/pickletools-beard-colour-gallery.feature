@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: A beard in every hair colour (gallery of the look catalogues)

  Scenario: beard-colour-gallery-1: beard colours 1 to 8 of 8
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Soren" exists
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" beard is "Norse"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Soren" hair colour is rgb (237, 202, 156)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beardcolour-Blonde"
    When Nelim's Pickle Tools: "Soren" hair colour is rgb (51, 51, 51)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beardcolour-DarkBlack"
    When Nelim's Pickle Tools: "Soren" hair colour is rgb (90, 58, 32)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beardcolour-DarkBrown"
    When Nelim's Pickle Tools: "Soren" hair colour is rgb (64, 51, 38)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beardcolour-DarkReddish"
    When Nelim's Pickle Tools: "Soren" hair colour is rgb (76, 51, 26)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beardcolour-DarkSaturatedReddish"
    When Nelim's Pickle Tools: "Soren" hair colour is rgb (79, 71, 66)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beardcolour-MidBlack"
    When Nelim's Pickle Tools: "Soren" hair colour is rgb (26, 26, 26)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beardcolour-PitchBlack"
    When Nelim's Pickle Tools: "Soren" hair colour is rgb (193, 146, 85)
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beardcolour-SandyBlonde"
