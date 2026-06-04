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

After generating implementation.md, proactively ask for confirmation:

```
implementation.md has been generated. Do you think the implementation plan is detailed and complete enough?
If so, the next step is to download the dataset and then start coding.
Or is there anything you'd like to add or adjust?
```

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

## implementation.md Format Specification

### General Rules

- Precise down to every function: function name, parameters (with type annotations), return value (with type), specific implementation logic
- Precise down to every directory and file: what it stores, what its responsibility is
- Precise down to every results file: filename, format, the meaning and units of every field
- Use `>` extensively to explain the rationale behind each design decision
- Use `>>` to mark design decisions backed by literature, with the original text attached

---

### Strong Baseline Format Template

````markdown
# Implementation Guide — {Topic}
> Generated: {YYYY-MM-DD} | Strategy: Strong Baseline Improvement | Status: PENDING_REVIEW
> Original project: {repo_url}
> Linked experiment design: docs/idea_report.md Part 3

---

## 1 Original Project Information

### 1.1 Project Overview
- **Name**: {project_name}
- **Link**: {GitHub URL}
- **Commit**: {hash} (pinned version to avoid upstream changes)
- **Framework**: {PyTorch x.x / other}
- **Original functionality**: {one paragraph describing what the original project does}

### 1.2 Rewrite Scope Overview

| File | Action | Reason for rewrite |
|-----|------|---------|
| `{file1.py}` | `[MODIFIED]` | {reason} |
| `{file2.py}` | `[NEW]` | {reason} |
| `{file3.py}` | `[KEEP]` | No modification needed |
| `{dir/}` | `[KEEP]` | No modification needed |

> {Explain why the rewrite scope is divided this way: reuse existing implementation as much as possible, only modify parts directly related to the innovation}

---

## 2 Project Structure

### 2.1 Complete Directory Tree After Rewrite

```text
code/
├── {existing directory/file}    [KEEP]
├── {existing file.py}           [MODIFIED] — {one-line description of what changed}
├── {new file.py}                [NEW] — {one-line description of functionality}
├── data/                        [KEEP / new]
├── results/                     [new]
├── logs/                        [new]
└── requirements.txt             [MODIFIED] — added dependencies: {list}
```

### 2.2 New Directory Descriptions

| Directory/File | Contents |
|----------|---------|
| `data/` | Raw dataset files, organized by dataset name in subdirectories |
| `results/` | Experiment outputs: checkpoints, evaluation results, prediction files |
| `logs/` | Training log CSV files |

---

## 3 Existing Files: Details and Rewrite Plans

> This chapter describes the existing implementation of each file that needs modification, then gives the precise rewrite plan.

### 3.x `{file_to_modify.py}` [MODIFIED]

**File responsibility**: {one sentence}

#### Existing Implementation

**Existing class/function list:**

```python
class {ExistingClass}:
    def __init__(self, {params}):
        """Original docstring"""
        ...
    
    def {existing_method}(self, {params}) -> {return_type}:
        """Original docstring"""
        # Description of existing logic: {explain what this function currently does}
        ...
```

**Explanation of existing logic:**
{Describe the core logic of existing functions — no need to paste the full code, use prose + key code snippets}

#### Rewrite Plan

**Functions to rewrite:**

**`{method_to_modify}`:**

Original signature: `def {method_to_modify}(self, {original_params})`
New signature: `def {method_to_modify}(self, {new_params})`

Rewrite:
```python
def {method_to_modify}(self, {new_params}) -> {return_type}:
    # [MODIFIED] {describe what changed and why}
    {new key logic snippet}
    
    # [KEPT] {explain which logic remains unchanged}
    {preserved logic}
```

> {Why this change: design rationale, or theoretical support from literature}

>> {If the rewrite directly borrows from a paper, cite the source} [n]

**Functions to add:**

**`{new_method}` (new):**

```python
def {new_method}(self, {params}) -> {return_type}:
    """
    {functional description}
    
    Args:
        {param}: {type} — {meaning}
    Returns:
        {return_type}: {meaning}
    """
    # {implementation logic description}
    {key code snippet}
```

