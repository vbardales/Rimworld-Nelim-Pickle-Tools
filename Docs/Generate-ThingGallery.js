// Thing catalogue of one mod (registry capture queue, docs/inventory/mods-capture.tsv): buildings, items (weapons, resources) and plants laid on a grid on the
// "test-colony" map, one scenario per shot. Generic: any mod that is not a terrain mod (Generate-TerrainGallery.js) and not a clothing mod (Generate-ClothesGallery.js,
// apparel is photographed on Nelim). Reads the content sheet ../../rimworld-mod-inventory/<key>.json.gz, classifies each concrete ThingDef by its parent chain and writes
//   Tests/Pickle/Mod/Pickle/Features/pickletools-things-<key>[-<group>][-from<K>].feature   (one scenario per shot)
//   Tests/Pickle/wsl-deps.things-<key>.map                                                    (tools + the mod by its Workshop id; hard dependencies of the mod
//                                                                                              are staged by the staging from its About.xml, a missing id goes in
//                                                                                              the mod's own wsl-ids.map or the shared table)
//   Tests/Pickle/things-<key>.key.md                                                          (which def is in which cell of each shot)
// Usage: node Docs/Generate-ThingGallery.js <workshopId> --group building|item|plant|apparel|style [--per N] [--shots N] [--from K] [--list] [--dep <packageId>:<workshopId>]...
//   --dep (repeatable) stages a hard dependency the staging does not resolve by itself (Ratkin Knights+ 3394862242 needs --dep bbb.ratkinweapon.morefailure:2779404660
//   --dep Solaris.RatkinRaceMod:1578693166 --dep erdelf.HumanoidAlienRaces:839005762: without them its DLL fails to load and the first step times out, ticket 8c99).
//   --list prints the classification (group, count, first names) and writes nothing.
// Groups: building (BuildingBase ancestor; 4 cells apart, facing north), item (weapons, resources and other ground items, 3 cells apart), plant (PlantBase ancestor, 3 cells apart,
// fully grown). Skipped on purpose: motes, projectiles, ethereal things, skyfallers, pawn races (a pawn is photographed by its own catalogue), apparel (-> Generate-ClothesGallery.js).
// A def that does not draw (hidden, no graphic) still gets its cell: the shot shows an empty block, which is a result. Run order per mod: --list, then one small ticket of 1 shot per
// group (the exploration, to check the framing and the staging), then the rest in tickets of about 10 shots (docs capture queue rules). Not played when written.
const fs = require('fs');
const path = require('path');
const zlib = require('zlib');

const args = process.argv.slice(2);
const key = args.find(a => /^\d+$/.test(a));
const opt = (n, d) => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : d; };
if (!key) { console.error('usage: node Docs/Generate-ThingGallery.js <workshopId> --group building|item|plant [--per N] [--shots N] [--from K] [--list]'); process.exit(2); }
const group = opt('--group', '');
const root = path.resolve(__dirname, '..');
const sheet = path.resolve(root, '..', '..', 'rimworld-mod-inventory', key + '.json.gz');
if (!fs.existsSync(sheet)) { console.error('no content sheet: ' + sheet); process.exit(1); }
const j = JSON.parse(zlib.gunzipSync(fs.readFileSync(sheet)));

