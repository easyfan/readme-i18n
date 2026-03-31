# readme-i18n

**Erstellt, aktualisiert, übersetzt und löscht** lokalisierte README-Dateien für beliebige
Verzeichnisse. Jede Sprachversion wird nativ verfasst — keine maschinelle Übersetzung aus
dem Englischen.

Standard-Sprachset: **zh · en · de · fr · ru** (5 der 6 UN-Amtssprachen, ~4 Mrd. Muttersprachler)

---

## Funktionen

- **Erstellen**: Inhalte aus dem Quellcode ableiten und in mehreren Sprachen generieren
- **Aktualisieren**: Änderungen in alle Sprachversionen gleichzeitig übernehmen
- **Übersetzen**: Eine einzelsprachige README auf das vollständige Sprachset erweitern
- **Löschen**: Alle oder einzelne Sprachversionen mit Bestätigung entfernen

Natürlichsprachliche Aktivierung:

```
Füge eine README zu packer/my-plugin hinzu
Erstelle eine mehrsprachige README für dieses Projekt
Aktualisiere nur die deutsche README mit den neuen API-Änderungen
Lösche die russische README
```

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

## Sprachunterstützung

Akzeptiert BCP-47-Codes und gängige Aliase. Das Dateinamensuffix entspricht der Benutzereingabe:

| Eingabe | Inhaltssprache | Ausgabedatei |
|---------|---------------|--------------|
| `cn`, `zh-cn`, `zh-hans` | Vereinfachtes Chinesisch | `README-cn.md` / `README-zh-cn.md` … |
| `zh`, `zh-sg` | Vereinfachtes Chinesisch | `README-zh.md` |
| `zh-tw`, `zh-hk`, `zh-hant`, `zht` | Traditionelles Chinesisch | `README-zh-tw.md` … |
| `en`, `en-us`, `en-gb` | Englisch | `README.md` |
| `de`, `de-at`, `de-ch` | Deutsch | `README-de.md` … |
| `fr`, `fr-ca`, `fr-be` | Französisch | `README-fr.md` … |
| `ru` | Russisch | `README-ru.md` |
| Sonstiger BCP-47-Code | Jeweilige Sprache | `README-<code>.md` |

Ungültige Codes werden abgelehnt. `cn` wird als Vereinfachtes Chinesisch erkannt.

> **Hinweis zum Standard-Sprachset**: zh · en · de · fr · ru deckt 5 UN-Amtssprachen ab.
> Für weitere Sprachen können `es` (Spanisch) oder `ja` (Japanisch) ergänzt werden.

---

## Ausgabedateien

| Modus | Sprache | Dateiname |
|-------|---------|-----------|
| Einzelsprache | Englisch (en) | `README.md` |
| Einzelsprache | Andere Sprache | `README-<code>.md` — kein `README.md` wird erstellt |
| Mehrsprachig | Englisch (en) | `README.md` |
| Mehrsprachig | Festgelegte Hauptsprache (nicht Englisch) | `README.md` |
| Mehrsprachig | Alle weiteren Sprachen | `README-<code>.md` |

Im Mehrsprachigkeitsmodus wird eine Navigationszeile am Dateianfang eingefügt:
```markdown
[English](README.md) | [中文](README-zh.md) | [Deutsch](README-de.md) | ...
```

Bei 2 oder mehr zu überschreibenden Dateien erscheint eine Sammelbestätigung:
```
3 Dateien existieren bereits: README.md  README-zh.md  README-de.md
Alle überschreiben? [Y] Alle / [N] Keine / [D] Einzeln entscheiden
```

**Änderungen und Löschvorgänge betreffen standardmäßig alle Sprachversionen.** Für einzelne Sprachen bitte explizit angeben.

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
