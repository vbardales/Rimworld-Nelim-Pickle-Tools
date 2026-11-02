# The texture-save step on vanilla art (no mod ships it, ContentFinder answers). Asked by VenusTouchWaistlines, ticket f38f red 2026-11-02.
#
#   scripts/Run-PickleWsl.ps1 -Mod PickleTools -DepMap wsl-deps.texture-save.map -Filter pickletools-texture-save
@requires:nelim.pickletools.textureowner
Feature: PickleTools texture save

  Background:
    Given the save "test-colony" is loaded

  Scenario: a vanilla body texture is saved as a png
    When Nelim's Pickle Tools: the texture "Things/Pawn/Humanlike/Bodies/Naked_Male_south" is saved as "vanilla-male-south"
