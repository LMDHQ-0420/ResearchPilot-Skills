# Document Formats

Detailed format specifications for `idea_report.md`, `dev_log.md`, and `code_guide.md`.
Chapter presence and content volume follow `references/template-flexibility.md`.

---

## idea_report.md

### Markdown Symbol Semantics

| Symbol | Meaning | Constraints |
|--------|---------|------------|
| `#` | File title / Part dividers | Exactly 3: file title, `# Part I`, `# Part II` |
| `##` | Major sections | Semantic names; numbering optional |
| `###` | Sub-sections | Semantic names; count follows content |
| `>` | Explanatory annotation | Immediately after hard content; plain-language gloss of the paragraph above |
| `>>` | Source annotation | Immediately after borrowed ideas; must cite `[n]`; append verified source sentence |
| `⚠️ [low confidence: ...]` | Uncertainty marker | End of any insufficiently evidenced claim; register in Pending Verification |
| `` `code` `` | Inline | File names, function names, variable names, commands, field names |
| ` ```text ` | Data flow / structure diagrams | |
| ` ```python ` | Pseudocode | |
| `$$...$$` | Block equations | |
| `$...$` | Inline equations | |
| `**bold**` | First occurrence of key terms; method row values in tables | Max 5 words |
| `1.` ordered list | References section only | |
| `- [ ]` checkbox | Implementation strategy options | |
| `---` | Part divider; before each review checkpoint | Only these positions |
| HTML comments | FORBIDDEN in final output | |

### Part I Template

```markdown
# {Topic} Idea Report
> Project: {project_name} | Generated: {YYYY-MM-DD} | Phase: 1 | Status: PENDING_REVIEW
> Omitted: {chapter} — {reason}    ← include only if a chapter is omitted
> Extended: {chapter}              ← include only if a chapter is added

---
# Part I: Literature Survey & Idea

## Topic Overview

### Topic Description
{What this research direction is, what problem it solves, which field. One paragraph.}

### Development Timeline
{Continuous prose, ≥ 4 key milestones in chronological order. Each milestone cites
a representative paper. Format: Author et al. [n] proposed ..., solving ...}

### Key Works Worth Noting
{Works worth learning from — not necessarily SOTA. Include methodologically inspiring works.
One sub-section per paper.}

#### {Short name} ({Venue} {Year})
{Core contribution, academic style, 1–2 sentences}

>> Borrowing value: {specific help for this idea, 1 sentence} [n]

### Candidate Idea Selection
> Auto-generated in Phase 1. Selected idea marked [Selected]; others [Not adopted].

#### Idea {n}: {Title} `[Selected / Not adopted]`
- **Core**: {one sentence}
- **Angle**: method transfer / improvement / reformulation
- **Novelty**: {High/Medium} — closest: {paper} [n], difference: {specific difference}
- **Feasibility**: {High/Medium/Low} — main risk: {risk}
- **Self-critique**:
  - Novelty authenticity: {assessment}
  - Experiment validity: {assessment}
  - Baseline fairness: {assessment}

---

## Introduction

### Research Background
{Field importance and application value. Academic style.}

> {Plain-language explanation of the above paragraph}

### Limitations of Existing Methods
{Bullet points, each covering one class of methods with specific citations.}

> {Why these limitations matter in practice}

### Contributions
The main contributions of this paper are as follows:
- We propose ... (method level)
- We design ... (technical level)
- We demonstrate on ... datasets, achieving ...

> Note: third bullet is a placeholder in Phase 1; fill with actual numbers after experiments.

---

## Related Work

### Development Timeline
| Year | Work | Venue | Core Contribution | Limitation |
|------|------|-------|-----------------|-----------|
| {year} | {Author} et al. [n] | {Venue} | {≤ 15 chars} | {≤ 10 chars} |

### Recent Progress (last 2 years)
{One paragraph per paper: Title (Venue Year) [n]: method description. Key metric results.}

>> {Relationship to this idea: what design it inspired, or the target to surpass} [n]

### Research Gap
{Shared weakness of existing methods, leading to this paper's motivation. Academic style.}

> {One-sentence plain summary: where existing methods are stuck}

---

## Proposed Method

### Overview
{What the method does, then how. Academic style.}

> {Intuition: explain with analogy or everyday language}

```text
Input → [Module A: role] → [Module B: role] → Output
```

> Data flow: {text explanation of each arrow}

### {Component Name}
{Input/output definition, steps, equations}

$$
{equation}
$$

> {Plain explanation of each symbol's intuition}

>> {Source}: This design is inspired by [n], which ... This work extends it by ... [n]
>> Source text: "{verbatim sentence from PDF}" (Section {X.X})

### Novelty Summary
1. **{Innovation 1}**: {one sentence}
2. **{Innovation 2}**: {one sentence}

### Feasibility Assessment
| Dimension | Rating | Notes |
|-----------|--------|-------|
| Compute | Low/Medium/High | Est. {N}GB VRAM, ~{N}h/epoch |
| Implementation | {1wk/2wk/1mo} | Main complexity: {module} |
| Innovation risk | Low/Medium/High | {e.g., parallel work may overlap} |

---

## Baseline Plan

| Baseline | Source [n] | Venue/Year | Why chosen | Expected advantage of ours |
|---------|-----------|-----------|-----------|--------------------------|

---

## References

> IEEE format. All entries verified via web_search. Unverifiable entries get [to verify].

1. {Last, F.}, et al., "{Full Title}," in *{Full Venue Name}*, vol. {v}, no. {n}, pp. {pp}, {year}.

> **Main work**: {what the paper does, ≤ 20 chars}
> **Why cited**: {specific help for this idea, ≤ 20 chars}
> **PDF**: `docs/papers/{full title}.pdf` / `[PDF unavailable]`
> **Verified text**: "{verbatim supporting sentence}" (Section {X.X}) / `⚠️ [low confidence: ...]`

---

## Pending Verification
> Auto-maintained. Check off after manual verification.

- [ ] {claim} (Section {n} — reason: {PDF unavailable / no supporting text found / conflicting sources})

---

> ⚠️ **Phase 1 Review Checkpoint**
> - /research-scout-en step2  — confirm, enter experiment design
> - /research-scout-en revise "feedback"  — regenerate Part I
```

