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

触发后，skill 会先检测目标目录是否已有 README 文件。若存在，会询问是更新现有文件、补充缺失语言，还是重新生成；否则直接询问语言模式：

```
请选择 README 语言：
  1. 单一语言
  2. 多语言  [默认：zh · en · de · fr · ru]
```

- **单一语言**：从 `zh / cn / en / de / fr / ru` 中选择，或输入任意 BCP-47 语言代码
- **多语言**：确认或自定义默认语言集

若选定的语言集不含英语，会在生成前要求指定一种语言作为主版本（`README.md`）。

---

## 语言别名

支持常见别名，输出文件名保留用户指定的后缀：

| 输入 | 内容语言 | 输出文件名 |
|------|---------|-----------|
| `cn`、`zh-cn`、`zh-hans` | 简体中文 | `README-cn.md` / `README-zh-cn.md` … |
| `zh`、`zh-sg` | 简体中文 | `README-zh.md` |
| `zh-tw`、`zh-hk`、`zh-hant`、`zht` | 繁体中文 | `README-zh-tw.md` … |
| `en`、`en-us`、`en-gb` | 英语 | `README.md` |
| 其他 BCP-47 | 对应语言 | `README-<代码>.md` |

无效代码（如 `xyz123`）会被拒绝并给出提示。

---

## 输出文件

| 模式 | 语言 | 文件名 |
|------|------|--------|
| 单语言 | 英语 (en) | `README.md` |
| 单语言 | 其他语言 | `README-<代码>.md` |
| 多语言 | 英语 (en) | `README.md` |
| 多语言 | 指定主语言（非英语） | `README.md` |
| 多语言 | 其余语言 | `README-<代码>.md` |

当有 2 个或以上已存在文件将被覆盖时，提供批量确认选项：
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
