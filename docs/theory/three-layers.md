# The Three-Layer Model: Harness, Loop, VPM

## Why three layers?

A project fails at exactly one of three levels. Diagnosing which level failed determines the fix.

```
┌─────────────────────────────────────────────┐
│  VPM                                        │
│  Is the goal correct?                       │
│  Does the acceptance line point at value?   │
│                                             │
│  ┌───────────────────────────────────────┐  │
│  │  Loop Engineering                    │  │
│  │  Does the loop converge?             │  │
│  │  When does it stop?                  │  │
│  │                                      │  │
│  │  ┌────────────────────────────────┐  │  │
│  │  │  Harness Engineering          │  │  │
│  │  │  What environment does        │  │  │
│  │  │  the agent need to run?       │  │  │
│  │  └────────────────────────────────┘  │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

Each layer is necessary. None is sufficient alone.

---

## Layer 1: Harness Engineering

**Question**: What environment does the agent need to run?

Harness Engineering covers: tool availability, API keys, file system permissions, context injection, pre/post hooks, sub-agent wiring. A harness failure is an execution failure — the agent cannot do what it was asked to do because the environment is wrong.

**Signs of a harness failure:**
- The agent produces errors about missing tools or permissions
- Context injected at session start is absent or malformed
- Hooks fire but scripts cannot be found

**Fix**: Fix the environment. The goal may be correct. The loop may converge. The harness just needs repair.

---

## Layer 2: Loop Engineering

**Question**: Does the loop converge, and when does it stop?

Loop Engineering covers: convergence conditions, exit criteria, iteration limits, escalation triggers, state management between iterations. A loop failure means the agent runs but does not stop — or stops at the wrong place.

**Signs of a loop failure:**
- The agent keeps iterating past a clear completion point
- The loop stops too early and declares success before the work is done
- State from one iteration bleeds incorrectly into the next

**Fix**: Fix the convergence condition. The goal may be correct. The harness may be fine. The loop just needs a better stopping rule.

---

## Layer 3: VPM

**Question**: Is the goal correct? Does the acceptance line point at real value?

VPM covers: PRD alignment, acceptance criteria definition, milestone ordering, PRD change management. A VPM failure means the agent executed correctly, the loop converged correctly, and the result is still wrong.

**Signs of a VPM failure:**
- All engineering health checks pass; users are disappointed
- The acceptance suite tests a proxy metric, not the actual value
- The PRD changed mid-project; the agent kept targeting the old version
- Core is unfinished; peripheral features are complete

**Fix**: Fix the goal or the acceptance line. Harness and loop repairs will not help if the agent is pointed at the wrong target.

---

## The diagnostic question

Before fixing anything, ask: **at which layer did this fail?**

- If the agent couldn't run: harness
- If the agent ran but didn't converge: loop
- If the agent converged to the wrong thing: VPM

Most agent project failures that *feel* like execution failures are VPM failures. The code ran. The tests passed. The product missed.
