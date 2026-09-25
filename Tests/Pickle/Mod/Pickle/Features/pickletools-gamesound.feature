# The game-side sound check of the optional SoundCapture tool: what the GAME holds as playing (a live sustainer, a playing
# one-shot sample, the main menu's music), not what reaches an audio device. It is the check EponaInstrumentsRenew makes for its
# instruments' sounds, and it does not depend on the audio sink, where the recorder of pickletools-soundcapture.feature measured
# silence. It says the game STARTED a sound; that a person can hear it stays by ear.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.soundcapture.map -Filter pickletools-gamesound
@requires:nelim.pickletools.soundcapture
Feature: PickleTools game sound

  Scenario: the game holds a playing sound on the main menu
    Given the main menu is open
    When Nelim's Pickle Tools: I let 3 real seconds go by
    Then Nelim's Pickle Tools: the game is playing a sound