// Defs in a folder the mod loads only IfModActive (LoadFolders.xml of the Workshop copy, game version 1.6) belong to an optional integration: they are not part of the mod's own
// catalogue and would fail with "no ThingDef named" when the other mod is not staged (RKK_CursedRetinueBow, ticket d631). They are listed apart, not photographed.
const lf = 'C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/' + key + '/LoadFolders.xml';
const conditional = [];
if (fs.existsSync(lf)) {
  const x = fs.readFileSync(lf, 'utf8');
  const v = (x.match(/<v1\.6>[\s\S]*?<\/v1\.6>/) || [''])[0];
  for (const m of v.matchAll(/<li IfModActive="([^"]+)">([^<]+)<\/li>/g)) conditional.push({ mod: m[1], folder: m[2].replace(/^\/+|\/+$/g, '') + '/' });
}
const condOf = d => conditional.find(c => (d.f || '').replace(/\\/g, '/').startsWith(c.folder));
const defs = j.defs.filter(d => d.t === 'ThingDef' && d.n && !condOf(d));
const apart = j.defs.filter(d => d.t === 'ThingDef' && d.n && condOf(d));
if (apart.length) console.log('conditional (IfModActive), not photographed: ' + apart.length + ' defs: ' + [...new Set(apart.map(d => condOf(d).mod))].join(', '));
const parentNames = new Set(defs.flatMap(d => (d.p || []).map(p => p.Name)));
const chain = d => (d.p || []).map(p => p.Name).join('>');
const classify = d => {
  const c = chain(d);
  if (/Mote|Fleck|Bullet|Projectile|Skyfaller|Ethereal|Filth|Gas/i.test(c) || /^(Bullet|Mote|Fleck)/i.test(d.n)) return 'skip';
  if (/AnimalThingBase|BasePawn|Race\b/.test(c) || /Race$/.test(d.n)) return 'skip';
  if (/Apparel|Hat/i.test(c) || /(Helm|Helmet|Hood)$/i.test(d.n)) return 'apparel';
  if (/PlantBase|PlantNonEdible/i.test(c)) return 'plant';
  if (/BuildingBase|FurnitureBase|BedBase|DoorBase|BenchBase|SteleBase/.test(c)) return 'building';
  if (/Weapon|Gun|Melee|ResourceBase|Item|Meal|Drug/i.test(c)) return 'item';
  return 'other';
};
const by = {};
for (const d of defs) { if (parentNames.has(d.n)) continue; (by[classify(d)] = by[classify(d)] || []).push(d.n); }
for (const g of Object.keys(by)) by[g] = [...new Set(by[g])].sort();
if (args.includes('--list') || !group) {
  for (const [g, l] of Object.entries(by)) console.log(`${g}: ${l.length}  ${l.slice(0, 6).join(', ')}`);
  process.exit(0);
}
// group style: the (thing, style) pairs of the mod's StyleCategoryDefs (Ideology styles of vanilla things), each placed with its style by StageDecor ("I place the decor ... with the style ...").
let names = by[group] || [];
if (group === 'style') {
  const dir = 'C:/Program Files (x86)/Steam/steamapps/workshop/content/294100/' + key + '/Defs';
  const walkx = d => fs.readdirSync(d, { withFileTypes: true }).flatMap(e => e.isDirectory() ? walkx(d + '/' + e.name) : (/\.xml$/i.test(e.name) ? [d + '/' + e.name] : []));
  names = [];
  for (const f of walkx(dir)) {
    const t = fs.readFileSync(f, 'utf8').replace(/<!--[\s\S]*?-->/g, '');
    for (const m of t.matchAll(/<li>\s*<thingDef>([^<]*)<\/thingDef>\s*<styleDef>([^<]*)<\/styleDef>/g)) names.push(m[1] + '|' + m[2]);
  }
  names = [...new Set(names)];
}
if (!names.length) { console.error('no ' + group + ' in ' + key); process.exit(1); }

const PITCH = group === 'style' ? 5 : group === 'building' ? 4 : 3;
const COLS = 5, X0 = 140, Z0 = 148;
const PER = Number(opt('--per', group === 'building' ? 10 : 15)), SHOTS = Number(opt('--shots', 0)), FROM = Number(opt('--from', 1));
const rows = Math.ceil(PER / COLS);
const wCells = COLS * PITCH, hCells = rows * PITCH;
const x1 = X0 + wCells - 1, z1 = Z0 + hCells - 1;
const cx = Math.round(X0 + wCells / 2), cz = Math.round(Z0 + hCells / 2); // the framing step takes whole cells ({int}): a .5 centre was an undefined step (ticket f4cd)
const size = Math.max(hCells / 2, wCells / 3.56) + 1; // root size that holds the grid with a margin (1080p frame: 2N cells tall, about 3.56N wide)

