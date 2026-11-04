@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Why the LTS trousers do not show: the same four garments on maps with and without AB Visible Pants and Venus Touch Waistlines

  Scenario: lts-pants-a: no AB Visible Pants, no Venus
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
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Dresspants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-a-Dresspants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Shorts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-a-Shorts"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Sweatpants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-a-Sweatpants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Skirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-a-Skirt"

  Scenario: lts-pants-b: AB Visible Pants alone
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
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Dresspants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-b-Dresspants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Shorts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-b-Shorts"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Sweatpants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-b-Sweatpants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Skirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-b-Skirt"

  Scenario: lts-pants-c: AB Visible Pants and Venus Touch Waistlines
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
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Dresspants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-c-Dresspants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Shorts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-c-Shorts"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Sweatpants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-c-Sweatpants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Skirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-c-Skirt"

  Scenario: lts-pants-d: the garment alone, no underwear worn (the underwear base may hide the trousers)
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
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Dresspants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-d-Dresspants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Shorts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-d-Shorts"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Sweatpants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-d-Sweatpants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Skirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "ltspants-d-Skirt"
