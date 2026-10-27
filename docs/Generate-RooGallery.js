// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-roo-gallery.feature: one photograph per tattoo def of Roo's Tattoos - Starter Pack and
// Roo's Birthmarks and Blemishes (both are tattoo defs, RB* for the birthmarks), on a bald Nelim for the face (the base of
// pickletools-face-skin-gallery) and on Nelim undressed for the body (owner, 2026-10-25: a body tattoo is on the skin, the underwear hid it) (the base of pickletools-look-gallery). Shots are named
// facetattoo-<def> and bodytattoo-<def>, so that docs/Make-LookSheets.ps1 (jobs facetattoo and bodytattoo, rows of ColonistRace/docs/catalogues/looks.md)
// fills their tiles from the folder Tests/Pickle/Inbox/look-gallery-roo*. Written 2026-10-25 from run d15c. Body_Royal is left out: it is also an
// Ideology def and the game keeps one of the two, so a photograph of it does not say which (see the catalogue).
// usage: node docs/Generate-RooGallery.js   (from the repository root; map wsl-deps.look-gallery.map holds both Roo mods)
const fs = require('fs');
const md = fs.readFileSync('ColonistRace/docs/catalogues/looks.md', 'utf8').split(/\r?\n/);
const rows = md.filter(l => /^\| Roo's (Birthmarks|Tattoos)/.test(l));
if (rows.length !== 2) throw new Error('expected the two Roo rows in looks.md, found ' + rows.length);
const face = [], body = [];
for (const r of rows) {
  for (const raw of r.split('|')[2].replace(/^\s*\(\d+\)\s*/, '').split(', ')) {
    const m = raw.trim().match(/^(\S+) \((Face|Body)\)$/);
    if (!m || m[1] === 'Body_Royal') continue;
    (m[2] === 'Face' ? face : body).push(m[1]);
  }
}
const P = "Nelim's Pickle Tools: ";
const common = [
  'Given the save "Nelims-tribe" is loaded',
  'And game speed is paused',
  `And ${P}the item and name labels are hidden`,
  `And ${P}the tooltips are hidden`,
  `And ${P}the colonist bar is hidden`,
  `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`,
  `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
  `And ${P}"Nelim" stands at (176, 120) facing South`,
];
const faceBase = [...common,
  `And ${P}"Nelim" hairstyle is "Bald"`,
  `And ${P}"Nelim" face tattoo is "none"`,
  `And ${P}"Nelim" mouth is "MouthNormal"`,
  `And ${P}"Nelim" brows are "BrowNormal"`,
  `And ${P}"Nelim" lids are "LidNormal"`,
  `And ${P}"Nelim" face skin is "SkinNormal"`,
  `And ${P}"Nelim" eyeballs are "EyeNormal"`,
  `And ${P}"Nelim" face head shape is "HeadNormal"`,
  `And ${P}"Nelim" facial expression is "normal"`,
  `And ${P}"Nelim" face is held neutral`,
  `And ${P}"Nelim" wears "Apparel_Pants"`,   // owner, 2026-10-25: the bare lower body showed in the face shots
  `And ${P}I frame the cell (176, 119) at zoom 3`,   // the zoom of the look gallery: the face crop of Make-LookSheets fits it
];
const bodyBase = [...common,
  `And ${P}"Nelim" facial expression is "normal"`,
  `And ${P}"Nelim" face is held neutral`,
  `And ${P}"Nelim" is undressed`,
  `And ${P}I frame the cell (176, 120) at zoom 2`,
];
const tags = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom'];
const out = [...tags, "Feature: One photograph per tattoo and birthmark of Roo's two mods on Nelim (look catalogue, Roo)", ''];
let n = 0;
function scenarios(kind, items, base, step) {
  const size = Math.ceil(items.length / Math.ceil(items.length / 20));   // even chunks of at most 20 shots (Pickle's watchdog stops a scenario at 300 s)
  for (let i = 0; i < items.length; i += size) {
    const part = items.slice(i, i + size); n++;
    out.push(`  Scenario: roo-gallery-${n}: ${kind} ${i + 1} to ${i + part.length} of ${items.length}`);
    base.forEach(l => out.push('    ' + l));
    for (const v of part) out.push(`    When ${P}${step(v)}`, `    And ${P}I let 5 frames pass`, `    And I take a screenshot "${kind}-${v}"`);
    out.push('');
  }
}
scenarios('facetattoo', face, faceBase, v => `"Nelim" face tattoo is "${v}"`);
scenarios('bodytattoo', body, bodyBase, v => `"Nelim" body tattoo is "${v}"`);
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-roo-gallery.feature', out.join('\n'));
console.log(`${face.length} face, ${body.length} body, ${n} scenarios`);

require('./Add-LookReset').apply('Tests/Pickle/Mod/Pickle/Features/pickletools-roo-gallery.feature');   // the look is saved once and restored before each photograph (owner, 2026-10-26)
