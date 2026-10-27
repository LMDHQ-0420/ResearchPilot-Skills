# Phase C: Experiment design

Read the local workflow-contract.md and confirmed requirements at startup. Completion means Part 3 answers the RQs with executable experiments and explicit evidence boundaries.

## C-1 Context, resources, and baseline reading

Read Part 2 hypotheses and candidate methods plus existing environment/resource notes. Reuse known hardware, time, and budget constraints. Ask together about missing information that affects feasibility; otherwise state assumptions and cost ranges. Do not invent measurements.

Select relevant baseline papers and core training/evaluation code for authorized read-only investigation. Record sources, revisions, splits, preprocessing fit scope, metrics, search policies, and implementation differences. Mark unavailable code and reproduction risks; do not claim a full-paper reading based on an abstract.

## C-2 Field conventions and falsifiable hypotheses

Review relevant recent and classic work. Explain how benchmarks, metrics, and customary experiments serve the RQs. Choose counts by evidence coverage and budget rather than quotas.

For each main hypothesis, specify supporting, contradicting, and inconclusive outcomes, necessary controls, and confounders. Preserve negative, failed, and nonsignificant results. Reserve the test set for final evaluation rather than iterative tuning or method selection.

## C-3 Data, code, and execution feasibility

Verify provenance, access, licenses, and revisions. Check scale, memory, runtime, and total run count; distinguish estimates from measurements. If one baseline is unavailable, document alternatives and limitations and continue unaffected work. Block the affected scope only when essential data or the scientific test itself is unavailable.

## C-4 Consolidated experiment outline

Present RQ/hypothesis → experiment → control → primary metric → decision criteria → cost and conclusion boundaries. Show both the full evidence plan and the executable core plan, with deferred experiments and priorities.

Consolidate confirmation for method, evaluation, or cost decisions beyond existing authorization. Expand approved outlines directly; do not require repeated approval of reading lists, summaries, or sections.

## C-5 Write Part 3

Use applicable document-formats.md fields and preserve other parts. Include rationale, data revisions/splits, leakage prevention, metric implementations, baseline sources and selection reasons, search budgets, seeds/repeats, and uncertainty/statistical reporting.

Explain favorable, unfavorable, and inconclusive outcomes. Beating every baseline is not acceptance; use predefined RQ-aligned metrics, effect sizes, and applicability boundaries.

## C-6 Costs and execution order

Summarize memory, per-run time, run count, and total cost with estimation basis and uncertainty. Stage core and extended evidence. Never describe an unexecuted full plan as verified findings.

## C-7 Validate and hand off

Check hypothesis coverage, fair controls, leakage prevention, feasibility, and reproducibility. Report the Part 3 path, completion evidence, and open issues; maintain state per workflow-contract.md. Consolidate unresolved important choices. Continue if implementation was authorized; otherwise recommend /research[D]-implementation.
