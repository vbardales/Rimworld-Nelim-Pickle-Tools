# Diagnostic of the "beauty" look of the fixture eyes (owner, 2026-10-25: the eye gene sheet still shows lashes and a liner with LidNormal and EyeBig).
# Photographs Nelim with her genes, logs them, removes every gene, gives only the eye colour gene back, photographs again. Not a test. NOT PLAYED when written.
#   Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.faceparts.map -Filter pickletools-eye-diag
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Why the fixture eyes look beauty

  Scenario: eye-diag: the eyes with the genes of Nelim, then with no gene but the eye colour
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Nelim" face tattoo is "none"
    And Nelim's Pickle Tools: "Nelim" mouth is "MouthNormal"
    And Nelim's Pickle Tools: "Nelim" brows are "BrowNormal"
    And Nelim's Pickle Tools: "Nelim" lids are "LidNormal"
    And Nelim's Pickle Tools: "Nelim" face skin is "SkinNormal"
    And Nelim's Pickle Tools: "Nelim" eyeballs are "EyeBig"
    And Nelim's Pickle Tools: "Nelim" face head shape is "HeadNormal"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: the camera frames the head of "Nelim" at root size 2
    And Nelim's Pickle Tools: the genes of "Nelim" are logged
    When Nelim's Pickle Tools: "Nelim" has the gene "Eyes_BrightGreen"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyediag-genes"
    And Nelim's Pickle Tools: "Nelim" loses all genes
    And Nelim's Pickle Tools: "Nelim" has the gene "Eyes_BrightGreen"
    And Nelim's Pickle Tools: the genes of "Nelim" are logged
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "eyediag-nogene"
