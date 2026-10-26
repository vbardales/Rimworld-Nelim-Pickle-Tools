// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-head-gallery.feature: the head types marked (Male) in ColonistRace/docs/CATALOGUE-LOOKS.md, which the game
// refuses on Nelim, photographed on a male pawn (owner, 2026-10-26: use a male mannequin). Shots head-<defName>, so the head sheets (Make-LookSheets, kind head) fill.
// Written 2026-10-26. usage: node docs/Generate-HeadGallery.js   (from the repository root; map wsl-deps.look-gallery.map)
const fs = require('fs');
const P = "Nelim's Pickle Tools: ";
const md = fs.readFileSync('ColonistRace/docs/CATALOGUE-LOOKS.md', 'utf8').split(/\n## Head types[^\n]*\n/)[1].split(/\n## /)[0];
const heads = [];
for (const l of md.split('\n')) {
  if (!l.startsWith('|') || /^\| (Mod|---)/.test(l)) continue;
  const cells = l.split('|').map(s => s.trim()).filter(Boolean);
  for (const raw of cells[cells.length - 1].replace(/^\(\d+\) /, '').split(', ')) if (/ \(Male\)$/.test(raw)) heads.push(raw.replace(/ \(Male\)$/, ''));
}
const nick = 'Mannequin';
const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom',
  'Feature: The male head types on a male pawn (the head catalogue)', ''];
const CHUNK = 20;
for (let i = 0; i < heads.length; i += CHUNK) {
  const part = heads.slice(i, i + CHUNK);
  out.push(`  Scenario: head-gallery-${i / CHUNK + 1}: male head types ${i + 1} to ${i + part.length} of ${heads.length}`,
    'Given the save "Nelims-tribe" is loaded', '  And game speed is paused',
    `  And ${P}the item and name labels are hidden`, `  And ${P}the tooltips are hidden`, `  And ${P}the colonist bar is hidden`, `  And ${P}the learning helper is hidden`,
    `  And ${P}the temperature of the map is 20 degrees`, `  And ${P}I let 10 ticks pass`, `  And ${P}I frame the area centred on (177, 121) at root size 6.5`,
    `  And ${P}the other colonists are out of frame`, `  And a colonist "${nick}" exists`, `  And ${P}"${nick}" gender is male`, `  And ${P}"${nick}" body type is Male`,
    `  And ${P}"${nick}" stands at (176, 120) facing South`, `  And ${P}"${nick}" hairstyle is "Bald"`, `  And ${P}"${nick}" wears "Apparel_BasicShirt"`,
    `  And ${P}"${nick}" face kit is "neutral"`, `  And ${P}"${nick}" facial expression is "normal"`, `  And ${P}"${nick}" face is held neutral`,
    `  And ${P}I frame the cell (176, 119) at zoom 3`);
  for (const h of part) out.push(`  When ${P}"${nick}" head type is "${h}"`, `  And ${P}I let 5 frames pass`, `  And I take a screenshot "head-${h}"`);
  out.push('');
}
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-head-gallery.feature', out.map(l => '    ' === l.slice(0, 4) || /^  Scenario|^Feature|^@|^$/.test(l) ? l : '    ' + l.replace(/^ +/, '')).join('\n'));
console.log(heads.length + ' male heads');

require('./Add-LookReset').apply('Tests/Pickle/Mod/Pickle/Features/pickletools-head-gallery.feature');   // the look is saved once and restored before each photograph (owner, 2026-10-26)
