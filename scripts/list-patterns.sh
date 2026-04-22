#!/bin/bash
# List all saved patterns in the knowledge base
# Usage: list-patterns.sh [--category <category>] [--search <term>]
set -euo pipefail

PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
KNOWLEDGE_DIR="$PLUGIN_DIR/knowledge"
FILTER_CATEGORY=""
SEARCH_TERM=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --category) FILTER_CATEGORY="$2"; shift 2 ;;
    --search)   SEARCH_TERM="$2"; shift 2 ;;
    -h|--help)
      echo "Usage: list-patterns.sh [--category <category>] [--search <term>]"
      echo "Categories: skill, agent, plugin, memory, config, workflow, general"
      exit 0 ;;
    *) echo "Unknown argument: $1" >&2; exit 1 ;;
  esac
done

found=0
echo ""
printf "%-30s %-12s %-10s\n" "Name" "Category" "Date"
echo "$(printf '%.0s-' {1..55})"

for f in "$KNOWLEDGE_DIR"/*.md; do
  [ -f "$f" ] || continue
  fname=$(basename "$f" .md)
  [ "$fname" = "INDEX" ] && continue

  cat_val=$(grep '^category:' "$f" 2>/dev/null | head -1 | sed 's/category: *//' || echo "unknown")
  date_val=$(grep '^date:' "$f" 2>/dev/null | head -1 | sed 's/date: *//' || echo "unknown")
  title=$(grep '^# ' "$f" 2>/dev/null | head -1 | sed 's/^# //' || echo "$fname")

  # Apply category filter
  if [ -n "$FILTER_CATEGORY" ] && [ "$cat_val" != "$FILTER_CATEGORY" ]; then
    continue
  fi

  # Apply search filter (search in title and description)
  if [ -n "$SEARCH_TERM" ]; then
    if ! grep -qi "$SEARCH_TERM" "$f" 2>/dev/null; then
      continue
    fi
  fi

  printf "%-30s %-12s %-10s\n" "$title" "$cat_val" "$date_val"
  found=$((found + 1))
done

echo ""
echo "$found pattern(s) found."

if [ $found -eq 0 ] && [ -z "$FILTER_CATEGORY" ] && [ -z "$SEARCH_TERM" ]; then
  echo "No patterns saved yet. Use /improve and approve suggestions to add patterns."
fi
