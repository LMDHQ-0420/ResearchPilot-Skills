# Research Scout

**Automated Academic Research Workflow for Claude Code**

[中文](README.md) | English

---

## Overview

Research Scout is a Claude Code Skill that automates the complete academic research pipeline: direction exploration, literature retrieval, idea development, experiment design, implementation design, and code implementation. The workflow progresses naturally through conversation — Claude asks for confirmation at each key checkpoint, so you never need to remember mode-switching commands.

---

## Highlights

- **Step-by-step confirmation, never deciding for you**: the research direction and each RQ are locked one at a time through multi-round dialogue; every output in Phases A/B carries a "confirmed content card" so the current consensus is always visible, and Claude never skips a phase without your confirmation.
- **Research before design, method grounded in evidence**: deep literature review comes first — every research gap must be backed by a passage from a paper; each RQ's novelty is validated by a targeted search, eliminating pseudo-innovation at the source.
- **Deep-read baselines before designing experiments**: before designing experiments, Claude deep-reads the papers and GitHub code of the chosen baselines, extracts their actual experimental designs, and aligns the plan with field conventions — rather than designing in a vacuum.
- **Plain-language method exposition**: idea deepening proceeds in three layers (technical framework → detailed pipeline → Introduction polishing); the pipeline is explained as "first… then…", without piling up formulas.
- **Anti-hallucination citation verification**: every citation is anchored to a supporting sentence in the source PDF; unverifiable ones are explicitly marked `⚠️ [low confidence]` and registered in a pending-verification list — uncertainty is never hidden.
- **Effectiveness first + implementation validation**: the first purpose of experiment design is to rigorously prove the idea's effectiveness, never trimming experiments to fit resources (resources are only estimated after design); only data/code availability is verified before design; the implementation guide is automatically checked for experiment coverage, logical consistency, and completeness.

> To learn exactly what Claude does at each phase and how it interacts with you, see the **[full workflow guide →](WORKFLOW.en.md)**.

---

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/research-scout.git
cd research-scout

# Install English version
cp -r skills/research-scout-en/research ~/.claude/skills/
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

| Phase | Name | What Claude mainly does | Output |
|-------|------|------------------------|--------|
| **A** | Direction Exploration & Literature Review | Searches literature, confirms the research direction and RQs step by step, writes the necessity argument | `idea_report.md` Part 1 |
| **B** | Idea Development | Three-layer confirmation: technical framework → plain-language pipeline → Introduction polishing | `idea_report.md` Part 2 |
| **C** | Experiment Design | Deep-reads baseline papers and code, synthesizes field conventions, confirms an experiment outline with you before expanding the full plan and giving a resource estimate | `idea_report.md` Part 3 |
| **D** | Implementation Design | Generates a function-precise coding guide, auto-checks coverage/consistency/completeness | `implementation.md` |
| **E** | Coding | Implements file by file per the guide, maintains a dev log, validates per module | code + `dev_log.md` |

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
                        #   (includes data flow and validation records)
  dev_log.md            # Coding progress and decision log
  user_requirements.md  # Constraints collected by Claude via conversation
                        #   (direction preferences, RQ constraints, implementation constraints, etc.)
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
cp -r code/skills/research-scout-zh/research ~/.claude/skills/
```

---

## License

MIT License — see [LICENSE](LICENSE)
