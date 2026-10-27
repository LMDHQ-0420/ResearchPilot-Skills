# ResearchPilot-Skills 完整流程详解

> 本文档逐阶段介绍每个 skill 的具体流程、约束和用户须知。概览和安装见 [README](README.md)。

每个阶段结束时 AI 主动给出下一步命令，未经你确认绝不跳阶段。

---

## 全局约束

以下约束贯穿所有阶段，任何 skill 均适用：

| # | 约束 |
|---|------|
| 1 | `docs/user_requirements.md` 中记录的用户约束优先于所有 skill 提示词中的默认指令 |
| 2 | 阶段间过渡必须由 AI 主动询问用户确认，不得自动跳过 |
| 3 | 不得捏造引用。所有参考文献必须经 web_search 验证，无法确认的加 `[待核实]` |
| 4 | 低置信度内容加 `⚠️ [低置信度：原因]`，不隐藏不确定性 |
| 5 | 每次改代码前必须先改对应设计文档，不允许只在代码里打补丁 |

---

## 阶段 A — `/research[A]-exploration` 方向探索与调研

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[A]-exploration 研究方向描述` |
| **前置条件** | 无（全新项目从这里开始）|
| **主要产物** | `docs/idea_report.md` Part 1、`docs/papers/` 论文、`docs/user_requirements.md` 阶段 A 章节 |
| **下一阶段** | `/research[B]-idea` |

### 流程步骤

| 步骤 | 做什么 | 根据什么 | 输出什么 | 约束 |
|------|--------|---------|---------|------|
| A-1 | 解析输入，收集需求 | 用户输入 | 写入 `user_requirements.md`（方向约束 / RQ 约束） | 信息不足时一次性提问，不分多轮 |
| A-2 | 初步文献检索 | 顶会/顶刊（NeurIPS/ICML/ICLR/CVPR/ACL 等）| 建议下载清单 | 按证据覆盖确定数量有效文献，每个 gap ≥2 篇支撑，最多 3 轮补充 |
| A-3 | 确认下载清单 | 检索结果 | 等用户确认后批量下载 | 未经用户确认不得擅自下载 |
| A-4 | 执行论文下载 | arXiv API → OpenReview API → 摘要 TXT | `docs/papers/{标题}.pdf` 或 `.txt` | 下载完成后输出每个文件完整路径 |
| A-4.5 | 询问是否逐篇详细介绍 | 用户偏好 | 记录到 `user_requirements.md` | 决定 Key Works 详略，无论选择都收录全部已下载论文 |
| A-5 | 锚定问题域，逐个确认方向 | 已下载文献 | 写入 `user_requirements.md` 研究方向字段 | 不一次性抛多个方向，一次聚焦 1–2 个深入讨论 |
| A-6 | 三层 RQ 提炼与确认 | 文献 gap | 写入 `user_requirements.md` RQ 字段，刷新确认卡片 | 一次提出一个 RQ，附 gap 引用/新颖性核查/可回答性 |
| A-7 | 汇编 Part 1，提交审核 | 已确认方向 + RQ + 必要性论证 | `idea_report.md` Part 1 | 展示全文供用户审核，确认后引导进入 B |

### 三层 RQ 结构

| 层次 | 名称 | 回答什么 | 对应实验 |
|------|------|---------|---------|
| RQ1 | 核心问题 | 我在解决什么大问题（领域痛点）| 主实验 |
| RQ2 | 机制问题 | 为什么现有方法做不好（关键瓶颈）| 消融实验 |
| RQ3 | 边界问题（可选）| 方法在什么条件下有效，局限在哪 | 附加实验 |

### 确认卡片（阶段 A/B 通用）

新增确认、恢复会话或阶段交接时显示当前已确认内容（仅显示非空字段）：
```
━━━━━━━━━━ 已确认内容 ━━━━━━━━━━
研究方向：{已确认}
主 RQ：{已确认}
次 RQ：{已确认}
方向约束：{用户约束}
RQ 约束：{用户约束}
参考论文：{用户指定}
技术框架：{阶段 B 才出现}
Pipeline：{阶段 B 才出现}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### 硬性约束

