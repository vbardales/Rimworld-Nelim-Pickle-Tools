@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Why a wielded weapon is not drawn (diagnostic of ticket ea83, 2026-10-24)

  Scenario: weapon-diag-1: one weapon, the game's drawing verdict and render tree in the log
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    Then Nelim's Pickle Tools: the weapon render of "Nelim" is logged
    When Nelim's Pickle Tools: "Nelim" wields "Gun_HellcatRifle"
    And Nelim's Pickle Tools: I let 5 frames pass
    Then Nelim's Pickle Tools: the weapon render of "Nelim" is logged
    And I take a screenshot "weapon-diag-Gun_HellcatRifle"
    And Nelim's Pickle Tools: "Nelim" puts its weapon away
