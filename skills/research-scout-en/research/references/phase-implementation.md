# Phases D+E: Implementation Design and Coding

---

## Phase D: Implementation Design

### Trigger

Entered automatically after the user confirms the experiment design in Phase C.

---

### D-0 Ask Whether to Use a Strong Baseline

**Strong baseline** definition: improving on top of an existing open-source project, rather than building from scratch.

```
The Method section of idea_report.md Part 2 mentions a Baseline reference.
Is your implementation based on an existing open-source project, or built from scratch?

- If based on an existing open-source project (strong baseline), provide the GitHub link
- If building from scratch, just say so
```

Based on the user's answer, proceed down one of the two paths below:

---

### Path A: Strong Baseline (Improving on an Open-Source Project)

#### D-A1 Obtain the Open-Source Project

Ask the user how to obtain the code:

```
How would you like to get the code for {project_name}?

Option 1: I'll run git clone and clone the project into the code/ directory
Option 2: I'll clone it myself and let you know when done
```

**If Claude runs git clone:**
```bash
git clone {repo_url} code/
```
Confirm the directory exists and files are complete after running.

**If the user clones it themselves:**
Wait for the user to finish, then:
```bash
ls code/
```
Confirm the directory exists before continuing.

If the clone fails or the directory does not exist, prompt the user to check the link or permissions.

#### D-A2 Read the Existing Project Structure

Fully scan the `code/` directory:
- List all files and directories
- For each Python file, extract:
  - All class definitions (class name, inheritance)
  - All functions/methods (function name, parameter list, return type, docstring)
  - Key dependencies (import statements)

#### D-A3 Collect Coding Constraints

Ask the user (if not already mentioned in conversation):
```
Before designing the rewrite plan, a few quick questions:
1. PyTorch version requirements? (compatible with the original project)
2. Which features of the original project need to be preserved? (all / specific features)
3. Any special code requirements? (style, multi-GPU support, etc.)
```
Write to `docs/user_requirements.md`.

#### D-A4 Generate implementation.md (Strong Baseline Format)

Generate `docs/implementation.md` using the "Strong Baseline Format Template" below.
Content must be precise down to the specific rewrite plan for every function that needs modification.

---

### Path B: Build from Scratch

#### D-B1 Collect Coding Constraints

Ask the user (if not already mentioned in conversation):
```
Before designing the implementation, a few quick questions:
1. PyTorch or another framework?
2. Any special code requirements? (style, multi-GPU support, etc.)
```
Write to `docs/user_requirements.md`.

#### D-B2 Generate implementation.md (Build from Scratch Format)

Generate `docs/implementation.md` using the "Build from Scratch Format Template" below.
Content must be precise down to every function signature, parameters, return values, and implementation logic for every file.

---

### D-Final Data Download Guide + Confirmation

After generating implementation.md, **immediately run one experiment requirements check** (see "Validation Rules" below), then ask for confirmation:

```
implementation.md has been generated and the experiment requirements check is complete.
Check result: {passed / issues found: …}

Do you think the implementation plan is detailed and complete enough?
If so, the next step is to download the dataset and then start coding.
Or is there anything you'd like to add or adjust?
```

After each user-requested revision to implementation.md, run the check again and append the result to the revised output.

After the user confirms implementation.md, output the data download guide:

```
Implementation plan confirmed. Before starting to code, please download the dataset first:

---

**Dataset: {dataset_name}**
Download URL: {official link}
Download method:
  {specific commands or steps, e.g.:}
  wget {url} -O data/{filename}
  # or
  kaggle datasets download {dataset_id} -p data/

After extraction, place at: data/{dataset_name}/
Expected directory structure:
  data/{dataset_name}/
  ├── {file1}    # {description}
  ├── {file2}    # {description}
  └── ...

{If the field has a standard preprocessing tool, mention it here:}
Preprocessing tool: {project_name} {link}
Preprocessing command: {specific command}

Once the data download is complete, let me know and we'll start the coding phase.
```

