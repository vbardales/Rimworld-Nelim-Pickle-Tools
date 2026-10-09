// Puts the contact sheet of each face part under its heading in ColonistRace/docs/FACE-PARTS.md (run again: already embedded sheets are skipped).
const fs = require('fs');
const file = 'ColonistRace/docs/FACE-PARTS.md';
const lines = fs.readFileSync(file, 'utf8').split(/\r?\n/);
const sheets = { 'Mouths': 'mouth', 'Brows': 'brow', 'Lids': 'lid', 'Lid options': 'lidoption', 'Skins': 'skin', 'Eyeballs': 'eyeball', 'Emotion marks': 'emotion', 'Head shapes': 'head', 'Kits': 'kit' };
const out = [];
let added = 0;
for (let i = 0; i < lines.length; i++) {
  out.push(lines[i]);
  const h = lines[i].match(/^## (.+?) \(`/);
  if (h && sheets[h[1]] && !lines[i + 2] ?.includes('img/parts-')) {
    out.push('', `![${h[1]}: one photograph per value, Nelim at 20 degrees, run of 2026-10-09](img/parts-${sheets[h[1]]}.jpg)`);
    added++;
  }
}
fs.writeFileSync(file, out.join('\n'));
console.log('sheets embedded: ' + added);
