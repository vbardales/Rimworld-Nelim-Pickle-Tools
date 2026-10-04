# Le Sanctuaire de Nelim : quels lieux pour quels scénarios

Relevé de la sauvegarde `Nelims-tribe` (copie, le 2026-10-04 19:24, de « Nelim's tribe » de Virginie), carte de **250 x 250** cellules. Les coordonnées sont celles de RimWorld : `(x, z)`, x vers l'est, **z vers le nord**. Source : le terrain, les plantes et les bâtiments lus dans le fichier `.rws` ; les captures du ticket `pickletools-sanctuary-survey` (`PickleTools/Tests/Pickle/Evidence/sanctuaire-survey/`) servent à confirmer chaque lieu. Cahier des charges : [SANCTUAIRE.md](SANCTUAIRE.md). Chargement : `Given the save "Nelims-tribe" is loaded`, avec `-DepMap wsl-deps.sanctuary.map` ; le fichier est `ScreenshotStudio/Mod/Pickle/Fixtures/Nelims-tribe.rws` (Git LFS).

**Cette sauvegarde est un instantané.** Virginie la complète (six smileys, rivière) : relire les cadres ci-dessous après chaque nouvelle copie.

## Qui vit dans la sauvegarde

**Un seul colon : Nelim.** Les autres pions de la carte sont des animaux (chats, chevaux, perroquets, loutres…, voir SANCTUAIRE.md § 24). Un mod qui a besoin d'autres personnages les ajoute lui-même, selon son scénario : `a colonist "X" exists`, `"X" stands at (x, z)`, `"X" wears "Apparel_…"` (steps de ColonistRace et de Pickle), et les retire en fin de scénario. Ne pas supposer d'autre colon dans une suite.

## La carte en bref

| Élément | Cellules | Ce que c'est |
|---|---|---|
| Rivière | x 110-140, de z 0 à z 250 | Cœur d'eau profonde large de 3 à 6 cellules, une cellule d'eau peu profonde de chaque côté. Droite et régulière sur z 0-65 : **à finir vers le bas** (Virginie), pas de rive ni de delta. |
| Maison | x 171-210, z 105-125 | Deux grandes pièces (parquet) et pièces annexes, murs en bois, portes. Plantations de riz à l'est. |
| Cabane | x 134-146, z 68-78 | Petit bâtiment seul, parquet, murs en bois, à environ 10 cellules de la berge ouest. |
| Cour de gravier | x 150-185, z 130-155 ; x 150-170, z 85-105 | Sol plat et dégagé, quelques meubles et lampes. |
| Bassins | x 148-200, z 158-188 | Plusieurs poches d'eau reliées, eau profonde au milieu. |
| Plantation de riz | x 216-240, z 104-136 | Rangées de riz, une pièce de terrain différent dessous. |
| Enclos | x 180-200, z 78-96 | Clôtures et portillon. |
| Forêt de bambous | tout le reste | Un bambou par cellule, très dense : ouest (x 0-110), sud (z 0-65), nord (z 190-250). |
| Smileys | voir plus bas | Dessinés par le terrain (une couleur de sol par smiley) sous la bambouseraie. |

## Les lieux par type de scénario

| Type de scénario | Lieu | Pourquoi |
|---|---|---|
| **Bâtiment, façade et vue d'ensemble** | Maison, cadre `(168, 102)` à `(213, 128)` | Seul grand bâtiment, deux pièces lisibles, lumière et meubles en place. |
| **Intérieur d'une pièce** | Maison, pièces à x 173-190 (ouest) et x 192-208 (est), z 106-124 | Parquet, meubles de bord, centre libre pour poser un sujet. |
| **Petit bâtiment seul, ou « bâtiment au bord de l'eau »** | Cabane, cadre `(132, 66)` à `(148, 80)`, rivière à l'ouest | Un seul bâtiment, berge proche (spec § 26 : « bâtiment au bord de l'eau, loutre dans le canal »). |
| **Sujet posé en terrain dégagé (décor pris puis retiré par StageDecor)** | Les quatre carrés libres : **A** `(191-204, 146-159)`, **B** `(176-189, 147-160)`, **C** `(195-205, 181-191)`, **D** `(59-68, 173-182)` | Aucune plante ni bâtiment ni eau sur 14 x 14 (A, B), 11 x 11 (C), 10 x 10 (D) : on pose, on photographie, `the decor is removed`. **Taille maximale d'un bâtiment à photographier : 14 x 14** ; au-delà, passer par la cour de gravier. |
| **Grand bâtiment (plus de 14 cellules)** | Cour de gravier `(150-185, 130-155)` | Terrain plat de 35 x 25, mais parsemé de meubles et de lampes : la dégager avec `the area from … to … is cleared` avant. |
| **Eau, canal, faune aquatique** (loutre, canard, cygne) | Bassins `(148-200, 158-188)` ; rivière à hauteur de la maison `(110-146, 96-124)` | Eau peu profonde et profonde à portée, rives dégagées. |
| **Faune de la maison** (chat, labrador) | Autour de la maison, engawa à l'ouest : `(160-172, 104-126)` | Herbe courte et gravier dégagés devant la façade. |
| **Faune de la bambouseraie** (thrumbo, panda) | Bambouseraie ouest `(26-66, 40-70)`, sud `(150-190, 20-50)` | Végétation dense, fond vert uniforme. |
| **Cultures** | Plantation de riz `(216-244, 100-140)` | Rangées régulières. |
| **Plans larges, vue d'ensemble du Sanctuaire** | Cadre `(100, 60)` à `(250, 190)` en zoom 70 | Rivière, maison, bassins et smileys dans le même plan. |
| **Fond neutre, végétation seule** | Bambouseraie sud `(150-190, 20-50)` | Aucun bâtiment, aucun sol différent. |

## Les smileys

Leur dessin est dans le terrain : une couleur de sol par smiley, avec des bambous plus petits (croissance 0,27) là où le sol est peint. Relevés dans cette sauvegarde :

| Smiley | Cellules | Remarque |
|---|---|---|
| Ouest | x 7-32, z 99-137 | Deux couleurs de sol, **le smiley d'origine ?** à confirmer. |
| Est, près de la maison | x 205-240, z 101-136 | Sous la plantation de riz, 36 x 36. |
| Est, sud | x 207-244, z 150-185 | 36 x 36. |
| Sud-ouest | x 58-76, z 169-187 | 19 x 19. |
| Nord-ouest, loin | x 2-27, z 227-243 | 26 x 17. |

Les trois smileys du bas de la première capture de Virginie (autour de z 40-60) **ne sont pas dans cette sauvegarde**. Il faut une sauvegarde faite après leur pose.

## Ce que ces lieux ne permettent pas encore

- **Pas de rive ni d'embouchure** au bas de la rivière (z 0-65) : c'est le chantier annoncé par Virginie.
- **Aucune zone dégagée de plus de 14 x 14** sans toucher au décor : un grand bâtiment passe par la cour de gravier, avec dégagement préalable.
- **Les noms exacts des sols** de la carte ne sont pas tous résolus (le prairie de base, les couleurs des smileys) : le relevé est fait sur les valeurs du fichier, pas sur les noms de définitions.
