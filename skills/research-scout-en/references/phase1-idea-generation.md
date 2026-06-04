# Phase 1: Literature Survey & Idea Generation

## Entry Points

Four input modes, combinable:

```bash
# Mode 1 — topic string
/research "battery SOH prediction"

# Mode 2 — papers flag (PDF files, paper names, or descriptions; mix allowed)
/research --papers paper1.pdf "Attention is All You Need" "transformer 2017 Google"

# Mode 3 — combined (recommended)
/research "battery SOH prediction" --papers paper1.pdf "BattFormer 2023"

# Mode 4 — free-form description (with or without attached PDFs)
/research
# User then types a paragraph describing their idea and attaches PDFs
```

## Step 1 — Parse Input

**Modes 1–3**: Extract topic string and/or papers list directly from command arguments.

**Mode 4 — free-form description**:
Extract the following structure and show to user for confirmation before proceeding:

```
Based on your description, I extracted:

**Research direction**: {direction}
**Your core insight**: {insight}
**Constraints**: {list}
**Papers provided**:
| # | File / Description | Treatment |
|---|-------------------|-----------|
| 1 | paper.pdf         | Read directly |
| 2 | {description}     | Infer metadata |

Confirm with `/research confirm` or correct inline.
```

After Mode 4 confirmation: write extracted content into `docs/user_requirements.md`
Phase 1 section automatically — skip the manual fill step (Step 3).

## Step 2 — Infer Paper Metadata (name/description inputs only)

For each non-PDF paper entry, infer full metadata and show for confirmation:

```
I inferred the following papers. Please confirm:

| # | Full Title | Venue | Year | First Author | One-line summary |
|---|-----------|-------|------|-------------|-----------------|
| 1 | Attention Is All You Need | NeurIPS | 2017 | Vaswani et al. | Transformer: pure attention replacing RNN |

To fix one entry: /research revise-paper 1 "correct info"
To confirm all:  /research confirm
```

`revise-paper` modifies only the specified row and re-displays the full table.
PDF inputs skip this step entirely.

## Step 3 — Read User Requirements

Check `docs/user_requirements.md` → `## Phase 1` section.
- If file missing or section empty: create file using the template in
  `references/user-requirements-template.md`, tell user to fill Phase 1 section,
  wait for `/research confirm`
- If filled (or Mode 4 auto-populated): read and apply as generation constraints

## Step 4 — Literature Retrieval (dual-track, parallel)

**Track A — user-provided papers as seeds:**
- Read PDFs directly: extract title, authors, venue, abstract, method sections
- Expand by following their reference lists and citing papers

**Track B — autonomous web_search:**
- Query: topic + user's stated direction from user_requirements
- Coverage: arXiv, NeurIPS, ICML, ICLR, CVPR, ECCV, ICCV, ACL, EMNLP, KDD, WWW
- Time range: last 3 years high-citation + classic foundational works

Merge and deduplicate both tracks. Target: ≥ 15 valid papers total.

## Step 5 — Search Self-Reflection Loop

After retrieval, verify: does each claimed research gap have ≥ 2 papers as evidence?
If not, run a focused follow-up search targeting the specific gap. Maximum 3 rounds.

## Step 6 — Generate 3–5 Candidate Ideas

Generate candidates from three angles (at least one per angle):

- **Method transfer**: adapt a mature technique from another field to this task
- **Existing method improvement**: fix a specific, identified weakness of current SOTA
- **Task reformulation**: redefine the problem structure or introduce new priors

**Novelty check for each candidate (mandatory):**
Search: `"{idea core keywords}" site:arxiv.org OR site:openreview.net`
Find the closest existing work. Label similarity: High / Medium / Low.
Auto-demote Low-novelty candidates — do not show them to user.

**Self-critique for each candidate (internal, results written into card):**
1. Is the claimed novelty real, or just renaming an existing method?
2. Do the proposed experiments actually validate the innovation (not mask weaknesses)?
3. Is baseline selection fair (no cherry-picking weak baselines)?

**Display to user:**

```
Based on literature analysis, here are {N} candidate ideas:

### Idea 1: {Title}
- **Core**: {one sentence}
- **Angle**: method transfer / improvement / reformulation
- **Novelty**: High — closest: {paper [n]}, differs by: {specific difference}
- **Feasibility**: Medium — main risk: {risk}
- **Self-critique**: {internal audit findings, including weaknesses}

### Idea 2: ...

Select with `/research pick {n}`
```

User runs `/research pick {n}` to choose one.

## Step 7 — Deepen Selected Idea

After pick:
- Expand method details: module breakdown, data flow diagram (text format), equations
- Feasibility table: compute resources, implementation timeline, innovation risk
- Baseline selection with justification for each choice

## Step 8 — Citation Content Verification

For every `>>` annotation in the draft report:
1. Open `docs/papers/{title}.pdf`
2. Locate the supporting sentence in Abstract / Introduction / Method
3. Append verified text to the annotation:

```markdown
>> This design is inspired by [3]. [3]
>> Source text: "We propose a selective state space model..." (Section 3.1)
```

If PDF unavailable:
```markdown
>> ... [3]
>> ⚠️ [low confidence: PDF unavailable, based on abstract only]
```

If PDF available but no supporting text found:
```markdown
>> ... [3]
>> ⚠️ [low confidence: no direct supporting text found in full paper]
```

Register all low-confidence entries in the `## Pending Verification` section.

## Step 9 — Write docs/idea_report.md

Generate Part I following the format in `references/document-formats.md`.

## Step 10 — Download PDFs

For every paper in the reference list, attempt download in order:
arXiv → Semantic Scholar → author homepage → OpenReview

Save as: `docs/papers/{exact reference title}.pdf`
Strip characters: `/\:*?"<>|` — preserve spaces.

**If any papers fail to download**, prompt user before continuing:

```
The following papers could not be downloaded automatically:

| # | Title | Suggested source |
|---|-------|-----------------|
| 1 | {title} | Sci-Hub / author email / library |

Place PDFs in docs/papers/ with the exact title as filename.
Run `/research confirm` when done, or `/research skip-papers` to skip.
```

On `confirm`: re-scan `docs/papers/`, match new files to reference entries, continue.
On `skip-papers`: mark remaining as `[PDF unavailable]` in reference list and continue.

User-provided PDFs (via `--papers`): copy to `docs/papers/` renamed to full title.

## Step 11 — Phase 1 Review Checkpoint

Show PDF summary then STOP:

```
PDF summary:
- ✅ {title}
- ✅ {title} (user uploaded)
- ❌ {title} [PDF unavailable]

docs/idea_report.md generated. Please review, then:
- /research step2   — confirm and enter experiment design
- /research revise "feedback"  — regenerate Part I with changes
```

Do not proceed until user runs step2 or revise.
