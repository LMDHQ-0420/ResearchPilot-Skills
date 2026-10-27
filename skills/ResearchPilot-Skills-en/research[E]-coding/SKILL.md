---
name: research[E]-coding
description: >
  Implement and validate research code from its design guide, maintain run instructions, reconstructable environments, and development logs.
version: 2.0.0
license: LICENSE
---

# Phase E: Coding

Read the [execution and handoff contract](references/workflow-contract.md) and existing docs/user_requirements.md. Implement and validate a substantive docs/implementation.md; file existence alone does not establish prerequisite completion.

## Workflow

1. Inspect the existing project, environment, and execution strategy; ask only about missing information that affects execution.
2. Implement in dependency order and check module interfaces, data flow, and experiment protocols.
3. Record a reconstructable environment including Python, PyTorch, CUDA, dependency versions, and installation sources.
4. Fix ordinary implementation errors within authorization; synchronize affected design documents for method changes and consolidate necessary confirmation.
5. Append historical logs per meaningful change unit, updating progress, run instructions, and README.
6. Run checks appropriate to the change, distinguishing static checks, smoke runs, and full experiments.

Details: [coding workflow](references/phase-E.md). Consult [template rules](references/template-flexibility.md) when needed.

## Completion and handoff

Report implemented scope, actual validation commands/results, experiments not run, and remaining issues. Update phase state. Commits and pushes are optional authorized actions, not coding completion criteria. Neither review nor a successful smoke run guarantees all logic is correct.

Recommend /research[F]-iteration for further diagnosis or /research[G.0]-plan for writing. Continue when the user already authorized the subsequent work.
