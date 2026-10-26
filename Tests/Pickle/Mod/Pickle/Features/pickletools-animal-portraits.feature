# Front portraits of the fixture animals (Virginie, 2026-10-18: a labrador, a thrumbo, a cat seen from the front). Each animal stands on the cell (176, 120) facing South (the camera side).
# Shogun is the labrador, Atticus and Rain the thrumbos of Nelims-tribe. Cats: pick from the cat breed captures of ColorfulCoatsCatsAndDogsRenew, or add them here once named.
# Rain wears a deep blue-green scarf #1F6769 (owner 2026-10-27; Atticus bare, a pale peach scarf only for a rare ceremony): map wsl-deps.animal-portraits.map (Animal Apparel Framework and Collars and Kit Renew).
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.animal-portraits.map -Filter 'pickletools-animal-portraits'
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.camerazoom
@requires:nelim.pickletools.colonistrace
Feature: Front portraits of the fixture animals

  Scenario: animal-portrait-1: Shogun seen from the front
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the animal "Shogun" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I frame the animal "Shogun" at zoom 2
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "portrait-shogun-labrador"

  Scenario: animal-portrait-2: Atticus seen from the front
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the animal "Atticus" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I frame the animal "Atticus" at zoom 5
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "portrait-atticus-thrumbo"

  Scenario: animal-portrait-3: Rain seen from the front
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the weather is set at once to "Clear"
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the animal "Rain" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the animal "Rain" is dressed in "Apparel_LargeAnimalScarf" dyed "#1F6769"
    And Nelim's Pickle Tools: I let 5 frames pass
    And Nelim's Pickle Tools: the render tree of the animal "Rain" draws "Apparel_LargeAnimalScarf"
    And Nelim's Pickle Tools: I frame the animal "Rain" at zoom 5
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "portrait-rain-thrumbo"


  Scenario: animal-portrait-4: candidate garments for the second thrumbo (the scarf was not pretty, owner 2026-10-26)
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "CandA" is spawned at (160, 120)
    And Nelim's Pickle Tools: the animal "CandA" stands at (160, 120) facing South
    And Nelim's Pickle Tools: the animal "CandA" is dressed in "Apparel_bridle" dyed "#8A5A2B"
    And Nelim's Pickle Tools: I frame the animal "CandA" at zoom 5
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "candidate-thrumbo-bridle"
    And Nelim's Pickle Tools: the animal "CandA" stands at (160, 120) facing East
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "candidate-thrumbo-bridle-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "CandB" is spawned at (166, 120)
    And Nelim's Pickle Tools: the animal "CandB" stands at (166, 120) facing South
    And Nelim's Pickle Tools: the animal "CandB" is dressed in "Apparel_LargeAnimalClothes" dyed "#3A4F7A"
    And Nelim's Pickle Tools: I frame the animal "CandB" at zoom 5
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "candidate-thrumbo-clothes"
    And Nelim's Pickle Tools: the animal "CandB" stands at (166, 120) facing East
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "candidate-thrumbo-clothes-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "CandC" is spawned at (172, 120)
    And Nelim's Pickle Tools: the animal "CandC" stands at (172, 121) facing South
    And Nelim's Pickle Tools: the animal "CandC" is dressed in "Apparel_LargeAnimalScarf" dyed "#2E6F5B"
    And Nelim's Pickle Tools: I frame the animal "CandC" at zoom 5
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "candidate-thrumbo-scarf-green"
    And Nelim's Pickle Tools: the animal "CandC" stands at (172, 121) facing East
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "candidate-thrumbo-scarf-green-side"
    And Nelim's Pickle Tools: an adult animal of kind "Thrumbo" named "CandD" is spawned at (178, 120)
    And Nelim's Pickle Tools: the animal "CandD" stands at (178, 120) facing South
    And Nelim's Pickle Tools: the animal "CandD" is dressed in "Apparel_LargeAnimalPowerArmorHelmet"
    And Nelim's Pickle Tools: I frame the animal "CandD" at zoom 5
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "candidate-thrumbo-helmet"
    And Nelim's Pickle Tools: the animal "CandD" stands at (178, 120) facing East
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "candidate-thrumbo-helmet-side"
