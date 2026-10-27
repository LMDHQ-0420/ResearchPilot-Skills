---
name: research[START]
description: >
  Detect research progress from artifact content, validation, and confirmations; use to resume a project or choose the next phase.
version: 2.0.0
license: LICENSE
---

> At startup, read the [execution and handoff contract](references/workflow-contract.md) for authorization, state, research, and reproducibility rules.


> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Read that file if present before generating any output to ensure compliance with confirmed user constraints.


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
  src/models/baseline/  # Baseline implementations (interface matches main model)
  notebooks/            # Visualization notebooks; paper figure/table generation
  data/                 # Datasets (gitignored)
  results/              # Experiment results (gitignored)
  logs/                 # Training logs (gitignored)
  README.md             # Environment setup and run commands
  requirements.txt      # Versioned dependencies; preserve the project lockfile
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/research[START]` | Detect current phase and show which skill to use |
| `/research[START] research description` | Suggest a Phase A command containing the description |
| `/research description` | Backward-compatible alias for `/research[START] description` |

---

## Phase Detection Logic

The router is read-only by default: do not create directories or repair state. Read current user intent, then compare docs/research_state.json against artifacts using the [execution and handoff contract](references/workflow-contract.md).

1. For valid state, check artifact SHA-256, completion evidence, applicable confirmation, and dependencies. Changed hashes require inspecting affected content rather than trusting complete.
2. If state is absent, malformed, unsupported, or inconsistent, preserve it and infer candidate status from the table below, reporting uncertainty. File, heading, and directory existence do not establish completion. Rebuilding or repairing state requires confirmation.
3. Current intent overrides linear ordering. Existing results may go to F, and existing manuscripts may go directly to writing/review without reconstructing all historical phases.

| Content evidence | Candidate phase/action |
|------------------|------------------------|
| No clear question, or Part 1 contains empty headings | A: direction and RQs |
| Substantive Part 1, but method missing or placeholder-only | B: method development |
| Clear method, but no testable protocol/resource plan | C: experiment design |
| Clear experiment protocol, but no implementation interfaces/data flow | D: implementation design |
| Adequate guide, but coding or necessary validation incomplete | E: coding and validation |
| Results need diagnosis, correction, or boundary analysis | F: iteration; weak metrics alone do not prove a method error |
| Writing requested, structure unclear | G.0: paper planning |
| Structure/materials available, a section needs writing/revision | Corresponding G.1–G.6 by user intent |
| Claims need verification, or manuscript/evidence changed since review | G.7: review/revalidation |
| Current-version review passed with no unresolved high-priority issues | Writing complete; revisit sections as needed |

Distinguish confirmed completion from inferred completion. A review passes only when bound to current manuscript, reference, and result versions with high-priority issues resolved. Report status, evidence, open items, and the recommended command. Ask together about critical ambiguous branches rather than guessing.

---

## Output Format

```
━━━━━━━━━━ ResearchPilot Phase Detection ━━━━━━━━━━
Current status: {one-line description of detected phase}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

→ Use `/{skill-name}` to continue.

{If a research description was provided: Suggested Phase A input —
use /research[A]-exploration {description} to start.}
```


---

## Standalone Download Command

Available at any time, regardless of phase state:

```
/research[A]-exploration download-paper paper description [--to "path"]
```

---
