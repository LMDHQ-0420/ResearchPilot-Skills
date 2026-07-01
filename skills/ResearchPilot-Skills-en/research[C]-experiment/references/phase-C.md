# Phase C Detailed Flow: Experiment Design

## Phase C: Experiment Design

### Trigger

Entered automatically after the user confirms the idea in Phase B.

> **Experiment design principle**: the first purpose of every experiment design is to **rigorously prove the effectiveness of the idea**, never trimming experiments to fit resources. Therefore **do not collect resource constraints (GPU/training time) before design**; instead, provide a resource estimate after the plan is complete (see C-6), for the user's reference only. Resources are not a design constraint.

### C-1 Deep-Read Baseline Papers and Code

Extract all selected baselines from the Method section of `idea_report.md` Part 2, present a deep-read plan to the user, and request confirmation:

```
Before designing experiments, I plan to deep-read the following baselines' papers and code repositories,
to understand how they design experiments and avoid an experiment design disconnected from field conventions:

| # | Baseline | Paper | GitHub | Purpose of deep-read |
|---|---------|-------|--------|---------------------|
| 1 | {name} | {title} [n] | {repo link or not found yet} | {one sentence: why read this — which method category it represents, or what's worth referencing in its experiment design} |
| 2 | {name} | ... | ... | ... |

Once confirmed, I will read each one and compile them into Part 3 Section 0.
```

Wait for user confirmation (they may add or remove items).

After confirmation, for each baseline:
1. Download the paper PDF (read directly if already in `docs/papers/`, otherwise fetch via the paper download logic)
2. Read the GitHub README and core training scripts (if the repo is accessible)
3. Extract from the paper and code:
   - Which datasets are used, and how they are split (ratio / official split / cross-validation)
   - Which experiments are designed (main, ablation, additional), and the purpose of each
   - Which models are compared, and the model-selection logic
   - Which evaluation metrics are used, and how they are computed
   - Key hyperparameter settings (batch size, lr, training epochs, etc.)

After extraction, present a summary to the user for confirmation, then proceed to C-2.

### C-2 Synthesize Field Experiment Conventions

Search papers from the same field in the past 3 years and, combined with the C-1 deep-read results, synthesize:
- Datasets commonly used across baselines (treated as the field's standard benchmarks)
- Evaluation metrics commonly used across baselines (treated as the field's standard metrics)
- Typical ablation design patterns (which components usually need ablation)
- Result table conventions (whether std is reported, whether results are averaged over multiple runs)

### C-3 Data & Code Availability Check

> Verify only "whether the experiments can be carried out" — i.e., whether the data and baseline code can be obtained; **do not check whether GPU/VRAM resources are sufficient** (resources are only estimated afterward in C-6, and are not a constraint).

Check two items (if either fails, pause and inform the user):
- **Dataset**: download link is accessible, data is publicly available (note the application process if access requires a request)
- **Baseline code**: repository is accessible, framework is compatible; if no code exists, note "needs self-implementation"

Write the availability summary at the end of Part 3 Section 0:
```markdown
### Data & Code Availability Summary
| Item | Status | Notes |
|------|--------|-------|
| Dataset {name} | ✅/⚠️/❌ | {explanation} |
| Baseline {name} code | ✅/⚠️/❌ | {explanation} |
```

### C-4 Propose an Experiment Outline and Confirm with the User

> Before writing the full content of Part 3, **first present an experiment outline and confirm it with the user interactively**. The outline is the skeleton; only after confirmation is it expanded into the full text — this avoids writing a pile of details on top of a wrong experimental framework.

Present the outline to the user, covering:

```
Before formally writing the experiment design, let's confirm the experiment outline:

**Datasets**: which datasets are planned (for the main experiment / additional experiments respectively), and why these.

**Experiment list and design logic**:
| # | Experiment | Type | Design intent (why designed this way; which point of the core method it supports) | # Models | Core baseline | Why chosen as core |
|---|-----------|------|------------------------------------------------------------------------------|----------|--------------|--------------------|
| 1 | Main experiment | Main | … | {N} | {model} | {why it's the core} |
| 2 | Ablation: w/o {module} | Ablation | … | {N} | — | — |
| 3 | {field-standard additional experiment} | Additional · mandatory | … | {N} | {model} | … |

**Optional extension experiments** (to fill out the workload, for you to choose):
- Option 1: {experiment name} — validates {property}, {one-sentence design intent}
- Option 2: {experiment name} — validates {property}, …
- Option 3: …
(List as many angles as possible; you can pick which to do)

Confirm the outline or tell me what to adjust; once you've selected the extension experiments, I'll expand it into the full Part 3.
```

Go back and forth with the user until the outline (including the selected extension experiments) is confirmed.

### C-5 Generate idea_report.md Part 3

Generate the full content using the Part 3 template in `references/document-formats.md`, based on the confirmed outline, appended to the end of `idea_report.md`.

- Section 0 (Baseline Experiment Survey) is filled directly from the C-1 deep-read results
- The experiment design from Section 1 onward builds on the field conventions synthesized in Section 0, expanded per the outline confirmed in C-4
- **Every experiment must fill in the "Why designed this way" field**, explaining its significance for supporting the core method
- **The Models Under Evaluation table must explain each model one by one**: its difference from the proposed method, the significance of inclusion, and the source paper (display only, not part of the selection decision); and identify the core baseline and its rationale
- Additional experiments are split into "field-standard (mandatory)" and "extension experiments (user-selected)"
- Annotate every experiment design decision with `>` to explain the rationale, including the citation number for decisions backed by paper evidence

### C-6 Provide a Resource Estimate After the Design Is Complete

Once the entire experiment plan is designed, provide a **resource estimate** based on model scale, data size, and the number of experiment groups, as reference information at the end of Part 3 (**for reference only, not a design constraint**):
```markdown
### Resource Estimate (reference)
| Experiment | Est. VRAM | Est. time per run | # Groups |
|-----------|-----------|-------------------|----------|
| Main experiment | ~{N}GB | ~{N} h/dataset | {N} |
| Ablation study | ~{N}GB | ~{N} h/variant | {N} |

> These are rough estimates; actual consumption depends on the specific implementation and hardware. If resources are limited, you may run the core experiments first and run in batches, without compromising the effectiveness proof.
```

### C-7 Ask for Confirmation After Each Output

```
Experiment design generated (with a resource estimate, for reference only). Is the experiment plan complete enough now?
If so, we can move into the implementation design phase and generate a detailed coding guide.
Or is there anything you'd like to adjust?
```

### C-8 Iterative Refinement (loop)

After the user proposes revisions, update Part 3 content and ask for confirmation again.
Once the user confirms, proceed to Phase D (see `references/phase-implementation.md`).
