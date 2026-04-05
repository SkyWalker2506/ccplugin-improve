#!/bin/bash
set -e

PLUGIN_NAME="improve"
INSTALL_DIR="$HOME/.claude/plugins/$PLUGIN_NAME"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "💡 ccplugin-improve kurulum başlıyor..."

mkdir -p "$INSTALL_DIR/scripts" "$INSTALL_DIR/commands" "$INSTALL_DIR/.claude-plugin" "$INSTALL_DIR/knowledge"

if [ "$SCRIPT_DIR" != "$INSTALL_DIR" ]; then
  cp "$SCRIPT_DIR/scripts/"*.sh "$INSTALL_DIR/scripts/"
  cp "$SCRIPT_DIR/commands/"*.md "$INSTALL_DIR/commands/"
  cp "$SCRIPT_DIR/.claude-plugin/plugin.json" "$INSTALL_DIR/.claude-plugin/"
  # Knowledge base: var olanların üzerine yazma
  for f in "$SCRIPT_DIR/knowledge/"*.md; do
    [ -f "$f" ] || continue
    dest="$INSTALL_DIR/knowledge/$(basename $f)"
    [ -f "$dest" ] || cp "$f" "$dest"
  done
fi

chmod +x "$INSTALL_DIR/scripts/"*.sh

echo "✅ ccplugin-improve kuruldu!"
echo "Komutlar: /improve [içerik], /improve-watch [dizin]"
