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
// Not checked: defs created by patches (XML Patches), defs of a mod outside the map, names built by a step at run time.
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
const active = new Set(mods.map(m => m.pkg.toLowerCase()));
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
  for (const name of (split ? split(m[1]) : [m[1]])) { if (SKIP.has(name)) continue; const k = type + '/' + name; if (!cited.has(k)) cited.set(k, new Set()); cited.get(k).add(sc.title.split(':')[0]); }
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
  const out = common.concat(v ? [root + '/' + v] : []);
  return out.length ? out : [root];
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
    t = t.replace(/<!--[\s\S]*?-->/g, '');
    for (const m of t.matchAll(/<([A-Za-z_][\w.:-]*)\b([^>]*)>\s*(?:<[^>]*>[^<]*<\/[^>]*>\s*)*?<defName>([^<]*)<\/defName>/g)) {
      if (/Abstract="True"/i.test(m[2])) continue;
      have.add(m[1] + '/' + m[3].trim());
    }
  }
}
const notOnDisk = [];
for (const m of mods) {
  // A numeric ref is a Workshop id; a name is a folder of the local Mods folder of the game (rjw, rjw-genes...).
  const root = m.isPath ? path.join(ROOT, m.ref).replace(/\\/g, '/') : (/^\d+$/.test(m.ref) ? W + m.ref : GAME.replace(/\/Data$/, '/Mods/') + m.ref);
  if (!fs.existsSync(root)) { notOnDisk.push(m.pkg + ' ' + m.ref); continue; }
  for (const r of loadFolders(root)) readDefsSimple(r + '/Defs');
}
for (const d of ['Core', 'Royalty', 'Ideology', 'Biotech', 'Anomaly', 'Odyssey']) readDefsSimple(GAME + '/' + d + '/Defs');

// 4. The verdict.
const missingDefs = [...cited.keys()].filter(k => !have.has(k));
if (invCheck) {
  // Picker's inventory: Type/defName on stdin, JSON out; trusted for the verdict when given.
  const r = cp.spawnSync('node', [invCheck, mapPath, '--game', '1.6'], { input: [...cited.keys()].join('\n'), encoding: 'utf8' });
  try { const j = JSON.parse(r.stdout); console.log('inventory: ok ' + j.ok + ', missing ' + (j.missing || []).length + (j.modsNotInventoried && j.modsNotInventoried.length ? ', not inventoried ' + j.modsNotInventoried.join(',') : '')); if ((j.missing || []).length || (j.modsNotInventoried || []).length) process.exitCode = 1; } catch (e) { console.error('inv-check gave no JSON: ' + (r.stderr || r.stdout).slice(0, 200)); process.exit(1); }
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
process.exit(bad ? 1 : 0);
