# Case: Lite DeepLearning Studio

**Outcome: ✅ Converged**
**VPM pattern: One clear, deterministic invariant (in-app model ↔ exported bundle must be byte-aligned) + subprocess ground-truth verification. The acceptance signal was a fact, not an opinion — so it could not be faked.**

---

## The signals

```
122 tests passing       ✓
ruff (lint) clean       ✓
subprocess: exported predict.py / run.py actually runs and predicts   ✓
```

---

## What happened

The project is a K12 AI competition workbench: students complete an end-to-end AI project in the browser with nothing to install. The flow is locked to four ordered steps — **prepare data → train model → test → export materials** — with step N+1 greyed out until step N is done.

Training happens locally in sklearn; the export is a zip containing a runnable Python pipeline plus a deployment layer for the classroom hardware and the competition submission docs. By v0.7.0 it covered text, image, audio, QA, sensor, OCR, and a trainable object detector — 37 Python files, 122 passing tests.

The core decision that made it converge was naming a single hard invariant early:

> **The model running inside the app and the model written into the export must be byte-aligned.**

This is a deterministic fact. If the feature-extraction logic in `app/ml/` changes, the corresponding Python template string in `template_service.py` must change with it, or the exported model diverges from the in-app one. The team captured this per capability as an explicit invariant table (the joblib storage keys and feature pipeline for each of text/image/audio/QA/sensor/detector).

The verification method was the key: rather than asking the agent "did the export work?", the tests **run the exported `predict.py` / `run.py` in a subprocess** and check the real output (`test_generation_services.py`). A synthetic-data fallback guarantees that even an export with no labels can retrain and run. Self-report was never the evidence; the subprocess result was.

---

## The alignment(s)

- **Rule 5 (deterministic checks for deterministic facts):** byte alignment between app and export is not a judgment call. It is verified by actually running the exported code in a subprocess and comparing real output — not by the agent asserting it looks correct.
- **Rule 2:** unit tests and lint were the engineering health line; the byte-aligned, actually-runnable export was the product value line. The project's value claim ("students get a bundle that really runs") was the thing tested directly.

---

## Source

Original retrospective: the operator's own project log, dated 2026-06-21, on v0.7.0 (2026-06-14).
Operator: solo developer with Claude + Codex, for a school K12 AI program.
Stack: FastAPI + sklearn + ONNX (MobileNetV2 / SSD), vanilla JS front end.

---

*The lesson is not "write more tests." It is: when the core promise can be stated as a deterministic invariant, verify it by running the real artifact in a subprocess — so neither human optimism nor agent self-report can pass a broken export.*