Wait for the user to confirm data download is complete, then proceed to Phase E.

---

### implementation.md Validation Rules

After every generation or revision of implementation.md, Claude must run the following checks, fix any issues found, then continue:

**1. Experiment Requirements Coverage**
- Cross-check every experiment in `idea_report.md` Part 3 (main, ablation, additional) against implementation.md — is there a corresponding module/function for each?
- Does each ablation variant (w/o X) have a corresponding implementation entry (config flag or code branch)?
- Does the results output format capture all evaluation metrics required by Part 3?

**2. Logical Consistency**
- Are tensor shapes consistent across modules (output shape of one module = input shape of the next)?
- Does the loss function's input shape match the model's output shape?
- Is the metric computation consistent with the definitions in Part 3?

**3. Completeness**
- Does every file in the implementation order have a corresponding section in the file details?
- Does the baselines list cover all comparison models in Part 3?
- Is the data directory structure consistent with the data flow description?

Check result format:
```
Validation result:
✅ Experiment coverage: {passed / missing: …}
✅ Logical consistency: {passed / issues found: …}
✅ Completeness: {passed / missing: …}
```
Fix any failing items directly in implementation.md, then re-output the check result.

### General Rules

- Precise down to every function: function name, parameters (with type annotations), return value (with type), specific implementation logic
- Precise down to every directory and file: what it stores, what its responsibility is
- Precise down to every results file: filename, format, the meaning and units of every field
- Use `>` extensively to explain the rationale behind each design decision; include citation numbers for literature-backed decisions

---

### Strong Baseline Format Template

````markdown
# Implementation Guide — {Topic}
> Generated: {YYYY-MM-DD} | Strategy: Strong Baseline Improvement | Status: PENDING_REVIEW
> Original project: {repo_url}
> Linked design: docs/idea_report.md Part 3

---

## 1 Original Project Info

### 1.1 Project Overview

- **Name**: {project name}
- **URL**: {GitHub URL}
- **Commit**: {hash} (pinned to avoid upstream changes)
- **Framework**: {PyTorch x.x / other}
- **Original functionality**: {one paragraph describing what the project does}

### 1.2 Rewrite Scope Summary

| File/Directory | Action | Reason |
|---------------|--------|--------|
| `{file1.py}` | `[MODIFIED]` | {reason} |
| `{file2.py}` | `[NEW]` | {reason} |
| `{file3.py}` | `[KEEP]` | No changes needed |

> {Explain the rewrite boundary: reuse as much as possible, only modify what is directly tied to the innovation}

---

## 2 Data Flow

Complete path from raw data files to model input:

```text
Raw files (data/{dataset_name}/)
  → Read and parse ({dataset_file.py})
      {format, field extraction, missing value handling}
  → Split (train / val / test)
      {split method: official / chronological / random; ratio; cite Part 3}
  → Normalize ({transforms_file.py})
      {mean/std computed from train set, applied to all splits; or other normalization}
  → Window / chunk / sample (if applicable)
      {window size, stride, label extraction; cite Part 3}
  → Model input Tensors
      x: shape {[B, ?, ?]}, meaning: {dimension explanation}
      y: shape {[B, ?]}, meaning: {explanation}
```

> {Key decisions in the data flow: why this split method, why this normalization}

---

## 3 Existing Files: Rewrite Plans

> For each file to modify: describe the current core logic, then give the rewrite plan.

### 3.x `{file_to_modify.py}` [MODIFIED]

**File responsibility**: {one sentence}

**Current core logic**:
{Describe what the existing functions do in plain text — no code. Focus on parts relevant to the innovation.}

**Functions to rewrite:**

**`{method_to_modify}({params}) -> {return_type}`**

- What it currently does: {describe original logic}
- What it will do instead:
  1. {Step 1}
  2. {Step 2}
  3. {Step 3}
- Parameter changes: {added / removed / modified params and their meaning}
- Return value changes: {if changed, explain new semantics and shape}

