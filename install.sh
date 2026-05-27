#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
TARGET="${SELF_MEDIA_SYSTEM_SKILLS_HOME:-$HOME/.agents/skills/self-media-system}"

usage() {
  cat <<'EOF'
Usage:
  ./install.sh [--target PATH]

Options:
  --target PATH  Install to a custom skill directory.
  -h, --help     Show this help.

Default target:
  ~/.agents/skills/self-media-system
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --target)
      TARGET="${2:-}"
      if [[ -z "$TARGET" ]]; then
        echo "ERROR: --target requires a path." >&2
        exit 1
      fi
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "ERROR: Unknown option: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if ! command -v rsync >/dev/null 2>&1; then
  echo "ERROR: rsync is required for installation." >&2
  exit 1
fi

TARGET="${TARGET/#\~/$HOME}"
TARGET_PARENT="$(dirname "$TARGET")"
mkdir -p "$TARGET_PARENT"

if [[ -e "$TARGET" && ! -d "$TARGET" ]]; then
  echo "ERROR: Target exists and is not a directory: $TARGET" >&2
  exit 1
fi

if [[ -d "$TARGET" ]]; then
  TARGET_REAL="$(cd "$TARGET" && pwd -P)"
else
  TARGET_REAL=""
fi

if [[ "$TARGET_REAL" == "$REPO_DIR" ]]; then
  echo "Already installed at $TARGET"
else
  mkdir -p "$TARGET"
  rsync -a \
    --exclude '.git/' \
    --exclude '.DS_Store' \
    --exclude '.self-media-system/' \
    --exclude '.writing-skills/' \
    --exclude '06-wechat-studio/content/' \
    --exclude '06-wechat-studio/AI/' \
    --exclude '06-wechat-studio/workspace-preferences.json' \
    "$REPO_DIR/" "$TARGET/"
  echo "Installed self-media-system skills to $TARGET"
fi

chmod +x "$TARGET/04-content-image-gen/scripts/generate.sh" 2>/dev/null || true
mkdir -p "$HOME/.self-media-system"

if [[ ! -f "$HOME/.self-media-system/.env" && -f "$TARGET/.env.example" ]]; then
  cp "$TARGET/.env.example" "$HOME/.self-media-system/.env"
  echo "Created config template at $HOME/.self-media-system/.env"
fi

echo "Verify:"
echo "  find \"$TARGET\" -name SKILL.md | sort"
