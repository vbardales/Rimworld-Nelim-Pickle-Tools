// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-soren-gallery.feature: the body tattoos and the beards, one photograph per value, on
// Soren (the male colonist, never Nelim): the tattoos on a bare male body in briefs (UnderWhere_Panties, to show as much tattoo as possible), seen from the front and from the back (12 tattoos, 24 shots, per scenario), the
// beards in a face close-up. The values are read from the steps of pickletools-look-gallery.feature (which holds the catalogue lists).
// Written 2026-10-25 at the owner's request. usage: node docs/Generate-SorenGallery.js   (from the repository root)
const fs = require('fs');
const look = fs.readFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-look-gallery.feature', 'utf8');
const values = re => [...new Set([...look.matchAll(re)].map(m => m[1]))];
const bodyTattoos = values(/"Nelim" body tattoo is "([^"]+)"/g).filter(t => !/^none$/i.test(t));
const beards = values(/"Nelim" beard is "([^"]+)"/g);
const P = "Nelim's Pickle Tools: ";
const pre = [
  'Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I let 10 ticks pass`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
  'And a colonist "Soren" exists', 'And "Soren" is 30 years old', `And ${P}"Soren" gender is male`,
  `And ${P}"Soren" stands at (176, 120) facing South`, `And ${P}the other colonists are out of frame`,
  `And ${P}"Soren" face kit is "neutral"`, `And ${P}"Soren" facial expression is "normal"`, `And ${P}"Soren" face is held neutral`,
  `And ${P}"Soren" body type is Male`,
];
let n = 0;
let out = '@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\n@requires:nelim.pickletools.camerazoom\n'
  + 'Feature: Body tattoos and beards on Soren, one photograph per value (the male half of the look catalogues)\n\n';
function scenarios(kind, items, setup, frame, step, views, CHUNK) {
  for (let i = 0; i < items.length; i += CHUNK) {
    const part = items.slice(i, i + CHUNK); n++;
    out += `  Scenario: soren-gallery-${n}: ${kind} ${i + 1} to ${i + part.length} of ${items.length}\n`;
    for (const l of [...pre, ...setup, `${P}I frame the cell ${frame}`]) out += `    ${/^(Given|And) /.test(l) ? '' : 'And '}${l}\n`;
    for (const it of part) {
      out += `    When ${step(it)}\n`;
      for (const v of views) out += (v.facing ? `    And ${P}"Soren" stands at (176, 120) facing ${v.facing}\n` : '') + `    And ${P}I let 5 frames pass\n    And I take a screenshot "soren-${kind}-${it}${v.suffix}"\n`;
    }
    out += '\n';
  }
}
scenarios('bodytattoo', bodyTattoos, [`"Soren" is undressed`, `"Soren" wears "UnderWhere_Panties"`].map(s => P + s), '(176, 120) at zoom 2', t => `${P}"Soren" body tattoo is "${t}"`, [{ facing: 'South', suffix: '-front' }, { facing: 'North', suffix: '-back' }], 12);
scenarios('beard', beards, [], '(176, 119) at zoom 3', b => `${P}"Soren" beard is "${b}"`, [{ suffix: '' }], 20);
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-soren-gallery.feature', out);
console.log(`${n} scenarios: ${bodyTattoos.length} body tattoos, ${beards.length} beards`);
