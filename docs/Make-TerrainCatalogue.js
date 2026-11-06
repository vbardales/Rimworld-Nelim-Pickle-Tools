// Cuts the terrain shots of a mod into one picture per floor and writes metadata.json, in the PRIVATE catalogue store (never in this public repo: the textures
// belong to the mods' authors; Audit 2026-11-06). Store: <rimworld-folder>/../rimworld-catalogue (sibling of rimworld-mod-inventory), terrain/<workshopId>/.
// Usage: node Docs/Make-TerrainCatalogue.js <workshopId> <shotsDir>[,<shotsDir>...] [--date YYYY-MM-DD] [--store <path>]
// Reads Tests/Pickle/terrain-<key>.key.md (which floor is in which block of which shot) and terrain-<key>.layout.json (where the grid is on the 1920 x 1080 shot),
// the screenshots manual--terrain-<key>-<NN>--step0.png in Tests/Pickle/Inbox/<shotsDir>/screenshots, and the [terrain-stats] lines of Player.log in those dirs
// (what the game loaded: label, description, cost, beauty, fertility...), the content sheet of the mod as the fallback.
// Writes terrain/<key>/<defName>.webp (block 270 px minus a 6 px inset = 258 px) and terrain/<key>/metadata.json (one row per floor).
const fs = require('fs'), path = require('path'), zlib = require('zlib'), cp = require('child_process');
const args = process.argv.slice(2);
const key = args.find(a => /^\d+$/.test(a));
const dirs = (args[args.indexOf(key) + 1] || '').split(',').filter(Boolean);
const opt = n => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : null; };
const date = opt('--date') || new Date().toISOString().slice(0, 10);
if (!key || !dirs.length) { console.error('usage: node Docs/Make-TerrainCatalogue.js <workshopId> <dir,dir> [--date D] [--store P]'); process.exit(2); }
const root = path.resolve(__dirname, '..');
const store = path.resolve(opt('--store') || path.join(root, '..', '..', 'rimworld-catalogue'));
const inbox = path.join(root, 'Tests', 'Pickle', 'Inbox');
const inv = JSON.parse(zlib.gunzipSync(fs.readFileSync(path.resolve(root, '..', '..', 'rimworld-mod-inventory', key + '.json.gz'))));
const defs = Object.fromEntries(inv.defs.filter(d => d.t === 'TerrainDef').map(d => [d.n, d]));
const layout = JSON.parse(fs.readFileSync(path.join(root, 'Tests', 'Pickle', `terrain-${key}.layout.json`), 'utf8'));
const keymd = fs.readFileSync(path.join(root, 'Tests', 'Pickle', `terrain-${key}.key.md`), 'utf8').split(/\r?\n/);
// the game's own stats
const stats = {};
for (const d of dirs) {
  const log = path.join(inbox, d, 'Player.log');
  if (!fs.existsSync(log)) continue;
  for (const l of fs.readFileSync(log, 'latin1').split(/\r?\n/)) {
    const m = l.replace(/<[^>]*>/g, '').match(/\[terrain-stats\] (\{.*\})\s*$/);
    if (m) { try { const o = JSON.parse(Buffer.from(m[1], 'latin1').toString('utf8')); stats[o.defName] = o; } catch (e) { /* a broken line is skipped */ } }
  }
}
const out = path.join(store, 'terrain', key);
fs.mkdirSync(out, { recursive: true });
const B = layout.blockPx, INSET = 6, SIZE = B - 2 * INSET;
const rows = [];
let shot = null, missing = 0;
for (const line of keymd) {
  const h = line.match(/^## Shot (\d+)/); if (h) { shot = h[1]; continue; }
  const m = line.match(/^\| (\d+) \| (\d+) \| (.+) \|$/); if (!m || !shot) continue;
  const [, r, c, name] = m;
  const png = dirs.map(d => path.join(inbox, d, 'screenshots', `manual--terrain-${key}-${shot}--step0.png`)).find(p => fs.existsSync(p));
  if (!png) { missing++; continue; }
  const file = name.replace(/[^A-Za-z0-9_.-]/g, '_') + '.webp';
  const x = Math.round(layout.x0px + (Number(c) - 1) * B + INSET), y = Math.round(layout.y0px + (Number(r) - 1) * B + INSET);
  const res = cp.spawnSync('ffmpeg', ['-y', '-loglevel', 'error', '-i', png, '-vf', `crop=${SIZE}:${SIZE}:${x}:${y}`, '-frames:v', '1', '-quality', '85', path.join(out, file)]);
  if (res.status !== 0) { console.error('ffmpeg failed for ' + name + ': ' + res.stderr); continue; }
  const d = defs[name] || {}, s = stats[name] || null;
  rows.push({ key: `${key}:${name}`, defName: name, type: 'TerrainDef', mod: inv.mod.Name, packageId: inv.mod.PackageId, workshopId: key,
    image: file, sheet: path.basename(png), cell: `shot ${shot} row ${r} col ${c}`, capturedAt: date, cropPx: SIZE,
    game: s, sheetFallback: { parents: (d.p || []).map(p => p.Name), file: d.f || '' } });
}
fs.writeFileSync(path.join(out, 'metadata.json'), JSON.stringify({ schema: 1, type: 'TerrainDef', mod: inv.mod.Name, packageId: inv.mod.PackageId, workshopId: key, capturedAt: date, items: rows }, null, 1));
console.log(`${key}: ${rows.length} floors cut into ${out}; ${Object.keys(stats).length} with game stats; ${missing} without a shot`);
