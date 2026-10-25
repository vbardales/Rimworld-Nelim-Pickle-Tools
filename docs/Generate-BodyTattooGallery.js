// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-bodytattoo-gallery.feature: one photograph per body tattoo of Ideology, Tattoos Expanded and
// Tribal Tattoos on Nelim UNDRESSED (owner, 2026-10-25: a body tattoo is on the skin, the underwear of the first catalogue hid part of it; the nude
// renders stay in the documentation, never in a Steam gallery). Roo's own tattoos are in pickletools-roo-gallery. Body_Royal is left out (Ideology and
// Roo's Starter Pack both define it, the game keeps one). Shots are named bodytattoo-<def>: docs/Make-LookSheets.ps1 (job bodytattoo) fills the tiles
// from the folders Tests/Pickle/Inbox/look-gallery-bodytattoo-N. The old tiles of these values must be deleted first (the tile cache would keep them).
// usage: node Docs/Generate-BodyTattooGallery.js   (from the repository root; map wsl-deps.look-gallery.map)
const fs = require('fs');
const md = fs.readFileSync('ColonistRace/docs/CATALOGUE-LOOKS.md', 'utf8').split(/\r?\n/);
const rows = md.filter(l => /^\| (Ideology|Tattoos Expanded|Tribal Tattoos) \|/.test(l));
if (rows.length !== 3) throw new Error('expected 3 rows, found ' + rows.length);
const body = [];
for (const r of rows) for (const raw of r.split('|')[2].replace(/^\s*\(\d+\)\s*/, '').split(', ')) {
  const m = raw.trim().match(/^(\S+) \(Body\)$/);
  if (m && m[1] !== 'Body_Royal') body.push(m[1]);
}
const P = "Nelim's Pickle Tools: ";
const base = ['Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
  `And ${P}"Nelim" stands at (176, 120) facing South`, `And ${P}"Nelim" facial expression is "normal"`, `And ${P}"Nelim" face is held neutral`,
  `And ${P}"Nelim" is undressed`, `And ${P}I frame the cell (176, 120) at zoom 2`];
const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom',
  'Feature: One photograph per body tattoo of Ideology, Tattoos Expanded and Tribal Tattoos on an undressed Nelim', ''];
const size = Math.ceil(body.length / Math.ceil(body.length / 16)); let n = 0;
for (let i = 0; i < body.length; i += size) {
  const part = body.slice(i, i + size); n++;
  out.push(`  Scenario: bodytattoo-gallery-${n}: body tattoos ${i + 1} to ${i + part.length} of ${body.length}`);
  base.forEach(l => out.push('    ' + l));
  for (const v of part) out.push(`    When ${P}"Nelim" body tattoo is "${v}"`, `    And ${P}I let 5 frames pass`, `    And I take a screenshot "bodytattoo-${v}"`);
  out.push('');
}
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-bodytattoo-gallery.feature', out.join('\n'));
fs.writeFileSync('docs/.bodytattoo-values.tmp', body.join('\n'));
console.log(`${body.length} body tattoos, ${n} scenarios`);
