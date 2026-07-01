# Phase D Detailed Flow: Implementation Design

---

## Phase D: Implementation Design

> **user_requirements.md takes priority**: All constraints recorded in `docs/user_requirements.md` (framework, device, code style, hard requirements, etc.) take precedence over any default instruction in this file. Read that file before generating implementation.md to ensure all design decisions comply with user constraints.

### Trigger

Entered automatically after the user confirms the experiment design in Phase C.

---

### D-0 Collect Coding Constraints

Ask the user (if not already mentioned in conversation):

```
Before designing the implementation, confirm a few things:
1. Framework: PyTorch or something else?
2. Any special code requirements? (style, multi-GPU, ONNX export, etc.)
3. Any hard requirements?
```

Write the answers to `docs/user_requirements.md` Phase D section.

---

### D-1 Generate implementation.md

Generate `docs/implementation.md` following the format template below. Content must be precise to every function signature, parameters, return values, and implementation logic for every file.

---

### D-end1 Validation and Confirmation

After generating implementation.md, **immediately run the validation checks** (see "Validation Rules" below), then ask the user to confirm:

```
implementation.md has been generated and validation is complete.
Validation result: {passed / issues found: …}

Is the implementation plan detailed and complete enough?
If so, the next step is to confirm a few pre-coding items, then start coding.
Or is there anything you'd like to adjust?
```

After every user-requested revision, run validation again and append the result.

After implementation.md is confirmed, guide the user to Phase E:

```
implementation.md confirmed.

→ Use `/research[E]-coding` to start coding (the pre-coding checklist runs at the start of Phase E).
```


## implementation.md Format Spec

### General Rules

- Precise to every function: name, parameters (with type annotations), return value (with type), implementation logic
- Precise to every directory and file: what it stores, what it is responsible for
- Precise to every results file: filename, format, meaning and unit of each field
- Use `>` extensively to explain the rationale behind each design decision; cite references where applicable

---

### Format Template

````markdown
# Implementation Guide — {Topic}
> Generated: {YYYY-MM-DD} | Strategy: from scratch | Status: PENDING_REVIEW
> Linked experiment design: docs/idea_report.md Part 3

---

## 1 Project Structure

> This chapter is the key opening section of implementation.md: complete directory tree (1.1) followed by a per-file function table (1.2).

### 1.1 Complete Directory Tree

```text
code/
├── src/
│   ├── models/
│   │   ├── {model_name}.py         # proposed model (one file per model)
│   │   └── baseline/
│   │       ├── {baseline1}.py      # one file per baseline
│   │       └── {baseline2}.py
│   ├── data/                       # subdirectory when multiple data files; else src/dataset.py
│   │   ├── {dataset}_dataset.py    # Dataset class
│   │   └── transforms.py           # preprocessing / augmentation
│   ├── train/                      # subdirectory when multiple training files; else src/train.py
│   │   ├── trainer.py              # training loop
│   │   └── scheduler.py            # lr scheduler (if separate)
│   ├── evaluate/                   # subdirectory when multiple eval files; else src/evaluate.py
│   │   └── evaluator.py
│   ├── utils/
│   │   ├── metrics.py              # metric computation
│   │   └── logger.py               # logging utility
│   ├── train.py                    # training entry point (called by scripts/train.sh)
│   ├── evaluate.py                 # evaluation entry point
│   └── predict.py                  # inference entry point (optional)
├── scripts/
│   ├── train.sh                    # nohup training, logs → logs/
│   ├── evaluate.sh                 # nohup evaluation
│   └── ablation.sh                 # nohup batch ablation
├── configs/
│   ├── default.yaml                # all hyperparameters centralized here
│   └── ablation_{variant}.yaml     # one config per ablation variant
├── data/                           # if preprocessing produces intermediate files: raw/ + processed/
│   ├── raw/                        # original downloaded data (when preprocessing exists)
│   └── processed/                  # preprocessed data (when preprocessing exists)
│   # if no intermediate data is produced, store files directly in data/ without subdirectories
├── results/                        # gitignored
├── logs/                           # gitignored; filename: YY-MM-DD_HH-MM-SS.log
├── README.md
└── requirements.txt
```

> **Directory rules**:
> - If there is only one proposed model under `src/models/`, place it directly as `{model_name}.py` without a subdirectory
> - `src/data/`, `src/train/`, `src/evaluate/`: if only one file, place it directly under `src/` without a subdirectory
> - `data/`: if the pipeline produces intermediate files, use `raw/` + `processed/`; otherwise store data directly in `data/`

