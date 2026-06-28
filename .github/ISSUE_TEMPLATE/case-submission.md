---
name: Case submission
about: Submit a real project retrospective to improve VPM
title: "[case] "
labels: case
assignees: ''
---

## Project summary

What was this project trying to build?

## Outcome

- [ ] Converged (product matched the PRD)
- [ ] Did not converge (engineering looked healthy, product missed)
- [ ] Partial

## The signals

```
[engineering health checks] → passing / failing
[product value checks]      → passing / failing
```

## VPM pattern

Which failure (or success) pattern best describes this case?

- [ ] Goal misalignment: implementation targeted the wrong version of the PRD
- [ ] Acceptance misalignment: the acceptance suite tested a proxy metric
- [ ] Milestone inversion: peripheral work completed before core was verified
- [ ] PRD change not frozen: work continued under old acceptance standard
- [ ] Self-report accepted: producer's self-check used as acceptance evidence
- [ ] Success case: VPM rules were followed; project converged

## Brief retrospective

2–4 sentences. What happened? Where did the alignment fail or succeed?

## Would you like to submit a full case?

If yes, copy [cases/TEMPLATE.md](../../cases/TEMPLATE.md) and fill it in. A PR to `cases/[your-project-name]/README.md` is the preferred format.
