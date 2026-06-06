# Template Flexibility Rules

These rules take precedence over any specific template instruction in other reference files.
Read this file before generating any document.

## Three Chapter Types

Every chapter in every document belongs to one of three types:

| Type | Definition | Handling |
|------|-----------|---------|
| **REQUIRED** | Must appear in every project. Content can be "N/A" but never omitted. | Always generate. Content volume follows research complexity. |
| **OPTIONAL** | Meaningful only for certain research types. | Include when relevant; omit when not. Note omissions in file header: `> Omitted: {chapter} — {reason}` |
| **EXTENSIBLE** | Research needs it but template does not pre-define it. | Add freely. Note additions in file header: `> Extended: {chapter}` |

## Content Volume

All quantity hints ("3–5 sentences", "5–8 papers", "≤3 items") are guidance, not hard limits.

The standard: write as much as needed to fully convey the information — no more, no less.

- Research background is simple → 1–2 sentences is fine
- Related work is unusually rich → 10+ papers is fine
- Method has 6 innovation components → 6 sub-sections is fine

## Sub-section Count

Sub-section count follows content, not template slot count.

- `Proposed Method` gets one sub-section per innovation component — components have as many as the method requires
- `Per-File Implementation Details` in implementation.md gets one sub-section per py file — files have as many as the project requires
- `Dev Log Entries` in dev_log.md grows with each completed module — no cap

Sub-section titles use semantic names, never placeholder text like `{Module Name}` or `{Core Component}`.

## Chapter Classification Per Document

### idea_report.md Part 1 + Part 2 (Phase B output)

| Chapter | Type | Omit condition |
|---------|------|---------------|
| Part 1 — Motivation | REQUIRED | — |
| Part 1 — Motivation necessity points | REQUIRED | Application/theoretical/timing — mark low-confidence if evidence insufficient, cannot omit |
| Part 1 — Research Questions | REQUIRED | At least 1 primary RQ; secondary RQs optional |
| Part 1 — Key Works summary table | REQUIRED | — |
| Part 1 — Key Works detail entries | REQUIRED | — |
| Part 2 — Introduction | REQUIRED | — |
| Part 2 — Related Works | REQUIRED | — |
| Part 2 — Method | REQUIRED | — |
| References | REQUIRED | — |
| Pending Verification | OPTIONAL | All citations verified, no low-confidence content |

### idea_report.md Part 3 (Phase C output)

| Chapter | Type | Omit condition |
|---------|------|---------------|
| 0 Baseline Experiment Survey (per-paper detail entries) | REQUIRED | — |
| 0 Field Convention Synthesis | REQUIRED | — |
| Data & Code Availability Summary | REQUIRED | — |
| 1 Datasets | REQUIRED | — |
| 2 Main Experiments | REQUIRED | — |
| 2 Ablation Study | REQUIRED | — |
| 2 Additional Experiments A: field-standard (mandatory) | REQUIRED | Omit only if the field has no recurring standard additional experiment |
| 2 Additional Experiments B: extension (user-selected) | REQUIRED | Omit only if the user chooses to do no extension experiments |
| 3 Resource Estimate (reference) | REQUIRED | — |

### implementation.md (Phase D output)

> See `references/phase-implementation.md` for the detailed format. There are two formats, chosen by whether a strong baseline is used:

**Format A: Strong Baseline Rewrite**

| Chapter | Type | Omit condition |
|---------|------|---------------|
| Original Project Info | REQUIRED | — |
| Rewrite Scope Summary | REQUIRED | — |
| Full Directory Tree After Rewrite | REQUIRED | First key opening part |
| Per-File Function Table | REQUIRED | Second key opening part, per file |
| Existing Files: Rewrite Plans | REQUIRED | Precise to every function to modify |
| Data Download and Preparation | REQUIRED | — |
| Results File Format | REQUIRED | — |
| Implementation Order | REQUIRED | — |

**Format B: Build from Scratch**

| Chapter | Type | Omit condition |
|---------|------|---------------|
| Full Directory Tree | REQUIRED | First key opening part, includes notebooks/ |
| Per-File Function Table | REQUIRED | Second key opening part, per file (not just per directory) |
| Per-File Implementation Details | REQUIRED | Precise to each function's signature, parameters, return, logic |
| Data Download and Preparation | REQUIRED | — |
| Results File Format | REQUIRED | — |
| Data Format | OPTIONAL | Pure algorithm work with no custom data format |
| Implementation Order | REQUIRED | — |

### dev_log.md

| Chapter | Type | Omit condition |
|---------|------|---------------|
| Project Overview | REQUIRED | — |
| Project Architecture | REQUIRED | — |
| Model Architecture | OPTIONAL | No custom model (e.g., pure data pipeline project) |
| Project Logic | REQUIRED | — |
| Progress Table | REQUIRED | — |
| Dev Log Entries | REQUIRED | — |
| Known Issues | OPTIONAL | Omit initially; add when issues arise |

## User Document Preferences

Always read the `### Document Preferences` field in user_requirements.md before generating
any document. Honor these preferences:

- **Language**: full English (default) / full Chinese
- **Introduction detail**: placeholder draft (default) / publication-ready detailed version
- **Data format chapter**: generate (default) / omit
- **Ablation table format**: single table (default) / split by dimension
- **Free-form**: any other structural or content preference stated by the user
