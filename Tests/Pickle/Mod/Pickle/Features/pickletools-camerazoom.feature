# The camera root size steps. Asks for 6, closer than the game's own range (11 to 60). The steps widen the range first (since 2026-11-12), so the
# camera reaches 6 (ticket f4e9, 2026-11-20); on 2026-10-10 (ticket 9e60, Pickle 6.6.3, before the widening) it read 11 (docs: CameraZoom/README.md).
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.camerazoom.map -Filter pickletools-camerazoom
@requires:nelim.pickletools.camerazoom
Feature: PickleTools camera zoom

  Background:
    Given the save "test-colony" is loaded

  Scenario: the camera is asked for a root size closer than the game's own zoom goes
    When Nelim's Pickle Tools: the camera root size is set to 6
    Then Nelim's Pickle Tools: the camera root size is 6

  Scenario: a size inside Pickle's own range is reached and read back
    When Nelim's Pickle Tools: the camera root size is set to 20
    Then Nelim's Pickle Tools: the camera root size is 20