| # | 约束 |
|---|------|
| 1 | 未经用户确认，不得进入阶段 B |
| 2 | 下载清单必须经用户确认后才执行下载 |
| 3 | 每个 RQ 必须有文献 gap 支撑，新颖性必须经专项搜索核查 |
| 4 | 下载完成后必须输出每个文件的完整路径 |
| 5 | Part 1 汇编完成后展示全文供用户审核，确认无误后才引导进入阶段 B |

### 用户须知

- 回答 AI 的澄清问题，表达方向偏好和约束
- 在候选方向/RQ 上给出选择或修改意见
- 挑战 AI 给出的 gap 判断——每个 gap 都有论文证据，评判证据够不够
- 确认 Part 1 内容准确完整后，输入"确认"进入阶段 B

---

## 阶段 B — `/research[B]-idea` Idea 深化

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[B]-idea` |
| **前置条件** | `idea_report.md` 含 Part 1（阶段 A 完成）|
| **主要产物** | `idea_report.md` Part 2（Introduction、Related Works、Method）|
| **下一阶段** | `/research[C]-experiment` |

### 流程步骤

| 步骤 | 做什么 | 根据什么 | 输出什么 | 约束 |
|------|--------|---------|---------|------|
| B-0 | 汇编 Part 1 | 阶段 A 已确认内容 | `idea_report.md` Part 1 最终版 | 直接汇编，不重新生成；Key Works 详略遵从 A-4.5 选择 |
| B-1 | 确认技术框架（第一层）| `docs/papers/` 已有文献 | 写入确认卡片"技术框架"栏 | 必须先大量精读已有文献；框架只讨论大方向，不涉及实现细节 |
| B-2 | 确认详细 pipeline（第二层）| 已确认技术框架 | 写入确认卡片"Pipeline"栏 | 必须用大白话"第一步…第二步…"，禁止堆砌公式 |
| B-3 | 撰写 Method 正文 | 已确认 pipeline | `idea_report.md` Part 2 Method 章节 | pipeline 与正文必须完全一致；每个公式用 `>` 解释变量 |
| B-4 | 引用内容核验 | `docs/papers/` PDF 原文 | 追加原文依据批注 | 无法核验的标注 `⚠️ [低置信度：PDF 不可用]` 并登记待核实清单 |
| B-5 | Introduction 精修（第三层）| 已确认 Method | `idea_report.md` Part 2 Introduction | 论文投稿风格，从领域重要性→局限→动机→方法→贡献列表 |

### 文献阅读原则

每次动笔/改写 idea 之前：
1. **优先读 `docs/papers/` 已有文献**，不急于下载新论文
2. 现有文献不足以支撑设计决策时，再补充下载

### 硬性约束

| # | 约束 |
|---|------|
| 1 | 未经用户确认，不得进入阶段 C |
| 2 | 每次动笔前必须先大量精读已有文献 |
| 3 | pipeline 描述必须是大白话，不允许堆砌公式 |
| 4 | 所有引用必须从 PDF 定位支撑段落，无法核验的标注低置信度 |

---

## 阶段 C — /research[C]-experiment 实验设计

读取相关 baseline 文献与代码，围绕可证伪假设设计主实验、消融与边界实验。规划前复用设备、时间与预算约束；同时给出完整证据方案和可执行核心方案，明确支持、反对与不确定结果及结论边界。

已授权的阅读与调查直接执行，重要方法/协议选择集中确认一次。大纲获批后展开 Part 3，检查对照公平性、数据泄漏、随机性和成本；按阶段状态约定记录完成依据。详见 [C 阶段流程](skills/ResearchPilot-Skills-zh/research[C]-experiment/references/phase-C.md)。

---

## 阶段 D — `/research[D]-implementation` 实现设计

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[D]-implementation` |
| **前置条件** | `idea_report.md` 含 Part 3（阶段 C 完成）|
| **主要产物** | `docs/implementation.md`（函数级编码指南）|
| **下一阶段** | `/research[E]-coding` |

