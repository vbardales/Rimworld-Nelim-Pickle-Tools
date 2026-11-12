# Étude : quel mod pour voir les cheveux sous le chapeau (2026-10-18)

Besoin (Virginie) : captures galerie où Nelim porte chapeau ET cheveux visibles dessous (cheveux longs détachés, jamais queue de cheval ni chignon). Règle écrite dans `SanctuaryBacklot/docs/GALERIE.md` et `GALLERY.md` (critère d).

Méthode : lecture `About.xml` installés (Workshop) et, pour 3496326157, page Steam. Rien essayé en jeu pendant étude.

| Workshop | Mod | packageId | Versions | Verdict |
|---|---|---|---|---|
| 3255379190 | Show Hair Under Stuff | `RaccoonCuddler.ShowHair` | 1.5, 1.6, 1.7 | **Retenu (provisoire).** Cheveux sous couvre-chefs hauts (chapeaux), cheveux et barbe sous casques complets. Deux options actives par défaut. Harmony seul. Déjà dans `wsl-deps.faceparts.map`. |
| 3760821540 | Hat Hair Control | `lordfelix.HatHairControl` | 1.6, 1.7 | **Plan B.** Réglage par chapeau : cheveux, barbe, chapeau derrière cheveux, masqué en intérieur ou au lit. Plus puissant, mais réglage par chapeau à poser, valeurs par défaut non lues. |
| 2296697286 | Dubs Apparel Tweaks | `Dubwise.DubsApparelTweaks` | 1.2 à 1.7 | Écarté. « Cheveux sous chapeaux » = une option parmi d'autres (vitesse d'équipement, chapeaux masqués au lit). |
| 2990606008 | AB's Head Apparel Tweaker | `AB.HATweaker` | 1.4 à 1.7 | Écarté. Réglages dessus/dessous des cheveux cassés avec Vanilla Expanded Framework, chargé dans certaines passes. |
| 3496326157 | Hat Adjust (Yatoro) | non lu | annoncé 1.5 à 2.0 | Écarté. Fait l'inverse : chapeaux ouverts recouvrent aussi cheveux. Page porte bannière « retiré de la communauté », sans valeur (protection anti-bot, voir mémoire projet). |

## Décision

Show Hair Under Stuff. Raisons : actif sans réglage, donc scénario Pickle n'a rien à configurer ; un seul but ; compatible 1.7 ; déjà staged par map des visages.

## Reste à prouver

- Ticket e457 (`pickletools-hat-hair.feature`, scénario `hat-hair-1`) : quatre chapeaux (cow-boy, tuque, flophat, casque Recon) sur coiffure `Long`, plus une prise sans chapeau. Lire captures : cheveux visibles ? traversent chapeau ?
- Si traverse : rejouer avec Hat Hair Control dans map, dessiner chapeau derrière cheveux.
- Non vérifié : compatibilité avec Facial Animation.