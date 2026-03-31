# readme-i18n

Génère des fichiers README localisés pour n'importe quel répertoire — en une seule langue ou en plusieurs langues simultanément.

Ensemble de langues par défaut : **zh · en · de · fr · ru**

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

## Utilisation

Demandez à Claude de générer un README pour un répertoire :

```
Ajoute un README à packer/my-plugin
Génère un README multilingue pour ce projet
Crée des README pour src/utils — en chinois et en anglais seulement
```

Une fois déclenché, le skill vérifie d'abord si des fichiers README existent déjà dans le
répertoire cible. Le cas échéant, il demande s'il faut mettre à jour les fichiers existants,
ajouter les langues manquantes ou tout recréer. Sinon, il pose la question suivante :

```
Générer le README en :
  1. Langue unique
  2. Multilingue  [par défaut : zh · en · de · fr · ru]
```

- **Langue unique** : choisissez parmi `zh / cn / en / de / fr / ru` ou saisissez n'importe quel code BCP-47
- **Multilingue** : confirmez ou personnalisez l'ensemble de langues par défaut

Si l'ensemble sélectionné ne comprend pas l'anglais, une langue est désignée comme version
principale (`README.md`) avant le début de la génération.

---

## Alias de langue

Les alias courants sont acceptés ; le suffixe du nom de fichier correspond à la saisie de l'utilisateur :

| Saisie | Langue du contenu | Fichier de sortie |
|--------|------------------|-------------------|
| `cn`, `zh-cn`, `zh-hans` | Chinois simplifié | `README-cn.md` / `README-zh-cn.md` … |
| `zh`, `zh-sg` | Chinois simplifié | `README-zh.md` |
| `zh-tw`, `zh-hk`, `zh-hant`, `zht` | Chinois traditionnel | `README-zh-tw.md` … |
| `en`, `en-us`, `en-gb` | Anglais | `README.md` |
| Tout autre code BCP-47 | Langue correspondante | `README-<code>.md` |

Les codes invalides (p. ex. `xyz123`) sont rejetés avec un message d'erreur explicite.

---

## Fichiers générés

| Mode | Langue | Nom de fichier |
|------|--------|----------------|
| Langue unique | Anglais (en) | `README.md` |
| Langue unique | Toute autre langue | `README-<code>.md` |
| Multilingue | Anglais (en) | `README.md` |
| Multilingue | Langue principale désignée (non anglais) | `README.md` |
| Multilingue | Toutes les autres langues | `README-<code>.md` |

Lorsque 2 fichiers ou plus seraient écrasés, une confirmation groupée est proposée :
```
3 fichiers existent déjà : README.md  README-zh.md  README-de.md
Écraser tout ? [Y] Tout écraser / [N] Tout ignorer / [D] Décider individuellement
```

**Les modifications et suppressions s'appliquent par défaut à toutes les versions linguistiques.** Pour n'agir que sur une langue spécifique, précisez-le explicitement.

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