### 流程步骤

| 步骤 | 做什么 | 根据什么 | 输出什么 | 约束 |
|------|--------|---------|---------|------|
| D-0 | 收集编码约束 | 对话 | 写入 `user_requirements.md` 阶段 D 章节 | 框架选择 / 特殊要求 / 硬性要求 |
| D-1 | 生成 implementation.md | `idea_report.md` Part 2/3 + 用户约束 | `docs/implementation.md` | 必须先读 `user_requirements.md`；精确到每个函数签名/参数/返回值/实现逻辑 |
| D-末1 | 执行三项校验 | implementation.md vs idea_report.md | 校验报告（✅/⚠️）| 有问题直接修复再给用户看 |
| D-末2 | 确认后引导进入 E | 用户确认 | — | implementation.md 确认后提示用 `/research[E]-coding` |

### 代码结构规范

```
code/
├── src/
│   ├── models/
│   │   ├── {model_name}.py         # 本文方法，一个文件一个模型
│   │   └── baseline/
│   │       └── {baseline}.py       # 一个 baseline 一个文件，接口与主模型完全一致
│   ├── data/                       # 多个数据处理文件时建子目录，单文件直接 src/dataset.py
│   ├── train/                      # 多个训练文件时建子目录，单文件直接 src/train.py
│   ├── evaluate/                   # 多个评估文件时建子目录，单文件直接 src/evaluate.py
│   ├── utils/
│   ├── train.py                    # 训练入口
│   └── evaluate.py                 # 评估入口
├── scripts/                        # nohup shell 脚本，日志 → logs/YY-MM-DD_HH-MM-SS.log
├── configs/
│   ├── default.yaml
│   └── ablation_{variant}.yaml     # 每个消融变体一个 config
├── data/                           # 有预处理流程时建 raw/ + processed/；否则直接存放
├── results/                        # gitignored
└── logs/                           # gitignored
```

### implementation.md 三项校验

| 校验项 | 检查内容 |
|--------|---------|
| 实验覆盖 | Part 3 每个实验是否有对应模块/函数；每个消融变体是否有实现入口 |
| 逻辑一致性 | tensor shape 跨模块是否一致；loss 输入输出是否匹配；指标计算口径是否与 Part 3 一致 |
| 完整性 | 每个列出文件是否有对应章节；`src/models/baseline/` 是否覆盖 Part 3 所有 baseline |

### 硬性约束

| # | 约束 |
|---|------|
| 1 | 生成 implementation.md 前必须先读 `user_requirements.md` |
| 2 | 生成后立即执行三项校验，有问题先修复再给用户确认 |
| 3 | `requirements.txt` 不得包含 torch、torchvision、torchaudio |

---

## 阶段 E — /research[E]-coding 编码

按实现指南编码并验证，复用已有项目环境并记录完整版本与重建命令；用户要求 uv 时遵循项目的 uv 目录与锁定规则。普通实现错误直接修复，方法或评估变化才同步受影响的设计文档。历史日志按有意义改动单元追加，进度和当前运行说明可以更新。

完成时区分静态检查、冒烟运行与完整实验。提交与推送仅在用户授权时执行，不是编码完成的前提。详见 [E 阶段流程](skills/ResearchPilot-Skills-zh/research[E]-coding/references/phase-E.md)。

---

## 阶段 F — /research[F]-iteration 代码迭代

根据真实结果检查数据、实现、训练与方法假设，先排除错误和替代解释。仅在授权不足且需要重要方法或评估变化时集中确认；按影响更新文档、代码和验证记录。保留失败与负结果，按预算和预设停止条件结束，不以必须胜过 baseline 为迭代目标。详见 [F 阶段流程](skills/ResearchPilot-Skills-zh/research[F]-iteration/references/phase-F.md)。

