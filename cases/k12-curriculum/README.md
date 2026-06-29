# Case: K12 AI Literacy Curriculum (Module 1)

**Outcome: ✅ Converged**
**VPM pattern: Spec-first at every carrier change + independent review that must cite evidence, must be written to disk, and never rubber-stamps. The maker⟂reviewer separation, re-applied each time the medium changed.**

---

## The signals

```
website acceptance        → 16/16 lessons pass    ✓
banned-word scan          → 0 hits                 ✓
48 self-test answers vs source of truth → 100% match   ✓
```

---

## What happened

This was not "write some articles." It was maintaining a curriculum knowledge base that grew across 16 lessons and **kept changing carrier**: text → student book → illustrations → interactive demos → website → delivery archive. The hard problem throughout was consistency and being age-appropriate without errors.

Scope: 16 lessons (~5,000 characters each, a fixed nine-part structure), 34 finalized illustrations, 29 interactive demos/animations, and a data-driven website covering all 16 lessons.

The method that made it converge, applied at every carrier change:

1. **Spec first.** Before producing, write the standard: a writing style guide, then an illustration review protocol + style spec, then demo spec-cards + visual spec, then website spec + acceptance criteria. The quality ceiling was set by the spec, every time.
2. **Independent review that doesn't rubber-stamp.** Writing had self-check lists; illustrations were reviewed across **3 reader perspectives × 7 dimensions**; demos used Codex self-check *plus a separate Claude second review that read the source against the spec card rather than trusting Codex's own QA log*; the website used dual teacher/student reviewer roles.
3. **Review must cite and must be written to disk.** Every review round was saved as `REVIEW_round-N.md` — not reported verbally in chat. Hard rule: never judge "empty frame / typo" from a thumbnail; crop and zoom. Honesty rule: if you can't see it, mark "needs human verification" — don't guess.
4. **Generate → check → revise → check, with round limits.** Images were redone on reject; demos capped at ~3 rounds (one ran 6); the website had a "failed twice, sent back to rebuild" round.

---

## What independent review actually caught

This is the proof the review was real, not ceremony:

- A decision-tree demo (INT-07) was built with 2 layers when the spec required 3 — a P0 teaching defect, caught and rebuilt as a recursive 3-layer tree.
- During a revision, the author (the AI) introduced a banned superlative ("最强"); the reviewer caught it. (Revisions must pass the gate too; banned words also caught by deterministic grep.)
- Illustration empty-frames and text overflowing the frame — caught only because the rule forced crop-and-zoom instead of thumbnail judgment.
- A microphone demo (INT-10) needed a real HTTPS environment the sandbox couldn't cover — marked "needs real-device verification" rather than passed.

---

## The alignment(s)

- **Rule 1 (PRD and acceptance together):** spec-first meant the acceptance bar existed before production, re-derived at every carrier change.
- **Rule 5 (independent review for judgment, deterministic for facts):** age-appropriateness and teaching correctness went to independent reviewers reading the real artifact; banned words went to deterministic grep.
- **The maker⟂reviewer separation in practice:** review was independent of production, had to cite evidence, and had to be written to disk — exactly the separation VPM makes a first-class rule.

---

## Source

Original retrospective: the operator's own full-lifecycle report, 2026-05 (writing) → 2026-06-20 (website + archive).
Operator: solo developer with Claude (writing/spec/review/website) + Codex (image generation, demos, layout).
Stack: Markdown / PDF / DOCX, data-driven static site (template + per-lesson JSON + build script).

---

*The most valuable output was not the book, images, demos, and website — it was a repeatable production method: spec first, then multi-role independent review that cites evidence and is written to disk, then bounded revision. It held at every carrier change.*
