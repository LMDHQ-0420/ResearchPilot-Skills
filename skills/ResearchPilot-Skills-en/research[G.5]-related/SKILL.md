---
name: research[G.5]-related
description: >
  Write or revise Related Works from verified literature organized by research question, clarifying relationships and differences.
version: 2.0.0
license: LICENSE
---

> At startup, read the [execution and handoff contract](references/workflow-contract.md) for authorization, state, research, and reproducibility rules.


# Phase G.5: Related Works

> **user_requirements.md priority**: All user constraints in `docs/user_requirements.md` **take precedence over any default instruction in this skill**. Read it if present before generating output.

## Command

```
/research[G.5]-related
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


**Prerequisite**: G.4 Introduction written

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

## Related Works Section-Specific Requirements

**Structure (Master-cai related-work.md)**:
- 2–4 topic subsections, each with four steps:
  Topic sentence → Representative works (3–5, with citations) → Limitation → Transition
- **Final subsection fixed as Research Gap**: synthesize limitations of all categories, point to the gap this paper fills

**Constraints**:
- Research Gap must be consistent with Introduction Part 2 — no contradictions
- No narrative lists of "XXX et al. propose..." — state the shared limitation of each category
- Every citation must explain why it is cited (which category it represents, which limitation it proves)

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
Related Works section written/revised.

→ Use `/research[G.6]-conclusion` to enter Conclusion.
→ Or use `/research[G.7]-review` for a full-paper review at any time.
```

---

## Reference Files

- Section guide: `references/section-guide.md`
- Common constraints: `references/common-writing-constraints.md`
- Template flexibility: `references/template-flexibility.md`
