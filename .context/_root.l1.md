# agentic-dev-bootstrap-android (fresh clone)

## Purpose

Agent-led bootstrap for durable Android projects. Until the kickoff interview
(`tasks/PROJECT-KICKOFF.md`) is complete, this repo is a template: `docs/`
are fill-in templates, `memory/` holds seeds, and this index describes the
bootstrap itself. After kickoff, rewrite this file for the project.

## Key entry points

- `CLAUDE.md` / `AGENTS.md` — agent bootstrap (kickoff protocol, session protocol, skills, memory, collaboration model)
- `tasks/PROJECT-KICKOFF.md` — the interview that generates the project
- `memory/NOW.md` — current intent (kickoff pending)
- `.context/current_task.md` — work state

## Structure

- `.cursor/skills` (canonical) + `.claude/skills` (mirror) — sync via `scripts/sync-skills.*`
- `.cursor/hooks` + `.cursor/hooks.json` — memory restore/nag hooks (python3, fail-open)
- `.cursor/rules/agent-memory.mdc` — always-on memory rule
- `.context/` — tiered index (this file, dir indexes, state files)
- `memory/` — NOW.md, facts.md, decisions.md
- `docs/` — templates + `references/` + `example/` (fictional worked example)
- `tasks/` — kickoff, collaborator onboarding, working notes (`TOPIC-YYYY-MM-DD.md`)
- `scripts/` — skill sync utilities + `git-hooks/pre-push` push guard (blocks collaborator pushes to `main`; enable via `git config core.hooksPath scripts/git-hooks`)

## Relationships

- `tasks/PROJECT-KICKOFF.md` answers → `docs/`, `memory/`, this index, `CLAUDE.md` intro
- Live infra (database / automation / design boards) = owner's environment only; other agents record infra asks in `memory/NOW.md` → "For owner (infra asks)"
- `docs/db-structure.md` → database schema (once infra exists)
- `docs/backend-flow-mapping.md` → backend workflows (once infra exists)
