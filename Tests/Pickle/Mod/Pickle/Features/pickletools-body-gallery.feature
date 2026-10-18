# One photograph per body type on Nelim (CATALOGUE-LOOKS.md, Body types). With Female Body Variants (tiagocc0.FemaleBodyVariants) Fat, Hulk and Thin differ by sex,
# so each is shot as female then as male; Male and Female once each; Baby and Child in their own scenario (the age is set first).
# Nelim keeps the fixture clothes as underwear. Pass: Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-catalogue.map -Filter 'body-gallery'
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Every body type on Nelim, one photograph per value and sex (gallery of the look catalogues)

  Scenario: body-gallery-1: adult bodies, female then male
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And Nelim's Pickle Tools: "Nelim" gender is female
    When Nelim's Pickle Tools: "Nelim" body type is Female
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Female"
    When Nelim's Pickle Tools: "Nelim" body type is Fat
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Fat-female"
    When Nelim's Pickle Tools: "Nelim" body type is Hulk
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Hulk-female"
    When Nelim's Pickle Tools: "Nelim" body type is Thin
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Thin-female"
    When Nelim's Pickle Tools: "Nelim" gender is male
    When Nelim's Pickle Tools: "Nelim" body type is Male
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Male"
    When Nelim's Pickle Tools: "Nelim" body type is Fat
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Fat-male"
    When Nelim's Pickle Tools: "Nelim" body type is Hulk
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Hulk-male"
    When Nelim's Pickle Tools: "Nelim" body type is Thin
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Thin-male"

  Scenario: body-gallery-2: child and baby
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    And "Nelim" is 8 years old
    When Nelim's Pickle Tools: "Nelim" body type is Child
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Child"
    When "Nelim" is 0 years old
    And Nelim's Pickle Tools: "Nelim" body type is Baby
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Baby"
