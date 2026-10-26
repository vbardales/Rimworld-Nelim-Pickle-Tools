@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.colonistrace
Feature: One photograph per animal garment (the animal apparel catalogue)

  Scenario: animal-apparel-gallery-1: garments 1 to 6 of 18
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin1" is spawned at (160, 120)
    And Nelim's Pickle Tools: the animal "Mannequin1" stands at (160, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin1" is dressed in "Apparel_SmallAnimalScarf"
    And Nelim's Pickle Tools: I frame the animal "Mannequin1" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalScarf-front"
    And Nelim's Pickle Tools: the animal "Mannequin1" stands at (160, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalScarf-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin2" is spawned at (166, 120)
    And Nelim's Pickle Tools: the animal "Mannequin2" stands at (166, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin2" is dressed in "Apparel_LargeAnimalScarf"
    And Nelim's Pickle Tools: I frame the animal "Mannequin2" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalScarf-front"
    And Nelim's Pickle Tools: the animal "Mannequin2" stands at (166, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalScarf-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin3" is spawned at (172, 121)
    And Nelim's Pickle Tools: the animal "Mannequin3" stands at (172, 121) facing South
    And Nelim's Pickle Tools: the animal "Mannequin3" is dressed in "Apparel_bridle"
    And Nelim's Pickle Tools: I frame the animal "Mannequin3" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_bridle-front"
    And Nelim's Pickle Tools: the animal "Mannequin3" stands at (172, 121) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_bridle-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin4" is spawned at (178, 120)
    And Nelim's Pickle Tools: the animal "Mannequin4" stands at (178, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin4" is dressed in "Apparel_SmallAnimalClothes"
    And Nelim's Pickle Tools: I frame the animal "Mannequin4" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalClothes-front"
    And Nelim's Pickle Tools: the animal "Mannequin4" stands at (178, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalClothes-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin5" is spawned at (184, 120)
    And Nelim's Pickle Tools: the animal "Mannequin5" stands at (184, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin5" is dressed in "Apparel_LargeAnimalClothes"
    And Nelim's Pickle Tools: I frame the animal "Mannequin5" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalClothes-front"
    And Nelim's Pickle Tools: the animal "Mannequin5" stands at (184, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalClothes-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin6" is spawned at (190, 120)
    And Nelim's Pickle Tools: the animal "Mannequin6" stands at (190, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin6" is dressed in "Apparel_SmallAnimalPowerArmor"
    And Nelim's Pickle Tools: I frame the animal "Mannequin6" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalPowerArmor-front"
    And Nelim's Pickle Tools: the animal "Mannequin6" stands at (190, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalPowerArmor-side"

  Scenario: animal-apparel-gallery-2: garments 7 to 12 of 18
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin1" is spawned at (160, 120)
    And Nelim's Pickle Tools: the animal "Mannequin1" stands at (160, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin1" is dressed in "Apparel_LargeAnimalPowerArmor"
    And Nelim's Pickle Tools: I frame the animal "Mannequin1" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalPowerArmor-front"
    And Nelim's Pickle Tools: the animal "Mannequin1" stands at (160, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalPowerArmor-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin2" is spawned at (166, 120)
    And Nelim's Pickle Tools: the animal "Mannequin2" stands at (166, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin2" is dressed in "Apparel_SmallAnimalPowerArmorHelmet"
    And Nelim's Pickle Tools: I frame the animal "Mannequin2" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalPowerArmorHelmet-front"
    And Nelim's Pickle Tools: the animal "Mannequin2" stands at (166, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_SmallAnimalPowerArmorHelmet-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin3" is spawned at (172, 121)
    And Nelim's Pickle Tools: the animal "Mannequin3" stands at (172, 121) facing South
    And Nelim's Pickle Tools: the animal "Mannequin3" is dressed in "Apparel_LargeAnimalPowerArmorHelmet"
    And Nelim's Pickle Tools: I frame the animal "Mannequin3" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalPowerArmorHelmet-front"
    And Nelim's Pickle Tools: the animal "Mannequin3" stands at (172, 121) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_LargeAnimalPowerArmorHelmet-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin4" is spawned at (178, 120)
    And Nelim's Pickle Tools: the animal "Mannequin4" stands at (178, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin4" is dressed in "diaper"
    And Nelim's Pickle Tools: I frame the animal "Mannequin4" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-diaper-front"
    And Nelim's Pickle Tools: the animal "Mannequin4" stands at (178, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-diaper-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin5" is spawned at (184, 120)
    And Nelim's Pickle Tools: the animal "Mannequin5" stands at (184, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin5" is dressed in "Apparel_dogbow"
    And Nelim's Pickle Tools: I frame the animal "Mannequin5" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_dogbow-front"
    And Nelim's Pickle Tools: the animal "Mannequin5" stands at (184, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_dogbow-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin6" is spawned at (190, 120)
    And Nelim's Pickle Tools: the animal "Mannequin6" stands at (190, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin6" is dressed in "Apparel_GoatMail"
    And Nelim's Pickle Tools: I frame the animal "Mannequin6" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_GoatMail-front"
    And Nelim's Pickle Tools: the animal "Mannequin6" stands at (190, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_GoatMail-side"

  Scenario: animal-apparel-gallery-3: garments 13 to 18 of 18
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin1" is spawned at (160, 120)
    And Nelim's Pickle Tools: the animal "Mannequin1" stands at (160, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin1" is dressed in "Apparel_leatherdogcollar"
    And Nelim's Pickle Tools: I frame the animal "Mannequin1" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_leatherdogcollar-front"
    And Nelim's Pickle Tools: the animal "Mannequin1" stands at (160, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_leatherdogcollar-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin2" is spawned at (166, 120)
    And Nelim's Pickle Tools: the animal "Mannequin2" stands at (166, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin2" is dressed in "Apparel_MedievalHorsePlate"
    And Nelim's Pickle Tools: I frame the animal "Mannequin2" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_MedievalHorsePlate-front"
    And Nelim's Pickle Tools: the animal "Mannequin2" stands at (166, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_MedievalHorsePlate-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin3" is spawned at (172, 121)
    And Nelim's Pickle Tools: the animal "Mannequin3" stands at (172, 121) facing South
    And Nelim's Pickle Tools: the animal "Mannequin3" is dressed in "Apparel_MedievalHorseHelmet"
    And Nelim's Pickle Tools: I frame the animal "Mannequin3" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_MedievalHorseHelmet-front"
    And Nelim's Pickle Tools: the animal "Mannequin3" stands at (172, 121) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_MedievalHorseHelmet-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin4" is spawned at (178, 120)
    And Nelim's Pickle Tools: the animal "Mannequin4" stands at (178, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin4" is dressed in "Apparel_MedievalHorseSaddle"
    And Nelim's Pickle Tools: I frame the animal "Mannequin4" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_MedievalHorseSaddle-front"
    And Nelim's Pickle Tools: the animal "Mannequin4" stands at (178, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_MedievalHorseSaddle-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin5" is spawned at (184, 120)
    And Nelim's Pickle Tools: the animal "Mannequin5" stands at (184, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin5" is dressed in "Apparel_shielddogcollar"
    And Nelim's Pickle Tools: I frame the animal "Mannequin5" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_shielddogcollar-front"
    And Nelim's Pickle Tools: the animal "Mannequin5" stands at (184, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_shielddogcollar-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "Mannequin6" is spawned at (190, 120)
    And Nelim's Pickle Tools: the animal "Mannequin6" stands at (190, 120) facing South
    And Nelim's Pickle Tools: the animal "Mannequin6" is dressed in "Apparel_studdeddogcollar"
    And Nelim's Pickle Tools: I frame the animal "Mannequin6" at zoom 5
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_studdeddogcollar-front"
    And Nelim's Pickle Tools: the animal "Mannequin6" stands at (190, 120) facing East
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "animalapparel-Apparel_studdeddogcollar-side"
