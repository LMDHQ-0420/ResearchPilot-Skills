# ResearchPilot-Skills Workflow Guide

> This document describes the detailed flow, constraints, and user responsibilities for each skill phase. For overview and installation, see [README](README.en.md).

At the end of each phase, the AI gives the next command. No phase is skipped without your confirmation.

---

## Global Constraints

| # | Constraint |
|---|------------|
| 1 | User constraints in `docs/user_requirements.md` take precedence over all default skill instructions |
| 2 | Phase transitions must be initiated by the AI asking the user — never automatic |
| 3 | Never fabricate citations; unverifiable entries get `[to verify]` |
| 4 | Low-confidence content gets `⚠️ [low confidence: reason]`; uncertainty is never hidden |
| 5 | Every code change requires updating the corresponding design document first |

---

## Phase A — `/research[A]-exploration` Direction Exploration

| Item | Detail |
|------|--------|
| **Command** | `/research[A]-exploration research direction` |
| **Prerequisite** | None (start here for a new project) |
| **Main output** | `docs/idea_report.md` Part 1, `docs/papers/`, `docs/user_requirements.md` Phase A section |
| **Next phase** | `/research[B]-idea` |

### Flow Steps

| Step | What | Based on | Output | Constraint |
|------|------|----------|--------|------------|
| A-1 | Parse input, collect requirements | User input | Write to `user_requirements.md` | Ask all questions in one message |
| A-2 | Initial literature search | Top venues (NeurIPS/ICML/ICLR/CVPR/ACL etc.) | Recommended download list | ≥15 papers; ≥2 per gap; up to 3 supplementary rounds |
| A-3 | Confirm download list | Search results | Batch download after confirmation | Do not download without confirmation |
| A-4 | Execute downloads | arXiv → OpenReview → abstract TXT | `docs/papers/{title}.pdf` or `.txt` | Output full file path after each download |
| A-4.5 | Ask whether to introduce each paper | User preference | Recorded in `user_requirements.md` | All downloaded papers included regardless |
| A-5 | Confirm research direction | Downloaded papers | Write to `user_requirements.md` | Focus on 1–2 candidates at a time |
| A-6 | Three-layer RQ refinement | Literature gaps | Write to `user_requirements.md`, refresh card | One RQ candidate at a time with gap/novelty/answerability |
| A-7 | Assemble Part 1, submit for review | Confirmed direction + RQs + necessity argument | `idea_report.md` Part 1 | Display full text; guide to B only after confirmation |

### Three-Layer RQ Structure

| Layer | Name | Answers | Corresponding Experiments |
|-------|------|---------|--------------------------|
| RQ1 | Core Question | What big problem am I solving | Main experiment |
| RQ2 | Mechanism Question | Why do existing methods fall short | Ablation experiments |
| RQ3 | Boundary Question (optional) | Under what conditions does the method work | Additional experiments |

### Confirmation Card (Phases A/B)

