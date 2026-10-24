// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-look-gallery.feature: one photograph per value of the look catalogues
// (ColonistRace/docs/CATALOGUE-*.md), on Nelim of the save Nelims-tribe, the way pickletools-face-parts-gallery does it.
// Input: the [look-*] lines of a pickletools-look-catalogue run, saved one per line in the file given as argument (default %TEMP%/look-lines.txt).
//   node docs/Generate-LookGallery.js [look-lines.txt]
const fs = require('fs'), path = require('path');
const src = process.argv[2] || path.join(process.env.TEMP, 'look-lines.txt');
const lines = fs.readFileSync(src, 'utf8').split(/\r?\n/);
const P = "Nelim's Pickle Tools: ";
function values(tag, pick) {
  const out = [];
  for (const l of lines) {
    if (!l.startsWith('[' + tag + '] ') || l.startsWith('[' + tag + '] total')) continue;
    const m = l.match(/^\[[a-z-]+\] (.*?) \((\d+)\): (.*)$/); if (!m) continue;
    const mod = m[1].split(' | ')[0].trim();
    for (const raw of m[3].split(', ')) { const v = pick(raw.trim(), mod); if (v) out.push(v); }
  }
  return out;
}
const plain = raw => raw.replace(/ \([A-Za-z]+\)$/, '').replace(/\[.*\]$/, '');
const hair = values('look-hair', plain), beard = values('look-beard', plain), head = values('look-head', raw => / \(Male\)$/.test(raw) ? null : plain(raw)); // a (Male) head is refused on Nelim ("is for Male; Nelim is Female"): those wait for Soren
const tattooAll = values('look-tattoo', raw => ({ name: plain(raw), type: (raw.match(/\((Face|Body)\)$/) || [])[1] || 'Face' }));
const faceTattoo = tattooAll.filter(t => t.type === 'Face').map(t => t.name), bodyTattoo = tattooAll.filter(t => t.type === 'Body').map(t => t.name);
const apparelRaw = values('look-apparel', raw => raw);
const isHat = r => /\[(?:UpperHead|FullHead|Mouth|Eyes)[\]\/]/.test(r);
const clean = r => r.replace(/\[.*\]$/, '');
const hats = apparelRaw.filter(isHat).map(clean), apparel = apparelRaw.filter(r => !isHat(r)).map(clean);
const hex = raw => { const m = raw.match(/^(.*)#([0-9A-Fa-f]{6})$/); return m ? { name: m[1], rgb: [0, 2, 4].map(i => parseInt(m[2].substr(i, 2), 16)) } : null; };
const colourLines = lines.filter(l => l.startsWith('[look-colour] ') && !l.includes('total'));
function colours(type) { const out = []; for (const l of colourLines) { const m = l.match(/^\[look-colour\] (.*?) \| (.*?) \((\d+)\): (.*)$/); if (m && m[2] === type) for (const r of m[4].split(', ')) { const c = hex(r.trim()); if (c) out.push(c); } } return out; }
const hairColours = colours('Hair'), ideoColours = colours('Ideo');

const PRE = [
  'Given the save "Nelims-tribe" is loaded', 'And game speed is paused',
  `And ${P}the item and name labels are hidden`, `And ${P}the tooltips are hidden`, `And ${P}the colonist bar is hidden`, `And ${P}the learning helper is hidden`,
  `And ${P}the temperature of the map is 20 degrees`, `And ${P}I let 10 ticks pass`, `And ${P}I frame the area centred on (177, 121) at root size 6.5`,
  `And ${P}"Nelim" stands at (176, 120) facing South`, `And ${P}"Nelim" face kit is "neutral"`, `And ${P}"Nelim" facial expression is "normal"`, `And ${P}"Nelim" face is held neutral`,
];
const CHUNK = 20; let n = 0; let out = '@requires:nelim.pickletools.screenshotstudio\n@requires:nelim.pickletools.colonistrace\n@requires:nelim.pickletools.camerazoom\n'
  + 'Feature: Every look value on Nelim, one photograph per value (gallery of the look catalogues)\n\n';
function scenarios(kind, items, framing, setup, step, shot, after, finish) {
  for (let i = 0; i < items.length; i += CHUNK) {
    const part = items.slice(i, i + CHUNK); n++;
    out += `  Scenario: look-gallery-${n}: ${kind} ${i + 1} to ${i + part.length} of ${items.length}\n`;
    for (const l of PRE) out += `    ${l}\n`;
    for (const l of setup) out += `    And ${l}\n`;
    out += `    And ${P}I frame the cell ${framing}\n`;
    for (const it of part) { out += `    When ${step(it)}\n    And ${P}I let 5 frames pass\n    And I take a screenshot "${kind}-${shot(it)}"\n` + (after ? `    And ${after(it)}\n` : ''); }
    if (finish) out += `    And ${finish}\n`;
    out += '\n';
  }
}
const FACE = '(176, 119) at zoom 3', BODY = '(176, 120) at zoom 2';
scenarios('hair', hair, FACE, [], h => `${P}"Nelim" hairstyle is "${h}"`, h => h);
scenarios('haircolour', hairColours, FACE, [`${P}"Nelim" hairstyle is "Afro"`], c => `${P}"Nelim" hair colour is rgb (${c.rgb.join(', ')})`, c => c.name);
scenarios('beard', beard, FACE, [], b => `${P}"Nelim" beard is "${b}"`, b => b);
scenarios('head', head, FACE, [], h => `${P}"Nelim" head type is "${h}"`, h => h);
scenarios('facetattoo', faceTattoo, FACE, [], t => `${P}"Nelim" face tattoo is "${t}"`, t => t);
scenarios('bodytattoo', bodyTattoo, BODY, [`${P}"Nelim" is undressed`, `${P}"Nelim" wears "UnderWhere_Panties"`, `${P}"Nelim" wears "UnderWhere_Bra"`], t => `${P}"Nelim" body tattoo is "${t}"`, t => t);
scenarios('garment', apparel, BODY, [], a => `${P}"Nelim" is undressed\n    And ${P}"Nelim" wears "UnderWhere_Panties"${['Apparel_TribalA', 'Apparel_BodyStrap', 'Apparel_Corset', 'Apparel_PsyfocusVest', 'Apparel_VestRoyal'].includes(a) ? '' : `\n    And ${P}"Nelim" wears "UnderWhere_Bra"`}\n    And ${P}"Nelim" wears "${a}"`, a => a);  // no bra under Apparel_TribalA, Apparel_BodyStrap, Apparel_Corset, Apparel_PsyfocusVest and Apparel_VestRoyal (owner, 2026-10-25)
scenarios('hat', hats, FACE, [`${P}"Nelim" hairstyle is "Long"`], a => `${P}"Nelim" wears "${a}"\n    And ${P}"Nelim" wears "Apparel_Corset"\n    And ${P}"Nelim" wears "Apparel_Pants"`, a => a, () => `${P}"Nelim" gets back the clothes it had\n    And ${P}"Nelim" hairstyle is "Long"`, `${P}"Nelim" hairstyle is "Victoria"`);
scenarios('ideocolour', ideoColours, BODY, [], c => `${P}"Nelim" is undressed\n    And ${P}"Nelim" wears "UnderWhere_Panties"\n    And ${P}"Nelim" wears "UnderWhere_Bra"\n    And ${P}"Nelim" wears "Apparel_BasicShirt" dyed rgb (${c.rgb.join(', ')})`, c => c.name);
fs.writeFileSync(path.join(__dirname, '..', 'Tests/Pickle/Mod/Pickle/Features/pickletools-look-gallery.feature'), out);
console.log(`${n} scenarios: hair ${hair.length}, haircolour ${hairColours.length}, beard ${beard.length}, head ${head.length}, facetattoo ${faceTattoo.length}, bodytattoo ${bodyTattoo.length}, garment ${apparel.length}, ideocolour ${ideoColours.length}`);