### 1.2 Per-File Function Table

> One row per file (not per directory). As many rows as there are files.

| File | Function | Input | Output | Called by |
|------|----------|-------|--------|-----------|
| `src/models/{model_name}.py` | {role} | {input} | {output} | `src/train.py` |
| `src/models/baseline/{baseline1}.py` | {role} | {input} | {output} | `src/train.py` |
| `src/data/{dataset}_dataset.py` | {role} | {input} | {output} | `src/train.py` |
| `src/train.py` | {role} | {input} | {output} | `scripts/train.sh` |
| `src/evaluate.py` | {role} | {input} | {output} | `scripts/evaluate.sh` |
| `src/utils/metrics.py` | {role} | {input} | {output} | `src/train.py`, `src/evaluate.py` |
| `configs/default.yaml` | centralize hyperparameters | — | — | all modules via config |
| ... | ... | ... | ... | ... |

**Directory-level constraints**:

| Path | Key constraint |
|------|---------------|
| `src/models/` | structure only, no training loop |
| `src/models/baseline/` | identical input/output interface as the main model |
| `src/data/` | data handling only, no model logic |
| `src/utils/` | stateless utility functions |
| `scripts/` | parameter assembly and nohup invocation only, no business logic |

---

## 2 Data Flow

Complete path from raw data files to model input:

```text
data/raw/{dataset_name}/ (or data/{dataset_name}/)
  → load and parse ({dataset_file.py})
      {format, field extraction, missing value handling}
  → preprocessing (if any): output to data/processed/{dataset_name}/
      {preprocessing steps}
  → split (train / val / test)
      {split strategy: official / chronological / random; ratio; cite Part 3}
  → normalization (transforms.py)
      {mean/std from training set, applied to all splits}
  → sliding window / chunking / sampling (if applicable)
      {window size, stride, label extraction; cite Part 3}
  → model input Tensor
      x: shape {[B, ?, ?]}, meaning: {dimension description}
      y: shape {[B, ?]}, meaning: {description}
```

> {Key decisions in data flow design: why this split, why this normalization}

---

## 3 Per-File Implementation Details

> For every function: signature, parameter meanings, return value semantics, implementation logic (prose steps, no code).
> Reading order: data → model → baseline → loss → training loop → evaluation → utils → scripts

### 3.1 `src/data/{dataset}_dataset.py`

**Responsibility**: load {dataset name}, preprocess, return model-ready tensors.

**`{DatasetName}(Dataset)`**

- Init parameters:
  - `data_path` (str): dataset root directory
  - `split` (str): "train" / "val" / "test"
  - `{other}` ({type}): {meaning, valid range}
- Init logic:
  1. Read raw file ({format: csv / mat / hdf5})
  2. Split by {strategy} ({rationale, cite Part 3})
  3. {normalization / sliding window / other preprocessing}
- `__len__() -> int`: total samples, computed as: {description}
- `__getitem__(idx) -> tuple[Tensor, Tensor]`:
  - Returns `(x, y)`, x shape: {[?, ?]}, y shape: {[?]}
  - Extraction: {window start/end, label extraction}

---

### 3.2 `src/models/{model_name}.py`

**Responsibility**: define the proposed model architecture.

**`{ModelName}(nn.Module)`**

- Init: `input_dim` (int), `hidden_dim` (int, default {N}), `{other}`
- `forward(x: Tensor) -> Tensor`:
  - Input x: shape `[B, L, D]`
  - Logic:
    1. Through {module A}: {what it does, shape change}
    2. Through {module B}: {description}
    3. Prediction head: {description}
  - Output shape: `[B, {output_dim}]`

---

### 3.3 `src/models/baseline/{baseline_name}.py`

**Responsibility**: reproduce {baseline name} with an interface identical to the main model.

- `__init__` signature matches the main model
- `forward(x: Tensor) -> Tensor` input/output format matches the main model
- Implementation: {describe the core approach of this baseline}

> Identical interface rationale: enables direct model replacement in `src/train.py` without modifying training code.

---

### 3.4 `src/train.py` (or `src/train/trainer.py`)

**Responsibility**: training/validation loop with early stopping, lr scheduling, checkpoint saving.

**`Trainer`**

- Init: `model`, `train_loader`, `val_loader`, `config` (from yaml)
- `train_one_epoch() -> float`: returns mean training loss
- `validate() -> tuple[float, dict]`: returns `(val_loss, {metric: value})`
- `fit() -> None`: epoch loop → train + validate → early stopping → save best checkpoint

