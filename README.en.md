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

## Overview

ResearchPilot-Skills is a set of SKILL.md-compatible academic research skills, supporting **Claude Code**, **OpenAI Codex CLI**, **Tencent CodeBuddy**, and other mainstream AI coding assistants. Each of the six phases is an independent skill loaded only when needed — precise context, no forgetting from oversized prompts.

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

> Each phase is an independent skill — all 7 must be installed for the full workflow. Chinese and English versions are mutually exclusive; do not mix them.

### Claude Code

```bash
cp -r skills/ResearchPilot-Skills-en/research[START]            ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[A]-exploration    ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[B]-idea           ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[C]-experiment     ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[D]-implementation ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[E]-coding         ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[F]-paper          ~/.claude/skills/
```

Verify: `ls ~/.claude/skills/ | grep research` (should show 7 directories)

### OpenAI Codex CLI

```bash
mkdir -p ~/.codex/skills
cp -r skills/ResearchPilot-Skills-en/research[START]            ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-en/research[A]-exploration    ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-en/research[B]-idea           ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-en/research[C]-experiment     ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-en/research[D]-implementation ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-en/research[E]-coding         ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-en/research[F]-paper          ~/.codex/skills/
```

Verify: `ls ~/.codex/skills/ | grep research` (should show 7 directories)

### Tencent CodeBuddy

CodeBuddy skills are installed in the `.codebuddy/skills/` directory inside your workspace:

```bash
mkdir -p .codebuddy/skills
cp -r skills/ResearchPilot-Skills-en/research[START]            .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-en/research[A]-exploration    .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-en/research[B]-idea           .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-en/research[C]-experiment     .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-en/research[D]-implementation .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-en/research[E]-coding         .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-en/research[F]-paper          .codebuddy/skills/
```

Verify installation (any tool): run `/research[START]` in conversation — if it shows a phase detection result, installation succeeded.

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
| `/research[F]-paper` | Enter Paper Writing |
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

## Six-Phase Workflow

| Phase | Name | What the AI mainly does | Output |
|-------|------|------------------------|--------|
| **A** | Direction Exploration & Literature Review | Searches literature, confirms the research direction and RQs step by step, writes the necessity argument | `idea_report.md` Part 1 |
| **B** | Idea Development | Three-layer confirmation: technical framework → plain-language pipeline → Introduction polishing | `idea_report.md` Part 2 |
| **C** | Experiment Design | Deep-reads baseline papers and code, synthesizes field conventions, confirms an experiment outline before expanding the full plan and giving a resource estimate | `idea_report.md` Part 3 |
| **D** | Implementation Design | Generates a function-precise coding guide, auto-checks coverage/consistency/completeness | `implementation.md` |
| **E** | Coding | Implements file by file per the guide, maintains a dev log, validates per module, reviews code on completion | code + `dev_log.md` |
| **F** | Paper Writing | Confirms the paper structure, drafts it, revises version by version from your annotations (each archived separately), guides figure/table generation | papers in `docs/manuscripts/` |

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
rm -rf ~/.claude/skills/research[F]-paper
```

Then re-run the install commands above replacing `ResearchPilot-Skills-en` with `ResearchPilot-Skills-zh`.

---

## License

MIT License — see [LICENSE](LICENSE)
