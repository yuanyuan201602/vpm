# Case: K12 AI Curriculum

**Outcome: ✅ Converged**
**VPM pattern: Spec-first, independent review at every carrier change, written-to-disk as the acceptance gate.**

---

## The signals

```
npm run build           → passing    ✓
npm run test:content    → passing    ✓

independent-review:age-appropriateness  → pass    ✓
independent-review:identity-completeness → pass   ✓
written-to-disk:carrier-change          → pass    ✓
```

Engineering health line and product value line both passed. Project converged.

---

## What happened

The project produced an AI literacy curriculum for K12 students. Each unit required age-appropriate language, culturally complete representation, and narrative coherence across sections.

These are judgment calls. No grep can verify "age-appropriate." No type-checker can catch "culturally incomplete identity representation." The team recognized this early.

The decision: define the product value line before writing any curriculum content.

For each carrier change (topic shift, age group shift, section addition), the process required:
1. Write the spec update
2. Get independent review of the spec before producing content
3. Produce content to the new spec
4. Get independent review of the produced content
5. Written-to-disk verification: the artifact must exist as a file on disk before it counts

Step 5 was the key invariant. "I described the output" did not pass. "The file exists at the specified path with the specified content" passed. This eliminated an entire class of hallucinated completions.

---

## The alignment(s)

- **Rule 1**: PRD and acceptance criteria were written together. The acceptance criteria forced the team to answer "how do we verify age-appropriateness?" before any content was produced.
- **Rule 4 (Core before shell)**: Curriculum content was verified before any packaging, branding, or LMS integration was started.
- **Rule 5**: Age-appropriateness and identity completeness were classified as judgment calls from the start. Independent reviewers read actual content, not summaries.

---

## Source

Original retrospective: internal project log
Operator: solo developer with external reviewers
Stack: Claude Code + Codex, Markdown + Python
Date: 2026 Q1
