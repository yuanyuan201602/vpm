# Case: Lite DeepLearning Studio

**Outcome: ✅ Converged**
**VPM pattern: Clear byte-level invariant + subprocess ground-truth verification eliminated the entire "it works on my machine" failure class.**

---

## The signals

```
npm run build              → passing    ✓
npm run test:unit          → passing    ✓

invariant:app-export-alignment → pass  ✓
subprocess:ground-truth        → pass  ✓
```

---

## What happened

The project was a lightweight deep learning model studio with an export function. The core invariant was: **the model displayed in the app and the model written to the export file must be byte-identical.**

This is a deterministic check. Byte equality is verifiable with a hash. There is no judgment involved.

The team encoded this as the primary acceptance gate from day one:

```bash
# check_alignment.sh
APP_HASH=$(python get_app_model_hash.py)
EXPORT_HASH=$(sha256sum exported_model.bin | cut -d' ' -f1)
[ "$APP_HASH" = "$EXPORT_HASH" ] && echo "PASS" || echo "FAIL: app/export mismatch"
```

This script ran as the PreToolUse gate on every agent action that touched model state. The agent could not proceed past any model-modifying step without the invariant passing.

The second key decision: use subprocess ground-truth verification. Rather than asking the agent "did the export succeed?", the verification script actually loaded the exported file in a subprocess and ran a forward pass. The result had to match the expected output to a numeric tolerance.

Self-report was explicitly banned as evidence. The agent's confirmation that the export "looked correct" was not accepted. The subprocess result was the only valid signal.

---

## The alignment(s)

- **Rule 2**: The app/export byte-alignment check was the product value line. Build success and unit tests were engineering health. The project did not declare completion until the byte-alignment check passed.
- **Rule 5**: Byte alignment is a deterministic fact. grep and run. The subprocess hash check was the correct verification method. No human judgment required — which also means no human subjectivity could pass a broken export.

---

## Source

Original retrospective: internal project log
Operator: solo developer
Stack: Claude Code + Codex, Python + TypeScript
Date: 2026 Q1
