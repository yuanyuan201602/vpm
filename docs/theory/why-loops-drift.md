# Why Loops Drift: Goal Misalignment in AI Agent Projects

*Draft — M2 artifact*

---

## The observation

AI agent loops can pass every engineering check and still produce the wrong product. This is not an exotic failure mode. It is the default failure mode.

The Chinese Identity Generator passed 54 tests, a full type check, a build, and 12/12 simulated user sessions. It failed to produce a Chinese identity card.

The failure was not in the execution. The failure was in what the loop was aimed at.

---

## Why this happens

An agent loop is a convergence machine. Given a goal, a set of tools, and an environment, it iterates until some stopping condition is met. The stopping condition is the acceptance line.

If the acceptance line is pointed at the wrong thing, the loop converges to the wrong thing. It does so reliably, efficiently, and without any indication that something is wrong — because from the loop's perspective, nothing is wrong. It hit the target.

Three mechanisms cause the acceptance line to point at the wrong thing:

**1. Proxy capture.** The acceptance line tests something measurable instead of something meaningful. "Output was produced" is measurable. "Output is a high-quality Chinese cultural identity card" requires judgment. When only measurable things are tested, the loop optimizes for measurability.

**2. PRD drift.** The PRD changes mid-project. The acceptance line is not updated. The loop continues targeting the old version. Both the producer and the agent believe work is on track because both are checking against a document that no longer describes the goal.

**3. Milestone inversion.** Peripheral work (packaging, UI polish, sharing features) is completed before core value is verified. Each peripheral completion produces a green signal. The green signals accumulate. The core is never verified. The loop is declared convergent on the basis of peripheral completions.

---

## Why the engineering health line is not enough

The engineering health line (build, tests, lint, type check) measures whether the system is executable. It does not measure whether the system is valuable.

A system that runs perfectly and produces worthless output passes every engineering health check. The engineering health line cannot distinguish these two outcomes because it does not ask about value. It asks about executability.

This is not a flaw in engineering health checks. It is their correct and intended scope. The flaw is in treating them as sufficient acceptance criteria.

---

## The fix

The fix is not to make engineering health checks more comprehensive. It is to add a second tier of checks that ask about value directly.

This requires:
1. Writing the product value checks at the same time as the PRD — before implementation begins
2. Giving the product value checks authority to stop the project that engineering health checks do not have
3. Using independent review for value judgments, because the producer cannot verify their own value claims

VPM formalizes this as the two-tier acceptance model (Rule 2) and the independent review requirement (Rule 5).

---

## What "verified" means

A project is verified when:
- The product value line passes (not just the engineering health line)
- The verification was performed by someone other than the producer (for judgment calls)
- The acceptance criteria were written before implementation, not after

Everything else is a hypothesis. A well-tested hypothesis, perhaps — but still a hypothesis about whether the thing works, not evidence that it does.

---

*This document is a working draft. It will be expanded as more cases are analyzed.*
