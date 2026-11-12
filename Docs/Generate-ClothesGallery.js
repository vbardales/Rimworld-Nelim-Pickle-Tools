// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-clothes-<key>-gallery.feature: one photograph per garment of one clothing mod on Nelim (a Female body,
// underwear base for the garments, a corset and trousers under the hats), with the framing and the shot names of pickletools-look-gallery
// (hat-<def> framed on the face, garment-<def> framed on the body), so docs/Make-LookSheets.ps1 picks the photographs up. The defs are read from the Workshop folder
// of the mod (Defs of the 1.6 or unversioned folders, comments stripped, ParentName resolved inside the mod, Male-only defs skipped), the priority ones first.
// With --rows it also prints the rows of ColonistRace/docs/catalogues/apparel.md (Mod | Layer (n) | names[slots]) for the mod.
//   node docs/Generate-ClothesGallery.js lts            (keys: lts, lisawork, boots)
// Pass: Submit-PickleRun.ps1 -Mod PickleTools -DepMap wsl-deps.clothes-<key>.map -Filter '::clothes-<key>-' -EvidenceDir Tests/Pickle/Inbox/clothes-<key>-1
const fs = require('fs'), path = require('path');
const W = 'C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/';
const MODS = {
  lts: { id: '3751997843', name: '[LTS] Raiments', first: ['LTS_SummerSundress', 'LTS_StraightDress', 'LTS_Skirt', 'LTS_Shorts', 'LTS_Dresspants'] },
  lisawork: { slim: true, id: '3709891968', name: "Lisa's Work Apparel", first: ['LisaWork_ApparelCollaredShirt', 'LisaWork_ApparelApronSurgeon', 'LisaWork_ApparelLabCoat', 'LisaWork_ApparelStethoscope'], firstLabels: /plaid shirt|shirt buttoned|pants and belt|^skirt$/i },
  boots: { id: '1488970545', name: 'Boots and Stuff', first: ['Apparel_sandals', 'Apparel_shoes'] },
};
const key = process.argv[2];
const mod = MODS[key];
if (!mod) { console.error('mod key: ' + Object.keys(MODS).join(', ')); process.exit(1); }
const root = W + mod.id;
function walk(d, out, depth = 0) {
  if (depth > 8) return;
  let es; try { es = fs.readdirSync(d, { withFileTypes: true }); } catch (e) { return; }
  for (const e of es) {
    const p = d + '/' + e.name;
    if (e.isDirectory()) { if (!/^(Textures|Sounds|Source|Languages|Assemblies|About)$/i.test(e.name)) walk(p, out, depth + 1); }
    else if (/\.xml$/i.test(e.name)) out.push(p);
  }
}
const files = []; walk(root, files);
const all = [];
for (const f of files) {
  const rel = f.replace(root, '');
  if (/\/(1\.[0-5])\//.test(rel) || /Versions\/1\.[0-5]\//.test(rel)) continue;
  let t; try { t = fs.readFileSync(f, 'utf8'); } catch (e) { continue; }
  t = t.replace(/<!--[\s\S]*?-->/g, '');
  for (const m of t.matchAll(/<ThingDef\b([^>]*)>([\s\S]*?)<\/ThingDef>/g)) {
    const a = m[1], b = m[2];
    all.push({
      name: (a.match(/\bName="([^"]*)"/) || [])[1], parent: (a.match(/\bParentName="([^"]*)"/) || [])[1], abs: /Abstract="True"/i.test(a),
      dn: (b.match(/<defName>([^<]*)<\/defName>/) || [])[1], label: (b.match(/<label>([^<]*)<\/label>/) || [])[1],
      apparel: /<apparel>/.test(b),
      groups: ((b.match(/<bodyPartGroups>([\s\S]*?)<\/bodyPartGroups>/) || ['', ''])[1].match(/<li>([^<]*)/g) || []).map(x => x.slice(4)),
      layers: ((b.match(/<layers>([\s\S]*?)<\/layers>/) || ['', ''])[1].match(/<li>([^<]*)/g) || []).map(x => x.slice(4)),
      gender: (b.match(/<gender>([^<]*)/) || [])[1],
    });
  }
}
const byName = {}; all.forEach(g => { if (g.name) byName[g.name] = g; });
const inh = (g, k, d = 0) => ((g[k] && g[k].length) ? g[k] : (d < 8 && g.parent && byName[g.parent] ? inh(byName[g.parent], k, d + 1) : g[k]));
const seen = new Set();
let defs = [];
for (const g of all) {
  if (!g.dn || g.abs || seen.has(g.dn)) continue;
  const isApparel = g.apparel || (g.parent && byName[g.parent] && byName[g.parent].apparel);
  if (!isApparel) continue;
  if (g.gender === 'Male') continue;
  seen.add(g.dn);
  const groups = inh(g, 'groups') || [], layers = inh(g, 'layers') || [];
  defs.push({ dn: g.dn, label: g.label || '', groups, layer: layers[0] || 'Unknown' });
}
const isHatDef = d => d.groups.some(x => /^(UpperHead|FullHead|Mouth|Eyes)$/.test(x));
const isFirst = d => Number(mod.first.includes(d.dn) || !!(mod.firstLabels && mod.firstLabels.test(d.label)));
defs.sort((x, y) => (isFirst(y) - isFirst(x)));
const rawName = d => d.dn + '[' + (d.groups.join('/')) + ']';
if (process.argv.includes('--rows')) {
  const byLayer = {};
  defs.forEach(d => (byLayer[d.layer] = byLayer[d.layer] || []).push(d));
  for (const [l, v] of Object.entries(byLayer)) console.log('| ' + mod.name + ' | ' + l + ' (' + v.length + ') | ' + v.map(rawName).sort().join(', ') + ' |');
  process.exit(0);
}
const P = "Nelim's Pickle Tools: ";
const PRE = [
  'Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I let 10 ticks pass`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
];
// slim (Lisa's Work: 1325 textures, 1.3 GB decoded, the full daily map got the game killed with exit 137 even at 6 garments per scenario): the map holds no Facial Animation, so no face step.
const NELIM = [`And ${P}"Nelim" stands at (176, 120) facing South`].concat(mod.slim ? [] : [`And ${P}"Nelim" face kit is "neutral"`, `And ${P}"Nelim" facial expression is "normal"`, `And ${P}"Nelim" face is held neutral`]);
const FACE = '(176, 119) at zoom 3', BODY = '(176, 120) at zoom 2', CHUNK = 6;
const wear = defs.filter(d => !isHatDef(d)).map(d => d.dn), hats = defs.filter(isHatDef).map(d => d.dn);
let n = 0, out = '@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\n@requires:nelim.pickletools.camerazoom\n'
  + `Feature: ${mod.name}, one photograph per garment on Nelim (gallery of the look catalogues)\n\n`;
function scenarios(title, items, setup, framing, step, shot, finish) {
  for (let i = 0; i < items.length; i += CHUNK) {
    const part = items.slice(i, i + CHUNK); n++;
    out += `  Scenario: clothes-${key}-${n}: ${title} ${i + 1} to ${i + part.length} of ${items.length}\n`;
    for (const l of PRE) out += `    ${l}\n`;
    for (const l of NELIM) out += `    ${l}\n`;
    for (const l of setup) out += `    And ${l}\n`;
    out += `    And ${P}I frame the cell ${framing}\n`;
    for (const it of part) out += `    When ${step(it)}\n    And ${P}I let 5 frames pass\n    And I take a screenshot "${shot(it)}"\n` + (finish ? `    And ${finish}\n` : '');
    out += '\n';
  }
}
scenarios('garments', wear, [], BODY,
  a => `${P}"Nelim" is undressed\n    And ${P}"Nelim" wears "UnderWhere_Panties"\n    And ${P}"Nelim" wears "UnderWhere_Bra"\n    And ${P}"Nelim" wears "${a}"`, a => 'garment-' + a);
scenarios('hats', hats, [`${P}"Nelim" hairstyle is "Long"`], FACE,
  a => `${P}"Nelim" wears "${a}"\n    And ${P}"Nelim" wears "Apparel_Corset"\n    And ${P}"Nelim" wears "Apparel_Pants"`, a => 'hat-' + a,
  `${P}"Nelim" gets back the clothes it had\n    And ${P}"Nelim" hairstyle is "Long"`);
const file = path.join(__dirname, '..', 'Tests/Pickle/Mod/Pickle/Features/pickletools-clothes-' + key + '-gallery.feature');
fs.writeFileSync(file, out);
console.log(`${mod.name}: ${n} scenarios, ${wear.length} garments, ${hats.length} hats; first: ${defs.slice(0, 8).map(d => d.dn).join(', ')}`);
// Pre-check (2026-11-04, after ticket 3a0f): every def the feature cites must exist in the mods of the map it runs with.
const check = require('child_process').spawnSync('node', [path.join(__dirname, 'Check-FeatureDefs.js'), '--map', 'clothes-' + key, '--feature', file], { encoding: 'utf8' });
console.log(check.stdout.trim());
if (check.status !== 0) { console.error('PRE-CHECK FAILED: do not file this ticket until the map holds the missing mods.'); process.exit(1); }