> {Why this new function is needed: which innovation component it implements}

---

### 3.x `{new_file.py}` [NEW]

**File responsibility**: {one sentence}

**Complete function list:**

#### `{ClassName}`

```python
class {ClassName}({BaseClass}):
    def __init__(self, {params: types}) -> None:
        """
        {class description}
        
        Args:
            {param}: {type} — {meaning, including value range}
        """
    
    def {method1}(self, {params: types}) -> {return_type}:
        """
        {method description}
        
        Args:
            {param}: {type} — {meaning}
        Returns:
            {type}: shape {[B, L, D]} — {meaning of each dimension}
        """
        # Implementation logic:
        # 1. {step 1}
        # 2. {step 2}
        # 3. {step 3}
```

> {Design rationale for each key step}

---

## 4 Data Download and Preparation

### 4.1 Datasets

| Dataset | Type | Source | Download link | Storage path |
|-------|------|------|---------|---------|

### 4.2 Download Steps

```bash
# {dataset name}
{specific download command}

# Extract (if needed)
{extraction command}

# Preprocessing (if a standard tool exists)
{preprocessing command}
```

### 4.3 Directory Structure After Download

```text
data/
└── {dataset_name}/
    ├── {file1}    # {description: format, content, row count/size}
    ├── {file2}    # {description}
    └── ...
```

### 4.4 Data Field Descriptions

| Field | Type | Unit | Meaning | Normal range |
|-----|------|------|------|---------|
| {field} | {type} | {unit} | {meaning} | [{min}, {max}] |

> {Explanation of field-specific domain concepts}

---

## 5 results File Format Specification

### 5.1 Model Weights `results/checkpoints/best.pth`

- **Format**: PyTorch state_dict
- **Loading**: `model.load_state_dict(torch.load('results/checkpoints/best.pth'))`
- **Contents**: Model parameters from the best validation epoch

### 5.2 Training Curves `logs/train_{timestamp}.csv`

```text
epoch, train_loss, val_loss, val_{metric1}, val_{metric2}, lr
1,     0.042,      0.038,    0.021,         0.031,         1e-3
```

| Field | Type | Meaning |
|-----|------|------|
| epoch | int | Current epoch number |
| train_loss | float | Training loss, lower is better |
| val_loss | float | Validation loss, lower is better |
| val_{metric1} | float | {metric name}, {unit}, {higher/lower} is better |
| lr | float | Current learning rate |

### 5.3 Evaluation Results `results/eval_{timestamp}.json`

```json
{
  "{metric1}": 0.018,
  "{metric2}": 0.026,
  "{metric3}": 2.3,
  "dataset": "{dataset_name}",
  "split": "test",
  "checkpoint": "results/checkpoints/best.pth"
}
```

| Field | Type | Unit | Meaning | Direction |
|-----|------|------|------|-------------|
| {metric1} | float | {unit} | {meaning} | lower is better |

### 5.4 Per-Sample Predictions `results/predictions_{timestamp}.csv`

```text
sample_id, {true_col}, {pred_col}, abs_error
0,         0.823,      0.817,      0.006
```

| Field | Type | Unit | Meaning |
|-----|------|------|------|
| sample_id | int | — | Test set sample index |
| {true_col} | float | {unit} | Ground truth label value |
| {pred_col} | float | {unit} | Model prediction value |
| abs_error | float | {unit} | Absolute error = \|pred - true\| |

> Sort by abs_error to locate samples with the largest model errors, and analyze which types of samples are hardest to predict.

### 5.5 Ablation Summary `results/ablation/summary.csv`

```text
variant,       {metric1}, {metric2}, notes
full_model,    0.018,     0.026,     full model
w/o_{moduleA}, 0.024,     0.033,     remove {module A}
w/o_{moduleB}, 0.021,     0.029,     remove {module B}
```

---

## 6 Implementation Order

{Order for strong baseline rewrite}

```
1. Confirm the original project runs correctly (run through the original training script)
   → Record original performance as the baseline

2. {Follow the rewrite scope table order, starting from the most core changes}
   → After modifying each file, run unit tests or a short training run to confirm no errors

3. Integrate all rewrites, run full training

4. Add comparison implementations in baselines/ (if any)

5. Add results/ output and logs/ logging functionality
```

