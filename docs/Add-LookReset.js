// Adds the baseline to the galleries that change one look value per photograph (owner, 2026-10-26: porosity between the shots): in each scenario, before the first
// step that sets hairstyle / hair colour / head type / beard / tattoo / skin colour, `the look of "X" is saved`; before every later such step, `the look of "X" is restored`.
// Idempotent. usage: node docs/Add-LookReset.js <feature>...   or require('./Add-LookReset').apply(file) at the end of a generator.
const fs = require('fs');
const P = "Nelim's Pickle Tools: ";
const SETS = new RegExp(`^([ ]*)(?:When|And|Given) ${P}"([^"]+)" (?:hairstyle is|hair colour is|head type is|beard is|face tattoo is|body tattoo is|skin colour is)`);
function apply(file) {
  const lines = fs.readFileSync(file, 'utf8').split(/\r?\n/);
  const out = []; let seen = new Set(); let added = 0;
  for (const l of lines) {
    if (/^\s*Scenario:/.test(l)) seen = new Set();
    const m = l.match(SETS);
    if (m && !/the look of/.test(l)) {
      const [, ind, nick] = m;
      const isWhen = /^\s*When /.test(l);
      if (isWhen) {   // setup lines (And/Given) before the first When describe the baseline; only the When steps are the photographs
        if (!seen.has(nick)) { out.push(`${ind}And ${P}the look of "${nick}" is saved`); seen.add(nick); added++; }
        else { out.push(`${ind}And ${P}the look of "${nick}" is restored`); added++; }
      }
    }
    out.push(l);
  }
  const text = out.join('\n');
  if (!/the look of .* is (saved|restored)\n[^\n]*\n[^\n]*the look of/.test(text) || true) fs.writeFileSync(file, text);
  return added;
}
module.exports = { apply };
if (require.main === module) for (const f of process.argv.slice(2)) console.log(f, apply(f));
