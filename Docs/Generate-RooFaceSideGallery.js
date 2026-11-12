// Writes Tests/Pickle/Mod/Pickle/Features/pickletools-roo-face-side-gallery.feature: the two face scenarios of pickletools-roo-gallery.feature (40 face tattoos of Roo's
// Birthmarks and Blemishes and Roo's Tattoos Starter Pack) replayed with the bald Nelim facing East, shots facetattoo-<defName>-side, so that docs/Make-LookSheets.ps1
// fills the profile sheets "Tatouages visage profil - Roos ..." (they were hatched: the Roo values had no profile photograph). Written 2026-10-28 at the owner's request.
// usage: node docs/Generate-RooFaceSideGallery.js   (from the repository root; map wsl-deps.look-gallery.map)
const fs = require('fs');
const src = fs.readFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-roo-gallery.feature', 'utf8').split(/\r?\n/);
const head = src.slice(0, src.findIndex(l => /^\s*Scenario:/.test(l)));
const out = [];
let cur = null, n = 0, count = 0;
const flush = () => { if (cur) out.push(...cur, ''); };
for (const l of src.slice(head.length)) {
  const m = l.match(/^(\s*)Scenario: roo-gallery-\d+: (facetattoo .*)$/);
  if (m) { flush(); n++; cur = [`${m[1]}Scenario: roo-face-side-gallery-${n}: profile of ${m[2]}`]; continue; }
  if (/^\s*Scenario:/.test(l)) { flush(); cur = null; continue; }
  if (!cur || /^\s*$/.test(l)) continue;
  cur.push(l.replace('"Nelim" stands at (176, 120) facing South', '"Nelim" stands at (176, 120) facing East').replace(/screenshot "(facetattoo-[^"]+)"/, (s, a) => { count++; return `screenshot "${a}-side"`; }));
}
flush();
fs.writeFileSync('Tests/Pickle/Mod/Pickle/Features/pickletools-roo-face-side-gallery.feature', [...head, ...out].join('\n').replace(/Feature: .*/, "Feature: Profile of every face tattoo and birthmark of Roo's two mods on a bald Nelim") + '\n');
console.log(`${n} scenarios, ${count} shots`);