After completing each file, immediately update the progress table in `docs/dev_log.md` and add a log entry.
````

---

### Build from Scratch Format Template

````markdown
# Implementation Guide — {Topic}
> Generated: {YYYY-MM-DD} | Strategy: Build from Scratch | Status: PENDING_REVIEW
> Linked experiment design: docs/idea_report.md Part 3

---

## 1 Project Structure

### 1.1 Complete Directory Tree

```text
code/
├── src/
│   ├── data/
│   │   ├── __init__.py
│   │   ├── {dataset}_dataset.py    # {one-line description}
│   │   └── transforms.py           # {one-line description}
│   ├── models/
│   │   ├── __init__.py
│   │   ├── {model_name}.py         # {one-line description}
│   │   └── losses.py               # {one-line description}
│   ├── trainers/
│   │   ├── __init__.py
│   │   └── trainer.py              # {one-line description}
│   └── utils/
│       ├── metrics.py              # {one-line description}
│       └── logger.py               # {one-line description}
├── scripts/
│   ├── train.sh
│   ├── evaluate.sh
│   └── ablation.sh
├── configs/
│   └── default.yaml
├── baselines/
│   └── {baseline_name}.py
├── data/                           # gitignored
├── results/                        # gitignored
├── logs/                           # gitignored
├── README.md
└── requirements.txt
```

### 1.2 Directory/File Responsibilities

| Path | Contents | Notes |
|-----|---------|------|
| `src/data/` | Dataset classes and preprocessing | All data-loading related code |
| `src/models/` | Model definitions and loss functions | Does not contain training logic |
| `src/trainers/` | Training and validation loops | Does not contain model definitions |
| `src/utils/` | Metric calculation and logging | Stateless utility functions |
| `scripts/` | Shell launch scripts | No business logic, only calls Python modules |
| `configs/` | Hyperparameter configuration | YAML format, all hyperparameters centralized here |
| `baselines/` | Baseline reproductions | Same interface as main model, for direct substitution |
| `data/` | Raw datasets | gitignored, not committed |
| `results/` | Experiment outputs | checkpoints, evaluation results, prediction files |
| `logs/` | Training logs | CSV format |

---

## 2 Per-File Detailed Implementation

> Precise down to every function: signature, parameters, return values, implementation logic.
> Reading order: data loading → model → loss → training loop → utils → scripts

### 2.1 `src/data/{dataset}_dataset.py`

**File responsibility**: Load {dataset_name} data, perform sliding window slicing, return tensors required by the model.

#### `{DatasetName}(torch.utils.data.Dataset)`

```python
class {DatasetName}(Dataset):
    def __init__(
        self,
        data_path: str,      # Dataset root directory
        split: str,          # "train" / "val" / "test"
        seq_len: int,        # Sliding window length
        stride: int,         # Sliding window stride
        normalize: bool = True  # Whether to normalize; mean and std computed from training set
    ) -> None:
```

> {Why these parameters are needed: rationale for seq_len and stride choices, citing Part 3 experiment parameter table}

```python
    def __len__(self) -> int:
        # Returns: (total_timesteps - seq_len) // stride + 1
```

```python
    def __getitem__(self, idx: int) -> tuple[torch.Tensor, torch.Tensor]:
        # Returns:
        #   x: [seq_len, feature_dim]  input sequence
        #   y: [1]                     label (value at the last timestep of the window)
        start = idx * self.stride
        x = self.data[start: start + self.seq_len]
        y = self.labels[start + self.seq_len - 1]
        return torch.tensor(x, dtype=torch.float32), torch.tensor([y], dtype=torch.float32)
```

> {Why the last timestep of the window is used as the label rather than the mean: explain alignment with task definition}

**Preprocessing pipeline** (executed in `__init__`):
1. Read raw data file ({format: csv / mat / hdf5})
2. Split by {split} ratio ({description: official split / chronological split, citing Part 3})
3. If `normalize=True`: compute mean and std from training set, apply to all splits

