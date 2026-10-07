# Étude : tri automatique de l'ordre de chargement d'un staging Pickle

Date : 2026-10-07. Étude seule, rien d'implémenté. Cible : `scripts/stage-pickle-wsl.sh` (écriture de `<activeMods>` aux lignes ~487-500, placement manuel lignes ~270-430), BACKLOG.md « Load order of a test staging, sorted like RimSort ».

## 1. Comment RimSort trie

Sources réellement lues (WebFetch) :
- https://github.com/RimSort/RimSort : licence **GPL-3.0**, Python, Windows/Linux/Mac.
- https://rimsort.github.io/RimSort/ : deux algorithmes (Alphabétique, Topologique), règles venant des règles communautaires, des auteurs de mods (About.xml) et de l'utilisateur.
- https://raw.githubusercontent.com/RimSort/RimSort/main/app/sort/topo_sort.py : tri par **niveaux** via la bibliothèque PyPI `toposort` (pas Kahn maison) ; chaque niveau est un ensemble sans dépendance interne, trié **alphabétiquement par nom** (minuscules) : déterministe. Sur cycle (`CircularDependencyError`) : cycles listés avec NetworkX `simple_cycles`, avertissement, puis **le tri s'arrête** (exception relancée).
- https://raw.githubusercontent.com/RimSort/RimSort/main/app/sort/dependencies.py : seulement des parcours (sous-graphe d'un niveau, dépendances directes/inverses récursives). Ne lit pas loadAfter lui-même.
- https://github.com/RimSort/Community-Rules-Database : `communityRules.json`, champs `loadBefore`, `loadAfter`, `loadFirst`, `loadLast`. **Licence non indiquée** sur la page (pas de LICENSE vu).
- Répertoire `app/sort/` : `alphabetical_sort.py`, `dependencies.py`, `mod_sorting.py`, `topo_sort.py`.

Le constructeur du graphe (lecture des champs About.xml, niveaux 0/1/2/3, traitement des mods absents) n'a pas pu être lu : `app/utils/metadata.py` renvoie 404, le wiki ne contient rien de la section tri.

Réutilisation : le code est GPL-3.0, donc l'embarquer ou le porter oblige à publier sous GPL ; les outils de ce dépôt sont-ils concernés ? À trancher. Les **données** `communityRules.json` : licence inconnue, à vérifier avant toute copie. Un algorithme (tri topologique avec départage alphabétique) n'est pas protégé : l'écrire soi-même est sans risque.

## 2. Options de réutilisation depuis bash/WSL

Vérifié : `wsl.exe -- bash -c 'which node python3'` : **python3 3.12.3 présent** (`/usr/bin/python3`) ; node, xmllint : non listés dans la sortie (absents ou non trouvés ; à reconfirmer).
- A. Appeler RimSort sans interface : aucun mode CLI/headless trouvé dans la doc lue. Écarté (GUI Qt, dépendances lourdes, GPL).
- B. **Script Python 3 maison**, stdlib seulement (`xml.etree`, `graphlib.TopologicalSorter`), lit les About.xml des dossiers déjà copiés dans `$GAME/Mods` : le plus simple, déterministe, sans dépendance. **Recommandé.**
- C. Règles communautaires en plus : optionnel, phase 2 (fichier téléchargé et mis en cache, licence à clarifier). Les About.xml portent déjà l'essentiel (voir §3 : les mods de nos maps déclarent presque tous leurs loadAfter).

Règles d'About.xml à gérer : `modDependencies` (ordre : dépendance avant), `loadAfter`, `loadBefore`, `forceLoadAfter`, `forceLoadBefore` (le jeu les traite comme des arêtes ; non vérifié ici : la différence exacte loadAfter / forceLoadAfter), variantes `…ByVersion` (dossier de version 1.6 : lire `About.xml` puis les balises `loadAfterByVersion/<v1.6>` ; le script de Mlie lit déjà un dossier `<version>/` : non vérifié pour About). Les arêtes vers un mod non activé sont ignorées.

