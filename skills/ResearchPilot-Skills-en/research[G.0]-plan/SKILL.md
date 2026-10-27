---
name: research[G.0]-plan
description: >
  Plan a paper structure, argument, and figures from the research report and real results, including restructuring existing manuscripts.
version: 2.0.0
license: LICENSE
---

> At startup, read the [execution and handoff contract](references/workflow-contract.md) for authorization, state, research, and reproducibility rules.


# Phase G.0: Paper Planning

> **user_requirements.md priority**: All user constraints in `docs/user_requirements.md` **take precedence over any default instruction in this skill**. Read it if present before generating output.

## Command

```
/research[G.0]-plan
```
> An optional natural-language instruction may follow the command. The AI will treat it as an additional constraint or supplement for this invocation.


---

## Flow Overview

```
Step 1: Update idea_report.md (compare with code, list diffs, user confirms, update in-place)
Step 2: Plan paper structure and figures (outline + per-section detail + figure/table plan)
Step 3: Ask for writing examples (before confirming structure; place in docs/manuscripts/examples/)
Step 4: Select paper format (md / LaTeX)
Step 5: Write detailed architecture comments into manuscript header
Step 6: Generate figure/table notebook cells in notebooks/figures.ipynb
```

See `references/phase-G0.md` for full details.

---

## Version Management

**idea_report.md**: Edit in-place, no backup. Prepend modification record to file header.

**Manuscript** (paper.md / paper.tex): Back up before editing, keep original as latest version:
```bash
cp paper.tex paper_{mm-dd_hh-mm}.tex
```
Append to file header after editing:
```latex
% Modified: {mm-dd_hh-mm}
% Changes: {what changed}
% Previous backup: paper_{mm-dd_hh-mm}.tex
```

---

## Non-Negotiable Constraints

1. Steps must be followed in order; each step requires user confirmation before proceeding.
2. Writing examples must be requested before confirming paper structure (Step 3 before Step 2 confirmation).
3. Architecture comments must specify every subsection title, content, and figure/table placement.
4. Rules in `references/template-flexibility.md` take precedence over any specific template instruction.

---

## On Phase Completion

```
G.0 complete.
- idea_report.md updated
- Architecture comments written into manuscript header
- figures.ipynb: {N} figure/table cells created
- Format: {md/LaTeX}

Recommended writing order (Master-cai):
Method → Experiments → Abstract → Introduction → Related Works → Conclusion

→ Use `/research[G.1]-method` to start writing Method.
```

---

## Reference Files

- Detailed flow: `references/phase-G0.md`
- Template flexibility rules: `references/template-flexibility.md`
