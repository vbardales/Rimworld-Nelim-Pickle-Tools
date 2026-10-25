// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-face-skin-gallery.feature: skins, brows, head shapes and the EyeGenes3 eyeballs redone on a
// bald Nelim with the neutral kit, expression normal, face held neutral (no blush, no hair), and pickletools-face-animation.feature: short photo
// sequences (blink, smile, brows) to be joined into animated sheets. Values come from ColonistRace/docs/FACE-PARTS.md. Written 2026-10-25 at the
// owner's request (skins, brows and head shapes from a normal bald face; BrowSwift, BrowEmpathetic, Beauty and Beauty2 were hard to read; eyeball Swift redone).
// No face kit anywhere: the base face is set part by part (the kits are not used, owner 2026-10-25; the kit table of FACE-PARTS.md is not redone).
// usage: node docs/Generate-SkinGallery.js   (from the repository root)
const fs = require('fs');
const md = fs.readFileSync('ColonistRace/docs/FACE-PARTS.md', 'utf8').split(/\r?\n/);
function section(title) {
  let on = false; const names = [];
  for (const l of md) {
    if (/^## /.test(l)) { on = l.startsWith('## ' + title); continue; }
    if (!on) continue;
    const t = l.match(/^\| (?!Mod|---)[^|]+\| ([^|]+)\|/);
    if (t) names.push(...t[1].split(',').map(s => s.trim()).filter(Boolean));
  }
  return names;
}
const skins = section('Skins'), brows = section('Brows'), heads = section('Head shapes'), lids = section('Lids');
const look = fs.readFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-look-gallery.feature', 'utf8');
const faceTattoos = [...new Set([...look.matchAll(/"Nelim" face tattoo is "([^"]+)"/g)].map(m => m[1]))];  // the catalogue list, as the look gallery photographs it
const eyeballs = ['Courageous', 'Empathetic', 'Swift'];  // EyeGenes3: Swift is redone, the two others stay beside it to compare
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
  `And ${PT}"Nelim" hairstyle is "Bald"`,
  `And ${PT}"Nelim" face tattoo is "none"`,
  `And ${PT}"Nelim" mouth is "MouthNormal"`,
  `And ${PT}"Nelim" brows are "BrowNormal"`,
  `And ${PT}"Nelim" lids are "LidNormal"`,
  `And ${PT}"Nelim" face skin is "SkinNormal"`,
  `And ${PT}"Nelim" eyeballs are "EyeNormal"`,
  `And ${PT}"Nelim" face head shape is "HeadNormal"`,
  `And ${PT}"Nelim" facial expression is "normal"`,
  `And ${PT}"Nelim" face is held neutral`,
  `And ${PT}I frame the cell (176, 119) at zoom 2`,
];
// The skin catalogue is photographed on a very white skin (owner, 2026-10-25): the dark overlays of the skins read better on it than on the orange default.
const whiteHead = [...head.slice(0, -1), `And ${PT}"Nelim" skin colour is rgb (255, 244, 238)`, head[head.length - 1]];
const tags = ['@requires:nelim.pickletools.screenshotstudio', '@requires:nelim.pickletools.colonistrace', '@requires:nelim.pickletools.camerazoom'];
const shot = (step, name, frames = 5) => [`When ${PT}${step}`, `And ${PT}I let ${frames} frames pass`, `And I take a screenshot "${name}"`];
function scenario(out, title, shots, base = head) {   // at most 25 shots per scenario (Pickle's watchdog stops a scenario at 300 s)
  out.push(`  Scenario: ${title}`);
  base.forEach(h => out.push('    ' + h));
  shots.forEach(s => s.forEach(x => out.push('    ' + x)));
  out.push('');
}
const out = [...tags, 'Feature: Skins, brows, head shapes and the EyeGenes3 eyeballs on a bald Nelim, neutral and without blush (the redone part of the face gallery)', ''];
scenario(out, `face-skin-gallery-1: ${skins[0]} to ${skins[skins.length - 1]} (all skins)`, skins.map(v => shot(`"Nelim" face skin is "${v}"`, `skin-${v}`)), whiteHead);
// Close-ups of the skins the owner flagged as hard to read (2026-10-25): no lids at all (no lashes over the eyes), closer zoom.
const closeSkins = ['AKN_SkinSnoot', 'SkinLeftChin', 'SkinDecrepit', 'SkinFreckles2', 'SkinFreckles3', 'SkinFurrows', 'SkinRightEye', 'SkinTiredEyes'];
const closeHead = whiteHead.map(h => h.includes('lids are') ? h.replace('LidNormal', 'LidNone') : h);  // root size: smaller = closer (zoom 3 was LESS close than zoom 2)
scenario(out, 'face-skin-closeup-1: the eight flagged skins, no lids, head framed at root size 2', closeSkins.map(v => shot(`"Nelim" face skin is "${v}"`, `skinclose-${v}`)), closeHead);
scenario(out, `face-brow-gallery-1: ${brows[0]} to ${brows[brows.length - 1]} (all brows)`, brows.map(v => shot(`"Nelim" brows are "${v}"`, `brow-${v}`)));
scenario(out, `face-head-gallery-1: ${heads.join(', ')} (all head shapes)`, heads.map(v => shot(`"Nelim" face head shape is "${v}"`, `head-${v}`)));
scenario(out, `face-lid-gallery-1: ${lids[0]} to ${lids[lids.length - 1]} (all lids, from a normal face, lower priority)`, lids.map(v => shot(`"Nelim" lids are "${v}"`, `lid-${v}`)));
for (let i = 0, n = 1; i < faceTattoos.length; i += 20, n++) {
  const part = faceTattoos.slice(i, i + 20);
  scenario(out, `face-tattoo-gallery-${n}: face tattoos ${i + 1} to ${i + part.length} of ${faceTattoos.length} on a bald Nelim`, part.map(v => shot(`"Nelim" face tattoo is "${v}"`, `facetattoo-${v}`)));
}
scenario(out, 'face-eyeball-swift: the EyeGenes3 eyeballs, Swift redone', eyeballs.map(v => shot(`"Nelim" eyeballs are "${v}"`, `eyeball-${v}`)));
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-face-skin-gallery.feature', out.join('\n'));

// Animations: one sequence per scenario, shots 4 frames apart.
const seqs = {
  blink: ['LidSimple', 'LidSleepy', 'LidVK_ClosedEyes', 'LidSleepy', 'LidSimple'].map(v => [`"Nelim" lids are "${v}"`, v]),
  smile: ['MouthSimpleMouth', 'MouthLipsTinySmile', 'MouthLipsSmallSmile', 'MouthLipsTinySmile', 'MouthSimpleMouth'].map(v => [`"Nelim" mouth is "${v}"`, v]),
  brows: ['BrowNormal', 'BrowRaised', 'BrowTriangle', 'BrowRaised', 'BrowNormal'].map(v => [`"Nelim" brows are "${v}"`, v]),
};
const anim = [...tags, 'Feature: Short photo sequences of the face parts, for animated sheets (a blink, a smile, brows)', ''];
for (const [k, frames] of Object.entries(seqs)) {
  scenario(anim, `face-animation-${k}: ${frames.length} frames of a ${k}`, frames.map(([step, v], i) => shot(step, `anim-${k}-${i + 1}-${v}`, 4)));
}
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-face-animation.feature', anim.join('\n'));
console.log(`${skins.length} skins, ${brows.length} brows, ${heads.length} head shapes, ${eyeballs.length} eyeballs; sequences ${Object.keys(seqs).join(', ')}`);
