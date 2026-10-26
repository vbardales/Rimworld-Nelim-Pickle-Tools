// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-seren-face-gallery.feature: one photograph per face part of Seren, from Stardust [Biotech Fork]
// (Workshop 3726565301, the Experimentals set: the one the NSB map loads), and the whole Seren pawn, female (Nelim) and male (Soren).
// The Seren genes (skins, hair colours, markings, sensors, ears, eyes, body masks) are already photographed by pickletools-gene-gallery
// (sheets skingene-seren-*, hairgene-seren-*, lookgene-seren-*), so they are not repeated here.
// Values are read from the mod's own face defs, not typed. Shots: seren-<part>-<defName>, seren-xeno-*; map wsl-deps.seren-face-gallery.map.
// Written 2026-10-25 at the owner's request (Seren catalogues, all of them).
// usage: node docs/Generate-SerenGallery.js   (from the repository root)
const fs = require('fs');
const DIR = 'C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/3726565301/1.6/Compatibility/Facial Animations - Experimentals/Defs/FaceTypeDefs/';
const names = file => [...fs.readFileSync(DIR + file, 'utf8').matchAll(/<defName>([^<]+)</g)].map(m => m[1]);
const heads = names('Head.xml'), lids = names('Lids.xml'), eyes = names('Eyes.xml'), brows = names('Brows.xml'), mouths = names('Mouth.xml'), skins = names('Skin.xml');
const P = "Nelim's Pickle Tools: ";
const tags = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom'];
const common = who => [
  'Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
  ...(who === 'Soren' ? ['And a colonist "Soren" exists', 'And "Soren" is 30 years old', `And ${P}"Soren" gender is male`, `And ${P}"Soren" body type is Male`] : []),
  `And ${P}"${who}" stands at (176, 120) facing South`, `And ${P}the other colonists are out of frame`,
  `And ${P}"${who}" xenotype is "OL_SerenBase"`, `And ${P}"${who}" hairstyle is "Bald"`, `And ${P}"${who}" face tattoo is "none"`,
];
const faceBase = [...common('Nelim'),
  `And ${P}"Nelim" mouth is "SerenMouthNormal"`, `And ${P}"Nelim" brows are "SerenBrowNormal"`, `And ${P}"Nelim" lids are "SerenLidNormal"`,
  `And ${P}"Nelim" eyeballs are "SerenEyesNormal"`, `And ${P}"Nelim" face head shape is "SerenHeadNormal"`,
  `And ${P}"Nelim" facial expression is "normal"`, `And ${P}"Nelim" face is held neutral`,
  `And ${P}I frame the cell (176, 119) at zoom 2`,
];
const shot = (step, name) => [`When ${P}${step}`, `And ${P}I let 5 frames pass`, `And I take a screenshot "${name}"`];
const out = [...tags, 'Feature: One photograph per face part of Seren (Experimentals set) and the whole Seren pawn, female and male (the Seren catalogues)', ''];
let n = 0;
function scenario(title, base, shots) {   // at most 25 shots per scenario (Pickle's watchdog stops a scenario at 300 s)
  n++; out.push(`  Scenario: seren-face-gallery-${n}: ${title}`);
  base.forEach(l => out.push('    ' + l));
  shots.forEach(s => s.forEach(x => out.push('    ' + x)));
  out.push('');
}
const parts = [
  ['head', 'face head shape is', heads], ['lid', 'lids are', lids], ['eyeball', 'eyeballs are', eyes], ['brow', 'brows are', brows], ['mouth', 'mouth is', mouths],
];
scenario(`face parts: ${heads.length} heads, ${lids.length} lids, ${eyes.length} eyeballs, ${brows.length} brows, ${mouths.length} mouths`, faceBase,
  parts.flatMap(([k, step, list]) => list.map(v => shot(`"Nelim" ${step} "${v}"`, `seren-${k}-${v}`))));
scenario(`face skins: ${skins.length} marking skins`, faceBase, skins.map(v => shot(`"Nelim" face skin is "${v}"`, `seren-skin-${v}`)));
// The Vanilla Textures Expanded set has one brow of its own (OL_SerenBrowNone, owner 2026-10-26: the brow sheet should show it): its own scenario, since the def only exists when that set is loaded.
scenario('VTE brow: OL_SerenBrowNone', [...common('Nelim'), `And ${P}"Nelim" facial expression is "normal"`, `And ${P}"Nelim" face is held neutral`, `And ${P}I frame the cell (176, 119) at zoom 2`], [shot(`"Nelim" brows are "OL_SerenBrowNone"`, 'seren-brow-OL_SerenBrowNone')]);
// The whole Seren pawn (xenotype OL_SerenBase: ears, one sensor, markings, skin and hair colours its genes give), clothed as the fixture is.
for (const who of ['Nelim', 'Soren']) {
  scenario(`the whole Seren pawn: ${who}`, [...common(who),
    `And ${P}"${who}" facial expression is "normal"`, `And ${P}"${who}" face is held neutral`, `And ${P}I frame the cell (176, 120) at zoom 2`],
    [shot(`"${who}" stands at (176, 120) facing South`, `seren-xeno-${who === 'Soren' ? 'man' : who}-front`), shot(`"${who}" stands at (176, 120) facing East`, `seren-xeno-${who === 'Soren' ? 'man' : who}-side`), shot(`"${who}" stands at (176, 120) facing North`, `seren-xeno-${who === 'Soren' ? 'man' : who}-back`)]);
}
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-seren-face-gallery.feature', out.join('\n'));
console.log(`${heads.length} heads, ${lids.length} lids, ${eyes.length} eyeballs, ${brows.length} brows, ${mouths.length} mouths, ${skins.length} skins; ${n} scenarios`);
