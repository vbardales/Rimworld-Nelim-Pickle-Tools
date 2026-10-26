@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.colonistrace
@requires:nelim.pickletools.camerazoom
Feature: Body tattoos and beards on Soren, one photograph per value (the male half of the look catalogues)

  Scenario: beard-tattoo-gallery-1: bodytattoo 1 to 12 of 104
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body tattoo is "NoTattoo_Body"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-NoTattoo_Body-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-NoTattoo_Body-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Buttons"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Buttons-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Buttons-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Cross"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cross-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cross-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Heart"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Heart-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Heart-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Insect"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Insect-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Insect-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Jester"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Jester-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Jester-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Moon"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Moon-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Moon-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Power"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Power-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Power-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Rings"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Rings-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Rings-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Royal"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Royal-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Royal-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Scar"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Scar-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Scar-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Skeleton"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skeleton-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skeleton-back"

  Scenario: beard-tattoo-gallery-2: bodytattoo 13 to 24 of 104
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Skull"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skull-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skull-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Spike"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Spike-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Spike-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Sun"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Sun-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Sun-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Tiger"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tiger-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tiger-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Wings"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Wings-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Wings-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Bear"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Bear-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Bear-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Birds"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Birds-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Birds-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Bull"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Bull-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Bull-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Butterfly"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Butterfly-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Butterfly-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Cat"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cat-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cat-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_circles"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_circles-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_circles-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Claws"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Claws-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Claws-back"

  Scenario: beard-tattoo-gallery-3: bodytattoo 25 to 36 of 104
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Deer"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Deer-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Deer-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Dragon"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Dragon-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Dragon-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Dragon_2c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Dragon_2c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Dragon_2c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Illuminati"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Illuminati-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Illuminati-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_invertedcross"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_invertedcross-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_invertedcross-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Japan"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Japan-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Japan-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_kanji_1c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_1c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_1c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_kanji_2c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_2c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_2c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_kanji_3c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_3c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_3c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_kanji_4c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_4c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_4c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_kanji_5c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_5c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_kanji_5c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Koi"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Koi-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Koi-back"

  Scenario: beard-tattoo-gallery-4: bodytattoo 37 to 48 of 104
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Labyrinth"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Labyrinth-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Labyrinth-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_leviathan"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_leviathan-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_leviathan-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Lion"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Lion-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Lion-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Lizard"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Lizard-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Lizard-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_lucifer"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_lucifer-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_lucifer-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_pentagram"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_pentagram-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_pentagram-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_rose"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_rose-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_rose-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_samurai"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_samurai-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_samurai-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_satanic_1c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_satanic_1c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_satanic_1c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_satanic_2c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_satanic_2c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_satanic_2c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_scythe"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_scythe-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_scythe-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Shark"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Shark-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Shark-back"

  Scenario: beard-tattoo-gallery-5: bodytattoo 49 to 60 of 104
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Skull_2c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skull_2c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Skull_2c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Tiger_2c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tiger_2c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tiger_2c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Triangle"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Triangle-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Triangle-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Tribal_back"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Tribal_back_2c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_2c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_2c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Tribal_back_3c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_3c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_3c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Tribal_back_4c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_4c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_4c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Tribal_back_5c"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_5c-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Tribal_back_5c-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_wings"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_wings-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_wings-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Wolf"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Wolf-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Wolf-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_yinyang"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_yinyang-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_yinyang-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_Anima"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Anima-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Anima-back"

  Scenario: beard-tattoo-gallery-6: bodytattoo 61 to 72 of 104
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_BlackClaw"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_BlackClaw-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_BlackClaw-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_BlueClaw"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_BlueClaw-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_BlueClaw-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_RedClaw"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_RedClaw-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_RedClaw-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_SacredAir"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredAir-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredAir-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_SacredFire"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredFire-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredFire-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_SacredGrass"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredGrass-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredGrass-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_SacredWater"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredWater-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SacredWater-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_Smoke"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Smoke-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Smoke-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_Spiral"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Spiral-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Spiral-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_Stripes"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Stripes-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Stripes-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_SunsBlessing"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SunsBlessing-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_SunsBlessing-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_Vines"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Vines-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_Vines-back"

  Scenario: beard-tattoo-gallery-7: bodytattoo 73 to 84 of 104
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body tattoo is "STribalTat_Body_WhiteClaw"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_WhiteClaw-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-STribalTat_Body_WhiteClaw-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBBirthmarkBodyA"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBBirthmarkBodyA-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBBirthmarkBodyA-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBBirthmarkBodyB"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBBirthmarkBodyB-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBBirthmarkBodyB-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBBirthmarkBodyC"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBBirthmarkBodyC-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBBirthmarkBodyC-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBLightningScars"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBLightningScars-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBLightningScars-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBMolesBodyA"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyA-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyA-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBMolesBodyB"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyB-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyB-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBMolesBodyC"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyC-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyC-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBMolesBodyD"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyD-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyD-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBMolesBodyE"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyE-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBMolesBodyE-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBPsoriasisBody"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBPsoriasisBody-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBPsoriasisBody-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBStitchesBodyA"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBStitchesBodyA-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBStitchesBodyA-back"

  Scenario: beard-tattoo-gallery-8: bodytattoo 85 to 96 of 104
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBStitchesBodyB"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBStitchesBodyB-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBStitchesBodyB-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBStretchMarksBody"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBStretchMarksBody-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBStretchMarksBody-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "RBVitiligoBody"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBVitiligoBody-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-RBVitiligoBody-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Barcode"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Barcode-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Barcode-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Cassandra"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cassandra-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Cassandra-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Chesttext"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Chesttext-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Chesttext-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_DarkPsycaster"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_DarkPsycaster-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_DarkPsycaster-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Fullbody"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Fullbody-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Fullbody-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Kitsune"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Kitsune-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Kitsune-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Lancaster"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Lancaster-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Lancaster-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Nonipples"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Nonipples-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Nonipples-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Oni"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Oni-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Oni-back"

  Scenario: beard-tattoo-gallery-9: bodytattoo 97 to 104 of 104
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: "Soren" is undressed
    And Nelim's Pickle Tools: I frame the cell (176, 120) at zoom 2
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Phoebe"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Phoebe-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Phoebe-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Randy"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Randy-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Randy-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Rave"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Rave-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Rave-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Ribcage"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Ribcage-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Ribcage-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Soulmateleft"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Soulmateleft-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Soulmateleft-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Soulmateright"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Soulmateright-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Soulmateright-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Yakuza"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Yakuza-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Yakuza-back"
    When Nelim's Pickle Tools: "Soren" body tattoo is "Body_Yorkshire"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Yorkshire-front"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing North
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "bodytattoo-Body_Yorkshire-back"

  Scenario: beard-tattoo-gallery-10: beard 1 to 20 of 41
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Soren" beard is "BeardFurskinKnots"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinKnots"
    When Nelim's Pickle Tools: "Soren" beard is "BeardFurskinMegabraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinMegabraid"
    When Nelim's Pickle Tools: "Soren" beard is "BeardFurskinMonkey"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinMonkey"
    When Nelim's Pickle Tools: "Soren" beard is "BeardFurskinMoustache"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinMoustache"
    When Nelim's Pickle Tools: "Soren" beard is "BeardFurskinScruffy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinScruffy"
    When Nelim's Pickle Tools: "Soren" beard is "BeardFurskinSenile"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinSenile"
    When Nelim's Pickle Tools: "Soren" beard is "BeardFurskinSideChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinSideChops"
    When Nelim's Pickle Tools: "Soren" beard is "BeardFurskinSideTufts"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinSideTufts"
    When Nelim's Pickle Tools: "Soren" beard is "BeardFurskinStrongChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardFurskinStrongChops"
    When Nelim's Pickle Tools: "Soren" beard is "FurskinCurlyMoustache"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-FurskinCurlyMoustache"
    When Nelim's Pickle Tools: "Soren" beard is "Anchor"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Anchor"
    When Nelim's Pickle Tools: "Soren" beard is "BeardCurly"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BeardCurly"
    When Nelim's Pickle Tools: "Soren" beard is "Boxed"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Boxed"
    When Nelim's Pickle Tools: "Soren" beard is "Braided"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Braided"
    When Nelim's Pickle Tools: "Soren" beard is "Bushy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Bushy"
    When Nelim's Pickle Tools: "Soren" beard is "BushyStyled"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-BushyStyled"
    When Nelim's Pickle Tools: "Soren" beard is "Circle"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Circle"
    When Nelim's Pickle Tools: "Soren" beard is "Classy"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Classy"
    When Nelim's Pickle Tools: "Soren" beard is "Curtain"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Curtain"
    When Nelim's Pickle Tools: "Soren" beard is "Ducktail"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Ducktail"

  Scenario: beard-tattoo-gallery-11: beard 21 to 40 of 41
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Soren" beard is "Fork"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Fork"
    When Nelim's Pickle Tools: "Soren" beard is "French"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-French"
    When Nelim's Pickle Tools: "Soren" beard is "Full"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Full"
    When Nelim's Pickle Tools: "Soren" beard is "Goatee"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Goatee"
    When Nelim's Pickle Tools: "Soren" beard is "Lincoln"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Lincoln"
    When Nelim's Pickle Tools: "Soren" beard is "LongDutch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-LongDutch"
    When Nelim's Pickle Tools: "Soren" beard is "Machete"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Machete"
    When Nelim's Pickle Tools: "Soren" beard is "Moustache"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Moustache"
    When Nelim's Pickle Tools: "Soren" beard is "MuttonChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-MuttonChops"
    When Nelim's Pickle Tools: "Soren" beard is "NoBeard"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-NoBeard"
    When Nelim's Pickle Tools: "Soren" beard is "Norse"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Norse"
    When Nelim's Pickle Tools: "Soren" beard is "OldDutch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-OldDutch"
    When Nelim's Pickle Tools: "Soren" beard is "Seer"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Seer"
    When Nelim's Pickle Tools: "Soren" beard is "SideWhiskers"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-SideWhiskers"
    When Nelim's Pickle Tools: "Soren" beard is "SoulPatch"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-SoulPatch"
    When Nelim's Pickle Tools: "Soren" beard is "StacheAndChops"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-StacheAndChops"
    When Nelim's Pickle Tools: "Soren" beard is "Stubble"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Stubble"
    When Nelim's Pickle Tools: "Soren" beard is "TriBraid"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-TriBraid"
    When Nelim's Pickle Tools: "Soren" beard is "Urist"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Urist"
    When Nelim's Pickle Tools: "Soren" beard is "VanDyke"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-VanDyke"

  Scenario: beard-tattoo-gallery-12: beard 41 to 41 of 41
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
    And Nelim's Pickle Tools: "Soren" hairstyle is "Bald"
    And Nelim's Pickle Tools: "Soren" stands at (176, 120) facing South
    And Nelim's Pickle Tools: the other colonists are out of frame
    And Nelim's Pickle Tools: "Soren" face kit is "neutral"
    And Nelim's Pickle Tools: "Soren" facial expression is "normal"
    And Nelim's Pickle Tools: "Soren" face is held neutral
    And Nelim's Pickle Tools: "Soren" body type is Male
    And Nelim's Pickle Tools: I frame the cell (176, 119) at zoom 3
    When Nelim's Pickle Tools: "Soren" beard is "Wizard"
    And Nelim's Pickle Tools: I let 5 frames pass
    And I take a screenshot "beard-Wizard"

