@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Hair under a hat on Nelim (choice of the hat-hair mod, GALERIE.md hat rule)

  # Mod under test: Show Hair Under Stuff (RaccoonCuddler.ShowHair, 3255379190), in wsl-deps.faceparts.map.
  # Story: Nelim, long loose hair, puts on four heads covers in turn; the hair must show under each and not cross the hat.
  # Risk: long loose hair clips through the hat brim. Plan: read the four captures; if it clips, replay with Hat Hair Control (3760821540) in the map.
  Scenario: hat-hair-1: four hats on long loose hair
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
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-none"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_CowboyHat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-CowboyHat"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Tuque"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Tuque"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_Flophat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-Flophat"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "Apparel_ArmorHelmetRecon"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-ArmorHelmetRecon"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Victoria"
