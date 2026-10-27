# The child garments of the look catalogue (Biotech Kid*, Odyssey VacsuitChildren) on Soren at 8 years old, one photograph each (shots garment-<def>).
# Pass: Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-gallery.map -Filter 'pickletools-child-gallery::child-gallery'
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Child garments, one photograph each (gallery of the look catalogues)

  Scenario: child-gallery-1: child garments 1 to 7 of 7
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
    And "Soren" is 8 years old
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_KidPants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidPants"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_KidRomper"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidRomper"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_KidShirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidShirt"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_KidTribal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidTribal"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_KidHelmet"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidHelmet"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_KidParka"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_KidParka"
    When Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "Apparel_VacsuitChildren"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-Apparel_VacsuitChildren"
