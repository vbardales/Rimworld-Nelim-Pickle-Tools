# The same probe as pickletools-camerazoom-cameraplus.feature, with SimpleCameraSetting staged (wsl-deps.camerazoom-simplecamera.map), default settings.
# Without a camera mod the game stops the zoom at root size 11. The Then asserts the size asked: it passes when the mod lifts the limit, and when it does
# not, the failure prints the size read (which may only mean its zoom range is a setting left at its default).
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.camerazoom-simplecamera.map -Filter 'pickletools-camerazoom-simplecamera'
@requires:nelim.pickletools.camerazoom
@requires:ray1203.SimpleCameraSetting
Feature: PickleTools camera zoom with SimpleCameraSetting

  Background:
    Given the save "test-colony" is loaded

  Scenario: SimpleCameraSetting lets the camera go closer than the game's own limit of 11
    When Nelim's Pickle Tools: the camera root size is set to 6
    Then Nelim's Pickle Tools: the camera root size is 6
