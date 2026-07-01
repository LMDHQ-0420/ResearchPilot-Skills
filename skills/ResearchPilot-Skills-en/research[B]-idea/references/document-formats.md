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

> **Pure blank template** (copy directly to `docs/idea_report.md` to start filling in): see `references/idea_report-template.md`.
> This section documents the format spec (symbol semantics, required/optional chapters); the blank template contains only the skeleton without explanatory text.

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

{A 2–3 sentence lead-in (≤100 words) explaining how the three-layer RQs are derived from the core gaps in Section 1, and how they relate to each other.}

> RQs form three layers: RQ1 defines the research goal, RQ2 reveals the core bottleneck (direct motivation for Method design), RQ3 questions the scope of applicability (optional). The three layers map to: main experiment → ablation experiments → additional experiments.

#### RQ1: Core Question (Research Goal)

**RQ1: {A broad question directly describing the field pain point, e.g. "How can battery SOH prediction accuracy be improved?"}**

- **Corresponding gap**: {Which core limitation in Section 1 it targets; cite supporting paper [n]}
- **Novelty**: {Has existing work fully answered this? How this research differs}
- **Corresponding experiment**: {Verified by the main experiment; what specifically is validated}

#### RQ2: Mechanism Question (Method Design Rationale)

**RQ2: {A mechanistic analysis question about why existing methods fall short, e.g. "Are local temporal features the key bottleneck for SOH prediction accuracy?"}**

- **Relationship to RQ1**: {How answering RQ2 provides the design rationale for solving RQ1 — it reveals the core obstacle in RQ1}
- **Corresponding gap**: {Has existing work analyzed this mechanism? Cite supporting paper [n]}
- **Corresponding experiment**: {Verified by ablation; what is ablated}

#### RQ3: Boundary Question (Scope of Applicability, optional)

**RQ3: {A scope/generalization question, e.g. "Does the proposed module generalize across different battery chemistries?"}** (optional; omit if scope is already focused)

- **Relationship to RQ1/RQ2**: {Questions the scope of conclusions, making the overall argument more rigorous}
- **Corresponding experiment**: {Verified by additional experiments}

> Note: RQ3 may be omitted. If omitted, state the reason here (e.g. "scope is focused; RQ1+RQ2 provide sufficient proof"). Every RQ must be specific, concrete, and answerable by experiment; do not write generic research-direction descriptions.

### 3 Key Works

{An introductory statement describing the selection logic of these works: which method categories are covered and why they are valuable references for this research. 2–3 sentences.}

<!-- Summary table: key works only (5–8). -->
| Short Name | Venue | Year | Core Contribution (one line) | Borrowing Value for This Research |
|-----------|-------|------|---------------------------|--------------------------------|
| {short name} | {Venue} | {year} | {what the paper does, ≤15 words} | {what specifically can be borrowed, ≤15 words} |

> The table lists key works only; the per-paper entries below include **every downloaded paper** (not just key works), with short names consistent with the headings.

<!-- Per-paper entries: include every downloaded paper. Whether to write the four-point detailed introduction depends on the user's Phase A choice (see phase-research.md A-4.5). -->
#### {Short Name} ({Venue} {Year}) [n]
{When the user chose detailed introductions, expand into four points, academic style:
1. What research problem it solves;
2. What method it uses and why designed that way;
3. How well the method performs;
4. What this paper means for this research.
When the user chose not to, write only a one-sentence core contribution.}

> Borrowing value: {specific help for this research — what is borrowed: method design / experimental paradigm / evaluation metrics / data processing, etc.} [n]
> Key work: {yes / no}, because {one-sentence reason — whether it appears in the key-works table above, and why}

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

> This section is filled directly from the deep-read results in Phase C-1, recording each baseline's experimental design as the reference standard for the experiment design that follows.

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

> This section is synthesized in Phase C-2, aggregating all baseline deep-read results to distill the field's experimental design consensus, directly guiding the experiment design below.

**Standard benchmarks**: {List datasets commonly used across baselines, noting their status in the field}

**Standard evaluation metrics**: {List metrics commonly used across baselines, noting computation and direction (higher / lower is better)}

**Ablation conventions**: {Describe which components the field typically ablates, and common ablation variant naming}

**Reporting norms**: {Whether mean ± std is reported, whether multiple random seeds are used, whether results are listed per dataset}

### Data & Code Availability Summary

> Verifies only whether the datasets and baseline code can be obtained; does not involve GPU/VRAM or other resources — resources are only estimated afterward at the end of Part 3.

| Item | Status | Notes |
|------|--------|-------|
| Dataset {name} | ✅/⚠️/❌ | {explanation} |
| Baseline {name} code | ✅/⚠️/❌ | {explanation} |

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
| Additional experiment types | All field-standard ones | Beyond the standard ones, add 1–3 extension experiments |
| Multiple runs required | Yes | Report mean ± std, at least 3 random seeds |

