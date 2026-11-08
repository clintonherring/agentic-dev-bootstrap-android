---
name: agent-memory
description: >-
  Maintain project agent memory (NOW.md, facts, decisions) so intent
  survives context compaction and model switches. Repo-markdown only —
  no external DB. Use when updating memory, after compaction, or
  diagnosing memory hooks.
---

# Agent memory

## Layers

| Layer | Role | Cost |
| --- | --- | --- |
| Rule `.cursor/rules/agent-memory.mdc` | Tiny always-on reflex | Every turn |
| This skill | Procedure: when/what to write, promote | On demand |
| Hooks in `.cursor/hooks.json` | Enforcement: restore after compact, checkpoint nag | Automatic |

A skill alone is not enough. Hooks reinject memory after compaction:

```
preCompact  → write per-conversation needs_restore flag
              (compaction runs; transcript becomes a summary)
postToolUse → see flag → inject NOW + task state + facts + decisions
              (budget ~3000 tokens, NOW first) → clear flag
```

`preCompact` can only return `user_message` (not model context). That is why
restore happens on `postToolUse` / `postToolUseFailure`.

Hooks need `python3` on PATH and fail open by design.

## Files

| Path | Purpose |
| --- | --- |
| `memory/NOW.md` | Current goal, constraints, next action (≤ ~80 lines) |
| `memory/facts.md` | Durable project truths |
| `memory/decisions.md` | Recent decisions, newest first |
| `tasks/ACTIVE` | Optional one-line slug |
| `tasks/<slug>/state.md` | Overflow task state |
| `memory.config.json` | Restore budget + file paths |

## When to write

1. **Goal shift** → rewrite `memory/NOW.md`.
2. **Durable discovery** → add a row to `memory/facts.md`.
3. **Choice made** → prepend to `memory/decisions.md`.
4. **End of session / before compaction** → NOW checkpoint (the stop-hook may
   remind once).
5. **Before phase change** → write state to disk first.

## Repo-markdown only

This repo deliberately keeps memory in git-tracked markdown. There is no
external memory DB and no sync scripts: git history is the audit trail, and
the files above are the whole system. (This is a stripped variant of the ECC
agent-memory distribution; the NocoDB sync layer was removed.)

## Install into another repo

Copy `.cursor/hooks.json`, `.cursor/hooks/`, `.cursor/rules/agent-memory.mdc`,
`.cursor/skills/agent-memory/`, `memory/`, and `memory.config.json`.
