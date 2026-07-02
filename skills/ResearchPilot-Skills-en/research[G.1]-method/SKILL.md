---
name: research[G.1]-method
description: >
  ResearchPilot Research Assistant [Phase G.1]: Write manuscript Method
version: 2.0.0
license: LICENSE
---

# Phase G.1: Method

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
/research[G.1]-method
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


**Prerequisite**: G.0 planning complete, architecture comments written into manuscript

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

## Method Section-Specific Requirements

**Three Questions Before Writing (for each module)**:
1. How does this module work? (read from code)
2. Why is this module needed? (corresponds to RQ2 bottleneck, from idea_report)
3. Why does this module work? (theoretical intuition or prior evidence)

**Three-Element Order (Master-cai method.md)**:
For each module subsection: Module Design → Motivation → Technical Advantage

**Formula constraint**: After every formula, explain all variable meanings.

**Writing order**: Overview first → each module → training objective

**Examples**: `references/examples/example-of-the-three-elements.md`

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
Method section written/revised.

→ Use `/research[G.2]-experiments` to enter Experiments.
→ Or use `/research[G.7]-review` for a full-paper review at any time.
```

---

## Reference Files

- Section guide: `references/section-guide.md`
- Common constraints: `references/common-writing-constraints.md`
- Three-element example: `references/examples/example-of-the-three-elements.md`
- Module motivation patterns: `references/examples/module-motivation-patterns.md`
- Section skeleton: `references/examples/section-skeleton.md`
- Template flexibility: `references/template-flexibility.md`
