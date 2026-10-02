# The camera root size steps. Asks for 6, closer than Pickle's clamp of 12. If the game bounds the zoom above 6, the Then fails
# printing the value the camera read: that value is the answer the gallery suites need (docs: CameraZoom/README.md).
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.camerazoom.map -Filter pickletools-camerazoom
@requires:nelim.pickletools.camerazoom
Feature: PickleTools camera zoom

  Background:
    Given the save "test-colony" is loaded

  Scenario: the camera is asked for a root size closer than Pickle's own zoom goes
    When Nelim's Pickle Tools: the camera root size is set to 6
    Then Nelim's Pickle Tools: the camera root size is 6

  Scenario: a size inside Pickle's own range is reached and read back
    When Nelim's Pickle Tools: the camera root size is set to 20
    Then Nelim's Pickle Tools: the camera root size is 20
