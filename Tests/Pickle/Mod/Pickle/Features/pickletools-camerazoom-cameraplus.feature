# The same probe as pickletools-camerazoom.feature, with Camera+ staged (wsl-deps.camerazoom-cameraplus.map). Without a camera mod the game stops the
# zoom at root size 11. Here the Then asserts the size asked: it passes when Camera+ lifts the limit, and when it does not, the failure prints the size read.
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.camerazoom-cameraplus.map -Filter 'pickletools-camerazoom-cameraplus'
@requires:nelim.pickletools.camerazoom
@requires:brrainz.cameraplus
Feature: PickleTools camera zoom with Camera+

  Background:
    Given the save "test-colony" is loaded

  Scenario: Camera+ lets the camera go closer than the game's own limit of 11
    When Nelim's Pickle Tools: the camera root size is set to 6
    Then Nelim's Pickle Tools: the camera root size is 6
