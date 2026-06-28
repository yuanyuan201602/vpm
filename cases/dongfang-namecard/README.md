# Case: Chinese Identity Generator (东方名片)

**Outcome: ❌ Did not converge**
**VPM pattern: Engineering health line was green the entire time. Product value line was never defined or enforced.**

---

## The signals

```
npm test              → 54 tests passing    ✓
npm run typecheck     → passing             ✓
npm run build         → passing             ✓
npm run sim:user      → 12/12               ✓

npm run test:experience → 0/8              ✗
```

Everything green. Product completely off target.

`sim:user` tested whether the system could produce *some* output when given a user prompt. It passed 12/12.

`test:experience` asked: "Is the generated content actually a high-quality Chinese cultural identity card, as the PRD described?" It failed 8/8.

The engineering health line was passing the whole time. The product value line — the only line that actually asked *"did we build what the PRD said?"* — was failing. Nobody had given it the authority to stop the project.

---

## What happened

The project was a generator for Chinese cultural identity cards ("东方名片") — not generic profiles, but cards that convey cultural depth, historical resonance, and identity specificity for Chinese users. The PRD described this clearly.

The agent (Claude + Codex stack) was given the PRD. It built a system that passed all engineering checks. `sim:user` simulated 12 user sessions and verified that responses were produced. Tests passed. Types were clean. Build succeeded.

What the agent actually built was a generic profile generator. The outputs had Chinese names and some culturally adjacent vocabulary, but they did not convey cultural depth, historical resonance, or identity specificity. A user reading the output would recognize that something was missing — but the test suite did not check for this.

The `test:experience` suite was written after the engineering work was complete. It asked a reviewer to read actual generated outputs and answer: does this feel like a genuine Chinese cultural identity card? 0 of 8 outputs passed.

---

## The misalignment(s)

- **Acceptance misalignment**: The acceptance suite (`sim:user`) tested the wrong thing. It verified that output was produced, not that the output matched the product promise.
- **Self-report accepted as verification**: The agent's own test framework was used as acceptance. No independent reviewer read the actual output until after the project was declared "complete."
- **Goal misalignment**: The PRD described cultural depth and identity specificity. The implementation targeted "Chinese-looking profile generation." These are not the same target, but the tests did not distinguish them.

---

## What VPM would have required

**Rule 1 (PRD and acceptance criteria are one artifact):**
The PRD described "cultural depth and identity specificity." If the acceptance criteria had been written at the same time as the PRD, the author would have been forced to answer: "How do I verify cultural depth?" That question would have surfaced the need for an independent human reviewer before a single line of code was written.

**Rule 2 (Product value line is the only gate):**
`sim:user 12/12` would have been classified as an engineering health line check — it proves output is produced, not that the output is good. It would not have been allowed to serve as the acceptance gate. `test:experience` would have been required to pass before the project was declared done.

**Rule 5 (Independent review for judgment calls):**
"Does this convey Chinese cultural identity?" is a judgment call. A banned-words scanner cannot answer it. A build check cannot answer it. VPM requires a human reviewer to read the actual output and answer the actual question. The producer's self-report is explicitly banned as acceptance evidence for this type of check.

---

## Source

Original retrospective: internal project log (anonymized)
Operator: solo developer
Stack: Claude Code + Codex, TypeScript
Date: 2026 Q1

---

*This is the canonical VPM failure case. All five VPM rules can be traced back to the failure modes visible in this project.*
