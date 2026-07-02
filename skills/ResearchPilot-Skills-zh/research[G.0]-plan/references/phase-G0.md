# 阶段 G.0 详细流程：论文规划

---

## 步骤 1：更新 idea_report.md

### 读取材料

读取以下全部内容：
- `docs/idea_report.md`（全文，包含 Part 1/2/3）
- `src/models/` 下所有模型文件（逐个读取）
- `src/models/baseline/` 下所有 baseline 文件
- `configs/default.yaml` 及所有消融 config
- `docs/dev_log.md`（全文，重点看迭代记录）
- `results/` 下所有评估结果文件

### 对比分析

逐项对比代码实现与 idea_report.md 的描述，找出不一致之处。重点检查：
- Part 2 Method：模型架构描述、模块设计、超参数、公式是否与代码一致
- Part 3 实验设计：数据集、baseline 列表、消融变体、评估指标是否与 dev_log/results 一致
- Part 1 RQ：研究问题的描述是否仍然准确（迭代后可能有偏移）

### 展示差异，等用户确认

```
发现以下内容需要更新（代码与 idea_report.md 不一致）：

**Part 2 — Method（需要修改）**：
- {具体差异1，如：3.2 节描述窗口大小为 8，当前代码为 16}
- {具体差异2，如：新增 positional encoding 模块，idea_report 中未提及}

**Part 3 — 实验设计（需要修改）**：
- {具体差异，如：增加了 w/o PE 消融变体，idea_report 中无此项}

**Part 1 — 无需修改**
**References — 无需修改**

工作量评估：{小改动（< 30 分钟）/ 中等改动（需重写 1-2 节）/ 大改动（可能重写整个 Part 2）}

是否按以上范围更新 idea_report.md？可增删需要修改的部分。
```

### 执行更新

用户确认后：
1. 在 `idea_report.md` 文件头**追加**修改记录（不删除已有记录）：
```markdown
<!--
修改时间：{mm-dd_hh-mm}
修改内容：{具体改了什么，按 Part 分条说明}
上一状态：{修改前主要内容的一句话概述}
-->
```
2. 直接在 `idea_report.md` 原文件上修改（不创建备份文件）
3. 修改完展示变更摘要，确认无误后进入步骤 2

---

## 步骤 2：规划论文结构与图表

基于更新后的 `idea_report.md`，与用户确认：

### 确认论文大纲

与用户讨论并确认：
- 目标会议/期刊（CCFA-A/B/C / IEEE 期刊名称）——决定页数限制、格式要求
- 所有一级标题、二级标题（包括 Method 各小节名称）
- 每个章节的核心内容（每节 2-4 条要点）
- 贡献列表草稿（3-5 条，每条可验证，与某个实验直接对应）

### 规划图表

列出所有图表（按在论文中出现的顺序），格式如下：

```
图表规划（按论文出现顺序）：

Fig.1 — {标题}（{所在章节}）
  类型：框架图/流程图/折线图/柱状图/...
  生成方式：用户手绘 / Python 生成 / 两者结合
  说明什么：{这张图展示的核心内容，一句话}
  怎么看：{横纵轴含义、颜色语义、关键对比点，读者应关注哪里}
  体现什么结论：{这张图证明了什么}
  对应 RQ：{RQ1 / RQ2 / RQ3 / 不直接对应}

Table.1 — {标题}（{所在章节}）
  类型：定量对比表
  生成方式：notebook 生成 LaTeX 代码
  说明什么：{表格内容概述}
  格式要求：booktabs，最优值加粗，次优值加下划线，列名含义明确

...（所有图表逐一列出）
```

---

## 步骤 3：询问写作范例

**必须在确认论文结构之前完成**。

```
在确定论文结构之前，你是否有参考的写作范例可以提供？
（例如目标会议/期刊的历史录用论文）

如有，请将文件放入 docs/manuscripts/examples/ 目录，完成后告知我。
有范例时，G.1–G.6 每个阶段的写作结构和风格将以范例为准
（包括章节划分、段落长度、图表比例等；写作规范约束不受影响）。
```

若有范例：
1. 读取范例文件全文
2. 提取结构特征：章节数量和标题、每章段落数、图表数量和类型、语言风格（正式程度、句式偏好）
3. 将提取结果写入 `docs/manuscripts/examples/style-notes.md`：

