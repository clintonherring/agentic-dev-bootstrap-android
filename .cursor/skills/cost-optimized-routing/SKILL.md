---
name: cost-optimized-routing
description: >-
  Optimizes Cursor token cost for Ultra: prefer Auto (Cost), Cursor Models pool
  (Composer/Grok), and cheap Task subagents. Classifies explore/plan/build/troubleshoot
  and routes models correctly. Use at the start of every task, when planning,
  building, troubleshooting, or when the user asks about cost or model choice.
---

# Cost-optimized routing (Cursor Ultra)

Clinton is on **Cursor Ultra** (~$200/mo, large included usage). Optimize for **included-pool burn rate**, not abstract API pennies.

## Default model policy

| Priority | Choice | When |
| --- | --- | --- |
| **1 — Default** | **Auto → Optimize for Cost** | Almost all chats. Router picks cheaper models; best Ultra default. |
| **2 — Cheap named** | **Composer 2.5** (Cursor Models pool) | Explicit cheap coding when you want a fixed model; very low $/MTok. |
| **3 — Cursor pool** | Grok 4.5 / 4.6 / 4.7 (non-Fast) | Strong daily building still on the generous Cursor Models pool. |
| **4 — Mid Other Models** | Sonnet-class, Gemini Flash/Pro, GPT mid-tier | Harder coding when Auto/Composer undershoot. |
| **5 — Frontier (sparingly)** | Opus / Fable / GPT high / Max Mode | Architecture, deep debug, security-critical, or after cheaper paths fail. |

### Ultra reality checks

- Two pools: **Cursor Models** (Composer, Grok — generous) vs **Other Models** (third-party API prices — burns faster).
- Composer 2.5 ≈ $0.50 / $2.50 per 1M in/out — usually the cheapest *named* option.
- Auto (Cost) is the right default on Ultra: do **not** avoid Auto.
- Avoid **Fast** variants and **Max Mode** unless explicitly needed (multipliers).
- Avoid long-context (>200k / 1M) windows unless required — they multiply cost.
- Check [cursor.com/dashboard](https://cursor.com/dashboard) usage if burn feels high.

Rates change; prefer pool membership (Cursor vs Other) over memorizing exact numbers. Source: [Models & Pricing](https://cursor.com/docs/models-and-pricing).

## Task classification

Classify before acting:

| Category | Cost | Route | When |
| --- | --- | --- | --- |
| **EXPLORE** | Lowest | `Task` explore, `model="fast"` | Find files, map structure, search |
| **PLAN** | Low | `SwitchMode` → Plan | Architecture, trade-offs, large scope |
| **BUILD-SIMPLE** | Low | `Task` generalPurpose, `model="fast"` | Boilerplate, config, single-file, repetitive |
| **BUILD-COMPLEX** | Higher | Main agent (prefer Auto Cost / Composer) | Multi-file dependent refactors, novel logic |
| **TROUBLESHOOT** | Higher | Main agent (keep chat context) | Debugging that needs conversation history |

### Classification rules

1. Default to cheap; escalate only after failure or clear complexity.
2. Troubleshooting stays on the main agent (context), but the **chat model** should still be Auto Cost unless stuck.
3. Plan before build when multiple approaches exist.
4. Parallelize independent EXPLORE tasks.
5. Never use Max Mode / max-only agents casually; watch >200k context surcharges.

## Workflow

### 1. Classify and announce (brief)

> EXPLORE — spinning a fast explore subagent to keep cost down.

### 2. Task brief (for subagents)

Write `tasks/[task-name]-[date].md` with Objective, Relevant Files, Constraints, What Was Tried.

### 3. Delegate or execute

**EXPLORE:** `Task(subagent_type="explore", model="fast", ...)`

**BUILD-SIMPLE:** `Task(subagent_type="generalPurpose", model="fast", ...)` with a complete brief (no conversation history).

**PLAN:** Switch to Plan mode; after agreement, reclassify implementation.

**BUILD-COMPLEX / TROUBLESHOOT:** Main agent; stay on Auto Cost unless escalating.

### 4. Review subagent output

Verify → update task file → escalate only if needed.

## Escalation

```
L1: Re-prompt fast subagent once (clearer constraints)
L2: Main agent fixes directly (same chat, Auto Cost)
L3: Suggest user switch chat model up one tier (Composer → Sonnet → Opus)
```

## Context preservation

- Main agent keeps conversation context; subagent failures are not lost if orchestrated.
- Persist across sessions via `tasks/` and, when present, `agent-memory` (`memory/NOW.md`).

## Do / Don't

### Do

- Default the **chat** to Auto (Cost) on Ultra
- Prefer Cursor Models pool for routine agent work
- Parallel EXPLORE; split BUILD-SIMPLE into independent pieces
- Plan mode before expensive multi-file coding
- Pair with `ecc-way-of-working` so ECC skills handle the workflow

### Don't

- Avoid Auto on Ultra (old advice — superseded)
- Pin Opus/Fable/Sonnet for search, renames, or boilerplate
- Use Fast / Max / huge context by default
- Use the main agent as a file searcher when EXPLORE exists
- Skip task briefs for delegated work

## Subagent prompt template

```
You are implementing [change] in [project type].

FILES TO READ FIRST:
- [path] — [why]

TASK:
[Concrete change]

PATTERNS TO FOLLOW:
[Paste examples]

CONSTRAINTS:
- [rules]
- Do not change [X]

EXPECTED RESULT:
[observable outcome]
```

## Domain notes

Optimized for Clinton's stack: Docker/compose services, Android (Kotlin), OpenSAR backends, rover/Linux, multi-repo Cursor workspaces.
