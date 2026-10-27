---
name: research[G.7]-review
description: >
  Review paper contributions, writing, experiments, and evaluation; align claims with actual evidence and report located, prioritized findings.
version: 2.0.0
license: LICENSE
---

# Phase G.7: Full-paper or scoped review

Read the [execution and handoff contract](references/workflow-contract.md) and confirmed requirements. A review request authorizes inspection without a separate writing-plan approval. Produce findings by default; edit the manuscript only when authorized.

## Reading and evidence

Read the full current manuscript, references, relevant research-report sections, and evaluation data/run records at the project's actual configured result paths. Results may be under code/results/ or elsewhere; do not hard-code results/. Mark unavailable evidence rather than inventing numbers or declaring a pass.

## Five dimensions

1. Contribution: direct claim support, hypotheses distinguished from verified conclusions, honest negative results and applicability boundaries.
2. Clarity: paragraph focus, terminology, equations, and figures; reverse-outline to find logical gaps.
3. Experimental strength: RQs answered by main, ablation, and boundary experiments; alternative explanations addressed. Beating every baseline is not required.
4. Evaluation: no leakage in splits, preprocessing fitting, model selection, or tuning; fair baseline search budgets; correct metrics and uncertainty/statistical reporting.
5. Method soundness: agreement among rationale, implementation, and ablations; no untested mechanism assertions presented as established facts.

## Claim–evidence table

List every major Abstract and Introduction claim:

| Claim and manuscript location | Evidence file/run ID/figure location | Status | Issue and remedy |
|-------------------------------|--------------------------------------|--------|------------------|
| Actual claim | Actual source and revision | supported / needs evidence / missing / contradicted | Experiment, weakening, or correction |

Do not skip unsupported or contradicted claims. Priorities: high affects contributions or main conclusions; medium affects local reasoning/readability; low is formatting/wording. Each finding includes location, evidence, impact, and an actionable remedy, not just a score.

## Delivery and completion

Except for read-only requests, save docs/manuscripts/review_report.md with project-relative paths and actual SHA-256 hashes for the manuscript, references, and result files; record scope, unchecked items, and high-priority findings/resolution status. Report existence does not mean a pass. Pass only with sufficient current-version evidence and all high-priority findings resolved. Keep unverifiable issues open and update phase state per the contract.

When authorized to edit, follow [writing constraints](references/common-writing-constraints.md) and [template rules](references/template-flexibility.md). Review alone does not require manuscript backups or rewriting. Consult the [review source](references/section-guide-source.md) and [writing-flow source](references/writing-flow-source.md) when useful.
