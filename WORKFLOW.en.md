# Research Scout — Full Workflow Guide

> This document details what Claude does at every step of the five phases and how it interacts with you.
> For the overview and installation, see the [README](README.en.md).

The workflow progresses naturally through conversation — no mode-switching commands to memorize. Claude proactively asks whether to continue at each key checkpoint, and never jumps to the next phase without your confirmation.

The five phases and their outputs:

| Phase | Name | Main Output |
|-------|------|------------|
| A | Direction Exploration & Literature Review | `docs/idea_report.md` Part 1 |
| B | Idea Deepening | `idea_report.md` Part 2 |
| C | Experiment Design | `idea_report.md` Part 3 |
| D | Implementation Design | `docs/implementation.md` |
| E | Coding | code + `docs/dev_log.md` |

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

### What Claude does

**1. Collect experiment constraints**
Asks for GPU model/VRAM, max training time per run, and other hard constraints; writes to `user_requirements.md`.

**2. Deep-read baseline papers and code**
This is the key prerequisite for experiment design:
- First shows you a reading plan: which baselines' papers and GitHub repos it will read, their core ideas, and why each is worth reading
- After you confirm, reads each paper PDF and code repository
- Extracts per baseline: which datasets, how they are split, which experiments are designed, which models are compared, which metrics are used, and key hyperparameters
- Compiles this into `idea_report.md` Part 3 Section 0

**3. Synthesize field conventions**
Aggregates the deep-read results to identify the standard benchmarks, metrics, ablation patterns, and reporting norms shared across baselines, forming the reference baseline for experiment design.

**4. Feasibility verification**
Confirms item by item that dataset links are accessible, baseline repos are accessible, and GPU memory is sufficient. If any check fails, pauses and informs you — never produces a plan that "looks complete but cannot run".

**5. Generate the experiment design**
At top-venue workload standard: main experiment with 3–5 datasets and 5–8 baselines; ablation study systematically covering all innovation modules (3–6 variants); 2–3 additional experiment types (generalization/efficiency/robustness/visualization); all results reported as mean ± std over at least 3 random seeds. Each experiment notes its purpose, dataset splits and rationale, metric meanings, expected outcome, and the models compared.

### What you do

- Provide hardware and time constraints
- Confirm or adjust the baseline deep-read list
- Review the experiment design and suggest changes

---

## Phase D: Implementation Design

> Goal: generate `implementation.md`, a coding guide precise down to each function, as the blueprint for Phase E.

### What Claude does

**1. Choose an implementation strategy**
- **Strong baseline path** (building on an existing open-source project): git clone the original → scan the structure → generate a rewrite plan; each function to modify is described as what it currently does → what it will do → parameter/return changes
- **Build from scratch path**: full directory tree + per-file responsibilities; a dedicated data flow section (raw files → parse → split → normalize → model input tensor, with shapes); each function documented with signature, parameters, return value, and logic

**2. Automatic validation**
After each generation or revision of `implementation.md`, runs three checks: experiment coverage (every Part 3 experiment has a corresponding implementation entry), logical consistency (tensor shapes align across modules), completeness (every file is documented).

**3. Data preparation guidance**
After `implementation.md` is confirmed, outputs data download instructions and waits for you to confirm data is ready before entering Phase E.

### What you do

- State whether you're building from scratch or on an existing open-source project (provide the link)
- Review the implementation plan
- Download datasets per the instructions and confirm completion

---

## Phase E: Coding

> Goal: implement file by file following `implementation.md`, maintaining a dev log throughout.

### What Claude does

**1. File-by-file implementation**
Codes one file at a time in the order from `implementation.md`, updating the `dev_log.md` progress table and log entry immediately after each file.

**2. Module validation**
After each module, runs a consistency check against `implementation.md` (function signatures, tensor shapes, evaluation metrics). `✅ Done` is marked only after the code is written and verified to run locally without errors.

**3. Handling design errors**
If a logical error or unimplementable design is found in `implementation.md`, Claude **does not silently work around it in code** — it stops → reports the issue and a suggested fix → waits for your confirmation → updates `implementation.md` first → then updates the code.

**4. Dependency rules**
`requirements.txt` lists library names only, no version pins, and excludes `torch`/`torchvision`/`torchaudio` (you install these per your CUDA version).

### What you do

- When a blocker arises, decide how to resolve it, or roll back to Phase C/D
- Run the code locally and feed experiment results back to Claude (can trigger an expected-vs-actual comparison analysis)

---

## Back to the README

- Project overview, installation, command reference → [README](README.en.md)
- Chinese workflow guide → [WORKFLOW.md](WORKFLOW.md)
