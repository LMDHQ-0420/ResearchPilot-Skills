# Research Scout

**Automated academic research workflow for Claude Code**

English | [中文](README.zh.md)

---

## Overview

Research Scout automates the complete academic research workflow from literature survey to code implementation. It guides researchers through three structured phases with human review checkpoints, ensuring high-quality output at each stage.

**Three-Phase Pipeline:**

```
Phase 1: Literature Survey & Idea Generation
          ↓ (user review & confirm)
Phase 2: Experiment Design & Feasibility Verification  
          ↓ (user review & confirm)
Phase 3: Code Implementation & Results Logging
```

## Features

- **4 Input Modes**: Topic string, paper PDFs, paper names, or free-form description
- **Multi-Candidate Ideas**: Generates 3-5 ideas with novelty verification and self-critique
- **Citation Verification**: Extracts supporting text from PDFs to prevent hallucination
- **Feasibility Checks**: Validates dataset availability, baseline code, and GPU memory before design
- **Structured Documents**: Generates `idea_report.md`, `dev_log.md`, `code_guide.md` with strict formatting
- **Rollback Support**: Can return to Phase 2 from Phase 3 to revise experiments
- **Results Tracking**: Sub-phase 3c compares actual vs expected results with diagnostic suggestions

## Installation

### Option 1: Via Git Clone (Recommended)

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/research-scout.git
cd research-scout

# Create symlink for English version to Claude Code plugins
mkdir -p ~/.claude/plugins/marketplaces
ln -s "$(pwd)/code/skills/research-scout-en" ~/.claude/plugins/marketplaces/research-scout-en

# Restart Claude Code to activate
```

### Option 2: Manual Installation

1. Download or clone this repository
2. Copy `code/skills/research-scout-en/` directory to `~/.claude/plugins/marketplaces/research-scout-en/`
3. Restart Claude Code

### Verify Installation

In Claude Code, type:

```bash
/research-scout-en "test installation"
```

If Claude starts asking about papers or prompts to fill user_requirements.md, installation succeeded.

## Quick Start

### Phase 1: Literature Survey & Idea Generation

Start with a research topic or papers:

```bash
# Mode 1 — Topic string
/research-scout-en "battery state-of-health prediction"

# Mode 2 — With seed papers (PDFs, names, or descriptions)
/research-scout-en "battery SOH" --papers paper1.pdf "BattFormer 2023"

# Mode 3 — Free-form description (attach PDFs if available)
/research-scout-en
# Then type your research idea in plain language
```

Claude will:
1. Infer paper metadata (if names/descriptions provided) and ask for confirmation
2. Create `docs/user_requirements.md` Phase 1 section → you fill it → `/research-scout-en confirm`
3. Retrieve 15+ papers via dual-track search (user papers + autonomous web search)
4. Generate 3-5 candidate ideas with novelty checks and self-critique
5. You select one: `/research-scout-en pick 3`
6. Claude deepens the selected idea and generates `docs/idea_report.md` Part I
7. Attempts to download PDFs; prompts if any fail

**Phase 1 Review Checkpoint** — Claude stops here. Review `docs/idea_report.md` Part I, then:
- `/research-scout-en step2` — confirm and advance to Phase 2
- `/research-scout-en revise "feedback"` — regenerate Part I with changes

### Phase 2: Experiment Design

After reviewing Phase 1 output:

```bash
/research-scout-en step2
```

Claude will:
1. Check `docs/user_requirements.md` Phase 2 section (prompts you to fill if empty)
2. Read full `idea_report.md` and retrieve experiment conventions from literature
3. Design complete experiment plan (datasets, metrics, baselines, ablations)
4. **Feasibility verification** (before writing):
   - ✅ Dataset download links still valid?
   - ✅ Baseline code repositories accessible?
   - ✅ GPU memory sufficient for proposed config?
5. Append Part II to `idea_report.md` with verification summary

**Phase 2 Review Checkpoint** — Claude stops. Review experiment design, then:
- `/research-scout-en step3` — confirm and advance to Phase 3
- `/research-scout-en revise "feedback"` — regenerate Part II

### Phase 3: Code Implementation

After reviewing Phase 2 output:

```bash
/research-scout-en step3
```

Claude will:

**Sub-phase 3a — Project Structure Design:**
1. Check `docs/user_requirements.md` Phase 3 section
2. Choose Strategy A (based on existing project) or Strategy B (from scratch)
3. Show structure → `/research-scout-en confirm` to proceed or `/research-scout-en revise-structure "feedback"`

**Sub-phase 3b — Code Implementation:**
1. Create `docs/dev_log.md` and `docs/code_guide.md`
2. Implement in order: `requirements.txt` → `configs/` → `README.md` → `src/` → `scripts/` → `baselines/`
3. **After each file**: update progress table + add log entry + update code_guide.md corresponding section
4. `requirements.txt` rule: NO `torch`/`torchvision`/`torchaudio`, library names only, no version pins

**Sub-phase 3c — Results Logging:**

After running experiments locally:

```bash
/research-scout-en log-results
# Claude prompts for experiment output
# Fills actual results into Part II table
# Compares vs expected, provides diagnosis if below target
```

### Rollback to Phase 2

If Phase 3 reveals experiment design issues:

```bash
/research-scout-en back-to-step2 "dataset inaccessible"
# Archives dev_log.md
# Marks Part II status as REVISING
# Run /research-scout-en revise "feedback" to update Part II
# Then /research-scout-en step3 to restart coding
```

## Commands Reference

| Command | Phase | Description |
|---------|-------|-------------|
| `/research-scout-en "topic"` | 1 entry | Start with research direction |
| `/research-scout-en --papers <files/names>` | 1 entry | Start with seed papers |
| `/research-scout-en` (free-form) | 1 entry | Extract from user description |
| `/research-scout-en confirm` | 1, 3 | Confirm papers, PDFs, or structure |
| `/research-scout-en revise-paper {n} "fix"` | 1 | Fix one inferred paper entry |
| `/research-scout-en skip-papers` | 1 | Skip missing PDFs |
| `/research-scout-en pick {n}` | 1 | Select candidate idea |
| `/research-scout-en step2` | 1→2 | Advance to experiment design |
| `/research-scout-en step3` | 2→3 | Advance to coding |
| `/research-scout-en revise "feedback"` | 1, 2 | Regenerate current phase doc |
| `/research-scout-en revise-structure "feedback"` | 3 | Adjust project structure |
| `/research-scout-en back-to-step2 "reason"` | 3 | Rollback to Phase 2 |
| `/research-scout-en log-results` | 3c | Record experiment results |

## Output Files

```
docs/
  idea_report.md        # Phase 1 Part I + Phase 2 Part II
  dev_log.md            # Phase 3 change log
  code_guide.md         # Phase 3 implementation reference
  user_requirements.md  # User inputs per phase (never copied into main docs)
  papers/               # Downloaded PDFs (filename = full paper title)
