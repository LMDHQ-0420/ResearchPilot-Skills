#!/bin/bash
# ResearchPilot-Skills 中文版安装脚本
# 用法：bash install-zh.sh [claude|codex|codebuddy]
# 默认安装到 Claude Code (~/.claude/skills/)

set -e

TARGET="${1:-claude}"

case "$TARGET" in
  claude)    DEST="$HOME/.claude/skills" ;;
  codex)     DEST="$HOME/.codex/skills" ;;
  codebuddy) DEST=".codebuddy/skills" ;;
  *)
    echo "用法：bash install-zh.sh [claude|codex|codebuddy]"
    echo "  claude     → ~/.claude/skills/ （默认）"
    echo "  codex      → ~/.codex/skills/"
    echo "  codebuddy  → .codebuddy/skills/ （当前目录下）"
    exit 1
    ;;
esac

SRC="skills/ResearchPilot-Skills-zh"
mkdir -p "$DEST"

echo "安装中文版 ResearchPilot-Skills → $DEST"

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

for skill in "${skills[@]}"; do
  cp -r "$SRC/$skill" "$DEST/"
  echo "  ✅ $skill"
done

echo ""
echo "安装完成（${#skills[@]} 个 skill）。"
echo "验证：ls \"$DEST\" | grep research"
echo ""
echo "启动后运行 /research[START] 测试安装。"
