# Phases A+B+C: Direction Exploration, Idea Deepening, Experiment Design

---

## Paper Download Logic

All paper downloads — whether auto-triggered within the flow or via the
standalone `/research download-paper` command — use the following logic:

```bash
INPUT="{paper title, arXiv ID, or URL}"
OUTPUT_DIR="${specified_path:-./docs/papers}"
mkdir -p "$OUTPUT_DIR"

# Extract arXiv ID
if echo "$INPUT" | grep -qE '^[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?$'; then
  ARXIV_ID="$INPUT"
elif echo "$INPUT" | grep -qE 'arxiv\.org/(abs|pdf)/'; then
  ARXIV_ID=$(echo "$INPUT" | grep -oE '[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?')
else
  QUERY=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$INPUT")
  API_RESULT=$(curl -s "https://export.arxiv.org/api/query?search_query=ti:${QUERY}&max_results=1")
  ARXIV_ID=$(echo "$API_RESULT" | grep -oE 'arxiv\.org/abs/[0-9]{4}\.[0-9]{4,5}' | grep -oE '[0-9]{4}\.[0-9]{4,5}' | head -1)
fi

# Fetch official title
META=$(curl -s "https://export.arxiv.org/api/query?id_list=${ARXIV_ID}")
TITLE=$(echo "$META" | python3 -c "
import sys, re, html
c = sys.stdin.read()
m = re.search(r'<entry>.*?<title>(.*?)</title>', c, re.DOTALL)
if m:
    t = html.unescape(m.group(1).strip().replace('\n', ' '))
    print(re.sub(r'\s+', ' ', t))
")

# Generate filename (preserve spaces, strip illegal characters)
FILENAME=$(echo "$TITLE" | python3 -c "
import sys, re
t = sys.stdin.read().strip()
t = re.sub(r'[/\\\\:*?\"<>|]', '', t)
print(t + '.pdf')
")

curl -L --silent "https://arxiv.org/pdf/${ARXIV_ID}" -o "${OUTPUT_DIR}/${FILENAME}"

if [ -s "${OUTPUT_DIR}/${FILENAME}" ]; then
  echo "✅ Saved: ${OUTPUT_DIR}/${FILENAME}"
else
  echo "❌ Download failed: $INPUT"
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

## Phase A: Direction Exploration

### Trigger

User inputs `/research "research direction description"` or `/research --papers ...`.

If the user inputs only `/research` (no content), reply:
```
Please tell me the direction you want to research. For example:
/research "I want to work on battery SOH prediction; existing Transformer methods don't exploit local features"
```

### A-1 Parse Input, Collect Requirements

Extract from user input: research direction, existing ideas, reference papers.

If the input lacks sufficient detail, ask all questions in a single turn (not across multiple rounds):
```
Before starting the search, a few quick questions:
1. What do you see as the core problem with existing methods?
2. What angle do you want to approach this from?
3. Are there any papers you particularly want to reference?
4. Any other constraints? (e.g., must run on a single GPU)
```

Write collected information to `docs/user_requirements.md`.

### A-2 Initial Literature Search

**Prioritize top venues**: NeurIPS, ICML, ICLR, CVPR, ECCV, ICCV, ACL, EMNLP, KDD, IEEE TII, IEEE TNNLS, etc.
ArXiv versions may be downloaded, but use the formally published information as the reference.

**Search self-reflection**: check that each research gap is supported by ≥2 papers; if not, run additional searches (up to 3 rounds).

Target: at least 10 valid references as the basis for initial direction exploration.

### A-3 Confirm Download List with User

```
Initial search complete. The following papers are recommended for download (you can add or remove):

| # | Title | Publication | arXiv Version |
|---|-------|------------|--------------|
| 1 | {title} | {Venue Year} | {ID or N/A} |
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

### A-5 Propose 5 Idea Directions

Based on downloaded papers, propose 5 broad idea directions. Each direction should be substantive:

```
Based on the literature analysis, here are 5 research directions for consideration:

### Direction 1: {title}
**Core idea**: {2–3 sentences describing what problem this direction addresses and what approach it takes}
**Literature basis**: {key papers supporting this direction and their core findings}
**Innovation angle**: {method transfer / improvement of existing methods / task reframing}
**Main challenges**: {core difficulties in realizing this direction}
**Novelty assessment**: {key differences from existing work; similarity: high / medium / low}

### Direction 2: ...
...
```

Then ask:
```
Which direction interests you? Or do you have other ideas?
You can select a direction, or tell me what you'd like to adjust.
```

### A-6 Iterative Refinement (loop)

