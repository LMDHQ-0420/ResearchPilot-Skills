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
| `>` | Explanatory annotation | Immediately after body text; plain-language gloss of formulas, design decisions, or difficult points; **use heavily** |
| `>>` | Source annotation | Immediately after borrowed ideas; must cite `[n]`; append verified verbatim sentence from PDF |
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

**Heading language rule (English version)**: all headings in English.

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

### 2 Development Timeline
{Narrate the evolution of the field in chronological order, at least 5 key milestones.
Format for each milestone: Author et al. [n] (Venue Year) proposed ..., solving ..., but still lacking ....
Use continuous paragraphs, not bullet lists.}

>> {If a milestone description directly draws from a survey or paper, annotate the source here} [n]

### 3 Key Works
{List 5–8 works worth learning from — not limited to SOTA; include methodologically inspiring works.
One sub-section per paper, title format: #### 3.x {Short Name} ({Venue} {Year})}

#### 3.1 {Short Name} ({Venue} {Year})
{Core contribution, academic style, 2–3 sentences}

>> Borrowing value: {specific help for this idea} [n]

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

>> {If a synthesis conclusion directly draws from a survey, annotate the source} [n]

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

#### 3.2 {Core Module Name}
{Detailed module description: input/output definitions, operation steps, equation derivation. Academic style.}

$$
{equation}
$$

> Formula: {intuition behind each symbol; why designed this way; theoretical justification}

>> This module's design is inspired by [n], where ... This work extends it by ... [n]
>> Source text: "{verbatim supporting sentence from PDF}" (Section {X.X})

#### 3.3 {Other Modules ...}
{Same structure; add or remove sub-sections based on method complexity}

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

### 2 Main Experiments

#### 2.1 Dataset Splits

| Dataset | Train | Val | Test | Split Method | Justification |
|---------|-------|-----|------|-------------|--------------|
| {Name} | {ratio or count} | {ratio or count} | {ratio or count} | {random / official / cross-val} | {reason} |

> {Explain why this split is used: does it follow the dataset's official split, cite related papers}

#### 2.2 Comparison Models

| Model | Source [n] | Type | Code |
|-------|-----------|------|------|
| **Ours** | — | Proposed method | — |
| {Baseline 1} | {Author} et al. [n] | {type} | {repo or N/A} |
| {Baseline 2} | {Author} et al. [n] | {type} | {repo or N/A} |

> {Explain why these baselines are chosen: which method categories they cover, whether current SOTA is included}

#### 2.3 Hyperparameters

| Parameter | Value | Notes |
|-----------|-------|-------|
| Learning rate | {value} | {notes} |
| Batch size | {value} | {notes} |
| Optimizer | {name} | {notes} |
| Epochs | {value} | {notes} |
| Random seed | 42 | Unified across all experiments |
| {Other key params} | {value} | {notes} |

> {Explain the basis for hyperparameter choices: whether they follow baseline paper settings, cite papers}

#### 2.4 Expected Results (placeholder)

| Model | {Dataset} | {Metric 1} | {Metric 2} | {Metric 3} |
|-------|----------|-----------|-----------|-----------|
| {Baseline 1} | — | — | — | — |
| {Baseline 2} | — | — | — | — |
| **Ours** | — | **?** | **?** | **?** |

### 3 Ablation Study

#### 3.1 Dataset Splits
{Same format as Main Experiments; if identical, reference that section directly}

#### 3.2 Ablation Variants

| Variant | Modification | Purpose |
|---------|-------------|---------|
| **Full model** | Complete model | — |
| w/o {Module A} | Remove {Module A}, replace with {fallback} | Validate effectiveness of {Module A} |
| w/o {Module B} | Remove {Module B} | Validate effectiveness of {Module B} |

> {Explain why these ablations are chosen: each ablation corresponds to one innovation, covering all core designs}

#### 3.3 Ablation Hyperparameters
{Same as Main Experiments; typically identical settings}

#### 3.4 Expected Results (placeholder)

| Variant | {Metric 1} | {Metric 2} | Notes |
|---------|-----------|-----------|-------|
| Full model | **?** | **?** | — |
| w/o {Module A} | ? | ? | Expected to drop |

### 4 Additional Experiments (optional)

> Include this section only when the method's properties require it. Common types: visualization analysis, robustness testing, efficiency comparison (FLOPs / inference latency), cross-dataset generalization.

#### 4.x {Experiment Name}

**Datasets**: {dataset split table in the same format as above}

**Comparison models**: {comparison model table in the same format as above}

> {Explain why this additional experiment is needed: what property it validates that the main experiments cannot}

---

## References

> IEEE format. All entries must be verified as real via web_search. Unverifiable entries get `[to verify]`.

1. {Last, F.}, et al., "{Full Title}," in *{Full Venue Name}*, vol. {v}, no. {n}, pp. {pp}, {year}.

> **Main work**: {what the paper does, ≤ 20 words}
> **Why cited**: {specific help for this idea, ≤ 20 words}
> **PDF**: `docs/papers/{full title}.pdf` / `[PDF unavailable]`
> **Verified text**: "{verbatim supporting sentence from PDF}" (Section {X.X}) / `⚠️ [low confidence: ...]`

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
