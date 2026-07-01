# Phase A Detailed Flow: Direction Exploration

: Direction Exploration, Idea Deepening, Experiment Design

---

## Paper Download Logic

All paper downloads — whether auto-triggered within the flow or via the
standalone `/research download-paper` command — use the following logic:

```bash
INPUT="{paper title, arXiv ID, OpenReview ID, or URL}"
OUTPUT_DIR="${specified_path:-./docs/papers}"
mkdir -p "$OUTPUT_DIR"

TITLE=""
PDF_URL=""

# ── Step 1: detect input type, try arXiv ─────────────────────────────────

if echo "$INPUT" | grep -qE '^[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?$'; then
  ARXIV_ID="$INPUT"
elif echo "$INPUT" | grep -qE 'arxiv\.org/(abs|pdf)/'; then
  ARXIV_ID=$(echo "$INPUT" | grep -oE '[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?')
else
  # Search arXiv by title
  QUERY=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$INPUT")
  API_RESULT=$(curl -s "https://export.arxiv.org/api/query?search_query=ti:${QUERY}&max_results=1")
  ARXIV_ID=$(echo "$API_RESULT" | grep -oE 'arxiv\.org/abs/[0-9]{4}\.[0-9]{4,5}' | grep -oE '[0-9]{4}\.[0-9]{4,5}' | head -1)
fi

if [ -n "$ARXIV_ID" ]; then
  # Fetch official arXiv title
  META=$(curl -s "https://export.arxiv.org/api/query?id_list=${ARXIV_ID}")
  TITLE=$(echo "$META" | python3 -c "
import sys, re, html
c = sys.stdin.read()
m = re.search(r'<entry>.*?<title>(.*?)</title>', c, re.DOTALL)
if m:
    t = html.unescape(m.group(1).strip().replace('\n', ' '))
    print(re.sub(r'\s+', ' ', t))
")
  PDF_URL="https://arxiv.org/pdf/${ARXIV_ID}"
fi

# ── Step 2: arXiv not found, try OpenReview ───────────────────────────────

if [ -z "$PDF_URL" ]; then
  # Check if input is an OpenReview URL or looks like a forum ID
  if echo "$INPUT" | grep -qE 'openreview\.net'; then
    OR_ID=$(echo "$INPUT" | grep -oE '[?&]id=([A-Za-z0-9_-]+)' | sed 's/[?&]id=//')
  elif echo "$INPUT" | grep -qE '^[A-Za-z0-9_-]{8,}$'; then
    OR_ID="$INPUT"
  else
    # Search OpenReview API v2 by title
    OR_QUERY=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$INPUT")
    OR_RESULT=$(curl -s "https://api2.openreview.net/notes?content.title=${OR_QUERY}&limit=1")
    OR_ID=$(echo "$OR_RESULT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    notes = data.get('notes', [])
    if notes:
        print(notes[0].get('forum', ''))
except:
    pass
")
    # Fall back to API v1 if v2 returns nothing
    if [ -z "$OR_ID" ]; then
      OR_RESULT=$(curl -s "https://api.openreview.net/notes?content.title=${OR_QUERY}&limit=1")
      OR_ID=$(echo "$OR_RESULT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    notes = data.get('notes', [])
    if notes:
        print(notes[0].get('forum', ''))
except:
    pass
")
    fi
  fi

  if [ -n "$OR_ID" ]; then
    # Fetch official OpenReview title
    OR_META=$(curl -s "https://api2.openreview.net/notes?forum=${OR_ID}&limit=1")
    TITLE=$(echo "$OR_META" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    notes = data.get('notes', [])
    if notes:
        t = notes[0].get('content', {}).get('title', '')
        if isinstance(t, dict):
            t = t.get('value', '')
        print(t)
except:
    pass
")
    PDF_URL="https://openreview.net/pdf?id=${OR_ID}"
  fi
fi

# ── Step 3: download ──────────────────────────────────────────────────────

if [ -z "$PDF_URL" ]; then
  echo "❌ Download failed: not found on arXiv or OpenReview — \"$INPUT\""
else
  [ -z "$TITLE" ] && TITLE="$INPUT"
  FILENAME=$(echo "$TITLE" | python3 -c "
import sys, re
t = sys.stdin.read().strip()
t = re.sub(r'[/\\\\:*?\"<>|]', '', t)
print(t + '.pdf')
")
  curl -L --silent "$PDF_URL" -o "${OUTPUT_DIR}/${FILENAME}"
  if [ -s "${OUTPUT_DIR}/${FILENAME}" ]; then
    echo "✅ Saved: ${OUTPUT_DIR}/${FILENAME}"
  else
    echo "❌ Download failed: URL found but PDF not accessible ($PDF_URL)"
  fi
fi
```

