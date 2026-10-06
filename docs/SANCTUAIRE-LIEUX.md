# Le Sanctuaire de Nelim : quels lieux pour quels scénarios

Relevé de la sauvegarde « Nelim's tribe » de Virginie, **version finale du 2026-10-04 à 22 h 39, heure locale de Virginie (GMT+2)** (rivière finie, sept smileys, faune posée), carte de **250 x 250** cellules. Les coordonnées sont celles de RimWorld : `(x, z)`, x vers l'est, **z vers le nord**. Source : le terrain, les plantes, les bâtiments et les animaux lus dans le fichier `.rws`. Les lieux marqués **(photographié)** ont été confirmés par des captures du ticket `pickletools-sanctuary-survey` sur la version de 19 h 24 (heure locale) ; les autres sont lus dans le fichier et à confirmer par une capture. Cahier des charges : [SANCTUAIRE.md](SANCTUAIRE.md). Chargement : `Given the save "Nelims-tribe" is loaded`, avec `-DepMap wsl-deps.sanctuary.map` ; le fichier est `ScreenshotStudio/Mod/Pickle/Fixtures/Nelims-tribe.rws` (Git LFS).

**Version et mods :** la sauvegarde liste 23 mods (DLC, Harmony, Pickle, PickleTools et ses compagnons, quelques mods de chargement). **Aucun mod de contenu : rien d'autre que du vanilla sur la carte.**

## Qui vit dans la sauvegarde

**Un seul colon : Nelim**, dans la maison en `(178, 121)`. Besoins à la sauvegarde : nourriture 0,73, repos 0,26, distraction 0,36. Les suites chargent la partie **en pause**, donc rien ne bouge ; un scénario qui fait avancer le temps doit d'abord lui redonner à manger et à se reposer. Un mod qui a besoin d'autres personnages les ajoute lui-même, selon son scénario : `a colonist "X" exists`, `"X" stands at (x, z)`, `"X" wears "Apparel_…"` (steps de ColonistRace et de Pickle), et les retire en fin de scénario.

Les autres pions de la carte sont **des animaux : 241, de 41 espèces**. Ils y sont déjà, ils ne sont pas à ajouter par les suites.

## La carte en bref

