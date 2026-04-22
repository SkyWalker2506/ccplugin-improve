#!/bin/bash
# Watch mode: monitor directory for changes, trigger /improve on change
# Usage: watch.sh [directory] [interval_seconds]
set -euo pipefail

WATCH_DIR="${1:-$(pwd)}"
INTERVAL="${2:-30}"
PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
STATE_FILE="/tmp/ccplugin-improve-watch-$$.state"
LOG_FILE="$PLUGIN_DIR/knowledge/watch-log.txt"

# Cleanup state file on exit
trap 'rm -f "$STATE_FILE"' EXIT

echo "Watch mode started: $WATCH_DIR (every ${INTERVAL}s)"
echo "Press Ctrl+C to stop"

# Compute checksum of tracked files (sorted, handles spaces in filenames)
_checksum() {
  find "$1" \( -name "*.md" -o -name "*.sh" -o -name "*.json" \) \
    -not -path '*/.git/*' \
    -exec stat -f "%m %N" {} \; 2>/dev/null | sort | md5
}

# Initial snapshot
_checksum "$WATCH_DIR" > "$STATE_FILE"

while true; do
  sleep "$INTERVAL"
  NEW_HASH=$(_checksum "$WATCH_DIR")
  OLD_HASH=$(cat "$STATE_FILE")

  if [ "$NEW_HASH" != "$OLD_HASH" ]; then
    CHANGED=$(find "$WATCH_DIR" \( -name "*.md" -o -name "*.sh" -o -name "*.json" \) \
      -not -path '*/.git/*' -newer "$STATE_FILE" 2>/dev/null | head -5 | tr '\n' ' ')
    echo ""
    echo "Change detected: $CHANGED"
    echo "$(date -u +%FT%TZ): $CHANGED" >> "$LOG_FILE"
    echo "$NEW_HASH" > "$STATE_FILE"
    echo "Run /improve to analyze the changes"
  fi
done