**Coherence requirements**:
- Every experiment must correspond to at least one innovation or hypothesis in the idea — no unrelated experiments
- Ablations must systematically cover all core design modules, each validated independently
- Additional experiments must validate properties the main experiment cannot cover (e.g., generalization, efficiency) — no redundancy with main experiments
- Additional experiments that recur across multiple papers in the field are treated as standard and must be done; beyond those, propose extension experiments from multiple angles for the user to choose
- All experiments use the same set of random seeds to ensure reproducibility

> If an experiment cannot meet the workload baseline above, explain the reason in that experiment's "Purpose" field (e.g., scarce public datasets in the domain, compute resource constraints).

Each experiment (main, ablation, additional) uses the following unified format:

#### {Experiment Number} {Experiment Name}

**Purpose**: {what this experiment validates — which innovation or hypothesis from the idea it tests}

**Why designed this way**: {Explain why this experiment adopts this setup (dataset choice, range of comparison models, metric combination), and what this design means for supporting the core method — i.e., "which point of the idea this experiment proves". This is the core field of this section and must not be omitted.}

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

> This table explains, one by one, which comparison/ablation models this experiment selects, how each differs from the proposed method, and the significance of including it for the idea.
> The "Source paper" column is for displaying information to the user only (which paper proposed the model, or which paper used it as a baseline); it **does not participate in the baseline-selection decision**.

| Model | Difference from our method | Significance of inclusion (support for the idea) | Type | Source paper (display only) | Code |
|-------|---------------------------|------------------------------------------------|------|----------------------------|------|
| **Ours** | — | Proposed method | Proposed method | — | — |
| {Baseline 1} | {how it differs from ours — missing which innovation module, or taking a different technical route} | {what advantage of ours this comparison highlights / which design choice it proves correct} | {classic / current SOTA / ablation variant} | {Author} et al. [n] ({Venue Year}) / used as a baseline by [n] | {repo or N/A} |
| {Baseline 2} | {...} | {...} | {type} | {source} | {repo or N/A} |

> {Explain the overall selection logic of this group: which method categories are covered, why this comparison is fair and representative}

**Core baseline**: {Identify which model in the table above is the core baseline (the strongest or most relevant comparison), and explain why it is the core — typically the current SOTA or the method closest to ours that best highlights the innovation.}

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
Fill in using the unified format above; models under evaluation are the ablation variants — the "Difference from our method" column states which module is removed, and the "Significance of inclusion" column states which design's necessity that variant validates.}

#### 2.3 Additional Experiments
{Beyond the main and ablation experiments, every method can usually be further validated along other property dimensions. This section has two categories, both filled in using the unified format above:}

**A. Field-standard additional experiments (mandatory)**
{During the C-1 deep-read of baseline papers, any additional experiment type that recurs across multiple papers (e.g., the generalization tests or efficiency comparisons that papers in this field commonly perform) is treated as the field "standard" and must be done in this work. List each, noting "this experiment appears in [n], [n], etc., and is the standard way this field validates {some property}".}

**B. Extension experiments to fill out the workload (user-selected)**
{Beyond the standard experiments, propose additional experiments from as many angles as possible to fill out the workload, for the user to choose from. For each, note the property dimension validated and the question it is expected to answer. Common angles (not limited to): interpretability (attention/feature visualization), generalization (cross-dataset/cross-domain), robustness (noise/adversarial/missing data), efficiency (FLOPs/parameters/inference latency), scalability (data scale/model scale), sensitivity (hyperparameters).}

> {For each additional experiment, the "Why designed this way" field explains what property it validates that the main and ablation experiments cannot cover}

### 3 Resource Estimate (reference)

> Filled in Phase C-6 after the experiment plan is complete. **The resource estimate is for reference only, not a constraint on the experiment design** — the first purpose of the design is to rigorously prove the effectiveness of the idea.

| Experiment | Est. VRAM | Est. time per run | # Groups |
|-----------|-----------|-------------------|----------|
| Main experiment | ~{N}GB | ~{N} h/dataset | {N} |
| Ablation study | ~{N}GB | ~{N} h/variant | {N} |
| {Additional experiment} | ~{N}GB | ~{N} h | {N} |

> These are rough estimates; actual consumption depends on the specific implementation and hardware. If resources are limited, you may run the core experiments first and run in batches, without compromising the effectiveness proof.

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
| Baseline | src/models/baseline/ | ⬜ TODO | — | |
| Training | src/train.py (or src/train/) | ⬜ TODO | — | |
| Evaluation | src/evaluate.py (or src/evaluate/) | ⬜ TODO | — | |
| Utils | src/utils/ | ⬜ TODO | — | |
| Scripts | scripts/ | ⬜ TODO | — | |

Status legend: ⬜ TODO / 🔄 WIP / ✅ Done (run-verified) / ❌ Blocked

## Dev Log Entries

### {YYYY-MM-DD HH:MM} — {action summary}
- **Completed**: {what was done}
- **Issues**: {problems encountered, or "none"}
- **Solutions**: {how resolved, or "none"}

## Known Issues (optional)
- [ ] {issue description}

---

> To revise the experiment design, tell Claude — the dev log will be archived
> with a note and history will be preserved.
```
