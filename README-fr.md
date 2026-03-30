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

Une fois déclenché, le skill pose la question suivante :

```
Générer le README en :
  1. Langue unique
  2. Multilingue  [par défaut : zh · en · de · fr · ru]
```

- **Langue unique** : choisissez parmi zh / en / de / fr / ru ou saisissez n'importe quel code BCP-47
- **Multilingue** : confirmez ou personnalisez l'ensemble de langues par défaut

---

## Fichiers générés

| Langue | Nom de fichier |
|--------|----------------|
| Anglais (en) | `README.md` |
| Chinois (zh) | `README-zh.md` |
| Allemand (de) | `README-de.md` |
| Français (fr) | `README-fr.md` |
| Russe (ru) | `README-ru.md` |
| Autre | `README-<code>.md` |

En mode multilingue, `README.md` correspond toujours à la version anglaise (ou à la langue principale désignée si l'anglais n'est pas sélectionné).

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
