# Phase E: Detailed coding workflow

## E-0 Inspect existing context

Read substantive implementation guidance, requirements, project environments, and Git status. Reuse confirmed devices, data paths, run strategy, and README location. Ask only about missing information that affects execution; do not require a fixed six-question form or change Git identity, branches, or remotes automatically.

Separate lightweight validation from expensive training. Follow existing authorization; if expensive runs are not authorized, provide commands and cost estimates while completing independent work.

## E-1 Environment and data

Reuse compatible environments and locks, subject to the user's manager choice. When uv is required, maintain .venv, .uv-python, .uv-cache, pyproject.toml, uv.lock, and .python-version inside the authorized root according to project rules. Do not create environments for file inspection.

Record Python, PyTorch, CUDA/driver compatibility, dependency versions, package indexes, and reconstruction commands. requirements.txt may include versions and the torch family. If torch requires a separate index/install, document it explicitly rather than omitting it. Do not mix managers to bypass user instructions.

Use real data; document official sources, revisions, access requirements, and expected sizes for missing data. Download within authorization. Never present synthetic data as experimental results; label test fixtures as tests.

Preserve existing .gitignore rules and add appropriate data, weights, logs, .venv/, .uv-cache/, .uv-python/, __pycache__/, and *.py[cod] entries as needed. Retain small reproducible result files according to project needs.

## E-2 Implementation and logs

Follow implementation dependencies. Check interfaces, tensor shapes, data flow, loss/metric definitions, ablation switches, and configuration behavior. Adapt to existing layout; do not force notebooks for noninteractive tasks.

Append a dev_log.md historical entry per meaningful change unit: rationale, affected files, document sync, validation commands/results, and remaining work. Historical entries are immutable; progress tables, known issues, and current run instructions can be updated. Synchronize README when execution, dependencies, or structure changes.

## E-3 Implementation errors and design changes

Fix ordinary import, path, type, or established-semantics errors directly and verify. For a local mistake in the implementation guide, correct the guide first, then the code, and log it without repetitive approval.

For changes to core hypotheses, methods, or evaluation protocols, present evidence, a proposal, and affected scope. Continue if authorization covers it; otherwise consolidate confirmation once. Update affected Part 2, Part 3, and implementation guidance without mechanically repeating all B/C/D.

## E-4 Necessary validation

Choose checks for the project and change, reusing existing tests. For research training code, prioritize:

- splits and preprocessing fit only on permitted training data, with no test-set model selection;
- small-sample end-to-end smoke runs and finite losses/gradients;
- metrics matching independent hand calculations or trusted references;
- ablation switches changing the intended computation;
- configurations, seeds, data revisions, and artifacts traceable to runs.

Run necessary relevant checks, not new tests for wording or log changes. Distinguish implemented, statically checked, smoke-tested, and full-experiment-pending states. Do not claim comprehensive validation prematurely.

## E-5 README, state, and optional Git actions

README covers purpose, environment reconstruction, data preparation, training/evaluation/ablation commands, and output locations. Update state and evidence per workflow-contract.md. Missing remotes or pending full training do not prevent accurate reporting of completed coding scope.

Commit/push only when authorized. Inspect repository, branch, remotes, and diff first. Stage task files explicitly rather than defaulting to git add .; do not force a main rename or initialize a nested repository inside an existing checkout. Check large files and sensitive configurations, and use only the authorized destination.

Report checks actually run, outcomes, unrun work, and limitations; continue iteration or hand off to writing according to the user's scope.
