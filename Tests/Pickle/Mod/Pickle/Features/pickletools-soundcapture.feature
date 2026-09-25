# PLAYED IN WSL, 2026-09-25, at 80 percent volume: 1 of 1, peak -16.2 dB (the WSL profile mutes the game unless a step raises the
# volume, which is why the first run read silence); the owner heard the menu music on her speakers. It runs in the WSL as a small ticket; a rule to run it alone and on Windows was withdrawn the same day (2026-09-25), the WSL
# recording fine. The sound plays on the owner's speakers for its few seconds. See SoundCapture/README.md.
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
    And Nelim's Pickle Tools: the game volume is 80 percent
    When Nelim's Pickle Tools: I record the sound as "main-menu"
    And I click button "New colony"
    And Nelim's Pickle Tools: I let 6 real seconds go by
    And Nelim's Pickle Tools: I stop recording the sound
    Then Nelim's Pickle Tools: the sound recorded as "main-menu" is not silent

  Scenario: with the music and the ambience muted the main menu records silence
    Given the main menu is open
    And Nelim's Pickle Tools: the game volume is 80 percent
    And Nelim's Pickle Tools: the game music and ambience are muted
    When Nelim's Pickle Tools: I record the sound as "main-menu-muted"
    And Nelim's Pickle Tools: I let 4 real seconds go by
    And Nelim's Pickle Tools: I stop recording the sound
    Then Nelim's Pickle Tools: the sound recorded as "main-menu-muted" is silent
