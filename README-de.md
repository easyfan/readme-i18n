# readme-i18n

Erstellt lokalisierte README-Dateien für beliebige Verzeichnisse — als Einzelsprache oder in mehreren Sprachen gleichzeitig.

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

Nach der Aktivierung prüft das Skill zunächst, ob bereits README-Dateien im Zielverzeichnis
vorhanden sind. Falls ja, wird gefragt, ob vorhandene Dateien aktualisiert, fehlende Sprachen
ergänzt oder alle Dateien neu erstellt werden sollen. Andernfalls wird der Sprachmodus abgefragt:

```
README erstellen in:
  1. Einzelsprache
  2. Mehrsprachig  [Standard: zh · en · de · fr · ru]
```

- **Einzelsprache**: Auswahl aus `zh / cn / en / de / fr / ru` oder beliebiger BCP-47-Sprachcode
- **Mehrsprachig**: Standard-Sprachset bestätigen oder anpassen

Falls das gewählte Sprachset kein Englisch enthält, wird vor der Generierung eine Sprache als
Hauptversion (`README.md`) festgelegt.

---

## Sprachaliase

Gängige Aliase werden akzeptiert; das Dateinamensuffix entspricht der Benutzereingabe:

| Eingabe | Inhaltssprache | Ausgabedatei |
|---------|---------------|--------------|
| `cn`, `zh-cn`, `zh-hans` | Vereinfachtes Chinesisch | `README-cn.md` / `README-zh-cn.md` … |
| `zh`, `zh-sg` | Vereinfachtes Chinesisch | `README-zh.md` |
| `zh-tw`, `zh-hk`, `zh-hant`, `zht` | Traditionelles Chinesisch | `README-zh-tw.md` … |
| `en`, `en-us`, `en-gb` | Englisch | `README.md` |
| Sonstiger BCP-47-Code | Jeweilige Sprache | `README-<code>.md` |

Ungültige Codes (z. B. `xyz123`) werden mit einer hilfreichen Fehlermeldung abgelehnt.

---

## Ausgabedateien

| Modus | Sprache | Dateiname |
|-------|---------|-----------|
| Einzelsprache | Englisch (en) | `README.md` |
| Einzelsprache | Andere Sprache | `README-<code>.md` |
| Mehrsprachig | Englisch (en) | `README.md` |
| Mehrsprachig | Festgelegte Hauptsprache (nicht Englisch) | `README.md` |
| Mehrsprachig | Alle weiteren Sprachen | `README-<code>.md` |

Wenn 2 oder mehr vorhandene Dateien überschrieben würden, erscheint eine Sammelbestätigung:
```
3 Dateien existieren bereits: README.md  README-zh.md  README-de.md
Alle überschreiben? [Y] Alle / [N] Keine / [D] Einzeln entscheiden
```

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
