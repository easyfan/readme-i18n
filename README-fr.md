# readme-i18n

**Génère, met à jour, traduit et supprime** des fichiers README localisés pour n'importe quel
répertoire. Chaque version linguistique est rédigée nativement — sans traduction automatique
depuis l'anglais.

Ensemble de langues par défaut : **zh · en · de · fr · ru** (5 des 6 langues officielles de
l'ONU, ~4 milliards de locuteurs natifs)

---

## Fonctionnalités

- **Générer** : déduire le contenu depuis le code source et le produire en plusieurs langues
- **Mettre à jour** : propager les modifications à toutes les versions linguistiques simultanément
- **Traduire** : étendre un README en langue unique vers l'ensemble de langues complet
- **Supprimer** : supprimer toutes les versions ou une langue spécifique, avec confirmation

Activation en langage naturel :

```
Ajoute un README à packer/my-plugin
Génère un README multilingue pour ce projet
Mets à jour uniquement le README allemand avec les nouveaux changements d'API
Supprime le README russe
```

---

## Installation

### Option A — Plugin Claude Code (recommandé)

```
/plugin marketplace add easyfan/readme-i18n
/plugin install readme-i18n@readme-i18n
```

### Option B — Script d'installation

```bash
git clone https://github.com/easyfan/readme-i18n
cd readme-i18n
./install.sh
```

```bash
# Options
./install.sh --dry-run      # aperçu sans écriture
./install.sh --uninstall    # supprimer les fichiers installés
CLAUDE_DIR=/custom ./install.sh
```

### Option C — Installation manuelle

```bash
cp -r skills/readme-i18n ~/.claude/skills/
```

---

## Prise en charge des langues

Accepte les codes BCP-47 standard et les alias courants. Le suffixe du nom de fichier correspond toujours à la saisie :

| Saisie | Langue du contenu | Fichier de sortie |
|--------|------------------|-------------------|
| `cn`, `zh-cn`, `zh-hans` | Chinois simplifié | `README-cn.md` / `README-zh-cn.md` … |
| `zh`, `zh-sg` | Chinois simplifié | `README-zh.md` |
| `zh-tw`, `zh-hk`, `zh-hant`, `zht` | Chinois traditionnel | `README-zh-tw.md` … |
| `en`, `en-us`, `en-gb` | Anglais | `README.md` |
| `de`, `de-at`, `de-ch` | Allemand | `README-de.md` … |
| `fr`, `fr-ca`, `fr-be` | Français | `README-fr.md` … |
| `ru` | Russe | `README-ru.md` |
| Tout autre code BCP-47 | Langue correspondante | `README-<code>.md` |

Les codes invalides sont rejetés avec un message explicite. `cn` est reconnu comme Chinois simplifié.

> **Note sur l'ensemble par défaut** : zh · en · de · fr · ru couvre 5 langues officielles de l'ONU.
> Ajoutez `es` (espagnol) ou `ja` (japonais) pour élargir la couverture.

---

## Fichiers générés

| Mode | Langue | Nom de fichier |
|------|--------|----------------|
| Langue unique | Anglais (en) | `README.md` |
| Langue unique | Toute autre langue | `README-<code>.md` — aucun `README.md` créé |
| Multilingue | Anglais (en) | `README.md` |
| Multilingue | Langue principale désignée (non anglais) | `README.md` |
| Multilingue | Toutes les autres langues | `README-<code>.md` |

En mode multilingue, une ligne de navigation est insérée en tête de chaque fichier :
```markdown
[English](README.md) | [中文](README-zh.md) | [Deutsch](README-de.md) | ...
```

Lorsque 2 fichiers ou plus seraient écrasés, une confirmation groupée est proposée :
```
3 fichiers existent déjà : README.md  README-zh.md  README-de.md
Écraser tout ? [Y] Tout écraser / [N] Tout ignorer / [D] Décider individuellement
```

**Les modifications et suppressions s'appliquent par défaut à toutes les versions.** Pour une langue spécifique, précisez-le explicitement.

---

## Structure du projet

```
readme-i18n/
├── .claude-plugin/
│   ├── plugin.json
│   └── marketplace.json
├── skills/
│   └── readme-i18n/
│       └── SKILL.md
├── install.sh
└── package.json
```

---

## Licence

MIT
