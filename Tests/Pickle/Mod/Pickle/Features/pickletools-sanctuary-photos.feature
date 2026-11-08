# Sanctuary photos: read-only. One scenario per place of SanctuaryBacklot/docs/SANCTUAIRE-LIEUX.md (title photos-<place>:). Loads the LATEST DecorBase fixture (now Nelims-tribe-decor-mods-w), noon, clear sky, no despawn, no edit, no save. Frame = the place and zoom registered by `I am at the sanctuary`. NPT bumps the fixture letter on every edit batch and tells NSB. Filed by NSB: Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.sanctuary-decor-mods.map -Filter 'pickletools-sanctuary-photos::photos-<place>:'.
@requires:nelim.pickletools.screenshotstudio
@requires:nelim.pickletools.stagedecor
@requires:nelim.pickletools.camerazoom
Feature: Sanctuary photos

  Scenario: photos-overview-north: the place overview-north photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "overview-north"
    And I take a screenshot "photo-overview-north"

  Scenario: photos-overview-south: the place overview-south photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "overview-south"
    And I take a screenshot "photo-overview-south"

  Scenario: photos-house: the place house photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "house"
    And I take a screenshot "photo-house"

  Scenario: photos-hearth-hall: the place hearth-hall photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "hearth-hall"
    And I take a screenshot "photo-hearth-hall"

  Scenario: photos-sleeping-nook: the place sleeping-nook photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And I take a screenshot "photo-sleeping-nook"

  Scenario: photos-sofa-corner: the place sofa-corner photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "sofa-corner"
    And I take a screenshot "photo-sofa-corner"

  Scenario: photos-dining-nook: the place dining-nook photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "dining-nook"
    And I take a screenshot "photo-dining-nook"

  Scenario: photos-fire-pit: the place fire-pit photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "fire-pit"
    And I take a screenshot "photo-fire-pit"

  Scenario: photos-cloister: the place cloister photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "cloister"
    And I take a screenshot "photo-cloister"

  Scenario: photos-statue-garden: the place statue-garden photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "statue-garden"
    And I take a screenshot "photo-statue-garden"

  Scenario: photos-prestige-hall: the place prestige-hall photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "prestige-hall"
    And I take a screenshot "photo-prestige-hall"

  Scenario: photos-ritual-hall: the place ritual-hall photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "ritual-hall"
    And I take a screenshot "photo-ritual-hall"

  Scenario: photos-terrace: the place terrace photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "terrace"
    And I take a screenshot "photo-terrace"

  Scenario: photos-plant-garden: the place plant-garden photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "plant-garden"
    And I take a screenshot "photo-plant-garden"

  Scenario: photos-hut: the place hut photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "hut"
    And I take a screenshot "photo-hut"

  Scenario: photos-river-bridge: the place river-bridge photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "river-bridge"
    And I take a screenshot "photo-river-bridge"

  Scenario: photos-left-bank: the place left-bank photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "left-bank"
    And I take a screenshot "photo-left-bank"

  Scenario: photos-right-bank: the place right-bank photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "right-bank"
    And I take a screenshot "photo-right-bank"

  Scenario: photos-fishing-zone: the place fishing-zone photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "fishing-zone"
    And I take a screenshot "photo-fishing-zone"

  Scenario: photos-water-garden: the place water-garden photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "water-garden"
    And I take a screenshot "photo-water-garden"

  Scenario: photos-gravel-yard: the place gravel-yard photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "gravel-yard"
    And I take a screenshot "photo-gravel-yard"

  Scenario: photos-emerald-clearing: the place emerald-clearing photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "emerald-clearing"
    And I take a screenshot "photo-emerald-clearing"

  Scenario: photos-enclosure: the place enclosure photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure"
    And I take a screenshot "photo-enclosure"

  Scenario: photos-workshops: the place workshops photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "workshops"
    And I take a screenshot "photo-workshops"

  Scenario: photos-barn: the place barn photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "barn"
    And I take a screenshot "photo-barn"

  Scenario: photos-preindustrial-workshop: the place preindustrial-workshop photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "preindustrial-workshop"
    And I take a screenshot "photo-preindustrial-workshop"

  Scenario: photos-postindustrial-workshop: the place postindustrial-workshop photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "postindustrial-workshop"
    And I take a screenshot "photo-postindustrial-workshop"

  Scenario: photos-enclosure-south: the place enclosure-south photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-south"
    And I take a screenshot "photo-enclosure-south"

  Scenario: photos-enclosure-north: the place enclosure-north photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "enclosure-north"
    And I take a screenshot "photo-enclosure-north"

  Scenario: photos-rice-paddies: the place rice-paddies photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "rice-paddies"
    And I take a screenshot "photo-rice-paddies"

  Scenario: photos-cotton-field: the place cotton-field photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "cotton-field"
    And I take a screenshot "photo-cotton-field"

  Scenario: photos-rice-paddy: the place rice-paddy photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "rice-paddy"
    And I take a screenshot "photo-rice-paddy"

  Scenario: photos-flower-garden: the place flower-garden photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "flower-garden"
    And I take a screenshot "photo-flower-garden"

  Scenario: photos-exhibition-zone: the place exhibition-zone photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "exhibition-zone"
    And I take a screenshot "photo-exhibition-zone"

  Scenario: photos-calm-zone: the place calm-zone photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone"
    And I take a screenshot "photo-calm-zone"

  Scenario: photos-calm-zone-close: the place calm-zone-close photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "calm-zone-close"
    And I take a screenshot "photo-calm-zone-close"

  Scenario: photos-bare-clearing: the place bare-clearing photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "bare-clearing"
    And I take a screenshot "photo-bare-clearing"

  Scenario: photos-dump: the place dump photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "dump"
    And I take a screenshot "photo-dump"

  Scenario: photos-play-area: the place play-area photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "play-area"
    And I take a screenshot "photo-play-area"

  Scenario: photos-smiley-southwest: the place smiley-southwest photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "smiley-southwest"
    And I take a screenshot "photo-smiley-southwest"

  Scenario: photos-smiley-bottom-west: the place smiley-bottom-west photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "smiley-bottom-west"
    And I take a screenshot "photo-smiley-bottom-west"

  Scenario: photos-smiley-bottom-centre: the place smiley-bottom-centre photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "smiley-bottom-centre"
    And I take a screenshot "photo-smiley-bottom-centre"

  Scenario: photos-smiley-bottom-east: the place smiley-bottom-east photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "smiley-bottom-east"
    And I take a screenshot "photo-smiley-bottom-east"

  Scenario: photos-smiley-west: the place smiley-west photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "smiley-west"
    And I take a screenshot "photo-smiley-west"

  Scenario: photos-smiley-river: the place smiley-river photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "smiley-river"
    And I take a screenshot "photo-smiley-river"

  Scenario: photos-smiley-north: the place smiley-north photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "smiley-north"
    And I take a screenshot "photo-smiley-north"

  Scenario: photos-infirmary: the place infirmary photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "infirmary"
    And I take a screenshot "photo-infirmary"

  Scenario: photos-infirmary-pawns: the place infirmary-pawns photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "infirmary-pawns"
    And I take a screenshot "photo-infirmary-pawns"

  Scenario: photos-infirmary-animals: the place infirmary-animals photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "infirmary-animals"
    And I take a screenshot "photo-infirmary-animals"

  Scenario: photos-pediatrics: the place pediatrics photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "pediatrics"
    And I take a screenshot "photo-pediatrics"

  Scenario: photos-window-backdrop-for-width: the place window-backdrop-for-width photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "window-backdrop-for-width"
    And I take a screenshot "photo-window-backdrop-for-width"

  Scenario: photos-window-backdrop-for-height: the place window-backdrop-for-height photographed as it stands
    Given the save "Nelims-tribe-decor-mods-w" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: the area and zone overlays are hidden
    And I wait 60 ticks
    And Nelim's Sanctuary: I am at the sanctuary "window-backdrop-for-height"
    And I take a screenshot "photo-window-backdrop-for-height"
