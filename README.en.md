# Research Scout

**Automated Academic Research Workflow for Claude Code**

[中文](README.md) | English

---

## Overview

Research Scout is a Claude Code Skill that automates the complete academic research pipeline: direction exploration, literature retrieval, idea development, experiment design, implementation design, and code implementation. The workflow progresses naturally through conversation — Claude asks for confirmation at each key checkpoint, so you never need to remember mode-switching commands.

---

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/research-scout.git
cd research-scout

# Install English version
cp -r skills/research-scout-en ~/.claude/skills/
```

> Chinese and English versions are mutually exclusive. Both use `/research` as the trigger. To switch versions, delete `~/.claude/skills/research` and install the other version.

Verify installation:

```bash
/research test installation
```

If Claude starts asking about your research direction, installation succeeded.

---

## Commands

| Command | Description |
|---------|-------------|
| `/research research direction` | Start the full research workflow |
| `/research --papers <pdf/name/description>` | Start with seed papers |
| `/research download-paper description [--to "path"]` | Download a single paper (standalone, works anytime) |

### Examples

```bash
# Start from a research direction
/research I want to improve battery SOH prediction — existing Transformer methods don't exploit local temporal features

# Start with seed papers (PDF filename, arXiv ID, or paper title)
/research time series forecasting --papers 2310.06625 "Informer 2021" paper.pdf

# Download a paper without starting the research workflow
/research download-paper Attention Is All You Need
/research download-paper 2310.06625 --to ./my-papers
```

Once started, the workflow proceeds through conversation. After each phase, Claude asks: "Is this complete enough? We can move on to the next phase."

---

## Five-Phase Workflow

### Phase A: Direction Exploration & Literature Review

Claude conducts a deep, iterative literature review across four rounds, producing `idea_report.md` Part 1.

**Problem domain scoping**: Initial retrieval of 10–15 representative papers; Claude reports across three dimensions (what problems the field addresses, major method families, most active sub-directions in the past two years). You confirm the scope and areas of interest.

**Deep literature coverage**: Downloads and reads papers within the confirmed scope; for each method family, outputs a structured analysis of what it can and cannot solve — every gap claim must be supported by a specific passage from a paper. You can add papers or challenge gap judgments; this step iterates until coverage is satisfactory.

**RQ formulation and validation**: Derives 3–5 candidate RQs from the confirmed gaps; each RQ is annotated with its corresponding gap, a novelty check (targeted search), and an answerability assessment. You select the primary RQ and secondary RQs.

**Necessity argument**: Writes a structured necessity argument for the selected RQs (application necessity / theoretical necessity / timing necessity), each point backed by citations. Once you confirm the argument holds, Part 1 is assembled.

---

### Phase B: Idea Development

After Part 1 is confirmed, Claude generates `idea_report.md` Part 2 independently.

**Part 2 — Idea design**: Introduction, Related Works (including research gap analysis), Method (overall framework 3.1 → plain-language walkthrough 3.2 → theoretical derivation 3.3+).

**References**: MLA format, all Part 1+2 citations consolidated, each entry annotated with main work and citation reason; all citations verified via `web_search`, unverifiable claims marked `[to verify]`.

---

### Phase C: Experiment Design

Claude designs a complete experimental plan based on domain conventions, appended to `idea_report.md` Part 3.

**Constraint collection**: Asks for GPU spec and max training time per run, saved to `user_requirements.md`.

**Baseline deep-read**: Presents a reading plan listing each baseline's paper and GitHub repo (with a one-line reason for reading it); after you confirm, Claude reads each one and extracts datasets used, split strategies, experiment designs, comparison models, evaluation metrics, and key hyperparameters — compiled into Part 3 Section 0.

**Domain convention synthesis**: Aggregates the deep-read results to identify the standard benchmarks, evaluation metrics, ablation patterns, and reporting norms shared across baselines, forming the reference baseline for experiment design.

**Feasibility verification**: Confirms dataset links are accessible, baseline repos are accessible, and GPU memory is sufficient; pauses and notifies you if any check fails.

**Experiment design** (top-venue workload standard): Main experiment with 3–5 datasets and 5–8 baselines; ablation study systematically covering all innovation modules (3–6 variants); 2–3 additional experiment types (generalization / efficiency / robustness / visualization); all results reported as mean ± std over at least 3 random seeds. Each experiment specifies: purpose, dataset splits and rationale, metric meanings, expected outcome, and a model table with one-line descriptions.

---

### Phase D: Implementation Design

Claude generates `implementation.md` — the precise coding guide for Phase E. After every generation or revision, Claude automatically runs three validation checks (experiment coverage, logical consistency, completeness).

**Strong baseline path** (extending an existing open-source project): Clone original project → scan structure → generate rewrite plan; each function to modify is described as: what it currently does → what it will do (text steps) → parameter / return value changes.

**Build from scratch path**: Full directory tree with per-file responsibilities; dedicated data flow section (raw files → parse → split → normalize → model input tensor, with shapes); each function documented with signature, parameter meanings, return semantics, and implementation logic.

**Data preparation**: After `implementation.md` is confirmed, Claude outputs data download instructions and waits for you to confirm data is ready before entering Phase E.

---

### Phase E: Coding

Claude implements code file by file following `implementation.md`, maintaining `dev_log.md` in sync.

**Module validation**: After completing each module, runs a consistency check against `implementation.md` (function signatures, tensor shapes, evaluation metrics).

**Error handling**: If an error is found in `implementation.md`: stop → report the issue and a suggested fix → wait for confirmation → update `implementation.md` first → then update the code.

**Dependency rules**: `requirements.txt` lists library names only, no version pins, no `torch` / `torchvision` / `torchaudio`.

---

## Generated Files

```
docs/
  idea_report.md        # Full research report
                        #   Part 1: Motivation (necessity argument), Research Questions, Key Works (table + detail entries)
                        #   Part 2: Introduction, Related Works, Method
                        #   Part 3: Datasets, experiment design (main/ablation/additional)
                        #   References: MLA format, with main work and citation reason per entry
  implementation.md     # File-by-file, function-by-function implementation guide
                        #   (includes data flow and validation records)
  dev_log.md            # Coding progress and decision log
  user_requirements.md  # Constraints collected by Claude via conversation
                        #   (direction preferences, GPU limits, etc.)
  papers/               # Downloaded PDFs or abstract TXTs

