---
name: readme-i18n
description: >
  Generate README files for a directory in one or multiple languages. Trigger when the
  user asks to create, add, or generate a README for a directory or project. Also trigger
  when the user mentions i18n, internationalization, or multi-language documentation.
  Default language set for multi-language mode: Chinese (zh), English (en), German (de),
  French (fr), Russian (ru).
---

# readme-i18n

Generate localized README files for a target directory. Supports single-language and
multi-language output. In multi-language mode the default set is zh · en · de · fr · ru.

## Steps

### Step 1: Identify target directory

Determine the target directory from the user's request. If not specified, use the current
working directory. If ambiguous, ask the user to confirm before proceeding.

### Step 2: Ask language mode

Present the user with a choice:

```
Generate README in:
  1. Single language
  2. Multi-language  [default: zh · en · de · fr · ru]
```

**If single**: ask which language — offer `zh / en / de / fr / ru` as quick options, or
accept any BCP-47 language code.

**If multi**: confirm the default set or let the user customize it:
```
Default: zh · en · de · fr · ru
Press Enter to confirm, or type codes to adjust (e.g. "en de ja"):
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
- `en`: concise, imperative, technical
- `zh`: warm, example-forward, 简洁
- `de`: formal `Sie`-form, precise, structured
- `fr`: neutral `vous`-form, descriptive
- `ru`: neutral, technical, concise

Do not machine-translate from English. Write each language naturally.

### Step 5: Write files

| Language | Filename |
|----------|----------|
| English (en) | `README.md` |
| Chinese (zh) | `README-zh.md` |
| German (de) | `README-de.md` |
| French (fr) | `README-fr.md` |
| Russian (ru) | `README-ru.md` |
| Other | `README-<code>.md` |

In multi-language mode, `README.md` is always the English version (or the primary
language if English was not selected — prompt the user to designate one).

If a file already exists, ask before overwriting:
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

1. Detect all `README*.md` files in the target directory.
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
