#!/usr/bin/env bash
# Sync skills: .cursor/skills (canonical) -> .claude/skills (mirror).
# Both Cursor and Claude Code auto-discover in-repo project skills.
# To keep a skill Cursor-only (e.g. an infra skill that needs your MCP
# tokens), set exclude below to its directory name — it is never mirrored.
# Usage: bash scripts/sync-skills.sh [--check]
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
src="$root/.cursor/skills"
dst="$root/.claude/skills"
# Set to a skill directory name to keep it Cursor-only (never mirrored):
exclude=""

[[ -d "$src" ]] || { echo "Canonical skills dir not found: $src" >&2; exit 2; }

is_excluded() { [[ -n "$exclude" && "$1" == "$exclude" ]]; }

if [[ "${1:-}" == "--check" ]]; then
  status=0
  for s in "$src"/*/; do
    name="$(basename "$s")"
    is_excluded "$name" && continue
    diff -qr "$s" "$dst/$name" >/dev/null 2>&1 || status=1
  done
  if [[ -d "$dst" ]]; then
    for d in "$dst"/*/; do
      [[ -d "$d" ]] || continue
      name="$(basename "$d")"
      is_excluded "$name" && continue
      [[ -d "$src/$name" ]] || status=1
    done
  else
    status=1
  fi
  if [[ $status -eq 0 ]]; then
    echo "Skills in sync."
  else
    echo "OUT OF SYNC - run: bash scripts/sync-skills.sh"
  fi
  exit $status
fi

mkdir -p "$dst"
# Remove stale mirrored dirs (keep excluded)
for d in "$dst"/*/; do
  [[ -d "$d" ]] || continue
  name="$(basename "$d")"
  is_excluded "$name" && continue
  [[ -d "$src/$name" ]] || rm -rf "$d"
done
# Mirror each canonical skill
for s in "$src"/*/; do
  name="$(basename "$s")"
  is_excluded "$name" && continue
  rm -rf "${dst:?}/$name"
  cp -R "$s" "$dst/$name"
done
if [[ -n "$exclude" ]]; then
  echo "Synced .cursor/skills -> .claude/skills (excluded: $exclude)."
else
  echo "Synced .cursor/skills -> .claude/skills."
fi
