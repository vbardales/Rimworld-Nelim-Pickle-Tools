// Inserts <param name="x">text</param> lines above the attribute of a step, below its summary.
// usage: node docs/add-param-docs.js docs/param-docs.json   (paths in the spec are relative to the repository root)
// Spec: [{ "file": "ColonistRace/Source/LookSteps.cs", "step": "{string} faces {word}", "params": { "name": "...", "direction": "..." } }]
// A step that already carries a <param> for that name is left alone, so the tool can be run again.
const fs = require('fs');
const path = require('path');
const root = path.resolve(__dirname, '..');
const spec = JSON.parse(fs.readFileSync(path.resolve(process.argv[2]), 'utf8'));
let added = 0;
for (const item of spec) {
  const file = path.join(root, item.file);
  const crlf = fs.readFileSync(file, 'utf8').includes('\r\n');
  const lines = fs.readFileSync(file, 'utf8').split(/\r?\n/);
  const hits = lines.map((l, i) => (/^\s*\[(Given|When|Then)\(/.test(l) && l.includes(item.step) ? i : -1)).filter(i => i >= 0);
  if (hits.length !== 1) { console.error('NOT FOUND or ambiguous (' + hits.length + '): ' + item.file + ' :: ' + item.step); process.exitCode = 1; continue; }
  const at = hits[0];
  const indent = lines[at].match(/^\s*/)[0];
  const insert = [];
  for (const [name, text] of Object.entries(item.params)) {
    // skip when this step's doc block already has the param
    let k = at - 1; let has = false;
    while (k >= 0 && /^\s*(\/\/\/|\[)/.test(lines[k])) { if (lines[k].includes('<param name="' + name + '">')) has = true; k--; }
    if (has) continue;
    insert.push(indent + '/// <param name="' + name + '">' + text + '</param>');
  }
  lines.splice(at, 0, ...insert);
  added += insert.length;
  fs.writeFileSync(file, lines.join(crlf ? '\r\n' : '\n'));
}
console.log('param docs added: ' + added);
