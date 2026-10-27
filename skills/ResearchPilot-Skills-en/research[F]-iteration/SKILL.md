---
name: research[F]-iteration
description: >
  Diagnose experiment logs and evaluation results, iterate configurations, implementation, or methods, and preserve failed and negative outcomes.
version: 2.0.0
license: LICENSE
---

> At startup, read the [execution and handoff contract](references/workflow-contract.md) for authorization, state, research, and reproducibility rules.


# Phase F: Code Iteration and Model Improvement

> **user_requirements.md priority**: All user constraints in `docs/user_requirements.md` **take precedence over any default instruction in this skill**. Read that file if present before generating any output.

## Command

```
/research[F]-iteration
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


---

## Phase F Flow Overview

```
F-1 Diagnostic analysis (read dev_log.md + results/ + idea_report.md, produce report)
F-2 Confirm backtrack scope (hyperparams only / model architecture / experiment design)
F-3 Update affected design documents when design semantics change
F-4 Code changes (log each meaningful change unit)
F-5 Validation (run experiments, append results to dev_log)
F-6 Decide whether to continue (loop F-1, or proceed to next phase)
```

Full step-by-step instructions: `references/phase-F.md`.

---

## Non-Negotiable Constraints

1. Historical log entries are append-only; update mutable progress/run summaries and log each meaningful change unit.
2. Must read `dev_log.md`, `results/` data, and `idea_report.md` before diagnosing — no guessing.
3. Confirm material method/evaluation changes once when outside existing authorization; fix ordinary errors directly and update affected design documents when semantics change.
4. If model architecture changes (Method), ablation design must be reviewed and updated in Part 3 if affected.
5. Rules in `references/template-flexibility.md` take precedence over any specific template instruction.

---

## On Phase Completion

When results are satisfactory:

```
Phase F complete. {N} iteration rounds completed. Final results recorded in dev_log.md.

→ Use `/research[G.0]-plan` to enter the Paper Planning phase.
```

---

## Reference Files

- Detailed flow: `references/phase-F.md`
- Template flexibility rules: `references/template-flexibility.md`
