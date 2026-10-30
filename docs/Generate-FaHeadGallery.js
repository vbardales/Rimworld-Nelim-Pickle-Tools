// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-fa-head-gallery.feature: one photograph per Facial Animation head shape (FacialAnimation.HeadTypeDef) of the
// mods of the owner's head shape list, on a bald Nelim, front view, set by the step `face head shape is`. Shots: fahead-<defName>.
// The head names are read from the listing the look catalogue runs print: lines `[face-parts] Head | <mod> (n): a, b, c` of the Player.log of the runs given below
// (b2 holds Genetic Biotech, b6 the others), so nothing is typed by hand. A head already photographed by the vanilla head sheets is not repeated here (HeadNormal is kept
// as the reference shot). Written 2026-10-30 at the owner's request (head shapes missing from the catalogue). Map wsl-deps.fa-heads.map.
// usage: node docs/Generate-FaHeadGallery.js   (from the repository root)
const fs = require('fs');
const RUNS = ['Tests/Pickle/Inbox/look-catalogue-8-b2/Player.log', 'Tests/Pickle/Inbox/look-catalogue-9-b6/Player.log'];
const P = "Nelim's Pickle Tools: ";
const found = new Map();   // defName -> mod label
for (const f of RUNS) {
  if (!fs.existsSync(f)) { console.error('missing ' + f); continue; }
  for (const l of fs.readFileSync(f, 'utf8').replace(/<[^>]*>/g, '').split('\n')) {
    const m = l.match(/\[face-parts\] Head \| (.*?) \(\d+\): (.*)$/);
    if (m) for (const n of m[2].split(', ')) found.set(n.trim(), m[1]);
  }
}
const heads = [...found.entries()].sort((a, b) => a[1].localeCompare(b[1]) || a[0].localeCompare(b[0]));
const CHUNK = 10;   // 12 shots a scenario at most: the 300 s watchdog killed a 20-shot scenario on 2026-10-30
const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom',
  'Feature: One photograph per Facial Animation head shape (the head shape catalogue)', ''];
for (let i = 0; i < heads.length; i += CHUNK) {
  const part = heads.slice(i, i + CHUNK);
  out.push(`  Scenario: fa-head-gallery-${i / CHUNK + 1}: head shapes ${i + 1} to ${i + part.length} of ${heads.length}`,
    '    Given the save "Nelims-tribe" is loaded', '    And game speed is paused',
    `    And ${P}the item and name labels are hidden`, `    And ${P}the tooltips are hidden`, `    And ${P}the colonist bar is hidden`, `    And ${P}the learning helper is hidden`,
    `    And ${P}the temperature of the map is 20 degrees`, `    And ${P}I frame the area centred on (177, 121) at root size 6.5`,
    `    And ${P}"Nelim" stands at (176, 120) facing South`, `    And ${P}the other colonists are out of frame`,
    `    And ${P}"Nelim" hairstyle is "Bald"`, `    And ${P}"Nelim" face tattoo is "none"`,
    `    And ${P}"Nelim" face kit is "neutral"`, `    And ${P}"Nelim" facial expression is "normal"`, `    And ${P}"Nelim" face is held neutral`,
    `    And ${P}I frame the cell (176, 119) at zoom 2`);
  for (const [n] of part) out.push(`    When ${P}"Nelim" face head shape is "${n}"`, `    And ${P}I let 5 frames pass`, `    And I take a screenshot "fahead-${n}"`);
  out.push('');
}
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-fa-head-gallery.feature', out.join('\n'));
console.log(heads.length + ' heads, ' + Math.ceil(heads.length / CHUNK) + ' scenarios: ' + heads.map(h => h[0]).join(', '));
