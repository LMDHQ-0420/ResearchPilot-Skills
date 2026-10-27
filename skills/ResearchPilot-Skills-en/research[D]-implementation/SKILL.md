---
name: research[D]-implementation
description: >
  Turn an approved experiment plan into a file/function implementation guide, checking coverage, interfaces, and data flow in implementation.md.
version: 2.0.0
license: LICENSE
---

> At startup, read the [execution and handoff contract](references/workflow-contract.md) for authorization, state, research, and reproducibility rules.


> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Read that file if present before generating any output to ensure compliance with confirmed user constraints.


# Phase D: Implementation Design

Generate a function-level coding guide — precise to every function signature,
parameters, return values, and implementation logic — then validate and confirm
before coding begins. Produces `docs/implementation.md`, then moves to Phase E.

**Prerequisite**: `docs/idea_report.md` contains Part 3 (Phase C complete).

## Command

```
/research[D]-implementation
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


---

## Phase D Flow Overview

```
D-0 Ask whether to use a strong baseline (improve existing open-source project
    vs. build from scratch)

Path A (Strong Baseline):
  D-A1 Obtain open-source project (git clone or user clones)
  D-A2 Scan project structure, extract all classes/functions/dependencies
  D-A3 Collect coding constraints (framework, features to preserve, requirements)
  D-A4 Generate implementation.md (strong baseline format)

Path B (From Scratch):
  D-B1 Collect coding constraints (framework, special requirements)
  D-B2 Generate implementation.md (from-scratch format)

D-end1 Run implementation.md validation (coverage / consistency / completeness)
D-end2 Pre-coding checklist (env / device / datasets / run strategy / README location)
```

Full step-by-step instructions: `references/phase-D.md`.

---

## Validation Rules

After every generation or revision, run three checks:

1. **Experiment coverage**: Does every experiment in Part 3 have a supporting module/function?
2. **Logic consistency**: Are tensor shapes consistent across modules?
3. **Completeness**: Does every listed file have a corresponding implementation section?

Validation output format:
```
✅ Experiment coverage: {pass / missing: …}
✅ Logic consistency: {pass / issue found: …}
✅ Completeness: {pass / missing: …}
```

---

## Non-Negotiable Constraints

1. Do not advance to Phase E without explicit user confirmation.
2. Run validation immediately after generating implementation.md; fix issues
   before presenting to user.
3. requirements.txt must not contain torch, torchvision, or torchaudio.
4. Rules in `references/template-flexibility.md` take precedence over any
   specific template instruction.
5. The pre-coding checklist (D-end2) must be completed item by item before
   coding begins.

---

## On Phase Completion

After implementation.md and pre-coding checklist are both confirmed:

```
Phase D complete. implementation.md has been generated and validated.
Pre-coding checklist confirmed.

After implementation.md and pre-coding checklist are both confirmed:

```
Phase D complete. implementation.md has been generated and validated.

→ Use `/research[E]-coding` to start coding.
```
```

---

## Reference Files

- Detailed flow: `references/phase-D.md`
- Document format specs: `references/document-formats.md`
- Template flexibility rules: `references/template-flexibility.md`
