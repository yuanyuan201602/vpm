# VPM Glossary

| Term | Definition |
|------|------------|
| Engineering health line | Does it run / build / pass smoke tests. Necessary condition. Not a completion criterion. |
| Product value line | Does it deliver what the PRD promised. The only gate that can stop the project. |
| Goal drift | The failure mode where an agent silently shifts its target during execution. The engineering health line stays green; the product value line was never enforced. |
| Freeze-old | The mandatory action when a PRD changes: mark all old schemas/artifacts as `legacy` before continuing under the new version. |
| Acceptance lock | PRD and acceptance criteria share a version number and are bumped together. |
| Independent review | Verification performed by someone other than the producer. Required for judgment calls (age-appropriateness, narrative coherence, identity completeness). Banned for deterministic checks (build success, banned-word scan, byte alignment). |
| Harness Engineering | Discipline that asks: what environment does the agent need to run? |
| Loop Engineering | Discipline that asks: how does the loop converge, and when does it stop? |
| VPM | Verified Project Management. The outer governance layer that asks: is the goal correct, and does the acceptance line point at real value? |