code/
  README.md             # Environment setup, data preparation, run commands
  requirements.txt
  src/                  # Core model and training code
  scripts/              # Data processing and experiment scripts
  configs/              # Hyperparameter configs
  baselines/            # Baseline implementations
  data/                 # gitignored
  results/              # gitignored
  logs/                 # gitignored
```

---

## FAQ

**Skill not triggering?**

```bash
ls ~/.claude/skills/research/SKILL.md
```
If the file doesn't exist, re-run the install command and restart Claude Code.

**Want to change the document format?**

Tell Claude in conversation, e.g. "Make the Introduction more detailed." Claude records preferences in `user_requirements.md` and applies them.

**A paper failed to download?**

Claude tries arXiv then OpenReview automatically. If both fail, it saves an abstract TXT (if available) or annotates citations with `⚠️ [PDF unavailable]`. You can also manually place the PDF in `docs/papers/` using the full paper title as the filename.

**How to download a paper without starting the research workflow?**

```bash
/research download-paper Mamba: Linear-Time Sequence Modeling with Selective State Spaces
/research download-paper 2312.00752 --to ./papers
```

**How to switch to the Chinese version?**

```bash
rm -rf ~/.claude/skills/research
cp -r code/skills/research-scout-zh ~/.claude/skills/
```

---

## License

MIT License — see [LICENSE](LICENSE)