> {Why this change: design rationale or literature support} [n]

**Functions to add:**

**`{new_method}({params}) -> {return_type}`** (new)

- Purpose: {one sentence}
- Parameters: `{param}` ({type}) — {meaning and constraints}
- Return: {type}, shape {[?]}, {meaning}
- Implementation logic:
  1. {Step 1}
  2. {Step 2}
  3. {Step 3}

> {Why this new function is needed: which innovation component it implements}

---

### 3.x `{new_file.py}` [NEW]

**File responsibility**: {one sentence}

**Functions/classes:**

**`{ClassName}`**

- Responsibility: {description}
- Init parameters: `{param}` ({type}) — {meaning and constraints}
- Key methods:

  **`{method1}({params}) -> {return_type}`**
  - Input: {description including shape}
  - Output: {description including shape}
  - Implementation logic:
    1. {Step 1}
    2. {Step 2}

  > {Rationale for key design decisions}

---

## 4 Data Download and Preparation

### 4.1 Datasets

| Dataset | Type | Source | Download | Storage Path |
|---------|------|--------|---------|-------------|

### 4.2 Download Steps

```bash
mkdir -p data/{dataset_name}
{specific download command}
```

### 4.3 Directory Structure After Download

```text
data/
└── {dataset_name}/
    ├── {file1}    # {format: file type, row count/size, content}
    ├── {file2}    # {description}
    └── ...
```

### 4.4 Data Field Reference

| Field | Type | Unit | Meaning | Normal Range |
|-------|------|------|---------|-------------|
| {field} | {type} | {unit} | {meaning} | [{min}, {max}] |

> {Domain-specific concept explanations}

---

## 5 Results File Format

### 5.1 Model Weights `results/checkpoints/best.pth`

- **Format**: PyTorch state_dict
- **Load**: `torch.load('results/checkpoints/best.pth', map_location='cpu')`
- **Content**: Model parameter dict from the best validation epoch

### 5.2 Training Curve `logs/train_{timestamp}.csv`

| Field | Type | Meaning |
|-------|------|---------|
| epoch | int | Epoch number, starting from 1 |
| train_loss | float | Average training loss |
| val_loss | float | Average validation loss |
| val_{metric1} | float | {metric name}, {unit}, {higher/lower is better} |
| lr | float | Current learning rate |

### 5.3 Evaluation Results `results/eval_{timestamp}.json`

| Field | Type | Unit | Meaning | Direction |
|-------|------|------|---------|-----------|
| {metric1} | float | {unit} | {meaning} | lower is better |
| num_samples | int | — | Total test set samples | — |
| dataset | str | — | Dataset name | — |
| split | str | — | Evaluation split | — |
| checkpoint | str | — | Weights path used | — |

### 5.4 Per-Sample Predictions `results/predictions_{timestamp}.csv`

| Field | Type | Unit | Meaning |
|-------|------|------|---------|
| sample_id | int | — | Sample index in test set |
| {true_col} | float | {unit} | Ground truth label |
| {pred_col} | float | {unit} | Model prediction |
| abs_error | float | {unit} | Absolute error = \|pred - true\| |

> Sort by abs_error descending to find the hardest samples; trace back to raw data via sample_id.

### 5.5 Ablation Summary `results/ablation/summary.csv`

| Field | Meaning |
|-------|---------|
| variant | Variant name, matches --ablation flag in ablation.sh |
| {metric1} | Metric 1 on test set |
| notes | Variant description |

---

## 6 Implementation Order

```
1. Confirm original project runs correctly (run original training script), record baseline performance
2. Follow rewrite scope table, start with the most core change
   → After each file, do a minimal runnable test to confirm no errors
3. Integrate all rewrites, run full training
4. Add baseline implementations in baselines/ (if any)
5. Add results/ output and logs/ logging
```

After completing each file, immediately update progress and add a log entry in `docs/dev_log.md`.
````

---

### Build from Scratch Format Template

