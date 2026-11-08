// Test of docs/Generate-TattooModsGallery.js in a sandbox (never touches the real Tests/Pickle folder or the real looks.md).
// Fixture: ColonistRace/docs/catalogues/looks.md with rows for the six tattoo mods (23 Myf face values plus Body_ values, Bill Doors on two rows).
// Checks: chunks <= 10 shots per scenario and within one mod, shot names (facetattoo-<def>, -side), Body_/OE_Body_ filtered, @requires header kept,
// look reset added, front/side facing, deterministic bytes, clear failure on a missing looks.md.
// Note: the script has no -Filter option (only mentioned in its header), so none is tested.
// usage: node docs/Generate-TattooModsGallery.test.js   (from the repository root)
const fs = require('fs'), os = require('os'), path = require('path'), assert = require('assert'), { spawnSync } = require('child_process');
const SCRIPT = path.join(__dirname, 'Generate-TattooModsGallery.js');
const REL = 'Tests/Pickle/Mod/Pickle/Features/';
const LOOKS = 'ColonistRace/docs/catalogues/looks.md';
const names = (n, p) => Array.from({ length: n }, (_, i) => `${p}${String(i + 1).padStart(2, '0')}`);
const myf = names(23, 'Myf');
const rows = [
  '| Mod | Values |', '| --- | --- |',
  `| Myf's Tattoos | (26) ${[...myf, 'Body_Myf1', 'OE_Body_Myf2', 'Body_Myf3'].join(', ')} |`,
  "| Sunny's Dr Stone Scars | (2) Sun01, Sun02 |",
  '| Morphs Assorted: Tattoos | (1) Mor01 |',
  '| Tattoo Face Scars | (1) Fac01 |',
  '| Misc Tattoos | (1) Mis01 |',
  '| Bill Doors | (2) Bil01, Bil02 |',
  '| Bill Doors | (1) Bil03, Body_Bil9 |',
  '| Unrelated Mod | (1) Zzz01 |',
];
function sandbox(noLooks) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'tmg-'));
  fs.mkdirSync(path.join(dir, REL), { recursive: true });
  if (!noLooks) { fs.mkdirSync(path.join(dir, path.dirname(LOOKS)), { recursive: true }); fs.writeFileSync(path.join(dir, LOOKS), rows.join('\n') + '\n'); }
  return dir;
}
const run = dir => spawnSync('node', [SCRIPT], { cwd: dir, encoding: 'utf8' });
const FRONT = 'pickletools-tattoomods-face.feature', SIDE = 'pickletools-tattoomods-face-side.feature';
const read = (dir, f) => fs.readFileSync(path.join(dir, REL, f), 'utf8');
const scenarios = text => text.split(/\r?\n(?=  Scenario:)/).slice(1);
const shots = s => [...s.matchAll(/take a screenshot "([^"]+)"/g)].map(m => m[1]);
const tests = [];
const test = (n, f) => tests.push([n, f]);
const expected = [...myf, 'Sun01', 'Sun02', 'Mor01', 'Fac01', 'Mis01', 'Bil01', 'Bil02', 'Bil03'];

test('chunks: Myf 23 -> 8,8,7, then one chunk per small mod, all <= 10, label order kept', () => {
  const d = sandbox(); const r = run(d); assert.strictEqual(r.status, 0, r.stderr);
  const sc = scenarios(read(d, FRONT));
  assert.deepStrictEqual(sc.map(s => shots(s).length), [8, 8, 7, 2, 1, 1, 1, 3]);
  sc.forEach(s => assert.ok(shots(s).length <= 10));
  assert.ok(/Scenario: tattoomods-face-1: Myf 1 to 8 of 23/.test(sc[0]));
  assert.ok(/Scenario: tattoomods-face-3: Myf 17 to 23 of 23/.test(sc[2]));
  assert.ok(/Scenario: tattoomods-face-8: BillDoors 1 to 3 of 3/.test(sc[7]), 'both Bill Doors rows merged');
  assert.ok(/8 scenarios 31 shots/.test(r.stdout), r.stdout);
});
test('shot names: facetattoo-<def> and facetattoo-<def>-side; Body_ and OE_Body_ values and other mods dropped', () => {
  const d = sandbox(); run(d);
  assert.deepStrictEqual(scenarios(read(d, FRONT)).flatMap(shots), expected.map(n => 'facetattoo-' + n));
  assert.deepStrictEqual(scenarios(read(d, SIDE)).flatMap(shots), expected.map(n => 'facetattoo-' + n + '-side'));
  for (const f of [FRONT, SIDE]) assert.ok(!/Body_|Zzz01/.test(read(d, f)));
});
test('front faces South, side faces East, set-up zoom and tattoo reset present in every scenario', () => {
  const d = sandbox(); run(d);
  for (const [f, facing, pre] of [[FRONT, 'South', 'tattoomods-face-'], [SIDE, 'East', 'tattoomods-face-side-']]) {
    const sc = scenarios(read(d, f)); assert.strictEqual(sc.length, 8);
    sc.forEach((s, i) => {
      assert.ok(s.includes(`Scenario: ${pre}${i + 1}:`));
      assert.ok(s.includes(`stands at (176, 120) facing ${facing}`));
      assert.ok(s.includes('I frame the cell (176, 119) at zoom 2'));
      assert.ok(s.includes('face tattoo is "none"'));
    });
  }
});
test('@requires header kept and look reset added (saved once, restored after) per scenario', () => {
  const d = sandbox(); run(d);
  const t = read(d, FRONT);
  assert.ok(t.startsWith('@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\n@requires:nelim.pickletools.camerazoom\nFeature: Front of every'));
  assert.ok(read(d, SIDE).includes('Feature: Profile of every'));
  scenarios(t).forEach(s => {
    assert.strictEqual((s.match(/the look of "Nelim" is saved/g) || []).length, 1);
    assert.strictEqual((s.match(/the look of "Nelim" is restored/g) || []).length, shots(s).length - 1);
  });
});
test('deterministic: second run gives the same bytes (look reset not doubled)', () => {
  const d = sandbox(); run(d);
  const a = [read(d, FRONT), read(d, SIDE)];
  assert.strictEqual(run(d).status, 0);
  assert.deepStrictEqual([read(d, FRONT), read(d, SIDE)], a);
});
test('missing looks.md: non-zero exit, file named, no feature written', () => {
  const d = sandbox(true); const r = run(d);
  assert.notStrictEqual(r.status, 0);
  assert.ok(/ENOENT/.test(r.stderr) && /looks\.md/.test(r.stderr), r.stderr);
  assert.deepStrictEqual(fs.readdirSync(path.join(d, REL)), []);
});

let bad = 0;
for (const [n, f] of tests) { try { f(); console.log('ok - ' + n); } catch (e) { bad++; console.log('FAIL - ' + n + '\n  ' + e.message); } }
console.log(`${tests.length - bad}/${tests.length} passed`);
process.exit(bad ? 1 : 0);
