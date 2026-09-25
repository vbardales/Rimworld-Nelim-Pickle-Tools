# RUN ALONE AND ON WINDOWS (the owner, 2026-09-25): a test that records the sound is played by itself, with no other test around it,
# on the Windows install, with the mod list changed for the run and put back after. Not on the WSL install, where it measured silence
# once (-91 dB) without an explanation. Nothing has been launched on Windows for it; see SoundCapture/README.md. The recording input
# of the tool is PulseAudio only, so a Windows run needs a source the tool does not have yet.
#
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
