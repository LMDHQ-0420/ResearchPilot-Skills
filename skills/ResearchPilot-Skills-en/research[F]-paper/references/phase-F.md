# Phase F: Paper Writing

> After Phase E (code and experiments complete), write the paper based on everything produced so far (`idea_report.md` Parts 1/2/3, `dev_log.md` experiment results, `docs/papers/` literature).

All paper files live in `docs/manuscripts/`. **Every revision is made on a freshly copied paper md — never overwrite the original**, forming a traceable version chain.

---

## Trigger

After Phase E code is complete and experiment results are recorded, Claude proactively asks whether to start paper writing:
```
Code and experiments are complete. Shall we move into paper writing?
I'll confirm the paper structure with you first, then write the first draft.
```

---

## Versioning and File Naming

Each paper md under `docs/manuscripts/` is named:
```
v{major}.{minor}-{brief summary of main change (≤15 words)}.md
```
Examples:
- `v1.0-first-draft.md`
- `v1.1-add-experiment-analysis.md`
- `v2.0-restructure-method-section.md`

**The major/minor version is decided automatically by Claude based on the size of the change**:
- **Major +1** (v1.x → v2.0): structural changes (add/remove sections, rewrite a whole chapter, method/experiment redesign)
- **Minor +1** (v1.1 → v1.2): local changes (polishing, adding paragraphs, editing captions, fixing references)

Each revision creates a new file; older versions are kept untouched.

---

## Paper Format Spec

### Language (English version skill)

- **The entire paper is in English** — title, all headings, body text, captions, references.
- The paper has **at most second-level headings** (`#` title + `##` first-level + `###` second-level; no `####`).

> `#` is the paper title (unique); `##` is first-level section headings; `###` is second-level subsection headings.

### Version annotation block under the title

Directly under the paper title, a `>` block records this version's info:
```markdown
# {Paper Title}

> **Version**: v1.0
> **Time**: {YYYY-MM-DD HH:MM}
> **Changes in this version**: First draft
```
From the second version on, "Changes in this version" states **what changed and how it differs from the previous version**, in a consistent format:
```markdown
> **Version**: v1.2
> **Time**: {YYYY-MM-DD HH:MM}
> **Changes in this version**: {what changed and how it differs from the previous version, one paragraph; consistent with prior versions}
```

### Writing-rationale annotations

- At the **start of every chapter (first-level heading) and every section (second-level heading)**, use `>` to state the writing rationale of that chapter/section.
- The body text follows the writing-rationale annotation.

### Blank `>` for user annotations

To make it easy for the user to annotate, place a **blank `>`** (just the `>` symbol, left empty) at each of:
- The start of every chapter (after the writing-rationale annotation)
- The start of every section (after the writing-rationale annotation)
- The end of every paragraph
- Below every figure/table caption

> The blank `>` is a placeholder for the user's annotations; Claude leaves it empty in the draft and reads what the user writes there during revision.

### Figures

- Every figure **must have a caption**, with a blank `>` below it
- Each figure is marked as **hand-drawn** or **Python-generated**
- Figures are cited in text as `Fig. N`

### Tables

- Every table must have a caption (table name + meaning of each row and column)
- Tables are cited in text as `Table N`

### References

- References are at the end; in-text citation format is `[x]`
- The reference list is numbered `[1]`, `[2]`, in **MLA format**
- Below each reference, use `>` to state two things (one sentence each):
```markdown
[1] {MLA-format entry}
> Main contribution: {what this paper does, one sentence}
> Reason for citing: {why this paper cites it, one sentence}
```
- All references must really exist (verified via web_search or from `docs/papers/`); never fabricate

---

## F-1 Confirm Paper Structure (first step, mandatory)

**Before writing any body text**, confirm the paper structure with the user, presenting the following:

```
Before writing the paper, let's confirm its structure:

**Overall outline** (all first- and second-level headings):
## Introduction
## Related Works
## Method
  ### {second-level heading}
## Experiments
  ### {second-level heading}
## Conclusion

**What each section covers and its writing rationale**:
- Introduction: {what it covers; writing rationale; why written this way — how it moves from background to gap to contributions}
- Related Works: {which categories of related work; rationale; why organized this way}
- Method: {...}
- Experiments: {...}
- Conclusion: {...}

**Figure/table plan**:
| ID | Type | Location | What it shows | Hand-drawn / Python-generated |
|----|------|----------|--------------|-------------------------------|
| Fig. 1 | Figure | Method | {method framework diagram} | Hand-drawn |
| Fig. 2 | Figure | Experiments | {result curves} | Python-generated |
| Table 1 | Table | Experiments | {main comparison} | Python-generated |

- Figures: state what each shows and how it's designed; distinguish hand-drawn (e.g. method framework) from Python-generated (e.g. data curves, visualizations)
- Tables: state what each shows and how it's designed

**Any additional requirements for this paper?** (target venue style, length, key selling points, etc.)

Once the structure is confirmed, I'll write the first draft.
```

