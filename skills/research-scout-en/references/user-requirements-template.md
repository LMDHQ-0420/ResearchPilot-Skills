# user_requirements.md Template

This file is created by Claude at the start of Phase 1 if it does not exist.
Users fill it; Claude reads the relevant section before each phase.

**Rules:**
- Claude NEVER copies content from this file into `idea_report.md`, `dev_log.md`, or `code_guide.md`
- Main documents show results only; this file holds raw user inputs
- Users may append a `### Document Preferences` field to any phase section
- If a field is irrelevant, write "none" — do not leave blank

---

## Template

```markdown
# User Requirements — {Topic}
> Created: {YYYY-MM-DD} | Project: {project_name}
> Claude reads the relevant phase section before each phase begins.
> Fill fields with your requirements, or write "none" if not applicable.

---

## Phase 1: Literature & Idea Requirements
> Fill after confirming papers/topic. Guides candidate idea generation direction.

### Your understanding of this topic
{Your existing knowledge, judgment, or background about this research problem.
Free-form text — write as much or as little as you like.}

### Preferred research directions
{e.g., lightweight methods / interpretability / cross-domain generalization /
data efficiency / real-time inference / theoretical guarantees}

### Directions to avoid
{e.g., parallel work already exists that makes this redundant /
requires large-scale pretraining / depends on private or proprietary data}

### Other constraints
{e.g., must run on a single consumer GPU /
method needs to be deployable on embedded hardware}

### Document preferences (optional)
{e.g., full English / Chinese body + English headings (default) /
Introduction should be publication-ready detail, not a placeholder /
omit the Data Format section in code_guide.md}

---

## Phase 2: Experiment Design Requirements
> Fill before running /research-scout-en step2.

### Hardware
{GPU model and count, available VRAM.
Example: RTX 3090 × 1, 24GB VRAM}

### Time constraints
{Maximum acceptable training time per run.
Example: single training run must complete within 12 hours}

### Dataset preference
{Specify dataset names to use, or write "let Claude recommend"}

### Experiment emphasis
{Which aspects of the results matter most to you.
Example: focus on ablation A1 and A2 / emphasize efficiency comparison /
need cross-dataset generalization test}

### Other constraints
{Example: no pretrained weights / must support multi-GPU DDP /
results need statistical significance tests with std dev reported}

---

## Phase 3: Coding Requirements
> Fill before running /research-scout-en step3.

### Programming language
{Default: Python. Specify if different.}

### Framework
{Default: PyTorch. Options: TensorFlow / JAX / scikit-learn / other}

### Code style
{Example: readability-first / minimize third-party dependencies /
needs DDP multi-GPU support / ONNX export required}

### Based on existing project
{Provide local path or GitHub URL if modifying an existing codebase.
Write "from scratch" otherwise.}

### Other requirements
{Example: full README with detailed usage examples /
must be Windows-compatible / Docker support needed /
code should be beginner-friendly with extensive comments}
```

---

## How Claude Uses This File

### Phase 1
- Reads `## Phase 1` section before generating candidates
- Preferred directions → prioritize matching idea angles
- Directions to avoid → do not generate candidates in those directions
- Document preferences → applied to all document generation in this session

### Phase 2
- Reads `## Phase 2` section before designing experiments
- Hardware → used in feasibility verification (GPU memory check)
- Time constraints → informs batch size and epoch count recommendations
- Dataset preference → used directly; "let Claude recommend" triggers field-norm search
- Experiment emphasis → shapes ablation design and additional analysis choices

### Phase 3
- Reads `## Phase 3` section before designing project structure
- Framework → determines import style and training loop conventions
- Based on existing project → triggers Strategy A; Claude reads that project's structure
- Code style → applied throughout implementation
