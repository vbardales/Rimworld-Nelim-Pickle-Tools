# The same probe as pickletools-camerazoom-cameraplus.feature, with SimpleCameraSetting staged (wsl-deps.camerazoom-simplecamera.map), default settings.
# Without a camera mod the game stops the zoom at root size 11. The Then asserts the size asked: it passes when the mod lifts the limit, and when it does
# not, the failure prints the size read (which may only mean its zoom range is a setting left at its default).
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.camerazoom-simplecamera.map -Filter 'pickletools-camerazoom-simplecamera'
# 2026-10-22: ticket 54d3 played the first version (set 6, read root size 6) and PASSED: SimpleCameraSetting lifts the root size bound of 11 with its default settings.
# The second Then reads what is drawn (orthographic size; 6 if it follows the root size, the game alone draws 11).
@requires:nelim.pickletools.camerazoom
@requires:ray1203.SimpleCameraSetting
Feature: PickleTools camera zoom with SimpleCameraSetting

  Background:
    Given the save "test-colony" is loaded

  Scenario: SimpleCameraSetting lets the camera go closer than the game's own limit of 11
    When Nelim's Pickle Tools: the camera root size is set to 6
    Then Nelim's Pickle Tools: the camera root size is 6
    And Nelim's Pickle Tools: the camera orthographic size is 6
