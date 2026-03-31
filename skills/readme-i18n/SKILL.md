---
name: readme-i18n
description: >
  Generate, update, translate, or delete README files for a directory in one or multiple
  languages. Each language version is written natively — not machine-translated from English.
  Trigger when the user asks to create, add, generate, update, modify, translate, or remove
  a README for a directory or project. Also trigger when the user mentions i18n,
  internationalization, multi-language documentation, or localized docs. Supports language
  aliases: cn, zh-tw, zh-hant, en-us, de-at, fr-ca, and any BCP-47 code.
---

# readme-i18n

Generate localized README files for a target directory. Supports single-language and
multi-language output. In multi-language mode the default set is zh · en · de · fr · ru.

## Steps

### Step 1: Identify target directory

Determine the target directory from the user's request. If not specified, use the current
working directory. If ambiguous, ask the user to confirm before proceeding.

### Step 1.5: Detect existing README files

Before asking about language mode, check whether any `README*.md` files already exist in the
target directory.

```
ls <target_directory>/README*.md 2>/dev/null
```

- **If files are found**: list them and ask the user:
  ```
  Found existing README files:
    README.md  README-zh.md  README-de.md
  Do you want to (U)pdate existing files, (A)dd missing languages, or (C)reate all from scratch?
  ```
  - **Update**: go to the "Modify existing READMEs" section below.
  - **Add missing languages**: continue to Step 2, but skip languages that already have a file.
  - **Create from scratch**: continue to Step 2 (existing files will trigger the overwrite prompt in Step 5).

- **If no files are found**: continue directly to Step 2.

### Step 2: Ask language mode

Present the user with a choice:

```
Generate README in:
  1. Single language
  2. Multi-language  [default: zh · en · de · fr · ru]
```

**If single**: ask which language — offer `zh / en / de / fr / ru` as quick options, or
accept any BCP-47 language code or common alias (see Language alias table below).

**If multi**: confirm the default set or let the user customize it:
```
Default: zh · en · de · fr · ru
Press Enter to confirm, or type codes to adjust (e.g. "en de ja" or "cn de ja"):
```

> **Note on `zh`**: In the default set, `zh` produces Simplified Chinese content. For Traditional
> Chinese use `zh-tw` or `zh-hant`. BCP-47 recommends `zh-Hans` / `zh-Hant` for explicit
> disambiguation, but short aliases (`zh`, `zh-tw`) are equally accepted.

**If the confirmed language set does not include `en`**: immediately ask which language should
serve as the primary README (i.e. be written to `README.md`):
```
The selected languages do not include English. Which language should be the primary README.md?
  → zh  de  fr  ru  (or any language from your set)
```
Record the answer as the **primary language** before proceeding to Step 3.

**Language alias table** — normalize input codes before use:

| User input | Normalized language | File suffix used | Notes |
|------------|--------------------|--------------------|-------|
| `cn`, `zh-cn`, `zh-hans` | Chinese (Simplified) | keep user input | Same content as `zh` |
| `zh`, `zh-sg` | Chinese (Simplified) | keep user input | Default Simplified |
| `zh-tw`, `zh-hk`, `zh-hant`, `zht` | Chinese (Traditional) | keep user input | Traditional variant |
| `en`, `en-us`, `en-gb` | English | keep user input | |
| `de`, `de-at`, `de-ch` | German | keep user input | |
| `fr`, `fr-ca`, `fr-be` | French | keep user input | |
| `ru` | Russian | keep user input | |
| any other BCP-47 | that language | keep user input | |

When an alias is recognized, silently normalize to the content language internally (for tone and
writing style), but **preserve the user's original suffix in the output filename**.
Example: user specifies `cn` → file is `README-cn.md`, content is Simplified Chinese.

**Language code validation**: if the user enters a code that is neither in the alias table nor a
plausible BCP-47 subtag (letters and hyphens only, e.g. `ja`, `ko`, `pt-br`), reject it:
```
"xyz123" is not a recognized language code. Please enter a valid BCP-47 code (e.g. ja, ko, pt-br)
or one of the quick options: zh / cn / en / de / fr / ru
```

### Step 3: Inspect the target directory

Read files that reveal what the project does. Priority order:

1. `package.json` / `pyproject.toml` / `Cargo.toml` / `go.mod` — name, description, version
2. Top-level source files — infer purpose from filenames and imports
3. Any existing partial README — use as reference baseline, do not delete

If nothing useful is found, ask the user for a one-line description of the project before
generating content.

