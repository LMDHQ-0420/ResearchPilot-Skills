---
name: research[C]-experiment
description: >
  Design main, ablation, and boundary experiments from hypotheses and baseline papers/code; produce an executable, budget-aware report Part 3.
version: 2.0.0
license: LICENSE
---

> At startup, read the [execution and handoff contract](references/workflow-contract.md) for authorization, state, research, and reproducibility rules.


> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Read that file if present before generating any output to ensure compliance with confirmed user constraints.


# Phase C: Experiment Design

Read baseline papers and code, synthesize field experiment conventions, design
main/ablation/additional experiments, and append `docs/idea_report.md` Part 3.
Then move to Phase D.

**Prerequisite**: Part 2 has substantive method content and applicable confirmation evidence; a heading alone does not establish Phase B completion.

**Design principle**: Test falsifiable hypotheses, including supporting, contradicting, and inconclusive outcomes. Account for resources before design and provide both full evidence and executable core plans with explicit conclusion boundaries.

## Command

```
/research[C]-experiment
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


---

## Phase C Flow Overview

```
C-1 Read known constraints and resources, then relevant baseline papers and code
C-2 Search field experiment conventions (recent 3-year papers in same domain)
C-3 Verify data and code availability
C-4 Propose experiment outline, confirm with user (skeleton first, then details)
C-5 Generate idea_report.md Part 3 full content
C-6 Estimate runtime costs; check core-plan feasibility and conclusion boundaries
C-7 Check completion evidence, then continue if authorized or suggest Phase D
C-8 Refine within scope; consolidate material unresolved choices
```

Full step-by-step instructions: `references/phase-C.md`.

---

## Non-Negotiable Constraints

1. Phase D requires applicable authorization; do not repeat confirmation when continuous work was already authorized.
2. Must show the experiment outline (C-4) and get user confirmation before
   writing the full Part 3 content.
3. Reuse or obtain hardware, time, and budget constraints before design; disclose untested conclusions in reduced plans.
4. Every model in evaluation tables must be explained individually: difference
   from the proposed method, reason for inclusion, source paper.
5. Never fabricate citations. Unverifiable content gets `⚠️ [low confidence: reason]`.
6. Rules in `references/template-flexibility.md` take precedence over any
   specific template instruction.

---

## On Phase Completion

After Part 3 is confirmed:

```
Phase C complete. idea_report.md Part 3 has been generated.

→ Use `/research[D]-implementation` to enter the Implementation Design phase.
```

---

## Reference Files

- Detailed flow: `references/phase-C.md`
- Document format specs: `references/document-formats.md`
- Template flexibility rules: `references/template-flexibility.md`
