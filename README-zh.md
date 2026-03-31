# readme-i18n

**生成、更新、翻译、删除**任意目录的多语言 README 文件。每种语言版本均以该语言自然写作，而非从英文机器翻译。

默认语言集：**zh · en · de · fr · ru**（覆盖联合国 6 大官方语言中的 5 种，触达约 40 亿母语使用者）

---

## 能做什么

- **生成**：从项目源码推断内容，一次生成多个语言版本
- **更新**：将改动同步到所有语言版本，或仅更新指定语言
- **翻译**：将现有单语言 README 扩展为完整多语言版本
- **删除**：带确认的批量或单语言删除

直接用自然语言触发：

```
为 packer/my-plugin 添加 README
给这个项目生成多语言 README
用新的 API 变更内容更新德文 README
把现有 README 翻译成中文和法文
删除俄文 README
```

---

## 安装

### 方式 A — Claude Code 插件（推荐）

```
/plugin marketplace add easyfan/readme-i18n
/plugin install readme-i18n@readme-i18n
```

### 方式 B — 安装脚本

```bash
git clone https://github.com/easyfan/readme-i18n
cd readme-i18n
./install.sh
```

```bash
# 可选参数
./install.sh --dry-run      # 预览，不写入文件
./install.sh --uninstall    # 卸载已安装文件
CLAUDE_DIR=/custom ./install.sh
```

### 方式 C — 手动复制

```bash
cp -r skills/readme-i18n ~/.claude/skills/
```

---

## 语言支持

接受标准 BCP-47 代码及常见别名，输出文件名保留你输入的后缀：

| 输入 | 内容语言 | 输出文件名 |
|------|---------|-----------|
| `cn`、`zh-cn`、`zh-hans` | 简体中文 | `README-cn.md` / `README-zh-cn.md` … |
| `zh`、`zh-sg` | 简体中文 | `README-zh.md` |
| `zh-tw`、`zh-hk`、`zh-hant`、`zht` | 繁体中文 | `README-zh-tw.md` … |
| `en`、`en-us`、`en-gb` | 英语 | `README.md` |
| `de`、`de-at`、`de-ch` | 德语 | `README-de.md` … |
| `fr`、`fr-ca`、`fr-be` | 法语 | `README-fr.md` … |
| `ru` | 俄语 | `README-ru.md` |
| 其他 BCP-47 | 对应语言 | `README-<代码>.md` |

无效代码会被拒绝并给出提示。`cn` 被识别为简体中文，而非未知代码。

> **默认集说明**：zh · en · de · fr · ru 覆盖联合国 5 种官方语言。如需进一步扩展，可加入 `es`（西班牙语，约 5 亿母语使用者）或 `ja`（日语，GitHub 活跃度极高）。

---

## 输出文件

| 模式 | 语言 | 文件名 |
|------|------|--------|
| 单语言 | 英语 (en) | `README.md` |
| 单语言 | 其他语言 | `README-<代码>.md`（不生成 `README.md`） |
| 多语言 | 英语 (en) | `README.md` |
| 多语言 | 指定主语言（非英语） | `README.md` |
| 多语言 | 其余语言 | `README-<代码>.md` |

多语言模式下，每个生成的文件顶部会自动插入语言导航链接：
```markdown
[English](README.md) | [中文](README-zh.md) | [Deutsch](README-de.md) | ...
```

当有 2 个或以上文件将被覆盖时，提供批量确认：
```
已存在 3 个文件：README.md  README-zh.md  README-de.md
全部覆盖？[Y] 全部覆盖 / [N] 全部跳过 / [D] 逐个确认
```

**修改/删除默认作用于全部语言版本**，如需仅操作特定语言，在指令中注明即可。

---

## 目录结构

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

## 许可证

MIT