After the user selects or requests changes:
1. If more literature support is needed: re-search → confirm download list → download → update direction descriptions
2. If the direction needs adjustment: revise direction content per user feedback
3. After each output, proactively ask:

```
Is the direction description complete enough now?
If so, we can move to the next phase and start building a detailed idea.
Or is there anything you'd like to add or change?
```

4. Once the user confirms, proceed to Phase B.

---

## Phase B: Idea Deepening

### Trigger

Entered automatically after the user confirms a direction in Phase A.

### B-1 Build idea_report.md Part 1 + Part 2

Generate the document according to the template in `references/document-formats.md`.

**Part 1 Topic Overview:**
- `### 1 Motivation`: direction background and research motivation, citing key papers
- `### 2 Development Timeline`: field evolution, ≥5 key milestones, in continuous paragraphs
- `### 3 Key Works`: 5–8 works worth learning from, one sub-section per paper, including borrowing value

**Part 2 Idea Design:**
- `### 1 Introduction`: strict academic paper style, no sub-headings, broad-to-narrow structure, contributions listed as bullet points at the end
- `### 2 Related Works`: synthesize existing approaches, final sub-section is always "Research Gap"
- `### 3 Method`: detailed theoretical framework, every formula annotated with `>`, final sub-section is always Baseline Reference and Evaluation Metrics (all entries must have paper citations)

Use `>` heavily to explain the design rationale and literature support for each step. Use `>>` to mark sources and append verbatim sentences from PDFs.

If more literature support is needed during generation: auto-search → confirm download list with user → download → continue generating.

### B-2 Citation Verification

For all `>>` annotations:
1. Open `docs/papers/{title}.pdf` (or `.txt`)
2. Locate the supporting passage, and append the verbatim text:
   ```
   >> This design is inspired by [3]. [3]
   >> Source text: "..." (Section 3.1)
   ```
3. If verification is not possible, append `⚠️ [low confidence: PDF unavailable]` and register in the Pending Verification list.

### B-3 Ask for Confirmation After Each Output

After each generation or revision:
```
The detailed idea description has been updated. Is the idea complete enough now?
If so, we can move into the experiment design phase.
Or is there anything you'd like to adjust?
```

### B-4 Iterative Refinement (loop)

After the user proposes revisions:
1. If new papers are needed: search → confirm download list → download → update document
2. If only content changes are needed: revise directly and re-output the relevant sections
3. Ask for confirmation again

Once the user confirms, proceed to Phase C.

---

## Phase C: Experiment Design

### Trigger

Entered automatically after the user confirms the idea in Phase B.

### C-1 Collect Experiment Constraints

Ask the user (if not already mentioned in conversation):
```
Before designing experiments, a few quick questions:
1. GPU setup? (model + VRAM)
2. Time limit per training run?
3. Do you have a preferred dataset, or should I recommend one?
4. Any particular emphasis for the experiments?
```

Write to `docs/user_requirements.md`.

### C-2 Search Field Experiment Conventions

Search papers from the same field in the past 3 years and extract:
- Common datasets and their standard split ratios
- Standard evaluation metrics and how they are computed
- Typical ablation design patterns
- Standard baseline hyperparameter configurations
- Result table formatting conventions

### C-3 Feasibility Verification

Check three items (if any fail, pause and inform the user):
- **Dataset**: download link is accessible, data is publicly available, scale is appropriate
- **Baseline code**: repository is accessible, framework is compatible; if no code exists, note "needs self-implementation"
- **Hardware**: estimate VRAM requirement; if it exceeds the user's GPU, suggest adjustments

Write the feasibility summary at the beginning of Part 3:
```markdown
### Feasibility Verification Summary
| Item | Status | Notes |
|------|--------|-------|
| Dataset {name} | ✅/⚠️/❌ | {explanation} |
| Baseline {name} code | ✅/⚠️/❌ | {explanation} |
| GPU VRAM | ✅/⚠️ | Estimated {N}GB, user has {M}GB |
```

### C-4 Generate idea_report.md Part 3

Generate using the Part 3 template in `references/document-formats.md`, appended to the end of `idea_report.md`.

Annotate every experiment design decision with `>` to explain the rationale. Use `>>` for decisions backed by paper evidence.

### C-5 Ask for Confirmation After Each Output

```
Experiment design generated. Is the experiment plan complete enough now?
If so, we can move into the implementation design phase and generate a detailed coding guide.
Or is there anything you'd like to adjust?
```

### C-6 Iterative Refinement (loop)

After the user proposes revisions, update Part 3 content and ask for confirmation again.
Once the user confirms, proceed to Phase D (see `references/phase-implementation.md`).
