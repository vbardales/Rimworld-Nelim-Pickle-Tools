// Terrain catalogue of one mod (registry capture queue, docs/registre/mods-capture.tsv).
// Reads the content sheet ../rimworld-mod-inventory/<key>.json.gz, takes the concrete TerrainDefs and writes
//   Tests/Pickle/Mod/Pickle/Features/pickletools-terrain-<key>.feature  (one scenario per shot of PER floors)
//   Tests/Pickle/wsl-deps.terrain-<key>.map                            (tools + the mod by its Workshop id)
//   Tests/Pickle/terrain-<key>.key.md                                  (which floor is where in each shot)
// Usage: node Docs/Generate-TerrainGallery.js <workshopId> [--per 18] [--shots N] [--from K]   (--from K starts at shot K, 1-based; K>1 writes pickletools-terrainmore-<key>-from<K>.feature and terrain-<key>-from<K>.key.md and leaves the first files, the map and the layout alone, so a ticket already filed on them keeps its tree)
// A floor is a 2 x 2 block, 6 per row. The grid starts at (140, 148) of "test-colony".
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

const args = process.argv.slice(2);
const key = args.find(a => /^\d+$/.test(a));
if (!key) { console.error('usage: node Docs/Generate-TerrainGallery.js <workshopId> [--per 18] [--shots N]'); process.exit(2); }
const opt = (n, d) => { const i = args.indexOf(n); return i >= 0 ? Number(args[i + 1]) : d; };
const ROOT = opt('--root', 3.8);  // root size of every shot: 3.5 clips the first block of a 6-wide row (12 cells x 154 px + the half-cell shift); owner 2026-11-18 asked 3 to 3.5 per cell
const BASE = args.includes('--base') ? args[args.indexOf('--base') + 1] : 'Concrete'; // ground under the swatches: a contrasting base (Soil) for light floors such as Poured Concrete (Cat, 2026-11-20: a concrete floor on Concrete was unreadable)
const PER = opt('--per', 18), SHOTS = opt('--shots', 0), FROM = opt('--from', 1);
const root = path.resolve(__dirname, '..');
const sheet = path.resolve(root, '..', '..', 'rimworld-mod-inventory', key + '.json.gz');
if (!fs.existsSync(sheet)) { console.error('no content sheet: ' + sheet); process.exit(1); }

