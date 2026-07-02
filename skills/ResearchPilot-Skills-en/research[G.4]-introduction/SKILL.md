---
name: research[G.4]-introduction
description: >
  ResearchPilot Research Assistant [Phase G.4]: Write manuscript Introduction
version: 2.0.0
license: LICENSE
---

# Phase G.4: Introduction

> **user_requirements.md priority**: All user constraints in `docs/user_requirements.md` **take precedence over any default instruction in this skill**. Always read it before generating output.

## Overview

### Paper Writing Stage Chain

| Skill | Responsibility |
|-------|---------------|
| `/research[G.0]-plan` | Update idea_report → plan structure/figures → select format |
| `/research[G.1]-method` | Write / revise Method |
| `/research[G.2]-experiments` | Write / revise Experiments |
| `/research[G.3]-abstract` | Write / revise Abstract |
| `/research[G.4]-introduction` | Write / revise Introduction |
| `/research[G.5]-related` | Write / revise Related Works |
| `/research[G.6]-conclusion` | Write / revise Conclusion + References |
| `/research[G.7]-review` | Full-paper review (five dimensions + claim-evidence) |

---

## Command

```
/research[G.4]-introduction
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


**Prerequisite**: G.3 Abstract written

---

## Before Writing: Required Steps

1. Read the full manuscript (avoid disconnection from already-written sections)
2. Read all existing references (References section or .bib file)
3. Read the `=== Paper Architecture ===` comment block at the top of the manuscript
4. Read `docs/idea_report.md` and `docs/dev_log.md` (find answers to writing questions here first)
5. Read example analysis if `docs/manuscripts/examples/style-notes.md` exists
6. Scan all annotations in the manuscript, list pending ones
7. Confirm writing plan with user before writing anything

See `references/common-writing-constraints.md` for full details.

---

## Introduction Section-Specific Requirements

**Backward Reasoning Before Writing (Master-cai introduction.md)**:
Answer these four questions first (from idea_report.md):
1. What technical problem do we solve, and why is there no well-established solution?
2. What are the contributions of our pipeline?
3. What are the benefits and new insights from our contributions?
4. How to use prior methods to lead readers to our solved challenge?

**Five-Part Structure**:
- Part 1: Task and application
- Part 2: SOTA failure + root technical reason (RQ2)
- Part 3: Proposed method + why it works + new insight
- Part 4: Additional contributions
- Part 5: Experiment summary + contribution list

**Contribution list**: facts only, no "novel"/"significant"; each contribution maps to an experiment.

**Examples**: `references/examples/pipeline-v1.md` through `pipeline-v3.md`

---

## Version Management

Back up before writing:
```bash
cp paper.md paper_{mm-dd_hh-mm}.md   # or .tex
```
Append modification record to file header after writing (see `references/common-writing-constraints.md`).

---

## Reference Maintenance

When a new citation is needed, append immediately:

**md**:
```markdown
[N] {Author}. "{Title}." *{Journal/Conference}*, {Year}.
> Core contribution: {what this paper does, one sentence}
> Reason for citation: {where in the paper, why cited here}
```

**LaTeX .bib**:
```bibtex
% [Core contribution] {one-sentence contribution}
% [Reason for citation] {section}: {why cited here}
@article{key, ...}
```

---

## On Phase Completion

```
Introduction section written/revised.

→ Use `/research[G.5]-related` to enter Related Works.
→ Or use `/research[G.7]-review` for a full-paper review at any time.
```

---

## Reference Files

- Section guide: `references/section-guide.md`
- Common constraints: `references/common-writing-constraints.md`
- Introduction examples: `references/examples/pipeline-v1.md`, `pipeline-v2.md`, `pipeline-v3.md`
- Template flexibility: `references/template-flexibility.md`
