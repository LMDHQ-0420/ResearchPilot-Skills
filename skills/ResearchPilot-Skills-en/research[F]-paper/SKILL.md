---
name: research[F]-paper
description: >
  ResearchPilot academic research Phase F: Paper Writing. Use after Phase E coding and
  experiments are complete. Confirms paper structure, generates a draft, revises
  based on user annotations (each revision saved as a new version), and guides
  Python figure/table generation. Trigger: /research[F]-paper
version: 2.0.0
license: LICENSE
---

# Phase F: Paper Writing

Write the paper from all prior outputs (`idea_report.md`, `dev_log.md` experiment
results, `docs/papers/` literature). Every revision creates a new version file,
forming a traceable version chain.

**Prerequisite**: `docs/dev_log.md` exists (Phase E complete).

## Workflow Overview & Outputs

ResearchPilot-Skills splits a complete academic research project into six independent
stage skills. The current skill is one link in that chain.

### Six-Stage Chain

| Skill | Phase | Main Output |
|-------|-------|-------------|
| `/research[A]-exploration` | Direction Exploration | `docs/idea_report.md` Part 1 |
| `/research[B]-idea` | Idea Deepening | `docs/idea_report.md` Part 2 |
| `/research[C]-experiment` | Experiment Design | `docs/idea_report.md` Part 3 |
| `/research[D]-implementation` | Implementation Design | `docs/implementation.md` |
| `/research[E]-coding` | Coding | `code/` + `docs/dev_log.md` |
| `/research[F]-paper` | Paper Writing | `docs/manuscripts/v*.md` |

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
/research[F]-paper
```

---

## Phase F Flow Overview

```
F-1 Confirm paper structure (outline + writing rationale + figure/table plan + extras)
F-2 Generate paper draft (v1.0-initial-draft.md)
F-3 Revise based on user annotations (read blank > markers, copy to new version file)
F-4 Guide Python figure/table generation (only after user approval)
F-5 Finalize — report final version filename and figure/table list
```

Full step-by-step instructions: `references/phase-F.md`.

---

## Version Naming

```
docs/manuscripts/v{major}.{minor}-{summary (≤15 chars)}.md
```

- Major version +1: structural changes (add/remove sections, rewrite whole chapter)
- Minor version +1: local changes (polish, add paragraphs, fix references)
- Every revision creates a new file; old versions are never overwritten

---

## Paper Format (English version)

- **Title**: English, followed by a one-line subtitle if needed
- **Section headings**: English (Introduction / Related Works / Method /
  Experiments / Conclusion)
- **Everything else**: English throughout
- Maximum two heading levels (no `####`)
- Each chapter/section opening has a writing-rationale annotation (`>`)
- One blank `>` after each paragraph, figure caption, and table caption for
  user annotations
- References in MLA format; each entry annotated with "Main contribution" and
  "Reason for citation"

---

## Non-Negotiable Constraints

1. Must confirm paper structure (F-1) before writing any body text.
2. Every revision must be copied to a new version file — never overwrite.
3. Python figure/table generation (image.ipynb / table.ipynb) only after
   explicit user approval.
4. All references must be real (verified via web_search or from `docs/papers/`);
   never fabricate citations.
5. Rules in `references/template-flexibility.md` take precedence over any
   specific template instruction.

---

## On Phase Completion

After the paper is finalized and figures/tables are generated:

```
Phase F complete. Paper finalized. Full workflow done.

Final version: docs/manuscripts/{latest version filename}
Figure files: notebooks/image.ipynb, notebooks/table.ipynb (if generated)
```

---

## Reference Files

- Detailed flow: `references/phase-F.md`
- Template flexibility rules: `references/template-flexibility.md`
