#!/bin/bash
# ResearchPilot-Skills English version installer
# Usage: bash install-en.sh [claude|codex|codebuddy]
# Default: Claude Code (~/.claude/skills/)

set -e

TARGET="${1:-claude}"

case "$TARGET" in
  claude)    DEST="$HOME/.claude/skills" ;;
  codex)     DEST="$HOME/.codex/skills" ;;
  codebuddy) DEST=".codebuddy/skills" ;;
  *)
    echo "Usage: bash install-en.sh [claude|codex|codebuddy]"
    echo "  claude     → ~/.claude/skills/ (default)"
    echo "  codex      → ~/.codex/skills/"
    echo "  codebuddy  → .codebuddy/skills/ (current directory)"
    exit 1
    ;;
esac

SRC="skills/ResearchPilot-Skills-en"
mkdir -p "$DEST"

echo "Installing ResearchPilot-Skills (English) → $DEST"

skills=(
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
)

for skill in "${skills[@]}"; do
  cp -r "$SRC/$skill" "$DEST/"
  echo "  ✅ $skill"
done

echo ""
echo "Installation complete (${#skills[@]} skills)."
echo "Verify: ls \"$DEST\" | grep research"
echo ""
echo "Run /research[START] in Claude Code to test."
