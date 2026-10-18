# Front portraits of the fixture animals (Virginie, 2026-10-18: a labrador, a thrumbo, a cat seen from the front). Each animal stands on the cell (176, 120) facing South (the camera side).
# Shogun is the labrador, Atticus and Rain the thrumbos of Nelims-tribe. Cats: pick from the cat breed captures of ColorfulCoatsCatsAndDogsRenew, or add them here once named.
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.faceparts.map -Filter 'pickletools-animal-portraits'
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
    And Nelim's Pickle Tools: I frame the animal "Shogun" at zoom 3
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
    And Nelim's Pickle Tools: I frame the animal "Atticus" at zoom 2
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
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: the animal "Rain" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I frame the animal "Rain" at zoom 2
    When Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "portrait-rain-thrumbo"

