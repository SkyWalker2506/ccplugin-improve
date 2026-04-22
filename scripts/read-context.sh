#!/bin/bash
# Mevcut sistemin durumunu okur — /improve analizine context sağlar
set -euo pipefail
PLUGIN_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "=== SYSTEM CONTEXT ==="
echo "Date: $(date -u +%FT%TZ)"
echo ""

# Skills
echo "--- SKILLS ---"
ls "$CLAUDE_DIR/skills/" 2>/dev/null | tr '\n' ' '
echo ""

# Agents (active)
echo "--- ACTIVE AGENTS ---"
python3 -c "
import json, os, sys
try:
    f = os.path.expanduser('~/.claude/config/agent-registry.json')
    if not os.path.exists(f):
        print('(agent-registry.json not found)')
        sys.exit(0)
    d = json.load(open(f))
    active = d.get('active_agents', [])
    agents = d.get('agents', {})
    if not active:
        print('(no active agents)')
    for id in active:
        a = agents.get(id, {})
        print(f'{id}: {a.get(\"name\",\"?\")} ({a.get(\"primary_model\",\"?\")}) — {\" \".join(a.get(\"capabilities\",[])[:3])}')
except Exception as e:
    print(f'(error reading agent registry: {e})')
" 2>/dev/null || echo "(python3 not available)"

# Plugins
echo ""
echo "--- INSTALLED PLUGINS ---"
ls "$CLAUDE_DIR/plugins/" 2>/dev/null | tr '\n' ' '
echo ""

# Recent memory
echo ""
echo "--- RECENT MEMORY (last 5) ---"
ls -t "$CLAUDE_DIR/projects/"*/memory/*.md 2>/dev/null | head -5 | while read f; do
  echo "$(basename $f): $(head -1 $f | sed 's/^#* *//')"
done

# Knowledge base
echo ""
echo "--- KNOWN PATTERNS ---"
ls "$PLUGIN_DIR/knowledge/" 2>/dev/null | grep '\.md$' | sed 's/\.md$//' | tr '\n' ', '
echo ""
