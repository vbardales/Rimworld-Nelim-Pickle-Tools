// Builds ColonistRace/docs/catalogues/index.html: one page over the look, apparel, colour, weapon, item and mod catalogues
// (ColonistRace/docs/catalogues/*.md) and the photograph sheets of ColonistRace/docs/img.
//   node Docs/Make-CatalogueHtml.js        (run from the repository root; rerun after Docs/Make-LookSheets.ps1)
// No dependency: the markdown subset the catalogues use (headings, tables, lists, images, links, code, bold) is rendered here.
const fs = require('fs'), path = require('path');
const root = path.resolve(__dirname, '..');
const docs = path.join(root, 'ColonistRace', 'docs');
const cat = path.join(docs, 'catalogues');

const esc = s => s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;');
// A link to a look sheet keeps working when a new sheet shifts the numbers: it is matched on what follows the number ("<label> - <mod> - <page>.jpg").
function sheetLink(u) {
  const m = decodeURI(u).match(/^\.\.\/img\/looks\/[0-9]{3,4} (.*\.jpg)$/);
  if (!m) return u;
  const hit = Object.values(byBlock).flat().find(f => f.slice(5) === m[1]);
  return hit ? '../img/looks/' + encodeURI(hit) : u;
}
function inline(s) {
  s = esc(s);
  s = s.replace(/!\[([^\]]*)\]\(([^)]+)\)/g, (_, a, u) => `<img loading="lazy" src="${sheetLink(u)}" alt="${a}">`);
  s = s.replace(/\[([^\]]+)\]\(([^)]+)\)/g, (_, a, u) => `<a href="${sheetLink(u)}">${a}</a>`);
  s = s.replace(/`([^`]+)`/g, '<code>$1</code>').replace(/\*\*([^*]+)\*\*/g, '<b>$1</b>');
  return s;
}
function render(md) {
  const out = [], lines = md.replace(/\r/g, '').split('\n');
  for (let i = 0; i < lines.length; i++) {
    const l = lines[i];
    let m;
    if ((m = l.match(/^(#{1,4}) (.*)/))) { const n = m[1].length; out.push(`<h${n + 1} id="${m[2].toLowerCase().replace(/[^a-z0-9]+/g, '-')}">${inline(m[2])}</h${n + 1}>`); }
    else if (l.startsWith('|')) {
      const rows = [];
      while (i < lines.length && lines[i].startsWith('|')) { rows.push(lines[i]); i++; } i--;
      const cells = r => r.trim().replace(/^\||\|$/g, '').split('|').map(c => c.trim());
      const head = cells(rows[0]), body = rows.slice(2).map(cells);
      out.push('<table><thead><tr>' + head.map(c => `<th>${inline(c)}</th>`).join('') + '</tr></thead><tbody>' +
        body.map(r => '<tr>' + r.map(c => `<td>${inline(c)}</td>`).join('') + '</tr>').join('') + '</tbody></table>');
    } else if (/^\s*[-*] /.test(l)) {
      const items = [];
      while (i < lines.length && /^\s*[-*] /.test(lines[i])) { items.push(lines[i].replace(/^\s*[-*] /, '')); i++; } i--;
      out.push('<ul>' + items.map(t => `<li>${inline(t)}</li>`).join('') + '</ul>');
    } else if (l.trim() === '') { /* skip */ }
    else out.push(`<p>${inline(l)}</p>`);
  }
  return out.join('\n');
}

const tabs = [
  ['looks', 'Looks', 'looks.md'], ['apparel', 'Apparel', 'apparel.md'], ['colours', 'Colours', 'colours.md'],
  ['weapons', 'Weapons and crafts', 'weapons-crafts.md'], ['items', 'Utility items', 'items.md'],
  ['faceparts', 'Face parts', 'face-parts.md'], ['modlooks', 'Mods: looks', 'mods-looks.md'],
  ['modgear', 'Mods: gear', 'mods-gear.md'], ['modworld', 'Mods: world', 'mods-world.md'],
  ['genes', 'Genes', 'genes.md'], ['seren', 'Seren', 'seren.md'], ['weather', 'Weather', 'weather.md'], ['jobs', 'Jobs', 'jobs.md'],
  ['animalapparel', 'Animal apparel', 'animal-apparel.md'],
  ['coverage', 'Coverage', 'coverage.md'], ['gaps', 'Gaps', 'gaps.md'],
];

// Photograph sheets: img/looks/<NNNN> <label> - <mod> - <page>.jpg grouped by kind (its block), plus the part sheets, the animation sheets and the building tabs.
const looksDir = path.join(docs, 'img', 'looks');
// Sheets are named "<NNNN> <label> - <mod> - <page>.jpg": the first two digits are the kind's block (Make-LookSheets.ps1 kindBlock, the two tables agree), the last two the rank of the sheet in it.
const kindBlock = { hair: 0, haircolour: 1, beard: 2, head: 3, facetattoo: 4, bodytattoo: 5, body: 6, bodymask: 7, garment: 8, hat: 9, colour: 10, ideocolour: 11,
  weapon: 12, eyegene: 13, skingene: 14, hairgene: 15, lookgene: 16, weather: 17, animalapparel: 18,
  serenhead: 19, serenlid: 20, sereneyeball: 21, serenbrow: 22, serenmouth: 23, serenskin: 24, serenvteskin: 25, serenxeno: 26 };
const byBlock = {};
for (const f of fs.readdirSync(looksDir).filter(f => /^[0-9]{4} .*.jpg$/.test(f)).sort()) (byBlock[+f.slice(0, 2)] = byBlock[+f.slice(0, 2)] || []).push(f);
const byKind = {};
for (const [k, n] of Object.entries(kindBlock)) if (byBlock[n]) byKind[k] = byBlock[n];
const sheet = f => `<a href="../img/looks/${encodeURI(f)}" target="_blank"><img loading="lazy" src="../img/looks/${encodeURI(f)}" alt="${f}"><span>${path.basename(f).replace(/.jpg$/, '')}</span></a>`;
let gallery = '';
for (const [k, files] of Object.entries(byKind))
  gallery += `<h3>${k}</h3><div class="sheets">` + files.map(sheet).join('') + '</div>';
const extra = [];
for (const d of ['parts', 'anim', 'buildings'])
  if (fs.existsSync(path.join(docs, 'img', d)))
    for (const f of fs.readdirSync(path.join(docs, 'img', d)).filter(f => /.(jpg|png)$/.test(f)).sort()) extra.push('../img/' + d + '/' + f);
gallery += '<h3>parts, animations, buildings</h3><div class="sheets">' + extra.map(f => `<a href="${f}" target="_blank"><img loading="lazy" src="${f}" alt="${f}"><span>${path.basename(f)}</span></a>`).join('') + '</div>';

// The sheets of a kind go right under the heading of their section in the catalogue pages.
const sheetsFor = kinds => {
  const files = kinds.flatMap(k => byKind[k] || []);
  return files.length ? '<div class="sheets wide">' + files.map(sheet).join('') + '</div>' : '';
};
const sectionKinds = [[/^Photographs/, ['serenhead', 'serenlid', 'sereneyeball', 'serenbrow', 'serenmouth', 'serenskin', 'serenvteskin', 'serenxeno']], [/^Animal garments/, ['animalapparel']], [/^Hairstyles/, ['hair']], [/^Beards/, ['beard']], [/^Head types/, ['head']], [/^Tattoos/, ['facetattoo', 'bodytattoo']], [/^Body types/, ['body']],
  [/^Garments/, ['garment', 'hat']], [/^Colours/, ['haircolour', 'ideocolour', 'colour']], [/^Weapons/, ['weapon']],
  [/^Eye colours/, ['eyegene']], [/^Skin colours/, ['skingene']], [/^Hair colours/, ['hairgene']], [/^Look genes/, ['lookgene']], [/^Weather/, ['weather']]];
const withSheets = h => h.replace(/(<h3 id="[^"]*">)([^<]*)(<\/h3>)/g, (m, a, text) => {
  const hit = sectionKinds.find(([re]) => re.test(text));
  return m + (hit ? sheetsFor(hit[1]) : '');
});

const sections = tabs.map(([id, title, file]) => {
  const p = path.join(cat, file);
  return `<section id="${id}" hidden><h1>${title}</h1><p class="src">${file}</p>${fs.existsSync(p) ? withSheets(render(fs.readFileSync(p, 'utf8').replace(/^# .*\n/, ''))) : '<p>Missing file.</p>'}</section>`;
}).join('\n');

const html = `<!doctype html>
<html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1">
<title>Look catalogues</title>
<style>
:root{--bg:#fafaf7;--fg:#1d1d1b;--mut:#6b6b66;--line:#dcdcd4;--acc:#2f7d32;--card:#fff}
@media (prefers-color-scheme:dark){:root{--bg:#161614;--fg:#e8e8e2;--mut:#9a9a92;--line:#33332f;--acc:#7fd17f;--card:#1f1f1c}}
*{box-sizing:border-box}body{margin:0;background:var(--bg);color:var(--fg);font:15px/1.5 system-ui,Segoe UI,sans-serif;display:flex;min-height:100vh}
nav{width:210px;flex:none;padding:16px;border-right:1px solid var(--line);position:sticky;top:0;height:100vh;overflow:auto}
nav h2{font-size:13px;text-transform:uppercase;letter-spacing:.06em;color:var(--mut);margin:0 0 8px}
nav a{display:block;padding:6px 8px;border-radius:6px;color:var(--fg);text-decoration:none;cursor:pointer}
nav a.on{background:var(--acc);color:#fff}
main{flex:1;min-width:0;padding:20px 28px 60px}
#q{width:100%;max-width:420px;padding:8px 10px;border:1px solid var(--line);border-radius:6px;background:var(--card);color:var(--fg);margin-bottom:12px}
h1{margin:0 0 4px}.src{color:var(--mut);margin:0 0 16px;font-size:13px}
h2,h3,h4{margin:24px 0 8px}
table{border-collapse:collapse;width:100%;background:var(--card);margin:8px 0}
th,td{border:1px solid var(--line);padding:6px 8px;text-align:left;vertical-align:top;font-size:14px;overflow-wrap:anywhere}td:not(:last-child),th:not(:last-child){white-space:nowrap;overflow-wrap:normal}a{color:var(--acc)}
th{background:color-mix(in srgb,var(--acc) 12%,var(--card))}
code{background:color-mix(in srgb,var(--fg) 8%,transparent);padding:1px 4px;border-radius:4px;font-size:13px}
main img{max-width:100%}p>img,li>img{display:block;margin:8px 0}
.sheets{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:12px}
.sheets a{background:var(--card);border:1px solid var(--line);border-radius:8px;padding:6px;text-decoration:none;color:var(--mut);font-size:12px}
.sheets.wide{grid-template-columns:repeat(auto-fill,minmax(520px,1fr))}.sheets img{width:100%;display:block;border-radius:4px}
tr.hide{display:none}
@media(max-width:700px){body{display:block}nav{width:auto;height:auto;position:static;border:0;border-bottom:1px solid var(--line)}main{padding:16px}}
</style></head><body>
<nav><h2>Catalogues</h2>
${tabs.map(([id, t]) => `<a data-t="${id}">${t}</a>`).join('')}<a data-t="photos">Photographs</a></nav>
<main><input id="q" type="search" placeholder="Filter rows (a defName, a mod...)">
${sections}
<section id="photos" hidden><h1>Photographs</h1><p class="src">ColonistRace/docs/img</p>${gallery}</section>
</main>
<script>
const links=[...document.querySelectorAll('nav a')],secs=[...document.querySelectorAll('main section')],q=document.getElementById('q');
function show(id){links.forEach(a=>a.classList.toggle('on',a.dataset.t===id));secs.forEach(s=>s.hidden=s.id!==id);try{localStorage.setItem('cat-tab',id)}catch(e){}filter()}
function filter(){const v=q.value.toLowerCase();document.querySelectorAll('main section:not([hidden]) tbody tr').forEach(r=>r.classList.toggle('hide',v&&!r.textContent.toLowerCase().includes(v)))}
links.forEach(a=>a.onclick=()=>{location.hash=a.dataset.t;show(a.dataset.t)});q.oninput=filter;
let start=location.hash.slice(1);try{start=start||localStorage.getItem('cat-tab')}catch(e){}
show(secs.some(s=>s.id===start)?start:'looks');
</script></body></html>`;
fs.writeFileSync(path.join(cat, 'index.html'), html);
console.log('wrote ColonistRace/docs/catalogues/index.html', (html.length / 1024).toFixed(0) + ' KB,', Object.values(byKind).flat().length, 'sheets');
