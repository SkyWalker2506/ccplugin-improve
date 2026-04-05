#!/bin/bash
# Watch mode: belirtilen dizini izle, değişiklik olunca /improve tetikle
# Kullanım: watch.sh [dizin] [saniye]
WATCH_DIR="${1:-$(pwd)}"
INTERVAL="${2:-30}"
PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
STATE_FILE="/tmp/ccplugin-improve-watch.state"

echo "👁️  Watch mode başlatıldı: $WATCH_DIR (her ${INTERVAL}s)"
echo "Durdurmak için Ctrl+C"

# İlk snapshot
find "$WATCH_DIR" -name "*.md" -o -name "*.sh" -o -name "*.json" 2>/dev/null | \
  xargs ls -lt 2>/dev/null | awk '{print $6,$7,$8,$9}' > "$STATE_FILE"

while true; do
  sleep "$INTERVAL"
  NEW_STATE=$(find "$WATCH_DIR" -name "*.md" -o -name "*.sh" -o -name "*.json" 2>/dev/null | \
    xargs ls -lt 2>/dev/null | awk '{print $6,$7,$8,$9}')

  if [ "$NEW_STATE" != "$(cat $STATE_FILE)" ]; then
    CHANGED=$(diff <(cat "$STATE_FILE") <(echo "$NEW_STATE") | grep '^>' | awk '{print $NF}' | head -5)
    echo ""
    echo "🔄 Değişiklik algılandı: $CHANGED"
    echo "$(date): $CHANGED" >> "$PLUGIN_DIR/knowledge/watch-log.txt"
    echo "$NEW_STATE" > "$STATE_FILE"
    echo "💡 /improve çalıştırarak analiz edebilirsin"
  fi
done
