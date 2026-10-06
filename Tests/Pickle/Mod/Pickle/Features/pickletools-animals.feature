# The animal steps: a named animal at a chosen life stage (by index and by LifeStageDef name), an adult, then the camera framed on one by its nickname. The steps assert the life stage themselves.
@requires:nelim.pickletools.screenshotstudio
Feature: Animals staged for a photograph

  Scenario: animals-shot: a kitten, a juvenile, an adult and a named stage, framed by nickname
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: an animal of kind "Cat" named "Mimi" is spawned at (197, 152) at life stage 0
    And Nelim's Pickle Tools: an animal of kind "Cat" named "Moka" is spawned at (199, 152) at life stage 1
    And Nelim's Pickle Tools: an adult animal of kind "Cat" named "Minou" is spawned at (201, 152)
    And Nelim's Pickle Tools: an animal of kind "Cat" named "Plume" is spawned at (203, 152) at the life stage "AnimalBaby"
    When Nelim's Pickle Tools: I frame the animal "Mimi" at zoom 4
    And I take a screenshot "animals-kitten"
    And Nelim's Pickle Tools: I frame the animal "Minou" at zoom 4
    And I take a screenshot "animals-adult"
