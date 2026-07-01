# Phase E Detailed Flow: Coding

## Phase E: Coding

> **user_requirements.md takes priority**: All constraints in `docs/user_requirements.md` take precedence over any default instruction in this file. Read it before coding.

> **dev_log.md is append-only**: Every code change must append a new log entry. Never overwrite or delete existing entries.

### Trigger

Entered automatically after the user confirms `implementation.md` in Phase D.

---

### E-0 Pre-Coding Checklist

**Before any coding begins**, confirm the following 6 items with the user (present all at once; user may answer item by item):

```
Implementation plan confirmed. Before coding, confirm a few things:

**1. Runtime Environment**
Which environment do you plan to use? What is its name?
  - I will look for an existing environment (e.g. `conda env list`):
    found → reuse directly; not found → I create one from requirements.txt.

**2. Device Requirements**
Any special device requirements? (e.g. CUDA version, cuDNN, Apple MPS, CPU-only, Python version)

**3. Dataset Preparation**
{Per dataset} "Dataset {name}": detected {already downloaded at data/{name}/ ✅ / not yet ❌}.
  - Not downloaded, fast (small / direct link) → I download it.
  - Not downloaded, slow (large / login / application required) → I give you the link and command:
    Link: {url}; Command: {cmd}; Place in: `data/raw/{name}/` (with preprocessing) or `data/{name}/` (direct use)

**4. Auto-Run After Coding**
Should I run the code automatically after writing?
  - Fast (seconds to minutes) → I run it to verify
  - Slow (hours to days) → you run it
  - Mixed → I run fast scripts; you run slow ones (full training, all ablations)
  Your choice?

**5. Git Repository**
Do you have an existing GitHub repository?
  - Yes → please provide the URL; push the whole project or just `code/`?
  - No → should I initialize a new one?
  Also: what is your git username and email? (for `git config`)

**6. README Location**
After all coding is done I will write a README.md (project overview, env setup, run commands).
Should it go in the {project root} or `code/` directory?

Confirm the above and I will start coding.
```

Write user answers to `docs/user_requirements.md` Phase E section (env name, device requirements, dataset handling, run strategy, git config, README location).

**Dataset handling**:
- Check whether each dataset already exists under `data/`
- Not downloaded, fast → download directly
- Not downloaded, slow → output instructions and wait:
```
**Dataset: {dataset_name}**
Download URL: {official link}
Command: {wget/kaggle/etc.}
Place in: `data/raw/{dataset_name}/` (with preprocessing) or `data/{dataset_name}/` (direct use)
Let me know when done.
```

**Git initialization** (if user has a repo or wants a new one):
```bash
git init
git config user.name "{username}"
git config user.email "{email}"
```

Create `.gitignore`:
```
# Datasets and large files
data/
# Model weights (may exceed 100 MB each)
results/checkpoints/
results/**/*.pth
results/**/*.pt
results/**/*.bin
results/**/*.ckpt
# CSV/JSON result files are tracked by default
# Logs
logs/
# Python
__pycache__/
*.pyc
.env
```

> **Large file check**: if any single file (dataset, weights, etc.) may exceed 100 MB, ask the user to confirm exclusion before pushing.

---

### E-1 Create dev_log.md

```markdown
# Dev Log — {topic}
> Created: {YYYY-MM-DD} | Last updated: {YYYY-MM-DD}
> Linked implementation guide: docs/implementation.md
> ⚠️ This file is append-only. Every code change must append a new log entry.

## Project Overview
| Item | Detail |
|------|--------|
| Research direction | {topic} |
| Implementation strategy | from scratch |
| Framework | {PyTorch x.x} |
| Git repository | {repo URL or "local"} |
| Push scope | {whole project / code/ only} |

## Implementation Progress

| Module | File | Status | Completed | Notes |
|--------|------|--------|-----------|-------|
| Init | requirements.txt, configs/ | ⬜ TODO | — | |
| Data loading | src/data/ | ⬜ TODO | — | |
| Main model | src/models/{model}.py | ⬜ TODO | — | |
| Baseline | src/models/baseline/ | ⬜ TODO | — | |
| Training | src/train.py (or src/train/) | ⬜ TODO | — | |
| Evaluation | src/evaluate.py (or src/evaluate/) | ⬜ TODO | — | |
| Utils | src/utils/ | ⬜ TODO | — | |
| Scripts | scripts/ | ⬜ TODO | — | |
| README | README.md | ⬜ TODO | — | written after all coding is done |

Status: ⬜ TODO / 🔄 WIP / ✅ Done (run-verified) / ❌ Blocked

## Dev Log

### {YYYY-MM-DD HH:MM} — Project initialized
- **Completed**: {details}
- **Issues**: {description, or "none"}
- **Solution**: {description, or "none"}

## Known Issues
- [ ] {description}

## How to Run

> This chapter is always at the bottom of dev_log.md — it is the "run manual" for this codebase. List every run command; for each command explain every parameter, what happens when it runs, and what it outputs (file/directory, format). Fill in commands as code progresses. **After every code change, check whether this chapter needs updating.**

### Environment Setup
```bash
{create/activate commands}
```
> Note: {what this does; prerequisites, e.g. PyTorch already installed for the right CUDA version}

### {Command 1: e.g. Training}
```bash
{full run command, e.g. bash scripts/train.sh --config configs/default.yaml}
```
- **Parameters**: `{--param}`: {meaning, range, default}
- **What happens**: {step-by-step: reads what → does what → outputs what}
- **Output**: {files/directories produced and their format}

### {Command 2: e.g. Evaluation / Ablation / Preprocessing …}
> Fill in all training / evaluation / ablation / preprocessing commands in the same format.
```