**Standalone command `/research download-paper "description" [--to "path"]`:**
- Does not depend on any flow state; usable at any time
- Saves to `docs/papers/` by default; `--to` specifies an alternate path
- Must output the full file path after a successful download
- On failure, explain the reason

**Download failure handling (within the flow):**
1. Inform the user which papers failed to download
2. State whether Claude can access the paper's abstract
3. Ask the user to place the PDF in `docs/papers/` with the full paper title as the filename
4. If the user does not provide a PDF and Claude has the abstract: create `docs/papers/{full paper title}.txt` and save the abstract there
5. If the user does not provide a PDF and Claude has no abstract: annotate the citation with `⚠️ [low confidence: PDF unavailable, abstract also unavailable]`

---

## Literature Reading Principle (applies to idea generation and every adjustment)

> This principle applies to **the initial idea generation** as well as **any later adjustment of the idea** (including adjustments triggered by backtracking from Phase D/E — see the backtracking flow in `phase-implementation.md`).

Before writing or revising the idea each time, you must **read existing literature extensively**:

- **Read what is already downloaded first; do not rush to download new papers**: first read closely the relevant papers already in `docs/papers/`, mastering them as the basis for design.
- **Download more only when needed**: when you find the existing literature **cannot support the current design decision, or cannot answer a newly surfaced question**, then re-run the "paper download logic" (search → confirm the download list with the user → download → read closely) and add the new papers to `docs/papers/`.
- Every key design decision should have literature support, with the source annotated via `>` and a citation number; unsupported claims go on the to-verify list or are marked low-confidence.

---

## Phase A: Direction Exploration

### Trigger

User inputs `/research "research direction description"` or `/research --papers ...`.

If the user inputs only `/research` (no content), reply:
```
Please tell me the direction you want to research. For example:
/research "I want to work on battery SOH prediction; existing Transformer methods don't exploit local features"
```

### Confirmation Card (shared by Phases A / B)

Every output in Phase A and Phase B begins with a "confirmed content card", so the user can always see the currently locked consensus. Format:

```
━━━━━━━━━━ Confirmed Content ━━━━━━━━━━
Research direction: {one-sentence description of the confirmed direction}
Primary RQ: {confirmed primary RQ}
Secondary RQ: {confirmed secondary RQ}
Direction constraints: {constraints the user placed on the research direction}
RQ constraints: {constraints the user placed on the research questions}
Reference papers: {papers the user explicitly named as required references}
Technical framework: {framework confirmed in Phase B, one line}
Pipeline: {pipeline confirmed in Phase B, one line}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Card rules:**
- **Output only confirmed, non-empty field lines; omit the entire line for any unconfirmed or empty field** — do not write placeholders like "TBD" or "none"
- If nothing has been confirmed yet (very start of the flow), do not output the card at all
- Fields are plain text, not bold, neatly aligned; wrapped top and bottom with `━` rules
- The "Technical framework" and "Pipeline" lines appear only in Phase B; not shown in Phase A
- The card only holds content "confirmed by the user"; unconfirmed direction/RQ candidates do not enter the card
- The card excludes the detailed literature search list (that is process content); only when the user explicitly names a paper as required reading is it listed under "Reference papers"
- Card content stays in sync with the Phase A section of `docs/user_requirements.md` (see `references/user-requirements-template.md`)
- After confirming new content, update `user_requirements.md` first, then refresh the card at the top of the next output

### A-1 Parse Input, Collect Requirements

Extract from user input: research direction, existing ideas, reference papers, constraints.

If the input lacks sufficient detail, ask all questions in a single turn (not across multiple rounds):
```
Before starting the search, a few quick questions:
1. What do you see as the core problem with existing methods?
2. What angle do you want to approach this from?
3. Are there any papers you particularly want to reference?
4. Any other constraints? (e.g., must run on a single GPU)
```

Write collected information to the Phase A section of `docs/user_requirements.md` (distinguishing direction constraints / RQ constraints).

### A-2 Initial Literature Search

**Prioritize top venues**: NeurIPS, ICML, ICLR, CVPR, ECCV, ICCV, ACL, EMNLP, KDD, IEEE TII, IEEE TNNLS, etc.
ArXiv versions may be downloaded, but use the formally published information as the reference.

**Search self-reflection**: check that each research gap is supported by ≥2 papers; if not, run additional searches (up to 3 rounds).

**Target: at least 15 valid references.**

If 15 papers have not been found after 3 rounds, explain the shortfall when presenting the download list:
```
Note: this direction has limited literature — only {N} papers found so far (target: 15).
Reason: {field is nascent / cross-disciplinary intersection / limited keyword coverage}.
Would you like to continue with the current {N} papers, or should I try a different search strategy?
```
Wait for user confirmation before proceeding.

### A-3 Confirm Download List with User

```
Initial search complete. The following papers are recommended for download (you can add or remove):

