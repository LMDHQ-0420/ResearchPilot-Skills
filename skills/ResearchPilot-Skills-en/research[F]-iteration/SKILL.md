---
name: research[F]-iteration
description: >
  ResearchPilot Research Assistant [Phase F]: Code iteration
version: 2.0.0
license: LICENSE
---

# Phase F: Code Iteration and Model Improvement

> **user_requirements.md priority**: All user constraints in `docs/user_requirements.md` **take precedence over any default instruction in this skill**. Always read that file before generating any output.

## Workflow Overview & Outputs

ResearchPilot-Skills splits a complete academic research project into seven independent stage skills. The current skill is one link in that chain.

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
  idea_report.md        # Part 1 (Phase A) / Part 2 (Phase B) / Part 3 (Phase C)
  implementation.md     # Coding guide (Phase D)
  dev_log.md            # Dev log (append-only, never delete)
  user_requirements.md  # User constraints, collected by Claude
  papers/               # Downloaded PDFs or abstract TXTs
  manuscripts/          # Phase G paper drafts

code/
  src/models/{model}.py / baseline/
  src/data/ / src/train.py / src/evaluate.py / src/utils/
  scripts/              # nohup shell scripts
  configs/
  data/ / results/ / logs/
  README.md / requirements.txt
```

---

## Command

```
/research[F]-iteration
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


---

## Phase F Flow Overview

```
F-1 Diagnostic analysis (read dev_log.md + results/ + idea_report.md, produce report)
F-2 Confirm backtrack scope (hyperparams only / model architecture / experiment design)
F-3 Update design documents (documents first, then code — never skip)
F-4 Code changes (append iteration log entry after every file change)
F-5 Validation (run experiments, append results to dev_log)
F-6 Decide whether to continue (loop F-1, or proceed to next phase)
```

Full step-by-step instructions: `references/phase-F.md`.

---

## Non-Negotiable Constraints

1. **dev_log.md is append-only**: every code change must append a new log entry — never overwrite.
2. Must read `dev_log.md`, `results/` data, and `idea_report.md` before diagnosing — no guessing.
3. Scope must be confirmed by user; design documents updated before any code changes.
4. If model architecture changes (Method), ablation design must be reviewed and updated in Part 3 if affected.
5. Rules in `references/template-flexibility.md` take precedence over any specific template instruction.

---

## On Phase Completion

When results are satisfactory:

```
Phase F complete. {N} iteration rounds completed. Final results recorded in dev_log.md.

→ Use `/research[G]-paper` to enter the Paper Writing phase.
```

---

## Reference Files

- Detailed flow: `references/phase-F.md`
- Template flexibility rules: `references/template-flexibility.md`
