@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Short and tied hairstyles in black for Ryu and Nelim, one photograph per value (request of NSB, 2026-10-23)

  Scenario: hair-black-1: 15 hairstyles in black (26, 26, 26)
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
    And Nelim's Pickle Tools: "Nelim" also wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" hair colour is rgb (26, 26, 26)
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Tatsuro"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_HD_Hair_Tatsuro"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Tidy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_HD_Hair_Tidy"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Undercut"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_HD_Hair_Undercut"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Barber"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_HD_Hair_Barber"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Block"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_HD_Hair_Block"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Pushback"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_HD_Hair_Pushback"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Slack"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_HD_Hair_Slack"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_CleancutHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_Royal_CleancutHD"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_NeatmaleHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_Royal_NeatmaleHD"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Neat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-RBDHD_Neat"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpony"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_HD_Hair_Highpony"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_HD_Hair_Highpigtails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_HD_Hair_Highpigtails"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Roo_Royal_TwintailsHD"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Roo_Royal_TwintailsHD"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "RBDHD_Twintails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-RBDHD_Twintails"
    When Nelim's Pickle Tools: "Nelim" hairstyle is "Ponytails"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hairblack-Ponytails"
