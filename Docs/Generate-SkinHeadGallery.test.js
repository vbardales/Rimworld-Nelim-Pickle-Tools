// Test of docs/Generate-SkinHeadGallery.js in a sandbox (never touches the real Tests/Pickle folder).
// Fixtures: a gene gallery with 2 skin scenarios (26 genes) and a seren gallery (13 genes). The script is run with cwd = sandbox.
// Checks: chunks <= 12 shots, shot names kept, zoom line replaced, @requires header kept, deterministic bytes, clear failure on a missing input.
// Note: the script has no -Filter option (only mentioned in its header), so none is tested.
// usage: node docs/Generate-SkinHeadGallery.test.js   (from the repository root)
const fs = require('fs'), os = require('os'), path = require('path'), assert = require('assert'), { spawnSync } = require('child_process');
const SCRIPT = path.join(__dirname, 'Generate-SkinHeadGallery.js');
const REL = 'Tests/Pickle/Mod/Pickle/Features/';
const P = "Nelim's Pickle Tools: ";
function scenario(name, genes) {
  const l = [`  Scenario: ${name}`, 'Given the save "Nelims-tribe" is loaded', `And ${P}I frame the cell (176, 120) at zoom 2`, ''];
  for (const g of genes) l.push(`When ${P}"Nelim" has the gene "${g}"`, `And ${P}I let 5 frames pass`, `And I take a screenshot "skingene-${g}"`);
  l.push('');
  return l.join('\n');
}
const names = (n, p) => Array.from({ length: n }, (_, i) => `${p}${String(i + 1).padStart(2, '0')}`);
function sandbox(opts = {}) {
  const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'shg-'));
  fs.mkdirSync(path.join(dir, REL), { recursive: true });
  const hdr = '@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\n';
  if (!opts.noGene) fs.writeFileSync(path.join(dir, REL, 'pickletools-gene-gallery.feature'),
    hdr + 'Feature: x\n\n' + scenario('gene-gallery-skins-1: a', names(14, 'Skin')) + scenario('gene-gallery-skins-2: b', names(12, 'Melanin')) + scenario('gene-gallery-other-1: skip', ['Nope']));
  if (!opts.noSeren) fs.writeFileSync(path.join(dir, REL, 'pickletools-seren-gallery.feature'),
    hdr + 'Feature: y\n\n' + scenario('seren-gallery-1: skin colours', names(13, 'Seren')) + scenario('seren-gallery-2: other', ['Nope']));
  return dir;
}
const run = dir => spawnSync('node', [SCRIPT], { cwd: dir, encoding: 'utf8' });
const read = (dir, f) => fs.readFileSync(path.join(dir, REL, f), 'utf8');
const scenarios = text => text.split(/\r?\n(?=  Scenario:)/).slice(1);
const shots = s => [...s.matchAll(/take a screenshot "([^"]+)"/g)].map(m => m[1]);
const tests = [];
const test = (n, f) => tests.push([n, f]);

test('gene gallery: 26 genes in 3 chunks of at most 12, names kept in order, other scenarios ignored', () => {
  const d = sandbox(); const r = run(d); assert.strictEqual(r.status, 0, r.stderr);
  const t = read(d, 'pickletools-skin-head-gallery.feature');
  const sc = scenarios(t);
  assert.deepStrictEqual(sc.map(s => shots(s).length), [9, 9, 8]);
  sc.forEach(s => assert.ok(shots(s).length <= 12));
  assert.deepStrictEqual(sc.flatMap(shots), [...names(14, 'Skin'), ...names(12, 'Melanin')].map(g => 'skingene-' + g));
  assert.ok(!/Nope/.test(t));
  assert.ok(/Scenario: skin-head-1: skin colour genes 1 to 9 of 26/.test(sc[0]));
  assert.ok(/Scenario: skin-head-3: skin colour genes 19 to 26 of 26/.test(sc[2]));
  assert.ok(sc[0].includes('has the gene "Skin01"'));
  assert.ok(/26 genes in 3 scenarios; seren: 13 genes in 2 scenarios/.test(r.stdout), r.stdout);
});
test('seren gallery: 13 genes in 2 chunks (7, 6), own prefix', () => {
  const d = sandbox(); run(d);
  const sc = scenarios(read(d, 'pickletools-skin-head-gallery-seren.feature'));
  assert.deepStrictEqual(sc.map(s => shots(s).length), [7, 6]);
  assert.ok(/Scenario: skin-head-seren-2: skin colour genes 8 to 13 of 13/.test(sc[1]));
  assert.deepStrictEqual(sc.flatMap(shots), names(13, 'Seren').map(g => 'skingene-' + g));
});
test('zoom line replaced (176, 120) -> (176, 119) in every scenario, none left behind', () => {
  const d = sandbox(); run(d);
  for (const f of ['pickletools-skin-head-gallery.feature', 'pickletools-skin-head-gallery-seren.feature']) {
    const t = read(d, f);
    assert.ok(!/\(176, 120\)/.test(t));
    scenarios(t).forEach(s => assert.ok(s.includes(`${P}I frame the cell (176, 119) at zoom 2`) && s.includes('Given the save "Nelims-tribe" is loaded')));
  }
});
test('@requires header kept, Feature title written', () => {
  const d = sandbox(); run(d);
  const t = read(d, 'pickletools-skin-head-gallery.feature');
  assert.ok(t.startsWith('@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\nFeature: Head photograph of every skin colour gene of Biotech'));
  assert.ok(read(d, 'pickletools-skin-head-gallery-seren.feature').includes('Feature: Head photograph of every skin colour gene of Seren, from Stardust'));
});
test('deterministic: second run gives the same bytes', () => {
  const d = sandbox(); run(d);
  const get = () => [read(d, 'pickletools-skin-head-gallery.feature'), read(d, 'pickletools-skin-head-gallery-seren.feature')];
  const a = get();
  assert.strictEqual(run(d).status, 0);
  assert.deepStrictEqual(get(), a);
});
test('missing input: non-zero exit with the missing file named', () => {
  for (const o of [{ noGene: true }, { noSeren: true }]) {
    const r = run(sandbox(o)); assert.notStrictEqual(r.status, 0);
    assert.ok(/ENOENT/.test(r.stderr) && /gallery\.feature/.test(r.stderr), r.stderr);
  }
});

let bad = 0;
for (const [n, f] of tests) { try { f(); console.log('ok - ' + n); } catch (e) { bad++; console.log('FAIL - ' + n + '\n  ' + e.message); } }
console.log(`${tests.length - bad}/${tests.length} passed`);
process.exit(bad ? 1 : 0);
