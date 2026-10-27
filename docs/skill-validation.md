# Skill validation

Run from the repository root with Node.js (no Python environment or dependencies required):

```powershell
node scripts/sync-shared-references.mjs --check
node scripts/validate-skills.mjs
```

The checks cover the existing package names, required metadata, local reference availability, independent skill boundaries, skill counts, and shared-reference parity. Existing bracketed command names remain unchanged for compatibility. These checks do not prove model behavior or compatibility with every host's skill parser.

Shared files are edited under `shared/zh/` and `shared/en/`; run `node scripts/sync-shared-references.mjs` afterward. Each packaged skill contains its own copies so the current installers still work. The figure skill retains its independent write boundary and does not load the stage contract.

Use these scenarios for behavioral evaluation in an authorized disposable research workspace. They are expected outcomes for instruction review, not an automated execution report:

| Request and project context | Expected behavior |
|-----------------------------|-------------------|
| Resume; Part 3 heading exists but its body is empty | Recommend C; do not declare C complete or write state during routing |
| Resume without research_state.json, with substantive Parts 1–3 | Infer a candidate from content; disclose uncertainty; do not demand replay of A–C |
| State is malformed or has an unknown schema version | Preserve it, infer read-only, and obtain confirmation before repair |
| State says review complete; manuscript/results changed | Check hashes and mark affected claims for revalidation |
| Review report exists but still contains high-priority issues | Do not report review passed |
| Fix an import/path error in already-authorized coding | Fix and verify without asking to repeat B/C/D |
| Core evaluation protocol needs changing | Present impact and consolidate confirmation unless already authorized |
| User already specified uv, GPU, budget, and run strategy | Reuse these requirements; record versions and keep environment files within the allowed root |
| Idea fails to beat a strong baseline | Preserve the result, evaluate predefined hypotheses and uncertainty, avoid automatic architectural changes |
| Review requested with results under code/results/ | Locate actual configured evidence; report missing material instead of inventing it |
| Small change updates progress and run instructions | Preserve historical events while updating mutable summaries; log the meaningful change unit |
| Coding requested without commit/push authorization | Complete coding and necessary checks without modifying remote/branch/identity or requiring a push |
| Install one phase directory without siblings | Local contract/templates remain available; no runtime dependency on repository shared/ |

For a real behavioral trial, record the request, input artifact revisions, actions taken, outputs, and deviations. Do not describe these scenarios as passed merely because the static checks pass.
