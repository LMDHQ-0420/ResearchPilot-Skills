# Phase F Detailed Flow: Code Iteration and Model Improvement

## Phase F: Code Iteration

> **user_requirements.md takes priority**: All constraints in `docs/user_requirements.md` take precedence over any default instruction in this file.
> **dev_log.md is append-only**: Every code change must append a new log entry. Never overwrite or delete existing entries.

### Trigger

Entered after Phase E coding is complete and experiment results are unsatisfactory. Use `/research[F]-iteration`.

This phase supports multiple iteration rounds (F-1 → F-5 → F-1 loop) until results are satisfactory.

---

### F-1 Diagnostic Analysis

**First, read the following files to gather full context**:
1. `docs/dev_log.md`: experiment results and previous iteration history
2. `results/` evaluation files (eval json / ablation summary csv, etc.)
3. `docs/idea_report.md` Part 2 (Method) and Part 3 (Experiment Design)

Based on the above, systematically examine three angles and produce a diagnostic report:

```
━━━━━━━━━━ Diagnostic Report ━━━━━━━━━━

**Current Results**:
{Key metrics extracted from dev_log.md and results/, compared against baselines}

**Diagnosis**:

① Data issues
  - {Are data processing / splitting / normalization potentially incorrect?}
  - {Evidence: which metric or observation supports this?}

② Model issues
  - {Which module might be the bottleneck?}
  - {What do ablation results suggest (if available)?}
  - {Evidence: specific experimental numbers}

③ Training issues
  - {Hyperparameters, convergence, overfitting/underfitting?}
  - {Evidence: patterns in training curves}

**Proposed improvement directions**:
1. {Suggestion 1 — expected to address which problem}
2. {Suggestion 2 — …}

Does this diagnosis look accurate? Which direction would you like to pursue, or do you have other ideas?
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Wait for the user to confirm the direction before proceeding to F-2.

---

### F-2 Confirm Backtrack Scope

Based on the diagnosis and user's choice, confirm what needs to change:

```
Based on the diagnosis, confirm the scope of changes:

[ ] Only change hyperparameters / training settings
    → update configs/ and dev_log.md only; no design documents touched

[ ] Change model architecture (Method changes)
    → update idea_report.md Part 2 (Method)
    → ablation design may change accordingly; update Part 3 if so
    → update implementation.md

[ ] Change experiment design (add/modify baselines / metrics / datasets)
    → update idea_report.md Part 3
    → update implementation.md

After confirming the scope, I will update the design documents first, then change the code.
```

**Constraint**: the scope must be confirmed by the user. Design documents must be updated before any code changes. Patching code without updating documents is not allowed.

---

### F-3 Update Design Documents

Update per the scope confirmed in F-2:

**Hyperparameters / training settings only**:
- Update the relevant yaml files in `configs/`
- Append an iteration entry to `dev_log.md` (see format below)

**Model architecture change**:
- Update `idea_report.md` Part 2 Method section (framework / pipeline / model description)
- If ablation design changes accordingly, update Part 3 ablation section
- Update `implementation.md` for the affected function descriptions
- Run implementation.md validation (experiment coverage / logic consistency / completeness)

**Experiment design change**:
- Update `idea_report.md` Part 3
- Update `implementation.md`
- Run implementation.md validation

After updating, show the user a change summary and confirm:
```
Documents updated. Summary of changes:
- idea_report.md: {what changed, which section}
- implementation.md: {which functions/modules}
- Validation result: {passed / issues found: …}

Confirmed? I will start modifying the code.
```

---

### F-4 Code Changes

Modify the code per the updated documents.

After each file is changed, **append** an iteration log entry to `dev_log.md`:

```markdown
### {YYYY-MM-DD HH:MM} — Iteration #{N}: {brief description}

**Reason**: {which problem from F-1 diagnosis prompted this}
**Changes**:
- `{file path}`: {what was changed}
- `{file path}`: {what was changed}
**Expected effect**: {how metrics are expected to change and why}
**Document sync**: idea_report.md {yes/no} | implementation.md {yes/no} | configs/ {yes/no}
```

**Constraints**:
- Every code change must append a log entry — never change code silently
- If the change affects run commands or parameters, update the "How to Run" chapter in `dev_log.md`

---

### F-5 Validation

After changes are done, run the relevant experiments per the run strategy from E-0:

- Auto-run → run directly, append results to dev_log.md
- User-run → provide the run command, wait for user's results

After experiments complete, **append** a results entry to `dev_log.md`:

```markdown
### {YYYY-MM-DD HH:MM} — Iteration #{N} Results

| Metric | Before | After | Change |
|--------|--------|-------|--------|
| {metric1} | {val} | {val} | {↑/↓ N%} |
| {metric2} | {val} | {val} | {↑/↓ N%} |

**Conclusion**: {was the change effective? analysis of why}
```

---

### F-6 Decide Whether to Continue

```
Iteration #{N} results recorded.

Current best: {key metric value}
vs. baseline: {surpassed / on par / below}

→ Results satisfactory — move to paper writing: `/research[G]-paper`
→ Results need more improvement — continue iterating: back to F-1
→ Larger-scope adjustment needed:
   - Change idea → `/research[B]-idea`
   - Change experiment design → `/research[C]-experiment`

Your choice?
```

---

### Phase F Complete

When results are satisfactory:

```
Phase F complete. {N} iteration rounds completed. Final results recorded in dev_log.md.

→ Use `/research[G]-paper` to enter the Paper Writing phase.
```
