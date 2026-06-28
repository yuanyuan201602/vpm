# VPM Acceptance Criteria — v0.1

*Versioned with PRD_v0.1.md. Both documents change together.*

---

## Engineering health line (necessary, not sufficient)

- [ ] All Markdown files parse without broken links to local files
- [ ] `for-coders/install.sh` is executable and exits 0 on a clean macOS/Linux environment
- [ ] `for-coders/scripts/check_gates.sh` is executable and exits 0 when all gates pass

---

## Product value line (the only gate)

A stranger with no prior context can complete all of the following:

### M0 · Local install

- [ ] Run `bash for-coders/install.sh` → AGENTS.md and check_gates.sh land in correct locations
- [ ] Open a new Claude Code session → SessionStart hook fires and VPM preamble is visible
- [ ] Trigger a Bash tool call → PreToolUse hook fires and check_gates.sh runs
- [ ] `/start-project` produces a filled PRD template and an ACCEPTANCE template with a version number

### M1 · GitHub repo

- [ ] A first-time visitor reads README.md and can answer: "What is VPM? What problem does it solve? How do I install it?" — without reading any other file
- [ ] The `dongfang-namecard` case makes the failure pattern concrete: a reader who has never heard of VPM understands why `sim:user 12/12` and `test:experience 0/8` can coexist
- [ ] CONTRIBUTING.md + cases/TEMPLATE.md together are sufficient for a new contributor to submit a retrospective without asking for help
- [ ] The install kit can be applied to a fresh project in < 15 minutes

---

## Acceptance rules

1. The engineering health line can never pass a failing product value line.
2. Both tiers must be re-verified after every PRD version bump.
3. Product value checks must be run by someone other than the person who wrote the feature (independent review for judgment calls; see Rule 5).
4. Any check that cannot be expressed as a deterministic command or an explicit reviewer question is not an acceptance check — it is a wish.
