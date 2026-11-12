// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-beard-colour-gallery.feature: one photograph per hair colour of the look catalogue (colours.md, group Hair), on a man
// (Soren, human, bald) with a Norse beard, so that the sheet shows what a beard looks like in each colour (a beard is drawn in the pawn's hair colour). Shots beardcolour-<name>,
// framed on the face like the hair colour shots. Written 2026-10-28 at the owner's request ("or like the hair?").
//   node docs/Generate-BeardColourGallery.js look-lines.txt   (the [look-colour] lines of a pickletools-look-catalogue run, one per line)
// Pass: Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-gallery.map -Filter 'pickletools-beard-colour-gallery::beard-colour-gallery'
const fs = require('fs'), path = require('path');
const lines = fs.readFileSync(process.argv[2], 'utf8').split(/\r?\n/);
const P = "Nelim's Pickle Tools: ";
const colours = [];
for (const l of lines) {
  const m = l.match(/^\[look-colour\] (.*?) \| (.*?) \((\d+)\): (.*)$/);
  if (!m || m[2] !== 'Hair') continue;
  for (const raw of m[4].split(', ')) {
    const c = raw.trim().match(/^(.*)#([0-9A-Fa-f]{6})$/);
    if (c) colours.push({ name: c[1], rgb: [0, 2, 4].map(i => parseInt(c[2].substr(i, 2), 16)) });
  }
}
if (!colours.length) throw new Error('no [look-colour] Hair line in ' + process.argv[2]);
let out = '@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\n@requires:nelim.pickletools.camerazoom\n'
  + 'Feature: A beard in every hair colour (gallery of the look catalogues)\n\n'
  + `  Scenario: beard-colour-gallery-1: beard colours 1 to ${colours.length} of ${colours.length}\n`;
const pre = [
  'Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I let 10 ticks pass`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
  'And a colonist "Soren" exists', `And ${P}"Soren" gender is male`, `And ${P}"Soren" stands at (176, 120) facing South`, `And ${P}the other colonists are out of frame`,
  `And ${P}"Soren" face kit is "neutral"`, `And ${P}"Soren" facial expression is "normal"`, `And ${P}"Soren" face is held neutral`,
  `And ${P}"Soren" hairstyle is "Bald"`, `And ${P}"Soren" beard is "Norse"`, `And ${P}I frame the cell (176, 119) at zoom 3`,
];
for (const l of pre) out += `    ${l}\n`;
for (const c of colours) out += `    When ${P}"Soren" hair colour is rgb (${c.rgb.join(', ')})\n    And ${P}I let 5 frames pass\n    And I take a screenshot "beardcolour-${c.name}"\n`;
fs.writeFileSync(path.join(__dirname, '..', 'Tests/Pickle/Mod/Pickle/Features/pickletools-beard-colour-gallery.feature'), out);
console.log(`${colours.length} colours`);
