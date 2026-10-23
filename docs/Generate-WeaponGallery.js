// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-weapon-gallery.feature: one photograph per weapon of ColonistRace/docs/CATALOGUE-WEAPONS-CRAFTS.md
// (section "Weapons"), Nelim wielding it on the save Nelims-tribe, the way pickletools-look-gallery does it for the other looks.
//   node Docs/Generate-WeaponGallery.js
// Hand-held weapons go in lots of 20; turret guns, artillery and mech guns go in a last lot of their own, so that a refusal of the equip step there
// does not lose the others. The photographs are named weapon-<defName> (Docs/Make-LookSheets.ps1 reads them from look-gallery* run folders).
const fs = require('fs'), path = require('path');
const md = fs.readFileSync(path.join(__dirname, '..', 'ColonistRace/docs/CATALOGUE-WEAPONS-CRAFTS.md'), 'utf8').split('\n');
const names = []; let on = false;
for (const l of md) {
  if (/^## /.test(l)) { on = /^## Weapons/.test(l); continue; }
  if (!on || !l.startsWith('|') || /^\| (Mod|---)/.test(l)) continue;
  const cells = l.trim().replace(/^\||\|$/g, '').split('|').map(c => c.trim());
  if (cells.length >= 3) names.push(...cells[2].split(', ').map(s => s.trim()).filter(Boolean));
}
const P = "Nelim's Pickle Tools: ";
const fixed = n => /Turret|Artillery|Mech$|MiniTurret/.test(n);
const hand = names.filter(n => !fixed(n)), fixedOnes = names.filter(fixed);
const PRE = [
  'Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I let 10 ticks pass`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
  `And ${P}"Nelim" stands at (176, 120) facing South`, `And ${P}"Nelim" face kit is "neutral"`, `And ${P}"Nelim" facial expression is "normal"`, `And ${P}"Nelim" face is held neutral`,
  `And ${P}I frame the cell (176, 120) at zoom 2`,
];
let out = '@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\n@requires:nelim.pickletools.camerazoom\n'
  + 'Feature: Every weapon on Nelim, one photograph per value (gallery of the weapon catalogue)\n\n';
let n = 0;
function lots(label, list) {
  for (let i = 0; i < list.length; i += 20) {
    const part = list.slice(i, i + 20); n++;
    out += `  Scenario: weapon-gallery-${n}: ${label} ${i + 1} to ${i + part.length} of ${list.length}\n`;
    for (const l of PRE) out += `    ${l}\n`;
    for (const w of part) out += `    When ${P}"Nelim" wields "${w}"\n    And ${P}I let 5 frames pass\n    And I take a screenshot "weapon-${w}"\n    And ${P}"Nelim" puts its weapon away\n`;
    out += '\n';
  }
}
lots('hand weapons', hand); lots('turret, artillery and mech guns', fixedOnes);
fs.writeFileSync(path.join(__dirname, '..', 'Tests/Pickle/Mod/Pickle/Features/pickletools-weapon-gallery.feature'), out);
console.log(`${n} scenarios: ${hand.length} hand weapons, ${fixedOnes.length} turret/artillery/mech (${names.length} in the catalogue)`);
