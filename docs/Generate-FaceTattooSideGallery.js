// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-face-tattoo-side-gallery.feature: the face tattoo scenarios of pickletools-face-skin-gallery.feature
// replayed with the bald Nelim facing East (profile), shots facetattoo-<defName>-side. Written 2026-10-26 at the owner's request (to choose a face tattoo
// for Ada she needs the side view). usage: node docs/Generate-FaceTattooSideGallery.js   (from the repository root)
const fs = require('fs');
const src = fs.readFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-face-skin-gallery.feature', 'utf8').split(/\r?\n/);
const head = src.slice(0, src.findIndex(l => /^\s*Scenario:/.test(l)));
const out = [];
let cur = null, n = 0, count = 0;
const flush = () => { if (cur) { out.push(...cur, ''); } };
for (const l of src.slice(head.length)) {
  const m = l.match(/^(\s*)Scenario: face-tattoo-gallery-\d+: (face tattoos .*)$/);
  if (m) { flush(); n++; cur = [`${m[1]}Scenario: face-tattoo-side-gallery-${n}: ${m[2].replace('face tattoos', 'profile of face tattoos')}`]; continue; }
  if (/^\s*Scenario:/.test(l)) { flush(); cur = null; continue; }
  if (!cur) continue;
  if (/^\s*$/.test(l)) continue;
  cur.push(l.replace('"Nelim" stands at (176, 120) facing South', '"Nelim" stands at (176, 120) facing East').replace(/screenshot "(facetattoo-[^"]+)"/, (s, a) => { count++; return `screenshot "${a}-side"`; }));
}
flush();
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-face-tattoo-side-gallery.feature', [...head, ...out].join('\n').replace(/Feature: .*/, 'Feature: Profile of every face tattoo on a bald Nelim (side view of the face tattoo gallery)') + '\n');
console.log(`${n} scenarios, ${count} shots`);
