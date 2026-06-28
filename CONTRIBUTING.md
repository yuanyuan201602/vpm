# Contributing to VPM

VPM improves through real cases. Theory without cases is just speculation.

---

## The most valuable contribution: a retrospective

If you have used AI agent tools on a complex project and experienced goal drift — the engineering looked healthy but the product was off target — your retrospective is worth more than any theoretical improvement to the framework.

A good retrospective answers:
1. What were the engineering health line signals? (build, tests, linting)
2. What was the product value line? Was it defined? Was it enforced?
3. Where did the target drift? When did you notice?
4. What would VPM's rules have changed?

Use the [case template](cases/TEMPLATE.md). A first contribution can be rough — the template will guide you.

---

## Other ways to contribute

**Rule challenges.** If a VPM rule is wrong, ambiguous, or missing an important case, open an issue with `[rule]` in the title. Include the case that breaks it. Rules without counter-cases will not be changed.

**Tool-specific adaptations.** VPM's install kit targets Claude Code + Codex. If you have validated it on Cursor, Windsurf, or another tool, a PR with the adapted wiring files is welcome.

**Translations.** The framework is currently English + Chinese. Other languages welcome.

---

## What VPM does not accept

- Rules derived only from theory, with no supporting case
- Changes that make the framework more complex without demonstrably solving a real failure mode
- Acceptance criteria that cannot be expressed as executable checks

---

## Process

VPM is developed under its own rules.

Every rule change requires:
- A case that motivates it (either a failure the rule prevents, or a success the rule explains)
- An executable check that verifies the rule is being followed
- A version bump in PRD + ACCEPTANCE (they change together)

PRs that change a rule without updating both documents will be closed.

---

## First contribution checklist

- [ ] Read [README.md](README.md) — especially the three-layer model
- [ ] Read the [Chinese Identity Generator case](cases/dongfang-namecard/) — this is the canonical failure case
- [ ] Copy [cases/TEMPLATE.md](cases/TEMPLATE.md) into a new directory under `cases/`
- [ ] Fill in the template with your project's data
- [ ] Open a PR — rough is fine, the template has the structure
