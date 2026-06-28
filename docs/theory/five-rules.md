# The Five VPM Rules — Extended

Each rule has a failure case it prevents and an executable check that verifies compliance.

---

## Rule 1: PRD and acceptance criteria are one artifact, not two

They share a version number and change together. If you cannot write the product value line checks, the PRD is not finished.

**Failure it prevents**: The Chinese Identity Generator case. The PRD described cultural depth. The acceptance suite tested output production. These were never reconciled because they were treated as separate documents.

**Executable check**:
```bash
# PRD_version and ACCEPTANCE_version must match
PRD_VER=$(grep '^# .* v' docs/PRD_*.md | grep -o 'v[0-9.]*' | head -1)
ACC_VER=$(grep '^# .* v' docs/ACCEPTANCE_*.md | grep -o 'v[0-9.]*' | head -1)
[ "$PRD_VER" = "$ACC_VER" ] || echo "FAIL: version mismatch"
```

---

## Rule 2: Acceptance has two tiers. Only the second one is a gate.

- Engineering health line: does it run, build, pass smoke tests. Necessary. Not sufficient.
- Product value line: does it deliver what the PRD promised. This is the only thing that can stop the project.

**Failure it prevents**: Declaring completion when `sim:user` passes and `test:experience` has not been run. The engineering health line passing is never permission to ship.

**Executable check**: ACCEPTANCE.md must contain a section labeled `Product value line` with at least one check item.

---

## Rule 3: PRD changes are the most dangerous moment.

When the PRD changes: freeze the old direction (mark legacy), re-derive acceptance criteria at the new version, re-derive milestones. Never continue under the old acceptance standard.

**Failure it prevents**: Agent continues executing toward old PRD targets after the PRD has been updated. Acceptance checks still reference the old version. Work is "done" by old criteria that no longer reflect the product goal.

**Executable check**:
```bash
# No acceptance check file should reference a PRD version that no longer exists
CURRENT_PRD_VER=$(ls docs/PRD_*.md | grep -o 'v[0-9.]*' | sort -V | tail -1)
grep -r 'PRD_v' docs/ACCEPTANCE_*.md | grep -v "$CURRENT_PRD_VER" && echo "FAIL: stale PRD reference"
```

---

## Rule 4: Core before shell.

No packaging, desktop wrappers, sharing features, or branding until the product value line passes on the core. Every premature peripheral feels like progress and proves the wrong direction.

**Failure it prevents**: Spending a week on a polished desktop wrapper for a product whose core output fails the acceptance check. The wrapper work is not wrong — the sequencing is.

**Executable check**: ACCEPTANCE.md must have a "Core" milestone that precedes any "Shell" or "Polish" milestone, and the Core milestone must be marked complete before Shell work begins.

---

## Rule 5: Deterministic checks for deterministic facts. Independent review for judgment calls.

Banned words, build success, byte alignment — grep and run. Age-appropriateness, identity completeness, narrative coherence — independent reviewer reads the real artifact, not the producer's self-report.

**Failure it prevents**: Using a build check to verify "cultural depth." Using the producer's self-assessment to verify "age-appropriate." These are judgment calls. The producer cannot be the verifier.

**Executable check**: ACCEPTANCE.md checks must be labeled either `[deterministic]` or `[judgment]`. All `[judgment]` checks must name a reviewer role that is not "the agent" or "the producer."