---

## 阶段 G — 论文写作（G.0–G.8）

论文写作阶段拆分为 9 个独立 skill，可按推荐顺序走，也可单独触发某个章节反复迭代。

**推荐写作顺序**（彭思达学习笔记 / Master-cai 建议）：G.0 规划 → G.1 Method → G.2 Experiments → G.3 Abstract → G.4 Introduction → G.5 Related Works → G.6 Conclusion → G.7 整稿审阅 → G.8 中英翻译（可选）

### G 阶段通用约束

每个 G.1–G.6 skill 触发时，**必须先执行**：

| # | 准备步骤 |
|---|---------|
| 1 | 读手稿当前全文（避免章节割裂）|
| 2 | 读参考文献（References 章节或 .bib 文件）|
| 3 | 读手稿开头的 `=== 论文架构 ===` 注释 |
| 4 | 读 `docs/idea_report.md` 和 `docs/dev_log.md` |
| 5 | 读写作范例分析（若存在）|
| 6 | 扫描全文批注，列出待处理批注 |
| 7 | 向用户确认本章节写作思路，确认后再写 |

**批注格式**：md 用 `> %批注：`，LaTeX 用 `%批注：`

**版本管理**：每次修改前先备份手稿（`paper_{mm-dd_hh-mm}.{ext}`），在文件头追加修改记录。

**参考文献格式**（每个 G.x skill 都可维护）：
- md：`[N] {MLA 格式}` + `> 核心工作：` + `> 引用原因：`
- LaTeX .bib：`% [核心工作]` + `% [引用原因]`

---

### G.0 — `/research[G.0]-plan` 论文规划

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[G.0]-plan` |
| **前置条件** | 阶段 E 或 F 完成，有实验结果 |
| **主要产物** | 更新后的 `idea_report.md`、手稿架构注释、`notebooks/figures.ipynb` |
| **下一阶段** | `/research[G.1]-method`（建议）|

| 步骤 | 做什么 | 根据什么 | 输出什么 | 约束 |
|------|--------|---------|---------|------|
| G.0-1 | 更新 idea_report.md | 代码 vs idea_report 对比 | 原文件直接修改，文件头追加修改记录 | 列出所有差异，用户一次确认后才修改 |
| G.0-2 | 规划论文结构与图表 | 更新后的 idea_report.md | 大纲 + 图表规划表 | 先询问范例（步骤 3），确认范例后才确认结构 |
| G.0-3 | 询问写作范例 | 用户上传 | `docs/manuscripts/examples/style-notes.md` | 必须在确认结构前完成；范例结构优先于模板 |
| G.0-4 | 选择论文格式 | 用户选择 | 手稿文件（paper.md 或 paper.tex）| LaTeX 复制模版，原件不动 |
| G.0-5 | 询问写作语言（仅中文版）| 用户选择 | 写入 `user_requirements.md` | — |
| G.0-6 | 写详细架构注释进手稿 | 确认的大纲 + 图表规划 | 手稿文件开头注释块 | 精确到每个小节标题/内容/图表位置 |
| G.0-7 | 生成图表 notebook | 图表规划 | `notebooks/figures.ipynb` | 按论文顺序排列；多子图在同一单元格生成整张图 |

### 架构注释格式

```
=== 论文架构 ===
论文题目：{确认的题目}
目标会议/期刊：{名称}
写作语言：{中文/英文}

1. Introduction
   1.1 {小节标题}
       内容：{2-4 条要点}
       图表：{若有}
