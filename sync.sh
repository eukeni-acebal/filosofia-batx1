#!/usr/bin/env bash
# sync.sh — flujo de dos máquinas, VIAJA con el repo (está en git).
#   ./sync.sh pull            → al EMPEZAR  (git pull [+ clasp pull si es proyecto GAS])
#   ./sync.sh push "mensaje"  → al TERMINAR (git add+commit+push [+ clasp push])
set -uo pipefail
cd "$(dirname "$0")"
case "${1:-}" in
  pull)
    git pull --rebase --autostash
    [ -f .clasp.json ] && clasp pull
    ;;
  push)
    git add -A
    git commit -m "${2:-wip}" || echo "(nada que commitear)"
    git push
    [ -f .clasp.json ] && clasp push
    ;;
  *)
    echo "Uso: ./sync.sh pull   |   ./sync.sh push \"mensaje\""
    exit 1
    ;;
esac
