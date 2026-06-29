# Case: Chinese Cultural Identity Generator

**Outcome: ❌ Did not converge (as of the 2026-06-21 retrospective)**
**VPM pattern: A correct two-tier test system already existed and was catching the gap — but it was never given the authority to stop the project. The PRD had been upgraded; the implementation kept polishing the old product.**

---

## The signals

Re-run at the time of the retrospective, on the live repo:

```
npm test            → 7 files, 54 tests passing   ✓
npm run typecheck   → passing                      ✓
npm run lint        → passing                      ✓
npm run build       → passing                      ✓
npm run sim:user    → 12/12                         ✓   (loose smoke test)

npm run test:experience → 0/8                       ✗   (strict experience test)
```

The engineering health line was green. The product experience line was failing. The gap between "it runs" and "the product holds up" was being measured correctly — and ignored as a gate.

The two strict failures were concrete:
- Formal-refinement collapse: across 8 scenarios, refinement produced only 2 unique names, below the required 3.
- The refine control never entered a clear disabled/used state after the first use — 8/8 scenarios failed `second_refinement_control_not_disabled`.

---

## What happened

The PRD had been upgraded from v1.0 to **v1.1**: the product was no longer a "Chinese name generator." It was now a **Chinese cultural identity system** — the user should receive not a name, but a structured identity package: name, courtesy name (字), art name / brand name (号), cultural imagery, an identity narrative, usage advice, and a visual card.

The implementation never followed. At retrospective time it was still the old MVP model — "one Chinese name + explanation + a refine button":

- The core schema was still `NameResult` (surname, given name, pinyin, one-line meaning, score…). It did not contain the v1.1 fields: `courtesy_name`, `art_name`, `identity_line`, `identity_narrative`, `imagery`, `usage_advice`, `visual_card`, rationale/trace.
- The engine was still a mock chooser over 8 fixed names scored by tag match and string length — not the constraint-solving cultural combination v1.1 required.
- The chat looked like a conversation but was really a one-shot form: submit once → jump to result. No real identity intake.
- The UI and naming were still "Eastern Name Card / 东方名片," even though v1.1 had narrowed the positioning to Chinese / local culture and explicitly warned against Orientalist over-claiming.

No matter how much the old result page was polished, it could only become a more refined version of the wrong product.

---

## The misalignment(s)

The retrospective named four, stacked:

- **Goal misalignment**: the PRD became an identity system; the build kept polishing the old single-name MVP.
- **Milestone inversion**: desktop shell (Tauri), share pages, SVG rendering, and packaging were already underway while the core identity package did not yet stand up.
- **Acceptance misalignment**: passing engineering tests created a feeling of progress; the strict experience test kept failing but was never made the stop-line.
- **Asset misalignment**: an adjacent repo already held a more correct deterministic engine, but no clear primary/secondary relationship had been declared, so effort kept flowing into the old shell.

---

## What VPM would have required

**Rule 2 (the product value line is the only gate):**
`sim:user 12/12` is an engineering health signal — it proves output is produced. `test:experience 0/8` is the product value line. Under VPM the project cannot be called progressing while the value line is red, and the strict test would have been the stop-line from the start.

**Rule 3 (freeze the old direction on a PRD change):**
At PRD v1.1 the old `NameResult` schema and "Eastern Name Card" branding should have been marked `[LEGACY]` immediately, and acceptance re-derived for the identity package. Instead the project kept running under the old standard.

**Rule 4 (core before shell):**
The desktop shell, share, render, and packaging work was real effort spent before the core value line passed. Each one felt like progress and pulled the project further from PRD v1.1.

---

## Source

Original retrospective: the operator's own project log, dated 2026-06-21 (anonymized here).
Operator: solo developer with Claude + Codex.
Stack: Next.js + TypeScript (Web/PWA), Tauri v2 desktop shell.

---

*This is the canonical VPM failure case. Note the sharpest detail: the team had built the right measuring instrument (a two-tier test suite) and it was working. The failure was governance — nobody gave the value line authority to stop the project.*
