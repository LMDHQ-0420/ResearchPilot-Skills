# Phases A+B+C: Direction Exploration, Idea Deepening, Experiment Design

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

### A-6 Distill and Confirm RQs One by One

> After the research direction is locked, move to RQ distillation. Likewise confirm one at a time, not all RQs at once.

**Step 1: gap → RQ derivation**. Based on the confirmed direction, derive candidate RQs from the literature gaps, **proposing one primary RQ candidate at a time**, with:
- Which specific gap it corresponds to (with supporting citation)
- Novelty check (targeted search result: existing / partial / open)
- Answerability (whether it can be answered within the experimental scope of a single paper)

Discuss this primary RQ with the user, allowing rewrite / merge / replace, until they confirm the primary RQ.

**Step 2: Add secondary RQs**. Once the primary RQ is confirmed, propose secondary RQs (1–3) one by one in the same manner, confirming each with the user.

**Step 3: Lock RQs**. As each RQ is confirmed, immediately write it into `user_requirements.md` and refresh the confirmation card.

**Step 4: Necessity argument**. Once all RQs are confirmed, write a necessity argument for the selected RQs (application / theoretical / timing, itemized, each backed by citations), and confirm with the user that the argument holds.

### A-7 Proceed to Phase B

Once the research direction, all RQs, and the necessity argument are confirmed, proactively ask:
```
{confirmation card}

The research direction and RQs are now locked, and the necessity argument holds.
I can now assemble Part 1 (Motivation / Research Questions / Key Works) and move into the idea-deepening phase.
Shall we continue? Or is there anything to add?
```

Once the user confirms, assemble Part 1 (see B-0) and proceed to Phase B.

---

## Phase B: Idea Deepening

### Trigger

Entered automatically after the user confirms a direction in Phase A.

> Phase B has already established the research direction and RQs; the goal is to deepen the "research question" into an "implementable method". **Every output likewise begins with the confirmation card** (in Phase B the card adds two more fields on top of Phase A: "Confirmed technical framework" and "Confirmed pipeline"). Deepening proceeds through three layers of step-by-step confirmation: technical framework → detailed pipeline → Introduction polishing.

> **Literature first**: before each generation or adjustment of the idea (technical framework / pipeline / Method) in this phase, you must follow the "Literature Reading Principle" above — first read closely the literature already in `docs/papers/`, and re-run the download flow only when the existing literature is insufficient to support a design decision. This applies to the initial deepening and to every later adjustment (including those backtracked from Phase D/E).

### B-0 Assemble Part 1

The content confirmed in Phase A is assembled directly into `idea_report.md` Part 1, not regenerated:
- `### 1 Motivation`: direction background and research motivation, citing key papers; **must end with a "Why this research is necessary" itemized paragraph** (application/theoretical/timing, each backed by citations)
- `### 2 Research Questions`: introductory statement + primary RQ (1) + secondary RQs (1–3); each RQ annotated with its corresponding gap, novelty, and answerability
- `### 3 Key Works`: two parts, **following the user's A-4.5 choice on "detailed introduction per paper"**:
  - **① Summary table**: always includes **only the key works** (5–8 works, not limited to SOTA), columns: short name / venue·journal / year / one-line core contribution / borrowing value. The table stays focused on key works.
  - **② Per-paper entries**: regardless of the user's choice, include **every paper downloaded in A-4** (not just the key works); each with a citation and a `>` line stating **why it is / is not a key work**.
    - If the user chose **yes** in A-4.5: write each paper's body as a four-point detailed introduction — ① what research problem it solves; ② what method it uses and why designed that way; ③ how well the method performs; ④ what this paper means for this research.
    - If the user chose **no**: write a one-sentence core contribution per paper, but still **include every downloaded paper** and keep the "why it is / is not a key work" `>` line.

After assembly, present Part 1 for the user's review; proceed to B-1 only after they confirm it.

### B-1 Confirm the Technical Framework (Layer 1)

> Goal: first align with the user on "what broad technical approach will answer the RQs", without implementation details.

Propose the overall technical framework to the user:
```
{confirmation card}

For the confirmed RQs, here is the technical framework I envision:

**Overall approach**: {one paragraph on what core technique answers the RQs and which innovation point it corresponds to}
**Framework sketch**:
{Input → [Module A: role] → [Module B: role] → Output —— as a text flow diagram}
**What each module solves**:
- Module A: {which part of the RQ it addresses}
- Module B: {...}

Is this technical framework heading in the right direction? Which modules need adjustment?
```

Go back and forth with the user until the framework is confirmed. Then write it into the "Confirmed technical framework" field of the card.

