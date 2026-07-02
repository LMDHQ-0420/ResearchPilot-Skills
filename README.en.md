<div align="center">

<img src="logo.png" alt="ResearchPilot-Skills" width="600" />

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/LMDHQ-0420/ResearchPilot-Skills/releases)
[![Platform](https://img.shields.io/badge/platform-Claude%20Code%20%7C%20Codex%20%7C%20CodeBuddy-lightgrey.svg)](https://github.com/LMDHQ-0420/ResearchPilot-Skills)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

**A full-pipeline AI research assistant — from research question to published paper**

[中文](README.md) | English

</div>

---

## News

- 📄 **[2026/07/02]** v2.0 major release: added code iteration phase (F) and paper writing phase G (G.0–G.7), based on Prof. Pengsida's public learning notes, covering planning, section-by-section writing, full-paper review, and more.
- 🎉 **[2026/07/01]** Officially renamed **ResearchPilot-Skills** with a full multi-stage skill refactor, eliminating context-overload forgetting.
- 📝 **[2026/06/07]** Added paper writing support (Phase F): versioned drafts, annotation-driven revisions, and Python figure/table generation.
- 🚀 **[2026/06/04]** Project launched — initial release covering the full pipeline from direction exploration to code implementation.

---

## Why ResearchPilot-Skills

🔬 **End-to-end coverage**: direction exploration → literature review → idea deepening → experiment design → coding → code iteration → paper writing. One skill suite, every phase loaded independently with precise context.

📐 **Experiments without compromise**: the sole purpose of experiment design is to rigorously prove the idea's effectiveness. Resource constraints play no role in design — they are only estimated after the plan is finalized.

🧱 **Code and design documents are tightly coupled**: every code change requires updating the design documents (`idea_report.md` / `implementation.md`) first. Patching code without updating documents is not allowed; backtracking follows the full chain.

📝 **Paper writing grounded in evidence**: based on Prof. Pengsida's public learning notes, every section has a writing framework, examples, and constraints. The full manuscript is read before each revision to prevent section disconnection.

---

## Seven-Phase Workflow

| Phase | Skill | What it does | Output |
|-------|-------|-------------|--------|
| **A** Exploration | `research[A]-exploration` | Literature search (≥15 papers) → three-layer RQ confirmation → necessity argument → assemble Part 1 | `idea_report.md` Part 1 |
| **B** Idea Deepening | `research[B]-idea` | Technical framework → plain-language pipeline → Method writing → Introduction polish | `idea_report.md` Part 2 |
| **C** Experiment Design | `research[C]-experiment` | Deep-read baseline code → synthesize field conventions → confirm outline → design main/ablation/additional experiments | `idea_report.md` Part 3 |
| **D** Implementation Design | `research[D]-implementation` | Generate function-level coding guide → three-way validation (coverage / consistency / completeness) | `implementation.md` |
| **E** Coding | `research[E]-coding` | File-by-file implementation → per-module validation → code review → write README → git push | code + `dev_log.md` |
| **F** Code Iteration | `research[F]-iteration` | Diagnose from results → confirm backtrack scope → update docs first → update code → append iteration record | `dev_log.md` iteration records |
| **G** Paper Writing | `research[G.0]`–`research[G.7]` | Update idea_report → plan figures → write each section → full-paper review | `docs/manuscripts/` |

> At the end of each phase, the AI gives the next command. No phase is skipped without your confirmation. Full details: **[Workflow Guide →](WORKFLOW.en.md)**.

---

## Skill List

| Skill | Command | Responsibility |
|-------|---------|---------------|
| Entry router | `/research[START]` | Detect current phase and route to the correct skill |
| Direction Exploration | `/research[A]-exploration` | Literature search, RQ confirmation, Part 1 assembly |
| Idea Deepening | `/research[B]-idea` | Technical framework, pipeline, Method writing |
| Experiment Design | `/research[C]-experiment` | Baseline deep-read, experiment plan design |
| Implementation Design | `/research[D]-implementation` | Function-level coding guide generation and validation |
| Coding | `/research[E]-coding` | File-by-file implementation, log maintenance, git push |
| Code Iteration | `/research[F]-iteration` | Diagnose → backtrack → update docs → update code → validate |
| Paper Planning | `/research[G.0]-plan` | Update idea_report, plan figures/tables, select format |
| Method | `/research[G.1]-method` | Write / revise Method section |
| Experiments | `/research[G.2]-experiments` | Write / revise Experiments section |
| Abstract | `/research[G.3]-abstract` | Write / revise Abstract |
| Introduction | `/research[G.4]-introduction` | Write / revise Introduction |
| Related Works | `/research[G.5]-related` | Write / revise Related Works |
| Conclusion | `/research[G.6]-conclusion` | Write / revise Conclusion + References |
| Full-paper Review | `/research[G.7]-review` | Five-dimension review + claim-evidence alignment |
| Paper Download | `/research[A]-exploration download-paper description` | Download a single paper, usable anytime |

---

## Examples

```bash
# New project — start from a research description
/research[A]-exploration I want to improve battery SOH prediction — existing Transformer methods don't exploit local temporal features

# Start with seed papers
/research[A]-exploration time series forecasting --papers 2310.06625 "Informer 2021" paper.pdf

# Not sure which phase you're in
/research[START]

# Download a paper without starting the research workflow
/research[A]-exploration download-paper Attention Is All You Need
/research[A]-exploration download-paper 2312.00752 --to ./my-papers
```

---

## Installation

```bash
git clone https://github.com/LMDHQ-0420/ResearchPilot-Skills.git
cd ResearchPilot-Skills

# Install English version
bash install-en.sh            # Claude Code (default)
bash install-en.sh codex      # OpenAI Codex CLI
bash install-en.sh codebuddy  # Tencent CodeBuddy (run inside your project)
```

Verify: `ls ~/.claude/skills/ | grep research` (should show 15 directories)

```bash
# Uninstall
bash uninstall.sh

# Switch to Chinese version
bash uninstall.sh && bash install-zh.sh
```

---

## Generated Files

```
docs/
  idea_report.md          # Research report (built across phases A/B/C)
    Part 1                #   Motivation, Research Questions (three-layer RQs), Key Works
    Part 2                #   Introduction, Related Works, Method
    Part 3                #   Datasets, Experiment Design (main/ablation/additional), Resource Estimate
  implementation.md       # Function-level coding guide (Phase D)
  dev_log.md              # Dev log, append-only (Phases E/F)
  user_requirements.md    # User constraints, auto-maintained by AI through conversation
  papers/                 # Downloaded paper PDFs or abstract TXTs
  manuscripts/            # Paper manuscript (Phase G)
    paper.md / paper.tex  # Current latest draft
    paper_{mm-dd_hh-mm}.* # Pre-edit backups
    examples/             # User-uploaded writing examples
    templates/            # LaTeX templates

code/
  src/
    models/               # Proposed model (one file per model)
      baseline/           # Baseline implementations (identical interface to main model)
    data/                 # Data processing
    train.py              # Training entry point
    evaluate.py           # Evaluation entry point
    utils/                # Utility functions
  scripts/                # nohup shell scripts; logs → logs/YY-MM-DD_HH-MM-SS.log
  configs/                # Hyperparameter yaml files
  data/                   # gitignored
  results/                # gitignored
  logs/                   # gitignored
  README.md               # Environment setup + run commands
  requirements.txt        # Dependencies (no torch family)
```

---

## FAQ

**Skill not triggering?**
```bash
ls ~/.claude/skills/ | grep research
```
If directories are missing, re-run the install script and restart the AI assistant.

**A paper failed to download?**
The AI tries arXiv then OpenReview automatically. If both fail, it saves an abstract TXT or annotates citations with `⚠️ [PDF unavailable]`. You can also manually place the PDF in `docs/papers/` using the full paper title as the filename.

**Changed the model architecture mid-project — what now?**
Use `/research[F]-iteration`. Diagnose the issue → confirm backtrack scope → update `idea_report.md` and `implementation.md` first → then update the code. Patching code without updating documents is not allowed.

**Can I skip a phase?**
Every phase skill can be triggered independently, but skipping prerequisites may leave documents incomplete. Use `/research[START]` to detect your current state before deciding where to resume.

---

## Acknowledgements

The paper writing phase (G.1–G.7) writing framework, section guidelines, and examples are primarily based on:

- **Pengsida** — [Learning Notes (Notion)](https://pengsida.notion.site/c1a22465a0fa4b15a12985223916048e) | [GitHub: learning_research](https://github.com/pengsida/learning_research)
- **[Master-cai/Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills)** — ML/CV/NLP paper writing skill, adapted from Prof. Pengsida's public notes
- **[Yuan1z0825/nature-skills](https://github.com/Yuan1z0825/nature-skills)** — Nature-series journal writing and scientific figure design skill
- **[Imbad0202/academic-research-skills](https://github.com/Imbad0202/academic-research-skills)** — Full academic research pipeline skill, providing writing example references

---

## License

MIT License — see [LICENSE](LICENSE)
