# Project kickoff interview (agent-led)

**Agent**: this file drives the first session on a fresh clone. Walk the
owner through each section, one at a time — ask, listen, propose when they
say "not sure". Tick boxes as answers land. When every section is done, run
the "Generate" section.

**Owner**: there are no wrong answers. "Not sure" means the agent proposes
and you approve.

## 1. Project identity

- [ ] Project name
- [ ] One-line description
- [ ] Demo or production-bound?

## 2. App shape

- [ ] Who uses it? (roles — e.g. owner / staff / customer)
- [ ] Core screens (the agent turns these into `docs/app-flow.md`)
- [ ] The 3 most important user flows
- [ ] Must-have vs nice-to-have features

## 3. Infrastructure

> Suggested default: **NocoDB** (database) + **n8n** (backend workflows
> exposing webhook APIs). Say yes, or pick alternatives.

- [ ] Database: NocoDB (suggested) / Supabase / Firebase / custom / none yet
- [ ] Backend: n8n workflows (suggested) / Supabase functions / Firebase / custom API
- [ ] Auth needs (a dummy login is fine for demos)
- [ ] File / media storage needed?
- [ ] Who operates the infra? Remember: infra access lives only in the
      operator's environment. Agents without access record infra asks in
      `memory/NOW.md` → "For owner (infra asks)" — they never get tokens.

## 4. Device constraints

- [ ] Portrait, landscape, or both?
- [ ] Special hardware (barcode scanner, NFC, printer, POS peripheral)?
- [ ] Minimum Android version
- [ ] Target device known (datasheet → `docs/references/`)?

## 5. Design

- [ ] Material 3 (standard, via `android-ui-m3` skill — confirm)
- [ ] Design references (links → `docs/references/`)
- [ ] Brand identity work now (skills: `brand-discovery`, `brand-voice`) or later?

## 6. Collaboration

- [ ] Solo project or collaborators?
- [ ] If collaborators: they work PR-only (see the collaboration model in
      `CLAUDE.md`). Note their GitHub usernames here for the record.
- [ ] Collaborator onboarding needed? → `tasks/ONBOARDING-COLLABORATOR.md`

## 7. Generate (the agent does all of this)

- [ ] Fill `docs/app-flow.md`, `docs/component-process-map.md`,
      `docs/db-structure.md`, `docs/backend-flow-mapping.md` from the answers
- [ ] Seed `memory/NOW.md`, `memory/facts.md`, `memory/decisions.md` with
      the decisions made
- [ ] Update `.context/` (root, `current_task.md`, `current_spec.md`, dir
      indexes) for the new project
- [ ] Rewrite the `CLAUDE.md` / `AGENTS.md` intro for the project and remove
      the "First run" section
- [ ] Record any infra asks in `memory/NOW.md` → "For owner (infra asks)"
- [ ] Commit the generated project baseline