---

### E-2 Implement Files in Order

Implementation order: `requirements.txt` → `configs/` → `src/data/` → `src/models/{model}.py` → `src/models/baseline/` → `src/train.py` → `src/utils/` → `src/evaluate.py` → `scripts/`

After completing each file, immediately:
1. Update the `dev_log.md` progress table (`✅ Done`, fill in time)
2. **Append** a log entry to `dev_log.md` (completed / issues / solution)
3. **Check whether the "How to Run" chapter needs updating**: if this file adds/changes run commands, parameters, output files or formats, update it immediately; otherwise skip

After completing each module (data / model / training loop / utils / scripts), run one consistency check against `implementation.md`:
- Function signatures, parameters, return values match description
- Tensor shapes match expected values
- If mismatch found, enter E-5 flow

**Follow the run strategy confirmed in E-0 item 4**:
- Auto-run → run immediately, mark `✅ Done` only after no errors
- User-run → static check (imports / syntax / shape inference), mark `🔄 WIP`, mark `✅ Done` after user confirms it passes
- Mixed → run fast scripts automatically; hand slow ones to the user

---

### E-3 requirements.txt Rules

- Library names only, no version numbers
- **Must not include `torch`, `torchvision`, or `torchaudio`**

---

### E-4 Blocking Issues

Stop immediately and prompt:
```
⚠️ Blocking issue: {specific problem}

Options:
- Tell me how to fix it → fix and continue
- Needs idea change → use `/research[B]-idea` to go back to Phase B
- Needs experiment design change → use `/research[C]-experiment`
- Needs implementation plan change → use `/research[D]-implementation`
```

---

### E-5 implementation.md Error Found

If a logic error, mismatch, or unimplementable design is found in `implementation.md`, **do not patch around it in code**:

1. Stop coding immediately
2. Report the issue (location / description / impact / suggested fix)
3. Wait for user confirmation
4. After confirmation, **update implementation.md first**, run validation
5. Then update code accordingly and continue
6. Append a log entry to `dev_log.md` recording the issue and correction

---

### E-6 User Requests Code Improvement

After each change, append to `dev_log.md` (completed / reason / impact) and check whether "How to Run" needs updating. **Never change code without updating dev_log.**

---

### E-7 Code Review (proactive, after all coding is complete)

Two hard requirements only:
1. **Runs without error**: imports complete, requirements.txt covers all libraries, paths and configs consistent, scripts launch via nohup with correct log paths
2. **Logically correct**: core module matches Method description, tensor shapes consistent end-to-end, loss/metrics match Part 3 definitions, ablation switches actually change behavior

Issues under (1) or (2) → must fix, confirm with user, append dev_log entry.
Style/engineering issues only → mention at most in one sentence, user decides.

---

### E-8 Write README.md

After all code is complete and the review passes, write README.md (at the location confirmed in E-0):

**Must include**:
- **Project overview**: one paragraph on what this project does (from idea_report.md topic)
- **Environment setup**: create/activate commands based on E-0; install PyTorch per official guide (by CUDA version); `pip install -r requirements.txt` for the rest
- **Detailed run commands**: sync from the "How to Run" chapter in dev_log.md

---

### E-9 Git Commit and Push

After README.md is written, commit and push per the git config from E-0:

```bash
git add .
git commit -m "Initial commit: {topic} implementation"
git branch -M main
git remote add origin {repo_url}
git push -u origin main
```

> **Push scope**:
> - Whole project → run from project root
> - `code/` only → initialize git inside `code/`, push from there

**Large file check**: before pushing, check for files over 100 MB (`find . -size +100M`). If any found, ask user to confirm exclusion.

---

### E-10 Phase E Complete

After code review passes, README is written, and git is pushed:

```
Phase E complete. Code review passed, README written, code pushed.

→ If experiment results are unsatisfactory, use `/research[F]-iteration` to iterate.
→ If results are satisfactory, go straight to paper writing: `/research[G]-paper`.
```
