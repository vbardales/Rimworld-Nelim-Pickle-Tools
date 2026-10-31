// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-face-skin-colour-test.feature: the faint face skin marks (SkinBruise, SkinCheekbones, SkinFrownLines, SkinFurrows, SkinDecrepit,
// SkinCrowsFeet) on four skin colours, to find the one where they read best (owner, 2026-10-31: sheets 0604 and 0605 are shot on a very pale skin where they are hard to see).
// Shots skintest-<colour>-<mark>. Map wsl-deps.faceparts.map. usage: node docs/Generate-FaceSkinColourTest.js
const fs = require('fs');
const P = "Nelim's Pickle Tools: ";
const colours = [['pale', '255, 244, 238'], ['tan', '222, 184, 150'], ['medium', '170, 120, 85'], ['dark', '100, 68, 50']];
const marks = ['SkinBruise', 'SkinCheekbones', 'SkinFrownLines', 'SkinFurrows', 'SkinDecrepit', 'SkinCrowsFeet'];
const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom', 'Feature: The faint face skin marks on four skin colours', ''];
colours.forEach(([name, rgb], i) => {
  out.push(`  Scenario: face-skin-colour-test-${i + 1}-${name}: ${marks.length} marks on the skin rgb (${rgb})`, '    Given the save "Nelims-tribe" is loaded', '    And game speed is paused',
    `    And ${P}the item and name labels are hidden`, `    And ${P}the tooltips are hidden`, `    And ${P}the colonist bar is hidden`, `    And ${P}the learning helper is hidden`,
    `    And ${P}the temperature of the map is 20 degrees`, `    And ${P}the other colonists are out of frame`, `    And ${P}I frame the area centred on (177, 121) at root size 6.5`,
    `    And ${P}"Nelim" stands at (176, 120) facing South`, `    And ${P}"Nelim" is undressed`, `    And ${P}"Nelim" wears "UnderWhere_Panties"`, `    And ${P}"Nelim" wears "UnderWhere_Bra"`,
    `    And ${P}"Nelim" hairstyle is "Bald"`, `    And ${P}"Nelim" face tattoo is "none"`, `    And ${P}"Nelim" mouth is "MouthNormal"`, `    And ${P}"Nelim" brows are "BrowNormal"`,
    `    And ${P}"Nelim" lids are "LidNormal"`, `    And ${P}"Nelim" eyeballs are "EyeNormal"`, `    And ${P}"Nelim" face head shape is "HeadNormal"`, `    And ${P}"Nelim" facial expression is "normal"`,
    `    And ${P}"Nelim" face is held neutral`, `    And ${P}"Nelim" skin colour is rgb (${rgb})`, `    And ${P}I frame the cell (176, 119) at zoom 2`);
  for (const m of marks) out.push(`    When ${P}"Nelim" face skin is "${m}"`, `    And ${P}I let 5 frames pass`, `    And I take a screenshot "skintest-${name}-${m}"`);
  out.push('');
});
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-face-skin-colour-test.feature', out.join('\n'));
console.log(colours.length * marks.length + ' shots');
