# MASTER ANALYSIS — ccplugin-improve

**Date:** 2026-04-22  
**Forge Run:** 1 of 3  
**Analyst:** Jarvis | Sonnet 4.6

---

## 1. Project Overview

`ccplugin-improve` is a Claude Code plugin that analyzes any content (video, article, idea, text) and recommends system improvements — categorizing them into skills, agents, plugins, memory, config, or workflow changes.

**Current state:** Functional MVP with 3 scripts and 1 command. Minimal, works but has significant UX and reliability gaps.

---

## 2. Current Architecture

```
commands/
  improve.md          — Main command (analysis prompt)
  improve-watch.md    — Watch mode (delegates to watch.sh)
scripts/
  read-context.sh     — Reads system state for /improve context
  save-pattern.sh     — Saves approved patterns to knowledge/
  watch.sh            — Polls filesystem for changes
knowledge/
  agent_lead-orchestrator-redesign.md  — Saved pattern example
  token_session-export.md              — Another saved pattern
```

---

## 3. Strengths

- Clean separation of concerns (analyze → save)
- Context-aware: reads live system state before analysis
- Category matrix is well-designed (skill/agent/plugin/memory/config/workflow)
- watch.sh is creative — filesystem polling for continuous improvement

---

## 4. Weaknesses & Gaps

### Critical
1. **No error handling in read-context.sh** — if `agent-registry.json` is missing, Python crashes silently
2. **watch.sh is fragile** — uses `xargs ls -lt` which breaks on filenames with spaces; state comparison is naive
3. **No URL/video input handling** — command says it handles "video, makale" but there's no actual fetch/scrape logic

### Medium
4. **save-pattern.sh overwrites without confirmation** — if pattern name exists, silently clobbers it
5. **No categories.json or taxonomy** — category values are free-form strings, no validation
6. **No list command** — can't view what patterns have been saved without manual `ls knowledge/`
7. **improve-watch.md** just calls watch.sh — no way to filter file types or set exclude patterns

### Low
8. **No tests** — shell scripts have zero test coverage
9. **knowledge/ has no index** — hard to discover saved patterns programmatically
10. **Output format uses emojis** — inconsistent with newer CDS conventions

---

## 5. Opportunities

| Opportunity | Category | Priority | Effort |
|-------------|----------|----------|--------|
| Add `/improve list` subcommand to show saved patterns | Command | High | Quick |
| Add URL fetch to read-context (WebFetch integration) | Feature | High | Medium |
| Fix watch.sh state comparison (use checksums) | Bug Fix | High | Quick |
| Add `--dry-run` flag to save-pattern.sh | UX | Medium | Quick |
| Add pattern deduplication/search | Feature | Medium | Medium |
| Add `--exclude` param to watch.sh | UX | Low | Quick |
| Auto-suggest Jira task creation from approved patterns | Integration | Medium | Medium |

---

## 6. Dependency Analysis

- **Depends on:** `~/.claude/` directory structure, agent-registry.json, Python 3
- **Used by:** End users via `/improve` slash command
- **No hard dependencies** — all scripts use built-in macOS/bash tools

---

## 7. Risk Assessment

- **Low risk** project — no secrets, no network calls (currently)
- Adding URL fetch adds scraping complexity
- watch.sh running in background could conflict with multiple Claude sessions

---

## 8. Recommended Sprint Focus

**Sprint 1:** Fix bugs (watch.sh checksums, read-context error handling, save-pattern dedup)  
**Sprint 2:** Add `/improve list` command + knowledge index  
**Sprint 3:** URL/content fetch integration + auto Jira suggestion