### Step 4: Generate README content

For each selected language, write a README that includes:

| Section | Required | Notes |
|---------|----------|-------|
| Project name + one-line description | ✅ | Match the detected/confirmed name |
| What it does | ✅ | 2-4 sentences in the target language |
| Installation | if detectable | inferred from package manager or install script |
| Usage / quick start | ✅ | at least one concrete example |
| Requirements | if detectable | e.g. Node ≥ 18, Python 3.10+ |
| License | if detectable | from package manifest or LICENSE file |

**Tone conventions by language**:
- `en` / `en-*`: concise, imperative, technical
- `zh` / `cn` / `zh-cn` / `zh-hans` / `zh-sg`: warm, example-forward, 简洁 (Simplified Chinese)
- `zh-tw` / `zh-hk` / `zh-hant` / `zht`: warm, example-forward, 簡潔 (Traditional Chinese — use Traditional characters)
- `de` / `de-*`: formal `Sie`-form, precise, structured
- `fr` / `fr-*`: neutral `vous`-form, descriptive
- `ru`: neutral, technical, concise

Do not machine-translate from English. Write each language naturally.

**In multi-language mode**: prepend a language navigation line to every generated file:
```markdown
[English](README.md) | [中文](README-zh.md) | [Deutsch](README-de.md) | [Français](README-fr.md) | [Русский](README-ru.md)
```
Adjust the list to match the actual languages being generated. Use the language's own name
(e.g. 中文, Deutsch) rather than English names.

### Step 5: Write files

| Mode | Language | Filename |
|------|----------|----------|
| Single-language | English (en) | `README.md` |
| Single-language | Any non-English | `README-<user-suffix>.md` (no `README.md` created) |
| Multi-language | English (en) | `README.md` |
| Multi-language | Primary language (non-English, user designated) | `README.md` |
| Multi-language | All other languages | `README-<user-suffix>.md` |

The filename suffix is always the **exact code the user specified** (or the default code from
the language set). Examples:
- user specifies `zh` → `README-zh.md`
- user specifies `cn` → `README-cn.md`
- user specifies `zh-tw` → `README-zh-tw.md`
- default set includes `zh` → `README-zh.md`

In multi-language mode, `README.md` is always the English version (or the primary language
designated in Step 2 if English was not selected).

If files already exist, ask before overwriting. When **2 or more** files would be overwritten,
offer a batch option first:
```
3 files already exist: README.md  README-zh.md  README-de.md
Overwrite all? [Y]es all / [N]o, skip all / [D]ecide individually
```
- **Yes all**: overwrite all without further prompts.
- **No, skip all**: keep existing files; only write truly new ones.
- **Decide individually**: ask for each file:
  ```
  README-zh.md already exists. Overwrite? [y/N]
  ```

After writing, report a summary:
```
Created:
  README.md        (en)
  README-zh.md     (zh)
  README-de.md     (de)
  README-fr.md     (fr)
  README-ru.md     (ru)
```

---

## Modify existing READMEs

When the user asks to **update or modify** a README in a directory:

1. Detect all `README*.md` files in the target directory. When mapping existing files to
   languages, apply the alias table: `README-cn.md` and `README-zh.md` both count as
   Simplified Chinese (treat as one slot, not two separate languages).
2. **If the existing files cover only a single language or a partial set** (i.e. not all
   five of zh · en · de · fr · ru are present), prompt the user:
   ```
   Found: README.md (en)
   The full language set is zh · en · de · fr · ru.
   Expand to all 5 languages while updating? [Y/n]
   ```
   - If **yes**: apply the update to existing files AND generate the missing language
     versions from scratch (same flow as Step 3–5 above).
   - If **no**: apply the change only to the existing files.
3. Apply the requested change to every selected file (translated appropriately per language).
4. Report which files were updated and which were newly created.

If the user specifies a subset of languages explicitly (e.g. "update only the Chinese
README"), skip the expansion prompt and apply the change to that subset only.

## Delete READMEs

When the user asks to **delete or remove** a README from a directory, delete **all
language versions** by default:

1. List all `README*.md` files found in the target directory.
2. Confirm with the user before deleting:
   ```
   Found 5 README files:
     README.md  README-zh.md  README-de.md  README-fr.md  README-ru.md
   Delete all? [Y/n]
   ```
3. If the user specifies a language (e.g. "delete only the German README"), delete only
   `README-de.md`.
4. Report which files were removed.
