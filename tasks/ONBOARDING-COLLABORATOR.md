# Onboarding — collaborator (running todo)

Living checklist for bringing a collaborator + their agent into this project
in **PR-only mode**. **Agent: work top to bottom, tick boxes (`[x]`) as items
complete, and include the updated checklist in your PRs. Owner: add new work
items at the bottom of Phase 3 as they come up.**

Replace `<owner>` and `<repo-url>` before sending (your agent can do this).

## Phase 0 — human prerequisites (collaborator, by hand)

- [ ] Create a GitHub account (<https://github.com/signup>) if you don't have one
- [ ] Accept the owner's collaborator invite (GitHub email / notifications)
- [ ] Install git (<https://git-scm.com/downloads>) — default options are fine
- [ ] Install your agent harness: Cursor (<https://cursor.com>) or Claude Code
      (<https://claude.com/claude-code>) and sign in

## Phase 1 — first session (3 commands + 1 prompt)

Open a terminal (PowerShell is fine) anywhere and run:

```powershell
git clone <repo-url>
cd <repo-folder>
```

Then start your agent (`claude`, or open the folder in Cursor) and paste:

```text
Read CLAUDE.md and follow everything it says — especially the "Collaboration
model": you work PR-only, never push to main, never merge. Then open
tasks/ONBOARDING-COLLABORATOR.md (this file) and work through Phase 2.
```

- [ ] Repo cloned
- [ ] Agent started inside the repo folder

## Phase 2 — agent setup (the agent does these autonomously)

- [ ] Run `git config core.hooksPath scripts/git-hooks` — activates the
      pre-push guard that blocks pushes to `main`
- [ ] Verify with `git config core.hooksPath` (prints `scripts/git-hooks`)
- [ ] Confirm the shared skills are present in `.claude/skills/` (Claude Code)
      or `.cursor/skills/` (Cursor) — they ship with the repo
- [ ] Read `memory/NOW.md`, `.context/current_task.md`, and
      `.context/current_spec.md` for current project state
- [ ] Read the architecture docs in `docs/`
- [ ] Tell the collaborator, in 3 plain sentences: what this project is, how
      the PR-only workflow goes, and what the first open work item is

## Phase 3 — open work items (the running todo)

Discussion items land here; answers and changes land in `docs/` via PR.

- [ ] (Owner adds the first work items here)

<!-- Owner: append new items below this line -->
