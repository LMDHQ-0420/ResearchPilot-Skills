---
name: research[A]-exploration
description: >
  ResearchPilot Research Assistant [Phase A]: Direction exploration
version: 2.0.0
license: LICENSE
---

> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Always read that file before generating any output to ensure compliance with confirmed user constraints.


# Phase A: Direction Exploration

Starting from a vague research interest, converge through multi-turn interaction
to a well-grounded research direction and a clear set of research questions (RQs).
Produces `docs/idea_report.md` Part 1, then moves to Phase B.

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
A-2 Initial literature search (≥15 papers, ≥2 per gap, up to 3 rounds)
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

Every output in this phase begins with a confirmed-content card (when content exists):

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
5. `user_requirements.md` is maintained by Claude through conversation only.
6. Rules in `references/template-flexibility.md` take precedence over any
   specific template instruction.
7. Before every idea generation or adjustment, read existing literature
   extensively (see `references/phase-A.md`, Literature Reading Principle).

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