````markdown
# Implementation Guide — {Topic}
> Generated: {YYYY-MM-DD} | Strategy: Build from Scratch | Status: PENDING_REVIEW
> Linked design: docs/idea_report.md Part 3

---

## 1 Project Structure

### 1.1 Full Directory Tree

```text
code/
├── src/
│   ├── data/
│   │   ├── {dataset}_dataset.py    # {one sentence: responsibility}
│   │   └── transforms.py           # {one sentence: responsibility}
│   ├── models/
│   │   ├── {model_name}.py         # {one sentence: responsibility}
│   │   └── losses.py               # {one sentence: responsibility}
│   ├── trainers/
│   │   └── trainer.py              # {one sentence: responsibility}
│   └── utils/
│       ├── metrics.py              # {one sentence: responsibility}
│       └── logger.py               # {one sentence: responsibility}
├── scripts/
│   ├── train.sh                    # Launch training
│   ├── evaluate.sh                 # Evaluate a checkpoint
│   └── ablation.sh                 # Batch ablation runs
├── configs/
│   └── default.yaml                # All hyperparameters here
├── baselines/
│   └── {baseline_name}.py          # Same interface as main model
├── data/                           # gitignored
├── results/                        # gitignored
├── logs/                           # gitignored
├── README.md
└── requirements.txt
```

### 1.2 Directory/File Responsibilities

| Path | Contents | Key Constraint |
|------|---------|---------------|
| `src/data/` | Dataset classes and preprocessing | Data only — no model logic |
| `src/models/` | Model definitions and loss functions | Structure only — no training loop |
| `src/trainers/` | Training and validation loop | Receives model as parameter |
| `src/utils/` | Metric computation and logging | Stateless utility functions |
| `scripts/` | Shell launch scripts | No business logic — only calls Python modules |
| `configs/` | Hyperparameter configs | YAML format; copy per experiment |
| `baselines/` | Baseline reimplementations | Identical interface to main model |

---

## 2 Data Flow

Complete path from raw data files to model input:

```text
Raw files (data/{dataset_name}/)
  → Read and parse ({dataset}_dataset.py)
      {format, field extraction, missing value handling}
  → Split (train / val / test)
      {split method: official / chronological / random; ratio; cite Part 3}
  → Normalize (transforms.py)
      {mean/std from train set, applied to all splits; or other method}
  → Window / chunk / sample (if applicable)
      {window size, stride, label extraction; cite Part 3}
  → Model input Tensors
      x: shape {[B, ?, ?]}, meaning: {dimension explanation}
      y: shape {[B, ?]}, meaning: {explanation}
```

> {Key decisions in the data flow: why this split, why this normalization}

---

## 3 File Implementation Details

> Each function: signature, parameter meaning, return value semantics, implementation logic (text steps — no code).
> Reading order: data → model → loss → training loop → utils → scripts → baselines

### 3.1 `src/data/{dataset}_dataset.py`

**File responsibility**: Load {dataset name} data, preprocess, return tensors for the model.

**`{DatasetName}(Dataset)`**

- Init parameters:
  - `data_path` (str): dataset root directory
  - `split` (str): "train" / "val" / "test"
  - `{other param}` ({type}): {meaning and constraints}
- Init logic:
  1. Read raw file ({format: csv / mat / hdf5})
  2. Split by {method} ({rationale, cite Part 3})
  3. {Normalize / window / other preprocessing}
- `__len__() -> int`: total sample count, computed as: {description}
- `__getitem__(idx) -> tuple[Tensor, Tensor]`:
  - Returns `(x, y)`, x shape: {[?, ?]}, y shape: {[?]}
  - Extraction: {window bounds, label extraction method}

> {Rationale for preprocessing decisions; cite papers or field conventions}

---

### 3.2 `src/data/transforms.py`

**File responsibility**: Normalization and augmentation transforms; stateless or carrying train-set statistics.

**`Normalize`**

