---
name: research[C]-experiment
description: >
  ResearchPilot Research Assistant [Phase C]: Experiment design
version: 2.0.0
license: LICENSE
---

> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Always read that file before generating any output to ensure compliance with confirmed user constraints.


# Phase C: Experiment Design

Read baseline papers and code, synthesize field experiment conventions, design
main/ablation/additional experiments, and append `docs/idea_report.md` Part 3.
Then move to Phase D.

**Prerequisite**: `docs/idea_report.md` contains Part 2 (Phase B complete).

**Design principle**: The sole purpose of every experiment is to rigorously
prove the idea's effectiveness. Resource constraints are not design inputs —
only a post-design estimate is provided.

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
/research[C]-experiment
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


---

## Phase C Flow Overview

```
C-1 Read baseline papers and code (show reading plan, wait for user confirmation)
C-2 Search field experiment conventions (recent 3-year papers in same domain)
C-3 Verify data and code availability
C-4 Propose experiment outline, confirm with user (skeleton first, then details)
C-5 Generate idea_report.md Part 3 full content
C-6 Provide resource estimate (reference only, appended to Part 3)
C-7 Ask user whether to proceed to Phase D
C-8 Iterative refinement (loop until user confirms)
```

Full step-by-step instructions: `references/phase-C.md`.

---

## Non-Negotiable Constraints

1. Do not advance to Phase D without explicit user confirmation.
2. Must show the experiment outline (C-4) and get user confirmation before
   writing the full Part 3 content.
3. Do not collect GPU/training-time resource constraints before design — only
   provide a post-design estimate.
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

After Part 3 is confirmed:

```
Phase C complete. idea_report.md Part 3 has been generated.

→ Use `/research[D]-implementation` to enter the Implementation Design phase.
```
```

---

## Reference Files

- Detailed flow: `references/phase-C.md`
- Document format specs: `references/document-formats.md`
- Template flexibility rules: `references/template-flexibility.md`
