// Makes every tool's Check-Steps.ps1 read the step patterns of SanctuaryBacklot/Source ("Nelim's Sanctuary: ..." steps) as one more
// source that shares Pickle's namespace, so that an ambiguity between a Pickle Tools step and a Sanctuary step is caught.
// Run once from the repository root; a script that already has the block is left alone.
const fs = require('fs');
const path = require('path');
const block = [
  '# SanctuaryBacklot (a sibling repository of the monorepo, not a tool folder of this one): its "Nelim\'s Sanctuary: ..." steps load with these',
  '# in the Sanctuary passes and share the namespace. Absent on a machine that does not have the repository: then there is nothing to compare.',
  '$sanctuarySrc = Join-Path (Split-Path (Split-Path $here -Parent) -Parent) \'SanctuaryBacklot\\Source\'',
  'if (Test-Path -LiteralPath $sanctuarySrc) { foreach ($p in Read-Patterns $sanctuarySrc \'tool:SanctuaryBacklot\') { $others += $p } }',
  '',
].join('\n');
let changed = 0;
for (const dir of fs.readdirSync('.')) {
  const file = path.join(dir, 'Check-Steps.ps1');
  if (!fs.existsSync(file)) continue;
  let text = fs.readFileSync(file, 'utf8');
  if (text.includes('tool:SanctuaryBacklot')) continue;
  const crlf = text.includes('\r\n');
  const lines = text.split(/\r?\n/);
  const at = lines.findIndex(l => l === '$otherExprs = @()');
  if (at < 0) { console.error('anchor not found: ' + file); process.exitCode = 1; continue; }
  lines.splice(at, 0, ...block.split('\n').slice(0, -1));
  fs.writeFileSync(file, lines.join(crlf ? '\r\n' : '\n'));
  changed++;
}
console.log('Check-Steps.ps1 changed: ' + changed);