```markdown
# 写作范例分析
> 范例文件：{文件名}
> 分析时间：{mm-dd_hh-mm}

## 结构特征
- 章节数量：{N} 个一级章节，{N} 个二级章节
- Introduction 结构：{段落数，每段内容概述}
- Method 结构：{小节数，每节内容概述}
- Experiments 结构：{小节数}
- 图表比例：{N} 张图，{N} 张表，平均每页 {N} 个图表

## 语言风格
- 句子平均长度：{短/中/长}
- 被动语态比例：{高/中/低}
- 技术术语密度：{高/中/低}
- 特殊写法：{如有值得注意的特殊写法}

## 与标准模板的差异
- {差异1，说明以范例为准还是以标准模板为准}
- {差异2，...}
```

---

## 步骤 4：选择论文格式

```
请选择论文格式：

① Markdown（.md）
   路径：docs/manuscripts/paper.md（中文）或 paper-en.md（英文）
   批注方式：在需要修改的段落后另起一行写：
   > %批注：{修改意见}

② LaTeX
   请将模版文件放入 docs/manuscripts/templates/ 目录，完成后告知我。
   或告知目标会议/期刊名称，我协助确认对应模版。
   路径：docs/manuscripts/paper.tex（或 paper-zh.tex / paper-en.tex）
   批注方式：在需要修改的行后写：
   %批注：{修改意见}
   参考文献：docs/manuscripts/references.bib（中英文共用）
```

若选 LaTeX：
- 将模版复制为 `paper.tex`（或 `paper-zh.tex`），模版原文件不动
- 创建 `docs/manuscripts/references.bib`（若不存在）

---

## 步骤 5：询问写作语言（仅中文版 skill）

```
请选择论文写作语言：

① 中文（可在 G.8 阶段将中文稿翻译为英文 LaTeX 版本）
② 英文（直接写英文，无需翻译阶段）
```

将用户选择写入 `docs/user_requirements.md` 阶段 G 章节。

---

## 步骤 6：将详细架构注释写入手稿

将论文结构（含每章写法 + 图表位置）以注释形式写入手稿文件开头。精确到每个小节的标题、写什么内容、使用哪些图表。

**md 格式模板**：
```markdown
<!--
修改时间：{mm-dd_hh-mm}
修改内容：初始化手稿，写入论文架构注释

=== 论文架构 ===
目标会议/期刊：{名称}
写作语言：{中文/英文}
写作范例：{docs/manuscripts/examples/{文件名} / 无}

1. Introduction
   1.1 领域背景与研究动机（1 段）
       内容：{领域重要性，引用 2-3 篇标志性工作}
   1.2 现有方法局限（1-2 段）
       内容：{逐条列出局限，每条对应引用，对应 RQ2}
   1.3 本文方法概述（1 段）
       内容：{切入点 + pipeline 高层描述}
   1.4 贡献列表（1 段）
       内容：{3-5 条，每条可验证，对应某个实验}
       图表：Fig.1（teaser 图或框架图）

2. Related Works
   2.1 {相关方向一}（1 段）
       内容：{代表性工作 + 局限}
   2.2 {相关方向二}（1 段）
   2.3 Research Gap（1 段）
       内容：{综合各类方法局限，指出本文填补的空白}

3. Method
   3.1 Overview（1 段 + Fig.N）
       内容：整体 pipeline 描述，Fig.N 框架图引用
   3.2 {模块名称一}（2-3 段）
       内容：模块设计 → 动机（对应 RQ2）→ 技术优势
       公式：{公式描述}
   3.3 {模块名称二}（2-3 段）
       内容：...
   3.4 训练目标（1-2 段）
       内容：损失函数定义 + 为什么选这个 loss

4. Experiments
   4.1 Experimental Setup（1-2 段）
       内容：数据集（{名称，统计量}）/ baseline（{列表，选取理由}）/ 指标（{公式}）/ 实现细节
   4.2 Main Results（2-3 段）
       图表：Table.1（主实验对比表），Fig.N（结果对比图）
       内容：定量分析，说明本文在哪个指标超过哪个 baseline 多少
   4.3 Ablation Study（1-2 段）
       图表：Fig.N（消融柱状图）
       内容：逐个组件说明必要性
   4.4 {Further Analysis 标题}（1-2 段）
       图表：{若有}
       内容：参数敏感性/效率对比/可视化分析

5. Conclusion
   内容：重述研究问题 → 总结证据 → 宏观影响 → 局限 + 未来工作

References
   格式：{MLA / bibtex}
   每条含：核心工作 + 引用原因

图表汇总（按出现顺序）：
{逐一列出所有图表编号、标题、位置}
===
-->
```