| # | Title | Publication | arXiv Version | Summary | Relevance |
|---|-------|------------|--------------|---------|-----------|
| 1 | {title} | {Venue Year} | {ID or N/A} | {one sentence on what the paper does} | {one sentence on why it's relevant to the current direction} |
...

Papers with an arXiv version will be downloaded automatically; papers without one must be provided manually.
Reply "confirm" to proceed, or let me know any changes.
```

### A-4 Execute Downloads, Report Results

Run the download logic in batch. After completion, report:
```
Download results:
✅ {title}.pdf
✅ {title}.pdf
❌ {title} (no arXiv version; Claude can / cannot access the abstract)
   → To fill this in, place the PDF in docs/papers/ with the full paper title as the filename
```

If any downloads fail, ask the user whether to fill them in manually, then continue.

### A-4.5 Ask Whether to Introduce Each Paper in Detail

After all downloads complete (including papers the user filled in manually), recognizing that the user may not have read some of these papers, proactively ask whether Claude should give a detailed introduction to each paper:
```
All papers are downloaded. You may not have read some of them yet.
Would you like me to give a detailed introduction to each paper? If so, I will cover four points per paper:
1. What research problem it solves;
2. What method it uses and why it is designed that way;
3. How well the method performs;
4. What this paper means for our research.

(Regardless of your choice, the per-paper entries under Part 1 Key Works will include **every** paper you downloaded, each marked as to whether it is a key work.)

Reply "yes" or "no".
```
Record the user's choice (yes / no to per-paper detailed introductions) in the Phase A section of `docs/user_requirements.md`, for use when assembling Key Works in B-0.

### A-5 Anchor the Problem Domain, Confirm the Research Direction Step by Step

> Goal of this step: interact thoroughly with the user and converge step by step to one clear research direction. Do not dump 5 directions at once for the user to pick; instead, guide the user to confirm progressively.

**Step 1: Problem domain report**. Based on the downloaded literature, report to the user across three dimensions to help build a global picture:
```
{confirmation card}

I have read through the retrieved literature. Here is the full picture of this direction:

**① What problem it mainly addresses**: {the core task and goal of this direction}
**② Major method families**: {breakdown of method categories, one sentence each}
**③ Most active sub-directions in the past two years**: {2–3 heating-up sub-directions}

Which part interests you most / do you most want to dig into? Or do you already have a more specific entry point in mind?
```

**Step 2: Discuss candidate directions one at a time**. Based on the user's interest, focus on 1–2 candidate directions at a time for in-depth discussion (core idea, literature basis, innovation angle, main challenges, novelty assessment), going back and forth with the user until they clearly settle on one direction.

**Step 3: Lock the direction**. After the user confirms, write the direction into `user_requirements.md` and fill the "Research direction" field of the confirmation card in the next output.

### A-6 Refine and Confirm RQs Layer by Layer

> After the research direction is locked, refine RQs in three layers — confirm each in order, never dump all at once.

**Three-Layer RQ Structure**:

| Layer | Name | What it answers | Corresponding experiments |
|-------|------|----------------|--------------------------|
| RQ1 | Core Question | What big problem am I solving (field pain point) | Main experiment |
| RQ2 | Mechanism Question | Why do existing methods fall short (key bottleneck) | Ablation experiments |
| RQ3 | Boundary Question | Under what conditions does the method work; its limits | Additional experiments (optional) |

> RQ1 defines the research goal. RQ2 directly motivates the Method design — answering it explains why the proposed approach solves RQ1. RQ3 makes the argument more rigorous. Without all three layers, the proof chain is incomplete.

---

**Step 1: Confirm RQ1 (Core Question)**

RQ1 is a broad question that defines the entire research goal. Form: one complete broad question corresponding to a field pain point.

```
{Confirmation card}

Based on the confirmed research direction, I propose the following core question (RQ1):

**RQ1: {A broad question directly describing the field pain point, e.g.
"How can battery SOH prediction accuracy be improved?"
"How can retrieval precision in RAG systems be enhanced?"}**

- Corresponding gap: {points to which specific limitation in Section 1, cite supporting paper [n]}
- Novelty: {targeted search result — has existing work fully answered this question?}
- Corresponding experiment: {verified by the main experiment; what specifically is validated}

Is this framing of the core question accurate?
```

Iterate with the user until RQ1 is confirmed. Write to `user_requirements.md` and refresh the confirmation card.

---

**Step 2: Confirm RQ2 (Mechanism Question)**

RQ2 is a deep analysis of RQ1: **why do existing methods fall short** — which specific mechanism or property is the bottleneck. RQ2 directly determines the Method design logic.

```
{Confirmation card}

With RQ1 confirmed, let's dig deeper: why can't existing methods answer RQ1 well? I propose the mechanism question (RQ2):

**RQ2: {A mechanistic analysis question, e.g.
"Are local temporal features the key bottleneck for SOH prediction accuracy?"
"How much does the semantic gap between queries and documents affect retrieval precision?"}**

- Relationship to RQ1: {how RQ2 explains the core obstacle in RQ1 — answering RQ2 provides the design rationale for solving RQ1}
- Corresponding gap: {has existing work analyzed this mechanism? cite supporting paper [n]}
- Corresponding experiment: {what ablation study verifies this}

Does this mechanism question accurately identify the core bottleneck in existing methods?
```

Iterate until RQ2 is confirmed. Write to `user_requirements.md` and refresh the card.

---

**Step 3: Confirm RQ3 (Boundary Question, optional)**

RQ3 asks about the method's applicable scope or generalizability. May be omitted if scope is already focused.

```
{Confirmation card}

Optional: should we add a boundary question (RQ3)?

**RQ3 candidate: {A scope/generalization question, e.g.
"Does the proposed local feature module generalize across different battery chemistries?"
"Is the query rewriting strategy stable across different domain knowledge bases?"}**

- Relationship to RQ1/RQ2: {questions the scope of conclusions, making the overall argument more rigorous}
- Corresponding experiment: {what additional experiment verifies this}

Is RQ3 needed? If the research is already focused enough, it can be omitted.
```

Confirm with the user whether to include RQ3. If yes, write to `user_requirements.md`; if no, skip.

---

**Step 4: Necessity Argument**

After all RQs are confirmed, write the necessity argument (application / theoretical / timing — three points, each backed by a paper citation). Confirm with the user that the argument holds.

### A-7 Assemble Part 1, Submit for Review, Guide to Phase B

After the research direction, all RQs, and the necessity argument are confirmed, assemble `idea_report.md` Part 1:

- `### 1 Motivation`: direction background and research motivation, citing key papers; **must end with a necessity argument section** (application / theoretical / timing — three points, each backed by citations)
- `### 2 Research Questions`: lead-in statement + three-layer RQs (RQ1 core / RQ2 mechanism / RQ3 boundary optional); each RQ annotated with corresponding gap, novelty/mechanism analysis, and corresponding experiment
- `### 3 Key Works`: summary table (5–8 key works) + per-paper entries (all downloaded papers, following the detail level chosen in A-4.5)

After assembling, display the full Part 1 and ask the user to review:

```
{confirmation card}

idea_report.md Part 1 has been assembled. Please review:

**Motivation**: {summary of content written}
**Research Questions**: RQ1 / RQ2 / RQ3 (if included)
**Key Works**: {N} papers total, {N} key works

Does Part 1 look accurate and complete? Any adjustments needed?
Once confirmed, we move into the Idea Deepening phase.
```

After the user confirms Part 1, guide to Phase B:

```
Part 1 confirmed.

→ Use `/research[B]-idea` to enter the Idea Deepening phase.
```
```

Once the user confirms, assemble Part 1 (see B-0) and proceed to Phase B.
