@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.colonistrace
Feature: One photograph per animal garment (the animal apparel catalogue)

  Scenario: animal-apparel-gallery-1: garments 1 to 12 of 18
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: an adult animal of kind "Alpaca" named "Mannequin1" is spawned at (160, 120)
    And Nelim's Pickle Tools: the animal "Mannequin1" stands at (160, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin1" is dressed in "Apparel_SmallAnimalScarf"
    And Nelim's Pickle Tools: I frame the animal "Mannequin1" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalScarf"
    And Nelim's Pickle Tools: an adult animal of kind "Cougar" named "Mannequin2" is spawned at (166, 120)
    And Nelim's Pickle Tools: the animal "Mannequin2" stands at (166, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin2" is dressed in "Apparel_LargeAnimalScarf"
    And Nelim's Pickle Tools: I frame the animal "Mannequin2" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalScarf"
    And Nelim's Pickle Tools: an adult animal of kind "Elephant" named "Mannequin3" is spawned at (172, 120)
    And Nelim's Pickle Tools: the animal "Mannequin3" stands at (172, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin3" is dressed in "Apparel_bridle"
    And Nelim's Pickle Tools: I frame the animal "Mannequin3" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_bridle"
    And Nelim's Pickle Tools: an adult animal of kind "Alpaca" named "Mannequin4" is spawned at (178, 120)
    And Nelim's Pickle Tools: the animal "Mannequin4" stands at (178, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin4" is dressed in "Apparel_SmallAnimalClothes"
    And Nelim's Pickle Tools: I frame the animal "Mannequin4" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalClothes"
    And Nelim's Pickle Tools: an adult animal of kind "Cougar" named "Mannequin5" is spawned at (184, 120)
    And Nelim's Pickle Tools: the animal "Mannequin5" stands at (184, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin5" is dressed in "Apparel_LargeAnimalClothes"
    And Nelim's Pickle Tools: I frame the animal "Mannequin5" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalClothes"
    And Nelim's Pickle Tools: an adult animal of kind "Alpaca" named "Mannequin6" is spawned at (190, 120)
    And Nelim's Pickle Tools: the animal "Mannequin6" stands at (190, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin6" is dressed in "Apparel_SmallAnimalPowerArmor"
    And Nelim's Pickle Tools: I frame the animal "Mannequin6" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalPowerArmor"
    And Nelim's Pickle Tools: an adult animal of kind "Bear_Grizzly" named "Mannequin7" is spawned at (196, 120)
    And Nelim's Pickle Tools: the animal "Mannequin7" stands at (196, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin7" is dressed in "Apparel_LargeAnimalPowerArmor"
    And Nelim's Pickle Tools: I frame the animal "Mannequin7" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalPowerArmor"
    And Nelim's Pickle Tools: an adult animal of kind "Alpaca" named "Mannequin8" is spawned at (202, 120)
    And Nelim's Pickle Tools: the animal "Mannequin8" stands at (202, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin8" is dressed in "Apparel_SmallAnimalPowerArmorHelmet"
    And Nelim's Pickle Tools: I frame the animal "Mannequin8" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalPowerArmorHelmet"
    And Nelim's Pickle Tools: an adult animal of kind "Bear_Grizzly" named "Mannequin9" is spawned at (208, 120)
    And Nelim's Pickle Tools: the animal "Mannequin9" stands at (208, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin9" is dressed in "Apparel_LargeAnimalPowerArmorHelmet"
    And Nelim's Pickle Tools: I frame the animal "Mannequin9" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalPowerArmorHelmet"
    And Nelim's Pickle Tools: an adult animal of kind "Husky" named "Mannequin10" is spawned at (214, 120)
    And Nelim's Pickle Tools: the animal "Mannequin10" stands at (214, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin10" is dressed in "diaper"
    And Nelim's Pickle Tools: I frame the animal "Mannequin10" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-diaper"
    And Nelim's Pickle Tools: an adult animal of kind "Fox_Arctic" named "Mannequin11" is spawned at (220, 120)
    And Nelim's Pickle Tools: the animal "Mannequin11" stands at (220, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin11" is dressed in "Apparel_dogbow"
    And Nelim's Pickle Tools: I frame the animal "Mannequin11" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_dogbow"
    And Nelim's Pickle Tools: an adult animal of kind "Goat" named "Mannequin12" is spawned at (226, 120)
    And Nelim's Pickle Tools: the animal "Mannequin12" stands at (226, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin12" is dressed in "Apparel_GoatMail"
    And Nelim's Pickle Tools: I frame the animal "Mannequin12" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_GoatMail"

  Scenario: animal-apparel-gallery-2: garments 13 to 18 of 18
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: an adult animal of kind "Fox_Arctic" named "Mannequin1" is spawned at (160, 120)
    And Nelim's Pickle Tools: the animal "Mannequin1" stands at (160, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin1" is dressed in "Apparel_leatherdogcollar"
    And Nelim's Pickle Tools: I frame the animal "Mannequin1" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_leatherdogcollar"
    And Nelim's Pickle Tools: an adult animal of kind "Horse" named "Mannequin2" is spawned at (166, 120)
    And Nelim's Pickle Tools: the animal "Mannequin2" stands at (166, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin2" is dressed in "Apparel_MedievalHorsePlate"
    And Nelim's Pickle Tools: I frame the animal "Mannequin2" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_MedievalHorsePlate"
    And Nelim's Pickle Tools: an adult animal of kind "Horse" named "Mannequin3" is spawned at (172, 120)
    And Nelim's Pickle Tools: the animal "Mannequin3" stands at (172, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin3" is dressed in "Apparel_MedievalHorseHelmet"
    And Nelim's Pickle Tools: I frame the animal "Mannequin3" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_MedievalHorseHelmet"
    And Nelim's Pickle Tools: an adult animal of kind "Horse" named "Mannequin4" is spawned at (178, 120)
    And Nelim's Pickle Tools: the animal "Mannequin4" stands at (178, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin4" is dressed in "Apparel_MedievalHorseSaddle"
    And Nelim's Pickle Tools: I frame the animal "Mannequin4" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_MedievalHorseSaddle"
    And Nelim's Pickle Tools: an adult animal of kind "Fox_Arctic" named "Mannequin5" is spawned at (184, 120)
    And Nelim's Pickle Tools: the animal "Mannequin5" stands at (184, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin5" is dressed in "Apparel_shielddogcollar"
    And Nelim's Pickle Tools: I frame the animal "Mannequin5" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_shielddogcollar"
    And Nelim's Pickle Tools: an adult animal of kind "Fox_Arctic" named "Mannequin6" is spawned at (190, 120)
    And Nelim's Pickle Tools: the animal "Mannequin6" stands at (190, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin6" is dressed in "Apparel_studdeddogcollar"
    And Nelim's Pickle Tools: I frame the animal "Mannequin6" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_studdeddogcollar"
