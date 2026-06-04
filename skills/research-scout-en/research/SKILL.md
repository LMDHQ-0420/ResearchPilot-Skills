---
name: research
description: >
  This skill should be used when the user wants to conduct academic research:
  generating ideas from a topic or papers, designing experiments, or implementing
  research code. Triggers on /research with a topic string, --papers flag,
  or sub-commands: step2, step3, confirm, pick, revise, revise-paper, skip-papers,
  revise-structure, back-to-step2, log-results. Also triggers when the user says
  "start research", "help me find papers", "generate a research idea", "design
  experiments for my idea", "implement based on idea report", or describes a
  research direction in free-form text with or without attached PDFs.
version: 1.0.0
license: LICENSE
---

# Research Scout

Automated three-phase academic research workflow. Each phase produces a structured
document for user review. Claude MUST stop and wait for explicit user confirmation
before advancing to the next phase.

## Phases

| Phase | Trigger | Output |
|-------|---------|--------|
| 1 — Literature Survey & Idea Generation | `/research "topic"` or `--papers` | `docs/idea_report.md` Part I |
| 2 — Experiment Design | `/research step2` | `docs/idea_report.md` Part II (appended) |
| 3 — Code Implementation | `/research step3` | `docs/dev_log.md`, `docs/code_guide.md`, `code/` |

## State Detection

Run at the start of EVERY invocation before doing anything else:

```
0. Read docs/user_requirements.md for the relevant phase section.
   If missing or section empty: create file, prompt user to fill, wait for confirm.

1. docs/idea_report.md does NOT exist → execute Phase 1
2. idea_report.md exists, no "# Part II" → Phase 1 complete
   pick {n}  → deepen selected idea
   step2     → check Phase 2 requirements, execute Phase 2
   revise    → regenerate Part I
3. idea_report.md contains "# Part II" → Phase 2 complete
   step3     → check Phase 3 requirements, execute Phase 3
   revise    → regenerate Part II
4. docs/dev_log.md exists → Phase 3 in progress
   confirm       → continue coding or confirm project structure
   log-results   → sub-phase 3c: record results
   back-to-step2 → archive dev_log, revise experiment design
```

## Commands

| Command | Phase | Action |
|---------|-------|--------|
| `/research "topic"` | Phase 1 entry | Start with research direction |
| `/research --papers <pdf/name/description>` | Phase 1 entry | Start with seed papers |
| `/research` (free-form text + optional PDFs) | Phase 1 entry | Extract topic and papers from description |
| `/research confirm` | Phase 1 / Phase 3 sub-step | Confirm paper list, PDF uploads, or project structure |
| `/research revise-paper {n} "correction"` | Phase 1 sub-step | Fix one inferred paper entry, re-display full table |
| `/research skip-papers` | Phase 1 sub-step | Mark remaining missing PDFs as [PDF unavailable] |
| `/research pick {n}` | Phase 1 sub-step | Select idea candidate n for deepening |
| `/research step2` | Phase 1 → 2 | Confirm idea report, enter experiment design |
| `/research step3` | Phase 2 → 3 | Confirm experiment design, enter coding |
| `/research revise "feedback"` | Phase 1 / Phase 2 | Regenerate current phase doc with changes |
| `/research revise-structure "feedback"` | Phase 3 sub-step | Adjust project structure before coding |
| `/research back-to-step2 "reason"` | Phase 3 | Archive dev_log, revise experiment design |
| `/research log-results` | Phase 3 sub-step 3c | Record actual results vs expected |

## Directory Layout

```
docs/
  idea_report.md        # Phase 1 + Phase 2
  dev_log.md            # Phase 3 change log
  code_guide.md         # Phase 3 implementation reference
  user_requirements.md  # User inputs — NEVER copy into main docs
  papers/               # Downloaded PDFs, filename = full paper title
code/                   # All project source code (flat, no subdir nesting)
  src/
  scripts/
  configs/
  data/                 # gitignored
  results/              # gitignored
  logs/                 # gitignored
  README.md
  requirements.txt      # NO torch/torchvision/torchaudio; no version pins
```

## Workflow Details

Full instructions for each phase are in `references/`:

- Phase 1 step-by-step: see `references/phase1-idea-generation.md`
- Phase 2 step-by-step: see `references/phase2-experiment-design.md`
- Phase 3 step-by-step: see `references/phase3-implementation.md`
- Document format specs: see `references/document-formats.md`
- Template flexibility rules: see `references/template-flexibility.md`
- user_requirements.md template: see `references/user-requirements-template.md`

## Non-Negotiable Constraints

1. Never advance phases without user confirmation. Every phase ends with a STOP + review checkpoint.
2. Never fabricate citations. Verify all references via web_search. Unverifiable entries get `[to verify]`.
3. Never silently hide uncertainty. Low-confidence claims get `⚠️ [low confidence: reason]` and a Pending Verification entry.
4. requirements.txt never contains torch, torchvision, or torchaudio.
5. user_requirements.md content is never copied into main docs. Main docs show results only.
6. Progress table `✅ Done` means run-verified, not just written.
7. code_guide.md and dev_log.md update in sync with each completed file — no batch updates.
8. If a phase output already exists, ask "already exists — overwrite?" before regenerating.
9. Documents default to Chinese body + English headings unless user_requirements specifies otherwise.
10. Template flexibility rules in `references/template-flexibility.md` take precedence over any specific template instruction.
