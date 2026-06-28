# Verified Project Management (VPM)

**A goal-alignment framework for AI agent projects.**

VPM sits above Harness Engineering and Loop Engineering. While those disciplines ask *"how does the agent run?"*, VPM asks *"is the agent running toward the right target — and will it know when it has arrived?"*

---

## The problem in one data point

A real project. Same operator, same Claude + Codex stack:

```
npm test          → 54 tests passing   ✓
npm run typecheck → passing            ✓
npm run build     → passing            ✓
npm run sim:user  → 12/12              ✓

npm run test:experience → 0/8          ✗
```

Everything green. Product completely off target.

The engineering health line was passing the whole time. The product value line — the only line that actually asked *"did we build what the PRD said?"* — was failing, and nobody had given it the authority to stop the project.

This is not an execution failure. The agent was executing perfectly. It was executing toward the wrong target.

---

## What VPM adds

Three disciplines, nested:

```
┌─────────────────────────────────────────────┐
│  Verified Project Management (VPM)          │
│  "Is the target correct? Is it still        │
│   correct? Does the acceptance line         │
│   point at real value?"                     │
│                                             │
│  ┌───────────────────────────────────────┐  │
│  │  Loop Engineering                    │  │
│  │  "Does the loop converge?            │  │
│  │   When does it stop?"                │  │
│  │                                      │  │
│  │  ┌────────────────────────────────┐  │  │
│  │  │  Harness Engineering          │  │  │
│  │  │  "What environment does       │  │  │
│  │  │   the agent need to run?"     │  │  │
│  │  └────────────────────────────────┘  │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

VPM does not replace the other two. It governs the target they are running toward.

---

## The five rules

**1. PRD and acceptance criteria are one artifact, not two.**
They share a version number and change together. If you cannot write the product value line checks, the PRD is not finished.

**2. Acceptance has two tiers. Only the second one is a gate.**
- Engineering health line: does it run, build, pass smoke tests. Necessary. Not sufficient.
- Product value line: does it deliver what the PRD promised. This is the only thing that can stop the project.

**3. PRD changes are the most dangerous moment.**
When the PRD changes: freeze the old direction (mark legacy), re-derive acceptance criteria at the new version, re-derive milestones. Never continue under the old acceptance standard.

**4. Core before shell.**
No packaging, desktop wrappers, sharing features, or branding until the product value line passes on the core. Every premature peripheral feels like progress and proves the wrong direction.

**5. Deterministic checks for deterministic facts. Independent review for judgment calls.**
Banned words, build success, byte alignment — grep and run. Age-appropriateness, identity completeness, narrative coherence — independent reviewer reads the real artifact, not the producer's self-report.

---

## Install (Claude Code + Codex)

```bash
git clone https://github.com/YOUR_USERNAME/vpm.git
cd vpm
bash for-coders/install.sh
```

Then in Claude Code:
```
/plugin install superpowers@claude-plugins-official
```

Start every new project with:
```
/start-project
```

---

## Real cases

All VPM rules are derived from real project retrospectives. No rule exists without a corresponding failure or success case.

| Case | Outcome | Key lesson |
|------|---------|------------|
| [Chinese Identity Generator](../cases/dongfang-namecard/) | ❌ Did not converge | Engineering health line green, product value line never enforced |
| [K12 AI Curriculum](../cases/k12-curriculum/) | ✅ Converged | Spec-first, independent review, written-to-disk — at every carrier change |
| [Lite DeepLearning Studio](../cases/lite-dl-studio/) | ✅ Converged | Clear invariant (app ↔ export byte-alignment) + subprocess ground-truth verification |

---

## Contribute

VPM improves through real cases. The most valuable contribution is a project retrospective showing where the acceptance line was (or wasn't) aligned with the real target.

See [CONTRIBUTING.md](../CONTRIBUTING.md) and the [case template](../cases/TEMPLATE.md).

---

## Chinese version

[README_ZH.md](framework-zh.md)

---

## Relationship to other frameworks

| Framework | Asks | Scope |
|-----------|------|-------|
| Harness Engineering | What environment does the agent need? | Single agent, single task |
| Loop Engineering | How does the loop converge and stop? | Single loop, defined goal |
| **VPM** | **Is the goal correct? Does acceptance point at real value?** | **Full project lifecycle, goal drift, PRD versioning** |

---

## Relationship to behavioral rule sets (Karpathy 12)

VPM does **not** replace single-task behavioral contracts like the Karpathy CLAUDE.md rules — it sits on top of them.

Those rules make each unit of agent work safe: read context before writing, fail loud, test intent not behavior, make surgical changes. They are necessary. But an agent can follow all of them perfectly and still build the wrong product — every task succeeds while the project drifts off target. That gap is what VPM closes.

VPM's install kit ships these rules as the **behavior layer** of `for-coders/AGENTS.md`, beneath its own **governance layer**. See [docs/related-work.md](related-work.md) for the full layer mapping, the rules VPM borrows, and the one it deliberately rejects.

---

## Status

`v0.1` — derived from three projects, one operator. Needs validation across more projects, tools, and domains. If you have used agent tools on a complex project and hit goal drift, your retrospective is the most valuable thing you can contribute.

---

*VPM is itself developed under VPM rules. See [docs/PRD_v0.1.md](PRD_v0.1.md) and [docs/ACCEPTANCE_v0.1.md](ACCEPTANCE_v0.1.md).*
