// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-colour-worklist.feature: one photograph per skin and hair colour gene of the mods of a batch of the
// colour worklist (Audit worklist docs/registre/worklist-npt-2026-11-02.tsv of the protocols root, static scan docs/runs/2026-11-02-colour-worklist-p1.md).
// Written 2026-11-02. Skin genes on underwear Nelim, hair genes with the hairstyle Afro, like Generate-GeneGallery.js (kept separate: that one reads mods the owner has since
// unsubscribed, so it cannot run any more without rewriting genes.md). Genes are read from the Defs of each mod on disk (Versions/1.6, 1.6, then the root), not typed.
// A name the game already defines (vanilla melanin, Biotech skins, vanilla hair) is skipped: the later mod overrides it and one gene would show under two names
// (Inclusive Skin Tones redefines Skin_Melanin1 to 9).
// One map per batch: Tests/Pickle/wsl-deps.colour-<batch>.map. Scenarios: colour-<batch>-<n>, 20 shots at most.
// usage: node docs/Generate-ColourWorklist.js   (from the repository root)
const fs = require('fs');
const STEAM = 'C:/Program Files (x86)/Steam/steamapps';
const DATA = STEAM + '/common/RimWorld/Data/';
const hex = (r, g, b) => [r, g, b].map(v => Math.max(0, Math.min(255, Math.round(v))).toString(16).padStart(2, '0')).join('').toUpperCase();
const colourOf = b => { const c = b.match(/<(?:skinColorBase|skinColorOverride|hairColorOverride)>\(?\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)/); if (!c) return ''; const v = [+c[1], +c[2], +c[3]].map(x => (c[0].includes('.') && x <= 1 ? x * 255 : x)); return hex(...v); };

const BATCHES = [
  { batch: 'w1a', mods: [
    { id: '3165888554', name: 'Vanilla Skin Tone Genes' },
    { id: '3551840130', name: 'Inclusive Skin Tones 1.6' },
    { id: '2985847757', name: 'Biotech Cosmetic Kit - Horns Halos and More' },
    { id: '2884115974', name: 'Integrated Genes' },
    { id: '3819827851', name: 'Geasbound Xenotype' },
    { id: '3790361865', name: "Sin's Softer Hair Colors" },
  ] },
];

function walkXml(dir) {
  const r = [];
  for (const e of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = dir + '/' + e.name;
    if (e.isDirectory()) r.push(...walkXml(p)); else if (e.name.endsWith('.xml')) r.push(p);
  }
  return r;
}
function genesIn(defs) {
  const out = { skin: [], hair: [] };
  for (const f of walkXml(defs)) {
    for (const b of fs.readFileSync(f, 'utf8').split(/<GeneDef[ >]/).slice(1)) {
      const name = (b.match(/<defName>([^<]+)</) || [])[1];
      const h = name && colourOf(b);
      if (h) (/<skinColor(?:Base|Override)>/.test(b) ? out.skin : out.hair).push({ name, hex: h });
    }
  }
  return out;
}
const vanilla = new Set([...genesIn(DATA + 'Core/Defs/GeneDefs').skin, ...genesIn(DATA + 'Core/Defs/GeneDefs').hair, ...genesIn(DATA + 'Biotech/Defs/GeneDefs').skin, ...genesIn(DATA + 'Biotech/Defs/GeneDefs').hair].map(g => g.name));
function modGenes(id) {
  const root = STEAM + '/workshop/content/294100/' + id;
  const defs = ['/Versions/1.6/Defs', '/1.6/Defs', '/1.6/Common/Defs', '/Common/Defs', '/Defs'].map(s => root + s).find(d => fs.existsSync(d));
  if (!defs) throw new Error('no Defs folder for ' + id);
  const g = genesIn(defs), skipped = [];
  for (const k of ['skin', 'hair']) g[k] = g[k].filter(x => !vanilla.has(x.name) || (skipped.push(x.name), false));
  return { ...g, skipped };
}

const PT = "Nelim's Pickle Tools: ";
const skinBase = [
  'Given the save "Nelims-tribe" is loaded',
  'And game speed is paused',
  `And ${PT}the item and name labels are hidden`,
  `And ${PT}the tooltips are hidden`,
  `And ${PT}the colonist bar is hidden`,
  `And ${PT}the learning helper is hidden`,
  `And ${PT}the temperature of the map is 20 degrees`,
  `And ${PT}I frame the area centred on (177, 121) at root size 6.5`,
  `And ${PT}"Nelim" stands at (176, 120) facing South`,
  `And ${PT}the other colonists are out of frame`,
  `And ${PT}"Nelim" hairstyle is "Bald"`,
  `And ${PT}"Nelim" face tattoo is "none"`,
  `And ${PT}"Nelim" mouth is "MouthNormal"`,
  `And ${PT}"Nelim" brows are "BrowNormal"`,
  `And ${PT}"Nelim" lids are "LidNormal"`,
  `And ${PT}"Nelim" face skin is "SkinNormal"`,
  `And ${PT}"Nelim" eyeballs are "EyeNormal"`,
  `And ${PT}"Nelim" face head shape is "HeadNormal"`,
  `And ${PT}"Nelim" facial expression is "normal"`,
  `And ${PT}"Nelim" face is held neutral`,
  `And ${PT}"Nelim" wears "UnderWhere_Panties"`,
  `And ${PT}"Nelim" wears "UnderWhere_Bra"`,
  `And ${PT}I frame the cell (176, 120) at zoom 2`,
];
const out = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom',
  'Feature: One photograph per skin and hair colour gene of the mods of the colour worklist', ''];
const chunks = (list, per) => { const n = Math.ceil(list.length / Math.ceil(list.length / per)); const r = []; for (let i = 0; i < list.length; i += n) r.push(list.slice(i, i + n)); return r; };
const skinShot = g => [`When ${PT}"Nelim" has the gene "${g.name}"`, `And ${PT}I let 5 frames pass`, `And I take a screenshot "skingene-${g.name}"`];
const hairShot = g => [`When ${PT}"Nelim" has the gene "${g.name}"`, `And ${PT}"Nelim" hair colour is taken from its genes`, `And ${PT}I let 5 frames pass`, `And I take a screenshot "hairgene-${g.name}"`];

for (const { batch, mods } of BATCHES) {
  const skins = [], hairs = [];
  for (const m of mods) {
    const g = modGenes(m.id);
    skins.push(...g.skin); hairs.push(...g.hair);
    console.log(`${batch} ${m.id} ${m.name}: ${g.skin.length} skin, ${g.hair.length} hair` + (g.skipped.length ? `, skipped ${g.skipped.length} vanilla names` : ''));
  }
  let k = 0;
  for (const part of chunks(skins, 20)) {
    out.push(`  Scenario: colour-${batch}-${++k}: skin colour genes ${part[0].name} to ${part[part.length - 1].name} (${part.length})`);
    skinBase.forEach(l => out.push('    ' + l));
    part.forEach(g => skinShot(g).forEach(l => out.push('    ' + l)));
    out.push('');
  }
  for (const part of chunks(hairs, 20)) {
    out.push(`  Scenario: colour-${batch}-${++k}: hair colour genes ${part[0].name} to ${part[part.length - 1].name} (${part.length})`);
    skinBase.forEach(l => out.push('    ' + l));
    out.push(`    And ${PT}"Nelim" hairstyle is "Afro"`);
    part.forEach(g => hairShot(g).forEach(l => out.push('    ' + l)));
    out.push('');
  }
  console.log(`${batch}: ${skins.length} skin and ${hairs.length} hair shots, ${k} scenarios`);
}
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-colour-worklist.feature', out.join('\n'));
