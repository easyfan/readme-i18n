# readme-i18n

**Generate, update, translate, and delete** localized README files for any directory —
single-language or multi-language, written natively in each target language.

Unlike translation-based tools, readme-i18n writes each language version from scratch using
the appropriate tone and conventions for that language. No machine translation from English.

Default language set: **zh · en · de · fr · ru** (covers 5 of the 6 UN official languages,
reaching ~4 billion native speakers)

---

## What it does

- **Generates** README files in one or multiple languages from your project's source code
- **Updates** existing README files across all language versions simultaneously
- **Translates** a single-language README into your full language set
- **Deletes** all or specific language versions with confirmation

Trigger it naturally:

```
Add a README to packer/my-plugin
Generate a multilingual README for this project
Update only the German README with the new API changes
Translate the existing README into Chinese and French
Delete the Russian README
```

---

## Install

### Option A — Claude Code plugin (recommended)

```
/plugin marketplace add easyfan/readme-i18n
/plugin install readme-i18n@readme-i18n
```

### Option B — install script

```bash
git clone https://github.com/easyfan/readme-i18n
cd readme-i18n
./install.sh
```

```bash
# Options
./install.sh --dry-run      # preview without writing
./install.sh --uninstall    # remove installed files
CLAUDE_DIR=/custom ./install.sh
```

### Option C — manual

```bash
cp -r skills/readme-i18n ~/.claude/skills/
```

---

## Language support

Accepts standard BCP-47 codes and common aliases. The suffix in the output filename always
matches what you typed:

| Input | Content language | Output filename |
|-------|-----------------|-----------------|
| `cn`, `zh-cn`, `zh-hans` | Simplified Chinese | `README-cn.md` / `README-zh-cn.md` … |
| `zh`, `zh-sg` | Simplified Chinese | `README-zh.md` |
| `zh-tw`, `zh-hk`, `zh-hant`, `zht` | Traditional Chinese | `README-zh-tw.md` … |
| `en`, `en-us`, `en-gb` | English | `README.md` |
| `de`, `de-at`, `de-ch` | German | `README-de.md` … |
| `fr`, `fr-ca`, `fr-be` | French | `README-fr.md` … |
| `ru` | Russian | `README-ru.md` |
| any other BCP-47 | that language | `README-<code>.md` |

Invalid codes are rejected with a helpful error. `cn` is accepted as Simplified Chinese
(not treated as an unknown code).

> **Default set note**: zh · en · de · fr · ru covers 5 UN official languages. Add `es`
> (Spanish, ~500M speakers) or `ja` (highly active on GitHub) to expand further.

---

## Output files

| Mode | Language | Filename |
|------|----------|----------|
| Single | English (en) | `README.md` |
| Single | Any non-English | `README-<code>.md` only — no `README.md` created |
| Multi | English (en) | `README.md` |
| Multi | Designated primary (non-English) | `README.md` |
| Multi | All others | `README-<code>.md` |

In multi-language mode, a language navigation header is added to each file:
```markdown
[English](README.md) | [中文](README-zh.md) | [Deutsch](README-de.md) | ...
```

When 2 or more existing files would be overwritten, a batch confirmation is offered:
```
3 files already exist: README.md  README-zh.md  README-de.md
Overwrite all? [Y]es all / [N]o, skip all / [D]ecide individually
```

---

## Package structure

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

## License

MIT