### B-2 Confirm the Detailed Pipeline (Layer 2, plain language)

> Goal: refine the framework into an executable, complete workflow. **The output must be in plain language, walking through what each step does as "first… then…", without piling up formulas.**

```
{confirmation card}

With the framework confirmed, here is how the complete pipeline operates (the flow first; formulas come later when writing the document):

**Step 1**: {what the input is, how it's processed, what it produces — in everyday language}
**Step 2**: {...}
**Step 3**: {...}
...

Why each step is designed this way: {the corresponding intuition}

Are there any gaps or unreasonable parts in this workflow?
```

Go back and forth with the user until the pipeline is confirmed. Then write it into the "Confirmed pipeline" field of the card.

Only after that, write Part 2's Method section:
- `### 1 Introduction`: leave as a placeholder for now, polished in B-4
- `### 2 Related Works`: synthesize existing approaches, final sub-section is always "Research Gap"
- `### 3 Method`: write the detailed theoretical framework based on the confirmed pipeline; 3.2 is the plain-language walkthrough (consistent with the confirmed pipeline), 3.3+ are the corresponding theoretical/formula expressions, every formula annotated with `>`, final sub-section is always Baseline Reference and Evaluation Metrics (all entries must have paper citations)

Use `>` heavily to explain the design rationale, literature support, and source annotations for each step. If more literature support is needed during generation: search → confirm download list → download → continue.

### B-3 Citation Verification

For all source annotations (`>` lines that include a citation number):
1. Open `docs/papers/{title}.pdf` (or `.txt`)
2. Locate the supporting passage, and append the verbatim text:
   ```
   > This design is inspired by [3]. [3]
   > Source text: "..." (Section 3.1)
   ```
3. If verification is not possible, append `⚠️ [low confidence: PDF unavailable]` and register in the Pending Verification list.

### B-4 Introduction Polishing (Layer 3)

> After the Method is confirmed, finally polish the Introduction to submission quality.

Write the Introduction in academic paper style (no sub-headings, from field importance → itemized limitations of existing methods with citations → motivation of this paper → method overview → itemized contributions), then ask:
```
{confirmation card}

The Introduction has been polished in academic paper style. Does the logic and force of this opening land well?
Which part should be strengthened (background setup / limitation argument / contribution framing)?
```

Go back and forth with the user until the Introduction is confirmed.

### B-5 Proceed to Phase C

Once the technical framework, pipeline, Method, and Introduction are all confirmed, proactively ask:
```
{confirmation card}

The idea is now fully deepened (technical framework → pipeline → Method → Introduction all confirmed).
Shall we move into the experiment design phase? Or is there anything to adjust?
```

Once the user confirms, proceed to Phase C.

---

## Phase C: Experiment Design

### Trigger

Entered automatically after the user confirms the idea in Phase B.

> **Experiment design principle**: the first purpose of every experiment design is to **rigorously prove the effectiveness of the idea**, never trimming experiments to fit resources. Therefore **do not collect resource constraints (GPU/training time) before design**; instead, provide a resource estimate after the plan is complete (see C-6), for the user's reference only. Resources are not a design constraint.

### C-1 Deep-Read Baseline Papers and Code

Extract all selected baselines from the Method section of `idea_report.md` Part 2, present a deep-read plan to the user, and request confirmation:

```
Before designing experiments, I plan to deep-read the following baselines' papers and code repositories,
to understand how they design experiments and avoid an experiment design disconnected from field conventions:

| # | Baseline | Paper | GitHub | Purpose of deep-read |
|---|---------|-------|--------|---------------------|
| 1 | {name} | {title} [n] | {repo link or not found yet} | {one sentence: why read this — which method category it represents, or what's worth referencing in its experiment design} |
| 2 | {name} | ... | ... | ... |

Once confirmed, I will read each one and compile them into Part 3 Section 0.
```

Wait for user confirmation (they may add or remove items).

After confirmation, for each baseline:
1. Download the paper PDF (read directly if already in `docs/papers/`, otherwise fetch via the paper download logic)
2. Read the GitHub README and core training scripts (if the repo is accessible)
3. Extract from the paper and code:
   - Which datasets are used, and how they are split (ratio / official split / cross-validation)
   - Which experiments are designed (main, ablation, additional), and the purpose of each
   - Which models are compared, and the model-selection logic
   - Which evaluation metrics are used, and how they are computed
   - Key hyperparameter settings (batch size, lr, training epochs, etc.)

After extraction, present a summary to the user for confirmation, then proceed to C-2.

### C-2 Synthesize Field Experiment Conventions

