# Phase B Detailed Flow: Idea Deepening



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
