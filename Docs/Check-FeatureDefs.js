#!/usr/bin/env node
// Pre-check of a Pickle feature BEFORE a ticket runs: every def name a scenario cites must exist in the mods of the map it will run with, and every
// @requires mod must be in the map. Written 2026-11-04 after ticket 3a0f (PickleTools) died at step 16, "no apparel 'UnderWhere_Panties' in this game", because the
// map lacked the underwear mod. It lists ALL the missing names at once, before the queue, in seconds.
//
//   node docs/Check-FeatureDefs.js --map <map path or name> --feature <file.feature> [--filter '::scenario a,::scenario b'] [--game-dir <Data folder>] [--inv <inv-check.js>]
//
// Exit 0: nothing missing. Exit 1: a def, a mod or a @requires is missing (or a mod of the map is not on disk). Exit 2: bad arguments.
// Backend "direct" (default, no inventory needed): reads the Defs of the mods of the map straight from the Workshop folder, LoadFolders v1.6 applied
// (IfModActive / IfModActiveAll / IfModNotActive evaluated against the packageIds of the map), plus the vanilla Data folders of the game. With --inv the
// def lookup is handed to Picker's inventory query (`inv-check.js <map> --game 1.6`, lines Type/defName on stdin, JSON out) once it exists.
// Defs added inside XML Patches (<value> blocks) count as present, patch conditions ignored. Not checked: defs of a mod outside the map, names built by a step at run time.
const fs = require('fs'), path = require('path'), cp = require('child_process');
const args = process.argv.slice(2);
const opt = n => { const i = args.indexOf('--' + n); return i < 0 ? null : args[i + 1]; };
const mapArg = opt('map'), featureArg = opt('feature'), filter = opt('filter'), invCheck = opt('inv');
if (!mapArg || !featureArg) { console.error('usage: node docs/Check-FeatureDefs.js --map <map> --feature <file> [--filter "::a,::b"] [--game-dir <Data>] [--inv <inv-check.js>]'); process.exit(2); }
const ROOT = path.resolve(__dirname, '..', '..');
const W = 'C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/';
const GAME = (opt('game-dir') || 'C:/Program Files (x86)/Steam/steamapps/common/RimWorld/Data').replace(/\\/g, '/');
const mapPath = fs.existsSync(mapArg) ? mapArg : path.join(ROOT, 'PickleTools/Tests/Pickle', 'wsl-deps.' + mapArg + '.map');

// What each step cites: [regex on the step text, def type, how to read the names].
const CITES = [
  [/wears "([^"]+)"/, 'ThingDef'], [/I dress "[^"]+" in "([^"]+)"/, 'ThingDef'],
  [/head type is "([^"]+)"/, 'HeadTypeDef'], [/face head shape is "([^"]+)"/, 'FacialAnimation.HeadTypeDef'],
  [/mouth is "([^"]+)"/, 'FacialAnimation.MouthTypeDef'], [/brows are "([^"]+)"/, 'FacialAnimation.BrowTypeDef'], [/lids are "([^"]+)"/, 'FacialAnimation.LidTypeDef'],
  [/eyeballs are "([^"]+)"/, 'FacialAnimation.EyeballTypeDef'], [/face skin is "([^"]+)"/, 'FacialAnimation.SkinTypeDef'],
  [/facial expression is "([^"]+)"/, 'FacialAnimation.FaceAnimationDef', s => s.split('+')],
  [/I place the decor "([^"]+)"/, 'ThingDef'], [/I lay the floor "([^"]+)"/, 'TerrainDef'],
  [/hairstyle is "([^"]+)"/, 'HairDef'], [/beard is "([^"]+)"/, 'BeardDef'],
  [/(?:face|body) tattoo is "([^"]+)"/, 'TattooDef'], [/has the gene "([^"]+)"/, 'GeneDef'],
];
const SKIP = new Set(['none', 'None']);

