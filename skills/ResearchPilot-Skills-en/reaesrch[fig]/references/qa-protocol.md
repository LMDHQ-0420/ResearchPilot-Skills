# Figure Quality Assurance Protocol

After every export or adjustment, run automatic checks for each figure and inspect its PNG preview. Write the results to `qa-report.json` inside that figure's directory. Any validation script, log, or cache must also remain under `code/fig/`.

## 1. Files and reproducibility

- The independent plotting script runs through an explicit command from either the project root or figure directory.
- PDF, SVG, and PNG all exist, open successfully, and share the same filename stem.
- The PDF is a single-page figure.
- All three formats come from one script run, one canvas, and one plotting object.
- Re-running the script does not create or modify project files outside `code/fig/`.

## 2. Physical dimensions

- The PDF page dimensions match `figure.yaml`.
- The SVG physical dimensions and `viewBox` agree with the target size.
- PNG defaults to 500 dpi, with pixel dimensions calculated as:

```text
width_px  = round(width_mm  / 25.4 * dpi)
height_px = round(height_mm / 25.4 * dpi)
```

- Allow numeric rounding inherent in format metadata, but not a visually or typographically meaningful size discrepancy.
- Figures in the same row have identical physical height.
- Their widths plus all horizontal gaps equal the target row width.
- Do not accept post-export scaling, stretching, or rerasterization as a dimension fix.

## 3. Typography

- Confirm before rendering that the system resolves Arial exactly.
- Missing or substituted fonts fail validation; do not silently switch families.
- Every text element uses a role from `font-library.yaml`.
- Legend labels match tick labels.
- Category labels sit between tick labels and axis titles in the size hierarchy.
- Bold weight is limited to roles that define it.
- Any arbitrary size or font exception requires explicit user approval and an entry in `figure.yaml` under `exceptions`.

## 4. Color

- Every color comes from a named entry or semantic role in `color-library.yaml`.
- Text, axes, ticks, backgrounds, and grids use their corresponding semantic roles.
- A semantic meaning keeps the same color across the figure group and existing project figures.
- Use the categorical sequence in library order unless the user confirms a different semantic mapping.
- Do not use categorical rainbow colors for continuous variables.
- Any arbitrary hexadecimal color exception requires explicit user approval and an entry under `exceptions`.

## 5. Data and statistical scope

- The figure reads the real sources declared in `figure.yaml`.
- Filters, groups, aggregates, uncertainty definitions, and random seeds match the confirmed scope.
- Verify row counts before and after filtering, group counts, and key summary values.
- Do not manually fill values, apply undeclared smoothing, remove outliers, or change axis limits to hide results.
- Data or statistical inconsistencies are blocking issues and must not be concealed by visual adjustments.

## 6. Visual preview

Inspect the final 500 dpi PNG as a whole and at useful zoom levels. Check at least:

- titles, axis titles, ticks, legends, values, and annotations for clipping;
- text-to-text, text-to-data, and legend-to-data collisions;
- panel letters, axes, ticks, and baselines for alignment;
- unbalanced whitespace or an excessively cramped data region;
- line, point, uncertainty, and fill legibility at final physical size;
- visual height, margin rhythm, and baseline harmony among figures in the same row;
- matching ranges, legends, text, and colors across the three formats.

Production details such as margins, subplot spacing, legend position, annotation avoidance, line width, and marker size may be adjusted. If a correction requires changing content, statistical scope, chart type, visual encoding, or arrangement, stop and request user confirmation.

## 7. QA report

`qa-report.json` should contain at least:

```json
{
  "figure_id": "fig01",
  "generated_formats": ["pdf", "svg", "png"],
  "dimensions_mm": {"width": 90, "height": 90},
  "png": {"dpi": 500, "width_px": 1772, "height_px": 1772},
  "checks": {
    "files": "pass",
    "dimensions": "pass",
    "font": "pass",
    "color": "pass",
    "data_scope": "pass",
    "visual_preview": "pass",
    "write_boundary": "pass"
  },
  "exceptions": []
}
```

Mark checks that cannot be automated as `manual-pass` or `blocked`; never present them as automatically verified. Report a figure as complete only after resolving every blocking item.
