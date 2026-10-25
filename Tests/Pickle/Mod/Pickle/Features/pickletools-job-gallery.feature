@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: One pose per job, first lot (the job catalogue)

  Scenario: job-gallery-1: CutPlant
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (195, 152) facing South
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: I place the decor "Plant_Bamboo" at (192, 150) fully grown
    And Nelim's Pickle Tools: "Nelim" is forced into the job "CutPlant" on the plant at (192, 150)
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I frame the cell (192, 150) at zoom 4
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "job-CutPlant"

  Scenario: job-gallery-2: Harvest
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (195, 152) facing South
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: I place the decor "Plant_Rice" at (197, 150) fully grown
    And Nelim's Pickle Tools: "Nelim" is forced into the job "Harvest" on the plant at (197, 150)
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I frame the cell (197, 150) at zoom 4
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "job-Harvest"

  Scenario: job-gallery-3: Milk
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (195, 152) facing South
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: an adult animal of kind "Cow" named "Vache" is spawned at (192, 154)
    And Nelim's Pickle Tools: "Nelim" is forced into the job "Milk" on "Vache"
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I frame the cell (192, 154) at zoom 4
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "job-Milk"

  Scenario: job-gallery-4: Shear
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (195, 152) facing South
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: an adult animal of kind "Sheep" named "Mouton" is spawned at (197, 154)
    And Nelim's Pickle Tools: "Nelim" is forced into the job "Shear" on "Mouton"
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I frame the cell (197, 154) at zoom 4
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "job-Shear"

  Scenario: job-gallery-5: Slaughter
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (195, 152) facing South
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: an adult animal of kind "Pig" named "Cochon" is spawned at (192, 148)
    And Nelim's Pickle Tools: "Nelim" is forced into the job "Slaughter" on "Cochon"
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I frame the cell (192, 148) at zoom 4
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "job-Slaughter"

  Scenario: job-gallery-6: Train
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And I set the hour to 12
    And I set the weather to "Clear"
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" stands at (195, 152) facing South
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: an adult animal of kind "Horse" named "Cheval" is spawned at (197, 148)
    And Nelim's Pickle Tools: "Nelim" is forced into the job "Train" on "Cheval"
    And Nelim's Pickle Tools: I advance the paused game by exactly 25 ticks
    And Nelim's Pickle Tools: I frame the cell (197, 148) at zoom 4
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "job-Train"
