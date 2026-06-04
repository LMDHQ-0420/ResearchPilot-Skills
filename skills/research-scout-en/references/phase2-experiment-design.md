# Phase 2: Experiment Design

## Entry

Triggered by `/research step2`.

Precondition: `docs/idea_report.md` exists and contains `# Part I`, does NOT yet contain `# Part II`.

## Steps

### Step 1 — Read User Requirements

Check `docs/user_requirements.md` → `## Phase 2` section.
- If empty: prompt user to fill Phase 2 section, wait for `/research confirm`
- If filled: read and apply as constraints on experiment design

### Step 2 — Read Full idea_report.md

Read the complete file: method description, baselines, feasibility assessment.
Extract: innovation components, proposed baselines, hardware constraints from Phase 1 feasibility table.

### Step 3 — Retrieve Experiment Conventions from Literature

Search same-domain papers (last 3 years) to understand field norms.
Extract from 3–5 representative papers:

- Common datasets and their standard train/val/test split ratios
- Standard evaluation metrics and their precise computation formulas
- Typical ablation design patterns (which components are conventionally ablated)
- Standard baseline hyperparameter configurations
- Result table conventions (whether to report std dev, number of runs, significance tests)

Use these norms as baseline for experiment design — the resulting design should
feel natural to reviewers in this field, not idiosyncratic.

### Step 4 — Design Complete Experiment Plan

Combine user requirements + field conventions to design:
- Dataset selection (prefer user-specified; otherwise recommend based on field norms)
- Evaluation metrics (align with field conventions unless user specifies otherwise)
- Main experiment procedure with explicit hyperparameters
- Baseline configuration table
- Ablation study covering each innovation component
- Additional analysis if method warrants it (visualization, efficiency, robustness)

### Step 5 — Feasibility Verification (must pass before writing to file)

Check three items. If any fail: PAUSE and tell the user. Do NOT generate an
unexecutable experiment design.

**① Dataset availability**
- web_search each dataset's download link; confirm still accessible
- Confirm public access (some medical/industrial datasets require application)
- Confirm data volume matches proposed train/val/test split
- If restricted: suggest a publicly available alternative

**② Baseline code availability**
- web_search each baseline for a public code repository
- Confirm repo is accessible (not 404)
- Confirm framework compatibility (e.g., both PyTorch)
- If no public code: mark "needs self-implementation" and note estimated effort in config table

**③ Hardware feasibility**
- Estimate GPU memory: model parameters × batch size × dtype bytes × safety factor 1.5
- Compare against user's hardware declared in user_requirements.md Phase 2
- If estimated > available: suggest mixed precision training or batch size reduction

Prepend the following summary block to Part II before the main content:

```markdown
### Feasibility Verification Summary
| Item | Status | Notes |
|------|--------|-------|
| Dataset {name} | ✅ Available / ⚠️ Requires application / ❌ Unavailable | {link or note} |
| Baseline {name} code | ✅ Available / ⚠️ Needs self-impl / ❌ Unavailable | {repo or note} |
| GPU memory | ✅ OK / ⚠️ Needs adjustment | Est. {N}GB, user has {M}GB |
```

### Step 6 — Append Part II to idea_report.md

Append after the Phase 1 review checkpoint line.
Format: see `references/document-formats.md` → Part II template.

### Step 7 — Phase 2 Review Checkpoint

STOP and display:

```
docs/idea_report.md Part II appended. Please review the experiment design, then:
- /research step3  — confirm and enter coding
- /research revise "feedback"  — regenerate Part II with changes
```

Do not proceed until user runs step3 or revise.

## Handling revise in Phase 2

When user runs `/research revise "feedback"` while Part II exists:
1. Read the feedback
2. Re-run Steps 4–6 incorporating the changes
3. Replace the existing Part II content (keep the Part II header and feasibility summary)
4. Return to Phase 2 review checkpoint
