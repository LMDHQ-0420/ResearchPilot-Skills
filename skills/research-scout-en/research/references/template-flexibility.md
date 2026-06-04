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
| Part 1 — Development Timeline | REQUIRED | — |
| Part 1 — Key Works | REQUIRED | — |
| Part 2 — Introduction | REQUIRED | — |
| Part 2 — Related Works | REQUIRED | — |
| Part 2 — Method | REQUIRED | — |
| References | REQUIRED | — |
| Pending Verification | OPTIONAL | All citations verified, no low-confidence content |

### idea_report.md Part 3 (Phase C output)

| Chapter | Type | Omit condition |
|---------|------|---------------|
| Feasibility Verification Summary | REQUIRED | — |
| Datasets | REQUIRED | — |
| Main Experiments | REQUIRED | — |
| Ablation Study | REQUIRED | — |
| Additional Experiments | OPTIONAL | Method does not involve visualization, efficiency, or robustness analysis |

### implementation.md (Phase D output)

| Chapter | Type | Omit condition |
|---------|------|---------------|
| Project Origin | REQUIRED | — |
| Project Structure | REQUIRED | — |
| Per-File Implementation Details | REQUIRED | — |
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

- **Language**: Chinese body + English headings (default) / full English / full Chinese
- **Introduction detail**: placeholder draft (default) / publication-ready detailed version
- **Data format chapter**: generate (default) / omit
- **Ablation table format**: single table (default) / split by dimension
- **Free-form**: any other structural or content preference stated by the user