## 3. Placement manuel actuel et effet du tri

À conserver (tête fixe, pas déductible d'About.xml, ou déductible mais plus sûr en dur) : `brrainz.harmony` d'abord, puis `ludeon.rimworld` et les DLC, `rimworks.rimlogging`, `rimworks.pickle`. En queue : le mod sous test puis sa suite de tests (`${MOD_KEY}PickleTests`). Le mod sous test doit rester dernier même si le tri voudrait autre chose : arête « après tous » ajoutée par le script. (Les mods `first:` : le tri les place par arêtes ; aucun `first:` dans les maps actuelles, voir ci-dessous.)

Inventaire (grep des `*/[Tt]ests/Pickle/wsl-deps*.map`, hors `nelim.*` et DLC `!ludeon…`) : 191 packageIds distincts ; 176 retrouvés dans `workshop/content/294100`, 15 absents du Workshop (`ancientbld.core`, `atlas.androidtiers`, `ceteam.combatextended`, `dipsy.diapers`, `flangopink.animalturretpacks`, `gugustar.snowrabbitracebeta`, `malistaticy.mer`, `neronix17.outland.core`, `owlchemist.animalgear.equipment`, `predatorking.funnycreatures`, `sarg.magicalmenagerie`, `spankyh.bunrace.core`, `thegoofyone.beefeaters`, `vanillaexpanded.achievements`, `vanillaracesexpanded.waster` : mods locaux, ids de recherche différents ou non téléchargés ; non élucidé).
Marqueurs : un seul `last:` (`TailorMadeWaistlines/Tests/Pickle/wsl-deps.gallery.map` : `last:astryl.tailormade`), aucun `first:`.
Parmi les 176 trouvés, la grande majorité déclare `loadAfter` (très souvent `brrainz.harmony`, `Ludeon.RimWorld`, `OskarPotocki.VanillaFactionsExpanded.Core`). Exemples avec arêtes entre mods des maps (extrait de mon script, 70 premières lignes de sortie lues, la suite non lue) : `astryl.tailormade` après `tiagocc0.FemaleBodyVariants` ; `memegoddess.giddyup` loadBefore `dylan.animalgear` ; `akairo.letshaveacat` après `SamBucher.ADogSaidAnimalProsthetics2` ; `kura.extrastone` après `sarg.alphaanimals` ; `adaptive.storage.framework` loadBefore `…VanillaFactionsExpanded.Core` ; `ab.vplrf` loadBefore `LanYv.HoomanCuteReborn` ; `mlie.rc2.core` / `mlie.vanillalikewheat` après `syrchalis.processor.framework` ; `dankpyon.medieval.overhaul` après VFE Core et processor.framework + forceLoadAfter RoyaltyPatches. Les `incompatibleWith` présents entre mods qu'une même map pourrait activer : `dajian.chiteaditional.expanded` vs `….oldmode` vs `ninedaylongbow.chinesecomprehensiveexpansion`. Limite : l'union de toutes les maps n'est pas une passe réelle ; l'impact exact se calcule par passe.

## 4. Risques

- **Cycles** : voir §A ci-dessous.
- **Mods absents** : arête vers un mod non staged = ignorée ; pas d'échec. Un `modDependencies` absent est déjà une erreur du script (`copy_steam`).
- **Déterminisme** : départage par packageId minuscule (RimSort : par nom ; packageId est plus stable). Entrée = contenu des About.xml copiés ; même staging = même ordre.
- **Traçabilité** : écrire dans le journal de run l'ordre final + les arêtes appliquées + cycles/arêtes rompues + incompatibilités ; sinon « l'ordre prouvé par la passe » n'est plus lisible (exigence BACKLOG).
- **Coût** : ~100-200 mods, parse XML Python < 1 s ; première exécution WSL de python sur /mnt/c lente (le balayage de 9051 dossiers workshop a pris > 2 min : ne lire que les dossiers stagés, jamais le Workshop entier).
- **Changement de comportement** : tous les passes existantes changent d'ordre ; les preuves archivées ne sont plus rejouables à l'identique. Prévoir un mode `--legacy-order` temporaire ou un drapeau dans le journal.

## A. Addendum : boucles infinies

Le tri et tout parcours de dépendances doivent se terminer sur cycle : utiliser `graphlib.TopologicalSorter` (lève `CycleError` avec le cycle), ou marquer les nœuds visités. Politique proposée : détecter, **lister le cycle dans le journal**, rompre de façon déterministe en retirant l'arête `loadAfter` dont la source a le packageId le plus grand dans l'ordre alphabétique (jamais une arête `modDependencies` ni une arête de la tête fixe), puis continuer ; si le cycle ne contient que des `modDependencies`, arrêter le staging avec message clair. RimSort, lui, s'arrête (lu dans topo_sort.py) : on ne fait pas pareil exprès, un test ne doit pas dépendre d'une fenêtre. Le script actuel n'a pas de parcours récursif (dépendances dures lues à plat : lignes ~377-392), donc aucune boucle aujourd'hui.

## B. Addendum : incompatibilités

`incompatibleWith` (About.xml, vu dans les données : ex. `adamas.bees`, `memegoddess.giddyup`, `kentington.saveourship2`) et règles communautaires « incompatible » (hors champs listés de communityRules.json : `loadBefore/After/First/Last` seuls vus ; non vérifié si une clé incompatible existe). Proposition : après le tri, si deux mods actifs sont déclarés incompatibles (dans un sens ou l'autre) : **avertir en clair dans le journal** et échouer par défaut (le jeu les décline ou affiche une alerte qui fausse la passe), sauf dans une passe qui s'intitule `incompat-*` (existent déjà : `wsl-deps.incompat-original.map`, `incompat-magicalmenagerie.map`) où c'est le but du test : alors seulement un avertissement. Décision à valider par la propriétaire.

## C. Addendum : doublons

- Même packageId depuis deux dossiers : cas déjà géré (`stage-pickle-wsl.sh:418`, « overlay replaces … » : le mod overlay remplace la copie de base, `is_active` empêche la double activation). Le tri doit **dédoublonner par packageId minuscule avant** de construire le graphe et refuser tout doublon restant (erreur, pas avertissement).
- Deux mods qui font le même travail : non détectable par About.xml. Pistes : règles `incompatibleWith` et la base de remplacements (D). Rien à automatiser en phase 1.

## D. Addendum : « Require This Instead »

Vérifié : recherche web + page workshop `search "Require This Instead"` : **aucun mod de ce nom trouvé**. Ce qui existe : **« Use This Instead »** (UTI, Mlie, packageId `Mlie.UseThisInstead`, présent dans le Workshop local, dossier 3396308787) : https://github.com/emipa606/UseThisInstead : suggère des remplaçants à jour d'un mod abandonné ; base `replacements.json.gz` à la racine du dépôt, licence **MIT**, C#. Supposition : RTI = UTI mal retenu, ou « Resolve This Instead » (`nelim.resolvethisinstead`, mod de la propriétaire, `ResolveThisInstead/Mod/About/About.xml`) qui lit les données de UTI. À confirmer avec elle.
Relation avec le tri : la base de remplacement dit « ancien mod X → mod Y » ; utile pour (1) détecter qu'un mod de la map est obsolète, (2) refuser X et Y actifs ensemble (doublon), (3) traduire un `loadAfter: X` en `loadAfter: Y` si X est absent mais Y actif (c'est exactement ce que Resolve This Instead fait côté jeu pour les MayRequire). Le fichier `.gz` est lisible par Python (`gzip` + `json`), schéma non examiné. Phase 2 seulement.

## E. Précision de la propriétaire (2026-10-07) : « Require This Instead » = Resolve This Instead (RTI)

Le mod que la propriétaire appelle « Require This Instead », actuellement inactif, est très probablement son mod `Resolve This Instead` (`ResolveThisInstead/`, packageId `nelim.resolvethisinstead`, code `RtiMod.cs`) : lu dans son `README.md` et son `STATUS.md` par Pickle Tools, pas par l'étude. Ce n'est PAS « Use This Instead » (Mlie), dont il reprend les données (MIT) en dépendance dure. Statut lu : très début de développement, un moteur de résolution avec tests unitaires et une preuve de concept jamais jouée ; rien de publié.

Ce qu'il fait : quand un mod demande « X est-il chargé ? » et que X est absent mais qu'un successeur connu de X est chargé, il répond oui. Lien avec le tri : (1) un mod remplacé n'a pas à être chargé si son successeur l'est ; (2) l'ancien et son successeur ne sont pas des doublons à signaler ni des incompatibles, ce sont le même mod à deux époques ; (3) ses règles (le fichier de Use This Instead) sont la source naturelle pour détecter ces remplacements. Non vérifié : le code d'RTI en détail, et que ce soit bien le mod visé.

## 5. Conception minimale recommandée

1. Nouveau `scripts/sort-load-order.py` (Python 3 stdlib, lancé depuis bash en WSL) : entrée = liste des dossiers de `$GAME/Mods` + liste de tête fixe ; sortie = packageIds triés sur stdout, diagnostics sur stderr.
2. Lire About.xml de chaque dossier stagé (balises racine + bloc version 1.6 pour `…ByVersion`), packageId en minuscules.
3. Arêtes : `modDependencies`, `loadAfter`, `forceLoadAfter` (X après Y), `loadBefore`, `forceLoadBefore` (inverse) ; ignorer les ids non stagés.
4. Tête fixe (harmony, ludeon.rimworld + DLC, rimlogging, pickle) toujours devant ; mod testé + suite toujours en queue ; ajoutés comme contraintes.
5. `graphlib.TopologicalSorter` avec départage par packageId minuscule (déterministe) ; cycle : politique §A.
6. Dans `stage-pickle-wsl.sh` : après les copies, appeler le script, remplacer `active+=` hand-built par sa sortie, supprimer `first:`/`last:`/`LAST`/`in_last`, nettoyer WELCOME.md et la map `wsl-deps.gallery.map`.
7. Journal de run : ordre final, arêtes retenues, cycles rompus, incompatibilités.
8. Tests (`scripts/Tests/test-stage-pickle-wsl.sh`, bac à sable) : loadAfter simple ; loadBefore ; cycle de 3 mods ; id absent ; doublon de packageId ; incompatibleWith (échec / `incompat-`) ; tête fixe et queue ; déterminisme (deux runs identiques) ; cas TailorMade/FemaleBodyVariants.
9. Phase 2 (optionnelle) : règles communautaires + base UTI, après avoir tranché les licences.

## Non vérifié

- Le constructeur du graphe de RimSort (niveaux, champs About.xml lus, mods absents), faute d'accès à `metadata.py` ; les niveaux 0-3 ne sont pas confirmés.
- Licence de `communityRules.json` (aucun fichier LICENSE vu) ; schéma de `replacements.json.gz`.
- Différence exacte `loadAfter` / `forceLoadAfter` dans le jeu ; lecture des blocs `…ByVersion`.
- Présence de node dans WSL (seul python3 confirmé) ; les 15 ids absents du Workshop.
- Liste complète des mods avec loadAfter dans les maps : seules les ~70 premières lignes de sortie ont été lues ; l'impact exact par passe n'est pas calculé.
- Existence d'une clé « incompatible » dans les règles communautaires.
- Existence réelle d'un mod « Require This Instead » (non trouvé).
