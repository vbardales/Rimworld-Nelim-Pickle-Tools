// Pulls the def-metadata JSON lines out of the junit.xml of a Pickle run (Pickle writes an attachment into <system-out>, not into a file) and writes
// def-metadata-<packageId>.jsonl into every catalogue folder that exists for the mod (things/<id>, terrain/<id>) of the private store rimworld-catalogue.
// Usage: node Docs/Extract-DefMetadata.js <workshopId> <inboxDir> [--store <path>] [--package <packageId>]
// A line of a generated def (Blueprint_, Frame_, Install_) is dropped, in case the run came from a build older than 2026-11-18.
const fs = require('fs'), path = require('path');
const args = process.argv.slice(2);
const [id, dir] = args;
const opt = n => { const i = args.indexOf(n); return i >= 0 ? args[i + 1] : null; };
if (!/^\d+$/.test(id || '') || !dir) { console.error('usage: node Docs/Extract-DefMetadata.js <workshopId> <inboxDir> [--store P] [--package <packageId>]'); process.exit(2); }
const root = path.resolve(__dirname, '..');
const store = path.resolve(opt('--store') || path.join(root, '..', '..', 'rimworld-catalogue'));
const xml = fs.readFileSync(path.join(root, 'Tests', 'Pickle', 'Inbox', dir, 'junit.xml'), 'utf8');
const dec = s => s.replace(/&lt;/g, '<').replace(/&gt;/g, '>').replace(/&quot;/g, '"').replace(/&apos;/g, "'").replace(/&amp;/g, '&');
const only = (opt('--package') || '').toLowerCase(); // a merged launch carries the metadata of several mods: keep one
let n = 0;
for (const m of xml.matchAll(/Attachment: def-metadata-(\S+) -&gt; ([\s\S]*?)(?=\r?\nAttachment: |<\/system-out>)/g)) { // a merged launch puts several attachments in one <system-out>
  if (only && m[1].toLowerCase() !== only) continue;
  const lines = dec(m[2]).split(/\r?\n/).filter(l => l.trim()).filter(l => !/^\{"packageId":"[^"]*","defName":"(Blueprint_|Frame_|Install_)/.test(l));
  lines.forEach(l => JSON.parse(l)); // a broken line fails here, not in the registry
  for (const kind of ['things', 'terrain']) {
    const d = path.join(store, kind, id);
    if (!fs.existsSync(d)) continue;
    fs.writeFileSync(path.join(d, `def-metadata-${m[1]}.jsonl`), lines.join('\n') + '\n');
    console.log(`${lines.length} defs of ${m[1]} -> ${d}`); n++;
  }
}
if (!n) { console.error('no def-metadata attachment or no catalogue folder for ' + id); process.exit(1); }
