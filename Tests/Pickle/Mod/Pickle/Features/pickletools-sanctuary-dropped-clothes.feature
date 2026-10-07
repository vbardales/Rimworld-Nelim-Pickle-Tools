# Does a dyed shirt keep its colour on the ground? Nelim wears a cream shirt and blue-green pants, drops them with the game's own drop, and the
# picture shows what lands beside her. The step also checks DrawColor and the ground graphic colour (run b1a6: DrawColor right, graphic white).
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
Feature: Sanctuary: dyed clothes dropped on the ground

  Scenario: dropped-clothes: dyed garments beside the pawn who dropped them
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_BasicShirt" dyed rgb (238, 224, 190)
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants" dyed rgb (30, 98, 104)
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 4
    And I take a screenshot "worn"
    When Nelim's Pickle Tools: "Nelim" drops its clothes
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 4
    And I take a screenshot "dropped"
    Then Nelim's Pickle Tools: the "Apparel_BasicShirt" dropped by "Nelim" is drawn in rgb (238, 224, 190)
