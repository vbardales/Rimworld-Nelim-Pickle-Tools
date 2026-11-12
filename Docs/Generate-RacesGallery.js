// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-races-gallery.feature: one photograph per visual item of four race mods that the owner re-subscribed to
// and wants catalogued before she unsubscribes again (Audit message and docs/registre/worklist-npt-2026-10-31.md, worklist-frilleum.md of the protocols root, 2026-10-31):
// Charmweavers (7 visual genes, the slave outfit), Molong (8 visual genes), Frilleum (23 garments and 4 head types on a Frilleum colonist, 3 drakes and the shellox).
// Shots race-<defName>. Map wsl-deps.races.map. Papou (2882466074) is not on the disk yet: add its genes here when it is.
// usage: node docs/Generate-RacesGallery.js   (from the repository root)
const fs = require('fs');
const P = "Nelim's Pickle Tools: ";
const charmGenes = ['RS_Skin_PaleGreen', 'RS_Headbone_RamHorns', 'RS_Headbone_MediumHorns', 'RS_Headbone_LargeHorns', 'RS_Wing_Batlike', 'RS_Tail_Spiked', 'RS_Eyes_Pink'];
const molongGenes = ['GS_Headbone_Skinhorns', 'GS_Ears_MFiend', 'GS_TigerEyeGene', 'GS_FiendHead', 'GS_BigNose', 'GS_Skin_VRed', 'GS_Skin_VBlue', 'GS_Skin_VYellow'];
const garments = ['Apparel_FrillPantsA', 'Apparel_FrillPantsB', 'Apparel_FrillShirt', 'Apparel_FrillCoatG', 'Apparel_FrillCoatP', 'Apparel_FrillCoatR', 'Apparel_FrillScapula', 'Apparel_FrillSmock',
  'Apparel_FrillBrigandine', 'Apparel_FrillGambeson', 'Apparel_FrillTricorn', 'Apparel_FrillHelmet', 'Apparel_FrillDoublet', 'Apparel_FrillCourtlyBreeches', 'Apparel_FrillGown', 'Apparel_FrillCorset',
  'Apparel_FrillFeatherCloak', 'Apparel_FrillRobe', 'Apparel_FrillRoyalArmor', 'Apparel_FrillCirclet', 'Apparel_FrillCircletGem', 'Apparel_FrillDiadem', 'Apparel_FrillCrown'];
const papouGenes = ['papagoBody1', 'papagoBody2', 'papagoTail', 'papagoWing0', 'papagoWing1', 'papagoWing2', 'papagoWing3', 'papagoWing4', 'papagoSkinColor1', 'papagoSkinColor2', 'papagoHairRed', 'papagoHairYellow', 'papagoCheek0', 'papagoCheek1', 'papagoEar0', 'papagoEar1', 'papagoEar2', 'papagoEar3', 'papagoEar4'];   // Papou (2882466074, 1.4 only, Sounds folder): its own map wsl-deps.races-papou.map, a Sounds folder may hang the load like Zealous Innocence
const heads = ['FrilleumSkull', 'FrilleumFaceA', 'FrilleumFaceB', 'FrilleumFaceC'];
const animals = [['IceDrake', 'IceDrake1', 170], ['ShieldDrake', 'ShieldDrake1', 172], ['TundraDrake', 'TundraDrake1', 174], ['Shellox', 'Shellox1', 178]];
const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom',
  'Feature: Four race mods before the owner unsubscribes: Charmweavers, Molong and Frilleum, one photograph per visual item', ''];
const pre = ['Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`, `And ${P}the other colonists are out of frame`];
function subject(nick, create) {
  const s = [];
  if (create) s.push(`And ${P}a colonist "${nick}" of kind "${create}" exists`);
  s.push(`And ${P}"${nick}" stands at (176, 120) facing South`, `And ${P}"${nick}" hairstyle is "Bald"`, `And ${P}"${nick}" face tattoo is "none"`, `And ${P}"${nick}" is undressed`, `And ${P}I frame the cell (176, 120) at zoom 2`);
  return s;
}
function scenario(name, extra, steps) {
  out.push(`  Scenario: ${name}`);
  for (const l of [...pre, ...extra]) out.push('    ' + l);
  for (const l of steps) out.push('    ' + l);
  out.push('');
}
const geneShots = (nick, list) => list.flatMap(g => [`When ${P}"${nick}" loses all genes`, `And ${P}"${nick}" has the gene "${g}"`, `And ${P}"${nick}" stands at (176, 120) facing South`, `And ${P}I let 5 frames pass`, `And I take a screenshot "race-${g}"`]);
scenario('races-gallery-1: Charmweavers genes and slave outfit on Nelim', subject('Nelim', null),
  [...geneShots('Nelim', charmGenes), `When ${P}"Nelim" loses all genes`, `And ${P}"Nelim" wears "RS_Apparel_SlaveOutfit"`, `And ${P}I let 5 frames pass`, 'And I take a screenshot "race-RS_Apparel_SlaveOutfit"']);
scenario('races-gallery-2: Molong genes on Nelim', subject('Nelim', null), geneShots('Nelim', molongGenes));
const garmentShots = list => list.flatMap(g => [`When ${P}"Fril" is undressed`, `And ${P}"Fril" wears "${g}"`, `And ${P}I let 5 frames pass`, `And I take a screenshot "race-${g}"`]);
scenario('races-gallery-3: Frilleum garments 1 to 12 of 23 on a Frilleum colonist', subject('Fril', 'FrilleumColonistB'), garmentShots(garments.slice(0, 12)));
scenario('races-gallery-4: Frilleum garments 13 to 23 of 23 on a Frilleum colonist', subject('Fril', 'FrilleumColonistB'), garmentShots(garments.slice(12)));
scenario('races-gallery-5: Frilleum head types on a Frilleum colonist', subject('Fril', 'FrilleumColonistB'),
  heads.flatMap(h => [`When ${P}"Fril" head type is "${h}"`, `And ${P}I let 5 frames pass`, `And I take a screenshot "race-${h}"`]));
scenario('races-gallery-6: Frilleum drakes and the shellox', [],
  animals.flatMap(([kind, name, x]) => [`Given ${P}an adult animal of kind "${kind}" named "${name}" is spawned at (${x}, 126)`, `When ${P}I frame the animal "${name}" at zoom 2`, `And ${P}I let 5 frames pass`, `And I take a screenshot "race-${kind}"`]));
scenario('races-gallery-7: Papou genes 1 to 10 of 19 on Nelim', subject('Nelim', null), geneShots('Nelim', papouGenes.slice(0, 10)));
scenario('races-gallery-8: Papou genes 11 to 19 of 19 on Nelim', subject('Nelim', null), geneShots('Nelim', papouGenes.slice(10)));
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-races-gallery.feature', out.join('\n') + '\n');
console.log('8 scenarios');
