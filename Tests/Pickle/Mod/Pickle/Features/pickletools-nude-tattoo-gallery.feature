# The two body tattoo values whose photograph was taken in underwear and must be taken nude (owner, 2026-10-28): NoTattoo_Body (sheet 0501) and Body_Royal (sheets 0502 and 0507).
# Same set-up as the body scenarios of pickletools-roo-gallery.feature (Nelim undressed, no underwear). Shots bodytattoo-<def>.
# Pass: Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-gallery.map -Filter 'pickletools-nude-tattoo-gallery::nude-tattoo-gallery'
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Body tattoo values photographed nude

  Scenario: nude-tattoo-gallery-1: NoTattoo_Body and Body_Royal
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: the look of "Nelim" is saved
    When Nelim's Pickle Tools: "Nelim" body tattoo is "NoTattoo_Body"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-NoTattoo_Body"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
    When Nelim's Pickle Tools: "Nelim" body tattoo is "Body_Royal"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Royal"
    And Nelim's Pickle Tools: the look of "Nelim" is restored