- Init: accepts `mean`, `std` (shape `[feature_dim]`, computed from train set)
- `__call__(x) -> ndarray`: computes `(x - mean) / (std + 1e-8)`

> {Why +1e-8: prevents division by zero when std is zero}

**{Other transform classes (if any)}**: {brief description}

---

### 3.3 `src/models/{model_name}.py`

**File responsibility**: Define the main model; implement forward inference for {core mechanism}.

**Model structure**:
```text
Input [B, L, D]
  → {Module A (class name)}: {role} → [B, L, D']
  → {Module B (class name)}: {role} → [B, D']
  → Prediction head (Linear)        → [B, {output_dim}]
```

**`{ModelName}(nn.Module)`**

- Init parameters: `input_dim` (int), `hidden_dim` (int, default {N}), `{other}`
- `forward(x: Tensor) -> Tensor`:
  - Input x: shape `[B, L, D]`
  - Implementation logic:
    1. Through {Module A}: {what it does, output shape change}
    2. Through {Module B}: {description}
    3. Prediction head: {description}
  - Output shape: `[B, {output_dim}]`

> {Overall model design rationale, corresponding to idea_report.md Part 2 Method section}

**`{CoreModule}(nn.Module)`** (core innovation module)

- Init parameters: `{param}` ({type}) — {meaning}
- `forward(x: Tensor) -> Tensor`:
  - Input: shape `[B, L, D]`
  - Implementation logic:
    1. {Step 1: describe operation and output shape change}
    2. {Step 2}
    3. {Step 3}
  - Output: shape `[B, L, D]` (or changed shape)

> {Rationale for each key step, corresponding to Method 3.3 theoretical description}
> {If a step borrows from a paper, cite the source} [n]

**Parameter count estimate**: ~{N}M parameters
**VRAM estimate**: ~{N}GB at batch_size={B}

---

### 3.4 `src/models/losses.py`

**File responsibility**: Define the training loss function.

**`{loss_fn}(pred: Tensor, target: Tensor) -> Tensor`**

- Input: `pred` shape `[B, {dim}]`, `target` shape `[B, {dim}]`
- Output: scalar
- Formula: $\mathcal{L} = {formula}$
- Implementation logic: {step-by-step computation description}

> {Why this loss function over MSE; literature support} [n]

---

### 3.5 `src/trainers/trainer.py`

**File responsibility**: Encapsulate full training/validation loop with early stopping, LR scheduling, and checkpoint saving.

**`Trainer`**

- Init parameters: `model`, `train_loader`, `val_loader`, `config` (from yaml)
- Init logic: build optimizer, scheduler, criterion from config; initialize patience counter

**`train_one_epoch() -> float`**

- Returns: average training loss for this epoch
- Logic: iterate train_loader → forward → compute loss → backward → update params
- Gradient clipping: {whether clip_grad_norm\_ is needed, threshold and rationale}

**`validate() -> tuple[float, dict]`**

- Returns: `(val_loss, {metric_name: value})`
- Logic: model.eval() → no_grad → iterate val_loader → collect predictions → call metrics.py

**`fit() -> None`**

- Logic: epoch loop → train_one_epoch + validate → early stopping check → save best checkpoint
- Early stopping: val_loss shows no improvement for {patience} consecutive epochs (threshold {min_delta})

> {Rationale for patience and min_delta values}

---

### 3.6 `src/utils/metrics.py`

**File responsibility**: Compute evaluation metrics; all functions accept numpy arrays and return float.

| Function | Metric | Formula | Range | Direction |
|----------|--------|---------|-------|-----------|
| `{metric1}(pred, true)` | {name} | {formula} | {range} | {higher/lower} is better |
| `{metric2}(pred, true)` | {name} | {formula} | {range} | {higher/lower} is better |

> {Field conventions for these metrics; cite papers using the same metrics}

---

### 3.7 `src/utils/logger.py`

**File responsibility**: Manage training logs; append per-epoch metrics to CSV.

**`Logger.log(epoch: int, metrics: dict) -> None`**

