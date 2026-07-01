# Phase E Detailed Flow: Coding

## Phase E: Coding


> **user_requirements.md takes priority**: All constraints in `docs/user_requirements.md` take precedence over any default instruction in this file. Read it before coding.

### Trigger

Entered automatically after the user confirms `implementation.md` and completes the pre-coding checklist (environment / device / dataset / run strategy / README location) in Phase D.

### E-0 Create README.md

Before coding formally begins, set up two artifacts that run through the whole phase:

**README.md** (placed where confirmed in D-Final-2 — project root or `code/`): must include
- **Project overview**: one paragraph on what the project does (from idea_report.md topic)
- **Environment setup**: based on the environment name and device requirements confirmed in D-Final-2, give create/activate commands; install PyTorch per the official guide (by CUDA version), the rest via `pip install -r requirements.txt`
- **Detailed run commands**: each command for training/evaluation/ablation/visualization (finalized once scripts are done)

> README is updated as coding progresses; env and run commands are filled in as soon as the matching code is done — no placeholders left behind.


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

### {YYYY-MM-DD HH:MM} — Project initialized
- **Completed**: {specific content}
- **Issues encountered**: {description, or "none"}
- **Solutions**: {description, or "none"}

## Known Issues
- [ ] {issue description}

## How to Run

> This chapter is fixed at the very bottom of dev_log.md and is the "run manual" for this code. List **every run command**; for each command, explain: the meaning of every parameter, what happens when it runs, and what it outputs (to which file/directory, in what format). Commands are filled in as the code progresses, and **every time the code changes, judge per E-2/E-6 whether this chapter needs syncing**.

### Environment setup
```bash
{commands to create/activate the environment}
```
> Note: {what this command does; prerequisites, e.g. PyTorch with matching CUDA already installed}

### {Command 1: e.g. Train}
```bash
{full run command, e.g. bash scripts/train.sh --config configs/default.yaml --gpu 0}
```
- **Parameters**:
  - `{--paramA}`: {meaning, range, default}
  - `{--paramB}`: {meaning, range, default}
- **What happens when it runs**: {step by step: what is read → what is done → training/eval process}
- **What it outputs**: {files/dirs produced and their formats, e.g. `results/checkpoints/best.pth` (best weights), `logs/train_{timestamp}.csv` (training curve)}

### {Command 2: e.g. Evaluate}
```bash
{full run command}
```
- **Parameters**: {meaning of each parameter}
- **What happens when it runs**: {}
- **What it outputs**: {}

### {Command 3: e.g. Ablation / Visualization …}
> Fill in every command in the format above: all training / evaluation / ablation / data preprocessing commands must be covered.
```

### E-2 Code Files in the Implementation Order from implementation.md

After completing each file, immediately sync:
1. Update the progress table in `dev_log.md` (`✅ Done`, fill in completion time)
2. Add a log entry in `dev_log.md`
3. If the file affects how the project runs or its environment, **sync `README.md`** (run commands / env notes)
4. If the file corresponds to a key step, **add the matching visualization cell in `notebooks/`**
5. **Automatically judge whether the "How to Run" chapter at the bottom of `dev_log.md` needs updating**: if this file adds/changes a run command, parameter, output file, or output format, immediately fill in or revise the corresponding entry in "How to Run" (command, meaning of each parameter, what happens when it runs, what it outputs); skip if not applicable

**After completing each module (data / model / training loop / utils / scripts), run one validation against implementation.md**:
- Check that implemented function signatures, parameters, and return values match the descriptions in implementation.md
- Check that tensor shapes in the data flow are as expected
- If any discrepancy is found, enter the "implementation.md error found" flow (see E-5)

**Follow the confirmed run strategy** (D-Final-2 item 4):
- "Claude auto-run" → run to verify right after writing; `✅ Done` only after a clean run
- "User runs" → do static checks (imports / syntax / shape reasoning), hand the run command to the user, mark `🔄 WIP`, and mark `✅ Done` only after the user reports a successful run
- "Mixed" → Claude runs fast scripts (minimal tests, data preprocessing); the user runs slow ones (full training, all ablations)

### E-3 requirements.txt Rules

- Library names only, no version numbers
- Must not contain `torch`, `torchvision`, `torchaudio`

### E-4 Encountering Blocking Issues

Stop immediately and prompt:
```
⚠️ Blocking issue: {specific problem}

