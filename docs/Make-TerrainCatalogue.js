// Cuts the terrain shots of a mod into one picture per floor and writes the metadata rows (registry capture queue, catalogue docs/catalogue/).
// Usage: node Docs/Make-TerrainCatalogue.js <workshopId> <shotsDir>[,<shotsDir>...] [--date YYYY-MM-DD]
// Reads Tests/Pickle/terrain-<key>.key.md (which floor is in which block) and the screenshots manual--terrain-<key>-<NN>--step0.png in the shots dirs
// (each relative to PickleTools/Tests/Pickle/Inbox/, "screenshots" subfolder). Layout of the shots written by Generate-TerrainGallery.js:
// 8 blocks per row, each block 2 x 2 cells, camera root size 8 on 1920 x 1080 = 67.5 px per cell, the grid starts at px (395, 170).
// Writes docs/catalogue/terrain/<key>/<defName>.webp (inset 3 px, 129 px square) and docs/catalogue/terrain.tsv (rows of this mod replaced).
const fs = require('fs'), path = require('path'), zlib = require('zlib'), cp = require('child_process');
const args = process.argv.slice(2);
const key = args.find(a => /^\d+$/.test(a));
const dirs = (args[args.indexOf(key) + 1] || '').split(',').filter(Boolean);
const di = args.indexOf('--date'); const date = di >= 0 ? args[di + 1] : new Date().toISOString().slice(0, 10);
if (!key || !dirs.length) { console.error('usage: node Docs/Make-TerrainCatalogue.js <workshopId> <dir,dir> [--date D]'); process.exit(2); }
const root = path.resolve(__dirname, '..');
const inbox = path.join(root, 'Tests', 'Pickle', 'Inbox');
const sheet = path.resolve(root, '..', '..', 'rimworld-mod-inventory', key + '.json.gz');
const inv = JSON.parse(zlib.gunzipSync(fs.readFileSync(sheet)));
const defs = Object.fromEntries(inv.defs.filter(d => d.t === 'TerrainDef').map(d => [d.n, d]));
const keymd = fs.readFileSync(path.join(root, 'Tests', 'Pickle', `terrain-${key}.key.md`), 'utf8').split(/\r?\n/);
const out = path.join(root, 'docs', 'catalogue', 'terrain', key);
fs.mkdirSync(out, { recursive: true });
const B = 135, X0 = 395, Y0 = 170, INSET = 3, SIZE = B - 2 * INSET;
const rows = [];
let shot = null;
for (const line of keymd) {
  const h = line.match(/^## Shot (\d+)/); if (h) { shot = h[1]; continue; }
  const m = line.match(/^\| (\d+) \| (\d+) \| (.+) \|$/); if (!m || !shot) continue;
  const [, r, c, name] = m;
  const png = dirs.map(d => path.join(inbox, d, 'screenshots', `manual--terrain-${key}-${shot}--step0.png`)).find(p => fs.existsSync(p));
  if (!png) { console.error('no shot ' + shot); continue; }
  const file = name.replace(/[^A-Za-z0-9_.-]/g, '_') + '.webp';
  const x = X0 + (Number(c) - 1) * B + INSET, y = Y0 + (Number(r) - 1) * B + INSET;
  const res = cp.spawnSync('ffmpeg', ['-y', '-loglevel', 'error', '-i', png, '-vf', `crop=${SIZE}:${SIZE}:${x}:${y}`, '-frames:v', '1', '-quality', '80', path.join(out, file)]);
  if (res.status !== 0) { console.error('ffmpeg failed for ' + name + ': ' + res.stderr); continue; }
  const d = defs[name] || {};
  rows.push([`${key}:${name}`, name, inv.mod.Name, inv.mod.PackageId, key, 'TerrainDef', (d.p || []).map(p => p.Name).join('>'), d.f || '', `terrain/${key}/${file}`, `${path.basename(png)}`, `shot ${shot} row ${r} col ${c}`, date, '']);
}
const tsvPath = path.join(root, 'docs', 'catalogue', 'terrain.tsv');
const head = ['key', 'defName', 'mod', 'packageId', 'workshopId', 'type', 'parents', 'source_file', 'image', 'sheet', 'cell', 'captured_at', 'note'];
let kept = [];
if (fs.existsSync(tsvPath)) kept = fs.readFileSync(tsvPath, 'utf8').split(/\r?\n/).slice(1).filter(l => l && !l.startsWith(key + ':'));
fs.writeFileSync(tsvPath, [head.join('\t'), ...kept, ...rows.map(r => r.join('\t'))].join('\n') + '\n');
console.log(`${key}: ${rows.length} floors cut into ${out}`);