```
━━━━━━━━━━ Confirmed Content ━━━━━━━━━━
Research direction: {confirmed}
Primary RQ: {confirmed}
Secondary RQs: {confirmed}
Direction constraints: {user constraints}
RQ constraints: {user constraints}
Reference papers: {user-specified}
Technical framework: {Phase B only}
Pipeline: {Phase B only}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Hard Constraints

| # | Constraint |
|---|------------|
| 1 | Do not proceed to Phase B without explicit confirmation |
| 2 | Download list must be confirmed before executing |
| 3 | Every RQ must be backed by a literature gap with citations |
| 4 | Output full file path after every download |
| 5 | Display full Part 1 for review; guide to B only after confirmation |

---

## Phase B — `/research[B]-idea` Idea Deepening

| Item | Detail |
|------|--------|
| **Command** | `/research[B]-idea` |
| **Prerequisite** | `idea_report.md` contains Part 1 |
| **Main output** | `idea_report.md` Part 2 (Introduction, Related Works, Method) |
| **Next phase** | `/research[C]-experiment` |

### Flow Steps

| Step | What | Based on | Output | Constraint |
|------|------|----------|--------|------------|
| B-0 | Assemble Part 1 | Phase A confirmed content | `idea_report.md` Part 1 final | Assemble directly; Key Works detail follows A-4.5 choice |
| B-1 | Confirm technical framework (layer 1) | Papers in `docs/papers/` | Write to confirmation card | Read existing papers first; direction only, not implementation |
| B-2 | Confirm detailed pipeline (layer 2) | Confirmed framework | Write to confirmation card | Plain language "step 1… step 2…"; no formula pileup |
| B-3 | Write Method body | Confirmed pipeline | `idea_report.md` Part 2 Method | Pipeline must match body; every formula annotated with variable meanings |
| B-4 | Verify cited content | PDF source texts | Append source passage annotations | Unverifiable: `⚠️ [low confidence: PDF unavailable]`, register in pending list |
| B-5 | Polish Introduction (layer 3) | Confirmed Method | `idea_report.md` Part 2 Introduction | Submission style: importance→limitations→motivation→method→contributions |

### Hard Constraints

| # | Constraint |
|---|------------|
| 1 | Do not proceed to Phase C without explicit confirmation |
| 2 | Read existing papers extensively before drafting |
| 3 | Pipeline must be in plain language; no formula pileup |
| 4 | All citations must be located in source PDF; unverifiable ones annotated as low confidence |

---

## Phase C — `/research[C]-experiment` Experiment Design

| Item | Detail |
|------|--------|
| **Command** | `/research[C]-experiment` |
| **Prerequisite** | `idea_report.md` contains Part 2 |
| **Main output** | `idea_report.md` Part 3 (datasets, experiment design, resource estimate) |
| **Next phase** | `/research[D]-implementation` |

### Flow Steps

| Step | What | Based on | Output | Constraint |
|------|------|----------|--------|------------|
| C-1 | Deep-read baseline papers and code | Baselines in Part 2 Method | Part 3 Section 0 (survey) | Show reading plan; wait for confirmation |
| C-2 | Survey field experiment conventions | Same-domain papers (last 3 years) + C-1 | Standard benchmarks/metrics/ablation patterns | — |
| C-3 | Verify data and code availability | Public links and repos | Availability table (✅/⚠️/❌) | Pause and inform user if either fails |
| C-4 | Propose experiment outline, confirm | Field conventions + availability | Outline (datasets/experiment list/extensions) | Skeleton first; expand only after confirmation |
| C-5 | Generate Part 3 full content | Confirmed outline | Append to `idea_report.md` | Every experiment must have "why designed this way"; every model explained individually |
| C-6 | Provide resource estimate | Model scale/data size/experiment count | Appended to end of Part 3 | Reference only; given after design is complete |

> **Design principle**: The sole purpose of all experiments is to rigorously prove the idea's effectiveness. Resource constraints are not design inputs.

### Hard Constraints

| # | Constraint |
|---|------------|
| 1 | Do not proceed to Phase D without explicit confirmation |
| 2 | Show experiment outline (C-4) and confirm before writing full Part 3 |
| 3 | Do not collect GPU/training-time constraints before design |
| 4 | Every evaluation model must be explained individually |

---

## Phase D — `/research[D]-implementation` Implementation Design

| Item | Detail |
|------|--------|
| **Command** | `/research[D]-implementation` |
| **Prerequisite** | `idea_report.md` contains Part 3 |
| **Main output** | `docs/implementation.md` (function-level coding guide) |
| **Next phase** | `/research[E]-coding` |

### Flow Steps

| Step | What | Based on | Output | Constraint |
|------|------|----------|--------|------------|
| D-0 | Collect coding constraints | Conversation | Write to `user_requirements.md` Phase D section | Framework / special requirements / hard requirements |
| D-1 | Generate implementation.md | `idea_report.md` Part 2/3 + user constraints | `docs/implementation.md` | Read `user_requirements.md` first; precise to every function |
| D-end1 | Three-way validation | implementation.md vs idea_report.md | Validation report | Fix issues before presenting to user |
| D-end2 | Guide to Phase E | User confirmation | — | Prompt `/research[E]-coding` after confirmation |

### Code Structure

```
code/
├── src/
│   ├── models/
│   │   ├── {model_name}.py         # proposed model (one file per model)
│   │   └── baseline/
│   │       └── {baseline}.py       # identical interface to main model
│   ├── data/                       # subdirectory if multiple files; else src/dataset.py
│   ├── train/                      # subdirectory if multiple files; else src/train.py
│   ├── evaluate/                   # subdirectory if multiple files; else src/evaluate.py
│   ├── utils/
│   ├── train.py                    # training entry point
│   └── evaluate.py                 # evaluation entry point
├── scripts/                        # nohup shell scripts; logs → logs/YY-MM-DD_HH-MM-SS.log
├── configs/
│   ├── default.yaml
│   └── ablation_{variant}.yaml
├── data/                           # raw/ + processed/ if preprocessing; else store directly
├── results/                        # gitignored
└── logs/                           # gitignored
```

### Three-Way Validation

| Check | Content |
|-------|---------|
| Experiment coverage | Every Part 3 experiment has a supporting module/function; every ablation variant has an implementation entry |
| Logic consistency | Tensor shapes consistent across modules; loss input/output matches; metric computations match Part 3 |
| Completeness | Every listed file has a section; `src/models/baseline/` covers all Part 3 baselines |

### Hard Constraints

| # | Constraint |
|---|------------|
| 1 | Read `user_requirements.md` before generating implementation.md |
| 2 | Run three-way validation immediately; fix issues before presenting |
| 3 | `requirements.txt` must not contain torch, torchvision, or torchaudio |

---

## Phase E — `/research[E]-coding` Coding

| Item | Detail |
|------|--------|
| **Command** | `/research[E]-coding` |
| **Prerequisite** | `docs/implementation.md` exists |
| **Main output** | All code under `code/`, `code/README.md`, `docs/dev_log.md` |
| **Next phase** | `/research[F]-iteration` (unsatisfactory) or `/research[G.0]-plan` (satisfied) |

### Flow Steps

| Step | What | Based on | Output | Constraint |
|------|------|----------|--------|------------|
| E-0 | Pre-coding checklist (6 items) | Conversation | Write to `user_requirements.md` Phase E | All 6 confirmed before coding starts |
| E-1 | Create dev_log.md | Checklist results | `docs/dev_log.md` | Includes progress table and "How to Run" chapter |
| E-2 | File-by-file coding | `implementation.md` | Code files | Append dev_log entry after each file |
| E-3 | Per-module validation | Code vs implementation.md | — | Signatures / parameters / return values / tensor shapes |
| E-4–E-6 | Handle blockers / doc errors / improvements | Conversation | Append dev_log entries | Update doc before code; every code change appends a log entry |
| E-7 | Code review | All code | Review report | Two hard requirements: runs without error + logically correct |
| E-8 | Write README.md | Confirmed location + dev_log "How to Run" | `README.md` | Written after all coding is done |
| E-9 | Git commit and push | E-0 git config | Remote repository | Check for files >100 MB before pushing |

### E-0 Pre-Coding Checklist

| # | Item | Description |
|---|------|-------------|
| 1 | Runtime environment | Name; reuse existing or create from requirements.txt |
| 2 | Device requirements | CUDA / cuDNN / Apple MPS / CPU-only / Python version |
| 3 | Dataset preparation | Check each; fast → download; slow → provide link and wait |
| 4 | Auto-run strategy | Auto / user-run / mixed |
| 5 | Git repository | Existing URL or create new; push scope; username/email |
| 6 | README location | Project root or `code/` directory |

### dev_log.md Rules

| Rule | Description |
|------|-------------|
| Append-only | Every code change must append a new log entry; never overwrite |
| Fixed "How to Run" chapter | Every run command with parameter meanings, what happens, what outputs |
| Auto-check after every change | If commands/parameters/outputs changed → update "How to Run" immediately |

### Hard Constraints

| # | Constraint |
|---|------------|
| 1 | `requirements.txt` must not contain torch, torchvision, or torchaudio |
| 2 | dev_log.md is append-only; every code change appends a log entry |
| 3 | Design issue found: update document first, then update code |
| 4 | README.md is written after all coding is complete |

---

## Phase F — `/research[F]-iteration` Code Iteration

| Item | Detail |
|------|--------|
| **Command** | `/research[F]-iteration` |
| **Prerequisite** | Phase E complete; experiment results unsatisfactory |
| **Main output** | `dev_log.md` appended iteration records |
| **Next phase** | `/research[G.0]-plan` (when satisfied) |

### Flow Steps

| Step | What | Based on | Output | Constraint |
|------|------|----------|--------|------------|
| F-1 | Diagnostic analysis | `dev_log.md` + `results/` + `idea_report.md` | Diagnostic report (data/model/training) | Must read all three; no guessing |
| F-2 | Confirm backtrack scope | Diagnosis + user choice | Confirmed scope | Three paths: hyperparams / architecture / experiment design |
| F-3 | Update design documents | Confirmed scope | Updated docs | Update docs first, then code |
| F-4 | Code changes | Updated documents | Code + dev_log iteration entry | Append log after every file |
| F-5 | Validation | Run experiments | dev_log results entry | Per E-0 run strategy |
| F-6 | Decide whether to continue | Validation results | — | Satisfied → G.0; needs more → F-1 |

### Backtrack Scope

| What changes | Update documents | Key requirement |
|-------------|-----------------|-----------------|
| Hyperparams / training settings only | `configs/` | No changes to idea_report or implementation.md |
| Model architecture | `idea_report.md` Part 2 + Part 3 (if ablation changes) + `implementation.md` | Re-run three-way validation |
| Experiment design | `idea_report.md` Part 3 + `implementation.md` | Re-run three-way validation |

### Iteration Log Format

```markdown
### {YYYY-MM-DD HH:MM} — Iteration #{N}: {brief description}
**Reason**: {which problem from F-1 diagnosis}
**Changes**:
- `{file path}`: {what changed}
**Expected effect**: {how metrics should change and why}
**Document sync**: idea_report.md {yes/no} | implementation.md {yes/no}
```

### Hard Constraints

| # | Constraint |
|---|------------|
| 1 | dev_log.md is append-only; every code change appends a log entry |
| 2 | Read dev_log.md / results/ / idea_report.md before diagnosing |
| 3 | Update design documents before code |
| 4 | If architecture changes, update Part 3 ablation if affected |

---

## Phase G — Paper Writing (G.0–G.7)

Paper writing is split into 8 independent skills. Follow the recommended order or trigger any section individually.

**Recommended order** (Pengsida's notes / Master-cai): G.0 → G.1 Method → G.2 Experiments → G.3 Abstract → G.4 Introduction → G.5 Related Works → G.6 Conclusion → G.7 Review

### G Phase Common Constraints

Every G.1–G.6 skill must execute before writing:

| # | Preparation step |
|---|-----------------|
| 1 | Read the full manuscript |
| 2 | Read all existing references |
| 3 | Read the `=== Paper Architecture ===` comment at the manuscript header |
| 4 | Read `docs/idea_report.md` and `docs/dev_log.md` |
| 5 | Read writing example analysis (if exists) |
| 6 | Scan all annotations |
| 7 | Confirm writing plan with user before writing |

**Annotation format**: md uses `> %annotation:`, LaTeX uses `%annotation:`

**Version management**: back up before every edit (`paper_{mm-dd_hh-mm}.{ext}`); append modification record to file header.

**Reference format** (every G.x skill can maintain):
- md: `[N] {MLA}` + `> Core contribution:` + `> Reason for citation:`
- LaTeX .bib: `% [Core contribution]` + `% [Reason for citation]`

---

### G.0 — `/research[G.0]-plan` Paper Planning

| Item | Detail |
|------|--------|
| **Command** | `/research[G.0]-plan` |
| **Prerequisite** | Phase E or F complete |
| **Main output** | Updated `idea_report.md`, manuscript architecture comments, `notebooks/figures.ipynb` |
| **Next phase** | `/research[G.1]-method` |

| Step | What | Based on | Output | Constraint |
|------|------|----------|--------|------------|
| G.0-1 | Update idea_report.md | Code vs idea_report comparison | Edit in-place, append modification record | List all diffs; user confirms once before editing |
| G.0-2 | Plan paper structure and figures | Updated idea_report | Outline + figure/table plan | Ask for example (step 3) before confirming structure |
| G.0-3 | Ask for writing example | User upload | `docs/manuscripts/examples/style-notes.md` | Must complete before confirming structure; example takes precedence over templates |
| G.0-4 | Select paper format | User choice | Manuscript file (paper.md or paper.tex) | LaTeX: copy template, do not edit original |
| G.0-5 | Write architecture comments into manuscript | Confirmed outline + figure plan | Manuscript header comment block | Precise to every subsection title / content / figure placement |
| G.0-6 | Generate figure/table notebook | Figure plan | `notebooks/figures.ipynb` | In paper order; multi-panel figures in one cell |

### Architecture Comment Format

```
=== Paper Architecture ===
Target venue: {name}

