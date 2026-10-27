#!/bin/bash
# Instalador de ResearchPilot-Skills en español.
# Uso: bash install-es.sh [claude|codex|codebuddy]
set -euo pipefail

TARGET="${1:-claude}"
case "$TARGET" in
  claude)    DEST="$HOME/.claude/skills" ;;
  codex)     DEST="$HOME/.codex/skills" ;;
  codebuddy) DEST="$PWD/.codebuddy/skills" ;;
  *)
    echo "Uso: bash install-es.sh [claude|codex|codebuddy]" >&2
    exit 1
    ;;
esac

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/skills/ResearchPilot-Skills-es"
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
)

# Verificar el paquete completo antes de modificar el destino.
for skill in "${skills[@]}"; do
  if [ ! -f "$SRC/$skill/SKILL.md" ]; then
    echo "[ERROR] No se encontró: $SRC/$skill/SKILL.md" >&2
    exit 1
  fi
done

mkdir -p -- "$DEST"
echo "Instalando ResearchPilot-Skills en español en $DEST"
for skill in "${skills[@]}"; do
  cp -R -- "$SRC/$skill" "$DEST/"
  echo "  [OK] $skill"
done

echo ""
echo "Completado: ${#skills[@]} habilidades."
echo "Reinicia el asistente y ejecuta /research[START]."
