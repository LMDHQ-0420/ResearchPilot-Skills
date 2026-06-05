# user_requirements.md Template

This file is created and maintained BY Claude through conversation. **Users never need to manually edit this file.**

At the start of each phase, if the user's input lacks sufficient detail, Claude asks targeted questions in the conversation. After the user responds, Claude writes the collected requirements into this file as constraints for the current phase.

**Rules:**
- This file is written and maintained by Claude, not by the user
- Claude never copies content from this file into `idea_report.md`, `implementation.md`, or `dev_log.md`
- Main documents show execution results only; this file stores raw collected requirements
- Users can state document preferences at any time in conversation; Claude updates the relevant field

---

## File Format

```markdown
# User Requirements — {Topic}
> Created: {YYYY-MM-DD} | Project: {project_name}
> Auto-filled by Claude based on conversation. No manual editing needed.

---

## Phase A: Direction Preferences
> Collected by Claude at Phase A start. Used to guide candidate idea generation.

### Preferred directions
{Extracted from user conversation: e.g., lightweight, interpretability, cross-domain generalization}

### Directions to avoid
{Extracted from user conversation: exclusions}

### Other constraints
{Extracted from user conversation: other directional restrictions}

### Document preferences
{Extracted from user conversation: language, detail level, etc. Default: Chinese body + English headings}

---

## Phase C: Hardware Constraints
> Record only hard constraints that materially affect the experiment plan. Do not record hyperparameter preferences.

### GPU constraint
{Extracted from user conversation: max GPU count and VRAM limit, e.g. "single A100 80G max"}

### Max training time per run
{Extracted from user conversation: time limit per run, leave blank if none}

---

## Phase D: Implementation Constraints
> Record only hard constraints that determine code structure.

### Based on existing project
{Extracted from user conversation: path or URL, or "from scratch"}

### Framework
{Extracted from user conversation. Default: PyTorch}

### Other hard requirements
{Extracted from user conversation: hard coding requirements only, e.g. "must support multi-GPU DDP", "needs ONNX export". Preference-level requirements are not recorded here.}
```

---

## When Claude Collects Requirements

### Phase A (Direction Exploration)
If the user's input does not include sufficient detail, Claude asks in conversation:

```
Before starting the literature search, a few quick questions (skip any that don't apply):
1. Any preferred directions? (e.g., lightweight, interpretability, cross-domain)
2. Anything you want to avoid?
3. Any other constraints?
```

If the user's input is already detailed enough, Claude extracts and writes directly — no questions asked.

### Phase C (Experiment Design)
Before generating Part 3, Claude asks in conversation:

```
Before designing experiments, two quick questions:
1. GPU constraint? (max count + VRAM, e.g. "single A100 80G")
2. Any time limit per training run?
```

### Phase D (Implementation Design)
Before generating implementation.md, Claude asks in conversation:

```
Before designing the implementation, a few quick questions:
1. PyTorch or another framework?
2. Building on an existing open-source project? (if yes, share the link)
3. Any hard requirements? (e.g., multi-GPU DDP, ONNX export)
```