// 1. The map: "<packageId> <workshopId>" or "<packageId> path:<dir>".
const mods = [];
for (const raw of fs.readFileSync(mapPath, 'utf8').split(/\r?\n/)) {
  const l = raw.trim();
  if (!l || l.startsWith('#')) continue;
  const m = l.match(/^(\S+)\s+(path:)?(\S+)/);
  if (m) mods.push({ pkg: m[1], isPath: !!m[2], ref: m[3] });
}
// The mod under test: the first folder of the feature path under the protocols root (<Mod>/Tests/Pickle/...). The launcher always stages it, and a map often
// does not list it, so its own defs would all read "not found" (RetroJoyRenew, 2026-11-10). Added to the defs read, not to the map's mods.
const tested = [];
{
  const rel = path.relative(ROOT, path.resolve(featureArg)).split(path.sep).join('/').split('/');
  const about = rel.length > 2 && rel[0] !== '..' ? path.join(ROOT, rel[0], 'Mod', 'About', 'About.xml') : null;
  const pkg = about && fs.existsSync(about) ? ((fs.readFileSync(about, 'utf8').match(/<packageId>\s*([^<\s]+)\s*<\/packageId>/) || [])[1]) : null;
  if (pkg && !mods.some(m => m.pkg.toLowerCase() === pkg.toLowerCase())) tested.push({ pkg, isPath: true, ref: rel[0] + '/Mod' });
}
const active = new Set(mods.concat(tested).map(m => m.pkg.toLowerCase()));
['ludeon.rimworld', 'ludeon.rimworld.royalty', 'ludeon.rimworld.ideology', 'ludeon.rimworld.biotech', 'ludeon.rimworld.anomaly', 'ludeon.rimworld.odyssey'].forEach(p => active.add(p));

// 2. The features: the scenarios the filter keeps, their cited names and @requires.
const featureText = fs.readFileSync(featureArg, 'utf8').replace(/\r\n/g, '\n');
const featureTags = (featureText.match(/^@requires:\S+/gm) || []).map(t => t.slice(10));
const parts = featureText.split(/^\s*Scenario:/m).slice(1);
const terms = (filter || '').split(',').map(t => t.trim()).filter(Boolean).map(t => t.replace(/^.*::/, ''));
const scenarios = parts.map(p => ({ title: p.split('\n')[0].trim(), body: p })).filter(s => !terms.length || terms.some(t => s.title.includes(t)));
if (!scenarios.length) { console.error('no scenario matches the filter'); process.exit(2); }
const cited = new Map();   // "Type/defName" -> scenario titles
for (const sc of scenarios) for (const line of sc.body.split('\n')) for (const [re, type, split] of CITES) {
  const m = line.match(re); if (!m) continue;
  // a quoted argument may be a comma-joined list of def names (`I dress "X" in "Apparel_A,Apparel_B"`, `the things "A,B" ... are hidden`): each name is checked alone (Audit, 2026-11-07)
  for (const name of (split ? split(m[1]) : [m[1]]).flatMap(n => n.split(',')).map(n => n.trim()).filter(Boolean)) { if (SKIP.has(name)) continue; const k = type + '/' + name; if (!cited.has(k)) cited.set(k, new Set()); cited.get(k).add(sc.title.split(':')[0]); }
}

