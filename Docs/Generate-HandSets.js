// Hand-made one-row catalogue sets for the Cat requests of 2026-11-18 (ArS builder props, CoL farm ground, BAp hearth furniture), one row per shot
// (Rimworld-Catalog/docs/CAPTURE-RULES.md). Run from Tests/Pickle: node ../../Docs/Generate-HandSets.js. A neutral Concrete floor is laid under every frame
// (the test-colony ground is sand on the west and dark rough stone with pebbles on the east, which breaks "clean frame"), things stand 2 to 4 cells apart on one row
// centred on (150, 150), the root size follows the row width. Screenshot name things-<set>-<shot>, scenario <set>-<shot>. Roots are guesses to check on an image.
const fs = require('fs');
const FEAT = 'Mod/Pickle/Features/';
const C = 'dlc:Core';
const pre = `    Given the save "test-colony" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the eclipse of the map is ended
    And Nelim's Pickle Tools: the area from (136, 144) to (164, 156) is cleared
    And Nelim's Pickle Tools: I lay the floor "Concrete" from (138, 145) to (162, 155)
`;
const post = (size, shot) => `    And I set the hour to 12
    And I set the weather to "Clear"
    And I wait 60 ticks
    And Nelim's Pickle Tools: studio presentation mode is enabled
    And Nelim's Pickle Tools: I frame the area centred on (150, 150) at root size ${size}
    And I take a screenshot "things-${shot}"
    Then no errors were logged
`;
function build(set, desc, shots) {
  let s = `# ${desc}, one row per shot, on a Concrete floor (owner rules 2026-11-18, Rimworld-Catalog/docs/CAPTURE-RULES.md). Written by Docs/Generate-HandSets.js: edit there.\n@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.stagedecor\nFeature: things ${set}\n\n`;
  let key = `# ${set} key\n\nOne row per shot: row = 1, col = left to right. Image: things-${set}-<shot>.webp. Roots are guesses, checked on the first image.\n`;
  for (const sh of shots) {
    s += `  Scenario: ${set}-${sh.id}\n` + pre;
    key += `\n## Shot ${sh.id}\n\n| row | col | mod | def |\n|---|---|---|---|\n`;
    if (sh.lay) {
      sh.lay.forEach(([d, x1, z1, x2, z2, m]) => {
        s += `    And Nelim's Pickle Tools: I lay the floor "${d}" from (${x1}, ${z1}) to (${x2}, ${z2})
`;
        key += `| 1 | ${sh.lay.indexOf(sh.lay.find(l => l[0] === d)) + 1} | ${m} | ${d} (floor, ${x2 - x1 + 1} x ${z2 - z1 + 1} cells) |
`;
      });
    } else if (sh.patches) {
      sh.items.forEach(([d, m], i) => {
        const x0 = sh.items.length === 1 ? 147 : 144 + 7 * i;
        s += `    And Nelim's Pickle Tools: I lay the floor "${d}" from (${x0}, 147) to (${x0 + 5}, 152)\n`;
        key += `| 1 | ${i + 1} | ${m} | ${d} (floor patch 6 x 6) |\n`;
      });
    } else {
      const n = sh.items.length, x0 = 150 - ((n - 1) * sh.step) / 2;
      sh.items.forEach(([d, m, k2], i) => {
        const x = Math.round(x0 + i * sh.step);
        const k = k2 || sh.kind;
        s += k === 'b' ? `    And Nelim's Pickle Tools: the building "${d}" is spawned on the nearest free cell around (${x}, 150) facing south\n`
          : k === 'p' ? `    And Nelim's Pickle Tools: I place the decor "${d}" at (${x}, 150) fully grown\n`
          : k === 's' ? `    And Nelim's Pickle Tools: 50 of the item "${d}" are spawned at (${x}, 150)\n`
          : k === 'h' ? `    And Nelim's Pickle Tools: 30 of the item "${d}" are spawned at (${x}, 150)\n`
          : `    And Nelim's Pickle Tools: 1 of the item "${d}" are spawned at (${x}, 150)\n`;
        key += `| 1 | ${i + 1} | ${m} | ${d}${k === 'h' ? ' (30, item stack)' : ''} |\n`;
      });
    }
    s += post(sh.size, `${set}-${sh.id}`) + '\n';
  }
  fs.writeFileSync(FEAT + `pickletools-things-${set}.feature`, s.replace(/\n+$/, '\n'));
  fs.writeFileSync(`things-${set}.key.md`, key);
}
build('ars-builder-props', 'Props catalogue for ArS: buildings, stacks, garments', [
  { id: 'building-a', kind: 'b', step: 2, size: 3, items: [['Stool', C], ['PlantPot', C], ['PlantPot_Bonsai', 'dlc:Ideology'], ['TorchLamp', C]] },
  { id: 'building-b', kind: 'b', step: 2, size: 3, items: [['StandingLamp', C], ['FermentingBarrel', C], ['ShelfSmall', C], ['CraftingSpot', C]] },
  { id: 'stacks', kind: 's', step: 2, size: 2.6, items: [['Steel', C], ['WoodLog', C], ['BlocksGranite', C]] },
  { id: 'apparel-a', kind: 'a', step: 2, size: 3, items: [['Apparel_Jacket', C], ['Apparel_Duster', C], ['Apparel_Cape', C], ['Apparel_Pants', C]] },
  { id: 'apparel-b', kind: 'a', step: 2, size: 2.6, items: [['Apparel_Beret', 'dlc:Royalty'], ['Apparel_VestRoyal', 'dlc:Royalty'], ['Apparel_Broadwrap', 'dlc:Ideology']] },
  { id: 'apparel-c', kind: 'a', step: 2, size: 3, items: [['VAE_Apparel_BuildersJacket', '1814987817'], ['VAE_Apparel_Apron', '1814987817'], ['VAE_Apparel_Overalls', '1814987817'], ['VAE_Handwear_Gloves', '1814987817']] },
  { id: 'apparel-d', kind: 'a', step: 2, size: 2.6, items: [['VAE_Headgear_Scarf', '1814987817'], ['Apparel_FSConstructionJacket', '3592569869'], ['Apparel_FSOveralls', '3592569869']] },
]);
build('col-farm-ground', 'Farm ground catalogue for CoL: floors, plants, fences, hay', [
  { id: 'floor-a', patches: true, size: 4, items: [['StrawMatting', C], ['PackedDirt', C]] },
  { id: 'floor-b', patches: true, size: 4, items: [['SoilRich', C], ['MossyTerrain', C]] },
  { id: 'floor-c', patches: true, size: 4, items: [['Soil', C], ['GrasslandSoil', 'dlc:Odyssey']] },
  { id: 'plant', kind: 'p', step: 2, size: 3.4, items: [['Plant_Grass', C], ['Plant_TallGrass', C], ['Plant_Haygrass', C], ['Plant_YellowGrass', 'dlc:Odyssey'], ['Plant_YellowTallGrass', 'dlc:Odyssey']] },
  { id: 'fence', kind: 'b', step: 3, size: 3, items: [['Fence', C], ['FenceGate', C]] },
  { id: 'hay', kind: 'h', step: 3, size: 2.6, items: [['Hay', C]] },
]);
build('bap-hearth-furniture', 'Hearth furniture catalogue for BAp: Core furniture and an Ideology carpet', [
  { id: 'a', kind: 'b', step: 4, size: 4.5, items: [['HandTailoringBench', C], ['FueledStove', C], ['Table2x2c', C], ['Table1x2c', C]] },
  { id: 'b', kind: 'b', step: 3, size: 3.5, items: [['Stool', C], ['DiningChair', C], ['Armchair', C], ['Shelf', C]] },
  { id: 'c', kind: 'b', step: 3, size: 3.5, items: [['ShelfSmall', C], ['Bookcase', C], ['Dresser', C], ['EndTable', C]] },
  { id: 'carpet', patches: true, size: 4, items: [['Carpet_MindbendA', 'dlc:Ideology']] },
]);
build('bib-water-garden', 'Water garden catalogue for BiB: fires, shrine, bonsai, floors, water', [
  { id: 'fire-a', kind: 'b', step: 2, size: 3, items: [['Brazier', 'dlc:Royalty'], ['Campfire', C]] },
  { id: 'bonsai', kind: 'p', step: 2, size: 3, items: [['Plant_TreeBonsai', 'dlc:Ideology'], ['PlantPot_Bonsai', 'dlc:Ideology', 'b']] },
  { id: 'shrine', kind: 'b', step: 4, size: 3.5, items: [['NatureShrine_Small', 'dlc:Royalty'], ['StylingStation', 'dlc:Ideology']] },
  { id: 'floor-a', patches: true, size: 4, items: [['FlagstoneGranite', C], ['FlagstoneSlate', C]] },
  { id: 'floor-b', patches: true, size: 4, items: [['FlagstoneSandstone', C], ['FlagstoneMarble', C]] },
  { id: 'floor-c', patches: true, size: 4, items: [['TileSandstone', C], ['FineTileSandstone', 'dlc:Royalty']] },
  { id: 'water', size: 5.5, lay: [['WaterShallow', 145, 145, 154, 154, C], ['WaterDeep', 148, 148, 151, 151, C]] },
]);
build('kija-village-clothes', 'Village clothes catalogue for CoKK: garments as ground items', [
  { id: 'a', kind: 'a', step: 2, size: 3, items: [['VAE_Apparel_Tunic', '1814987817'], ['VAE_Apparel_TribalKilt', '1814987817'], ['VAE_Apparel_Skirt', '1814987817'], ['VAE_Apparel_Shorts', '1814987817']] },
  { id: 'b', kind: 'a', step: 2, size: 3, items: [['VAE_Apparel_TribalPoncho', '1814987817'], ['VAE_Apparel_Trousers', '1814987817'], ['Apparel_TribalA', C], ['Apparel_BasicShirt', C]] },
  { id: 'c', kind: 'a', step: 2, size: 3, items: [['Apparel_Robe', C], ['Apparel_CollarShirt', C], ['Apparel_FSGardeningVest', '3592569869']] },
  { id: 'd', kind: 'a', step: 2, size: 3, items: [['VAE_Apparel_Apron', '1814987817']] },
]);
