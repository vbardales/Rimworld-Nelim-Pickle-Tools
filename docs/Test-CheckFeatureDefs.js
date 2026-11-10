// Test of docs/Check-FeatureDefs.js (offline, Core defs only): a comma-joined list of def names in one step is checked name by name.
//  1. a list of three Core defs passes (exit 0); 2. a list with one unknown def fails (exit 1) and names that def only.
// usage: node docs/Test-CheckFeatureDefs.js   (from the repository root; needs the game's Data folder at its default path or --game-dir)
const fs = require('fs'), os = require('os'), path = require('path'), { spawnSync } = require('child_process');
const dir = fs.mkdtempSync(path.join(os.tmpdir(), 'cfd-'));
const map = path.join(dir, 'empty.map'); fs.writeFileSync(map, '# no mod: the Core defs only\n');
const run = list => {
  const feat = path.join(dir, 'a.feature');
  fs.writeFileSync(feat, `Feature: t\n\n  Scenario: dress-list: a list\n    Given Nelim's Pickle Tools: I dress "Toma" in "${list}"\n`);
  const r = spawnSync('node', [path.join(__dirname, 'Check-FeatureDefs.js'), '--map', map, '--feature', feat], { encoding: 'utf8' });
  return { code: r.status, out: (r.stdout || '') + (r.stderr || '') };
};
let bad = 0;
const ok = run('Apparel_CollarShirt,Apparel_Pants,Apparel_Duster');
if (ok.code !== 0) { bad++; console.log('FAIL 1: a list of three Core defs must pass, exit ' + ok.code + '\n' + ok.out); } else console.log('ok 1: a list of three Core defs passes');
const ko = run('Apparel_CollarShirt, Apparel_NoSuchThing ,Apparel_Pants');
const named = [...ko.out.matchAll(/ThingDef\/(\S+)/g)].map(m => m[1]);
if (ko.code !== 1 || named.length !== 1 || named[0] !== 'Apparel_NoSuchThing') { bad++; console.log('FAIL 2: only Apparel_NoSuchThing must be named, exit ' + ko.code + ', named ' + JSON.stringify(named) + '\n' + ko.out); } else console.log('ok 2: a list with one unknown def fails and names that def only');
// 3. a def with nested elements BEFORE its defName (LP_GardenBench, HDA_*, 2026-11-10) is found; an Abstract one is not.
const rel = 'PickleTools/.cfd-test-' + process.pid, modDir = path.join(__dirname, '..', '..', rel);
fs.mkdirSync(path.join(modDir, 'Defs'), { recursive: true });
fs.writeFileSync(path.join(modDir, 'Defs', 'a.xml'), '<?xml version="1.0"?>\n<Defs>\n<ThingDef ParentName="X"><graphicData><texPath>a/b</texPath><drawSize>(1,1)</drawSize></graphicData><comps><li Class="C"><k>v</k></li></comps><defName>Nest_Bench</defName></ThingDef>\n<ThingDef Abstract="True" Name="Y"><defName>Nest_Abstract</defName></ThingDef>\n</Defs>');
const map3 = path.join(dir, 'nest.map'); fs.writeFileSync(map3, 'test.nest path:' + rel + '\n');
const feat3 = path.join(dir, 'b.feature');
fs.writeFileSync(feat3, `Feature: t\n\n  Scenario: nest: x\n    Given Nelim's Pickle Tools: I place the decor "Nest_Bench"\n    And Nelim's Pickle Tools: I place the decor "Nest_Abstract"\n`);
const r3 = spawnSync('node', [path.join(__dirname, 'Check-FeatureDefs.js'), '--map', map3, '--feature', feat3], { encoding: 'utf8' });
const named3 = [...(r3.stdout || '').matchAll(/ThingDef\/(\S+)/g)].map(m => m[1]);
if (r3.status !== 1 || named3.length !== 1 || named3[0] !== 'Nest_Abstract') { bad++; console.log('FAIL 3: only Nest_Abstract must be missing, exit ' + r3.status + ', named ' + JSON.stringify(named3) + '\n' + r3.stdout + r3.stderr); } else console.log('ok 3: nested elements before defName are read, Abstract skipped');
fs.rmSync(modDir, { recursive: true, force: true });
fs.rmSync(dir, { recursive: true, force: true });
process.exit(bad ? 1 : 0);