- Appends all metrics for the current epoch to `logs/train_{timestamp}.csv`

---

### 3.8 `configs/default.yaml`

All hyperparameters here, organized by block: `data`, `model`, `training`, `logging`.

| Parameter | Block | Default | Notes |
|-----------|-------|---------|-------|
| `data.seq_len` | data | {N} | {rationale, cite Part 3} |
| `model.hidden_dim` | model | {N} | {rationale} |
| `training.lr` | training | {float} | {rationale} |
| `training.batch_size` | training | {N} | {VRAM constraint or field convention} |
| `training.patience` | training | {N} | {early stopping rationale} |

> Copy to `configs/{experiment_name}.yaml` for different experiments; specify with `--config`.

---

### 3.9 `scripts/`

**`train.sh`**: Call trainer with config path and GPU index.
**`evaluate.sh`**: Load a checkpoint, evaluate on test set, output eval json.
**`ablation.sh`**: Loop through ablation variants, consolidate results to `results/ablation/summary.csv`.

> Scripts contain no business logic — only parameter assembly and Python module calls.

---

### 3.10 `baselines/{baseline_name}.py`

**File responsibility**: Reimplement baseline method with identical interface to the main model.

- `__init__` parameter signature matches the main model
- `forward(x: Tensor) -> Tensor` input/output format identical to main model
- Implementation logic: {describe this baseline's core approach}

> Identical interface means the model can be swapped in trainer.py without any training code changes.

---

## 4 Data Download and Preparation

### 4.1 Datasets

| Dataset | Type | Source | Download | Storage Path |
|---------|------|--------|---------|-------------|

### 4.2 Download Steps

```bash
mkdir -p data/{dataset_name}
{specific download command}
```

### 4.3 Directory Structure After Download

```text
data/
└── {dataset_name}/
    ├── {file1}    # {format: file type, row count/size, content}
    ├── {file2}    # {description}
    └── ...
```

### 4.4 Data Field Reference

| Field | Type | Unit | Meaning | Normal Range |
|-------|------|------|---------|-------------|
| {field} | {type} | {unit} | {meaning} | [{min}, {max}] |

> {Domain-specific concept explanations}

---

## 5 Results File Format

### 5.1 Model Weights `results/checkpoints/best.pth`

- **Format**: PyTorch state_dict
- **Load**: `torch.load('results/checkpoints/best.pth', map_location='cpu')`
- **Content**: Model parameter dict from the best validation epoch

### 5.2 Training Curve `logs/train_{timestamp}.csv`

| Field | Type | Meaning |
|-------|------|---------|
| epoch | int | Epoch number, starting from 1 |
| train_loss | float | Average training loss |
| val_loss | float | Average validation loss |
| val_{metric1} | float | {metric name}, {unit}, {higher/lower is better} |
| lr | float | Current learning rate |

### 5.3 Evaluation Results `results/eval_{timestamp}.json`

| Field | Type | Unit | Meaning | Direction |
|-------|------|------|---------|-----------|
| {metric1} | float | {unit} | {meaning} | lower is better |
| num_samples | int | — | Total test set samples | — |
| dataset | str | — | Dataset name | — |
| split | str | — | Evaluation split | — |
| checkpoint | str | — | Weights path used | — |

### 5.4 Per-Sample Predictions `results/predictions_{timestamp}.csv`

| Field | Type | Unit | Meaning |
|-------|------|------|---------|
| sample_id | int | — | Sample index in test set |
| {true_col} | float | {unit} | Ground truth label |
| {pred_col} | float | {unit} | Model prediction |
| abs_error | float | {unit} | Absolute error = \|pred - true\| |

> Sort by abs_error descending to find the hardest samples; trace back to raw data via sample_id.

### 5.5 Ablation Summary `results/ablation/summary.csv`

| Field | Meaning |
|-------|---------|
| variant | Variant name, matches --ablation flag in ablation.sh |
| {metric1} | Metric 1 on test set |
| notes | Variant description |

---

## 6 Implementation Order

```
requirements.txt
  → configs/default.yaml
  → README.md (draft; run commands as placeholders)
  → src/data/{dataset}_dataset.py
  → src/data/transforms.py
  → src/models/{model_name}.py (implement core innovation module first, then assemble full model)
  → src/models/losses.py
  → src/trainers/trainer.py
  → src/utils/metrics.py
  → src/utils/logger.py
  → scripts/ (finalize README.md run commands after scripts are done)
  → baselines/{baseline_name}.py
```

After completing each file, immediately update progress and add a log entry in `docs/dev_log.md`.
`✅ Done` can only be marked after the file is written AND verified to run without errors locally.
````

## Phase E: Coding

### Trigger

Entered automatically after the user confirms `implementation.md` and completes the data download in Phase D.

### E-1 Create dev_log.md

```markdown
# Dev Log — {topic}
> Created: {YYYY-MM-DD} | Last updated: {YYYY-MM-DD}
> Linked implementation guide: docs/implementation.md

## Project Overview
| Item | Content |
|------|------|
| Research direction | {topic} |
| Implementation strategy | Build from scratch / Strong baseline rewrite: {project_name} |
| Framework | {PyTorch x.x} |

## Implementation Progress

| Module | File | Status | Completion time | Notes |
|------|------|------|---------|------|
| Initialization | requirements.txt, configs/, README.md | ⬜ TODO | — | |
| Data loading | src/data/ | ⬜ TODO | — | |
| Main model | src/models/{model}.py | ⬜ TODO | — | |
| Loss function | src/models/losses.py | ⬜ TODO | — | |
| Train loop | src/trainers/trainer.py | ⬜ TODO | — | |
| Utils | src/utils/ | ⬜ TODO | — | |
| Scripts | scripts/ | ⬜ TODO | — | |
| Baselines | baselines/ | ⬜ TODO | — | |

Status: ⬜ TODO / 🔄 WIP / ✅ Done (run-verified) / ❌ Blocked

## Dev Log

### {YYYY-MM-DD} — Project initialized
- **Completed**: {specific content}
- **Issues encountered**: {description, or "none"}
- **Solutions**: {description, or "none"}

## Known Issues
- [ ] {issue description}
```

### E-2 Code Files in the Implementation Order from implementation.md

After completing each file, immediately sync:
1. Update the progress table in `dev_log.md` (`✅ Done`, fill in completion time)
2. Add a log entry in `dev_log.md`

**After completing each module (data / model / training loop / utils / scripts), run one validation against implementation.md**:
- Check that implemented function signatures, parameters, and return values match the descriptions in implementation.md
- Check that tensor shapes in the data flow are as expected
- If any discrepancy is found, enter the "implementation.md error found" flow (see E-5)

### E-3 requirements.txt Rules

- Library names only, no version numbers
- Must not contain `torch`, `torchvision`, `torchaudio`

### E-4 Encountering Blocking Issues

Stop immediately and prompt:
```
⚠️ Blocking issue: {specific problem}

Options:
- Tell me how to resolve it → fix directly and continue
- Need to revise the experiment design → we go back to Phase C
- Need to revise the implementation plan → we go back to Phase D
```

### E-5 Implementation Error Found in implementation.md

If a logic error, description mismatch, or unimplementable design is found in implementation.md during coding, **do not silently work around it in code**. Follow this flow:

1. Stop coding the current file immediately
2. Report the issue to the user:
   ```
   ⚠️ Found an issue in implementation.md:

   **Location**: {section / function name}
   **Issue**: {specific description: logic error / mismatch with reality / design not implementable}
   **Impact**: {what will go wrong if this is not fixed}
   **Suggested fix**: {proposed change}

   May I update implementation.md according to the suggestion above?
   ```
3. Wait for user confirmation
4. After confirmation, **update implementation.md first**, then run the validation check (see "Validation Rules")
5. Once the check passes, update the code to match the revised implementation.md and resume coding