---

## 步骤 7：生成图表 notebook

在 `notebooks/figures.ipynb` 中，按论文出现顺序创建单元格。

每个数据图的单元格格式（多子图必须在一个单元格内生成完整图）：

```python
# ============================================================
# Fig.N — {标题}（{所在章节}）
# ------------------------------------------------------------
# 图注（完整）：{完整图注文字，英文}
# 说明什么：{这张图展示的核心内容}
# 怎么看：{横纵轴含义，颜色语义，关键对比点，读者应关注哪里}
# 体现什么结论：{一句话结论}
# ============================================================

import matplotlib.pyplot as plt
import matplotlib as mpl
import numpy as np

# CCFA/IEEE 全局样式
mpl.rcParams.update({
    'font.family': 'Times New Roman',
    'font.size': 8,
    'axes.titlesize': 9,
    'axes.labelsize': 8,
    'xtick.labelsize': 7,
    'ytick.labelsize': 7,
    'legend.fontsize': 7,
    'lines.linewidth': 1.0,
    'lines.markersize': 4,
    'axes.spines.right': False,
    'axes.spines.top': False,
    'figure.dpi': 300,
    'savefig.dpi': 300,
    'savefig.bbox': 'tight',
})

# 语义化色板（colorblind-safe）
COLORS = {
    'proposed': '#2166AC',   # 蓝：本文方法
    'baseline': '#D6604D',   # 红：baseline
    'variant':  '#4DAC26',   # 绿：消融变体
    'ref':      '#999999',   # 灰：参考线/下界
}

# 从 results/ 读取真实数据
# data = ...（从 results/ 下的 json/csv 文件读取）

# 生成图（多子图时一次性生成整张图）
fig, axes = plt.subplots(...)
# ... 绘图代码 ...

# 输出到 notebooks/fig/（SVG 矢量 + PNG 300dpi）
# fig.savefig('notebooks/fig/Fig_N.svg', format='svg')
# fig.savefig('notebooks/fig/Fig_N.png', dpi=300)
plt.show()
```

每个表格的单元格格式：

```python
# ============================================================
# Table.N — {标题}（{所在章节}）
# ------------------------------------------------------------
# 说明什么：{表格内容概述}
# 列含义：{每列的含义和单位}
# 行含义：{每行代表什么（方法名/数据集/变体）}
# 格式要求：booktabs，最优值加粗，次优值加下划线
# ============================================================

import pandas as pd

# 从 results/ 读取真实数据
# data = ...

# pandas 预览（用于检查数据）
df = pd.DataFrame(...)
display(df)

# 生成 LaTeX 代码（可直接复制进论文）
print(df.to_latex(
    index=True,
    bold_rows=False,
    escape=False,
    # booktabs=True  # 需要 pandas >= 1.4
))
# 注：LaTeX 代码需手动添加 \toprule/\midrule/\bottomrule，加粗/下划线
```

---

## 图片设计规范（CCFA/IEEE 风格）

- **尺寸**：单栏图 3.5 英寸宽，双栏图 7.0 英寸宽，高度按内容比例调整
- **字体**：Times New Roman，正文 8pt，坐标轴标签 8pt，刻度 7pt，图例 7pt
- **线宽**：1.0–1.5pt
- **色板**：colorblind-safe，语义化（见上方 COLORS）
- **坐标轴**：去掉右轴和上轴（spines.right=False, spines.top=False）
- **图例**：放图内，不单独放外
- **误差棒**：全文统一（均值±std 或 ±SEM，选一种，在 Experimental Setup 说明）
- **表格**：booktabs 格式，无竖线，最优加粗，次优下划线
- **输出**：SVG（矢量，用于编辑）+ PNG 300dpi（用于提交），保存到 `notebooks/fig/`
- **一图一结论**：图注第一句话就是这张图的结论
- **图注自包含**：只看图注不看正文也能理解这张图
