# readme-i18n

Generate localized README files for any directory — single-language or multi-language.

Default language set: **zh · en · de · fr · ru**

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

## Usage

Ask Claude to generate a README for any directory:

```
Add a README to packer/my-plugin
Generate a multilingual README for this project
Create README files for src/utils — Chinese and English only
```

When triggered, the skill asks:

```
Generate README in:
  1. Single language
  2. Multi-language  [default: zh · en · de · fr · ru]
```

- **Single**: pick one language (zh / en / de / fr / ru or any BCP-47 code)
- **Multi**: confirm or customize the default set

---

## Output files

| Language | Filename |
|----------|----------|
| English (en) | `README.md` |
| Chinese (zh) | `README-zh.md` |
| German (de) | `README-de.md` |
| French (fr) | `README-fr.md` |
| Russian (ru) | `README-ru.md` |
| Other | `README-<code>.md` |

In multi-language mode, `README.md` is always the English version (or the designated
primary language if English is not selected).

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
