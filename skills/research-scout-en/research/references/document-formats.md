# Document Formats

Detailed format specifications for `idea_report.md`, `implementation.md`, and `dev_log.md`.
Chapter presence and content volume follow `references/template-flexibility.md`.

> Note: `code_guide.md` is deprecated. Its content has been split into
> `implementation.md` (implementation design guide, Phase D output) and
> `code/README.md` (environment setup and run commands, generated early in Phase E).

---

## idea_report.md

### Markdown Symbol Semantics

| Symbol | Meaning | Constraints |
|--------|---------|------------|
| `#` | File title | Unique across the document |
| `## Part 1` / `## Part 2` / `## Part 3` | Three major part headings | Fixed — do not add or remove; text is fixed |
| `### 1` / `### 2` / `### 3` | Level-1 sections (renumbered from 1 within each Part) | Fixed section titles — see templates below |
| `#### 1.1` / `#### 1.2` | Level-2 sub-sections | Add or remove freely; use semantic names |
| `##### 1.1.1` | Level-3 sub-sections | Use only when necessary |
| `>` | Annotation | Immediately after body text; plain-language gloss of formulas, design decisions, sources, or difficult points; **use heavily** |
| `⚠️ [low confidence: ...]` | Uncertainty marker | End of any insufficiently evidenced claim; register in Pending Verification list |
| `` `code` `` | Inline code | File names, function names, variable names, commands |
| ` ```text ` | Data flow / structure diagrams | |
| ` ```python ` | Pseudocode | |
| `$$...$$` | Block equations | |
| `$...$` | Inline equations | |
| `**bold**` | First occurrence of key terms; method row values in tables | Max 5 words |
| `1.` ordered list | References section only | |
| `---` | Between Parts; before each review checkpoint | Only these two positions |
| HTML comments | STRICTLY FORBIDDEN in final output | |

**Heading language rule (English version)**: all headings in English, including `## References`.

---

### idea_report.md Full Template

````markdown
# {Research Direction} Idea Report
> Generated: {YYYY-MM-DD} | Status: PENDING_REVIEW

---

## Part 1 Topic Overview

### 1 Motivation
{Explain the background of this research direction: why the problem matters, what core limitations existing methods have, and why pursuing this direction is meaningful.
Continuous paragraphs, academic style, cite key papers.}

> {Plain-language supplement: from a practical application perspective, explain why existing methods fall short}

**Why this research is necessary:**

- **Application necessity**: {From a real application scenario, explain what concrete impact the limitations of existing methods have on downstream tasks or deployment, with supporting citations}
- **Theoretical necessity**: {Point out the cognitive gap left by existing work — what problem remains under-studied or unexplained, with supporting citations}
- **Timing necessity**: {Explain why now is the right time to study this problem — e.g., emergence of new datasets, maturity of enabling techniques, new application demands}

> Note: all three points must be backed by literature, not asserted subjectively. If a point lacks sufficient evidence in the current review, mark it ⚠️ [low confidence: evidence pending].

### 2 Research Questions

{An introductory statement explaining which core gaps from Section 1 these RQs are derived from. 2–3 sentences, under 100 words.}

#### Primary RQ

**RQ1: {State as a complete question ending with a question mark}**

- **Corresponding gap**: {Which limitation in Section 1 it targets, with supporting citation [n]}
- **Novelty**: {Whether existing work has partially answered this question, and how this research differs from it}
- **Answerability**: {Explain that this RQ can be answered within the experimental scope of a single paper, and through what experiments}

#### Secondary RQs

**RQ2: {Complete question}**

- **Corresponding gap**: {Supporting citation [n]}
- **Relation to RQ1**: {Whether this RQ extends, precedes, or complements RQ1}

**RQ3: {Complete question}** (optional, add or remove based on research scope)

- **Corresponding gap**: {Supporting citation [n]}
- **Relation to RQ1**: {State the relation}

> Note: the number of RQs follows the research scope, typically 1 primary + 1–3 secondary. Each RQ must be specific, concrete, and answerable by experiment; do not write generic research-direction descriptions.

### 3 Key Works

{An introductory statement describing the selection logic of these works: which method categories are covered and why they are valuable references for this research. 2–3 sentences.}

| Short Name | Venue | Year | Core Contribution (one line) | Borrowing Value for This Research |
|-----------|-------|------|---------------------------|--------------------------------|
| {short name} | {Venue} | {year} | {what the paper does, ≤15 words} | {what specifically can be borrowed, ≤15 words} |

