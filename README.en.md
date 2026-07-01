# ResearchPilot-Skills

**Automated Academic Research Workflow for Claude Code**

[中文](README.md) | English

---

## Overview

ResearchPilot-Skills is a Claude Code Skill that automates the complete academic research pipeline: direction exploration, literature retrieval, idea development, experiment design, code implementation, and paper writing. The workflow progresses naturally through conversation — Claude asks for confirmation at each key checkpoint, so you never need to remember mode-switching commands.

---

## Highlights

- **Step-by-step confirmation, never deciding for you**: the research direction and each RQ are locked one at a time through multi-round dialogue; every output in Phases A/B carries a "confirmed content card" so the current consensus is always visible, and Claude never skips a phase without your confirmation.
- **Research before design, method grounded in evidence**: deep literature review comes first — every research gap must be backed by a passage from a paper; each RQ's novelty is validated by a targeted search, eliminating pseudo-innovation at the source.
- **Deep-read baselines before designing experiments**: before designing experiments, Claude deep-reads the papers and GitHub code of the chosen baselines, extracts their actual experimental designs, and aligns the plan with field conventions — rather than designing in a vacuum.
- **Plain-language method exposition**: idea deepening proceeds in three layers (technical framework → detailed pipeline → Introduction polishing); the pipeline is explained as "first… then…", without piling up formulas.
- **Anti-hallucination citation verification**: every citation is anchored to a supporting sentence in the source PDF; unverifiable ones are explicitly marked `⚠️ [low confidence]` and registered in a pending-verification list — uncertainty is never hidden.
- **Effectiveness first + implementation validation**: the first purpose of experiment design is to rigorously prove the idea's effectiveness, never trimming experiments to fit resources (resources are only estimated after design); only data/code availability is verified before design; the implementation guide is automatically checked for experiment coverage, logical consistency, and completeness.
- **Paper writing with versioning and annotations**: confirm the paper structure before drafting; the body leaves blank `>` markers for you to annotate in place, and Claude revises from your notes; every revision is archived as a separate file (`v{major}.{minor}-{summary}`), with figures/tables Python-generated to match the paper format.

> To learn exactly what Claude does at each phase and how it interacts with you, see the **[full workflow guide →](WORKFLOW.en.md)**.

---

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/ResearchPilot-Skills.git
cd ResearchPilot-Skills

# Install English version (all 7 skills)
cp -r skills/ResearchPilot-Skills-en/research[START]           ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[A]-exploration   ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[B]-idea          ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[C]-experiment    ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[D]-implementation ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[E]-coding        ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-en/research[F]-paper         ~/.claude/skills/
```

> Each phase is an independent skill — all 7 must be installed for the full workflow. Chinese and English versions are mutually exclusive; do not mix them.

Verify installation:

```bash
ls ~/.claude/skills/ | grep research
```

You should see 7 directories: `research[START]`, `research[A]-exploration`, `research[B]-idea`, `research[C]-experiment`, `research[D]-implementation`, `research[E]-coding`, `research[F]-paper`.

Then run in Claude Code:

```bash
/research[START] test installation
```

If Claude shows a phase detection result, installation succeeded.

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

At the end of each phase, Claude prompts the next command, e.g.:
```
Phase A complete. → Use `/research[B]-idea` to enter the Idea Deepening phase.
```

---

## Six-Phase Workflow

| Phase | Name | What Claude mainly does | Output |
|-------|------|------------------------|--------|
| **A** | Direction Exploration & Literature Review | Searches literature, confirms the research direction and RQs step by step, writes the necessity argument | `idea_report.md` Part 1 |
| **B** | Idea Development | Three-layer confirmation: technical framework → plain-language pipeline → Introduction polishing | `idea_report.md` Part 2 |
| **C** | Experiment Design | Deep-reads baseline papers and code, synthesizes field conventions, confirms an experiment outline with you before expanding the full plan and giving a resource estimate | `idea_report.md` Part 3 |
| **D** | Implementation Design | Generates a function-precise coding guide, auto-checks coverage/consistency/completeness | `implementation.md` |
| **E** | Coding | Implements file by file per the guide, maintains a dev log, validates per module, reviews code on completion | code + `dev_log.md` |
| **F** | Paper Writing | Confirms the paper structure, drafts it, revises version by version from your annotations (each archived separately), guides figure/table generation | papers in `docs/manuscripts/` |

Every phase boundary is a mandatory human checkpoint — Claude never jumps to the next phase without your confirmation. For exactly what Claude does at each phase and how it interacts with you, see the **[full workflow guide →](WORKFLOW.en.md)**.

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
                        #   (opens with directory tree + per-file function table; includes data flow and validation records)
  dev_log.md            # Coding progress and decision log
  user_requirements.md  # Constraints collected by Claude via conversation
                        #   (direction preferences, RQ constraints, implementation constraints, etc.)
  papers/               # Downloaded PDFs or abstract TXTs
  manuscripts/          # Phase F paper; each revision archived separately v{major}.{minor}-{summary}.md

code/
  README.md             # Project overview, env setup, detailed run commands (location: project root or code/)
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
# Remove installed English skills
rm -rf ~/.claude/skills/research[START]
rm -rf ~/.claude/skills/research[A]-exploration
rm -rf ~/.claude/skills/research[B]-idea
rm -rf ~/.claude/skills/research[C]-experiment
rm -rf ~/.claude/skills/research[D]-implementation
rm -rf ~/.claude/skills/research[E]-coding
rm -rf ~/.claude/skills/research[F]-paper

# Install Chinese version
cp -r skills/ResearchPilot-Skills-zh/research[START]           ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[A]-exploration   ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[B]-idea          ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[C]-experiment    ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[D]-implementation ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[E]-coding        ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[F]-paper         ~/.claude/skills/
```

---

## License

MIT License — see [LICENSE](LICENSE)
