// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-seren-sbe-gallery.feature: the 12 body mask genes of Seren Biotech Extended (SerenOriginalMask_0 .. _11, zero-based as in SBE) on Nelim and on a man,
// front and back, 4 scenarios of 12 shots. Same set-up as the body mask scenarios of pickletools-seren-gallery.feature (undressed, skin colour rgb (70, 50, 80)); no accent gene, so the masks
// keep the colour written on the gene. Shots bodymask-SerenOriginalMask_<n>-<nelim|man>-<front|back>. Written 2026-10-28 at the owner's request (sheet 0801 follows SBE).
// Pass: Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.seren-sbe.map -Filter 'pickletools-seren-sbe-gallery::seren-sbe-gallery'
const fs = require('fs'), path = require('path');
const P = "Nelim's Pickle Tools: ";
const PRE = ['Given the save "Nelims-tribe" is loaded', 'And game speed is paused', `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`];
function subject(name, man) {
  const s = [];
  if (man) s.push(`And a colonist "${name}" exists`, `And ${P}"${name}" gender is male`, `And ${P}"${name}" body type is Male`);
  s.push(`And ${P}"${name}" stands at (176, 120) facing South`, `And ${P}the other colonists are out of frame`, `And ${P}"${name}" hairstyle is "Bald"`, `And ${P}"${name}" face tattoo is "none"`,
    `And ${P}"${name}" mouth is "MouthNormal"`, `And ${P}"${name}" brows are "BrowNormal"`, `And ${P}"${name}" lids are "LidNormal"`, `And ${P}"${name}" face skin is "SkinNormal"`,
    `And ${P}"${name}" eyeballs are "EyeNormal"`, `And ${P}"${name}" face head shape is "HeadNormal"`, `And ${P}"${name}" facial expression is "normal"`, `And ${P}"${name}" face is held neutral`,
    `And ${P}I frame the cell (176, 120) at zoom 2`, `And ${P}"${name}" skin colour is rgb (70, 50, 80)`, `And ${P}"${name}" is undressed`);
  return s;
}
let out = '@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\n@requires:nelim.pickletools.camerazoom\n@requires:nelim.serenbiotechextended\nFeature: The 12 body masks of Seren Biotech Extended, front and back, on Nelim and on a man\n\n';
let n = 0;
for (const [who, name, man] of [['nelim', 'Nelim', false], ['man', 'Mannequin', true]]) {
  for (const [view, dir] of [['front', 'South'], ['back', 'North']]) {
    n++;
    out += `  Scenario: seren-sbe-gallery-${n}: SBE body masks on ${who}, ${view} (12 genes)\n`;
    for (const l of PRE) out += `    ${l}\n`;
    for (const l of subject(name, man)) out += `    ${l}\n`;
    for (let m = 0; m < 12; m++) out += `    When ${P}"${name}" loses all genes\n    And ${P}"${name}" has the gene "SerenOriginalMask_${m}"\n    And ${P}"${name}" stands at (176, 120) facing ${dir}\n    And ${P}I let 5 frames pass\n    And I take a screenshot "bodymask-SerenOriginalMask_${m}-${who}-${view}"\n`;
    out += '\n';
  }
}
fs.writeFileSync(path.join(__dirname, '..', 'Tests/Pickle/Mod/Pickle/Features/pickletools-seren-sbe-gallery.feature'), out);
console.log(n + ' scenarios');
