# 图件规格

在绘图前，把用户确认的设计、只读发现的数据来源和最终尺寸写入 `code/fig/layout-plan.yaml`。每幅图再在自己的 `figure.yaml` 中保存可独立复现的信息。

## 整体版面规格

`layout-plan.yaml` 至少包含：

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

字段可以按项目需要扩展，但必须能验证：

- 每幅图的最终宽高；
- 哪些图属于同一行；
- 同行图的共同高度；
- 间距和总宽度；
- 尺寸来自期刊、用户还是默认参考值。

若期刊给出明确要求，把原始要求及其来源写入 `publication_override`。覆盖默认值时不得改写 Skill 内置 YAML。

## 单图规格

每幅图的 `figure.yaml` 至少记录：

```yaml
version: 1
figure_id: fig01

purpose: "这幅图要说明的核心内容"
expression: "折线图"
arrangement: "row-1 的左图"

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

其中 `purpose`、`expression`、`arrangement` 和 `data` 的统计口径必须来自用户确认，不能根据结果效果擅自重写。

## 设计确认门槛

开始正式绘图前必须明确：

1. 图件要回答或展示什么；
2. 使用哪些真实数据；
3. 筛选、分组、聚合及误差如何定义；
4. 图形类型和视觉编码；
5. 坐标轴、图例和必要标注；
6. 图件之间的排列关系；
7. 默认版面还是期刊覆盖尺寸。

可以读取源代码和项目文档来发现候选答案并向用户总结；凡是会改变统计结论或图形表达的歧义，必须由用户确认。

## 目录与命名

- `figure-id` 使用稳定、简洁、适合文件名的标识，如 `fig01`、`fig02-ablation`。
- 每幅正式图只有一个目录和一个主绘图脚本。
- 三种正式输出与 `figure-id` 同名。
- PNG 同时作为最终栅格输出和视觉预览，不另建重复预览文件。
- QA 报告固定为 `qa-report.json`。
- 不生成 `backup/`、`archive/`、`history/` 或时间戳副本。

## 数据真实性

- 直接读取声明的数据来源，不把图上数值硬编码进绘图脚本。
- 若原始结果需要转换，转换过程必须写在该图的独立脚本中并与 `figure.yaml` 的统计口径一致。
- 记录筛选前后样本数、分组数量及关键聚合结果，便于核对。
- 随机抖动、抽样或 bootstrap 若属于用户确认的表达或统计流程，固定并记录随机种子。
- 数据缺失、字段含义不明或结果互相冲突时停止，不自行填补或猜测。
