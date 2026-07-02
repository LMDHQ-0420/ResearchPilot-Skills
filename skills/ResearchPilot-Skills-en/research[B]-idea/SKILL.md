---
name: research[B]-idea
description: >
  ResearchPilot Research Assistant [Phase B]: Idea deepening
version: 2.0.0
license: LICENSE
---

> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Always read that file before generating any output to ensure compliance with confirmed user constraints.


# Phase B: Idea Deepening

Starting from a confirmed research direction and RQs, deepen the "research
question" into an "implementable method" through three layers of confirmation.
Produces `docs/idea_report.md` Part 2, then moves to Phase C.

**Prerequisite**: `docs/idea_report.md` exists and contains Part 1 (Phase A complete).

## Workflow Overview & Outputs

ResearchPilot-Skills splits a complete academic research project into seven independent
stage skills. The current skill is one link in that chain.

### Seven-Stage Chain

| Skill | Phase | Main Output |
|-------|-------|-------------|
| `/research[A]-exploration` | Direction Exploration | `docs/idea_report.md` Part 1 |
| `/research[B]-idea` | Idea Deepening | `docs/idea_report.md` Part 2 |
| `/research[C]-experiment` | Experiment Design | `docs/idea_report.md` Part 3 |
| `/research[D]-implementation` | Implementation Design | `docs/implementation.md` |
| `/research[E]-coding` | Coding | `code/` + `docs/dev_log.md` |
| `/research[F]-iteration` | Code Iteration | `dev_log.md` iteration records |
| `/research[G.0]-plan` | Paper Planning | manuscript architecture + `notebooks/figures.ipynb` |
| `/research[G.1]-method` | Method | manuscript Method section |
| `/research[G.2]-experiments` | Experiments | manuscript Experiments section |
| `/research[G.3]-abstract` | Abstract | manuscript Abstract |
| `/research[G.4]-introduction` | Introduction | manuscript Introduction |
| `/research[G.5]-related` | Related Works | manuscript Related Works |
| `/research[G.6]-conclusion` | Conclusion + References | manuscript Conclusion |
| `/research[G.7]-review` | Full-paper Review | review report |

### Project Directory Structure

```
docs/
  idea_report.md        # Research report in three parts:
                        #   Part 1: Motivation, RQs, Key Works  (Phase A)
                        #   Part 2: Introduction, Related Works, Method  (Phase B)
                        #   Part 3: Datasets, Experiment Design, Resource Estimate  (Phase C)
  implementation.md     # Coding guide: file- and function-level implementation plan  (Phase D)
  dev_log.md            # Dev log: progress, decisions, "How to Run" section  (Phase E)
  user_requirements.md  # User constraints: collected and maintained by Claude
  papers/               # Downloaded paper PDFs or abstract TXTs
  manuscripts/          # Paper drafts, each revision archived separately
                        #   (e.g. v1.0-initial-draft.md, v1.1-revision.md)

code/
  src/                  # Core model and training code
  scripts/              # Run scripts (train.sh, evaluate.sh, ablation.sh)
  configs/              # Hyperparameter config files
  baselines/            # Baseline model implementations
  notebooks/            # Visualization notebooks; paper figure/table generation
  data/                 # Datasets (gitignored)
  results/              # Experiment results (gitignored)
  logs/                 # Training logs (gitignored)
  README.md             # Environment setup and run commands
  requirements.txt      # Dependencies (library names only, no torch family)
```

---

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

Every output in this phase begins with a confirmed-content card:

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

After Part 2 is fully confirmed:

```
Phase B complete. idea_report.md Part 2 has been generated.

→ Use `/research[C]-experiment` to enter the Experiment Design phase.
```
```

---

## Reference Files

- Detailed flow: `references/phase-B.md`
- Document format specs: `references/document-formats.md`
- Template flexibility rules: `references/template-flexibility.md`