> {Basis for preprocessing approach: citing papers using the same preprocessing or field conventions}

---

### 2.2 `src/data/transforms.py`

**File responsibility**: Data augmentation and normalization transforms.

#### `Normalize`

```python
class Normalize:
    def __init__(self, mean: np.ndarray, std: np.ndarray) -> None:
        # mean, std: shape [feature_dim], computed from training set
    
    def __call__(self, x: np.ndarray) -> np.ndarray:
        # Returns: (x - mean) / (std + 1e-8)
        # +1e-8 to prevent division by zero
```

---

### 2.3 `src/models/{model_name}.py`

**File responsibility**: Define the main model `{ModelName}`, implement forward inference for {core mechanism}.

**Model architecture diagram**:
```text
Input [B, L, D]
  → {Module A (class name: ModuleA)}: {role}  → [B, L, D']
  → {Module B (class name: ModuleB)}: {role}  → [B, D']
  → Prediction head (nn.Linear)               → [B, 1]
```

#### `{ModelName}(nn.Module)`

```python
class {ModelName}(nn.Module):
    def __init__(
        self,
        input_dim: int,      # Input feature dimension
        hidden_dim: int,     # Hidden layer dimension, default 128
        num_layers: int,     # Number of {module} layers, default {N}
        dropout: float = 0.1 # Dropout probability
    ) -> None:
```

> {Rationale for hidden_dim and num_layers choices: citing Part 3 experiment parameter table or related papers}

```python
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        # x: [B, L, D] → pred: [B, 1]
        # Steps:
        # 1. {Module A}: {description}
        # 2. {Module B}: {description}
        # 3. Prediction head: Linear(hidden_dim, 1)
```

#### `{CoreModule}(nn.Module)` (core innovation module)

```python
class {CoreModule}(nn.Module):
    def __init__(self, dim: int, {other_params}) -> None:
        # {initialization logic description}
    
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        # x: [B, L, D] → out: [B, L, D]
        # Key steps:
        # 1. {step 1}
        # 2. {step 2}
```

> {Design rationale for each step, especially parts related to the innovation}

>> {If a step directly borrows from a paper, cite the source and attach the original text} [n]

**Parameter count estimate**: ~{N}M parameters
**VRAM estimate**: ~{N}GB at batch_size={B}

---

### 2.4 `src/models/losses.py`

**File responsibility**: Define the loss function used during training.

#### `{LossName}`

```python
def {loss_fn}(
    pred: torch.Tensor,   # [B, 1] predicted values
    target: torch.Tensor  # [B, 1] ground truth labels
) -> torch.Tensor:        # scalar
```

**Formula**:
$$
\mathcal{L} = {formula}
$$

> {Meaning of each symbol; why this loss function is chosen over MSE; literature basis}

---

### 2.5 `src/trainers/trainer.py`

**File responsibility**: Encapsulates the full training/validation loop, supports early stopping, learning rate scheduling, and checkpoint saving.

#### `Trainer`

```python
class Trainer:
    def __init__(
        self,
        model: nn.Module,
        train_loader: DataLoader,
        val_loader: DataLoader,
        config: dict              # from configs/default.yaml
    ) -> None:
        # Initialize from config: optimizer, scheduler, criterion, patience, etc.
```

**`train_one_epoch() -> float`**:
```python
    def train_one_epoch(self) -> float:
        # Returns: average training loss
        self.model.train()
        for batch_x, batch_y in self.train_loader:
            self.optimizer.zero_grad()
            pred = self.model(batch_x.to(self.device))
            loss = self.criterion(pred, batch_y.to(self.device))
            loss.backward()
            # {Is gradient clipping needed? clip_grad_norm_ threshold and rationale}
            self.optimizer.step()
        return avg_loss
```

**`validate() -> tuple[float, dict]`**:
```python
    def validate(self) -> tuple[float, dict]:
        # Returns: (val_loss, {metric_name: value})
        self.model.eval()
        with torch.no_grad():
            # Iterate over validation set, compute loss and all evaluation metrics
```