const j = JSON.parse(zlib.gunzipSync(fs.readFileSync(sheet)));
const defs = j.defs.filter(d => d.t === 'TerrainDef' && d.n);
// An abstract def is only named as a parent by another def: drop those.
const parents = new Set(defs.flatMap(d => (d.p || []).map(p => p.Name)));
let names = [...new Set(defs.map(d => d.n))].filter(n => !parents.has(n)).sort();
// A TerrainDef with MayRequire exists only when that other mod is loaded (Alpha Memes, Biomes Islands: Nautian and Greekcore tickets 2306 and 2026-11-17): left out, listed on stdout.
{
  const modDir = 'C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/' + key;
  const walkm = d => fs.existsSync(d) ? fs.readdirSync(d, { withFileTypes: true }).flatMap(e => e.isDirectory() ? walkm(d + '/' + e.name) : (/\.xml$/i.test(e.name) ? [d + '/' + e.name] : [])) : [];
  const gated = new Set();
  for (const f of walkm(modDir).filter(f => /\/Defs\//.test(f))) {
    const t = fs.readFileSync(f, 'utf8').replace(/<!--[\s\S]*?-->/g, '');
    for (const m of t.matchAll(/<TerrainDef[^>]*MayRequire="[^"]*"[^>]*>\s*<defName>([^<]*)<\/defName>/g)) gated.add(m[1]);
  }
  const dropped = names.filter(n => gated.has(n));
  if (dropped.length) { console.log(`needs another mod (MayRequire, ${dropped.length}, not photographed): ${dropped.join(', ')}`); names = names.filter(n => !gated.has(n)); }
}
// --only-log <Player.log>: keep the floors the game really loaded, read from the [terrain-stats] lines of a run (a def that needs another mod, such as ATH Draconic's Pristine
// Limestone floors, is in the content sheet but not in the game, and its scenario stops at "no terrain def"; ticket e3ba, 2026-11-12). The others are listed on stdout.
const onlyLog = args.includes('--only-log') ? args[args.indexOf('--only-log') + 1] : null;
if (onlyLog) {
  const have = new Set();
  for (const l of fs.readFileSync(onlyLog, 'latin1').split(/\r?\n/)) {
    const m = l.replace(/<[^>]*>/g, '').match(/\[terrain-stats\] (\{.*\})\s*$/);
    if (m) { try { have.add(JSON.parse(m[1]).defName); } catch (e) { /* a broken line is skipped */ } }
  }
  const lost = names.filter(n => !have.has(n));
  console.log(`not in the game (${lost.length}, not photographed): ${lost.join(', ')}`);
  names = names.filter(n => have.has(n));
}
if (!names.length) { console.error('no concrete TerrainDef in ' + key); process.exit(1); }

const COLS = 6, X0 = 140, Z0 = 148;
const shots = [];
for (let i = 0; i < names.length; i += PER) shots.push(names.slice(i, i + PER));
const used = SHOTS > 0 ? shots.slice(FROM - 1, FROM - 1 + SHOTS) : shots.slice(FROM - 1);
const rows = Math.ceil(PER / COLS);
const x1 = X0 + COLS * 2 - 1, z1 = Z0 + rows * 2 - 1;
const cx = X0 + COLS, cz = Z0 + rows; // camera cell: the world centre is the middle of that cell, half a cell right of and above the grid middle

let f = `# Terrain catalogue of workshop mod ${key} (${names.length} floors, ${shots.length} shots of up to ${PER}), generated by Docs/Generate-TerrainGallery.js. Do not edit by hand.\n`;
f += `# A floor is a 2 x 2 block, ${COLS} per row from the north-west corner (${X0}, ${Z0}); the key of each shot is Tests/Pickle/terrain-${key}.key.md.\n`;
f += `@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.stagedecor\nFeature: Terrain catalogue ${key}${FROM > 1 ? ' from shot ' + FROM : ''}\n\n`;
let k = `# Terrain key, workshop mod ${key}\n\nFloor positions: block column from the west (1..${COLS}), block row from the south... listed as row 1 = north.\n\n`;
used.forEach((shot, si) => {
  const n = String(FROM + si).padStart(2, '0');
  f += `  Scenario: terrain-${key}-${n}: floors ${(FROM - 1 + si) * PER + 1} to ${(FROM - 1 + si) * PER + shot.length}\n`;
  f += `    Given the save "test-colony" is loaded\n    And game speed is paused\n`;
  f += `    And Nelim's Pickle Tools: the eclipse of the map is ended\n`;
  if (si === 0) f += `    And Nelim's Pickle Tools: the terrains of the mod "${j.mod.PackageId}" are logged
`;
  f += `    And Nelim's Pickle Tools: the area from (${cx - 10}, ${cz - 6}) to (${cx + 10}, ${cz + 6}) is cleared\n`; // the whole ground: no rock left in frame
  f += `    And Nelim's Pickle Tools: I lay the floor "${BASE}" from (${cx - 10}, ${cz - 6}) to (${cx + 10}, ${cz + 6})
`; // one uniform ground under the whole frame (the test-colony ground is split into sand and dark stone)
  k += `## Shot ${n}\n\n| row | col | floor |\n|---|---|---|\n`;
  shot.forEach((name, i) => {
    const c = i % COLS, r = Math.floor(i / COLS);
    const ax = X0 + c * 2, az = z1 - 1 - r * 2;
    f += `    And Nelim's Pickle Tools: I lay the floor "${name}" from (${ax}, ${az}) to (${ax + 1}, ${az + 1})\n`;
    k += `| ${r + 1} | ${c + 1} | ${name} |\n`;
  });
  f += `    And I set the hour to 12\n    And I set the weather to "Clear"\n    And I wait 60 ticks\n`;
  f += `    And Nelim's Pickle Tools: studio presentation mode is enabled\n`;
  // a shot with fewer floors than a full grid is framed on the blocks it uses, zoomed so that each cell stays large (Cat, 2026-11-20)
  const cu = Math.min(shot.length, COLS), ru = Math.ceil(shot.length / COLS);
  const fcx = X0 + cu, fcz = z1 - ru + 1, froot = shot.length < PER ? Math.min(ROOT, Math.max(ru, cu * 2 / 3.56) + 1) : ROOT;
  f += `    And Nelim's Pickle Tools: I frame the area centred on (${fcx}, ${fcz}) at root size ${Number(froot.toFixed(1))}\n`;
  f += `    And I take a screenshot "terrain-${key}-${n}"\n    Then no errors were logged\n\n`;
  k += '\n';
});

const tools = ['screenshotstudio', 'camerazoom', 'stagedecor', 'savesteps', 'colonistrace', 'clearscreen'];
let m = `# Terrain catalogue of workshop mod ${key}, generated by Docs/Generate-TerrainGallery.js.\nbrrainz.harmony 2009463077\n`;
m += tools.map(t => `nelim.pickletools.${t} path:PickleTools/${{ screenshotstudio: 'ScreenshotStudio', camerazoom: 'CameraZoom', stagedecor: 'StageDecor', savesteps: 'SaveSteps', colonistrace: 'ColonistRace', clearscreen: 'ClearScreen' }[t]}/Mod`).join('\n') + '\n';
m += `nelim.pickletools   path:PickleTools/Tests/Pickle/StandaloneBase/Mod\n${j.mod.PackageId} ${key}\n`;

const tp = path.join(root, 'Tests', 'Pickle');
const more = FROM > 1;
fs.writeFileSync(path.join(tp, "Mod", "Pickle", "Features", more ? `pickletools-terrainmore-${key}-from${FROM}.feature` : `pickletools-terrain-${key}.feature`), f);
if (!more) fs.writeFileSync(path.join(tp, `wsl-deps.terrain-${key}.map`), m);
fs.writeFileSync(path.join(tp, more ? `terrain-${key}-from${FROM}.key.md` : `terrain-${key}.key.md`), k);
if (!more) fs.writeFileSync(path.join(tp, `terrain-${key}.layout.json`), JSON.stringify({ cols: COLS, rows, blockPx: 2 * 1080 / (2 * ROOT), pxPerCell: 1080 / (2 * ROOT), x0px: 960 - (COLS + 0.5) * 1080 / (2 * ROOT), y0px: 540 - (rows - 0.5) * 1080 / (2 * ROOT), note: "x0px,y0px = top-left pixel of the grid on a 1920x1080 shot, camera root size 4 centred on cell (X0+COLS, Z0+rows)", X0, Z0, per: PER, packageId: j.mod.PackageId, name: j.mod.Name }));
console.log(`${key}: ${names.length} floors, ${shots.length} shots, wrote ${used.length}`);