Options:
- Tell me how to resolve it → fix directly and continue
- Need to revise the idea → we go back to Phase B (see the E-8 backtracking flow)
- Need to revise the experiment design → we go back to Phase C (see the E-8 backtracking flow)
- Need to revise the implementation plan → we go back to Phase D (see the E-8 backtracking flow)
```

> Any option that involves revising the idea / experiment design / implementation plan goes through the **E-8 backtracking flow** — never alter the design ad hoc at the coding site.

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

### E-6 When the User Requests Code Improvements

When the user requests code improvements (after or during coding), every change must **keep two documents in sync**:
1. **`README.md`**: if the change affects run commands, dependencies, project structure, or functionality, update the relevant section immediately
2. **`docs/dev_log.md`**: add a log entry recording the improvement's completed content, reason, and impact; and **automatically judge whether the "How to Run" chapter at the bottom needs updating** — if this change adds/modifies a run command, parameter, output file, or output format, revise the corresponding entry immediately; skip if not applicable

> Never change code without updating README and dev_log — all three must stay consistent. If the improvement adds a key step, also add the matching `notebooks/` visualization. **Every code change must judge whether the "How to Run" chapter of dev_log.md needs syncing.**

### E-7 Code Review (proactively, after all coding is complete)

Once all files are coded, Claude **proactively** reviews the entire codebase and reports to the user.

> **Review scope**: this is research code for **validating a paper idea**, not production engineering, so it **does not pursue engineering-grade strictness** (no fussing over naming style, over-abstraction, defensive edge cases, or micro-optimization). The review targets only two **hard lines**:
> 1. **The code runs** — dependencies, imports, paths, and entry scripts are correct; the main chain from data loading to training to evaluation runs end to end
> 2. **The logic is fully correct** — the implementation matches the method/experiment design in `idea_report.md`; tensor-flow shapes are self-consistent; loss/metric computation is correct; ablation switches actually take effect; no silent bugs

**Review checklist** (go through each, report real issues only):
- **Runnability**: imports complete, `requirements.txt` covers all libraries used, file paths match the config, script entries can invoke the right modules
- **Logical correctness**: the core innovation module's implementation matches the Method description; tensor shapes are self-consistent across the whole chain; loss inputs/outputs match; metric computation matches Part 3; each ablation variant's switch genuinely changes behavior
- **Data-flow closure**: data loading → preprocessing → model → loss → evaluation → results persistence — the whole chain connects
- **Consistency with design**: every Part 3 experiment has a runnable entry; results output fields are complete

**Report format after review**:
```
Code review complete (criteria: runnable + logically correct; not an engineering-grade strict review).

✅ Passed: {runnability / logical correctness / data-flow closure / consistency with design}
⚠️ Issues found:
1. {location}: {issue — why it breaks running or correctness} → suggestion: {fix}
2. ...

Shall I fix these as suggested? (dev_log will be synced after fixing)
```

- If an issue falls on either hard line — "won't run" or "logic error" → **must fix**; after user confirmation, fix it and sync README/dev_log per E-6
- If it's only style / engineering polish that doesn't affect running or correctness → do not change proactively; mention it in one line at most and leave it to the user
- When there are no issues, report honestly "review passed, code runs and logic matches the design" — do not fabricate issues

### E-8 Poor Experiment Results → Backtrack to Adjust the Idea / Experiment Design (full B/C/D chain)

> When it applies: **a design is found unworkable during coding** (E-4 / E-5), or **the experiment results are poor after the code runs**. Either case may require going back to adjust the idea and experiment design, which in turn touches both design documents `idea_report.md` and `implementation.md`. **Never patch around a design problem in code.**

**Step 1: Diagnose and confirm backtracking with the user (mandatory — confirm before acting)**

First report the experiment results / blocking situation honestly, give a diagnosis and a proposed backtracking scope, and wait for the user to confirm:
```
Current experiment results / blocking situation: {describe honestly, with key data from dev_log / results}

Diagnosis: {likely cause of poor results / unworkability}

Design documents to adjust and the corresponding phases to revisit (please confirm):
- [ ] The idea itself needs adjustment → back to Phase B, revise idea_report.md Part 2 (Method / pipeline / technical framework)
- [ ] The experiment design needs adjustment → back to Phase C, revise idea_report.md Part 3 (datasets / experiment list / baselines / metrics)
- [ ] The implementation plan needs adjustment → back to Phase D, revise implementation.md

Shall we backtrack with the scope above? You may add or remove parts to adjust.
```

**Step 2: Re-walk the full flow of the corresponding phase per the confirmed scope (not an in-place patch)**

After the user confirms, **re-run the existing flow of the corresponding phase** per the mapping below, still confirming with the user at each step:

| What to adjust | Phase to revisit | Document | Key requirement |
|---------------|------------------|----------|-----------------|
| Idea (technical framework / pipeline / Method) | Phase B (see `phase-research.md` B-1–B-4) | `idea_report.md` Part 2 | **Read literature extensively first** (see "Literature Reading Principle") before adjusting |
| Experiment design (data/experiments/baselines/metrics) | Phase C (see `phase-research.md` C-1–C-8) | `idea_report.md` Part 3 | Re-verify data and code availability, re-confirm the experiment outline |
| Implementation plan | Phase D (see D-0–D-final in this file) | `implementation.md` | Re-run the implementation.md verification rules |

> **Chain dependency**: adjustments usually propagate top-down — changing the idea (B) generally requires updating the experiment design (C) and implementation plan (D); changing the experiment design (C) generally requires updating the implementation plan (D). After backtracking to the topmost affected layer, **sync the affected downstream documents in order B→C→D** — do not change only the upstream and leave the downstream contradicting it.

**Step 3: Literature requirement (mandatory for every idea adjustment)**

Every idea adjustment must follow the "Literature Reading Principle": first read closely the literature already in `docs/papers/`; only when the existing literature cannot solve the current problem, re-run the paper download flow to add new papers.

**Step 4: Return to Phase E and continue coding**

After all design documents (`idea_report.md` / `implementation.md` as needed) are updated and confirmed by the user, return to Phase E, revise the code per the updated implementation.md, and add a backtracking entry to `dev_log.md` (reason, which documents were adjusted, which phases).
