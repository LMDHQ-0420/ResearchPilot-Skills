<div align="center">

<img src="logo.png" alt="ResearchPilot-Skills" width="600" />

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/LMDHQ-0420/ResearchPilot-Skills/releases)
[![Platform](https://img.shields.io/badge/platform-Claude%20Code%20%7C%20Codex%20%7C%20CodeBuddy-lightgrey.svg)](https://github.com/LMDHQ-0420/ResearchPilot-Skills)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

**Automated Academic Research Workflow Skill**

From direction exploration, literature review, and idea development to experiment design,  
code implementation, and paper writing — all through natural conversation.

[中文](README.md) | English

</div>

---

## News

- 🎉 **[2026/07/01]** Officially renamed to **ResearchPilot-Skills** with a full six-phase refactor — each phase is now an independent skill, eliminating context-overload forgetting.
- 📄 **[2026/06/07]** Added paper writing support (Phase F): versioned drafts, annotation-driven revisions, and Python figure/table generation.
- 🚀 **[2026/06/04]** Project launched — initial release covering the full pipeline from direction exploration to coding.

---

## Overview

ResearchPilot-Skills is a set of SKILL.md-compatible academic research skills, supporting **Claude Code**, **OpenAI Codex CLI**, **Tencent CodeBuddy**, and other mainstream AI coding assistants. Each of the seven phases is an independent skill loaded only when needed — precise context, no forgetting from oversized prompts.

---

## Highlights

- **Step-by-step confirmation, never deciding for you**: the research direction and each RQ are locked one at a time through multi-round dialogue; every output in Phases A/B carries a "confirmed content card" so the current consensus is always visible, and the AI never skips a phase without your confirmation.
- **Research before design, method grounded in evidence**: deep literature review comes first — every research gap must be backed by a passage from a paper; each RQ's novelty is validated by a targeted search, eliminating pseudo-innovation at the source.
- **Deep-read baselines before designing experiments**: before designing experiments, the AI deep-reads the papers and GitHub code of the chosen baselines, extracts their actual experimental designs, and aligns the plan with field conventions — rather than designing in a vacuum.
- **Plain-language method exposition**: idea deepening proceeds in three layers (technical framework → detailed pipeline → Introduction polishing); the pipeline is explained as "step 1… step 2…", without piling up formulas.
- **Anti-hallucination citation verification**: every citation is anchored to a supporting sentence in the source PDF; unverifiable ones are explicitly marked `⚠️ [low confidence]` and registered in a pending-verification list — uncertainty is never hidden.
- **Effectiveness first + implementation validation**: the first purpose of experiment design is to rigorously prove the idea's effectiveness, never trimming experiments to fit resources; the implementation guide is automatically checked for experiment coverage, logical consistency, and completeness.
- **Paper writing with versioning and annotations**: confirm the paper structure before drafting; the body leaves blank `>` markers for you to annotate in place, and the AI revises from your notes; every revision is archived as a separate file (`v{major}.{minor}-{summary}`), with figures/tables Python-generated to match the paper format.

> To learn exactly what the AI does at each phase and how it interacts with you, see the **[full workflow guide →](WORKFLOW.en.md)**.

---

## Installation

Clone the repository first:

```bash
git clone https://github.com/LMDHQ-0420/ResearchPilot-Skills.git
cd ResearchPilot-Skills
```

> Each phase is an independent skill. Chinese and English versions are mutually exclusive; do not mix them.

### One-Command Install (Recommended)

```bash
# Claude Code (default)
bash install-en.sh

# OpenAI Codex CLI
bash install-en.sh codex

# Tencent CodeBuddy (run inside your project directory)
bash install-en.sh codebuddy
```

Verify:

```bash
ls ~/.claude/skills/ | grep research
```

You should see 15 directories (`research[START]`, `research[A]-exploration` … `research[G.7]-review`).

Then run in Claude Code:

```bash
/research[START]
```

If it shows a phase detection result, installation succeeded.

### Uninstall

```bash
bash uninstall.sh           # Claude Code
bash uninstall.sh codex     # Codex
bash uninstall.sh codebuddy # CodeBuddy
```

### Switch to Chinese Version

```bash
bash uninstall.sh   # remove English version first
bash install-zh.sh  # install Chinese version
```

---

## Commands

| Command | Description |
|---------|-------------|
| `/research[START] research direction` | Detect current phase and route to the correct skill |
| `/research[A]-exploration research direction` | Start direction exploration (use this for a brand-new project) |
| `/research[B]-idea` | Enter Idea Deepening |
| `/research[C]-experiment` | Enter Experiment Design |
| `/research[D]-implementation` | Enter Implementation Design |
| `/research[E]-coding` | Enter Coding |
| `/research[F]-iteration` | Enter Code Iteration |
| `/research[G.0]-plan` | Enter Paper Planning |
| `/research[G.1]-method` … `/research[G.7]-review` | Write sections / full-paper review |
| `/research[A]-exploration download-paper description [--to "path"]` | Download a single paper (standalone) |
| `/research[A]-exploration download-paper description [--to "path"]` | Download a single paper (standalone, works anytime) |

> `/research description` is a backward-compatible alias for `/research[START] description`.

### Examples

```bash
# New project — go straight to direction exploration
/research[A]-exploration I want to improve battery SOH prediction — existing Transformer methods don't exploit local temporal features

# Not sure which phase you're in — use the router
/research[START]

# Start with seed papers (PDF filename, arXiv ID, or paper title)
/research[A]-exploration time series forecasting --papers 2310.06625 "Informer 2021" paper.pdf

# Download a paper without starting the research workflow
/research[A]-exploration download-paper Attention Is All You Need
/research[A]-exploration download-paper 2310.06625 --to ./my-papers
```

At the end of each phase, the AI prompts the next command, e.g.:
```
Phase A complete. → Use `/research[B]-idea` to enter the Idea Deepening phase.
```

---

## Seven-Phase Workflow

| Phase | Name | What the AI mainly does | Output |
|-------|------|------------------------|--------|
| **A** | Direction Exploration & Literature Review | Searches literature, confirms the research direction and RQs step by step, writes the necessity argument | `idea_report.md` Part 1 |
| **B** | Idea Development | Three-layer confirmation: technical framework → plain-language pipeline → Introduction polishing | `idea_report.md` Part 2 |
| **C** | Experiment Design | Deep-reads baseline papers and code, synthesizes field conventions, confirms an experiment outline before expanding the full plan and giving a resource estimate | `idea_report.md` Part 3 |
| **D** | Implementation Design | Generates a function-precise coding guide, auto-checks coverage/consistency/completeness | `implementation.md` |
| **E** | Coding | Implements file by file per the guide, maintains a dev log, validates per module, reviews code on completion | code + `dev_log.md` |
| **F** | Code Iteration | Reads experiment results, diagnoses issues, updates design docs, iterates code, logs every change | `dev_log.md` iteration records |
| **G** | Paper Writing | Confirms the paper structure, drafts it, revises version by version from your annotations (each archived separately), guides figure/table generation | papers in `docs/manuscripts/` |

Every phase boundary is a mandatory human checkpoint — the AI never jumps to the next phase without your confirmation. For exactly what the AI does at each phase and how it interacts with you, see the **[full workflow guide →](WORKFLOW.en.md)**.

---

## Generated Files

```
docs/
  idea_report.md        # Full research report
                        #   Part 1: Motivation (necessity arguments), Research Questions, Key Works
                        #   Part 2: Introduction, Related Works, Method
                        #   Part 3: Datasets, Experiment Design (main/ablation/additional), Resource Estimate
                        #   References: MLA format, with main contribution and citation reason per entry
  implementation.md     # File- and function-level coding guide (dir tree, file table, data flow, validation log)
  dev_log.md            # Coding progress and decision log
  user_requirements.md  # Constraints collected through conversation (direction, RQ, implementation preferences)
  papers/               # Downloaded paper PDFs or abstract TXTs
  manuscripts/          # Phase F paper; each revision archived separately v{major}.{minor}-{summary}.md

code/
  README.md             # Project overview, env setup, detailed run commands
  requirements.txt
  src/                  # Core model and training code
  scripts/              # Data processing and experiment scripts
  configs/              # Hyperparameter configs
  baselines/            # Baseline implementations
  notebooks/            # Key-step visualization; paper figures/tables via image.ipynb / table.ipynb
  data/                 # gitignored
  results/              # gitignored
  logs/                 # gitignored
```

---

## FAQ

**Skill not triggering?**

Check that the skill directories exist. For Claude Code:
```bash
ls ~/.claude/skills/ | grep research
```
If directories are missing, re-run the install commands and restart the AI assistant.

**Want to change the document format?**

Tell the AI in conversation, e.g. "Make the Introduction more detailed." It records preferences in `user_requirements.md` and applies them.

**A paper failed to download?**

The AI tries arXiv then OpenReview automatically. If both fail, it saves an abstract TXT (if available) or annotates citations with `⚠️ [PDF unavailable]`. You can also manually place the PDF in `docs/papers/` using the full paper title as the filename.

**How to download a paper without starting the research workflow?**

```bash
/research[A]-exploration download-paper Mamba: Linear-Time Sequence Modeling with Selective State Spaces
/research[A]-exploration download-paper 2312.00752 --to ./papers
```

**How to switch to the Chinese version?**

Remove the installed English skills first (Claude Code example):
```bash
rm -rf ~/.claude/skills/research[START]
rm -rf ~/.claude/skills/research[A]-exploration
rm -rf ~/.claude/skills/research[B]-idea
rm -rf ~/.claude/skills/research[C]-experiment
rm -rf ~/.claude/skills/research[D]-implementation
rm -rf ~/.claude/skills/research[E]-coding
rm -rf ~/.claude/skills/research[F]-iteration
rm -rf ~/.claude/skills/research[G.0]-plan
rm -rf ~/.claude/skills/research[G.1]-method
rm -rf ~/.claude/skills/research[G.2]-experiments
rm -rf ~/.claude/skills/research[G.3]-abstract
rm -rf ~/.claude/skills/research[G.4]-introduction
rm -rf ~/.claude/skills/research[G.5]-related
rm -rf ~/.claude/skills/research[G.6]-conclusion
rm -rf ~/.claude/skills/research[G.7]-review
```

Then re-run the install commands above replacing `ResearchPilot-Skills-en` with `ResearchPilot-Skills-zh`.

---

## License

MIT License — see [LICENSE](LICENSE)