const shots = [];
for (let i = 0; i < names.length; i += PER) shots.push(names.slice(i, i + PER));
const used = SHOTS > 0 ? shots.slice(FROM - 1, FROM - 1 + SHOTS) : shots.slice(FROM - 1);
const tag = `things-${key}-${group}`;
let f = `# ${group} catalogue of workshop mod ${key} (${names.length} defs, ${shots.length} shots of up to ${PER}), generated by Docs/Generate-ThingGallery.js. Do not edit by hand.\n`;
f += `# A def sits at the centre of its ${PITCH} x ${PITCH} cell, ${COLS} per row from the north-west corner (${X0}, ${Z0}); the key of each shot is Tests/Pickle/things-${key}-${group}.key.md.\n`;
f += `@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.stagedecor\nFeature: ${group} catalogue ${key}${FROM > 1 ? ' from shot ' + FROM : ''}\n\n`;
let k = `# ${group} key, workshop mod ${key}\n\nCell = the ${PITCH} x ${PITCH} block, row 1 = north.\n\n`;
used.forEach((shot, si) => {
  const n = String(FROM + si).padStart(2, '0');
  f += `  Scenario: ${tag}-${n}: defs ${(FROM - 1 + si) * PER + 1} to ${(FROM - 1 + si) * PER + shot.length}\n`;
  f += `    Given the save "test-colony" is loaded\n    And game speed is paused\n`;
  f += `    And Nelim's Pickle Tools: the eclipse of the map is ended\n`;
  f += `    And Nelim's Pickle Tools: the area from (${X0}, ${Z0}) to (${x1}, ${z1}) is cleared\n`;
  k += `## Shot ${n}\n\n| row | col | def |\n|---|---|---|\n`;
  shot.forEach((name, i) => {
    const c = i % COLS, r = Math.floor(i / COLS);
    const ax = X0 + c * PITCH + Math.floor(PITCH / 2), az = z1 - Math.floor(PITCH / 2) - r * PITCH;
    if (group === 'building') f += `    And Nelim's Pickle Tools: the building "${name}" is spawned at (${ax}, ${az}) facing south\n`;
    else if (group === 'style') { const [th, st] = name.split('|'); f += `    And Nelim's Pickle Tools: I place the decor "${th}" with the style "${st}" at (${ax}, ${az})
`; }
    else if (group === 'plant') f += `    And Nelim's Pickle Tools: I place the decor "${name}" at (${ax}, ${az}) fully grown\n`;
    else f += `    And Nelim's Pickle Tools: 1 of the item "${name}" are spawned at (${ax}, ${az})\n`;
    k += `| ${r + 1} | ${c + 1} | ${name} |\n`;
  });
  f += `    And I set the hour to 12\n    And I set the weather to "Clear"\n    And I wait 60 ticks\n`;
  f += `    And Nelim's Pickle Tools: studio presentation mode is enabled\n`;
  f += `    And Nelim's Pickle Tools: I frame the area centred on (${cx}, ${cz}) at root size ${size.toFixed(1)}\n`;
  f += `    And I take a screenshot "${tag}-${n}"\n    Then no errors were logged\n\n`;
  k += '\n';
});

const tools = { screenshotstudio: 'ScreenshotStudio', camerazoom: 'CameraZoom', stagedecor: 'StageDecor', savesteps: 'SaveSteps', colonistrace: 'ColonistRace', clearscreen: 'ClearScreen' };
let m = `# Thing catalogue of workshop mod ${key}, generated by Docs/Generate-ThingGallery.js.\nbrrainz.harmony 2009463077\n`;
m += Object.entries(tools).map(([t, dir]) => `nelim.pickletools.${t} path:PickleTools/${dir}/Mod`).join('\n') + '\n';
m += args.flatMap((a, i) => (a === '--dep' ? [args[i + 1].replace(':', ' ') + '\n'] : [])).join('');
m += `nelim.pickletools   path:PickleTools/Tests/Pickle/StandaloneBase/Mod\n${j.mod.PackageId} ${key}\n`;

const tp = path.join(root, 'Tests', 'Pickle');
const suffix = FROM > 1 ? `-from${FROM}` : '';
fs.writeFileSync(path.join(tp, 'Mod', 'Pickle', 'Features', `pickletools-${tag}${suffix}.feature`), f);
fs.writeFileSync(path.join(tp, `wsl-deps.things-${key}.map`), m);
fs.writeFileSync(path.join(tp, `things-${key}-${group}${suffix}.key.md`), k);
console.log(`${key}: ${names.length} ${group} defs, ${shots.length} shots, wrote ${used.length}`);
