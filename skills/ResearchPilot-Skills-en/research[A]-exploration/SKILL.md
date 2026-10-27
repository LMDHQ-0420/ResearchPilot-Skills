---
name: research[A]-exploration
description: >
  Explore research directions, verify literature, formulate research questions, and produce report Part 1; also download individual papers.
version: 2.0.0
license: LICENSE
---

> At startup, read the [execution and handoff contract](references/workflow-contract.md) for authorization, state, research, and reproducibility rules.


> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Read that file if present before generating any output to ensure compliance with confirmed user constraints.


# Phase A: Direction Exploration

Starting from a vague research interest, converge through multi-turn interaction
to a well-grounded research direction and a clear set of research questions (RQs).
Produces `docs/idea_report.md` Part 1, then moves to Phase B.

## Commands

| Command | Description |
|---------|-------------|
| `/research[A]-exploration research description` | Start direction exploration |
| `/research[A]-exploration --papers <pdf/name/description>` | Start with reference papers |
| `/research[A]-exploration download-paper description [--to "path"]` | Standalone paper download (independent of flow, usable at any time) |

---

## Trigger Logic

```
/research[A]-exploration download-paper → execute standalone download, skip flow

/research[A]-exploration (no content) → refuse and reply:
  "Please provide a research description, e.g.:
   /research[A]-exploration I want to improve battery SOH prediction —
   existing Transformer methods don't exploit local temporal features"

Otherwise → enter direction exploration flow
```

---

## Phase A Flow Overview

```
A-1 Parse input, collect requirements (write to user_requirements.md)
A-2 Search by question scope; check supporting/contradicting evidence and stop at adequate coverage
A-3 Show download list to user for confirmation
A-4 Execute downloads, report results
A-4.5 Ask whether user wants detailed per-paper introductions
A-5 Anchor problem domain, confirm research direction step by step
A-6 Refine and confirm RQs one by one (primary RQ + secondary RQs)
A-7 Compile idea_report.md Part 1
```

Full step-by-step instructions: `references/phase-A.md`.

---

## Confirmation Card

Show a concise confirmed-content card when decisions change, resuming, or handing off:

```
━━━━━━━━━━ Confirmed Content ━━━━━━━━━━
Research direction: {confirmed direction}
Primary RQ: {confirmed primary RQ}
Secondary RQs: {confirmed secondary RQs}
Direction constraints: {user constraints}
RQ constraints: {user constraints}
Reference papers: {user-specified papers}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Only output confirmed, non-empty fields. Omit empty or unconfirmed fields entirely.

---

## Paper Download

Full download logic (arXiv → OpenReview → abstract TXT fallback) is in
`references/phase-A.md`, Paper Download section.

---

## Non-Negotiable Constraints

1. Do not advance to Phase B without explicit user confirmation.
2. Never fabricate citations. All references must be verified via web_search;
   unverifiable entries get `[to verify]`.
3. Never hide uncertainty. Low-confidence content gets `⚠️ [low confidence: reason]`.
4. After `download-paper`, always output the full file path.
5. Record confirmed user constraints in user_requirements.md; respect direct user edits and current explicit instructions.
6. Rules in `references/template-flexibility.md` take precedence over any
   specific template instruction.
7. Read primary literature relevant to the current idea decision. Reuse prior reading records; add reading when key evidence is missing rather than rereading a fixed count.

---

## On Phase Completion

After Part 1 is compiled and confirmed:

```
Phase A complete. idea_report.md Part 1 has been generated.

→ Use `/research[B]-idea` to enter the Idea Deepening phase.
```

---

## Reference Files

- Detailed flow: `references/phase-A.md`
- Document format specs: `references/document-formats.md`
- idea_report.md blank template: `references/idea_report-template.md`
- Template flexibility rules: `references/template-flexibility.md`
- User requirements collection: `references/user-requirements-template.md`
