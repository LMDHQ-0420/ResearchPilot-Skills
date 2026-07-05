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
- 论文题目（可提供候选题目由用户选择或自由填写）
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
论文题目：{确认的题目}
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

# 全局样式
mpl.rcParams.update({
    'font.family': 'Arial',          # 顶刊标准；Arial 不可用时回退 DejaVu Sans
    'svg.fonttype': 'none',          # SVG 文字保持可编辑
    'pdf.fonttype': 42,              # PDF 文字保持可编辑
    'font.size': 7,
    'axes.titlesize': 8,
    'axes.labelsize': 7,
    'xtick.labelsize': 6,
    'ytick.labelsize': 6,
    'legend.fontsize': 6,
    'lines.linewidth': 1.0,
    'lines.markersize': 4,
    'axes.linewidth': 0.8,
    'axes.spines.right': False,
    'axes.spines.top': False,
    'legend.frameon': False,
    'figure.dpi': 300,
    'savefig.dpi': 300,
    'savefig.bbox': 'tight',
})

# 语义化色板（colorblind-safe）
# 规则：红色 / 橙色专用于失败 / 降级 / 警示，不得用于普通 baseline
COLORS = {
    'proposed':  '#2CB1A1',  # teal：本文方法（全图统一）
    'baseline1': '#4C78A8',  # 蓝：强 baseline
    'baseline2': '#8172D5',  # 紫：次 baseline
    'baseline3': '#B4C0E4',  # 淡蓝：弱 / 经典 baseline
    'variant':   '#4DAC26',  # 绿：消融变体
    'ref':       '#909090',  # 灰：参考线 / 不可用 baseline
    'failure':   '#C44E52',  # 红：失败 / 降级 / 超时（专用）
    'warning':   '#E6A23C',  # 橙：警示 / 阈值（专用）
    'neutral':   '#D9D9D9',  # 浅灰：缺失值填充
}

# 图类型选择规则：
#   主质量指标（多方法 × 多数据集） → 分组柱状图 或 方法×数据集热图
#   运行时 / 内存对比               → 方法×数据集热图（log10 值）
#   加速比排名                      → 水平 lollipop（对数 x 轴），显示中位数 ± IQR
#   消融组件贡献                    → delta lollipop 或哑铃图（paired slope）
#                                     不用普通柱状图（除非绝对量是核心信息）
#   参数敏感性                      → small-multiple 折线图，端点直接标签，不用图例
#   可扩展性 / 延迟趋势             → 对数 x 折线图，端点直接标签
#   多指标权衡（如 F1 vs 运行时）   → scatter，双轴标注方向（↑better / ↓better）
#   鲁棒性 / 失败分析               → 失败区域热图 或 heat-bubble 矩阵

# 对数坐标规则（强制）：
#   运行时 / 内存 / 加速比：max/min > 10 时必须用对数坐标
#   精度 / F1 / 召回率：0–1 或 0–100 线性坐标，不缩放
#   误差指标（MAE/RMSE 等）：轴标签标注 "↓ better"

# 缺失 / 超时 baseline 处理（不得静默丢弃）：
#   热图：用 COLORS['neutral'] 填充对应格，标注 "N/A" 或 "T/O"
#   柱状图：用虚线框占位，标注 "N/A" 或 "T/O"

# 布局规则：
#   4–6 个 panel 为宜
#   主 claim panel（主实验对比）应大于辅助 panel，不做等大网格
#   机制 / 消融 / 效率 panel 压缩为一行
#   图例：优先端点直接标签；需要图例时用一条共享图例条，不在每个 panel 重复

