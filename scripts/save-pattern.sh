#!/bin/bash
# Onaylanan bir iyileştirmeyi knowledge base'e kaydeder
# Kullanım: save-pattern.sh "pattern-adi" "kategori" "açıklama"
PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
NAME="${1:-unnamed}"
CATEGORY="${2:-general}"
DESC="${3:-}"
FILE="$PLUGIN_DIR/knowledge/${CATEGORY}_${NAME}.md"

cat > "$FILE" <<EOF
---
name: $NAME
category: $CATEGORY
date: $(date -u +%F)
---

# $NAME

$DESC

## Uygulama
<!-- Nasıl uygulandığı -->

## Sonuç
<!-- Ne kazanıldı -->
EOF

echo "✅ Pattern kaydedildi: $FILE"