**`fit() -> None`**:
```python
    def fit(self) -> None:
        # epoch loop + early stopping
        # Early stopping logic:
        if val_loss < self.best_val_loss - self.min_delta:
            self.best_val_loss = val_loss
            self.patience_counter = 0
            self.save_checkpoint()
        else:
            self.patience_counter += 1
            if self.patience_counter >= self.patience:
                break
```

> {Rationale for patience and min_delta choices}

---

### 2.6 `src/utils/metrics.py`

**File responsibility**: Compute evaluation metrics; all functions accept numpy arrays and return float.

| Function | Metric | Formula | Range | Direction | Notes |
|-----|------|------|------|------|---------|
| `mae(pred, true)` | MAE | mean(\|pred-true\|) | [0,+∞) | lower is better | — |
| `rmse(pred, true)` | RMSE | sqrt(mean((pred-true)²)) | [0,+∞) | lower is better | more sensitive to large errors |
| `mape(pred, true)` | MAPE | mean(\|pred-true\|/true)×100% | [0,+∞) | lower is better | unstable when true≈0 |

> {Field conventions for each metric, citing papers using the same metrics}

---

### 2.7 `src/utils/logger.py`

**File responsibility**: Unified management of training logs, writes to CSV, with optional wandb/tensorboard support.

**`Logger.log(epoch: int, metrics: dict) -> None`**:
Writes all metrics for the current epoch to `logs/train_{timestamp}.csv`.

---

### 2.8 `configs/default.yaml`

```yaml
data:
  dataset: {dataset_name}
  data_dir: data/
  seq_len: {N}       # {rationale: citing Part 3 or field convention}
  stride: {N}        # {rationale}
  train_ratio: 0.7
  val_ratio: 0.1
  test_ratio: 0.2

model:
  name: {model_name}
  input_dim: {N}
  hidden_dim: {N}    # {rationale}
  num_layers: {N}    # {rationale}
  dropout: 0.1

training:
  epochs: {N}
  batch_size: {N}    # {rationale: VRAM constraints or field convention}
  lr: {float}        # {rationale: citing paper or tuning experience}
  optimizer: adamw
  scheduler: cosine
  patience: {N}
  min_delta: 1e-4
  seed: 42

logging:
  use_wandb: false
  log_dir: logs/
  result_dir: results/
```

> To change hyperparameters, only edit this file. Different experiments can be copied as `configs/{experiment_name}.yaml` and specified with `--config` at training time.

---

### 2.9 `scripts/train.sh`

```bash
#!/bin/bash
set -e
python -m src.trainers.trainer \
  --config configs/default.yaml \
  --gpu 0 \
  --seed 42
echo "Training complete, weights saved to results/checkpoints/best.pth"
```

### 2.10 `scripts/evaluate.sh`

```bash
#!/bin/bash
python -m src.evaluate \
  --config configs/default.yaml \
  --ckpt results/checkpoints/best.pth \
  --split test
```

### 2.11 `scripts/ablation.sh`

```bash
#!/bin/bash
# Ablation A1: remove {module A}
python -m src.trainers.trainer \
  --config configs/default.yaml \
  --ablation w/o_{moduleA}

# Ablation A2: remove {module B}
python -m src.trainers.trainer \
  --config configs/default.yaml \
  --ablation w/o_{moduleB}

# Summarize results
python -m src.utils.summarize_ablation \
  --result_dir results/ablation/
```

### 2.12 `baselines/{baseline_name}.py`

**File responsibility**: Reproduce the baseline method with an interface identical to the main model.

```python
class {BaselineName}(nn.Module):
    def __init__(self, input_dim: int, hidden_dim: int, ...) -> None:
        # Parameter signature kept identical to the main model
    
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        # x: [B, L, D] → pred: [B, 1]
        # Input/output format identical to the main model
```

> Reason for identical interface: allows direct model substitution in trainer.py, avoiding separate training code for each baseline.

---

## 3 Data Download and Preparation

### 3.1 Datasets

| Dataset | Type | Source | Download link | Storage path |
|-------|------|------|---------|---------|

### 3.2 Download Steps