### Part II Template

Append after the Phase 1 review checkpoint:

```markdown
---
# Part II: Experiment Design
> Updated: {YYYY-MM-DD} | Phase: 2 | Status: PENDING_REVIEW
> User experiment requirements: see docs/user_requirements.md → ## Phase 2

### Feasibility Verification Summary
| Item | Status | Notes |
|------|--------|-------|
| Dataset {name} | ✅ Available / ⚠️ Requires application / ❌ Unavailable | {link} |
| Baseline {name} code | ✅ Available / ⚠️ Needs self-impl / ❌ Unavailable | {repo} |
| GPU memory | ✅ OK / ⚠️ Needs adjustment | Est. {N}GB, user has {M}GB |

---

## Experiment Overview

### Experiment Goals
{Core hypotheses to validate. Each corresponds to one innovation component.}

### Implementation Strategy
- [x] From scratch / [ ] Based on: {project/link}
  - If based on existing: modifications needed: {list}

### Environment
| Item | Config |
|------|--------|
| Python | {x.x} |
| Framework | {PyTorch x.x / TF x.x} |
| Hardware | {GPU model}, VRAM ≥ {N}GB |
| Estimated training | {N}h/epoch × {M} epochs |

### Reproducibility
All experiments use random seed `42` across `torch`, `numpy`, `random`.

### Datasets
| Dataset | Source | Size | Split | Preprocessing |
|---------|--------|------|-------|--------------|
| {name} | {link} | {N samples} | {ratio} | {steps} |

---

## Main Experiments

### Experiment Procedure
{Step-by-step: data prep → model init (lr, bs, optimizer, scheduler) →
training (epochs, early stopping) → evaluation → result logging}

### Baseline Configuration
| Baseline | Code source | Key hyperparams | Metrics | Est. train time | VRAM |
|---------|-------------|----------------|---------|----------------|------|

### Evaluation Metrics
| Metric | Formula | Expected (ours) | Expected (SOTA) | Direction |
|--------|---------|----------------|----------------|---------|
| {name} | {formula} | {estimate} | {lit value} | higher/lower is better |

### Expected Results (placeholder — fill via /research-scout-en log-results)
| Method | {Dataset} | {Metric1} | {Metric2} |
|--------|-----------|-----------|-----------|
| {Baseline} | — | — | — |
| **Ours** | — | **?** | **?** |

---

## Ablation Study

> Purpose: validate each innovation component independently.

| ID | Variant | Modification | Purpose | Dependency | Expected direction |
|----|---------|-------------|---------|-----------|-------------------|
| A1 | w/o {module} | Remove {module}, replace with {fallback} | Validate {module} | After main exp | {metric} drops |

---

## Additional Analysis
{Visualization, robustness test, efficiency comparison — include only if meaningful}

---

> ⚠️ **Phase 2 Review Checkpoint**
> - /research-scout-en step3  — confirm, enter coding
> - /research-scout-en revise "feedback"  — regenerate Part II
```

---

## dev_log.md

