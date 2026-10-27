#!/bin/bash
# ResearchPilot-Skills uninstaller for all editions: zh / en / es.
# Usage: bash uninstall.sh [claude|codex|codebuddy]
set -euo pipefail

TARGET="${1:-claude}"
case "$TARGET" in
  claude)    DEST="$HOME/.claude/skills" ;;
  codex)     DEST="$HOME/.codex/skills" ;;
  codebuddy) DEST="$PWD/.codebuddy/skills" ;;
  *)
    echo "Usage: bash uninstall.sh [claude|codex|codebuddy]" >&2
    exit 1
    ;;
esac

# All editions share these names. G.8 belongs to the Chinese edition.
skills=(
  "research[fig]"
  "research[START]"
  "research[A]-exploration"
  "research[B]-idea"
  "research[C]-experiment"
  "research[D]-implementation"
  "research[E]-coding"
  "research[F]-iteration"
  "research[G.0]-plan"
  "research[G.1]-method"
  "research[G.2]-experiments"
  "research[G.3]-abstract"
  "research[G.4]-introduction"
  "research[G.5]-related"
  "research[G.6]-conclusion"
  "research[G.7]-review"
  "research[G.8]-translate"
)

echo "Uninstalling ResearchPilot-Skills [zh/en/es] from $DEST"
removed=0
for skill in "${skills[@]}"; do
  target="$DEST/$skill"
  if [ -d "$target" ] || [ -L "$target" ]; then
    rm -rf -- "$target"
    echo "  [removed] $skill"
    removed=$((removed + 1))
  fi
done

echo ""
echo "Removed: $removed skills."
