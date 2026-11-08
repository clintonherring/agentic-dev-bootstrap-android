# Facts

- Bootstrapped from `agentic-dev-bootstrap-android`; project specifics are decided at kickoff (`tasks/PROJECT-KICKOFF.md`).
- Frontend target: Android (Kotlin, Jetpack Compose, Material 3).
- Skills live in-repo: `.cursor/skills` (canonical) + `.claude/skills` (mirror via `scripts/sync-skills.*`).
- Memory is repo-markdown only (`memory/` + Cursor hooks); no external memory DB.
- Project index is tiered in `.context/` (skill: `context-tiering`) — read tiers before source.
