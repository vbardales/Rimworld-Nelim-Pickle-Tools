@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: The three child garments of Lisa's Work on Emi, the girl of the Sanctuary (NSB recipe, 2026-11-04: vanilla Bob instead of the Roo hairstyle, default eyes, no Facial Animation parts: the garment is the subject)

  Scenario: clothes-lisawork-child-1: three child garments on Emi
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (180, 121) facing South
    And Nelim's Pickle Tools: a colonist "Emi" of kind "Colonist" exists
    And Nelim's Pickle Tools: "Emi" loses all genes
    And Nelim's Pickle Tools: "Emi" gender is Female
    And "Emi" is 8 years old
    And Nelim's Pickle Tools: "Emi" body type is Child
    And Nelim's Pickle Tools: "Emi" head type is "Female_AveragePointy"
    And Nelim's Pickle Tools: "Emi" has the gene "Skin_Melanin2"
    And Nelim's Pickle Tools: "Emi" has the gene "Hair_Pink"
    And Nelim's Pickle Tools: "Emi" hair colour is taken from its genes
    And Nelim's Pickle Tools: "Emi" hairstyle is "Bob"
    And Nelim's Pickle Tools: "Emi" face tattoo is "Face_Stars"
    And Nelim's Pickle Tools: "Emi" body tattoo is "none"
    And Nelim's Pickle Tools: "Emi" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Emi" is undressed
    And Nelim's Pickle Tools: "Emi" wears "UnderWhere_Loincloth"
    And Nelim's Pickle Tools: "Emi" wears "LisaWork_ApparelServantGirlDressChild"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LisaWork_ApparelServantGirlDressChild"
    And Nelim's Pickle Tools: "Emi" is undressed
    And Nelim's Pickle Tools: "Emi" wears "UnderWhere_Loincloth"
    And Nelim's Pickle Tools: "Emi" wears "LisaWork_ApparelSlaveRagsChild"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LisaWork_ApparelSlaveRagsChild"
    And Nelim's Pickle Tools: "Emi" is undressed
    And Nelim's Pickle Tools: "Emi" wears "UnderWhere_Loincloth"
    And Nelim's Pickle Tools: "Emi" wears "LisaWork_ApparelSchoolUniformFemaleChild"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LisaWork_ApparelSchoolUniformFemaleChild"
