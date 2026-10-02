# A trader arrives and the trade window opens. No purchase: the stock of a trader is random, so the buy step is not in this probe.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.tradesteps.map -Filter pickletools-tradesteps
@requires:nelim.pickletools.tradesteps
Feature: PickleTools trade steps

  Background:
    Given the save "test-colony" is loaded

  Scenario: a trader arrives and the trade window opens
    Given Nelim's Pickle Tools: a trader of kind "Caravan_Outlander_BulkGoods" has arrived
    When Nelim's Pickle Tools: the trade window is open