code/
  src/, scripts/, configs/, baselines/
  data/, results/, logs/  # gitignored
  README.md, requirements.txt
```

## Template Flexibility

All documents follow flexible template rules:

- **Required chapters**: Must appear (content can be "N/A")
- **Optional chapters**: Include only when relevant (e.g., Data Format chapter omitted for pure algorithm work)
- **Extensible chapters**: Add freely when research needs it

Content volume hints ("3-5 sentences") are guidance, not hard limits.

### Document Preferences

In `user_requirements.md` any phase section, you can add:

```markdown
### Document Preferences
- Language: full English (default) / Chinese body + English headings / full Chinese
- Introduction detail: placeholder draft (default) / publication-ready detailed version
- Data format chapter: generate (default) / omit
- Other: {your preferences}
```

## FAQ

### How to install both Chinese and English versions?

```bash
# Chinese version
ln -s "$(pwd)/code/skills/research-scout-zh" ~/.claude/plugins/marketplaces/research-scout-zh

# English version
ln -s "$(pwd)/code/skills/research-scout-en" ~/.claude/plugins/marketplaces/research-scout-en
```

### Claude doesn't trigger the skill?

1. Check command spelling: `/research-scout-en` (with `-en` suffix)
2. Restart Claude Code
3. Verify symlink path: `ls -la ~/.claude/plugins/marketplaces/`

### Can I modify generated document formats?

Yes. Declare in "Document Preferences" section in `user_requirements.md`, or directly edit `skills/research-scout-en/references/document-formats.md`.

### Phase 1 ideas not satisfactory?

Run `/research-scout-en revise "more specific direction guidance"` — Claude will regenerate candidate ideas.

### How to recover from failed experiments?

Use `/research-scout-en back-to-step2 "failure reason"`, revise experiment design, then re-enter Phase 3.

## Project Structure

```
code/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   ├── research-scout-en/      # English version skill
│   │   ├── SKILL.md
│   │   └── references/
│   │       ├── phase1-idea-generation.md
│   │       ├── phase2-experiment-design.md
│   │       ├── phase3-implementation.md
│   │       ├── document-formats.md
│   │       ├── template-flexibility.md
│   │       └── user-requirements-template.md
│   └── research-scout-zh/      # Chinese version skill
│       └── ...
├── LICENSE
├── README.md (中文)
└── README.en.md (this file)
```

## Contributing

Issues and Pull Requests are welcome!

Improvement directions:
- Support for more domain-specific paper retrieval sources
- Enhanced PDF parsing for citation verification
- Experiment result visualization templates
- Support for more programming languages/frameworks

## License

MIT License - see [LICENSE](LICENSE)

## Acknowledgments

Built on [Claude Code](https://code.claude.com) skill framework.
