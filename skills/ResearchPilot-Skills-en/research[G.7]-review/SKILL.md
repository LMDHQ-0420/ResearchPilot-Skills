---
name: research[G.7]-review
description: >
  ResearchPilot Research Assistant [Phase G.7]: Full-paper review
version: 2.0.0
license: LICENSE
---

# Phase G.7: Full-Paper Review

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
/research[G.7]-review
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


**Prerequisite**: Any or all sections written

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

## Full-Paper Review Section-Specific Requirements

**Five Dimensions (Master-cai paper-review.md)**:
1. Contribution: every claimed contribution supported by experiments?
2. Writing clarity: one message per paragraph? topic sentence covers the paragraph? consistent terminology?
3. Experimental strength: main/ablation/additional experiments cover all RQs? no missing strong baselines?
4. Evaluation completeness: fair comparisons? metric selection justified?
5. Method design soundness: every design choice motivated? ablation-verified?

**Claim-evidence alignment (required)**:
Output table for every major claim in Abstract and Introduction:
```
| Claim | Evidence | Status |
|-------|----------|--------|
| ... | ... | supported / needs evidence / missing |
```
Unsupported claims must be addressed — cannot be skipped.

**Reverse outlining**: extract each paragraph's topic sentence; check if they form a coherent story.

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
Full-Paper Review section written/revised.

→ Paper writing complete.
→ Or use `/research[G.7]-review` for a full-paper review at any time.
```

---

## Reference Files

- Review guide source: `references/section-guide-source.md`
- Writing flow source: `references/writing-flow-source.md`
- Template flexibility: `references/template-flexibility.md`
