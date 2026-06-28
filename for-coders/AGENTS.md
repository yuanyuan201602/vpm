# AGENTS.md — VPM Project Authority Instructions

*Authoritative instruction source for all AI agents (Claude Code, Codex, Cursor, etc.) on this project. Takes precedence over any other configuration. Keep this file under 200 lines — beyond that, model adherence drops sharply.*

This file has two layers:
- **Layer 1 — Governance (VPM):** is the project aimed at the right target?
- **Layer 2 — Behavior:** does each task get done without silent failure?

---

## Layer 1 — Governance (VPM)

### Before any significant action, know
1. Current PRD version (`docs/PRD_*.md`)
2. Current acceptance criteria version (`docs/ACCEPTANCE_*.md`)
3. The active milestone (`docs/GOALS.md`)
4. The last gate result: `bash for-coders/scripts/check_gates.sh`

If any gate fails, stop. Do not proceed. Report the failure.

### Acceptance has two tiers — only the second is a gate
- **Engineering health line** (build, tests, typecheck, no banned words): necessary, not sufficient.
- **Product value line** (delivers what the PRD promised): the only thing that can stop the project. Judgment calls here require **independent review** — do not self-certify.

### PRD change protocol (the most dangerous moment)
If the PRD changes mid-session:
1. STOP current work.
2. Mark in-progress artifacts `[LEGACY - <prev version>]`.
3. Re-read the new PRD; re-derive acceptance criteria at the new version.
4. Resume only after confirming the new acceptance line. Never continue under an old standard.

### Milestone ordering
Core before shell. No packaging, distribution, or branding until the product value line passes on core. A completed peripheral with a failing core is not progress.

### Banned governance patterns
- Self-reporting completion without running the acceptance checks.
- Updating ACCEPTANCE.md without bumping PRD.md (they version together).
- Verifying a judgment call with a deterministic check.
- Continuing after a PRD bump without re-deriving acceptance criteria.

---

## Layer 2 — Behavior

*Distilled from Andrej Karpathy's notes on recurring LLM coding failures plus community field-testing. See [docs/related-work.md](../docs/related-work.md) for provenance and the layer mapping. These govern HOW each task is executed; Layer 1 governs WHETHER it points at the right target.*

1. **Think before coding.** State assumptions. Ask instead of guessing. Present multiple interpretations when ambiguous. Stop and name what's unclear when confused.
2. **Simplicity first.** Minimum code that solves the problem. Nothing speculative. No abstractions for single-use code.
3. **Surgical changes.** Touch only what you must. Don't "improve" adjacent code or refactor what isn't broken. Match existing style.
4. **Goal-driven execution.** Define verifiable success criteria, then loop until verified — don't follow step-by-step instructions. (This is the bridge to Layer 1.)
5. **Use the model only for judgment calls.** Model: classification, drafting, summarization, extraction. Not: routing, retries, deterministic transforms. If code can answer, code answers. (Mirrors VPM Rule 5.)
6. **Read before you write.** Before editing a file, read its exports, immediate callers, and shared utilities. "Looks orthogonal" is the most dangerous phrase.
7. **Surface conflicts, don't average them.** If two patterns contradict, pick one (newer / better tested), explain why, flag the other for cleanup. Blended conventions are the hardest to maintain.
8. **Tests verify intent, not just behavior.** Each test encodes WHY the behavior matters. A test that still passes when business logic changes is invalid. (This is exactly the dongfang-namecard failure.)
9. **Checkpoint after every significant step.** Summarize what's done, verified, and left. If you can't describe the current state, stop and restate — don't continue from a state you can't recount.
10. **Match codebase conventions, even if you disagree.** Conformance > taste. If a convention is genuinely harmful, surface it for discussion — don't fork silently.
11. **Fail loud.** "Completed" is wrong if anything was silently skipped. "Tests pass" is wrong if any were skipped. Surface uncertainty; never hide it. (Enforced by `check_gates.sh` exit codes.)

> Omitted: a hard token-budget rule (4000/task, 30000/session) circulates in the source material. We do not adopt it — the numbers have no stated derivation and contradict Rule 2. Tune context budgets per project if needed; do not treat fixed numbers as law.

---

## Session start checklist
- [ ] Current PRD version
- [ ] Current acceptance criteria version
- [ ] Active milestone
- [ ] Last gate check result
