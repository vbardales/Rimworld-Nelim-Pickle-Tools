@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: [LTS] Raiments, one photograph per garment on Nelim (gallery of the look catalogues)

  Scenario: clothes-lts-1: garments 1 to 20 of 32
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
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_StraightDress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_StraightDress"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_SummerSundress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_SummerSundress"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Skirt"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Skirt"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Shorts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Shorts"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Dresspants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Dresspants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Scarf"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Scarf"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_CourierCoat"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_CourierCoat"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_BearCape"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_BearCape"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_MedievalCape"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_MedievalCape"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_ClockworkAttire"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_ClockworkAttire"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_LacedDress"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_LacedDress"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_HalfGasMask"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_HalfGasMask"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Bodysuit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Bodysuit"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_FuturisticTop"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_FuturisticTop"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_FuturisticPants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_FuturisticPants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Sweatpants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Sweatpants"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_MedievalArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_MedievalArmor"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_LeatherArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_LeatherArmor"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Poncho"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Poncho"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Hoodie"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Hoodie"

  Scenario: clothes-lts-2: garments 21 to 32 of 32
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
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_MilitaryParka"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_MilitaryParka"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_DuneCloth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_DuneCloth"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_MaidArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_MaidArmor"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_ButlerArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_ButlerArmor"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_LightPolymerArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_LightPolymerArmor"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_RegalCloth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_RegalCloth"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_TartanPlaid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_TartanPlaid"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Tunika"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Tunika"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_TribalHeavyArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_TribalHeavyArmor"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_TribalLightArmor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_TribalLightArmor"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_TribalWear"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_TribalWear"
    When Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: "Nelim" wears "LTS_Jumpsuit"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "garment-LTS_Jumpsuit"

  Scenario: clothes-lts-3: hats 1 to 9 of 9
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
    When Nelim's Pickle Tools: "Nelim" wears "LTS_Shawl"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-LTS_Shawl"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "LTS_CourierHat"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-LTS_CourierHat"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "LTS_WideBrimmedHat"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-LTS_WideBrimmedHat"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "LTS_MedievalArmorHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-LTS_MedievalArmorHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "LTS_MaidHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-LTS_MaidHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "LTS_LightPolymerHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-LTS_LightPolymerHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "LTS_TribalHeavyMask"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-LTS_TribalHeavyMask"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "LTS_TribalLightHelmet"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-LTS_TribalLightHelmet"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"
    When Nelim's Pickle Tools: "Nelim" wears "LTS_TribalHeadband"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Corset"
    And Nelim's Pickle Tools: "Nelim" wears "Apparel_Pants"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "hat-LTS_TribalHeadband"
    And Nelim's Pickle Tools: "Nelim" gets back the clothes it had
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Long"

