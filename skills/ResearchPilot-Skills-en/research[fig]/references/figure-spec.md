# Figure Specification

Before plotting, record the user-confirmed design, read-only discoveries about data, and final dimensions in `code/fig/layout-plan.yaml`. Each `figure.yaml` then contains the information required to reproduce one figure independently.

## Overall layout specification

`layout-plan.yaml` should contain at least:

```yaml
version: 1
units: mm

publication_override: null

rows:
  - id: row-1
    target_width: 190
    target_height: 90
    horizontal_gaps: [10]
    figures: [fig01, fig02]

figures:
  - id: fig01
    directory: code/fig/fig01
    width: 90
    height: 90
    size_source: layout_default
  - id: fig02
    directory: code/fig/fig02
    width: 90
    height: 90
    size_source: layout_default
```

Fields may be extended for the project, but the specification must support validation of:

- final width and height for every figure;
- which figures share a row;
- their common row height;
- gaps and total row width;
- whether dimensions came from a publication, the user, or default references.

When a publication provides explicit requirements, record the original requirement and its source in `publication_override`. Do not edit the Skill's built-in YAML when overriding defaults.

## Per-figure specification

Each `figure.yaml` should contain at least:

```yaml
version: 1
figure_id: fig01

purpose: "The central point this figure should communicate"
expression: "line chart"
arrangement: "left figure in row-1"

data:
  sources:
    - path: code/results/example.csv
      role: primary
  fields: []
  filters: []
  grouping: []
  aggregation: null
  uncertainty: null
  statistical_notes: null

layout:
  units: mm
  width: 90
  height: 90
  size_source: layout_default
  dpi: 500

style:
  font_library: skill:references/font-library.yaml
  color_library: skill:references/color-library.yaml
  semantic_colors: {}

exceptions: []
```

The user must confirm `purpose`, `expression`, `arrangement`, and the statistical scope under `data`. Do not rewrite them in response to how favorable or visually attractive the results appear.

## Design confirmation gate

Before formal plotting, establish:

1. what the figure answers or demonstrates;
2. which real data it uses;
3. filtering, grouping, aggregation, and uncertainty definitions;
4. chart type and visual encodings;
5. axes, legends, and required annotations;
6. relationships and arrangement among figures;
7. whether layout defaults or publication overrides apply.

Source code and project documentation may be read to discover candidate answers and summarize them for the user. Any ambiguity that could alter the statistical conclusion or visual expression requires user confirmation.

## Directory and naming

- Use a stable, concise, filename-safe identifier such as `fig01` or `fig02-ablation`.
- Every formal figure has one directory and one primary plotting script.
- All three formal outputs share the figure identifier as their stem.
- The PNG is both the final raster output and the visual preview; do not create a duplicate preview file.
- The QA report is always named `qa-report.json`.
- Do not create `backup/`, `archive/`, `history/`, or timestamped copies.

## Data integrity

- Read declared data sources directly; do not hard-code plotted values in the script.
- If source results require transformation, implement that transformation in the independent plotting script and keep it consistent with the statistical scope recorded in `figure.yaml`.
- Record row counts before and after filtering, group counts, and key aggregate values for verification.
- If jitter, sampling, or bootstrap is part of the confirmed expression or statistical method, fix and record the random seed.
- Stop when data is missing, field semantics are unclear, or sources conflict. Do not fill gaps or guess.
