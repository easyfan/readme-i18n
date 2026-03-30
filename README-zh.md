# readme-i18n

为任意目录生成本地化 README 文件，支持单语言和多语言模式。

默认语言集：**zh · en · de · fr · ru**

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

## 使用方式

直接告诉 Claude 你想为哪个目录生成 README：

```
为 packer/my-plugin 添加 README
给这个项目生成多语言 README
为 src/utils 创建中英文 README
```

触发后，skill 会询问语言模式：

```
请选择 README 语言：
  1. 单一语言
  2. 多语言  [默认：zh · en · de · fr · ru]
```

- **单一语言**：从 zh / en / de / fr / ru 中选择，或输入任意 BCP-47 语言代码
- **多语言**：确认或自定义默认语言集

---

## 输出文件

| 语言 | 文件名 |
|------|--------|
| 英语 (en) | `README.md` |
| 中文 (zh) | `README-zh.md` |
| 德语 (de) | `README-de.md` |
| 法语 (fr) | `README-fr.md` |
| 俄语 (ru) | `README-ru.md` |
| 其他 | `README-<代码>.md` |

多语言模式下，`README.md` 始终为英文版本（若未选英语，则指定一种语言作为主版本）。

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
