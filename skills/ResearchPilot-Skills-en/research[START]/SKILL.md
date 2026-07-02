---
name: research[START]
description: >
  ResearchPilot Research Assistant [Entry]: Entry router
version: 2.0.0
license: LICENSE
---

> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Always read that file before generating any output to ensure compliance with confirmed user constraints.


# ResearchPilot-Skills Entry Router

Automatically detects the current research phase and directs the user to the
appropriate stage skill.

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
| `/research[START]` | Detect current phase and show which skill to use |
| `/research[START] research description` | Same, and pass description to Phase A |
| `/research description` | Backward-compatible alias for `/research[START] description` |

---

## Phase Detection Logic

Check the `docs/` directory in this order:

```
docs/idea_report.md does not exist
  → Not started yet — go to Phase A

idea_report.md exists, does not contain "## Part 2"
  → Phase A in progress

idea_report.md contains "## Part 2", does not contain "## Part 3"
  → Phase B in progress

idea_report.md contains "## Part 3", docs/implementation.md does not exist
  → Phase C complete / Phase D not started

docs/implementation.md exists, docs/dev_log.md does not exist
  → Phase D complete / Phase E not started

docs/dev_log.md exists, docs/manuscripts/ does not exist
  → Phase E: Coding in progress

docs/manuscripts/ exists
  → Phase F: Paper writing in progress
```

---

## Output Format

```
━━━━━━━━━━ ResearchPilot Phase Detection ━━━━━━━━━━
Current status: {one-line description of detected phase}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

→ Use `/{skill-name}` to continue.

{If a research description was provided: Description passed to Phase A —
use /research[A]-exploration {description} to start.}
```

Phase-to-skill mapping:

| Phase | Use skill |
|-------|-----------|
| A: Direction Exploration (not started or in progress) | `/research[A]-exploration research description` |
| B: Idea Deepening in progress | `/research[B]-idea` |
| C complete, D not started | `/research[D]-implementation` |
| D complete, E not started | `/research[E]-coding` |
| E in progress | `/research[E]-coding` |
| F in progress (iteration) | `/research[F]-iteration` |
| G.0 complete, G.1+ in progress | `/research[G.1]-method` (or the current section) |
| G.7 review done | `/research[G.7]-review` |

---

## Standalone Download Command

Available at any time, regardless of phase state:

```
/research[A]-exploration download-paper paper description [--to "path"]
```

---

## Six-Stage Skill Overview

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