---

### 3.5 `src/utils/metrics.py`

**Responsibility**: compute evaluation metrics; all functions accept numpy arrays and return float.

| Function | Metric | Formula | Range | Direction |
|----------|--------|---------|-------|-----------|
| `{metric1}(pred, true)` | {name} | {formula} | {range} | lower/higher is better |

---

### 3.6 `configs/default.yaml`

All hyperparameters centralized here, grouped by: `data`, `model`, `training`, `logging`.

| Parameter | Section | Default | Rationale |
|-----------|---------|---------|-----------|
| `data.seq_len` | data | {N} | {cite Part 3} |
| `model.hidden_dim` | model | {N} | {rationale} |
| `training.lr` | training | {float} | {rationale} |
| `training.batch_size` | training | {N} | {GPU memory or field convention} |
| `training.patience` | training | {N} | {early stopping rationale} |

> Ablation experiments copy this as `configs/ablation_{variant}.yaml` and pass it via `--config`.

---

### 3.7 `scripts/train.sh`

```bash
#!/bin/bash
TIMESTAMP=$(date +"%y-%m-%d_%H-%M-%S")
LOG_FILE="logs/${TIMESTAMP}.log"
mkdir -p logs

nohup python src/train.py \
    --config configs/default.yaml \
    --gpu 0 \
    > "$LOG_FILE" 2>&1 &

echo "Training started. PID: $! | Log: $LOG_FILE"
```

`evaluate.sh` and `ablation.sh` follow the same nohup pattern, calling `src/evaluate.py` and looping over configs respectively.

---

## 4 Data Download and Preparation

### 4.1 Datasets

| Dataset | Type | Source | Download link | Storage path |
|---------|------|--------|--------------|--------------|

### 4.2 Download Steps

```bash
mkdir -p data/raw/{dataset_name}
{download command}
```

### 4.3 Directory Structure After Download

```text
data/
├── raw/
│   └── {dataset_name}/
│       ├── {file1}    # {format description}
│       └── ...
└── processed/         # auto-generated after preprocessing (if applicable)
```

If no preprocessing is needed, store directly:
```text
data/
└── {dataset_name}/
    ├── {file1}    # {format description}
    └── ...
```

---

## 5 Results File Format Spec

### 5.1 Model Weights `results/checkpoints/best.pth`

- **Format**: PyTorch state_dict
- **Load**: `torch.load('results/checkpoints/best.pth', map_location='cpu')`
- **Content**: model parameters at the best validation epoch

### 5.2 Training Logs `logs/YY-MM-DD_HH-MM-SS.log`

Each `scripts/train.sh` run auto-generates a timestamp-named log file containing the full stdout/stderr of the training process.

### 5.3 Evaluation Results `results/eval_{timestamp}.json`

| Field | Type | Unit | Meaning | Direction |
|-------|------|------|---------|-----------|
| {metric1} | float | {unit} | {meaning} | lower is better |
| num_samples | int | — | test set size | — |
| dataset | str | — | dataset name | — |
| split | str | — | evaluation split | — |
| checkpoint | str | — | weight path used | — |

### 5.4 Per-Sample Predictions `results/predictions_{timestamp}.csv`

| Field | Type | Unit | Meaning |
|-------|------|------|---------|
| sample_id | int | — | index in test set |
| {true_col} | float | {unit} | ground truth |
| {pred_col} | float | {unit} | model prediction |
| abs_error | float | {unit} | absolute error = |pred - true| |

### 5.5 Ablation Summary `results/ablation/summary.csv`

| Field | Meaning |
|-------|---------|
| variant | variant name, maps to configs/ablation_{variant}.yaml |
| {metric1} | metric on test set |
| notes | variant description |

---

## 6 Implementation Order

```
requirements.txt
  → configs/default.yaml (and ablation configs)
  → README.md (draft: project overview + env setup; run commands filled in as code completes)
  → src/data/ (Dataset class + transforms)
  → src/models/{model_name}.py (core innovation module first, then assemble full model)
  → src/models/baseline/ (each baseline, interface identical to main model)
  → src/train.py (or src/train/trainer.py)
  → src/utils/metrics.py + logger.py
  → src/evaluate.py
  → src/predict.py (if needed)
  → scripts/ (complete README.md run commands)
```

After completing each file, immediately update `docs/dev_log.md` progress and add a log entry; update `README.md` if run commands or env are affected.
`✅ Done` may only be marked after the file is written **and** verified to run without errors (under user-run strategy: mark after user confirms it passes).
````
