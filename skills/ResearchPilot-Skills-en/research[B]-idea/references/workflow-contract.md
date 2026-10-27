# Execution and handoff contract

Read this file when starting a phase. It defines cross-phase execution rules; phase references describe the task itself. Apply this contract to older fixed approval counts, full-chain backtracking, and per-file logging requirements in other references. Current user instructions and project permissions take priority, and confirmed authorization persists. Current instructions override stale documents. A missing `docs/user_requirements.md` is not a blocker. Record confirmed constraints, never model assumptions as user requirements.

## Confirmation and execution

- Continue authorized reading, searches, local fixes, documentation updates, and lightweight validation. Inspect existing context before asking; do not ask again for answered questions.
- Consolidate confirmation into one decision when the research direction, core hypothesis, method, or evaluation protocol materially changes. An approved outline authorizes drafting its details without section-by-section approval.
- Run expensive experiments, use paid resources, or publish externally only within authorization. Ask about the specific action when authorization is missing. Continue across phases if the user authorized that scope; otherwise provide the next command at the phase boundary.
- Fix and verify ordinary implementation errors directly. Update affected design documents when the method changes; an import or path fix does not require repeating B/C/D. For a real blocker, state evidence, attempted remedies, and missing information.

## Phase state

Except for read-only requests, maintain `docs/research_state.json` after a meaningful unit of work, rather than after every file. Respect the user's writable directories. Example:

```json
{
  "schema_version": 1,
  "active_phase": "C",
  "phases": {
    "C": {
      "status": "in_progress",
      "artifacts": [{"path": "docs/idea_report.md", "sha256": "<actual file hash>"}],
      "completion_evidence": [],
      "confirmation": {"status": "not_requested", "scope": "", "source": ""},
      "updated_at": "<ISO 8601 timestamp with timezone>"
    }
  }
}
```

- Phase IDs are A–F and G.0–G.8 (G.8 is Chinese-only). Status values: `not_started`, `in_progress`, `complete`, `needs_revalidation`, `blocked`.
- Artifacts contain project-relative paths and actual SHA-256 hashes. Never persist example placeholders as real records. Completion evidence names concrete checks and outcomes, such as a completed hypothesis/control/evaluation/resource plan, rather than file existence.
- Confirmation status: `not_requested`, `confirmed`, or `not_required`. Record the scope and actual user instruction; explain existing authorization or routine work for `not_required`. Never invent approval or timestamps.
- `complete` requires substantive content, passing necessary checks, and any required confirmation. Distinguish implemented code from verified execution; do not claim full training passed after a smoke test.
- When hashes or upstream methods/evaluation change, check affected downstream phases. Invalidate related conclusions, not every phase mechanically. Bind reviews to versions of the manuscript, evaluation results, and reference files; changes require rechecking affected claims.
- If state is missing, malformed, unsupported, or inconsistent, preserve the original and infer a candidate state from content in read-only mode, reporting uncertainty. Obtain confirmation before repairing corrupt or materially ambiguous state. Within authorized phase work, initialize absent state directly using known facts only. Legacy projects without state can still invoke phase skills directly.

## Research and reproducibility

Experiments test falsifiable hypotheses. Specify supporting, contradicting, and inconclusive outcomes beforehand, and preserve failures and negative results. Beating every baseline is not a validity criterion. Do not repeatedly tune on the test set. Record splits, preprocessing fit scope, seeds, search budgets, and metric implementations.

Account for available hardware, time, and budget during planning. Present both the full evidence plan and an executable core plan, stating which conclusions a reduced plan can support. Adapt literature and experiment counts to the question; stop at adequate evidence coverage instead of filling quotas.

Reuse the project's environment manager subject to user requirements. When uv is required, keep environments, interpreters, and caches inside the authorized project and maintain `pyproject.toml`, `uv.lock`, and `.python-version` according to project rules. Record Python, PyTorch, CUDA, and other dependency versions. Hardware-specific packages may be installed separately, but record their versions, indexes, and reconstruction commands. Unversioned requirements alone are insufficient for reproducibility.

Historical event entries are append-only; correct earlier conclusions with a new entry. Progress tables, current run instructions, and known-issue summaries may be updated. Log each meaningful change unit with affected files and validation results.
