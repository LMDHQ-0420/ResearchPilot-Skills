# Research Scout

**Automated Academic Research Workflow for Claude Code**

[中文](README.md) | English

---

## Overview

Research Scout is a Claude Code Skill that automates the complete academic research pipeline: from direction exploration, literature retrieval, and idea development, through experiment design, to code implementation. The workflow progresses naturally through conversation — Claude asks for confirmation at each key checkpoint, so you never need to remember mode-switching commands.

---

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/research-scout.git
cd research-scout

# Install English version
cp -r code/skills/research-scout-en ~/.claude/skills/research
```

> Chinese and English versions are mutually exclusive. Both use `/research` as the trigger command. To switch versions, delete `~/.claude/skills/research` and install the other version.

Verify installation:

```bash
/research "test installation"
```

If Claude starts asking about your research direction, installation succeeded.

---

## Commands

| Command | Description |
|---------|-------------|
| `/research "research direction"` | Start the full research workflow |
| `/research --papers <pdf/name/description>` | Start with seed papers |
| `/research download-paper "description" [--to "path"]` | Download a single paper (standalone, works anytime) |

### Starting the Workflow

```bash
# Start from a research direction
/research "I want to improve battery SOH prediction — existing Transformer methods don't exploit local temporal features"

# Start with seed papers (PDF filename, arXiv ID, or paper title)
/research "time series forecasting" --papers 2310.06625 "Informer 2021" paper.pdf

# Download a paper without starting the research workflow
/research download-paper "Attention Is All You Need"
/research download-paper "2310.06625" --to "./my-papers"
```

Once started, the entire workflow proceeds through conversation — no additional commands needed. After each phase, Claude asks: "Is this complete enough? We can move on to the next phase."

---

## Five-Phase Workflow

### Phase A: Direction Exploration

Claude searches the literature and proposes 5 research directions for you to choose from.

1. Parses your input; if information is insufficient, asks clarifying questions in a single turn
2. Retrieves papers from top venues (NeurIPS, ICML, ICLR, CVPR, ACL, etc.), targeting 10+ papers
3. Presents a download list for confirmation, then batch-downloads to `docs/papers/`
4. Proposes 5 directions, each with: core idea, literature support, innovation angle, main challenges, and novelty assessment
5. You select or request changes; Claude iterates with additional retrieval

After each round, Claude asks: "Is this direction complete enough? Ready to move to idea development?"

---

### Phase B: Idea Development

Claude builds the selected direction into a fully structured idea, generating `idea_report.md` Parts 1 and 2.

- **Part 1**: Motivation (current limitations + proposed approach), method development timeline, key paper list
- **Part 2**: Introduction (background and significance), Related Works (including research gap analysis), Method (method description + baseline reference + evaluation metrics)

All citations are verified via `web_search`. Unverifiable claims are marked `[to verify]`. Claims with paper support are annotated `>>` with the supporting text.

After each round, Claude asks: "Is the idea complete enough? Ready to move to experiment design?"

---

### Phase C: Experiment Design

Claude designs a complete experimental plan based on domain conventions, appended to `idea_report.md` Part 3.

1. Asks about hardware, time constraints, and dataset preferences (saved to `user_requirements.md`)
2. Searches recent papers (last 3 years) for standard datasets, metrics, and ablation patterns
3. **Feasibility verification**:
   - Are dataset download links accessible?
   - Are baseline code repositories accessible?
   - Does GPU memory meet estimated requirements?
4. Generates: main experiment table (method comparison), ablation studies, additional analysis

Items that fail feasibility checks are flagged ⚠️ and paused for user action.

After each round, Claude asks: "Is the experiment design complete enough? Ready to move to implementation design?"

---

### Phase D: Implementation Design

Claude generates `implementation.md` — a precise, function-level coding guide for Phase E.

**Strong baseline path (your method extends an existing open-source project):**
1. Clones the original project
2. Scans existing code structure, documents every file and directory
3. Generates a rewrite plan: per-function changes (original signature → new signature + rewrite logic)

**Build from scratch path:**
1. Collects framework preferences and code style constraints
2. Generates complete directory tree with purpose of every file and directory
3. Specifies every function: full signature + parameter types + return value + implementation logic

Both paths include: results file format (meaning of every field) and data directory structure.

After `implementation.md` is confirmed, Claude outputs data download instructions and waits for you to confirm data is ready before entering Phase E.

---

### Phase E: Coding

Claude implements code file by file following `implementation.md`, maintaining `dev_log.md` in sync.

Implementation order: `requirements.txt` → `configs/` → `code/README.md` → `src/` → `scripts/` → `baselines/`

After completing each file:
- Records in `dev_log.md`: file completed, key implementation decisions, items to test
- Asks whether to proceed to the next file

`requirements.txt` rule: library names only, no version pins, no `torch`/`torchvision`/`torchaudio`.

---

## Generated Files

```
docs/
  idea_report.md        # Full research report
                        #   Part 1: Motivation, development timeline, key papers
                        #   Part 2: Introduction, Related Works, Method
                        #   Part 3: Datasets, main experiments, ablations, additional analysis
  implementation.md     # File-by-file, function-by-function implementation guide
  dev_log.md            # Coding progress and decision log
  user_requirements.md  # Constraints collected by Claude via conversation (auto-maintained)
  papers/               # Downloaded PDFs (filename = full paper title)

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

Check the install path:
```bash
ls ~/.claude/skills/research/SKILL.md
```
If the file doesn't exist, re-run the install command. Restart Claude Code and try again.

**Want to change the generated document format?**

Tell Claude in conversation, e.g. "Make the Introduction more detailed" or "Add learning rate comparison to ablations." Claude records preferences in `user_requirements.md` and applies them.

**A paper failed to download?**

Claude will report which papers failed and whether a summary is available. You can manually place the PDF in `docs/papers/` using the full paper title as the filename. You can also skip it — Claude will annotate with `⚠️ [PDF unavailable]`.

**How to download a paper without starting the research workflow?**

```bash
/research download-paper "Mamba: Linear-Time Sequence Modeling with Selective State Spaces"
/research download-paper "2312.00752" --to "./papers"
```

**How to switch to the Chinese version?**

```bash
rm -rf ~/.claude/skills/research
cp -r code/skills/research-scout-zh ~/.claude/skills/research
```

---

## License

MIT License — see [LICENSE](LICENSE)
