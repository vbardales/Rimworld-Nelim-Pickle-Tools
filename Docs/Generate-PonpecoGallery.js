// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-ponpeco-gallery.feature: one photograph per garment of Ponpeco Accessories (on Nelim) and Ponpeco Kids' Clothes
// (on Soren at 8 years old), with the framing and the shot names of pickletools-look-gallery (hat-<def> framed on the face, garment-<def> framed on the body), so
// docs/Make-LookSheets.ps1 picks the photographs up. Input: the [look-apparel] lines of a pickletools-look-catalogue run, one per line, in the file given as argument.
//   node docs/Generate-PonpecoGallery.js look-lines.txt
// Pass: Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.look-gallery.map -Filter 'pickletools-ponpeco-gallery::ponpeco-gallery'
const fs = require('fs'), path = require('path');
const lines = fs.readFileSync(process.argv[2], 'utf8').split(/\r?\n/);
const P = "Nelim's Pickle Tools: ";
const isHat = r => /\[(?:UpperHead|FullHead|Mouth|Eyes)[\]\/]/.test(r);
const clean = r => r.replace(/\[.*\]$/, '');
function defs(modRe) {
  const out = [];
  for (const l of lines) {
    const m = l.match(/^\[look-apparel\] (.*?) \| (.*?) \((\d+)\): (.*)$/);
    if (m && modRe.test(m[1])) for (const raw of m[4].split(', ')) out.push(raw.trim());
  }
  return out;
}
const acc = defs(/^Ponpeco Accessories/), kids = defs(/^Ponpeco Kids/);
const PRE = [
  'Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I let 10 ticks pass`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
];
const NELIM = [`And ${P}"Nelim" stands at (176, 120) facing South`, `And ${P}"Nelim" face kit is "neutral"`, `And ${P}"Nelim" facial expression is "normal"`, `And ${P}"Nelim" face is held neutral`];
const SOREN = ['And a colonist "Soren" exists', 'And "Soren" is 8 years old', `And ${P}"Soren" gender is male`, `And ${P}"Soren" body type is Child`, `And ${P}"Soren" stands at (176, 120) facing South`,
  `And ${P}the other colonists are out of frame`, `And ${P}"Soren" face kit is "neutral"`, `And ${P}"Soren" facial expression is "normal"`, `And ${P}"Soren" face is held neutral`];
const FACE = '(176, 119) at zoom 3', BODY = '(176, 120) at zoom 2', CHUNK = 20;
let n = 0, out = '@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\n@requires:nelim.pickletools.camerazoom\n'
  + "Feature: Ponpeco Accessories and Kids' Clothes, one photograph per garment (gallery of the look catalogues)\n\n";
function scenarios(title, items, subject, setup, framing, step, shot, finish) {
  for (let i = 0; i < items.length; i += CHUNK) {
    const part = items.slice(i, i + CHUNK); n++;
    out += `  Scenario: ponpeco-gallery-${n}: ${title} ${i + 1} to ${i + part.length} of ${items.length}\n`;
    for (const l of PRE) out += `    ${l}\n`;
    for (const l of subject) out += `    ${l}\n`;
    for (const l of setup) out += `    And ${l}\n`;
    out += `    And ${P}I frame the cell ${framing}\n`;
    for (const it of part) out += `    When ${step(it)}\n    And ${P}I let 5 frames pass\n    And I take a screenshot "${shot(it)}"\n` + (finish ? `    And ${finish}\n` : '');
    out += '\n';
  }
}
const accHats = acc.filter(isHat).map(clean), accWear = acc.filter(r => !isHat(r)).map(clean);
const kidHats = kids.filter(isHat).map(clean), kidWear = kids.filter(r => !isHat(r)).map(clean);
scenarios('accessory hats', accHats, NELIM, [`${P}"Nelim" hairstyle is "Long"`], FACE,
  a => `${P}"Nelim" wears "${a}"\n    And ${P}"Nelim" wears "Apparel_Corset"\n    And ${P}"Nelim" wears "Apparel_Pants"`, a => 'hat-' + a,
  `${P}"Nelim" gets back the clothes it had\n    And ${P}"Nelim" hairstyle is "Long"`);
scenarios('accessory neck pieces', accWear, NELIM, [], BODY,
  a => `${P}"Nelim" is undressed\n    And ${P}"Nelim" wears "UnderWhere_Panties"\n    And ${P}"Nelim" wears "UnderWhere_Bra"\n    And ${P}"Nelim" wears "${a}"`, a => 'garment-' + a);
scenarios('kids clothes', kidWear, SOREN, [], BODY, a => `${P}"Soren" is undressed\n    And ${P}"Soren" wears "UnderWhere_Loincloth"\n    And ${P}"Soren" wears "${a}"`, a => 'garment-' + a);   // a loincloth under every garment (owner, 2026-10-28)
scenarios('kids hats', kidHats, SOREN, [], FACE, a => `${P}"Soren" is undressed\n    And ${P}"Soren" wears "${a}"`, a => 'hat-' + a);
fs.writeFileSync(path.join(__dirname, '..', 'Tests/Pickle/Mod/Pickle/Features/pickletools-ponpeco-gallery.feature'), out);
console.log(`${n} scenarios: accessory hats ${accHats.length}, accessory neck pieces ${accWear.length}, kids clothes ${kidWear.length}, kids hats ${kidHats.length}`);
