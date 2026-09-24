# The optional SoundCapture tool: the game's sound, recorded between two steps and measured. English only, because it
# clicks a button by its label; the sound does not depend on the language.
#
# This scenario is also the answer to a question that was open: does the headless game under Xvfb open an audio output at
# all? If it does not, the recorder hears nothing and the last step fails with a message that says so. That is a result,
# not a defect of the tool.
#
# NOTE: on the WSL install the sink that carries the game's sound is the one WSLg provides, so the same sound also plays on the
# Windows speakers for the few seconds of this scenario.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.soundcapture.map -Filter pickletools-soundcapture
@requires:nelim.pickletools.soundcapture
Feature: PickleTools sound capture

  Scenario: the game's sound reaches the recorder from the main menu
    Given the main menu is open
    When Nelim's Pickle Tools: I record the sound as "main-menu"
    And I click button "New colony"
    And Nelim's Pickle Tools: I let 6 real seconds go by
    And Nelim's Pickle Tools: I stop recording the sound
    Then Nelim's Pickle Tools: the sound recorded as "main-menu" is not silent