> Each row corresponds to one detailed entry below; keep the short name consistent with the heading below.

#### {Short Name} ({Venue} {Year}) [n]
{Core contribution, academic style, 2–3 sentences. Describe the method's core idea and main experimental findings.}

> Borrowing value: {specific help for this research — what is borrowed: method design / experimental paradigm / evaluation metrics / data processing, etc.} [n]

---

## Part 2 Idea Design

### 1 Introduction
{Write the Introduction strictly in academic paper style.
No sub-headings allowed.
Structure: broad direction (field importance) → limitations of existing methods (itemized, with citations) → motivation for this paper → overview of proposed method → contributions listed as bullet points.
Length: 600–1000 words.}

The main contributions are as follows:
- We propose ... (method level)
- We design ... (technical level)
- We demonstrate on ... datasets, achieving ...

> Note: the third contribution is a placeholder; fill with real numbers after experiments.

### 2 Related Works

#### 2.1 {Related Direction 1}
{Summarize the main approaches in this direction, cite representative papers, point out shared limitations. No need to introduce papers one by one — focus on synthesis.}

> {If a synthesis conclusion directly draws from a survey, annotate the source} [n]

#### 2.2 {Related Direction 2}
{Same as above}

#### 2.3 Research Gap
{Synthesize the shortcomings identified across all directions above; explicitly state the research gap this paper fills.
This is the final sub-section of Related Works — always present.
Format: first list the shared problems of existing methods, then explain which angle this paper attacks from.}

> {One-sentence summary: where existing methods are stuck, and where this paper breaks through}

### 3 Method

#### 3.1 {Overall Framework}
{High-level idea of the method: first "what it does", then "how it does it". Academic style, 3–5 sentences.}

> {Intuition: explain the core idea with an analogy or everyday language}

```text
Input → [Module A: role] → [Module B: role] → [Module C: role] → Output
```

> Data flow: {text explanation of each arrow in the diagram above}

#### 3.2 Step-by-Step Walkthrough
{Describe every step of the method in plain, accessible language — no formulas, no jargon.
Use "Step 1 … Step 2 …" structure so that a reader without domain background can follow what the method does.
Each step here must correspond one-to-one with a sub-section in 3.3; the number of steps equals the number of 3.3 sub-sections.}

> {Supplementary note: the intuitive justification for this sequence — why this order is natural and correct}

#### 3.3 {Core Module Name}
{Detailed module description: input/output definitions, operation steps, equation derivation. Academic style.
This section corresponds one-to-one with the matching step in 3.2, providing the rigorous theoretical treatment.}

$$
{equation}
$$

> Formula: {intuition behind each symbol; why designed this way; theoretical justification}

> This module's design is inspired by [n], where ... This work extends it by ... [n]
> Source text: "{verbatim supporting sentence from PDF}" (Section {X.X})

#### 3.4 {Other Modules ...}
{Same structure; add or remove sub-sections based on method complexity; each sub-section corresponds to one step in 3.2}

#### 3.x Baseline Reference and Evaluation Metrics
{This section is always present, positioned as the final sub-section of Method.
Explain which baselines are chosen and why, and which evaluation metrics are chosen and why.
Every baseline and every metric must have a paper citation as justification.}

| Baseline | Source [n] | Reason for Selection |
|----------|-----------|---------------------|
| {Name} | {Author} et al. [n] ({Venue Year}) | {Reason} |

> {Explain why these baselines constitute a fair and representative comparison}

| Metric | Definition | Justification [n] |
|--------|-----------|-------------------|
| {Metric name} | {Computation method} | {Cite papers that use this metric} |

> {Explain why these metrics accurately reflect the innovation of this method}

---

## Part 3 Experiment Design

### 0 Baseline Experiment Survey

> This section is filled directly from the deep-read results in Phase C-2, recording each baseline's experimental design as the reference standard for the experiment design that follows.

#### 0.x {Baseline Name} ({Venue} {Year}) [n]

**Paper**: {full title} | **Code**: {GitHub link or `[code unavailable]`}

**Core idea**: {One sentence on the baseline's core method and its relation to this research}

**Datasets**:

| Dataset | Scale | Split Strategy | Ratio / Notes |
|---------|-------|---------------|--------------|
| {name} | {# samples / size} | {random / official / chronological / cross-validation} | {specific ratio or notes} |

**Experiment design**:

| Experiment | Purpose | Comparison Models | Evaluation Metrics |
|-----------|---------|------------------|-------------------|
| {main experiment name} | {what it validates} | {all comparison models, comma-separated} | {metric list} |
| {ablation name} | {which component it validates} | {ablation variant names} | {metric list} |

**Key hyperparameters**: batch size = {N}, lr = {float}, epochs = {N}, {other key hyperparameters}

> {Noteworthy experimental design details observed from the code / paper, worth borrowing or watching out for}

---

### 0.x+1 Field Convention Synthesis

> This section is synthesized in Phase C-3, aggregating all baseline deep-read results to distill the field's experimental design consensus, directly guiding the experiment design below.

**Standard benchmarks**: {List datasets commonly used across baselines, noting their status in the field}

**Standard evaluation metrics**: {List metrics commonly used across baselines, noting computation and direction (higher / lower is better)}

**Ablation conventions**: {Describe which components the field typically ablates, and common ablation variant naming}

**Reporting norms**: {Whether mean ± std is reported, whether multiple random seeds are used, whether results are listed per dataset}

### Feasibility Verification Summary

| Item | Status | Notes |
|------|--------|-------|
| Dataset {name} | ✅/⚠️/❌ | {explanation} |
| Baseline {name} code | ✅/⚠️/❌ | {explanation} |
| GPU memory | ✅/⚠️ | Estimated {N}GB, user has {M}GB |

---

### 1 Datasets

#### 1.1 Available Datasets

| Dataset | Type | Scale | Download | Usage |
|---------|------|-------|---------|-------|
| {Name} | {classification/regression/sequence/etc.} | {# samples / size} | {official link} | Primary / Backup |

> {Explain why this dataset is chosen: its standard status in the field, cite papers that use it}

#### 1.2 Backup Datasets

| Dataset | Type | Scale | Download | Reason for Backup |
|---------|------|-------|---------|------------------|
| {Name} | {type} | {scale} | {link} | {explanation} |

#### 1.3 Data Preprocessing
{If there is a standard preprocessing project or tool for this field, it must be identified here, including the project link.
If no standard tool exists, describe the standard preprocessing pipeline.}

> {Explain why this preprocessing approach is used, and whether it has paper support}

### 2 Experiment Design

**Workload baseline (top venue standard)**:

| Dimension | Minimum | Recommended |
|-----------|---------|-------------|
| Main experiment datasets | 2 | 3–5 (covering different scales / domains) |
| Baseline models compared | 4 | 5–8 (recent SOTA + classic methods) |
| Ablation variants | 1 per innovation | 3–6 variants, systematically covering all core designs |
| Additional experiment types | 1 | 2–3 (from: generalization / efficiency / robustness / visualization) |
| Multiple runs required | Yes | Report mean ± std, at least 3 random seeds |

**Coherence requirements**:
- Every experiment must correspond to at least one innovation or hypothesis in the idea — no unrelated experiments
- Ablations must systematically cover all core design modules, each validated independently
- Additional experiments must validate properties the main experiment cannot cover (e.g., generalization, efficiency) — no redundancy with main experiments
- All experiments use the same set of random seeds to ensure reproducibility

> If an experiment cannot meet the workload baseline above, explain the reason in that experiment's "Purpose" field (e.g., scarce public datasets in the domain, compute resource constraints).

Each experiment (main, ablation, additional) uses the following unified format:

#### {Experiment Number} {Experiment Name}

**Purpose**: {what this experiment validates — which innovation or hypothesis from the idea it tests}

**Dataset and Splits**:

| Dataset | Train | Val | Test | Split Method | Justification |
|---------|-------|-----|------|-------------|--------------|
| {Name} | {ratio or count} | {ratio or count} | {ratio or count} | {random / official / cross-val} | {reason; cite papers that use the same split} |

**Evaluation Metrics**:

| Metric | Meaning | Computation | Justification |
|--------|---------|------------|--------------|
| {Metric name} | {one sentence on what this metric measures} | {formula or steps} | {cite papers that use this metric} |

> {Explain why this set of metrics accurately reflects the purpose of this experiment}

**Expected Outcome**: {how much better the proposed method is expected to perform vs. baselines, and why this improvement is anticipated}

**Models Under Evaluation**:

| Model | Source [n] | Type | Code | Description |
|-------|-----------|------|------|-------------|
| **Ours** | — | Proposed method | — | {one sentence describing the proposed method} |
| {Baseline 1} | {Author} et al. [n] | {type: classic / current SOTA / ablation variant} | {repo or N/A} | {one sentence on this model's core approach} |
| {Baseline 2} | {Author} et al. [n] | {type} | {repo or N/A} | {one sentence} |

> {Explain the selection logic: which method categories are covered, why this comparison is fair}

**Expected Results (placeholder)**:

| Model | {Dataset} | {Metric 1} | {Metric 2} | {Metric 3} |
|-------|----------|-----------|-----------|-----------|
| {Baseline 1} | — | — | — | — |
| {Baseline 2} | — | — | — | — |
| **Ours** | — | **?** | **?** | **?** |

---

The specific experiments are as follows:

#### 2.1 Main Experiment: Overall Performance Comparison
{Purpose: comprehensively validate the proposed method's performance advantage over existing methods on standard benchmarks.
Fill in using the unified format above.}

#### 2.2 Ablation Study: Effectiveness of {Core Module}
{Purpose: remove each innovation module one at a time to validate the necessity of each design.
Name ablation variants as: w/o {module name}, replaced by {fallback approach}.
Fill in using the unified format above; models under evaluation are the ablation variants.}

#### 2.3 {Additional Experiment (optional)}
{Include only when the method's properties require it. Common types: robustness testing, cross-dataset generalization, efficiency comparison (FLOPs / inference latency), visualization analysis.
Fill in using the unified format above.}

> {Explain why this additional experiment is needed: what property it validates that the main and ablation experiments cannot cover}

---

## References

> MLA format. All entries must be verified as real via web_search. Unverifiable entries get `[to verify]`.
> All citations from Part 1 and Part 2 are consolidated here — do not list references separately within each Part.

[1] Last, First. "Full Paper Title." *Full Venue Name*, vol. v, no. n, year, pp. start–end.

> **Main work**: {what the paper does, ≤ 20 words}
> **Why cited**: {specific help for this idea, ≤ 20 words}
> **PDF**: `docs/papers/{full title}.pdf` / `[PDF unavailable]`

---

## Pending Verification
> Auto-maintained by Claude. Check off after manual verification.

- [ ] {claim} (Location: {Section}, Reason: {PDF unavailable / no supporting text found / data from secondary citation})

---

> ⚠️ **Phase B Review Checkpoint**
> Please review Part 1 and Part 2. Claude will ask whether you are satisfied
> and whether to proceed to experiment design (Phase C / Part 3).
````

---

## dev_log.md

```markdown
# Dev Log — {topic}
> Created: {YYYY-MM-DD} | Last Updated: {YYYY-MM-DD}
> Linked design: `docs/idea_report.md` (Part 3, updated {date})

## Project Overview
| Item | Value |
|------|-------|
| Research direction | {topic} |
| Strategy | From scratch / Based on {project name} |
| Code root | `code/` |
| Design version | {Part 3 updated date} |
| Language | Python |
| Framework | {PyTorch / TF / JAX} |
| User coding requirements | {collected from conversation} |

## Project Architecture

```text
code/
└── ... (matches confirmed structure exactly)
```

### Module Responsibilities
| File/Dir | Responsibility | Input | Output | Key Deps |
|----------|---------------|-------|--------|---------|

## Model Architecture (optional)

### Overall Structure
```text
Input → [Module A] → [Module B] → Output
```

### Core Module Pseudocode
```python
class {ModelName}(nn.Module):
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        ...
```

## Project Logic

### Data Flow
```text
Raw files → Dataset → DataLoader → transforms → model input
```

### Training Flow
```text
load config → init → epoch loop → early stopping → save ckpt
```

### Inference Flow
```text
load ckpt → test set → forward → postprocess → compute metrics → save results
```

## Progress

| Module | File | Status | Completed | Notes |
|--------|------|--------|-----------|-------|
| Init | README.md, requirements.txt, configs/ | ✅ Done | {date} | |
| Data loading | src/data/ | ⬜ TODO | — | |
| Main model | src/models/{model}.py | ⬜ TODO | — | |
| Train loop | src/trainers/trainer.py | ⬜ TODO | — | |
| Utils | src/utils/ | ⬜ TODO | — | |
| Scripts | scripts/ | ⬜ TODO | — | |
| Baselines | baselines/ | ⬜ TODO | — | |

Status legend: ⬜ TODO / 🔄 WIP / ✅ Done (run-verified) / ❌ Blocked

## Dev Log Entries

### {YYYY-MM-DD} — {action summary}
- **Completed**: {what was done}
- **Issues**: {problems encountered, or "none"}
- **Solutions**: {how resolved, or "none"}

## Known Issues (optional)
- [ ] {issue description}

---

> To revise the experiment design, tell Claude — the dev log will be archived
> with a note and history will be preserved.
```
