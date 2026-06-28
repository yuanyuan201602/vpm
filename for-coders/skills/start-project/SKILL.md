# /start-project

A Claude Code skill that initializes a new VPM-governed project.

## What it does

1. Creates `docs/PRD_v0.1.md` from the VPM PRD template
2. Creates `docs/ACCEPTANCE_v0.1.md` from the VPM acceptance template
3. Creates `docs/GOALS.md` with milestone scaffolding
4. Copies `for-coders/AGENTS.md` to the project root
5. Runs `check_gates.sh` to verify the baseline is clean

## Invocation

```
/start-project
```

Optionally with a project name:

```
/start-project MyProjectName
```

## Skill instructions (for Claude)

When the user runs `/start-project [name]`:

1. Ask: "What is this project trying to do in one sentence?"
2. Ask: "Who is the target user?"
3. Ask: "What is the core value — what must be true for this project to have succeeded?"
4. Use the answers to fill in the PRD template below.
5. Ask: "How will we verify the core value? Specifically — what will a reviewer check, and is it deterministic or a judgment call?"
6. Use the answer to fill in the ACCEPTANCE template.
7. Write both files to `docs/`.
8. Confirm: "PRD and acceptance criteria written. Run `bash for-coders/scripts/check_gates.sh` to verify baseline."

### PRD template

```markdown
# [Project Name] — PRD v0.1

## One-line positioning
[What this does and for whom]

## Problem
[What fails without this]

## Target user
[Who uses this]

## Core value
[What must be true for this project to have succeeded]

## Milestones
### M0 · Core
- Goal: [first verifiable thing that proves core value]
- Acceptance: [specific check]

### M1 · [Next milestone]
- Goal: [...]
- Acceptance: [...]

## Invariants
1. [Non-negotiable constraint derived from the problem, not from theory]
```

### ACCEPTANCE template

```markdown
# [Project Name] — Acceptance Criteria v0.1

*Versioned with PRD v0.1. Both documents change together.*

## Engineering health line (necessary, not sufficient)
- [ ] [deterministic check]
- [ ] [deterministic check]

## Product value line (the only gate)
- [ ] [judgment: reviewer reads X and answers Y]
- [ ] [deterministic: script verifies Z]
```
