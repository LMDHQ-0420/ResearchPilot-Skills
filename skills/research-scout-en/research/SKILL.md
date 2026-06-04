---
name: research
description: >
  Use this skill when the user wants to conduct academic research: generating
  ideas from a research direction or papers, deepening an idea, designing
  experiments, or implementing research code. The trigger format requires a
  research description after /research — /research alone with no content is
  not accepted.
version: 2.0.0
license: LICENSE
---

# Research Scout

Automated academic research workflow, from direction exploration to code
implementation. The flow advances naturally through conversation — Claude
proactively asks the user at each node whether to continue, so no commands
are needed to switch phases.

---

## Commands

| Command | Description |
|---------|-------------|
| `/research research direction description` | Start the full research flow (no quotes needed) |
| `/research --papers <pdf/name/description>` | Start the flow with reference papers |
| `/research download-paper description [--to "path"]` | Standalone single-paper download (independent of flow, usable at any time) |

> **`/research download-paper`** is a standalone command that does not depend
> on any flow state. It can be used at any time; specify a paper description
> and an optional save path (default `docs/papers/`). After download, Claude
> outputs the full file path.

---

## Five-Phase Flow

```
Phase A: Direction Exploration (iterative)
  Describe direction → search papers → download → propose 5 idea directions
  → user selects/modifies → re-search → re-download → refine
  → Claude asks for confirmation → loop until direction is settled

Phase B: Idea Deepening (iterative)
  Build idea_report.md Part 1 + Part 2 → search/download papers
  → user gives feedback → refine → Claude asks for confirmation
  → loop until idea is polished

Phase C: Experiment Design (iterative)
  Generate idea_report.md Part 3 → user gives feedback → refine
  → Claude asks for confirmation → loop until experiment design is complete

Phase D: Implementation Design (iterative)
  Generate implementation.md (highly detailed, directly guides coding)
  → user gives feedback → refine → Claude asks for confirmation
  → loop until implementation plan is complete

Phase E: Coding
  Code according to implementation.md
  Maintain dev_log.md in sync
```

Phase transitions are all driven by Claude proactively asking, for example:
> "The direction is now well-defined. Are you happy with it? If so, we can
> move into the idea deepening phase."

---

## Directory Structure

```
docs/
  idea_report.md        # Phase B output: Part 1+2; Phase C appends Part 3
  implementation.md     # Phase D output, detailed implementation guide
  dev_log.md            # Phase E coding log
  user_requirements.md  # Collected by Claude through conversation, auto-maintained
  papers/               # Downloaded paper PDFs / abstract TXTs
code/
  README.md             # Environment setup, data prep, run commands (generated early in Phase E)
  src/ scripts/ configs/ baselines/
  data/ results/ logs/  # gitignored
  requirements.txt      # Library names only, no versions, no torch/torchvision/torchaudio
```

---

## State Detection

On every invocation, determine the current state in this order:

```
/research download-paper → execute standalone download, do not enter the flow

/research (no content) → refuse, respond: "Please provide a research direction, e.g.: /research I want to improve battery SOH prediction"

docs/idea_report.md does not exist
  → Phase A: Direction Exploration

idea_report.md exists, does not contain "## Part 3"
  → Phase A/B in progress (check whether Part 2 exists to distinguish)

idea_report.md contains "## Part 3", docs/implementation.md does not exist
  → Between Phase C and D

implementation.md exists, docs/dev_log.md does not exist
  → Phase D complete, ready to enter Phase E

dev_log.md exists
  → Phase E: Coding in progress
```

---

## Flow Details

Full step-by-step instructions are in `references/`:

- Phases A+B+C: see `references/phase-research.md`
- Phases D+E: see `references/phase-implementation.md`
- Document format specs: see `references/document-formats.md`
- Template flexibility rules: see `references/template-flexibility.md`
- User requirements collection: see `references/user-requirements-template.md`

---

## Paper Download Logic

Paper downloads use the arXiv API, integrated into the flow and also
independently triggerable. Full download logic is in the "Paper Download"
section of `references/phase-research.md`.

---

## Non-Negotiable Constraints

1. Phase transitions must be initiated by Claude asking the user for
   confirmation — never skip automatically.
2. Never fabricate citations. All references must be verified via web_search.
   Unverifiable entries get `[to verify]`.
3. Never hide uncertainty. Low-confidence content gets
   `⚠️ [low confidence: reason]`.
4. requirements.txt must not contain torch, torchvision, or torchaudio.
5. user_requirements.md is collected and maintained by Claude through
   conversation — users never need to manually edit it. Main docs show
   results only.
6. dev_log.md is updated in sync with each completed file — no batch updates.
7. Rules in `references/template-flexibility.md` take precedence over any
   specific template instruction.
8. After a `download-paper` command completes, Claude must output the full
   file path.