| Élément | Cellules | Ce que c'est |
|---|---|---|
| Rivière | x 105-126, de z 0 à z 250 | Eau profonde au milieu, eau peu profonde de chaque côté. **Finie en amont (2026-10-04)** : de z 60 à z 0 elle rétrécit (7 cellules d'eau profonde à z 60, 3 à z 0), serpente (centre entre x 109 et x 120), a des hauts-fonds, une berge de gravier et des roseaux, et sort de la carte par le bas. Raccord au-dessus de z 60 sans coupure. **(photographié)** |
| Maison | x 171-210, z 105-125 | **Trois pièces** (Virginie, 2026-10-04) : la grande salle ouest (parquet, x 172-191, z 106-124, avec coin lit, salon, foyer et table), la pièce à damier au nord-est (x 202-209, z 114-123) et la pièce moquettée au sud-est (tapis bleu, piano) ; la zone en brique entre la salle et le damier est un passage. Murs en bois, panneaux coulissants. Limites des deux pièces de l'est lues sur la capture, à confirmer dans le fichier. **(photographié)** |
| Cabane | x 134-146, z 68-78 | Petit bâtiment seul, parquet, murs en bois, à environ 10 cellules de la berge ouest. **(photographié)** |
| Cour de gravier | x 150-185, z 130-155 ; x 150-170, z 85-105 | Sol plat, quelques meubles et lampes. **(photographié)** |
| Bassins | x 148-200, z 158-188 | Plusieurs poches d'eau reliées, nénuphars et roseaux. **(photographié)** |
| Plantation de riz | x 216-240, z 104-136 | Rangées de riz. **(photographié)** |
| Enclos à plantes | x 180-200, z 78-96 | Clôtures et portillon : **un enclos pour les plantes, pas pour les animaux**. |
| Forêt de bambous | tout le reste | Un bambou par cellule : ouest, sud, nord. Les smileys y sont dégagés. |
| Smileys | voir plus bas | Moquette orange sous les bambous, un disque dégagé par smiley. |

## Les lieux par type de scénario

| Type de scénario | Lieu | Pourquoi |
|---|---|---|
| **Bâtiment, façade et vue d'ensemble** | Maison, cadre `(190, 115)` zoom 15 | Seul grand bâtiment, deux pièces lisibles, lumière et meubles en place. **(photographié)** |
| **Intérieur d'une pièce** | Maison : salle ouest `(181, 115)` (nom de cadre `hearth-hall`), pièce à damier `(205, 118)`, pièce moquettée `(200, 109)` | Parquet, meubles de bord, centre libre pour poser un sujet. Cadre des deux dernières : `I frame the cell` zoom 12. |
| **Petit bâtiment seul, « bâtiment au bord de l'eau »** | Cabane, cadre `(140, 73)` zoom 12, rivière à l'ouest | Un seul bâtiment, berge proche (spec § 26 : « bâtiment au bord de l'eau, loutre dans le canal »). **(photographié)** |
| **Sujet posé en terrain dégagé (décor pris puis retiré par StageDecor)** | Carrés libres : **A** `(191-204, 146-159)`, **B** `(176-189, 147-160)` (14 x 14) ; **C** `(105-117, 154-166)` (13 x 13) ; **D** `(132-143, 48-59)`, **E** `(223-234, 48-59)`, **F** `(178-189, 49-60)`, **G** `(86-97, 93-104)`, **H** `(169-180, 195-206)` (12 x 12, au cœur d'un smiley) ; **I** `(195-205, 181-191)` (11 x 11) ; **J** `(59-68, 173-182)` (10 x 10) | Aucune plante, aucun bâtiment, aucune eau : on pose, on photographie, `the decor is removed`. **Taille maximale d'un bâtiment à photographier : 14 x 14** ; au-delà, passer par la cour de gravier. Les carrés D à H sont sur la moquette orange d'un smiley : fond vif, à éviter pour un test qui veut du neutre. |
| **Grand bâtiment (plus de 14 cellules)** | Cour de gravier `(150-185, 130-155)` | Terrain plat de 35 x 25, mais parsemé de meubles et de lampes : la dégager avec `the area from … to … is cleared` avant. |
| **Eau, canal, faune aquatique** (loutre, canard, cygne) | Bassins `(148-200, 158-188)` ; rivière à hauteur de la maison `(110-146, 96-124)` ; rivière en amont `(105-120, 0-60)` | Eau peu profonde et profonde, rives dégagées. Cygnes, canards et loutres y sont déjà (voir faune). |
| **Rivière sauvage, amont** | `(114, 30)` zoom 20 | Berges de gravier, hauts-fonds, roseaux, bambouseraie des deux côtés. |
| **Faune de la maison** (chat, labrador) | Maison et alentours `(165-212, 100-130)` | Chats en `(191, 113)` et `(199, 104)`. |
| **Faune de la bambouseraie** (thrumbo, panda) | Pandas en `(110, 166)` et `(140, 217)` ; bambouseraie sud `(150-190, 20-50)` | Végétation dense, fond vert uniforme. |
| **Cultures** | Plantation de riz `(216-244, 100-140)` | Rangées régulières. |
| **Plans larges, vue d'ensemble du Sanctuaire** | Cadre `(100, 60)` à `(250, 190)` en zoom 70 | Rivière, maison, bassins et smileys dans le même plan. |
| **Fond neutre, végétation seule** | Bambouseraie sud `(150-190, 20-50)` | Aucun bâtiment, aucun sol différent. |

## Les smileys

Il y a plus de sept smileys de moquette orange de 19 x 19 cellules, dégagés de bambou, plus les grands. Seuls ces sept ont un nom, parce qu'ils servent de cadrage ; les autres n'en ont pas, et nous n'en créons pas sans besoin d'un mod (voir "Aucun lieu ne convient" dans GALERIE.md). Cadrage conseillé : la cellule du centre, zoom 15.

| Smiley | Centre | Cellules | Remarque |
|---|---|---|---|
| Sud-ouest | `(67, 177)` | x 58-76, z 169-186 | **(photographié)** yeux et bouche sombres, un œil clair. |
| Bas, ouest | `(139, 56)` | x 130-148, z 47-65 | Posé par Virginie le 2026-10-04. |
| Bas, centre | `(185, 56)` | x 176-194, z 48-65 | idem |
| Bas, est | `(230, 56)` | x 221-239, z 47-64 | idem |
| Ouest | `(93, 100)` | x 84-102, z 92-109 | idem |
| Nord-ouest, rivière | `(113, 160)` | x 104-122, z 152-169 | À côté du fleuve. |
| Nord | `(176, 202)` | x 167-185, z 194-211 | idem |
| Grand, est-sud | `(223, 168)` | x 205-246, z 148-187 | **(photographié)** 36 x 36, orange avec yeux et bouche sombres. |
| Grand, est, près de la maison | `(223, 118)` | x 205-240, z 101-136 | Sous la plantation de riz. |
| Lointain ouest | `(20, 118)` | x 7-32, z 99-137 | Deux couleurs de sol, **caché sous les bambous** (photographié, invisible). |
| Lointain nord-ouest | `(14, 235)` | x 2-27, z 227-243 | 26 x 17. |

## La faune de la sauvegarde

Posée par Virginie, **au-delà des cinq animaux permanents du cahier des charges**. Le relevé donne des positions, pas des scénarios : un test qui compte des animaux doit lire le jeu, pas ce tableau.

| Famille | Espèces et nombres |
|---|---|
| Compagnons du Sanctuaire | Chat 3 (maison), Labrador 2 `(107, 150)` et `(137, 76)`, Thrumbo **2** en `(177, 120)` et `(179, 107)` (**dans la maison** : le cahier des charges en prévoit un seul, dans le jardin ou la bambouseraie), Panda 2, Loutre 4, Cygne 10, Canard 3 |
| Petite faune | Moineau 14, Écureuil 11, Cochon d'Inde 11, Ara 11, Chinchilla 9, Flamant 9, Chien de prairie 10, Vison 10, Lièvre des neiges 10, Dinde 10, Lièvre 3, Paon 3, Héron 5, Corbeau 5, Vautour 8, Oiseau bleu 3, Tortue 7, Tatou 5, Porc-épic 1 |
| Grande faune et élevage | Cheval 13, Âne 8, Mouton 8, Poulet 8, Cochon 5, Vache 4, Bison 4, Mastodonte 3, Alpaga 3, Husky 3, Yorkshire 4, Boomalope 4, Ours grizzly 1, Lynx 1, Bouquetin 1 |

## Ce que ces lieux ne permettent pas encore

- **Un seul thrumbo en trop et des animaux dangereux** (ours, lynx, vautours, boomalopes) sont sur la carte : à décider avec Virginie s'ils restent.
- **Les noms exacts des sols** de la carte ne sont pas tous résolus (le prairie de base, la moquette orange et les couleurs des smileys) : le relevé est fait sur les valeurs du fichier, pas sur les noms de définitions.
- **Les nouveaux lieux (sept smileys, rivière) ne sont pas encore photographiés** sur la version du 22:39 : un ticket de repérage reste à faire une fois la sauvegarde copiée dans `Fixtures`.

## Les cadres nommés

Les mods n'écrivent pas de coordonnées. Ils nomment le lieu : `Given Nelim's Pickle Tools: I am at the sanctuary "<nom>"` (ou `When ... I frame the sanctuary "<nom>"`, même effet). Le nom règle la position (x, z) et le zoom ; la table ci-dessous donne les noms.
Ancien libellé, toujours valable : `Nelim's Pickle Tools: I frame the sanctuary "<nom>"` (ScreenshotStudio, `-DepMap wsl-deps.sanctuary.map`) centre la caméra et règle le zoom. Un nom inconnu échoue en listant les noms valides.

| Nom | Centre | Zoom | Ce que c'est |
|---|---|---|---|
| `overview-north`, `overview-south` | (125, 185) et (125, 65) | 60 | Vue d'ensemble en deux parties : la moitié haute (enclos, grange) puis la moitié basse. Une seule vue ne couvre pas les 250 cellules |
| `house` | (190, 115) | 15 | Maison entière |
| `hearth-hall` | (181, 115) | 12 | Salle de l'ermite (nom de Virginie) : le bâtiment principal, 19 x 19 cases. Lit de Nelim sur tapis blanc (nord-ouest), salon au tapis rose (nord-est), foyer central à pierres (centre), deux braséros (est), table à manger sur tapis blanc (sud-ouest). Des animaux y dorment : les retirer avec l'étape « the animals are removed » si le test veut la salle vide ; en japonais, irori no ma |
| `statue-garden` | (155, 97) | 13 | Jardin aux statues, ou place des statues (noms de Virginie) : statues et sculptures au sud, et le champ de petites fleurs jaunes qu'elle y a intégré au nord, entre la rivière et le mur ouest de la maison ; large cadre de 75 x 42 cases |
| `prestige-hall` | (196, 111) | 8.5 | Salle de prestige : table à manger sur tapis gris, porte ornée à l'est, piano blanc (sud-est), sol brun, 8 cases de large |
| `ritual-hall` | (206, 117) | 8 | Salle des rituels, ou salle de l'idéologie (Temple, Sanctuaire) : sol à damier, barbier (station de coiffure), harpe, bibliothèque ; la plus à droite de la maison. Deux appareils y affichent l'éclair « sans courant » |
| `terrace` | (197, 123) | 9 | Terrasse, ou véranda (noms de Virginie, confirmés sur sa capture) : zone de brique à ciel couvert, sol sombre, un piano noir, entre la salle aux foyers, la salle des rituels et l'extérieur |
| `plant-garden` | (190, 85) | 11 | Jardin des plantes (enclos du bas) |
| `hut` | (140, 67) | 12 | Salon de thé (nom de Virginie) : la cabane de bois au bord de l'eau, table basse et deux sièges, banc en bas ; juste au-dessus du smiley `smiley-bottom-west`. Alias : `tea-room` |
| `fishing-zone` | (114, 68) | 12 | Même lieu que `water-zone` : c'est la zone de pêche (Virginie), la mare ronde du bas de la rivière, sans nénuphars ; à utiliser pour une scène de pêche ou de pêcheur |
| `water-garden` | (167, 173) | 14 | Jardin aquatique (nom de Virginie, ex-`pools`) : mare avec nénuphars, fleurs mauves, canards, joncs sur les bords ; bambou au nord |
| `gravel-yard` | (170, 143) | 14 | Cour de gravier |
| `emerald-clearing` | (197, 152) | 12 | Carré libre A (14 x 14, x 191-204, z 146-159) : terre nue, la pile vanométrique en bordure est (x 205) |
| `enclosure` | (158, 224) | 22 | Enclos total (nom de Virginie) : les deux enclos à animaux clôturés dans la bambouseraie du nord, 58 x 42 cases (x 130-187, z 204-245, 196 éléments de clôture), au nord du smiley `smiley-north` ; l'enclos du bas contient la zone de culture verte |
| `enclosure-south` | (149, 214) | 12 | Le petit enclos, celui du bas (x 130-168, z 204-223) : il contient la zone de culture verte ; clos, avec des portails en (159, 207) au sud et (130, 219) à l'ouest, et en (148, 223) et (163, 223) vers l'enclos du haut |
| `enclosure-north` | (166, 235) | 13 | L'enclos du haut (x 144-187, z 224-245, 44 x 22), au nord-est du précédent |
| `rice-paddies` | (229, 114) | 20 | Rizières, ou « le champ » (noms de Virginie) : riz planté (106 plants, x 184-239, z 82-133) autour de la grand-place |
| `cotton-field` | (211, 114) | 20 | Champ de coton : le grand smiley orange, au sud-est de la maison (nom de Virginie) ; estimation à confirmer |
| `exhibition-zone` | (225, 168) | 21 | Zone d'expo (nom de Virginie, ex-`smiley-east`) : le grand smiley du sud-est, sol de moquette orange, un objet par case pour l'exposition ; 39 cases de large. Alias : `grand-place` (même lieu, regroupé le 2026-10-05) |
| `calm-zone` | (193, 187) | 11 | Zone calme (nom de Virginie) : le rectangle blanc au-dessus de la zone d'expo. Position mesurée sur la vue d'ensemble, à confirmer | Alias : `cream-clearing`. Décalé de 20 cases vers la gauche (revue de Virginie) |
| `dump` | (49, 236) | 20 | Décharge (nom de Virginie) : le carré rose dans la clairière la plus haute, en haut à gauche de la carte. Position mesurée sur la capture (carré rose, bambouseraie clairsemée autour). Alias : `décharge` |
| `smiley-southwest`, `smiley-bottom-west`, `smiley-bottom-centre`, `smiley-bottom-east`, `smiley-west`, `smiley-river`, `smiley-north` | voir la table des smileys | 15 | Les sept smileys de 19 x 19 |

**Heure et météo.** La sauvegarde de Virginie date de 23 h : les captures sont sombres. Un scénario qui veut la lumière du jour commence par `I set the hour to 12` et `I set the weather to "Clear"`. La fixture finale sera enregistrée à midi par le ticket de finition.

**L'enclos à animaux** n'existe pas dans la sauvegarde de Virginie ; il est ajouté par `pickletools-sanctuary-finish.feature` sur le carré libre B (176-189, 147-160), des clôtures avec un portillon au sud et quelques moutons et vaches à l'intérieur. Le carré B n'est plus libre après ça.

## Vider un lieu

Si un lieu est trop encombré pour un test, le scénario le vide : `Given Nelim's Pickle Tools: the sanctuary "<nom>" is emptied` (ou `When ... I empty the sanctuary "<nom>"`). Meubles, objets, plantes, saleté et cadavres disparaissent ; murs, portes et personnages restent. Pour les quatre pièces (`hearth-hall`, `prestige-hall`, `ritual-hall`, `terrace`, `cloister`) la zone est la pièce ; pour les autres lieux, la zone est le carré de la photo. La sauvegarde sur disque n'est pas modifiée : seul le run en cours est vidé.

## Captures à vide

Chaque lieu nommé a sa photographie, prise sans mod testé, de jour et sans interface : `Tests/Pickle/Evidence/sanctuaire-places/screenshots/manual--sanctuary-<nom>--step0.png` (feature `pickletools-sanctuary-places`, ainsi que `…-<nom>-empty` pour les pièces et jardins vidés). Un mod compare sa scène à cette photographie : ce qui diffère est à lui, le reste est décor.

## Manque de zones libres

Les carrés libres A à J ne suffisent-ils pas ? On retire du bambou (étape `the area from (x, z) to (x, z) is cleared`) pour en ouvrir d'autres, dans la sauvegarde finale, après accord de Virginie : demandez la taille voulue.

## Besoins particuliers : demandez

Cette doc décrit ce qui existe aujourd'hui, pas ce qui est figé. Si un mod qui utilise le Sanctuaire a un besoin particulier (un lieu à nommer, une zone libre plus grande, du bambou à retirer, une pièce à vider, plus de fleurs autour d'une zone, un autre cadrage), il le demande à la session PickleTools (NPT) : le lieu évolue au cas par cas, selon les besoins réels des mods. Ne modifiez pas la fixture vous-mêmes.

## Électricité : pile vanométrique

Une pile vanométrique (`VanometricPowerCell`, 1 x 2, 1000 W en continu, sans combustible, transmet le courant aux bâtiments contigus) est posée en permanence à côté du carré libre A, en `(205, 152-153)` : le bord est du carré A est la colonne x = 204. Un mod qui photographie un objet électrique le pose dans le carré, **contre la pile** (par exemple en `(204, 152)`), et il est alimenté sans conduit. Cadrage : `Given Nelim's Pickle Tools: I am at the sanctuary "power-cell"` (centre (204, 152), zoom 9). La pile éclaire un peu (rayon 3) : elle est visible sur la photographie à vide du lieu `clearing-a`. Il faut davantage de puissance : demandez.

## Lieux nommés ajoutés (positions à confirmer sur les captures à vide)

| Nom | Centre | Zoom | Ce que c'est |
|---|---|---|---|
| `sleeping-nook` | (177, 121) | 6.5 | Coin lit de Nelim, tapis blanc, dans la salle aux foyers |
| `sofa-corner` | (187, 123) | 3.5 | Salon au tapis rose, dans la salle aux foyers |
| `dining-nook` | (176, 108) | 3.7 | Table à manger sur tapis blanc, dans la salle aux foyers |
| `fire-pit` | (181, 115) | 5 | Foyer central de la salle aux foyers |
| `cloister` | (179, 130) | 7 | Cloître (渡り廊下) : galerie couverte de plancher de bois, à colonnes, au nord de la salle aux foyers, perpendiculaire à la rivière |
| `river-bridge` | (135, 126) | 11 | Pont de bois sur la rivière |
| `left-bank` | (112, 111) | 21 | Rive gauche (nom de Virginie) : la berge ouest de la rivière, du pont (en haut à droite) au smiley `smiley-west` (en bas à gauche), avec la bambouseraie dense entre les deux ; large cadre de 78 x 42 cases |
| `right-bank` | (144, 132) | 11 | Rive droite : berge est de la rivière, côté maison |

## Nettoyer et dégager (étapes)

- `Given Nelim's Pickle Tools: all filth is cleaned` : toute la saleté de la carte (sol sale, sang, cendre) disparaît. À appeler au début du scénario ; la fixture finale (`final2`) l'aura déjà fait.
- `Given Nelim's Pickle Tools: the animals are removed from the sanctuary "<nom>"` : les animaux du lieu sont retirés (pas tués), les colons restent. Utile pour les deux thrumbos de la salle aux foyers, par exemple `"sleeping-nook"` ou `"hearth-hall"`.
- `Given Nelim's Pickle Tools: the sanctuary "<nom>" is emptied` : meubles, objets, plantes, saleté.
- `Given Nelim's Pickle Tools: the roof is removed from the sanctuary "<nom>"` : retire tous les toits du lieu (murs gardés). Exception pour les tests, pas pour une capture de galerie : le toit fait partie du bâtiment photographié et sa suppression crée des ombres. Pour un lieu sombre, voir « Éclairer un lieu sombre » dans docs/GALERIE.md.
- `Given Nelim's Pickle Tools: the power network is refreshed` : connecte les bâtiments alimentés qui n'ont encore aucun réseau (ceux qui en ont un ne sont pas touchés) et recalcule les réseaux. À appeler après avoir posé le bâtiment, avant la capture. Si l'icône « sans courant » reste, c'est un manque réel de puissance : une pile vanométrique fournit 1000 W ; si le bâtiment en demande davantage, poser une deuxième pile contre la première (`VanometricPowerCell` en (205, 154), par exemple).

## Zoom minimum

La caméra du jeu ne s'approche pas au-delà de la taille de racine 11 environ (mesuré : 49 pixels par case sur un écran de 1080 pixels, soit 22 cases de haut sur 39 de large). Les petits lieux (une pièce, la terrasse, le cloître, le foyer, la pile) sont donc tous cadrés à 11 : la photographie montre le lieu et ses abords. Pour un cadrage plus serré, le mod recadre l'image lui-même ; une demande d'un zoom plus proche n'aboutirait pas.

## Le bâtiment nord : grange et ateliers

Au nord de la carte, collé à l'est de `enclosure-north` (x 187-218, z 229-245), un bâtiment de trois pièces que Virginie a ajouté le 5 octobre :

| Nom | Centre | Zoom | Ce que c'est |
|---|---|---|---|
| `workshops` | (203, 237) | 11 | Le bâtiment entier, 32 x 17 cases |
| `barn` | (193, 237) | 14 | La grange : grande salle de terre, à l'ouest, ouverte sur l'enclos (portes en (187, 232-233) et (187, 241)). Contient actuellement : une table de poker, une table de billard, des lits pour animaux (à vérifier sur la capture) |
| `preindustrial-workshop` | (205, 237) | 11 | Atelier préindustriel : sol carrelé beige, établis, matériaux |
| `postindustrial-workshop` | (214, 237) | 24 | Atelier postindustriel : sol clair, appareils (réfrigérateur, machines, générateur) |

**35 piles vanométriques** (`VanometricPowerCell`) bordent le mur est (x 219-221, z 228-246) et le côté nord (z 246, x 213-220) : l'atelier postindustriel est alimenté en permanence. Un mod qui photographie un objet électrique peut le poser dans cet atelier ou à côté d'une pile.

## Animaux mis en scène

Pickle ne retrouve par surnom que les colons libres : ces étapes (`AnimalSteps.cs`) posent un animal de la faction du joueur à une case, avec un surnom.

```gherkin
Given Nelim's Pickle Tools: an animal of kind "Megabee" named "Reine" is spawned at (197, 152) at life stage 0
Given Nelim's Pickle Tools: an animal of kind "Megabee" named "Reine" is spawned at (197, 152) at the life stage "AnimalBaby"
Given Nelim's Pickle Tools: an adult animal of kind "Megabee" named "Ouvrière" is spawned at (198, 152)
When Nelim's Pickle Tools: I frame the animal "Reine" at zoom 11
```

Le stade 0 est le plus jeune, le dernier est l'adulte. Pour un cliché d'animaux, `podium` (197, 152) et `enclosure-south` sont dégagés.

## Décisions de Virginie, 2026-10-05

- **Pile vanométrique** : elle reste où elle est, en `(205, 152-153)`, contre le podium. Elle alimente bien la salle voisine (1000 W).
- **Feu de camp** : gardé dans la sauvegarde, à proposer aux mods comme décor.
- **Animaux** de la sauvegarde : gardés (chimère, flamant, oiseaux...).
- **Smileys** : pas de nouveaux noms.

## Alias et lieux retirés (2026-10-05, revue de Virginie)

Doublons fusionnés : les anciens noms restent valables et mènent au lieu gardé. `tea-room` mène à `hut` ; `clearing-a`, `podium`, `emerald-podium` et `great-courtyard` à `emerald-clearing` ; `river` à `left-bank` ; `water-zone` à `water-garden`.

Retirés : `forest-edge`, `river-upstream`, `river-exit`, `power-cell`, `animal-pen` (les enclos ont été remontés : voir `enclosure`), `bamboo-south`, `bamboo-west`. Un step qui les nomme échoue en disant que le lieu a disparu et en listant les lieux connus.

## Limites de la caméra (mesurées 2026-10-05)

Le jeu borne la taille de la caméra à **11 minimum, 60 maximum** (`CameraMapConfig.sizeRange`) : un zoom demandé à 8 donnait 11, à 70 donnait 60. Les mods de caméra (SimpleCameraSetting, Camera+) élargissent cette plage ; le step de cadrage du Sanctuaire fait la même chose lui-même, de 2 à 130, sans mod supplémentaire. Les lieux serrés (`sofa-corner`, `dining-nook`...) utilisent donc des zooms sous 11. Les deux vues d'ensemble gardent 60 : `overview-north` couvre z 125 à 245 et `overview-south` z 5 à 125.
## Noms d'usage reconnus (alias)

Le nom d'un lieu est normalisé avant la recherche (accents retirés, minuscules, espaces, tirets bas et apostrophes remplacés par des tirets). Ces noms mènent aux lieux : `tea-room` à `hut` ; `statue-plaza` à `statue-garden` ; `hermit-hall` à `hearth-hall` ; `salle des rituels`, `salle de l'idéologie` à `ritual-hall` ; `véranda` à `terrace` ; `le champ`, `rizières` à `rice-paddies` ; `zone d'expo` à `exhibition-zone`.

Regroupés le 2026-10-05 : `grand-place` est un alias d'`exhibition-zone` (le même grand smiley) ; `cream-clearing` est un alias de `calm-zone`.