...
图表汇总（按出现顺序）：
- Fig.1 {标题}（{章节}，{手绘/Python}）— {说明什么，怎么看，体现什么结论}
- Table.1 {标题}（{章节}）— {说明什么}
===
```

### 图表设计规范（CCFA/IEEE 风格）

| 项目 | 规范 |
|------|------|
| 字体 | Times New Roman，正文 8pt，坐标轴标签 8pt，刻度 7pt，图例 7pt |
| 尺寸 | 单栏 3.5 英寸，双栏 7.0 英寸 |
| 坐标轴 | 去掉右轴和上轴 |
| 色板 | 本文方法蓝 `#2166AC`，baseline 红 `#D6604D`，变体绿 `#4DAC26`，参考灰 `#999999` |
| 误差棒 | 全文统一（均值±std 或 ±SEM）|
| 表格 | booktabs，无竖线，最优加粗，次优下划线 |
| 输出 | SVG + PNG 300dpi → `notebooks/fig/` |
| 图注 | 第一句是结论；自包含 |

---

### G.1 — `/research[G.1]-method` Method

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[G.1]-method` |
| **前置条件** | G.0 规划完成 |
| **下一阶段** | `/research[G.2]-experiments` |

写每个模块前先回答三问（从代码和 idea_report 找答案）：

| 问题 | 来源 |
|------|------|
| 这个模块如何运作？| 从代码读取实现 |
| 为什么需要这个模块？| 对应 RQ2 的某个瓶颈，从 idea_report 找 |
| 为什么这个模块有效？| 理论直觉或先验证据 |

每个模块小节按三要素顺序写：**模块设计 → 设计动机 → 技术优势**

| 小节 | 内容 |
|------|------|
| Overview | 一段话 + pipeline 图引用（Fig. N）|
| 各模块详述 | 三要素顺序，每个公式后解释所有变量 |
| 训练目标 | 损失函数定义 + 为什么选这个 loss |

---

### G.2 — `/research[G.2]-experiments` Experiments

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[G.2]-experiments` |
| **前置条件** | G.1 Method 已写 |
| **下一阶段** | `/research[G.3]-abstract` |

三个核心问题（来自彭思达学习笔记 / Master-cai）：

| 问题 | 对应实验 |
|------|---------|
| 本文方法是否优于强 baseline？| 主实验 |
| 哪些模块/设计选择带来了提升？| 消融实验 |
| 方法的泛化能力如何？| 附加实验 |

| 小节 | 必须包含 |
|------|---------|
| Experimental Setup | 数据集统计量 / baseline 选取理由 / 指标公式 / 实现细节 |
| Main Results | 结果表格 + 含具体数字的文字分析 + 原因解释 |
| Ablation Study | 每个变体说明 w/o 什么，说明组件必要性 |
| Further Analysis | 参数敏感性 / 效率对比 / 可视化 |

---

### G.3 — `/research[G.3]-abstract` Abstract

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[G.3]-abstract` |
| **前置条件** | G.1 Method 和 G.2 Experiments 已写 |
| **下一阶段** | `/research[G.4]-introduction` |

三种模板（来自彭思达学习笔记 / Master-cai），选一种：

| 版本 | 结构 |
|------|------|
| V1 Challenge→Contribution | 任务 → 挑战 → 贡献 → 优势 → 实验 |
| V2 Challenge→Insight→Contribution | 任务 → 挑战 → 洞见 → 贡献 → 优势 → 实验 |
| V3 多贡献 | 任务 → 贡献1+优势 → 贡献2+优势 → 实验 |

写前先从 idea_report.md / dev_log.md 回答四问：技术问题 / 技术贡献 / 方法为何有效 / 提供了什么洞见。Result 句必须含真实数字。

---

### G.4 — `/research[G.4]-introduction` Introduction

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[G.4]-introduction` |
| **前置条件** | G.3 Abstract 已写 |
| **下一阶段** | `/research[G.5]-related` |

五部分结构（来自彭思达学习笔记 / Master-cai）：

