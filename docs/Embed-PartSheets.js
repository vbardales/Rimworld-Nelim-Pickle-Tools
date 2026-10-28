// Puts the contact sheet of each face part under its heading in ColonistRace/docs/catalogues/face-parts.md (run again: already embedded sheets are skipped).
const fs = require('fs');
const file = 'ColonistRace/docs/catalogues/face-parts.md';
const lines = fs.readFileSync(file, 'utf8').split(/\r?\n/);
const sheets = { 'Mouths': 'mouth', 'Brows': 'brow', 'Lids': 'lid', 'Lid options': 'lidoption', 'Skins': 'skin', 'Eyeballs': 'eyeball', 'Emotion marks': 'emotion', 'Head shapes': 'head', 'Kits': 'kit' };
const sheetNames = { mouth: '0601 Parties du visage - Bouches', brow: '0602 Parties du visage - Sourcils', lid: '0603 Parties du visage - Paupieres', skin: '0604 Parties du visage - Peaux', eyeball: '0606 Parties du visage - Yeux', head: '0607 Parties du visage - Formes de tete', kit: '0608 Parties du visage - Kits', lidoption: '0610 Parties du visage - Options de paupieres', emotion: '0611 Parties du visage - Marques d emotion' };
const out = [];
let added = 0;
for (let i = 0; i < lines.length; i++) {
  out.push(lines[i]);
  const h = lines[i].match(/^## (.+?) \(`/);
  if (h && sheets[h[1]] && !lines[i + 2] ?.includes('img/looks/06')) {
    out.push('', `![${h[1]}: one photograph per value, Nelim at 20 degrees, run of 2026-10-09](../img/looks/${encodeURI(sheetNames[sheets[h[1]]])}.jpg)`);
    added++;
  }
}
fs.writeFileSync(file, out.join('\n'));
console.log('sheets embedded: ' + added);
