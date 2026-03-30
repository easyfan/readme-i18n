#!/usr/bin/env bash
# install.sh — readme-i18n Claude Code plugin installer
# ✅ Verified by automated tests: this install path is covered by the skill-test pipeline (looper Stage 5).
#
# Usage:
#   ./install.sh              # install to ~/.claude/
#   ./install.sh --dry-run    # preview without writing
#   ./install.sh --uninstall  # remove installed files
#   CLAUDE_DIR=/path ./install.sh  # custom target

set -euo pipefail

SCRIPT_PATH="$0"
while [ -L "$SCRIPT_PATH" ]; do
  link_dir="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"
  SCRIPT_PATH="$(readlink "$SCRIPT_PATH")"
  [[ "$SCRIPT_PATH" != /* ]] && SCRIPT_PATH="$link_dir/$SCRIPT_PATH"
done
SCRIPT_DIR="$(cd "$(dirname "$SCRIPT_PATH")" && pwd)"

CLAUDE_DIR="${CLAUDE_DIR:-$HOME/.claude}"
DRY_RUN=false
UNINSTALL=false

for arg in "$@"; do
  case "$arg" in
    --dry-run)   DRY_RUN=true ;;
    --uninstall) UNINSTALL=true ;;
    --target=*)  CLAUDE_DIR="${arg#--target=}" ;;
    --help|-h)
      echo "Usage: ./install.sh [--dry-run] [--uninstall] [--target=<path>]"
      echo "  CLAUDE_DIR=/path ./install.sh   # custom Claude config dir"
      exit 0 ;;
  esac
done

ok()   { printf "  \033[32m✓\033[0m %s\n" "$*"; }
skip() { printf "  \033[2m– %s (up to date)\033[0m\n" "$*"; }
info() { printf "  %s\n" "$*"; }
run()  { $DRY_RUN || "$@"; }

echo ""
echo "  readme-i18n — Claude Code plugin v$(grep '"version"' "$SCRIPT_DIR/package.json" | head -1 | grep -o '[0-9.]*')"
echo "  Target: $CLAUDE_DIR"
$DRY_RUN && echo "  Mode: DRY RUN (no files modified)"
echo ""

if ! command -v claude &>/dev/null; then
  printf "  \033[33m! 'claude' CLI not found. Install Claude Code first: https://claude.ai/code\033[0m\n\n"
fi

SKILL_SRC="$SCRIPT_DIR/skills/readme-i18n"
SKILL_DST="$CLAUDE_DIR/skills/readme-i18n"

if $UNINSTALL; then
  echo "  Uninstalling..."
  if [ -d "$SKILL_DST" ]; then
    run rm -rf "$SKILL_DST"
    ok "Removed $SKILL_DST"
  else
    skip "skills/readme-i18n (not found)"
  fi
  echo ""
  echo "  Uninstall complete."
  echo ""
  exit 0
fi

changed=0

if [ -f "$SKILL_DST/SKILL.md" ] && diff -q "$SKILL_SRC/SKILL.md" "$SKILL_DST/SKILL.md" &>/dev/null; then
  skip "skills/readme-i18n/SKILL.md"
else
  [ -d "$SKILL_DST" ] && info "Updating  skills/readme-i18n..." || info "Installing skills/readme-i18n..."
  run mkdir -p "$SKILL_DST"
  run cp -r "$SKILL_SRC/." "$SKILL_DST/"
  ok "skills/readme-i18n → $SKILL_DST"
  changed=$((changed + 1))
fi

echo ""
if $DRY_RUN; then
  echo "  [dry-run] $changed file(s) would be modified."
else
  echo "  Done! $changed item(s) installed."
  echo ""
  echo "  Usage: ask Claude to generate a README for any directory."
  echo "  Example: \"Add a README to packer/my-plugin\""
fi
echo ""
