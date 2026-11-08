# Current Specification

## Active Feature

- **Feature**: TBD at kickoff
- **Version**: 0.1.0
- **Branch**: main

## Requirements

- [ ] Filled by the kickoff interview (`tasks/PROJECT-KICKOFF.md`)

## Architecture Decisions

Carried from the bootstrap (keep unless the project overrides):

- Android M3 Compose frontend (skill: `android-ui-m3`)
- Repo-markdown memory; dual-location skills, canonical `.cursor/skills`
- Tiered `.context/` index; read tiers before source
- Infra-specific skills stay Cursor-only via sync exclusion

## Test Matrix

| Test | Status | Date | Notes |
|------|--------|------|-------|
| sync-skills check | pending | — | run after first pull |
| memory hook smoke test | pending | — | Cursor only |

## Release Checklist

- [ ] Kickoff interview complete
- [ ] `docs/` filled from answers
- [ ] `CLAUDE.md`/`AGENTS.md` rewritten for the project
