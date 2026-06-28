# Related Work: VPM and the Karpathy CLAUDE.md Rules

## Why this document exists

The most cited behavioral contract for AI coding agents is the set of rules distilled from Andrej Karpathy's observations on recurring LLM coding failures (4 core rules, later extended to 12 by community field-testing). VPM and that rule set are frequently confused because both address the same anxiety: *"the agent said it was done, but it wasn't."*

They are not competitors. They operate at different layers. This document maps the relationship so contributors and users know which tool solves which problem.

---

## The layer mapping

Using VPM's three-layer model:

```
VPM governance        ← "Is the project aimed at the right target?"
  └─ Loop / Harness   ← "Does each task get done correctly?"  ← Karpathy 12 live here
```

The Karpathy rules are a **single-task behavioral contract**. They make one unit of agent work safe: don't delete code blindly, read context first, fail loud, test intent. They say nothing about whether the project as a whole is converging to the PRD.

VPM is a **project-level governance layer**. It assumes each task is executed competently (which the Karpathy rules help ensure) and asks the question above it: even if every task succeeds, is the acceptance line pointed at real value?

**An agent can follow all 12 Karpathy rules perfectly and still build the wrong product** — exactly the dongfang-namecard failure. That gap is what VPM exists to close.

---

## Direct overlaps (independent convergence)

Two independent sources — Karpathy/community field-testing across 30+ repos, and VPM's three project retrospectives — landed on the same rules. Convergence from independent evidence raises confidence in these specific rules:

| Karpathy rule | VPM equivalent |
|---------------|----------------|
| #4 Goal-driven execution (define verifiable success criteria) | VPM's foundation — the acceptance line *is* the verifiable success criterion |
| #5 Use the model only for judgment calls | VPM Rule 5 (deterministic checks for facts, independent review for judgment) — nearly identical |
| #9 Tests verify intent, not just behavior | The dongfang-namecard lesson (`sim:user` tested behavior; `test:experience` tested intent) |
| #12 Fail loud / no silent failure | VPM Rule 2 + `check_gates.sh` exit-code discipline |

---

## What VPM borrows from the Karpathy work

1. **A complete behavior layer.** VPM's `AGENTS.md` previously covered only governance. The Karpathy 12 fill the missing single-task contract. They now live in `for-coders/AGENTS.md` as Layer 2.

2. **The 200-line adherence constraint.** Field-testing found model adherence to instruction files drops sharply past ~200 lines. This is now a hard constraint on `AGENTS.md` size.

3. **The evidentiary bar VPM still needs to clear.** The Karpathy rules carry a quantified result (reported error rate 41% → 11% → ~3% across 30+ repos, 6 weeks, 50+ tasks, blind-tested). VPM currently rests on N=1, three self-reported projects. To be credible, VPM needs an analogous quantified metric — e.g. the rate of "claimed-complete but value-line-failing" outcomes, before vs. after adopting VPM. This is an open gap, tracked as a contribution priority.

---

## What VPM deliberately does NOT adopt

The extended rule set includes a hard token-budget rule (4,000 tokens/task, 30,000/session). VPM does not adopt it:

- The numbers have no stated derivation — they violate VPM's own invariant that rules come from real retrospectives, not assertion.
- A fixed budget contradicts Karpathy Rule 2 (simplicity) and is brittle across models and task types.

Context budgeting is real and worth tuning per project, but VPM will not encode unvalidated magic numbers as law.

---

## Sources

- Karpathy's notes on LLM coding failure modes (2026, public commentary).
- Community distillation to 4 core rules (multica-ai / forrestchang CLAUDE.md repos).
- Extension to 12 rules with blind field-testing (attributed to @Mnilax).
- Local summary: `卡帕西_CLAUDE.md_编写原则_12条.md`.

*Numbers above are as reported by the sources and have not been independently reproduced by the VPM project. Treat them as directional.*
