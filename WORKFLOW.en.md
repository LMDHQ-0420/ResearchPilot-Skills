# CCFA-Skill — Full Workflow Guide

> This document details what Claude does at every step of the six phases and how it interacts with you.
> For the overview and installation, see the [README](README.en.md).

The workflow progresses naturally through conversation — no mode-switching commands to memorize. Claude proactively asks whether to continue at each key checkpoint, and never jumps to the next phase without your confirmation.

The six phases and their outputs:

| Phase | Name | Main Output |
|-------|------|------------|
| A | Direction Exploration & Literature Review | `docs/idea_report.md` Part 1 |
| B | Idea Deepening | `idea_report.md` Part 2 |
| C | Experiment Design | `idea_report.md` Part 3 |
| D | Implementation Design | `docs/implementation.md` |
| E | Coding | code + `docs/dev_log.md` |
| F | Paper Writing | paper in `docs/manuscripts/` (archived by version) |

---

## The "Confirmation Card" running through Phases A / B

In Phases A and B, **every output from Claude begins with a "confirmed content card"**, so you can always see the currently locked consensus:

```
━━━━━━━━━━ Confirmed Content ━━━━━━━━━━
Research direction: …
Primary RQ: …
Secondary RQ: …
Direction constraints: …
RQ constraints: …
Reference papers: …
Technical framework: … (Phase B)
Pipeline: … (Phase B)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

The card lists only the fields **you have confirmed and that are non-empty** — any unconfirmed or empty field is omitted entirely, with no "TBD"/"none" placeholders; at the very start, when nothing is confirmed yet, the card is not shown. Candidate directions and intermediate search lists never enter it — only papers you explicitly name as references are listed. The card stays in sync with `docs/user_requirements.md` in real time.

---

## Phase A: Direction Exploration & Literature Review

> Goal: through thorough multi-round interaction, converge a vague research interest into an objectively grounded research direction and a clear set of research questions (RQs).

### What Claude does

**1. Parse input, collect requirements**
Extracts your research direction, existing ideas, reference papers, and constraints. If detail is insufficient, asks all questions in a single turn (not across rounds), then writes to `user_requirements.md`, distinguishing "direction constraints" from "RQ constraints".

**2. Initial literature search**
Prioritizes top venues (NeurIPS, ICML, ICLR, CVPR, ACL, etc.), targeting at least 15 valid references. Each research gap requires ≥2 supporting papers; if short, runs additional searches (up to 3 rounds). If coverage falls short, Claude reports the reason honestly and asks whether to continue.

**3. Confirm download list → download papers**
Presents a recommended download list (title, publication, arXiv version, one-line summary, relevance), and after you confirm, batch-downloads to `docs/papers/`. Tries arXiv first, falls back to OpenReview automatically, saves abstract TXT if both fail.

**4. Anchor the problem domain, confirm the direction step by step**
Instead of dumping 5 directions to pick from, it:
- First reports the problem domain across three dimensions (what the field mainly addresses, the major method families, the most active sub-directions in the past two years)
- Based on your interest, focuses on 1–2 candidate directions at a time for in-depth discussion
- Goes back and forth until you clearly settle on one direction and lock it

**5. Distill and confirm RQs one by one**
- Proposes one primary RQ candidate at a time, with: its corresponding gap, a novelty check (targeted search result), and an answerability assessment
- Discusses with you, allowing rewrite/merge/replace, until the primary RQ is confirmed
- Then confirms secondary RQs (1–3) one by one in the same manner
- Once all are confirmed, writes a necessity argument (application/theoretical/timing, each backed by citations)

**6. Assemble Part 1**
Once direction, RQs, and necessity argument are confirmed, with your agreement, assembles them into `idea_report.md` Part 1 (Motivation, Research Questions, Key Works), then proceeds to Phase B.

### What you do

- Answer Claude's clarifying questions, express direction preferences and constraints
- Make a choice or suggest changes for each candidate direction/RQ
- Challenge the gap judgments Claude presents — each gap has paper evidence; you judge whether the evidence is sufficient
- Confirm that the direction and RQs are locked

---

## Phase B: Idea Deepening

> Goal: with the direction and RQs set, deepen the "research question" into an "implementable method". Every output likewise carries the confirmation card, confirming progressively across three layers.

### What Claude does

**0. Assemble and review Part 1**
Assembles the Phase A results into Part 1, presents it for your review, and continues only after you confirm.

**1. Confirm the technical framework (Layer 1)**
First aligns with you on "what broad technical approach will answer the RQs", giving the overall idea, a framework sketch (input → modules → output), and which part of the RQ each module addresses. No implementation details — back and forth until the framework is confirmed.

**2. Confirm the detailed pipeline (Layer 2, plain language)**
Refines the framework into an executable, complete workflow. **The output is plain language — "first… then…" walking through what each step does, without piling up formulas.** Each step also explains its design intuition. Only after confirmation does Claude write Part 2's Method section (3.2 plain-language walkthrough, 3.3+ corresponding theory and formulas).

**3. Citation verification**
For each source annotation, opens the corresponding PDF, locates the supporting passage, and appends the verbatim text. Unverifiable ones are marked `⚠️ [low confidence: PDF unavailable]` and registered in the pending-verification list — uncertainty is surfaced explicitly, never hidden.

**4. Introduction polishing (Layer 3)**
Finally polishes the Introduction to submission quality, in academic paper style (field importance → limitations of existing methods → motivation → method overview → itemized contributions), confirming the logic and force with you.

**5. Proceed to Phase C**
Once technical framework, pipeline, Method, and Introduction are all confirmed, proceeds to experiment design with your agreement.

### What you do

- Confirm or adjust at each of the three checkpoints: technical framework, pipeline, Introduction
- The pipeline is a plain-language description — focus on whether the workflow has gaps or unreasonable parts
- Confirm the idea is fully deepened

---

## Phase C: Experiment Design

> Goal: first deep-read the baselines' actual experiment designs, then design a complete, executable plan aligned with field conventions.
> **Core principle**: the first purpose of experiment design is to rigorously prove the idea's effectiveness, never trimming experiments to fit resources. So resource constraints (GPU/training time) are not collected before design; instead, a resource estimate is provided for reference once the plan is complete.

### What Claude does

**1. Deep-read baseline papers and code**
This is the key prerequisite for experiment design:
- First shows you a reading plan: which baselines' papers and GitHub repos it will read, their core ideas, and why each is worth reading
- After you confirm, reads each paper PDF and code repository
- Extracts per baseline: which datasets, how they are split, which experiments are designed, which models are compared, which metrics are used, and key hyperparameters
- Compiles this into `idea_report.md` Part 3 Section 0

**2. Synthesize field conventions**
Aggregates the deep-read results to identify the standard benchmarks, metrics, ablation patterns, and reporting norms shared across baselines, forming the reference baseline for experiment design.

**3. Data & code availability check**
Verifies only "whether the experiments can be carried out" — confirms dataset links are accessible and baseline repos are accessible. If either fails, pauses and informs you. **Does not check whether GPU/VRAM is sufficient.**

**4. Propose an experiment outline and confirm with you**
Before writing the full text, first presents an experiment outline for discussion: which datasets, how each experiment is designed, why designed that way, how many models participate in each, what the core baseline is and why it's chosen. It also lists several optional extension experiments for you to select. Only after the outline is confirmed does it expand into the full Part 3.

**5. Generate the experiment design**
Per the confirmed outline, at top-venue workload standard: main experiment with 3–5 datasets and 5–8 baselines; ablation study systematically covering all innovation modules (3–6 variants); additional experiments in two categories — field-standard experiments that recur across multiple papers (mandatory) + the extension experiments you selected. Each experiment explains "why designed this way and what it means for supporting the core method"; each model under evaluation is described one by one — its difference from our method, the significance of inclusion, and its source paper (display only) — with the core baseline identified. All results reported as mean ± std over at least 3 random seeds.

**6. Provide a resource estimate (reference only)**
Once the plan is complete, gives a resource estimate based on model scale and the number of experiment groups (estimated VRAM, time per run, group counts), written at the end of Part 3. **This is reference only, not a design constraint**; if resources are limited, you can run the core experiments first and run in batches.

### What you do

- Confirm or adjust the baseline deep-read list
- Review the experiment outline and pick which optional extension experiments to do
- Review the full experiment design and suggest changes

---

## Phase D: Implementation Design

> Goal: generate `implementation.md`, a coding guide precise down to each function, as the blueprint for Phase E.
> `implementation.md` opens with two key parts: a **full directory tree** + a **per-file function table**.

### What Claude does

**1. Choose an implementation strategy**
- **Strong baseline path** (building on an existing open-source project): git clone the original → scan the structure → generate a rewrite plan; each function to modify is described as what it currently does → what it will do → parameter/return changes
- **Build from scratch path**: full directory tree + per-file function table; a dedicated data flow section (raw files → parse → split → normalize → model input tensor, with shapes); each function documented with signature, parameters, return value, and logic

**2. Automatic validation**
After each generation or revision of `implementation.md`, runs three checks: experiment coverage (every Part 3 experiment has a corresponding implementation entry), logical consistency (tensor shapes align across modules), completeness (every file is documented).

**3. Pre-coding confirmation checklist**
After `implementation.md` is confirmed, before coding starts, confirms with you item by item: ① which environment and its name (reuse if found, create if not); ② device-specific requirements; ③ whether datasets are downloaded — Claude downloads the quick ones, gives you commands and paths for the slow ones; ④ whether Claude should auto-run the code (advised by estimated runtime: Claude runs fast, you run slow, or mixed); ⑤ whether README goes in the project root or `code/`.

### What you do

- State whether you're building from scratch or on an existing open-source project (provide the link)
- Review the implementation plan
- Respond to the pre-coding checklist (environment, device, datasets, run strategy, README location)

---

## Phase E: Coding

> Goal: implement file by file following `implementation.md`, maintaining the dev log, README, and visualization notebooks throughout.

### What Claude does

**1. Set up README and notebooks/ first**
Before coding, establishes two artifacts that run through the whole phase: **README.md** (project overview + env setup + detailed run commands, placed where you confirmed) and **notebooks/** (one Jupyter file per key step for visualization).

**2. File-by-file implementation**
Codes one file at a time in order, updating `dev_log.md` after each file; syncs the README for anything affecting run/env, and adds the matching notebook for key steps.

**3. Run per the chosen strategy**
Per your confirmed strategy: Claude auto-run / you run / mixed (Claude runs fast ones, you run slow ones). `✅ Done` is marked only after run verification passes.

**4. Module validation and error handling**
Runs a consistency check after each module (signatures, tensor shapes, metrics). If a logical error or unimplementable design is found in `implementation.md`, Claude **does not silently work around it in code** — it stops → reports → waits for your confirmation → updates `implementation.md` first → then the code.

**5. Proactive code review after completion**
Once all coding is done, Claude proactively reviews the code and reports back. This is research code for validating a paper idea, so it **does not do an engineering-grade strict review** (no fussing over naming, abstraction, performance) — it guards only two hard lines: ① the code runs end to end; ② the logic is fully correct (matches the method design, shapes self-consistent, metrics/ablation switches correct, no silent bugs). Issues touching these two must be fixed (after your confirmation); style/polish items are only flagged, not changed proactively.

**6. Sync docs on improvements**
When you request improvements, or when Claude fixes review findings, each change syncs the README (if it affects run/structure/functionality) and `dev_log.md` (a new log entry with a precise timestamp), keeping all three consistent.

**7. Dependency rules**
`requirements.txt` lists library names only, no version pins, and excludes `torch`/`torchvision`/`torchaudio` (you install these per your CUDA version).

### What you do

- When a blocker arises, decide how to resolve it, or roll back to Phase C/D
- Run the slow code per the run strategy and feed experiment results back to Claude (can trigger an expected-vs-actual comparison analysis)
- Review Claude's code-review report and decide whether to fix
- Request code improvements (Claude keeps README and dev_log in sync)

---

## Phase F: Paper Writing

> Goal: write the paper from everything produced so far (idea_report, experiment results, literature). Papers live in `docs/manuscripts/`, and **every revision is copied to a new file** so versions are traceable.

### What Claude does

**1. Confirm the paper structure first (mandatory)**
Before writing any body text, Claude confirms with you: all first-/second-level headings, what each chapter covers and its writing rationale (especially how Introduction and Related Works are written and why), the figure/table plan (where figures/tables go, what each shows, how it's designed, which are hand-drawn vs Python-generated), and any extra requirements. Drafting starts only after this is confirmed.

**2. Generate the first draft**
Generates `v1.0-first-draft.md` per the confirmed structure. Format (English version skill): the entire paper in English, at most second-level headings. Each chapter/section opens with a `>` writing-rationale note; a **blank `>`** is left at the start of each chapter/section, the end of each paragraph, and below each figure/table caption for your annotations; every figure has a caption marked hand-drawn/Python-generated; references at the end in MLA, each with `>` notes on contribution and reason for citing.

**3. Revise from annotations (loop)**
After you write notes at the blank `>` markers and say "annotations done", Claude reads your annotations in the latest version, revises point by point, and **copies to a new version file** (major/minor decided automatically by change size, named `v{major}.{minor}-{≤15-word summary}.md`), updating the version block under the title (version, time, change description). Loops until the paper is complete.

**4. Guide figure/table generation**
When the paper is nearly settled, Claude proactively guides you to approve generating Python figures/tables: figures go in `notebooks/image.ipynb` (one cell per figure, noting which Fig. / caption / how to read it, can export SVG to `notebooks/image/`, export line commented by default); tables go in `notebooks/table.ipynb` (one cell per table, format matching the paper, annotating table name and row/column meanings). Hand-drawn figures (e.g. the method framework) you draw yourself.

### What you do

- Confirm the paper structure (outline, writing rationale, figure/table plan, extra requirements)
- Review the draft, write annotations in place at the blank `>` markers, then tell Claude
- Approve Claude generating Python figures/tables; draw hand-drawn figures yourself

---

## Back to the README

- Project overview, installation, command reference → [README](README.en.md)
- Chinese workflow guide → [WORKFLOW.md](WORKFLOW.md)
