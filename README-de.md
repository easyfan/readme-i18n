# readme-i18n

Erstellt lokalisierte README-Dateien für beliebige Verzeichnisse – als Einzelsprache oder in mehreren Sprachen gleichzeitig.

Standard-Sprachset: **zh · en · de · fr · ru**

---

## Installation

### Option A — Claude Code Plugin (empfohlen)

```
/plugin marketplace add easyfan/readme-i18n
/plugin install readme-i18n@readme-i18n
```

### Option B — Installationsskript

```bash
git clone https://github.com/easyfan/readme-i18n
cd readme-i18n
./install.sh
```

```bash
# Optionen
./install.sh --dry-run      # Vorschau ohne Dateiänderungen
./install.sh --uninstall    # Installierte Dateien entfernen
CLAUDE_DIR=/custom ./install.sh
```

### Option C — Manuelle Installation

```bash
cp -r skills/readme-i18n ~/.claude/skills/
```

---

## Verwendung

Weisen Sie Claude an, für ein Verzeichnis eine README zu erstellen:

```
Füge eine README zu packer/my-plugin hinzu
Erstelle eine mehrsprachige README für dieses Projekt
Erstelle README-Dateien für src/utils – nur Chinesisch und Englisch
```

Nach der Aktivierung fragt das Skill nach dem Sprachmodus:

```
README erstellen in:
  1. Einzelsprache
  2. Mehrsprachig  [Standard: zh · en · de · fr · ru]
```

- **Einzelsprache**: Auswahl aus zh / en / de / fr / ru oder beliebiger BCP-47-Sprachcode
- **Mehrsprachig**: Standard-Sprachset bestätigen oder anpassen

---

## Ausgabedateien

| Sprache | Dateiname |
|---------|-----------|
| Englisch (en) | `README.md` |
| Chinesisch (zh) | `README-zh.md` |
| Deutsch (de) | `README-de.md` |
| Französisch (fr) | `README-fr.md` |
| Russisch (ru) | `README-ru.md` |
| Sonstige | `README-<code>.md` |

Im Mehrsprachigkeitsmodus entspricht `README.md` stets der englischen Version (oder der festgelegten Hauptsprache, falls Englisch nicht ausgewählt wurde).

**Änderungen und Löschvorgänge betreffen standardmäßig alle Sprachversionen.** Soll nur eine bestimmte Sprache bearbeitet werden, kann dies explizit angegeben werden.

---

## Verzeichnisstruktur

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

## Lizenz

MIT
