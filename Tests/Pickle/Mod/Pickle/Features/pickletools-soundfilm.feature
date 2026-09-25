# The optional SoundCapture tool, second step: a video WITH its sound. The recorder and a film by the clock (ten pictures a second)
# start in one step, and the end step encodes the pictures and puts the sound into one mp4 (H.264 and AAC, which Windows plays as
# it is), `film-sound.mp4` in the report's `screenshots/film/pickletools-sound--<name>/`.
#
# PLAYED 2026-09-25 after a first attempt read -91 dB (the WSLg audio stalled, see SoundCapture/README.md) and a second crashed at startup (exit 139): 1 of 1, an 11.9 s mp4 with the menu music (peak -14.3 dB), the picture at 7.4 pictures a second because the software renderer draws slowly. What a run proves: the file exists and the sound in it is not silent. What only a person can say: that the picture
# and the sound are in step, and that the sound is the right one. Open the mp4, watch and listen.
#
# The sound also plays on the owner's speakers for the few seconds of the scenario (the WSLg sink is the way out).
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.soundcapture.map -Filter pickletools-soundfilm
@requires:nelim.pickletools.soundcapture
Feature: PickleTools video with sound

  Scenario: the main menu is filmed with its music
    Given the main menu is open
    And Nelim's Pickle Tools: the game volume is 80 percent
    When Nelim's Pickle Tools: I film with sound as "main-menu-film"
    And Nelim's Pickle Tools: I let 3 real seconds go by
    And I click button "New colony"
    And Nelim's Pickle Tools: I let 4 real seconds go by
    And Nelim's Pickle Tools: I stop filming with sound
    Then Nelim's Pickle Tools: the sound recorded as "main-menu-film" is not silent
