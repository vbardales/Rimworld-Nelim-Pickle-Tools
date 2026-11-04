@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: The three child garments of Lisa's Work on a neutral girl of 9 (MannequinChild, not an NSB character)

  Scenario: clothes-lisawork-child-1: three child garments
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "MannequinChild" exists
    And Nelim's Pickle Tools: "MannequinChild" loses all genes
    And Nelim's Pickle Tools: "MannequinChild" gender is female
    And "MannequinChild" is 9 years old
    And Nelim's Pickle Tools: "MannequinChild" body type is Child
    And Nelim's Pickle Tools: "MannequinChild" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "MannequinChild" is undressed
    And Nelim's Pickle Tools: "MannequinChild" wears "UnderWhere_Loincloth"
    And Nelim's Pickle Tools: "MannequinChild" wears "LisaWork_ApparelServantGirlDressChild"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LisaWork_ApparelServantGirlDressChild"
    And Nelim's Pickle Tools: "MannequinChild" is undressed
    And Nelim's Pickle Tools: "MannequinChild" wears "UnderWhere_Loincloth"
    And Nelim's Pickle Tools: "MannequinChild" wears "LisaWork_ApparelSlaveRagsChild"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LisaWork_ApparelSlaveRagsChild"
    And Nelim's Pickle Tools: "MannequinChild" is undressed
    And Nelim's Pickle Tools: "MannequinChild" wears "UnderWhere_Loincloth"
    And Nelim's Pickle Tools: "MannequinChild" wears "LisaWork_ApparelSchoolUniformFemaleChild"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LisaWork_ApparelSchoolUniformFemaleChild"
