#!/bin/bash
# ResearchPilot-Skills 卸载脚本（中英文均可）
# 用法：bash uninstall.sh [claude|codex|codebuddy]

set -e

TARGET="${1:-claude}"

case "$TARGET" in
  claude)    DEST="$HOME/.claude/skills" ;;
  codex)     DEST="$HOME/.codex/skills" ;;
  codebuddy) DEST=".codebuddy/skills" ;;
  *)
    echo "用法 / Usage: bash uninstall.sh [claude|codex|codebuddy]"
    exit 1
    ;;
esac

echo "卸载 ResearchPilot-Skills from $DEST"

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
  "research[G.8]-translate"
)

removed=0
for skill in "${skills[@]}"; do
  target="$DEST/$skill"
  if [ -d "$target" ]; then
    rm -rf "$target"
    echo "  🗑️  $skill"
    ((removed++)) || true
  fi
done

echo ""
echo "已卸载 $removed 个 skill。"
