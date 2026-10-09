// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-face-parts-gallery.feature from ColonistRace/docs/FACE-PARTS.md:
// one photograph per face part value and per kit, on Nelim, 25 shots per scenario (Pickle's watchdog stops a scenario at 300 s).
// usage: node docs/Generate-FaceGallery.js   (from the repository root)
const fs = require('fs');
const md = fs.readFileSync('ColonistRace/docs/FACE-PARTS.md', 'utf8').split(/\r?\n/);
const secs = {};
let cur = null;
for (const l of md) {
  const h = l.match(/^## (.+?) \(`(.+?)`\)/);
  if (h) { cur = { title: h[1], names: [] }; secs[h[1]] = cur; continue; }
  if (/^## /.test(l)) { cur = null; continue; }
  if (!cur || cur.title === 'Kits') continue;
  const t = l.match(/^\| (?!Mod|---)[^|]+\| ([^|]+)\|/);
  if (t) { cur.names.push(...t[1].split(',').map(s => s.trim()).filter(Boolean)); continue; }
  const p = l.match(/^([A-Za-z0-9_]+) \(/);
  if (p) cur.names.push(p[1]);
}
const PT = "Nelim's Pickle Tools: ";
const head = [
  'Given the save "Nelims-tribe" is loaded',
  'And game speed is paused',
  `And ${PT}the item and name labels are hidden`,
  `And ${PT}the tooltips are hidden`,
  `And ${PT}the colonist bar is hidden`,
  `And ${PT}the learning helper is hidden`,
  `And ${PT}the temperature of the map is 20 degrees`,
  `And ${PT}I frame the area centred on (177, 121) at root size 6.5`,
  `And ${PT}"Nelim" stands at (176, 120) facing South`,
  `And ${PT}"Nelim" face kit is "neutral"`,
  `And ${PT}I frame the cell (176, 119) at zoom 2`,
].map(l => '    ' + l).join('\n') + '\n';
const stepText = { Mouths: 'mouth is', Brows: 'brows are', Lids: 'lids are', Skins: 'face skin is', Eyeballs: 'eyeballs are', 'Head shapes': 'face head shape is', 'Lid options': 'lid option is', 'Emotion marks': 'emotion mark is' };
const pre = { Mouths: 'mouth', Brows: 'brow', Lids: 'lid', Skins: 'skin', Eyeballs: 'eyeball', 'Head shapes': 'head', 'Lid options': 'lidoption', 'Emotion marks': 'emotion' };
const shot = (when, label) => `    When ${when}\n    And ${PT}I let 5 frames pass\n    And I take a screenshot "${label}"\n`;
const blocks = [];
for (const t of Object.keys(stepText)) for (const n of secs[t].names) blocks.push({ label: `${pre[t]}-${n}`, text: shot(`${PT}"Nelim" ${stepText[t]} "${n}"`, `${pre[t]}-${n}`) });
for (const k of ['smile', 'calm', 'sad', 'angry', 'smug', 'neutral']) blocks.push({ label: `kit-${k}`, text: shot(`${PT}"Nelim" face kit is "${k}"`, `kit-${k}`) });
const per = 25;
const total = Math.ceil(blocks.length / per);
let out = '@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\nFeature: Every face part and kit on Nelim, one photograph per value (gallery of the step parameters)\n';
for (let i = 0; i < total; i++) {
  const g = blocks.slice(i * per, (i + 1) * per);
  out += `\n  Scenario: face-parts-gallery-${i + 1}: ${g[0].label} to ${g[g.length - 1].label} (part ${i + 1} of ${total})\n` + head + g.map(b => b.text).join('');
}
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-face-parts-gallery.feature', out);
console.log(blocks.length + ' shots, ' + total + ' scenarios');