# 布局防护规则（每张图都必须遵守，防止常见排版问题）
#
# 1. 整体布局方式（二选一，不得混用）
#    方案 A：等大网格  →  plt.subplots(..., constrained_layout=True)
#    方案 B：不等大 GridSpec  →  fig.add_gridspec(..., hspace=0.6, wspace=0.55)
#            + fig.subplots_adjust(left=0.08, right=0.98, top=0.96, bottom=0.11)
#    禁止：constrained_layout=True 与手动 GridSpec hspace/wspace 同时使用
#    保存：fig.savefig(..., bbox_inches="tight") 两种方案都必须加
#
# 2. x 轴标签
#    - 标签数 > 8：rotation=35, ha="right", fontsize=6
#    - 标签字符 > 12：截断为 11 字符 + "..."（在 set_xticks 前处理，不在渲染后处理）
#    - 上限：x 轴 ≤ 12 个，y 轴 ≤ 10 个
#
# 3. 图例防遮挡
#    - 2–6 条折线：用端点直接标注（ax.annotate + textcoords="offset points"）
#    - 必须用图例时：ax.legend(frameon=False, fontsize=6)，不放在数据密集区域
#
# 4. Colorbar
#    - fraction=0.033（panel 多）或 0.046（panel 少），pad=0.012–0.02
#    - cbar.ax.tick_params(labelsize=body_fontsize - 1)
#    - cbar.outline.set_visible(False)
#
# 5. Panel 标签与标题分离（防碰撞）
#    - 字母标签：ax.text(-0.11, 1.055, "a", transform=ax.transAxes,
#                        fontsize=8.4, fontweight="bold", va="bottom", ha="left")
#    - 标题：ax.set_title("短名词短语", loc="left", fontsize=7.6, pad=4.5)
#    - 两者必须分开设置，不合并
#
# 6. 多 panel 间距参考（3 行图含旋转标签）
#    hspace=0.62, wspace=0.56, bottom=0.105

# 从 results/ 读取真实数据
# data = ...（从 results/ 下的 json/csv 文件读取）

# 生成图（多子图时一次性生成整张图）
fig, axes = plt.subplots(...)
# ... 绘图代码 ...

# 输出到 notebooks/fig/（SVG 矢量 + PNG 300dpi）
# fig.savefig('notebooks/fig/Fig_N.svg', format='svg', bbox_inches='tight')
# fig.savefig('notebooks/fig/Fig_N.png', dpi=300, bbox_inches='tight')
plt.show()

# ── 视觉自检（每张图生成后必须执行）──────────────────────────
# 保存 PNG 后，读取 notebooks/fig/Fig_N.png，检查以下问题：
#   - 标签 / 刻度被图边界截断
#   - x 轴标签互相重叠
#   - 图例遮挡数据区域
#   - Colorbar 与 panel 内容重叠
#   - Panel 字母标签与标题碰撞
#   - 任何文字显示不完整
# 发现问题 → 修改代码 → 重新生成 → 再次检查
# 最多迭代 2 次；2 次后仍有问题则告知用户并说明原因
# ─────────────────────────────────────────────────────────────
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

## 图片设计规范

- **尺寸**：单栏图 3.5 英寸（89mm）宽，双栏图 7.2 英寸（183mm）宽，高度按内容比例调整
- **字体**：Arial（不可用时回退 DejaVu Sans），正文/轴标签 7pt，刻度 6pt，图例 6pt，panel 标签 8pt bold
- **线宽**：0.8–1.5pt（坐标轴 0.8pt，数据线 1.0–1.5pt）
- **色板**：colorblind-safe，语义化（见上方 COLORS）；红色/橙色专用于失败/降级，不用于普通 baseline
- **坐标轴**：去掉右轴和上轴；轴线宽 0.8pt；误差指标轴标签标注"↓ better"，精度指标标注"↑ better"
- **对数坐标**：运行时/内存/加速比 max/min > 10 时强制使用对数坐标
- **图例**：优先端点直接标签；需要图例时用一条共享图例条，不在多个 panel 中重复
- **缺失 baseline**：不得静默丢弃；热图用浅灰（#D9D9D9）填充并标注"N/A"或"T/O"；柱状图用虚线框占位
- **布局**：主 claim panel 应大于辅助 panel；4–6 panel 为宜；避免等大 dashboard 格
- **误差棒**：全文统一（均值±std 或 ±SEM，选一种，在 Experimental Setup 说明）
- **表格**：booktabs 格式，无竖线，最优加粗，次优下划线
- **输出**：SVG（矢量，用于编辑）+ PNG 300dpi（用于提交），保存到 `notebooks/fig/`
- **一图一结论**：图注第一句话就是这张图的结论
- **图注自包含**：只看图注不看正文也能理解这张图