// 3. The defs of the mods of the map.
function loadFolders(root) {
  let lf; try { lf = fs.readFileSync(root + '/LoadFolders.xml', 'utf8'); } catch (e) { lf = null; }
  const roots = [];
  if (lf) {
    const sec = (lf.match(/<v1\.6>([\s\S]*?)<\/v1\.6>/) || lf.match(/<default>([\s\S]*?)<\/default>/) || [])[1];
    if (sec) {
      for (const m of sec.matchAll(/<li([^>]*)>([^<]*)<\/li>/g)) {
        const a = m[1], dir = m[2].trim().replace(/^\/$/, '');
        const list = n => ((a.match(new RegExp(n + '="([^"]*)"')) || [])[1] || '').split(',').map(x => x.trim().toLowerCase()).filter(Boolean);
        const any = list('IfModActive'), all = list('IfModActiveAll'), not = list('IfModNotActive');
        if (any.length && !any.some(p => active.has(p))) continue;
        if (all.length && !all.every(p => active.has(p))) continue;
        if (not.length && not.some(p => active.has(p))) continue;
        roots.push(dir ? root + '/' + dir : root);
      }
      return roots;
    }
  }
  const common = fs.existsSync(root + '/Common') ? [root + '/Common'] : [];
  const v = ['1.6', '1.5', '1.4', '1.3'].find(x => fs.existsSync(root + '/' + x));
  // Without LoadFolders.xml the game loads the mod root (its Defs folder), then Common, then the folder of the game version: the root is never left out
  // (Disco! 2436747646 keeps DSC_DiscoFloor in root Defs/ beside empty version folders; the pre-check refused a def the game loads, 2026-11-12).
  return [root].concat(common, v ? [root + '/' + v] : []);
}
function xmlFiles(d, out, depth = 0) {
  if (depth > 8) return;
  let es; try { es = fs.readdirSync(d, { withFileTypes: true }); } catch (e) { return; }
  for (const e of es) { const p = d + '/' + e.name; if (e.isDirectory()) xmlFiles(p, out, depth + 1); else if (/\.xml$/i.test(e.name)) out.push(p); }
}
const have = new Set();   // "Type/defName"
// A def is an element of <Defs> that holds a <defName> (a few simple siblings may come before it); Abstract="True" ones are left out.
function readDefsSimple(defsDir) {
  const files = []; xmlFiles(defsDir, files);
  for (const f of files) {
    let t; try { t = fs.readFileSync(f, 'utf8'); } catch (e) { continue; }
    t = t.replace(/<!--[\s\S]*?-->/g, '').replace(/<!\[CDATA\[[\s\S]*?\]\]>/g, '').replace(/<\?[\s\S]*?\?>/g, '');
    // Tag stack: a <defName> names its PARENT element, wherever defName sits among the siblings (nested elements may come before it) and at any depth (patch <value> blocks).
    const stack = [];
    for (const m of t.matchAll(/<(\/?)([A-Za-z_][\w.:-]*)\b((?:"[^"]*"|'[^']*'|[^>"'])*?)(\/?)>|([^<]+)/g)) {
      if (m[5] !== undefined) continue;
      if (m[1]) { const i = stack.map(s => s.tag).lastIndexOf(m[2]); if (i >= 0) stack.length = i; continue; }
      if (m[4]) continue;
      if (m[2] === 'defName') {
        const end = t.indexOf('</defName>', m.index);
        const parent = stack[stack.length - 1];
        if (end > 0 && parent && !/Abstract\s*=\s*["']true["']/i.test(parent.attrs)) have.add(parent.tag + '/' + t.slice(m.index + m[0].length, end).trim());
        continue;
      }
      stack.push({ tag: m[2], attrs: m[3] });
    }
  }
}
const notOnDisk = [];
for (const m of mods.concat(tested)) {
  // A numeric ref is a Workshop id; a name is a folder of the local Mods folder of the game (rjw, rjw-genes...).
  const root = m.isPath ? path.join(ROOT, m.ref).replace(/\\/g, '/') : (/^\d+$/.test(m.ref) ? W + m.ref : GAME.replace(/\/Data$/, '/Mods/') + m.ref);
  if (!fs.existsSync(root)) { notOnDisk.push(m.pkg + ' ' + m.ref); continue; }
  // Patches too: a patch may add defs inside <value> (Moving Vanilla Eyes removes the FA eyeballs and re-adds EyeThin there). Counted as present whatever the patch conditions.
  for (const r of loadFolders(root)) { readDefsSimple(r + '/Defs'); readDefsSimple(r + '/Patches'); }
}
for (const d of ['Core', 'Royalty', 'Ideology', 'Biotech', 'Anomaly', 'Odyssey']) readDefsSimple(GAME + '/' + d + '/Defs');

// 4. The verdict.
const missingDefs = [...cited.keys()].filter(k => !have.has(k));
if (invCheck) {
  // Picker's index (scripts/inv-check.mjs, 1.6 and 1.7, ~9.7k mods): Type/defName on stdin, JSON out. A cross-check of the direct reading. The index holds no mod of the local
  // Mods folder (rjw...): when the map has some, only the direct reading judges (they are listed as "local, read directly").
  // --deep (Picker, 2026-11-04): also follows the references of each cited def (apparel layers, hediffs, genes, thing categories...). `# skip-refs: <packageId>` lines of the map mute what a deliberately excluded mod would provide.
  // Not verified (Picker's limits): texture and sound files, defs created by patches, a reference to a def that exists nowhere (typo).
  const skip = fs.readFileSync(mapPath, "utf8").split(String.fromCharCode(10)).map(l => (l.match(/^#\s*skip-refs:\s*(\S+)/) || [])[1]).filter(Boolean);
  const args = [invCheck, mapPath, '--game', opt('game') || '1.6', '--deep'];
  for (const s of skip) args.push('--exclude', s);
  const r = cp.spawnSync('node', args, { input: [...cited.keys()].join(String.fromCharCode(10)), encoding: 'utf8' });
  try {
    const j = JSON.parse(r.stdout);
    const local = mods.filter(m => !m.isPath && isNaN(Number(m.ref))).map(m => m.ref);
    const unknown = (j.modsNotInventoried || []).filter(x => !local.includes(x));
    console.log('inventory: ok ' + j.ok + ', missing ' + (j.missing || []).length + (unknown.length ? ', NOT INVENTORIED ' + unknown.join(',') : '') + (local.length ? ' (local mods read directly: ' + local.join(',') + ')' : ''));
    const refs = j.missingRefs || [];
    if (refs.length) { console.log('MISSING REFERENCES of cited defs (' + refs.length + '): the map probably lacks a mod (or add `# skip-refs: <packageId>` to the map if the exclusion is wanted)'); for (const x of refs.slice(0, 40)) console.log('  ' + x.def + ' -> ' + x.ref + '   provided by ' + ((x.providers || []).join(', ') || '?')); }
    if (unknown.length || ((j.missing || []).length && !local.length) || (refs.length && !local.length)) process.exitCode = 1;
  } catch (e) { console.error('inv-check gave no JSON: ' + (r.stderr || r.stdout).slice(0, 200)); process.exit(1); }
}
const missingReq = featureTags.filter(p => !active.has(p.toLowerCase()));
let bad = 0;
console.log(`${have.size} defs read; ${path.basename(featureArg)}: ${scenarios.length} scenario(s), ${cited.size} cited def name(s), map ${path.basename(mapPath)} (${mods.length} mods)`);
if (notOnDisk.length) { bad++; console.log('MODS OF THE MAP NOT ON DISK (' + notOnDisk.length + '): ' + notOnDisk.join(', ')); }
if (missingReq.length) { bad++; console.log('@requires NOT IN THE MAP: ' + missingReq.join(', ')); }
if (missingDefs.length) {
  bad++;
  console.log('DEFS NOT FOUND IN THE MODS OF THE MAP (' + missingDefs.length + '): the map probably lacks a mod, or the name is wrong');
  for (const k of missingDefs) console.log('  ' + k + '   (' + [...cited.get(k)].slice(0, 3).join(', ') + ')');
} else console.log('all ' + cited.size + ' cited def names exist in the mods of the map');

// 5. The seeds of the pass (Tests/Pickle/config/<map name>/Mod_<folder>_<Class>.xml): each must name a mod staged by the map (a Workshop id, or local-<packageId> for a path: mod);
// the launcher refuses the run otherwise (ticket 3b11, 2026-11-04: seed Mod_3753978140_MovingVanillaEyesMod.xml in a map without Moving Vanilla Eyes).
{
  const name = path.basename(mapPath).replace(/^wsl-deps./, "").replace(/.map$/, "");
  const dir = path.join(path.dirname(mapPath), "config", name);
  const staged = new Set(mods.map(m => (m.isPath ? "local-" + m.pkg : m.ref)));
  const orphans = fs.existsSync(dir) ? fs.readdirSync(dir).filter(f => /^Mod_/.test(f)).filter(f => { const folder = f.replace(/^Mod_/, "").replace(/_[^_]*$/, ""); return !staged.has(folder); }) : [];
  if (orphans.length) { bad++; console.log("SEEDS THAT NAME NO STAGED MOD (" + orphans.length + ", config/" + name + "): " + orphans.join(", ")); }
}
process.exit(bad || process.exitCode ? 1 : 0);
