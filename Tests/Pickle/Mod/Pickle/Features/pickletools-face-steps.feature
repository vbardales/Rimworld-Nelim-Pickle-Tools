@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
Feature: Eye colour and facial expression of a colonist (Nals Facial Animation)

  Scenario: face-steps: Nelim with violet eyes, then a played expression
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: "Nelim" eye colour is rgb (150, 60, 200)
    And Nelim's Pickle Tools: "Nelim" facial expression is "SocialRelax"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And I take a screenshot "violet-eyes"

  Scenario: face-steps-eyes: violet eyes with a neutral face, then a cheerful expression
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: "Nelim" eye colour is rgb (150, 60, 200)
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "violet-eyes-normal"
    When Nelim's Pickle Tools: "Nelim" facial expression is "moodCheerful"
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 2
    And I take a screenshot "cheerful"