1. Introduction
   1.1 {subsection title}
       Content: {2-4 key points}
       Figures: {if any}
...
Figure/Table Summary (in paper order):
- Fig.1 {title} ({section}, {hand-drawn/Python}) — {what it shows, how to read it, what conclusion}
- Table.1 {title} ({section}) — {what it shows}
===
```

### Figure Design (CCFA/IEEE Style)

| Item | Specification |
|------|--------------|
| Font | Times New Roman; body 8pt, axis labels 8pt, ticks 7pt, legend 7pt |
| Width | Single-column 3.5 in, double-column 7.0 in |
| Axes | Remove right and top spines |
| Color | proposed blue `#2166AC`, baseline red `#D6604D`, variant green `#4DAC26`, reference gray `#999999` |
| Error bars | Consistent (mean±std or ±SEM, choose one) |
| Tables | booktabs, no vertical lines, bold best, underline second-best |
| Output | SVG + PNG 300dpi → `notebooks/fig/` |
| Caption | First sentence is the conclusion; self-contained |

---

### G.1 — `/research[G.1]-method` Method

| Item | Detail |
|------|--------|
| **Command** | `/research[G.1]-method` |
| **Prerequisite** | G.0 complete |
| **Next phase** | `/research[G.2]-experiments` |

Answer three questions per module (from code and idea_report):

