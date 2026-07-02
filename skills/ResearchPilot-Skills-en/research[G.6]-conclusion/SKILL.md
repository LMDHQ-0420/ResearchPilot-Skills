---
name: research[G.6]-conclusion
description: >
  ResearchPilot Research Assistant [Phase G.6]: Write manuscript Conclusion
version: 2.0.0
license: LICENSE
---

# Phase G.6: Conclusion + References

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
/research[G.6]-conclusion
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


**Prerequisite**: G.5 Related Works written

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

## Conclusion Section-Specific Requirements

**Four-Step Conclusion (Master-cai conclusion.md)**:
1. Restate the research problem (1 sentence, echo Introduction Part 2)
2. Summarize key evidence (reference contribution list, cite experiment numbers)
3. State broader impact or application value (1–2 sentences)
4. Limitations (honest, 1–2 sentences) + Future work (specific, 1–2 sentences)

**Reference verification (required in this stage)**:
- Every citation must have "Core contribution" and "Reason for citation" annotations
- Verify every citation is real (from docs/papers/ or web_search confirmed)
- Fill in any missing annotations

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
Conclusion section written/revised.

→ Use `/research[G.7]-review` to enter full-paper review.
→ Or use `/research[G.7]-review` for a full-paper review at any time.
```

---

## Reference Files

- Section guide: `references/section-guide.md`
- Common constraints: `references/common-writing-constraints.md`
- Template flexibility: `references/template-flexibility.md`
