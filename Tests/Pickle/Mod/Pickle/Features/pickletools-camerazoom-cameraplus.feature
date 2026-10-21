# Same probe as pickletools-camerazoom.feature, with Camera+ staged (wsl-deps.camerazoom-cameraplus.map). Camera+ keeps the root size inside the game's own range
# (11 to 60) and maps it onto another orthographic size (Tools.LerpRootSize): at root size 11 its default zoom range draws an orthographic size of 2, where the
# game alone draws 11. Ticket 996e (2026-10-21) read root size 11 and showed the root size is not the zoom. The second Then reads what is drawn.
#
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.camerazoom-cameraplus.map -Filter 'pickletools-camerazoom-cameraplus'
@requires:nelim.pickletools.camerazoom
@requires:brrainz.cameraplus
Feature: PickleTools camera zoom with Camera+

  Background:
    Given the save "test-colony" is loaded

  Scenario: Camera+ keeps the root size at 11 and draws a closer picture than the game alone
    When Nelim's Pickle Tools: the camera root size is set to 6
    Then Nelim's Pickle Tools: the camera root size is 11
    And Nelim's Pickle Tools: the camera orthographic size is 2
