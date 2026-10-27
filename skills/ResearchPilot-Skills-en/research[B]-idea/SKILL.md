---
name: research[B]-idea
description: >
  Develop research questions into a technical approach with a pipeline, rationale, and testable hypotheses; write or revise report Part 2.
version: 2.0.0
license: LICENSE
---

> At startup, read the [execution and handoff contract](references/workflow-contract.md) for authorization, state, research, and reproducibility rules.


> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Read that file if present before generating any output to ensure compliance with confirmed user constraints.


# Phase B: Idea Deepening

Starting from a confirmed research direction and RQs, deepen the "research
question" into an "implementable method" through three layers of confirmation.
Produces `docs/idea_report.md` Part 2, then moves to Phase C.

**Prerequisite**: `docs/idea_report.md` exists and contains Part 1 (Phase A complete).

## Command

```
/research[B]-idea
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


---

## Phase B Flow Overview

```
B-0 Compile Part 1 (directly from Phase A confirmed content — no regeneration)
B-1 Confirm technical framework (Layer 1)
B-2 Confirm detailed pipeline (Layer 2 — plain language, step-by-step)
    → Write Part 2: Related Works + Method
B-3 Verify cited content (locate supporting sentences in PDFs)
B-4 Polish Introduction (Layer 3)
B-5 Ask user whether to proceed to Phase C
```

Full step-by-step instructions: `references/phase-B.md`.

---

## Confirmation Card

Show a concise confirmed-content card when decisions change, resuming, or handing off:

```
━━━━━━━━━━ Confirmed Content ━━━━━━━━━━
Research direction: {confirmed}
Primary RQ: {confirmed}
Secondary RQs: {confirmed}
Direction constraints: {user constraints}
RQ constraints: {user constraints}
Reference papers: {user-specified}
Technical framework: {confirmed framework, one sentence}
Pipeline: {confirmed pipeline, one sentence}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Only output confirmed, non-empty fields. Omit empty or unconfirmed fields entirely.

---

## Non-Negotiable Constraints

1. Do not advance to Phase C without explicit user confirmation.
2. Never fabricate citations. Unverifiable content gets `⚠️ [low confidence: reason]`
   and is logged in the pending-verification list.
3. Before writing or revising any idea, read existing literature in
   `docs/papers/` extensively (see `references/phase-B.md`, Literature Reading Principle).
4. The pipeline output must use plain language — "Step 1…Step 2…" — not formulas.
5. Rules in `references/template-flexibility.md` take precedence over any
   specific template instruction.

---

## On Phase Completion

After Part 2 is fully confirmed:

```
Phase B complete. idea_report.md Part 2 has been generated.

→ Use `/research[C]-experiment` to enter the Experiment Design phase.
```

---

## Reference Files

- Detailed flow: `references/phase-B.md`
- Document format specs: `references/document-formats.md`
- Template flexibility rules: `references/template-flexibility.md`
