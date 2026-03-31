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

When triggered, the skill first checks for existing README files. If found, it asks whether to
update, add missing languages, or recreate from scratch. Otherwise it asks for language mode:

```
Generate README in:
  1. Single language
  2. Multi-language  [default: zh · en · de · fr · ru]
```

- **Single**: pick one language — quick options `zh / cn / en / de / fr / ru` or any BCP-47 code
- **Multi**: confirm or customize the default set

If the selected set does not include English, you are asked to designate one language as the
primary `README.md` before generation starts.

---

## Language aliases

Common aliases are accepted and preserve the user-specified suffix in the filename:

| Input | Content language | Output filename |
|-------|-----------------|-----------------|
| `cn`, `zh-cn`, `zh-hans` | Simplified Chinese | `README-cn.md` / `README-zh-cn.md` … |
| `zh`, `zh-sg` | Simplified Chinese | `README-zh.md` |
| `zh-tw`, `zh-hk`, `zh-hant`, `zht` | Traditional Chinese | `README-zh-tw.md` … |
| `en`, `en-us`, `en-gb` | English | `README.md` |
| any other BCP-47 | that language | `README-<code>.md` |

Invalid codes (e.g. `xyz123`) are rejected with a helpful error message.

---

## Output files

| Mode | Language | Filename |
|------|----------|----------|
| Single | English (en) | `README.md` |
| Single | Any non-English | `README-<code>.md` |
| Multi | English (en) | `README.md` |
| Multi | Designated primary (non-English) | `README.md` |
| Multi | All others | `README-<code>.md` |

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