| Part | 内容 | 对应逻辑 |
|------|------|---------|
| Part 1 | 任务介绍 + 应用价值 + 目标指标 | 为什么这个问题重要 |
| Part 2 | 现有 SOTA 方法失败 + 根本技术原因 | 对应 RQ2 |
| Part 3 | 本文方法 + 为什么能解决挑战 + 新洞见 | 核心贡献 |
| Part 4 | 附加贡献 + 影响 | 完整贡献列表 |
| Part 5 | 实验摘要 + 贡献列表（只陈述事实，不用主观形容词）| 可验证的事实 |

---

### G.5 — `/research[G.5]-related` Related Works

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[G.5]-related` |
| **前置条件** | G.4 Introduction 已写 |
| **下一阶段** | `/research[G.6]-conclusion` |

每节标准段落：**主题句**（这类方法的核心思路）→ **代表性工作**（3–5 篇）→ **局限** → **过渡句**

末节固定为 **Research Gap**，必须与 Introduction Part 2 完全一致，不能矛盾。

---

### G.6 — `/research[G.6]-conclusion` Conclusion + References

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[G.6]-conclusion` |
| **前置条件** | G.5 Related Works 已写 |
| **下一阶段** | `/research[G.7]-review` |

Conclusion 四步：重述研究问题 → 总结关键证据（引用实验数字）→ 宏观影响 → 局限性 + 未来工作（具体，不泛泛）

本阶段做完整参考文献核验：每条引用必须有"核心工作"和"引用原因"注释，且真实存在。

---

### G.7 — `/research[G.7]-review` 整稿审阅

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[G.7]-review` |
| **前置条件** | 任意或全部章节写完后均可触发 |
| **下一阶段** | `/research[G.8]-translate`（中文写作）或完成 |

五维度检查（来自彭思达学习笔记 / Master-cai）：

| 维度 | 检查内容 |
|------|---------|
| 贡献 | 每个声称的贡献是否在 Experiments 中有直接支撑？|
| 写作清晰度 | 每段只有一个信息？段首句概括全段？术语全文一致？|
| 实验充分性 | 主实验/消融/附加实验是否覆盖所有 RQ？有无遗漏的强 baseline？|
| 评估完整性 | 比较是否公平？指标选择是否有领域依据？|
| 方法设计合理性 | 每个设计选择是否有动机？是否有消融验证？|

**Claim-Evidence 对齐**（必做）：

| Claim | Evidence | Status |
|-------|----------|--------|
| {claim 内容} | {对应实验/表/图} | supported / needs evidence / missing |

未支撑的 claim 必须补充实验或弱化表述，不可跳过。

---

### G.8 — `/research[G.8]-translate` 中→英翻译（仅中文版）

| 项目 | 内容 |
|------|------|
| **触发命令** | `/research[G.8]-translate` |
| **前置条件** | G.7 审阅通过，中文稿基本定稿 |
| **适用范围** | 仅中文版 skill 包含此阶段 |

| 步骤 | 说明 |
|------|------|
| 确认需求 | 询问是否需要生成英文 LaTeX 版本 |
| 选择模版 | 复用 G.0 中的模版，或上传新模版到 `docs/manuscripts/templates/` |
| 初始化 | 复制模版为 `paper-en.tex`；中文稿确认 `-zh` 后缀；共用 `references.bib` |
| 逐章翻译 | 每句英文上方一行保留原始中文注释；建立术语对照表写在文件头 |
| 版本记录 | 在 `paper-en.tex` 文件头追加修改记录 |

---

## 版本管理规范汇总

| 文件 | 策略 | 说明 |
|------|------|------|
| `idea_report.md` | 原文修改，无备份 | 文件头追加修改记录 |
| 论文手稿（paper.md / .tex）| 修改前复制备份 | `paper_{mm-dd_hh-mm}.{ext}`，原文件永远是最新版 |
| `dev_log.md` | 只追加，不删除 | 每次代码改动必须追加日志条目 |
| `implementation.md` | 原文修改 | 每次修改后重新执行三项校验 |
