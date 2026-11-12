// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-vanilla-head-gallery.feature: one photograph per vanilla HeadTypeDef (Core, Biotech, Anomaly: the "Head types" of
// ColonistRace/docs/catalogues/looks.md), on a BALD pawn, front view, on a map WITHOUT Facial Animation. With Nals Facial Animation loaded the mod draws its own head and
// the vanilla head type does not show: the first sheets (0301 to 0303, 2026-10-26) came out identical for every head for that reason. Shots head-<defName> (kind head).
// Heads tagged (Male) are photographed on a male mannequin, the others on Nelim. Map wsl-deps.vanilla-heads.map (no face mods). Written 2026-10-30.
// usage: node docs/Generate-VanillaHeadGallery.js   (from the repository root)
const fs = require('fs');
const P = "Nelim's Pickle Tools: ";
const md = fs.readFileSync('ColonistRace/docs/catalogues/looks.md', 'utf8').split(/\n## Head types[^\n]*\n/)[1].split(/\n## /)[0];
const male = [], other = [];
for (const l of md.split('\n')) {
  if (!l.startsWith('|') || /^\|\s*(Mod\b|-)/.test(l)) continue;   // header row and the separator row |---|---|
  const cells = l.split('|').map(s => s.trim()).filter(Boolean);
  for (const raw of cells[cells.length - 1].replace(/^\(\d+\) /, '').split(', ')) (/ \(Male\)$/.test(raw) ? male : other).push(raw.replace(/ \((Male|Female)\)$/, ''));
}
const CHUNK = 10;
const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom',
  'Feature: The vanilla head types on a bald pawn, on a map without Facial Animation (the head catalogue)', ''];
const pre = ['Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I let 10 ticks pass`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
  `And ${P}the other colonists are out of frame`];
function family(list, nick, extra, label) {
  for (let i = 0; i < list.length; i += CHUNK) {
    const part = list.slice(i, i + CHUNK);
    out.push(`  Scenario: vanilla-head-gallery-${label}-${i / CHUNK + 1}: ${label} head types ${i + 1} to ${i + part.length} of ${list.length}`);
    for (const l of [...pre, ...extra, `And ${P}"${nick}" stands at (176, 120) facing South`, `And ${P}"${nick}" hairstyle is "Bald"`, `And ${P}"${nick}" face tattoo is "none"`, `And ${P}I frame the cell (176, 119) at zoom 2`]) out.push('    ' + l);
    for (const h of part) out.push(`    When ${P}"${nick}" head type is "${h}"`, `    And ${P}I let 5 frames pass`, `    And I take a screenshot "head-${h}"`);
    out.push('');
  }
}
family(male, 'Mannequin', ['And a colonist "Mannequin" exists', `And ${P}"Mannequin" gender is male`, `And ${P}"Mannequin" body type is Male`, `And ${P}"Mannequin" is undressed`, `And ${P}"Mannequin" wears "UnderWhere_Boxers"`], 'male');
family(other, 'Nelim', [`And ${P}"Nelim" is undressed`, `And ${P}"Nelim" wears "UnderWhere_Panties"`, `And ${P}"Nelim" wears "UnderWhere_Bra"`], 'other');
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-vanilla-head-gallery.feature', out.join('\n'));
console.log(male.length + ' male heads, ' + other.length + ' others');
