// Builds ColonistRace/docs/catalogues/labels-fr.json: the French label of every value shown on the catalogue sheets (defName -> label), read from the French
// translations of the game and of the mods, never invented. A value with no French translation is simply absent: the catalogue then shows its defName only.
// Sources: the official French packs of the game and DLC (Data/<DLC>/Languages/French*.tar, extracted by the caller into <dir>/<DLC>/DefInjected/...), and the
// Languages/French*/DefInjected folders of the Workshop mods (also under a version folder such as 1.6/Languages). Key read: <defName.label>.
// usage: node docs/Make-FrenchLabels.js <dir of the extracted official packs>      (from the repository root; the tars are extracted with: tar --force-local -xf <tar> -C <dir>/<DLC>)
const fs = require('fs'), path = require('path');
const extracted = process.argv[2];
if (!extracted) throw new Error('usage: node docs/Make-FrenchLabels.js <dir of the extracted official French packs>');
const looks = 'ColonistRace/docs/img/looks';
const sheets = JSON.parse(fs.readFileSync(path.join(looks, 'sheets.json'), 'utf8').replace(/^\uFEFF/, ''));
const wanted = new Set();
for (const cells of Object.values(sheets)) for (const c of (Array.isArray(cells) ? cells : [cells])) {
  const t = (c.text || '').replace(/ #[0-9A-Fa-f]{6}$/, '').replace(/ \(not photographed\)$/, '');
  wanted.add(t); wanted.add(t.split(' ')[0]); wanted.add(t.replace(/-(side|front|back)$/, ''));
}
const labels = {}, from = {};
function readXml(file, source) {
  let x; try { x = fs.readFileSync(file, 'utf8'); } catch (e) { return; }
  for (const m of x.matchAll(/<([A-Za-z0-9_.\-]+?)\.label>([^<]+)<\/\1\.label>/g)) {
    const key = m[1];
    if (wanted.has(key) && !labels[key]) { labels[key] = m[2].trim(); from[key] = source; }
  }
}
function walk(dir, source, depth = 0) {
  let ents; try { ents = fs.readdirSync(dir, { withFileTypes: true }); } catch (e) { return; }
  for (const e of ents) {
    const p = path.join(dir, e.name);
    if (e.isDirectory()) { if (depth < 6) walk(p, source, depth + 1); } else if (e.name.endsWith('.xml')) readXml(p, source);
  }
}
for (const dlc of fs.readdirSync(extracted)) walk(path.join(extracted, dlc), 'game:' + dlc);
const ws = 'C:/Program Files (x86)/Steam/steamapps/workshop/content/294100';
let mods = 0;
for (const id of fs.readdirSync(ws)) {
  const roots = [path.join(ws, id, 'Languages')];
  try { for (const v of fs.readdirSync(path.join(ws, id))) if (/^\d+\.\d+$/.test(v)) roots.push(path.join(ws, id, v, 'Languages')); } catch (e) { continue; }
  for (const r of roots) {
    let langs; try { langs = fs.readdirSync(r); } catch (e) { continue; }
    for (const l of langs) if (/^French/i.test(l)) { walk(path.join(r, l), 'mod:' + id); mods++; }
  }
}
const out = Object.fromEntries(Object.keys(labels).sort().map(k => [k, labels[k]]));
fs.writeFileSync('ColonistRace/docs/catalogues/labels-fr.json', JSON.stringify(out, null, 1) + '\n');
const bySrc = {}; for (const s of Object.values(from)) bySrc[s.split(':')[0]] = (bySrc[s.split(':')[0]] || 0) + 1;
console.log(`${Object.keys(out).length} French labels for ${wanted.size} catalogue keys (${mods} mod French folders read)`, JSON.stringify(bySrc));

// Draft labels (labels-fr-draft.json): for the values that have no translation, a French label built word by word from the CamelCase of the defName, ONLY when every
// word is in the small dictionary below (colour genes only). A value with an unknown word gets no draft, so a draft is never half English. The catalogue
// shows a draft in italics, an official or mod label in plain text.
const dict = {
  black: 'noir', white: 'blanc', gray: 'gris', grey: 'gris', red: 'rouge', blue: 'bleu', green: 'vert', yellow: 'jaune', orange: 'orange', purple: 'violet', pink: 'rose',
  brown: 'brun', teal: 'sarcelle', cyan: 'cyan', magenta: 'magenta', gold: 'doré', golden: 'doré', silver: 'argent', bronze: 'bronze', pale: 'pâle', light: 'clair', dark: 'foncé',
  deep: 'profond', bright: 'vif', ice: 'glace', jade: 'jade', sapphire: 'saphir', rosey: 'rose', lavender: 'lavande', lilac: 'lilas', mint: 'menthe', cool: 'frais', warm: 'chaud',
  sky: 'ciel', navy: 'marine', olive: 'olive', peach: 'pêche', cherry: 'cerise', crimson: 'cramoisi', azure: 'azur', fiery: 'ardent', maroon: 'bordeaux', verdant: 'verdoyant',
  violet: 'violet', blonde: 'blond', sandy: 'sable', snow: 'neige', ink: 'encre', mid: 'moyen', slate: 'ardoise', ruby: 'rubis', emerald: 'émeraude', amber: 'ambre', coral: 'corail',
  ivory: 'ivoire', cream: 'crème', copper: 'cuivre', rust: 'rouille', charcoal: 'charbon', ebony: 'ébène', tan: 'hâlé', beige: 'beige', turquoise: 'turquoise', indigo: 'indigo',
  lime: 'citron vert', plum: 'prune', rose: 'rose', wine: 'vin', sand: 'sable', stone: 'pierre', ash: 'cendre', smoke: 'fumée', steel: 'acier', midnight: 'minuit', forest: 'forêt',
  mouth: 'bouche', brow: 'sourcil', brows: 'sourcils', lid: 'paupière', lids: 'paupières', eye: 'œil', eyes: 'yeux', skin: 'peau', hair: 'cheveux', head: 'tête', face: 'visage',
  lips: 'lèvres', lip: 'lèvre', smile: 'sourire', big: 'grand', small: 'petit', tiny: 'minuscule', simple: 'simple', frown: 'moue', grin: 'grand sourire', smirk: 'sourire en coin',
  worried: 'inquiet', sad: 'triste', scowl: 'air renfrogne', smug: 'suffisant', little: 'petit', normal: 'normal', none: 'aucun', subtle: 'discret', male: 'homme', female: 'femme',
  thick: 'épais', thin: 'fin', even: 'régulier', raised: 'relevé', square: 'carré', triangle: 'triangle', round: 'rond', wide: 'large', narrow: 'étroit', long: 'long', short: 'court',
  sleepy: 'endormi', cheerful: 'joyeux', flirty: 'charmeur', pointy: 'pointu', almond: 'amande', hardened: 'endurci', flashy: 'voyant', shy: 'timide', closed: 'fermé', open: 'ouvert',
  freckles: 'taches de rousseur', furrows: 'sillons', decrepit: 'décrépit', tired: 'fatigué', left: 'gauche', right: 'droit', chin: 'menton', cheek: 'joue', cheeks: 'joues', rosy: 'rose',
  bionic: 'bionique', both: 'deux', cave: 'caverne', man: 'homme', heavy: 'lourd', jaw: 'mâchoire', gaunt: 'émacié', average: 'moyen', narrow: 'étroit',
};
const prefixWord = { skingene: 'peau', hairgene: 'cheveux', eyegene: 'yeux' };
const stripPrefix = n => n.replace(/^(GES_|GEH_|LYN_|OL_|VSTG_|AKN_|Gene_|Skin_|Hair_|Eyes?_|Mouth|Brow|Lid|Skin|Eye|Head)/, '').replace(/^(Skin_|Hair_|Eyes?_)/, '');
const draft = {};
for (const [f, cells] of Object.entries(sheets)) {
  const block = +f.slice(0, 2), kind = { 1: 'hairgene', 5: 'eyegene', 14: 'skingene' }[block];
  if (!kind) continue;   // drafts only for the colour genes (a shade and a colour: reliable); face parts would read as broken French
  for (const c of (Array.isArray(cells) ? cells : [cells])) {
    const key = (c.text || '').replace(/ #[0-9A-Fa-f]{6}$/, '').split(' ')[0];
    if (!key || labels[key] || draft[key]) continue;
    const words = stripPrefix(key).split(/[_\s]+|(?<=[a-z0-9])(?=[A-Z])/).filter(Boolean).map(w => w.toLowerCase()).filter(w => !/^\d+$/.test(w));
    if (!words.length || words.some(w => !dict[w])) continue;
    const head = prefixWord[kind] ? prefixWord[kind] + ' ' : '';
    const mod = new Set(['dark', 'light', 'deep', 'bright', 'pale', 'mid', 'sandy', 'ice', 'cool', 'warm', 'snow']);   // French puts the shade after the colour: dark black = noir foncé
    const ordered = [...words.filter(w => !mod.has(w)), ...words.filter(w => mod.has(w))];
    draft[key] = (head + ordered.map(w => dict[w]).join(' ')).replace(/^./, ch => ch.toUpperCase());
  }
}
fs.writeFileSync('ColonistRace/docs/catalogues/labels-fr-draft.json', JSON.stringify(Object.fromEntries(Object.keys(draft).sort().map(k => [k, draft[k]])), null, 1) + '\n');
console.log(Object.keys(draft).length + ' draft labels (all words in the dictionary)');
