---
name: reaesrch[fig]
description: >
  Independently create, revise, and validate publication figures. May read project source code, result data, and Markdown documents to understand the research and plotting requirements, but all project writes are strictly limited to code/fig/; use for real-data plotting, journal-aware physical sizing, consistent typography and color, and synchronized PDF/SVG/PNG delivery.
license: LICENSE
---

# Scientific Figure Production

The user determines what each figure shows, its statistical scope, visual expression, and arrangement. This Skill handles physical-size calculation, directory organization, plotting implementation, synchronized export, and quality assurance for the confirmed design.

This Skill is fully independent. It is not a ResearchPilot phase and does not invoke or depend on any other Skill.

## Access Boundary

### Allowed reads

Read project material relevant to the current figures when needed to understand the research objective, data semantics, statistical implementation, and established terminology. This may include:

- source code, configurations, logs, result files, and data files under `code/`;
- relevant Markdown, LaTeX, and text documentation under `docs/` or elsewhere in the project;
- other data sources explicitly identified by the user.

Read only what is needed for the current figure task. Read access never implies permission to modify a file. Explicit requirements in the current conversation take precedence over older project documentation.

### Only allowed write location

Every new, modified, overwritten, cached, or temporary project file must remain under `code/fig/` at the project root. Do not modify any project file outside `code/fig/`, including source code, result data, documentation, dependency manifests, or configuration files.

- Create `code/fig/` if it does not exist.
- Do not create backups, snapshots, archives, history copies, or timestamped previous versions.
- Do not copy source data into `code/fig/` unless the user explicitly requests it.
- Do not modify dependency files or the project environment on your own. If existing tools are insufficient, report the missing capability and ask the user to decide.

## Required Built-In Specifications

Before planning any figure, read all of the following files completely:

- [Default layout sizes](references/layout-defaults.yaml)
- [Font library](references/font-library.yaml)
- [Color library](references/color-library.yaml)

Read [Figure specification](references/figure-spec.md) when defining figures. Read [Quality assurance protocol](references/qa-protocol.md) when exporting and validating them.

## Core Workflow

1. Confirm with the user what each figure shows, the visual form, the statistical scope, and how the figures are arranged. Project materials may reveal available data and existing implementations, but do not replace the user's design decisions.
2. Read the relevant source code, result data, and Markdown documents to locate the real data source, field meanings, statistical implementation, target layout, and output requirements. Never substitute simulated, estimated, or manually invented values for actual results.
3. Create `code/fig/layout-plan.yaml` and record every figure, row relationship, data source, statistical scope, and size source as defined in [Figure specification](references/figure-spec.md).
4. Solve the layout at row level before assigning individual figure sizes. Width is the primary constraint. Figures in one row must receive the same target height before plotting, and their widths plus gaps must equal the target row width. Never equalize heights by scaling exported files afterward.
5. Give every figure its own `code/fig/<figure-id>/` directory, `figure.yaml`, and plotting script. The script must independently reproduce that figure from the declared data sources.
6. Load the built-in font and color libraries. Resolve Arial exactly and reject silent fallback. Use only named colors or semantic roles from the color library. Any exception requires explicit user approval and an entry in `figure.yaml`.
7. Plot real data under the confirmed statistical scope. Do not independently change filtering, aggregation, uncertainty definitions, axis meaning, chart type, visual encoding, or arrangement.
8. Export same-stem PDF, SVG, and PNG files consecutively from the same canvas and plotting object. PNG defaults to 500 dpi. Always regenerate all three formats together.
9. Follow [Quality assurance protocol](references/qa-protocol.md) to check size, typography, colors, whitespace, clipping, overlap, and cross-format consistency. Write the results to `qa-report.json` inside the figure directory.
10. Inspect the final-size PNG preview. Production adjustments such as margins, legend placement, and label collision avoidance are allowed. If correction requires changing content, statistical scope, or visual design, stop and request user confirmation. After every adjustment, regenerate and revalidate all three formats.

## Size Rules

Apply configuration sources in this order, from highest to lowest precedence:

1. explicit journal or conference requirements;
2. user-specified dimensions for the current figure group;
3. user-specified dimensions for an individual figure;
4. default references in `layout-defaults.yaml`.

Defaults are layout references, not mandatory journal standards. Calculate height from content density, aspect ratio, and arrangement. Figures in the same row must have equal physical height. For target width `W`, gaps `g_i`, and individual widths `w_i`, enforce:

```text
sum(w_i) + sum(g_i) = W
```

Plot directly at final physical size using `inch = mm / 25.4`. Do not resize after export.

## Directory Convention

```text
code/fig/
├── layout-plan.yaml
├── <figure-id>/
│   ├── figure.yaml
│   ├── plot_<figure-id>.<py|R|other user-selected language>
│   ├── <figure-id>.pdf
│   ├── <figure-id>.svg
│   ├── <figure-id>.png
│   └── qa-report.json
└── ...
```

Follow the user's requested language or the project's existing plotting stack. If neither determines the choice, use the tool best supported by the existing data and environment. Formal figures must come from the independent script inside each figure directory and must not depend on hidden notebook state.

## Completion Conditions

Report completion only when all conditions hold:

- the confirmed content, statistical scope, expression, and arrangement were not changed without approval;
- every figure has its own directory, specification, and independently runnable plotting script;
- PDF, SVG, and PNG outputs all exist and agree;
- size and same-row constraints pass validation;
- font, type-role, color, and exception checks pass;
- the PNG preview has no visible clipping, collision, or unbalanced whitespace;
- every project write remains inside `code/fig/`.

At handoff, list every figure path, physical size, PNG pixel dimensions, data source, statistical-scope summary, and quality-assurance result.
