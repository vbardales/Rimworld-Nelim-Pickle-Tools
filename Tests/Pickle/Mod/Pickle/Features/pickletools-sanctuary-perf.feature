# What the Sanctuaire costs to simulate, against Pickle's own small fixture (test-colony, 1,693 things). The last step of each scenario asks for an
# impossible budget (0.001 ms) ON PURPOSE: Pickle's failure message prints the mean and the peak of the sampled ticks, and that is the measurement.
# Red by design. Needs Pickle's fast mode (the launcher's default); in watch mode the budget steps refuse to measure.
# Virginie, 2026-10-04: keep the 241 animals and the 66,000 bamboo unless they badly hurt performance.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.sanctuary.map -Filter pickletools-sanctuary-perf
Feature: Sanctuaire cost per tick

  Scenario: Pickle's test colony, the reference
    Given the save "test-colony" is loaded
    And game speed is paused
    When I wait 600 ticks
    Then the last 500 ticks average under 0.001 ms

  Scenario: the Sanctuaire de Nelim
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    When I wait 600 ticks
    Then the last 500 ticks average under 0.001 ms
