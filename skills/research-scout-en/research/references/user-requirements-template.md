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

## Phase A: Direction Exploration Requirements
> Collected by Claude at Phase A start. Used to guide candidate idea generation.

### Understanding of this topic
{Extracted from user conversation: existing knowledge, judgment, or background}

### Preferred directions
{Extracted from user conversation: e.g., lightweight, interpretability, cross-domain generalization}

### Directions to avoid
{Extracted from user conversation: exclusions}

### Other constraints
{Extracted from user conversation: e.g., must run on single GPU}

### Document preferences
{Extracted from user conversation: language, detail level, etc. Default: Chinese body + English headings}

---

## Phase C: Experiment Design Requirements
> Collected by Claude before Phase C. Used to guide experiment design.

### Hardware
{Extracted from user conversation: GPU model, count, VRAM limit}

### Time constraints
{Extracted from user conversation: max training time per run}

### Dataset preference
{Extracted from user conversation: specified dataset or "let Claude recommend"}

### Experiment emphasis
{Extracted from user conversation: what aspects matter most}

### Other constraints
{Extracted from user conversation: additional experiment restrictions}

---

## Phase D: Implementation Design Requirements
> Collected by Claude before Phase D. Used to guide project structure and implementation.

### Programming language
{Extracted from user conversation. Default: Python}

### Framework
{Extracted from user conversation. Default: PyTorch}

### Code style
{Extracted from user conversation: style preferences}

### Based on existing project
{Extracted from user conversation: path or URL, or "from scratch"}

### Other requirements
{Extracted from user conversation: additional coding requirements}
```

---

## When Claude Collects Requirements

### Phase A (Direction Exploration)
If the user's input (topic string, --papers, or free-form description) does not include sufficient detail, Claude asks in conversation:

```
Before starting the literature search, a few quick questions (skip any that don't apply):
1. Do you have existing ideas or knowledge about this topic?
2. Any preferred directions? (e.g., lightweight, interpretability, cross-domain)
3. Anything you want to avoid?
4. Any other constraints? (e.g., must run on a single GPU)
```

If the user's input is already detailed enough, Claude extracts and writes directly — no questions asked.

### Phase C (Experiment Design)
Before generating Part 3, Claude asks in conversation:

```
Before designing experiments, a few quick questions:
1. What's your GPU setup? (model + VRAM)
2. Any time limit per training run?
3. Do you have a preferred dataset, or should I recommend based on field conventions?
4. Any particular emphasis for the experiments? (e.g., focus on ablation A1 and A2)
```

### Phase D (Implementation Design)
Before generating implementation.md, Claude asks in conversation:

```
Before designing the implementation, a few quick questions:
1. PyTorch or another framework?
2. Building on an existing open-source project? (if yes, share the link)
3. Any special code requirements? (e.g., multi-GPU DDP, ONNX export)
```
