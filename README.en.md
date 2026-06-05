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

### Phase A: Direction Exploration

Claude searches the literature and proposes 5 research directions for you to choose from.

1. Parses input; if information is insufficient, asks clarifying questions in a single turn (preferred directions, exclusions)
2. Retrieves papers from top venues, targeting 15+; if fewer found, explains why and waits for confirmation
3. Presents a download list with a one-line summary and relevance note per paper; batch-downloads to `docs/papers/`
   - Tries arXiv first; falls back to OpenReview automatically; saves abstract TXT if both fail
4. Proposes 5 directions, each with: core idea, literature support, innovation angle, main challenges, novelty assessment
5. You select or request changes; Claude iterates with additional retrieval

---

### Phase B: Idea Development

Claude builds the selected direction into a fully structured idea, generating `idea_report.md` Parts 1 and 2.

- **Part 1**: Motivation, development timeline, Key Works
- **Part 2**: Introduction, Related Works (including research gap), Method
  - Method has three layers: overall framework (3.1), plain-language walkthrough (3.2), theoretical derivation (3.3+)
- **References**: MLA format, all Part 1+2 citations consolidated, each entry annotated with main work and citation reason

All citations verified via `web_search`; unverifiable claims marked `[to verify]`.

---

### Phase C: Experiment Design

Claude designs a complete experimental plan based on domain conventions, appended to `idea_report.md` Part 3.

1. Asks for GPU constraint and max training time per run (saved to `user_requirements.md`)
2. Searches recent papers for standard datasets, metrics, and ablation patterns
3. **Feasibility verification**: dataset links accessible, baseline repos accessible, GPU memory sufficient
4. Generates experiment design at top-venue workload standard:
   - Main experiment: 3–5 datasets, 5–8 baselines
   - Ablation study: systematically covers all innovation modules, 3–6 variants
   - Additional experiments: 2–3 types (generalization / efficiency / robustness / visualization)
   - All results reported as mean ± std over at least 3 random seeds

Each experiment specifies: purpose, dataset splits and rationale, evaluation metrics and meaning, expected outcome, and a model table with one-line description per model.

---

### Phase D: Implementation Design

Claude generates `implementation.md` — the precise coding guide for Phase E. After every generation or revision, Claude automatically runs a validation check: experiment coverage, logical consistency, completeness.

**Strong baseline path** (extending an existing open-source project):
- Clone original project → scan structure → generate rewrite plan
- Each function to modify: what it currently does → what it will do (text steps) → parameter/return changes

**Build from scratch path**:
- Full directory tree with per-file responsibilities
- Dedicated data flow section: raw files → parse → split → normalize → model input tensor (with shapes)
- Each function: signature + parameter meanings + return semantics + implementation logic (text steps)

After `implementation.md` is confirmed, Claude outputs data download instructions and waits for you to confirm data is ready before entering Phase E.

---

### Phase E: Coding

Claude implements code file by file following `implementation.md`, maintaining `dev_log.md` in sync.

- After completing each module, runs a validation against implementation.md (signatures, shapes, metric consistency)
- If an error is found in implementation.md: stop → report issue and suggested fix → wait for confirmation → update implementation.md first → then update code
- `requirements.txt`: library names only, no version pins, no `torch`/`torchvision`/`torchaudio`

---

## Generated Files

```
docs/
  idea_report.md        # Full research report
                        #   Part 1: Motivation, development timeline, Key Works
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