| Question | Source |
|----------|--------|
| How does this module work? | Read from code |
| Why is this module needed? | Corresponds to RQ2, from idea_report |
| Why does this module work? | Theoretical intuition or prior evidence |

Write each module in three-element order: **Module Design → Motivation → Technical Advantage**

| Subsection | Content |
|-----------|---------|
| Overview | One paragraph + pipeline figure reference |
| Module details | Three-element order; explain all variables after every formula |
| Training objective | Loss definition + rationale |

---

### G.2 — `/research[G.2]-experiments` Experiments

| Item | Detail |
|------|--------|
| **Command** | `/research[G.2]-experiments` |
| **Prerequisite** | G.1 written |
| **Next phase** | `/research[G.3]-abstract` |

Three core questions (Pengsida's notes / Master-cai):

| Question | Experiment |
|----------|-----------|
| Is the method better than strong baselines? | Main experiment |
| Which modules/choices drive the gain? | Ablation study |
| How well does the method generalize? | Additional analysis |

| Subsection | Must include |
|-----------|-------------|
| Experimental Setup | Dataset statistics / baseline rationale / metric formulas / implementation details |
| Main Results | Table + text with specific numbers + explanation of why |
| Ablation Study | Each variant: what is removed, metric change, why component is necessary |
| Further Analysis | Parameter sensitivity / efficiency / visualization |

---

### G.3 — `/research[G.3]-abstract` Abstract

| Item | Detail |
|------|--------|
| **Command** | `/research[G.3]-abstract` |
| **Prerequisite** | G.1 and G.2 written |
| **Next phase** | `/research[G.4]-introduction` |

Three templates (Pengsida's notes / Master-cai):

| Version | Structure |
|---------|-----------|
| V1 Challenge→Contribution | task → challenge → contribution → advantage → experiments |
| V2 Challenge→Insight→Contribution | task → challenge → insight → contribution → advantage → experiments |
| V3 Multiple Contributions | task → contribution1+advantage → contribution2+advantage → experiments |

Answer four pre-writing questions from idea_report.md / dev_log.md. Result sentence must contain real numbers.

---

### G.4 — `/research[G.4]-introduction` Introduction

| Item | Detail |
|------|--------|
| **Command** | `/research[G.4]-introduction` |
| **Prerequisite** | G.3 written |
| **Next phase** | `/research[G.5]-related` |

Five-part structure (Pengsida's notes / Master-cai):

| Part | Content | Logic |
|------|---------|-------|
| Part 1 | Task + application value + target metrics | Why this problem matters |
| Part 2 | SOTA failure + root technical reason | Corresponds to RQ2 |
| Part 3 | Proposed method + why it works + new insight | Core contribution |
| Part 4 | Additional contributions | Complete list |
| Part 5 | Experiment summary + contribution list (facts only) | Verifiable claims |

---

### G.5 — `/research[G.5]-related` Related Works

| Item | Detail |
|------|--------|
| **Command** | `/research[G.5]-related` |
| **Prerequisite** | G.4 written |
| **Next phase** | `/research[G.6]-conclusion` |

Standard paragraph per topic: **Topic sentence** → **Representative works** (3–5) → **Limitation** → **Transition**

Final subsection fixed as **Research Gap**: must be completely consistent with Introduction Part 2.

---

### G.6 — `/research[G.6]-conclusion` Conclusion + References

| Item | Detail |
|------|--------|
| **Command** | `/research[G.6]-conclusion` |
| **Prerequisite** | G.5 written |
| **Next phase** | `/research[G.7]-review` |

Four-step Conclusion: restate problem → summarize evidence (cite numbers) → broader impact → limitations + future work

Complete reference verification in this phase: every citation needs "core contribution" + "reason for citation" annotations and must be real.

---

### G.7 — `/research[G.7]-review` Full-Paper Review

| Item | Detail |
|------|--------|
| **Command** | `/research[G.7]-review` |
| **Prerequisite** | Any or all sections written |
| **Next phase** | Complete |

Five-dimension check (Pengsida's notes / Master-cai):

| Dimension | Check |
|-----------|-------|
| Contribution | Every claimed contribution directly supported by experiments? |
| Writing clarity | One message per paragraph? Topic sentence covers paragraph? Consistent terminology? |
| Experimental strength | Main/ablation/additional experiments cover all RQs? Missing baselines? |
| Evaluation completeness | Fair comparisons? Metric selection justified? |
| Method design soundness | Every design choice motivated? Ablation-verified? |

**Claim-Evidence alignment** (required):

| Claim | Evidence | Status |
|-------|----------|--------|
| {claim} | {experiment/table/figure} | supported / needs evidence / missing |

Unsupported claims must be addressed — cannot be skipped.

---

## Version Management Summary

| File | Strategy | Notes |
|------|----------|-------|
| `idea_report.md` | Edit in-place, no backup | Append modification record to header |
| Manuscript (paper.md / .tex) | Back up before every edit | `paper_{mm-dd_hh-mm}.{ext}`; original is always latest |
| `dev_log.md` | Append-only, never delete | Every code change appends a log entry |
| `implementation.md` | Edit in-place | Re-run three-way validation after every edit |