```bash
mkdir -p data/{dataset_name}
{specific download command, e.g., wget / kaggle / manual download instructions}
```

### 3.3 Directory Structure After Download

```text
data/
└── {dataset_name}/
    ├── {file1}    # {format description, e.g.: CSV, one sample per row, {N} columns}
    ├── {file2}    # {description}
    └── ...
```

### 3.4 Data Field Descriptions

| Field | Type | Unit | Meaning | Normal range |
|-----|------|------|------|---------|
| {field} | {type} | {unit} | {meaning} | [{min}, {max}] |

> {Explanation of field-specific domain concepts}

---

## 4 results File Format Specification

### 4.1 Model Weights `results/checkpoints/best.pth`

- **Format**: PyTorch state_dict
- **Loading**: `torch.load('results/checkpoints/best.pth', map_location='cpu')`
- **Contents**: Parameter dictionary of the model at the best validation epoch

### 4.2 Training Curves `logs/train_{timestamp}.csv`

```text
epoch, train_loss, val_loss, val_{metric1}, val_{metric2}, lr
1,     0.042,      0.038,    0.021,         0.031,         1e-3
```

| Field | Type | Meaning |
|-----|------|------|
| epoch | int | Current epoch number, starting from 1 |
| train_loss | float | Average training set loss |
| val_loss | float | Average validation set loss |
| val_{metric1} | float | {metric name}, {unit}, {higher/lower} is better |
| lr | float | Current learning rate |

> Normal convergence curve: val_loss continuously decreases for the first N epochs, then levels off.
> If val_loss rises while train_loss is still decreasing, overfitting is occurring — try increasing dropout or reducing lr.

### 4.3 Evaluation Results `results/eval_{timestamp}.json`

```json
{
  "{metric1}": 0.018,
  "{metric2}": 0.026,
  "dataset": "{dataset_name}",
  "split": "test",
  "num_samples": {N},
  "checkpoint": "results/checkpoints/best.pth",
  "timestamp": "{YYYY-MM-DD HH:MM:SS}"
}
```

| Field | Type | Unit | Meaning | Direction |
|-----|------|------|------|------|
| {metric1} | float | {unit} | {meaning} | lower is better |
| num_samples | int | — | Total number of test set samples | — |

### 4.4 Per-Sample Predictions `results/predictions_{timestamp}.csv`

```text
sample_id, {true_col}, {pred_col}, abs_error
0,         0.823,      0.817,      0.006
1,         0.791,      0.804,      0.013
```

| Field | Type | Unit | Meaning |
|-----|------|------|------|
| sample_id | int | — | Sample index in the test set |
| {true_col} | float | {unit} | Ground truth label value |
| {pred_col} | float | {unit} | Model prediction value |
| abs_error | float | {unit} | Absolute error = \|pred - true\| |

> Usage: sort by abs_error descending to locate the hardest-to-predict samples; use sample_id to trace back to the original data.

### 4.5 Ablation Summary `results/ablation/summary.csv`

```text
variant,       {metric1}, {metric2}, notes
full_model,    0.018,     0.026,     full model (baseline)
w/o_{moduleA}, 0.024,     0.033,     remove {module A}
w/o_{moduleB}, 0.021,     0.029,     remove {module B}
```

| Field | Meaning |
|-----|------|
| variant | Variant name, corresponds to the --ablation parameter in ablation.sh |
| {metric1} | {metric 1 on test set} |
| notes | Variant description |

---

## 5 Implementation Order

```
requirements.txt
  → configs/default.yaml
  → README.md (draft, with placeholder run commands)
  → src/data/{dataset}_dataset.py
  → src/data/transforms.py
  → src/models/{model_name}.py (implement core module first, then assemble full model)
  → src/models/losses.py
  → src/trainers/trainer.py
  → src/utils/metrics.py
  → src/utils/logger.py
  → scripts/ (fill in README.md run commands when done)
  → baselines/{baseline_name}.py
```

After completing each file, immediately update the progress table in `docs/dev_log.md` and add a log entry.
`✅ Done` may only be marked after the file is written and verified to run locally without errors.
````

---

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
