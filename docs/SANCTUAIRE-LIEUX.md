# Le Sanctuaire de Nelim : quels lieux pour quels scénarios

Relevé de la sauvegarde « Nelim's tribe » de Virginie, **version finale du 2026-10-04 22:39** (rivière finie, sept smileys, faune posée), carte de **250 x 250** cellules. Les coordonnées sont celles de RimWorld : `(x, z)`, x vers l'est, **z vers le nord**. Source : le terrain, les plantes, les bâtiments et les animaux lus dans le fichier `.rws`. Les lieux marqués **(photographié)** ont été confirmés par des captures du ticket `pickletools-sanctuary-survey` sur la version de 19:24 ; les autres sont lus dans le fichier et à confirmer par une capture. Cahier des charges : [SANCTUAIRE.md](SANCTUAIRE.md). Chargement : `Given the save "Nelims-tribe" is loaded`, avec `-DepMap wsl-deps.sanctuary.map` ; le fichier est `ScreenshotStudio/Mod/Pickle/Fixtures/Nelims-tribe.rws` (Git LFS).

**Version et mods :** la sauvegarde liste 23 mods (DLC, Harmony, Pickle, PickleTools et ses compagnons, quelques mods de chargement). **Aucun mod de contenu : rien d'autre que du vanilla sur la carte.**

## Qui vit dans la sauvegarde

**Un seul colon : Nelim**, dans la maison en `(178, 121)`. Besoins à la sauvegarde : nourriture 0,73, repos 0,26, distraction 0,36. Les suites chargent la partie **en pause**, donc rien ne bouge ; un scénario qui fait avancer le temps doit d'abord lui redonner à manger et à se reposer. Un mod qui a besoin d'autres personnages les ajoute lui-même, selon son scénario : `a colonist "X" exists`, `"X" stands at (x, z)`, `"X" wears "Apparel_…"` (steps de ColonistRace et de Pickle), et les retire en fin de scénario.

Les autres pions de la carte sont **des animaux : 241, de 41 espèces**. Ils y sont déjà, ils ne sont pas à ajouter par les suites.

## La carte en bref

| Élément | Cellules | Ce que c'est |
|---|---|---|
| Rivière | x 105-126, de z 0 à z 250 | Eau profonde au milieu, eau peu profonde de chaque côté. **Finie en amont (2026-10-04)** : de z 60 à z 0 elle rétrécit (7 cellules d'eau profonde à z 60, 3 à z 0), serpente (centre entre x 109 et x 120), a des hauts-fonds, une berge de gravier et des roseaux, et sort de la carte par le bas. Raccord au-dessus de z 60 sans coupure. **(photographié)** |
| Maison | x 171-210, z 105-125 | Deux grandes pièces (parquet) et pièces annexes, murs en bois, portes. **(photographié)** |
| Cabane | x 134-146, z 68-78 | Petit bâtiment seul, parquet, murs en bois, à environ 10 cellules de la berge ouest. **(photographié)** |
| Cour de gravier | x 150-185, z 130-155 ; x 150-170, z 85-105 | Sol plat, quelques meubles et lampes. **(photographié)** |
| Bassins | x 148-200, z 158-188 | Plusieurs poches d'eau reliées, nénuphars et roseaux. **(photographié)** |
| Plantation de riz | x 216-240, z 104-136 | Rangées de riz. **(photographié)** |
| Enclos | x 180-200, z 78-96 | Clôtures et portillon. |
| Forêt de bambous | tout le reste | Un bambou par cellule : ouest, sud, nord. Les smileys y sont dégagés. |
| Smileys | voir plus bas | Moquette orange sous les bambous, un disque dégagé par smiley. |

## Les lieux par type de scénario

| Type de scénario | Lieu | Pourquoi |
|---|---|---|
| **Bâtiment, façade et vue d'ensemble** | Maison, cadre `(190, 115)` zoom 15 | Seul grand bâtiment, deux pièces lisibles, lumière et meubles en place. **(photographié)** |
| **Intérieur d'une pièce** | Maison, pièces à x 173-190 (ouest) et x 192-208 (est), z 106-124 | Parquet, meubles de bord, centre libre pour poser un sujet. |
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

Sept smileys de moquette orange de 19 x 19 cellules, dégagés de bambou, plus les grands. Cadrage conseillé : la cellule du centre, zoom 15.

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
