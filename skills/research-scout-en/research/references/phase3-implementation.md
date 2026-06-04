# Phase 3: Code Implementation

## Entry

Triggered by `/research step3`.

Precondition: `docs/idea_report.md` exists and contains `# Part II`.

---

## Sub-phase 3a: Project Structure Design & Confirmation

### Step 1 — Read User Coding Requirements

Check `docs/user_requirements.md` → `## Phase 3` section.
- If empty: prompt user to fill Phase 3 section, wait for `/research confirm`
- If filled: read and apply (language, framework, existing project, style)

### Step 2 — Read Full idea_report.md

Extract: method modules, datasets, baselines, ablation components, metrics.
This drives file naming and module responsibility assignment.

### Step 3 — Choose Structure Strategy

**Strategy A — Based on existing open-source project:**

Condition: `user_requirements.md` Phase 3 "Based on existing project" field has a path or URL.

- Read the original project's directory tree
- Design a modification plan: label each file `[NEW]` / `[MODIFIED]` / `[KEEP]`
- Do NOT restructure the original directory hierarchy; only add on top of it

**Strategy B — Build from scratch (default):**

Use this standard layout. Add or remove sub-directories based on actual needs
(e.g., no `baselines/` if there is only one baseline that lives in `src/`).

```
code/
├── src/
│   ├── data/           # dataset loading and preprocessing
│   ├── models/         # model definitions and losses
│   ├── trainers/       # train/val loops
│   └── utils/          # metrics, logging, helpers
├── scripts/
│   ├── train.sh        # training launch (hyperparams as args)
│   ├── evaluate.sh     # evaluation script
│   └── ablation.sh     # ablation experiment runner
├── configs/
│   └── default.yaml    # all hyperparameters centralized here
├── baselines/          # baseline reimplementations
├── data/               # datasets — add to .gitignore
├── results/            # experiment outputs — add to .gitignore
├── logs/               # training logs — add to .gitignore
├── README.md
└── requirements.txt    # library names only; NO torch/torchvision/torchaudio; no version pins
```

### Step 4 — Show Structure and Request Confirmation

```
Structure strategy: build from scratch / based on {project name} (Strategy A)

code/
{rendered directory tree with one-line comment per file}

Confirm:  /research confirm
Adjust:   /research revise-structure "feedback"
```

Wait for `/research confirm` before proceeding to 3b.

---

## Sub-phase 3b: Code Implementation

### On Start

Simultaneously create two documents:

1. `docs/dev_log.md` — fill Project Overview table and Project Architecture section
2. `docs/code_guide.md` — fill "Project Origin" and "Project Structure" chapters;
   leave other chapters as `{placeholder — filled as modules complete}`

### First File: README.md

README.md must contain:

**Project intro**: one paragraph from idea_report.md topic description.

**Environment setup** (exact format, no deviation):

```markdown
## Environment Setup

```bash
# 1. Create conda environment
conda create -n {env_name} python={x.x}
conda activate {env_name}

# 2. Install PyTorch (choose based on your CUDA version)
# See: https://pytorch.org/get-started/locally/
# Example for CUDA 12.1:
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# 3. Install other dependencies
pip install -r requirements.txt
```
```

**Dataset preparation**: from idea_report.md Part II datasets section.

**Run commands**: from scripts/ (filled after scripts/ is complete — use placeholders initially).

### requirements.txt Rules

- List library names only — no version pins, no comments
- MUST NOT contain: `torch`, `torchvision`, `torchaudio`
- Example valid entries: `numpy`, `pandas`, `scikit-learn`, `wandb`, `tqdm`, `einops`

### Implementation Order

```
requirements.txt → configs/default.yaml → README.md → src/data/ → src/models/ →
src/trainers/ → src/utils/ → scripts/ → baselines/
```

### Per-file Sync Protocol

After completing EACH file, do three things simultaneously:

1. Update `dev_log.md` progress table: change status to `✅ Done`, fill completion date
2. Add a `dev_log.md` entry:
   ```markdown
   ### {YYYY-MM-DD} — {module name}
   - **Completed**: {what was implemented}
   - **Issues**: {problems encountered, or "none"}
   - **Solutions**: {how resolved, or "none"}
   ```
3. Add the corresponding sub-section in `code_guide.md` "Each File Explained" chapter

After completing `scripts/`: fill the "Launch Guide" chapter in `code_guide.md`.
After completing `src/data/`: fill the "Data Format" chapter in `code_guide.md` (if applicable per template-flexibility rules).

### Blocking Issues

If hitting an experiment-design-level problem (dataset inaccessible, metric undefined,
baseline interface incompatible, etc.): STOP immediately and display:

```
⚠️ Blocked: {specific problem}

This requires revisiting the experiment design.
Run /research back-to-step2 "{reason}" to roll back.
Or respond inline if the issue can be resolved without changing the design.
```

---

## Sub-phase 3c: Results Feedback Loop

Triggered by `/research log-results` at any point during or after coding.

### Steps

1. Prompt user to paste experiment output (metric values or log excerpt)

2. Fill actual results into Part II expected results table — replace `?` placeholders

3. Compare against "Expected (ours)" column:
   - Above expected by > 5%: `✅ exceeded +{diff}`
   - Within ±5%: `✅ as expected`
   - Below expected by > 5%: `⚠️ below expected -{diff}`

4. If main experiment below expected, show diagnosis:

```
Main experiment result is below expected. Likely causes:
1. {cause} (suggestion: {specific fix})
2. {cause} (suggestion: {specific fix})

Options:
- /research revise "adjustment"  — tweak hyperparameters or preprocessing
- /research back-to-step2 "reason"  — revise experiment design
- /research log-results  — continue recording next experiment
```

5. Add entry to `dev_log.md`:

```markdown
### {YYYY-MM-DD} — Results: {experiment name}
- **Actual**: {metric} = {value}
- **Expected**: {metric} = {expected value}
- **Assessment**: ✅ exceeded / ✅ as expected / ⚠️ below expected
- **Analysis**: {findings or conclusion}
```

---

## back-to-step2 Rollback

When user runs `/research back-to-step2 "reason"`:

1. Prepend to top of `dev_log.md`:
   ```markdown
   [ARCHIVED - {YYYY-MM-DD} - {reason}]
   ```
2. Change `Status` field in Part II header of `idea_report.md` to `REVISING`
3. Display:
   ```
   dev_log.md archived. Experiment design is now marked REVISING.
   Run /research revise "feedback" to update Part II.
   Then run /research step3 to re-enter coding with the revised design.
   ```
