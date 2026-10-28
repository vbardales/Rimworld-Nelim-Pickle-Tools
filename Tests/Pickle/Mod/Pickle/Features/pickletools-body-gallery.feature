# One photograph per body type (looks.md, Body types). With Female Body Variants (tiagocc0.FemaleBodyVariants) Fat, Hulk and Thin differ by sex:
# Nelim shoots Female, Fat, Hulk, Thin; her male alter ego Soren (a second colonist, not Nelim) shoots Male, Fat, Hulk, Thin, then Child and Baby (a boy).
# Both keep the fixture clothes as underwear. Pass: Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-gallery.map -Filter 'pickletools-body-gallery::body-gallery'
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Every body type, one photograph per value and sex (gallery of the look catalogues)

  Scenario: body-gallery-1: Nelim, the female bodies
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And Nelim's Pickle Tools: "Nelim" gender is female
    And Nelim's Pickle Tools: "Nelim" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Nelim" face kit is "neutral"
    And Nelim's Pickle Tools: "Nelim" facial expression is "normal"
    And Nelim's Pickle Tools: "Nelim" face is held neutral
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Panties"
    And Nelim's Pickle Tools: "Nelim" wears "UnderWhere_Bra"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
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

  Scenario: body-gallery-2: Soren, the male bodies
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Soren" exists
    And "Soren" is 30 years old
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" wears "UnderWhere_Boxers"
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Male"
    When Nelim's Pickle Tools: "Soren" body type is Fat
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Fat-male"
    When Nelim's Pickle Tools: "Soren" body type is Hulk
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Hulk-male"
    When Nelim's Pickle Tools: "Soren" body type is Thin
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Thin-male"

  Scenario: body-gallery-3: Soren as a child, then a baby
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Soren" exists
    And "Soren" is 8 years old
    And Nelim's Pickle Tools: "Soren" gender is male
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body type is Child
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: "Soren" wears "UnderWhere_Loincloth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Child-male"
    When Nelim's Pickle Tools: "Soren" gets back the clothes it had
    When "Soren" is 0 years old
    And Nelim's Pickle Tools: "Soren" body type is Baby
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Baby"

  Scenario: body-gallery-4: a girl child (Lyra) in a loincloth
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the item and name labels are hidden
    And Nelim's Pickle Tools: the tooltips are hidden
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Pickle Tools: the temperature of the map is 20 degrees
    And Nelim's Pickle Tools: I let 10 ticks pass
    And Nelim's Pickle Tools: I frame the area centred on (177, 121) at root size 6.5
    And a colonist "Lyra" exists
    And "Lyra" is 8 years old
    And Nelim's Pickle Tools: "Lyra" gender is female
    And Nelim's Pickle Tools: "Lyra" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Lyra" face kit is "neutral"
    And Nelim's Pickle Tools: "Lyra" facial expression is "normal"
    And Nelim's Pickle Tools: "Lyra" face is held neutral
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Lyra" body type is Child
    And Nelim's Pickle Tools: "Lyra" is undressed
    And Nelim's Pickle Tools: "Lyra" wears "UnderWhere_Loincloth"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "body-Child-female"