Iterate with the user until the structure (outline + writing rationale + figure/table plan + extra requirements) is confirmed. Write the extra requirements into the Phase F section of `docs/user_requirements.md`.

---

## F-2 Generate the First Draft

Once the structure is confirmed, generate `v1.0-first-draft.md` under `docs/manuscripts/`:

- Strictly follow the **Paper Format Spec** above (language, heading levels, version block, writing-rationale annotations, blank `>`, captions, references)
- Write chapter by chapter per the confirmed outline and rationale
- Figures: hand-drawn ones get a figure slot + caption (marked "hand-drawn"); Python-generated ones get a slot + caption (marked "to be Python-generated"), no image generated yet
- Experiment data comes from real results recorded in `dev_log.md`; mark placeholders where no result exists and say so
- References come from `docs/papers/` and in-text citations, each with the two `>` annotation lines

Then prompt the user:
```
First draft v1.0 generated: docs/manuscripts/v1.0-first-draft.md

Please review the draft and write your revision notes at the blank > markers in the text
(blank > markers are left at the start of each chapter/section, the end of each paragraph, and below each figure/table caption).
Once done, tell me "annotations done" and I'll read them and revise.
```

---

## F-3 Revise Based on Annotations (iterative loop)

After the user says "annotations done":

1. **Automatically open the latest version** under `docs/manuscripts/` (the highest version number)
2. Read the user's annotations written at the blank `>` markers
3. Revise point by point per the annotations
4. **Copy to a new version file** (do not overwrite the old one): decide major/minor by change size, name it `v{x}.{y}-{≤15-word summary}.md`
5. Update the version block under the title (version, time `YYYY-MM-DD HH:MM`, change description)
6. In the new version, clear the handled annotation `>` markers (leave fresh blank `>` for the next round)
7. Prompt the user to review the new version and keep annotating

Repeat each loop until the user considers the paper complete.

---

## F-4 Figure/Table Generation (Claude-guided)

When Claude judges the paper is nearly settled (stable structure, content largely finalized), it **proactively guides** the user to approve generating the Python-generatable figures and tables:
```
The content is fairly stable. The following figures/tables can be Python-generated;
I can set up the generation scripts once you approve:
- Fig. 2 (result curves), Fig. 3 (feature visualization)
- Table 1 (main comparison), Table 2 (ablation results)
(Fig. 1, the method framework, is hand-drawn — you'll draw it yourself)
Generate them?
```

Once approved, generate per the spec below:

### Figures: `notebooks/image.ipynb`

- Create `notebooks/image.ipynb`
- **One cell generates one figure**
- Each cell:
  - Detailed comments stating: which **Fig. N** this is, its **caption**, and **how to read the figure**
  - The plotting code
  - Supports output to `notebooks/image/` as **SVG**, default filename `Fig_1.svg` (by number)
  - **The SVG-output line is commented out by default** (the user uncomments it to export)

```python
# Fig. 2 — {caption}
# How to read: {what it shows, axis meanings, key trend}
# ... plotting code ...
# fig.savefig('notebooks/image/Fig_2.svg', format='svg', bbox_inches='tight')  # commented by default; uncomment to export
```

### Tables: `notebooks/table.ipynb`

- Create `notebooks/table.ipynb`
- **One cell generates one table**, in a format exactly matching what the paper requires
- Each cell details: the **table name**, and the **meaning of each row and column**

```python
# Table 1 — {table name}
# Rows: {row meaning}; Columns: {column meaning}
# ... table code (output a table matching the paper format exactly) ...
```

> Hand-drawn figures (e.g. the method framework) do not go into the ipynb; the user draws them, and the body keeps the figure slot with its caption marked "hand-drawn".

---

## F-5 Completion

Once the paper is finalized and figures/tables are generated, Claude reports the final version filename and the figure/table inventory. Phase F ends.
