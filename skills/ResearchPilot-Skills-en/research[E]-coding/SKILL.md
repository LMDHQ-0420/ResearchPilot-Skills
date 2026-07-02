---
name: research[E]-coding
description: >
  ResearchPilot Research Assistant [Phase E]: Coding
version: 2.0.0
license: LICENSE
---

> **user_requirements.md priority**: All user constraints recorded in `docs/user_requirements.md` (direction preferences, implementation requirements, document format, etc.) **take precedence over any default instruction in this skill**. Always read that file before generating any output to ensure compliance with confirmed user constraints.


# Phase E: Coding

Implement code file by file according to `docs/implementation.md`, maintain the
development log, and conduct a proactive code review (runnable + logically correct)
when all files are complete.

**Prerequisite**: `docs/implementation.md` exists and the pre-coding checklist
(Phase D end) has been completed.

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
/research[E]-coding
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


---

## Phase E Flow Overview

```
E-0 Create README.md and notebooks/ directory
E-1 Create dev_log.md (with progress table and "How to Run" chapter)
E-2 Implement files in the order specified by implementation.md
    After each file: update dev_log.md + update README.md if needed + add notebook
    After each module: validate consistency with implementation.md
E-3 requirements.txt rules (library names only, no versions, no torch family)
E-4 Design issue found → pause and inform user, do not work around it
E-5 implementation.md error found → fix the document first, then fix the code
E-6 Post-file sync (README + "How to Run" chapter in dev_log.md)
E-7 Proactive code review after all files complete
E-8 Poor experiment results → backtrack through B/C/D (no code-only patches)
```

Full step-by-step instructions: `references/phase-E.md`.

---

## dev_log.md Rules

- Updated **in sync** with each completed file — no batch updates
- Has a fixed "How to Run" chapter at the bottom; every code change must
  automatically check whether this chapter needs updating
- `✅ Done` can only be marked after a file is written **and** runs without errors

---

## Non-Negotiable Constraints

1. requirements.txt must not contain torch, torchvision, or torchaudio.
2. dev_log.md must be updated with each file — no batch catch-up writes.
3. When design is found to be unworkable, confirm the backtracking scope with
   the user and re-walk the corresponding Phase B/C/D flow — never patch around
   it in code only.
4. After every code change, automatically judge whether the "How to Run" chapter
   in dev_log.md needs to be updated.
5. Rules in `references/template-flexibility.md` take precedence over any
   specific template instruction.

---

## On Phase Completion

After the code review passes:

```
Phase E complete. Code review passed — code is runnable and logically
consistent with the design.

→ Use `/research[F]-paper` to start paper writing.
```

---

## Reference Files

- Detailed flow: `references/phase-E.md`
- Template flexibility rules: `references/template-flexibility.md`