Search papers from the same field in the past 3 years and, combined with the C-1 deep-read results, synthesize:
- Datasets commonly used across baselines (treated as the field's standard benchmarks)
- Evaluation metrics commonly used across baselines (treated as the field's standard metrics)
- Typical ablation design patterns (which components usually need ablation)
- Result table conventions (whether std is reported, whether results are averaged over multiple runs)

### C-3 Data & Code Availability Check

> Verify only "whether the experiments can be carried out" — i.e., whether the data and baseline code can be obtained; **do not check whether GPU/VRAM resources are sufficient** (resources are only estimated afterward in C-6, and are not a constraint).

Check two items (if either fails, pause and inform the user):
- **Dataset**: download link is accessible, data is publicly available (note the application process if access requires a request)
- **Baseline code**: repository is accessible, framework is compatible; if no code exists, note "needs self-implementation"

Write the availability summary at the end of Part 3 Section 0:
```markdown
### Data & Code Availability Summary
| Item | Status | Notes |
|------|--------|-------|
| Dataset {name} | ✅/⚠️/❌ | {explanation} |
| Baseline {name} code | ✅/⚠️/❌ | {explanation} |
```

### C-4 Propose an Experiment Outline and Confirm with the User

> Before writing the full content of Part 3, **first present an experiment outline and confirm it with the user interactively**. The outline is the skeleton; only after confirmation is it expanded into the full text — this avoids writing a pile of details on top of a wrong experimental framework.

Present the outline to the user, covering:

```
Before formally writing the experiment design, let's confirm the experiment outline:

**Datasets**: which datasets are planned (for the main experiment / additional experiments respectively), and why these.

**Experiment list and design logic**:
| # | Experiment | Type | Design intent (why designed this way; which point of the core method it supports) | # Models | Core baseline | Why chosen as core |
|---|-----------|------|------------------------------------------------------------------------------|----------|--------------|--------------------|
| 1 | Main experiment | Main | … | {N} | {model} | {why it's the core} |
| 2 | Ablation: w/o {module} | Ablation | … | {N} | — | — |
| 3 | {field-standard additional experiment} | Additional · mandatory | … | {N} | {model} | … |

**Optional extension experiments** (to fill out the workload, for you to choose):
- Option 1: {experiment name} — validates {property}, {one-sentence design intent}
- Option 2: {experiment name} — validates {property}, …
- Option 3: …
(List as many angles as possible; you can pick which to do)

Confirm the outline or tell me what to adjust; once you've selected the extension experiments, I'll expand it into the full Part 3.
```

Go back and forth with the user until the outline (including the selected extension experiments) is confirmed.

### C-5 Generate idea_report.md Part 3

Generate the full content using the Part 3 template in `references/document-formats.md`, based on the confirmed outline, appended to the end of `idea_report.md`.

- Section 0 (Baseline Experiment Survey) is filled directly from the C-1 deep-read results
- The experiment design from Section 1 onward builds on the field conventions synthesized in Section 0, expanded per the outline confirmed in C-4
- **Every experiment must fill in the "Why designed this way" field**, explaining its significance for supporting the core method
- **The Models Under Evaluation table must explain each model one by one**: its difference from the proposed method, the significance of inclusion, and the source paper (display only, not part of the selection decision); and identify the core baseline and its rationale
- Additional experiments are split into "field-standard (mandatory)" and "extension experiments (user-selected)"
- Annotate every experiment design decision with `>` to explain the rationale, including the citation number for decisions backed by paper evidence

### C-6 Provide a Resource Estimate After the Design Is Complete

Once the entire experiment plan is designed, provide a **resource estimate** based on model scale, data size, and the number of experiment groups, as reference information at the end of Part 3 (**for reference only, not a design constraint**):
```markdown
### Resource Estimate (reference)
| Experiment | Est. VRAM | Est. time per run | # Groups |
|-----------|-----------|-------------------|----------|
| Main experiment | ~{N}GB | ~{N} h/dataset | {N} |
| Ablation study | ~{N}GB | ~{N} h/variant | {N} |

> These are rough estimates; actual consumption depends on the specific implementation and hardware. If resources are limited, you may run the core experiments first and run in batches, without compromising the effectiveness proof.
```

### C-7 Ask for Confirmation After Each Output

```
Experiment design generated (with a resource estimate, for reference only). Is the experiment plan complete enough now?
If so, we can move into the implementation design phase and generate a detailed coding guide.
Or is there anything you'd like to adjust?
```

### C-8 Iterative Refinement (loop)

After the user proposes revisions, update Part 3 content and ask for confirmation again.
Once the user confirms, proceed to Phase D (see `references/phase-implementation.md`).
