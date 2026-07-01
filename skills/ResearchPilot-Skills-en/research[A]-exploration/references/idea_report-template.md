# idea_report.md Blank Template

> This file is the pure blank skeleton of `idea_report.md`, for direct copy to `docs/idea_report.md` before filling in.
> Format symbol semantics and required/optional chapter rules: see `references/document-formats.md` and `references/template-flexibility.md`.
> Placeholders use `{}` — replace the entire `{...}` including braces when filling in.
> The ```` ```markdown ```` block below is the copyable template body.

````markdown
# {Research Direction} Idea Report
> Generated: {YYYY-MM-DD} | Status: PENDING_REVIEW

---

## Part 1 Topic Overview

### 1 Motivation

{Background and motivation body text}

> {Plain-language supplement}

**Why this research is necessary:**

- **Application necessity**: {} [n]
- **Theoretical necessity**: {} [n]
- **Timing necessity**: {}

### 2 Research Questions

{Introductory statement: which core gaps from Section 1 these RQs are derived from}

#### Primary RQ

**RQ1: {Complete question?}**

- **Corresponding gap**: {} [n]
- **Novelty**: {}
- **Answerability**: {}

#### Secondary RQs

**RQ2: {Complete question?}**

- **Corresponding gap**: {} [n]
- **Relation to RQ1**: {}

### 3 Key Works

{Selection logic: which method categories are covered and why they are valuable}

<!-- Summary table: key works only -->
| Short Name | Venue | Year | Core Contribution (one line) | Borrowing Value |
|-----------|-------|------|---------------------------|----------------|
| {short name} | {Venue} | {year} | {} | {} |

<!-- Per-paper entries: include EVERY downloaded paper (not just key works).
     If the user chose detailed introductions, write the four points; otherwise a one-line core contribution. -->
#### {Short Name} ({Venue} {Year}) [n]

{If detailed introduction is needed, expand into four points:
1. What research problem it solves: {}
2. What method it uses and why designed that way: {}
3. How well the method performs: {}
4. What this paper means for this research: {}
If not needed, write only a one-sentence core contribution.}

> Borrowing value: {} [n]
> Key work: {yes / no}, because {}

---

## Part 2 Idea Design

### 1 Introduction

{Academic-style Introduction body, no sub-headings}

The main contributions are as follows:
- {Method-level contribution}
- {Technical-level contribution}
- {Experiment-level contribution (placeholder; fill with real results after experiments)}

### 2 Related Works

#### 2.1 {Related Direction 1}

{Synthesis body}

> {Source annotation if applicable} [n]

#### 2.2 {Related Direction 2}

{Synthesis body}

#### 2.3 Research Gap

{Research gap body}

> {One-sentence summary: where existing methods are stuck, and where this paper breaks through}

### 3 Method

#### 3.1 {Overall Framework}

{High-level approach body}

> {Intuition explanation}

```text
Input → [Module A: role] → [Module B: role] → Output
```

> Data flow: {}

#### 3.2 Step-by-Step Walkthrough

{Plain-language step-by-step: first… then…}

> {Design intuition}

#### 3.3 {Core Module Name}

{Module description and theoretical formulation}

$$
{formula}
$$

> Formula: {}

> This module is inspired by [n], {}. [n]
> Source text: "{supporting sentence}" (Section {X.X})

#### 3.x Baseline Reference and Evaluation Metrics

| Baseline | Source [n] | Selection rationale |
|---------|-----------|-------------------|
| {name} | {Author} et al. [n] ({Venue Year}) | {} |

> {Why these baselines are fair and representative}

| Metric | Definition | Selection basis [n] |
|--------|-----------|-------------------|
| {metric name} | {computation} | {} |

> {Why these metrics reflect the innovation}

---

## Part 3 Experiment Design

### 0 Baseline Experiment Survey

#### 0.x {Baseline Name} ({Venue} {Year}) [n]

**Paper**: {full title} | **Code**: {GitHub link or `[code unavailable]`}

**Core idea**: {}

**Datasets**:

| Dataset | Scale | Split Strategy | Ratio / Notes |
|---------|-------|---------------|--------------|
| {name} | {} | {} | {} |

**Experiment design**:

| Experiment | Purpose | Comparison Models | Metrics |
|-----------|---------|-----------------|---------|
| {main experiment} | {} | {} | {} |
| {ablation} | {} | {} | {} |

**Key hyperparameters**: batch size = {N}, lr = {float}, epochs = {N}, {others}

> {Noteworthy experimental design details}

---

### 0.x+1 Field Convention Synthesis

**Standard benchmarks**: {}

**Standard evaluation metrics**: {}

**Ablation conventions**: {}

**Reporting norms**: {}

### Data & Code Availability Summary

| Item | Status | Notes |
|------|--------|-------|
| Dataset {name} | ✅/⚠️/❌ | {} |
| Baseline {name} code | ✅/⚠️/❌ | {} |

---

### 1 Datasets

#### 1.1 Available Datasets

| Dataset | Type | Scale | Download | Usage |
|---------|------|-------|---------|-------|
| {name} | {} | {} | {official link} | Primary / Backup |

> {Why this dataset was chosen} [n]

#### 1.2 Backup Datasets

| Dataset | Type | Scale | Download | Reason for Backup |
|---------|------|-------|---------|-----------------|
| {name} | {} | {} | {link} | {} |

#### 1.3 Data Preprocessing

{Standard preprocessing tool and link, or standard preprocessing pipeline}

> {Why this preprocessing approach, any paper support} [n]

### 2 Experiment Design

Each experiment (main, ablation, additional) uses the unified format below:

#### {Experiment Number} {Experiment Name}

**Purpose**: {which innovation or hypothesis from the idea this validates}

**Why designed this way**: {what this setup means for supporting the core method — which point of the idea it proves}

**Dataset and Splits**:

| Dataset | Train | Val | Test | Split Method | Justification |
|---------|-------|-----|------|-------------|--------------|
| {name} | {} | {} | {} | {} | {} [n] |

**Evaluation Metrics**:

| Metric | Meaning | Computation | Justification |
|--------|---------|------------|--------------|
| {metric} | {} | {} | {} [n] |

> {Why this set of metrics reflects the experiment's purpose}

**Expected Outcome**: {how much better, and why}

**Models Under Evaluation**:

| Model | Difference from our method | Significance of inclusion | Type | Source paper (display only) | Code |
|-------|---------------------------|--------------------------|------|----------------------------|------|
| **Ours** | — | Proposed method | Proposed method | — | — |
| {Baseline 1} | {} | {} | {classic/SOTA/ablation} | {Author} et al. [n] ({Venue Year}) / used as baseline by [n] | {repo or N/A} |

> {Overall selection logic: which categories are covered, why this comparison is fair}

**Core baseline**: {which model is the core baseline and why}

**Expected Results (placeholder)**:

| Model | {Dataset} | {Metric 1} | {Metric 2} | {Metric 3} |
|-------|----------|-----------|-----------|-----------|
| {Baseline 1} | — | — | — | — |
| **Ours** | — | **?** | **?** | **?** |

---

The specific experiments are as follows:

#### 2.1 Main Experiment: Overall Performance Comparison

{Fill using unified format above}

#### 2.2 Ablation Study: Effectiveness of {Core Module}

{Fill using unified format; name variants as w/o {module name}, replaced by {fallback}}

#### 2.3 Additional Experiments

**A. Field-standard additional experiments (mandatory)**

{List each recurring experiment type found across multiple baseline papers, noting "this experiment appears in [n], [n], and is the standard way this field validates {property}"}

**B. Extension experiments to fill out the workload (user-selected)**

{List additional experiments from multiple angles for the user to choose, each noting the property dimension validated: interpretability / generalization / robustness / efficiency / scalability / sensitivity}

### 3 Resource Estimate (reference)

| Experiment | Est. VRAM | Est. time per run | # Groups |
|-----------|-----------|-------------------|----------|
| Main experiment | ~{N}GB | ~{N} h/dataset | {N} |
| Ablation study | ~{N}GB | ~{N} h/variant | {N} |
| {Additional} | ~{N}GB | ~{N} h | {N} |

> Rough estimates; actual consumption depends on implementation and hardware. If resources are limited, prioritize core experiments and run in batches.

---

## References

> Format: MLA. All entries must be verified as real via web_search. Unverifiable entries get `[to verify]`.

[1] Last, First. "Full Paper Title." *Full Journal/Conference Name*, vol. X, no. X, Year, pp. X–X.

> Main contribution: {one sentence}
> Reason for citing: {one sentence}
> PDF: `docs/papers/{full paper title}.pdf` / `[PDF unavailable]`

---

## Pending Verification
> Auto-maintained by Claude. Check off items as you verify them.

- [ ] {claim} (Location: {Section}, Reason: {PDF unavailable / no supporting text found / data from secondary source})

---

> ⚠️ **Phase B Completion Checkpoint**
> Review Part 1 and Part 2, then tell Claude whether to proceed to experiment design.
> - Ready to continue → tell Claude, proceed to Phase C
> - Needs revision → raise the issues; Claude will iterate and ask again
````
