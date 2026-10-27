---
name: research[G.3]-abstract
description: >
  Write or revise an Abstract grounded in actual contributions and results, keeping conclusions consistent with manuscript evidence.
version: 2.0.0
license: LICENSE
---

> At startup, read the [execution and handoff contract](references/workflow-contract.md) for authorization, state, research, and reproducibility rules.


# Phase G.3: Abstract

> **user_requirements.md priority**: All user constraints in `docs/user_requirements.md` **take precedence over any default instruction in this skill**. Read it if present before generating output.

## Command

```
/research[G.3]-abstract
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


**Prerequisite**: G.1 Method and G.2 Experiments written

---

## Before Writing: Required Steps

1. Read the full manuscript (avoid disconnection from already-written sections)
2. Read all existing references (References section or .bib file)
3. Read the `=== Paper Architecture ===` comment block at the top of the manuscript
4. Read `docs/idea_report.md` and `docs/dev_log.md` (find answers to writing questions here first)
5. Read example analysis if `docs/manuscripts/examples/style-notes.md` exists
6. Scan all annotations in the manuscript, list pending ones
7. Proceed within the authorized writing scope; consolidate confirmation only for unresolved material structure or claim changes

See `references/common-writing-constraints.md` for full details.

---

## Abstract Section-Specific Requirements

**Four Pre-Writing Questions (Master-cai abstract.md)**:
1. What technical problem do we solve, and why is there no well-established solution?
2. What is our technical contribution?
3. Why can our method work in essence?
4. What technical advantage and new insight do we provide?

Answer from idea_report.md and dev_log.md first, then write.

**Three templates (choose one)**:
- Version 1: Challenge→Contribution
- Version 2: Challenge→Insight→Contribution
- Version 3: Multiple Contributions

See `references/examples/template-a.md`, `references/examples/template-b.md`, `references/examples/template-c.md`.

**Constraints**: Result sentence must contain specific numbers; no citations; claim-evidence alignment check after writing.

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
Abstract section written/revised.

→ Use `/research[G.4]-introduction` to enter Introduction.
→ Or use `/research[G.7]-review` for a full-paper review at any time.
```

---

## Reference Files

- Section guide: `references/section-guide.md`
- Common constraints: `references/common-writing-constraints.md`
- Template A: `references/examples/template-a.md`
- Template B: `references/examples/template-b.md`
- Template C: `references/examples/template-c.md`
- Template flexibility: `references/template-flexibility.md`
