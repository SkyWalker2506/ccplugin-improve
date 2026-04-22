# SPRINT PLAN — ccplugin-improve

**Date:** 2026-04-22  
**Based on:** MASTER_ANALYSIS.md  
**Forge Runs:** 3 × 3 sprints

---

## Sprint 1 — Bug Fixes & Reliability

**Goal:** Make existing functionality solid and trustworthy.

| Task | Description | Effort |
|------|-------------|--------|
| S1-T1 | Fix `read-context.sh`: wrap Python block in try/except, handle missing agent-registry.json | Quick |
| S1-T2 | Fix `watch.sh`: replace `xargs ls -lt` with `find + sha256` checksum for reliable state comparison | Quick |
| S1-T3 | Fix `save-pattern.sh`: check if file exists before writing, prompt or add `--force` flag | Quick |
| S1-T4 | Add timestamp and category validation to `save-pattern.sh` | Quick |
| S1-T5 | Add error exit codes to all scripts (set -euo pipefail) | Quick |

---

## Sprint 2 — List & Discovery Commands

**Goal:** Make saved patterns discoverable.

| Task | Description | Effort |
|------|-------------|--------|
| S2-T1 | Create `scripts/list-patterns.sh` — list all knowledge/*.md with name, category, date | Quick |
| S2-T2 | Add `/improve list` subcommand to `commands/improve.md` | Quick |
| S2-T3 | Create `knowledge/INDEX.md` — auto-generated index of all patterns | Quick |
| S2-T4 | Update `save-pattern.sh` to regenerate INDEX.md after saving | Quick |
| S2-T5 | Add pattern search: `list-patterns.sh --category skill` filtering | Quick |

---

## Sprint 3 — URL & Content Fetch Integration

**Goal:** Actually handle the "video, makale" use cases promised by the command.

| Task | Description | Effort |
|------|-------------|--------|
| S3-T1 | Add URL detection to `improve.md` — if arg starts with http, fetch via `mcp__fetch__fetch_readable` | Medium |
| S3-T2 | Add YouTube transcript support — detect youtube.com URLs, use `fetch_youtube_transcript` | Medium |
| S3-T3 | Update `read-context.sh` to include recent git log (last 5 commits) as context | Quick |
| S3-T4 | Add `--jira` flag suggestion to output format in `improve.md` | Quick |
| S3-T5 | Create `knowledge/watch-log.txt` gitignore entry | Quick |

---

## Task Priority Matrix

| Priority | Tasks |
|----------|-------|
| P0 (Critical) | S1-T1, S1-T2, S1-T3, S1-T5 |
| P1 (High) | S2-T1, S2-T2, S2-T3, S2-T4 |
| P2 (Medium) | S1-T4, S2-T5, S3-T1, S3-T2 |
| P3 (Low) | S3-T3, S3-T4, S3-T5 |

---

## Skip Criteria (>2hr tasks)

- No tasks exceed 2hr estimate. All are shell script edits or markdown updates.