```markdown
# Dev Log — {project_name}
> Created: {YYYY-MM-DD} | Last Updated: {YYYY-MM-DD}
> Linked design: docs/idea_report.md (Phase 2, updated {date})

## Project Overview
| Item | Value |
|------|-------|
| Research direction | {topic} |
| Strategy | From scratch / Based on {project} |
| Code root | code/ |
| Design version | {Part II Updated date} |
| Language | Python |
| Framework | {PyTorch / TF / JAX} |
| User coding requirements | see docs/user_requirements.md → ## Phase 3 |

## Project Architecture

```text
code/
└── ... (matches confirmed structure exactly)
```

### Module Responsibilities
| File/Dir | Responsibility | Input | Output | Key deps |
|----------|---------------|-------|--------|---------|

## Model Architecture (optional — omit if no custom model)

### Overall Structure
```text
Input [B, L, D] → [Module A: role] → [Module B: role] → Output [B, 1]
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
Raw files → Dataset.__getitem__ → DataLoader(batch) → transforms → model input tensor
```

### Training Flow
```text
load config → init model/optimizer/scheduler → epoch loop:
  → train_one_epoch → validate → early_stopping check → save best_ckpt
```

### Inference Flow
```text
load best_ckpt → test DataLoader → forward → postprocess → compute metrics → save csv
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

## Known Issues & TODO (optional — add when issues arise)
- [ ] {issue}

---

> To revise experiment design: /research-scout-en back-to-step2 "reason"
> This dev_log will be prefixed with [ARCHIVED] and history preserved.
```

---

## code_guide.md

```markdown
# Project Implementation Guide — {Topic}
> Project: {project_name} | Created: {YYYY-MM-DD} | Last Updated: {YYYY-MM-DD}
> Linked design: docs/idea_report.md | Change log: docs/dev_log.md
> Omitted: {chapter} — {reason}    ← include only if a chapter is omitted

---

## Project Origin

### Strategy
{From scratch / Based on open-source project}

> {Reason for choosing this strategy}

### Original Project Info (Strategy A only)
- **Name**: {name}
- **URL**: {GitHub URL}
- **Commit**: {hash — pins the version used}
- **Scope of changes**: NEW: {list} | MODIFIED: {list} | KEPT: {list}

---

## Project Structure

### Full Directory Tree
```text
code/
└── ... (exact confirmed structure, with one-line comment per file)
```

### File Responsibilities
| File/Dir | Responsibility | Called by |
|----------|---------------|-----------|

---

## Launch Guide

### Train Main Model
```bash
bash scripts/train.sh
```

**Adjustable parameters** (edit in scripts/train.sh):
| Param | Default | Description |
|-------|---------|-------------|
| --config | configs/default.yaml | config file path |
| --seed | 42 | random seed |
| --gpu | 0 | GPU index |

**Output files**:
| File | Path | Content | How to read |
|------|------|---------|------------|
| Best weights | results/checkpoints/best.pth | best val epoch params | `torch.load(path)` |
| Training curve | logs/train_{ts}.csv | loss/metric per epoch | CSV, first col = epoch |

> {How to interpret the training curve: what normal convergence looks like,
> what warning signs look like}

### Evaluate
```bash
bash scripts/evaluate.sh --ckpt results/checkpoints/best.pth
```

**Output files**: {table with path, content, format, and field-level explanations}

> {How to read the evaluation JSON/CSV: what each field means, units, value ranges}

### Ablation Experiments
```bash
bash scripts/ablation.sh
```

Output: `results/ablation/summary.csv` — one row per variant, ready for paper table.

### Run Baseline
```bash
bash scripts/evaluate.sh --baseline {name} --ckpt {path}
```

---

## Each File Explained

> Read order: data loading → models → training loop → utils → scripts

### src/data/{dataset}_dataset.py

**Role**: {what this file does in one sentence}

**Key class**: `{ClassName}(torch.utils.data.Dataset)`

**Input**: {raw data file path and format}
**Output**: `(x, y)` — x: `[seq_len, feature_dim]`, y: `[1]`

**Core logic**:
```python
def __getitem__(self, idx):
    ...  # show only the non-obvious part
```

> {Explanation of any non-obvious design choices}

---

### src/models/{model_name}.py

**Role**: {what this file does}

**Input**: `x: Tensor [{batch}, {seq_len}, {feature_dim}]`
**Output**: `pred: Tensor [{batch}, 1]`

**Structure**:
```text
Input → [Module A: role] → [Module B: role] → Output
```

**Core logic**:
```python
def forward(self, x):
    ...
```

> {Plain explanation of non-obvious parts}

---

{one sub-section per remaining file, same pattern}

---

## Data Format (optional)

### Input Data

**Raw files**: `data/{dataset}/`

| Field | Type | Unit | Meaning | Normal range |
|-------|------|------|---------|-------------|

> {Domain-specific concepts a non-expert would need explained}

### Output Data

**Predictions** `results/predictions_{ts}.csv`:
```text
sample_id, true_val, pred_val, abs_error
0,         0.823,    0.817,    0.006
```

> {What each column means and how to spot patterns}

---

## FAQ (optional — add entries as issues arise during implementation)

### Q: {issue title}
**Cause**: {root cause}
**Fix**: {specific steps}

---

> Created at start of sub-phase 3a. Updated in sync with each completed module.
```
