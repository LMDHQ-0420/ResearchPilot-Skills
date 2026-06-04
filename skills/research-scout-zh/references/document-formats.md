# 文档格式规范

`idea_report.md`、`dev_log.md` 和 `code_guide.md` 的详细格式规范。
章节的存在与内容篇幅遵循 `references/template-flexibility.md`。

---

## idea_report.md

### Markdown 符号语义

| 符号 | 含义 | 约束 |
|------|------|------|
| `#` | 文件标题 / 部分分隔符 | 恰好 3 处：文件标题、`# Part I`、`# Part II` |
| `##` | 主要章节 | 语义化名称；编号可选 |
| `###` | 小节 | 语义化名称；数量跟随内容 |
| `>` | 解释性注释 | 紧跟正式内容之后；对上一段落的通俗解释 |
| `>>` | 来源注释 | 紧跟借用的观点之后；必须引用 `[n]`；附上已验证的原文句子 |
| `⚠️ [low confidence: ...]` | 不确定性标记 | 放在证据不足的论断末尾；在 Pending Verification 中登记 |
| `` `code` `` | 行内代码 | 文件名、函数名、变量名、命令、字段名 |
| ` ```text ` | 数据流 / 结构图 | |
| ` ```python ` | 伪代码 | |
| `$$...$$` | 块级公式 | |
| `$...$` | 行内公式 | |
| `**粗体**` | 关键术语首次出现；表格中方法行的值 | 最多 5 个词 |
| `1.` 有序列表 | 仅用于 References 章节 | |
| `- [ ]` 复选框 | 实现策略选项 | |
| `---` | 部分分隔符；每个审阅检查点前 | 仅限这些位置 |
| HTML 注释 | 最终输出中禁止使用 | |

### 第一部分模板

```markdown
# {Topic} Idea Report
> Project: {project_name} | Generated: {YYYY-MM-DD} | Phase: 1 | Status: PENDING_REVIEW
> Omitted: {chapter} — {reason}    ← 仅在省略章节时包含
> Extended: {chapter}              ← 仅在新增章节时包含

---
# Part I: Literature Survey & Idea

## Topic Overview

### Topic Description
{该研究方向是什么，解决什么问题，属于哪个领域。一段话。}

### Development Timeline
{连续散文，按时间顺序列出 ≥ 4 个关键里程碑。每个里程碑引用一篇代表性论文。格式：Author et al. [n] proposed ..., solving ...}

### Key Works Worth Noting
{值得学习的工作——不一定是 SOTA。包括在方法论上有启发性的工作。
每篇论文一个小节。}

#### {简称} ({Venue} {Year})
{核心贡献，学术风格，1–2 句话}

>> Borrowing value: {对本想法的具体帮助，1 句话} [n]

### Candidate Idea Selection
> 在第一阶段自动生成。被选中的想法标记 [Selected]；其他标记 [Not adopted]。

#### Idea {n}: {Title} `[Selected / Not adopted]`
- **Core**: {一句话}
- **Angle**: method transfer / improvement / reformulation
- **Novelty**: {High/Medium} — closest: {paper} [n], difference: {具体差异}
- **Feasibility**: {High/Medium/Low} — main risk: {风险}
- **Self-critique**:
  - Novelty authenticity: {评估}
  - Experiment validity: {评估}
  - Baseline fairness: {评估}

---

## Introduction

### Research Background
{领域重要性与应用价值。学术风格。}

> {对上一段落的通俗解释}

### Limitations of Existing Methods
{要点列表，每条涵盖一类方法并给出具体引用。}

> {这些局限在实践中为何重要}

### Contributions
The main contributions of this paper are as follows:
- We propose ... （方法层面）
- We design ... （技术层面）
- We demonstrate on ... datasets, achieving ...

> 注：第三条在第一阶段为占位符；实验完成后填入实际数字。

---

## Related Work

### Development Timeline
| Year | Work | Venue | Core Contribution | Limitation |
|------|------|-------|-----------------|-----------|
| {year} | {Author} et al. [n] | {Venue} | {≤ 15 字} | {≤ 10 字} |

### Recent Progress (last 2 years)
{每篇论文一段：Title (Venue Year) [n]：方法描述。关键指标结果。}

>> {与本想法的关系：启发了哪个设计，或是超越的目标} [n]

### Research Gap
{现有方法的共同弱点，引出本文的动机。学术风格。}

> {一句话通俗概括：现有方法卡在哪里}

---

## Proposed Method

### Overview
{方法做什么，然后怎么做。学术风格。}

> {直觉：用类比或日常语言解释}

```text
Input → [Module A: role] → [Module B: role] → Output
```

> 数据流：{对每个箭头的文字说明}

### {Component Name}
{输入/输出定义，步骤，公式}

$$
{equation}
$$

> {对每个符号直觉的通俗解释}

>> {来源}：This design is inspired by [n], which ... This work extends it by ... [n]
>> Source text: "{PDF 中的逐字原句}" (Section {X.X})

### Novelty Summary
1. **{创新点 1}**: {一句话}
2. **{创新点 2}**: {一句话}

### Feasibility Assessment
| Dimension | Rating | Notes |
|-----------|--------|-------|
| Compute | Low/Medium/High | 预计 {N}GB 显存，约 {N}h/epoch |
| Implementation | {1wk/2wk/1mo} | 主要复杂度：{module} |
| Innovation risk | Low/Medium/High | {例如：平行工作可能重叠} |

---

## Baseline Plan

| Baseline | Source [n] | Venue/Year | Why chosen | Expected advantage of ours |
|---------|-----------|-----------|-----------|--------------------------|

---

## References

> IEEE 格式。所有条目通过 web_search 验证。无法验证的条目标注 [to verify]。

1. {Last, F.}, et al., "{Full Title}," in *{Full Venue Name}*, vol. {v}, no. {n}, pp. {pp}, {year}.

> **Main work**: {论文做了什么，≤ 20 字}
> **Why cited**: {对本想法的具体帮助，≤ 20 字}
> **PDF**: `docs/papers/{full title}.pdf` / `[PDF unavailable]`
> **Verified text**: "{逐字支撑句}" (Section {X.X}) / `⚠️ [low confidence: ...]`

---

## Pending Verification
> 自动维护。手动验证后打勾。

- [ ] {论断}（Section {n} — 原因：{PDF unavailable / no supporting text found / conflicting sources}）

---

> ⚠️ **Phase 1 Review Checkpoint**
> - /research step2  — 确认后进入实验设计
> - /research revise "feedback"  — 重新生成第一部分
```

### 第二部分模板

在第一阶段审阅检查点之后追加：

```markdown
---
# Part II: Experiment Design
> Updated: {YYYY-MM-DD} | Phase: 2 | Status: PENDING_REVIEW
> User experiment requirements: see docs/user_requirements.md → ## Phase 2

### Feasibility Verification Summary
| Item | Status | Notes |
|------|--------|-------|
| Dataset {name} | ✅ Available / ⚠️ Requires application / ❌ Unavailable | {link} |
| Baseline {name} code | ✅ Available / ⚠️ Needs self-impl / ❌ Unavailable | {repo} |
| GPU memory | ✅ OK / ⚠️ Needs adjustment | 预计 {N}GB，用户有 {M}GB |

---

## Experiment Overview

### Experiment Goals
{要验证的核心假设。每条对应一个创新组件。}

### Implementation Strategy
- [x] From scratch / [ ] Based on: {project/link}
  - 如基于现有项目：所需修改：{list}

### Environment
| Item | Config |
|------|--------|
| Python | {x.x} |
| Framework | {PyTorch x.x / TF x.x} |
| Hardware | {GPU model}, VRAM ≥ {N}GB |
| Estimated training | {N}h/epoch × {M} epochs |

### Reproducibility
所有实验在 `torch`、`numpy`、`random` 中统一使用随机种子 `42`。

### Datasets
| Dataset | Source | Size | Split | Preprocessing |
|---------|--------|------|-------|--------------|
| {name} | {link} | {N samples} | {ratio} | {steps} |

---

## Main Experiments

### Experiment Procedure
{步骤说明：数据准备 → 模型初始化（lr、bs、optimizer、scheduler）→
训练（epochs、early stopping）→ 评估 → 结果记录}

### Baseline Configuration
| Baseline | Code source | Key hyperparams | Metrics | Est. train time | VRAM |
|---------|-------------|----------------|---------|----------------|------|

### Evaluation Metrics
| Metric | Formula | Expected (ours) | Expected (SOTA) | Direction |
|--------|---------|----------------|----------------|---------|
| {name} | {formula} | {estimate} | {lit value} | higher/lower is better |

### Expected Results（占位符——通过 /research log-results 填入）
| Method | {Dataset} | {Metric1} | {Metric2} |
|--------|-----------|-----------|-----------|
| {Baseline} | — | — | — |
| **Ours** | — | **?** | **?** |

---

## Ablation Study

> 目的：独立验证每个创新组件。

| ID | Variant | Modification | Purpose | Dependency | Expected direction |
|----|---------|-------------|---------|-----------|-------------------|
| A1 | w/o {module} | 移除 {module}，替换为 {fallback} | 验证 {module} | 在主实验之后 | {metric} 下降 |

---

## Additional Analysis
{可视化、鲁棒性测试、效率对比——仅在有意义时包含}

---

> ⚠️ **Phase 2 Review Checkpoint**
> - /research step3  — 确认后进入编码
> - /research revise "feedback"  — 重新生成第二部分
```

---

## dev_log.md

```markdown
# Dev Log — {project_name}
> Created: {YYYY-MM-DD} | Last Updated: {YYYY-MM-DD}
> Linked design: docs/idea_report.md (Phase 2, updated {date})

## Project Overview
| Item | Value |
|------|-------|
| Research direction | {topic} |
| Strategy | From scratch / Based on {project} |
| Code root | code/ |
| Design version | {Part II Updated date} |
| Language | Python |
| Framework | {PyTorch / TF / JAX} |
| User coding requirements | see docs/user_requirements.md → ## Phase 3 |

## Project Architecture

```text
code/
└── ...（与已确认的结构完全一致）
```

### Module Responsibilities
| File/Dir | Responsibility | Input | Output | Key deps |
|----------|---------------|-------|--------|---------|

## Model Architecture（可选——无自定义模型时省略）

### Overall Structure
```text
Input [B, L, D] → [Module A: role] → [Module B: role] → Output [B, 1]
```

### Core Module Pseudocode
```python
class {ModelName}(nn.Module):
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        ...
```

## Project Logic

### Data Flow
```text
Raw files → Dataset.__getitem__ → DataLoader(batch) → transforms → model input tensor
```

### Training Flow
```text
load config → init model/optimizer/scheduler → epoch loop:
  → train_one_epoch → validate → early_stopping check → save best_ckpt
```

### Inference Flow
```text
load best_ckpt → test DataLoader → forward → postprocess → compute metrics → save csv
```

## Progress

| Module | File | Status | Completed | Notes |
|--------|------|--------|-----------|-------|
| Init | README.md, requirements.txt, configs/ | ✅ Done | {date} | |
| Data loading | src/data/ | ⬜ TODO | — | |
| Main model | src/models/{model}.py | ⬜ TODO | — | |
| Train loop | src/trainers/trainer.py | ⬜ TODO | — | |
| Utils | src/utils/ | ⬜ TODO | — | |
| Scripts | scripts/ | ⬜ TODO | — | |
| Baselines | baselines/ | ⬜ TODO | — | |

状态说明：⬜ TODO / 🔄 WIP / ✅ Done（运行验证通过）/ ❌ Blocked

## Dev Log Entries

### {YYYY-MM-DD} — {操作摘要}
- **Completed**: {完成的内容}
- **Issues**: {遇到的问题，或"none"}
- **Solutions**: {解决方式，或"none"}

## Known Issues & TODO（可选——出现问题时添加）
- [ ] {问题}

---

> 如需修改实验设计：/research back-to-step2 "reason"
> 本 dev_log 将被加上 [ARCHIVED] 前缀，历史记录得以保留。
```

---

## code_guide.md

```markdown
# Project Implementation Guide — {Topic}
> Project: {project_name} | Created: {YYYY-MM-DD} | Last Updated: {YYYY-MM-DD}
> Linked design: docs/idea_report.md | Change log: docs/dev_log.md
> Omitted: {chapter} — {reason}    ← 仅在省略章节时包含

---

## Project Origin

### Strategy
{From scratch / Based on open-source project}

> {选择该策略的原因}

### Original Project Info（仅策略 A）
- **Name**: {name}
- **URL**: {GitHub URL}
- **Commit**: {hash — 固定所用版本}
- **Scope of changes**: NEW: {list} | MODIFIED: {list} | KEPT: {list}

---

## Project Structure

### Full Directory Tree
```text
code/
└── ...（精确的已确认结构，每个文件附一行注释）
```

### File Responsibilities
| File/Dir | Responsibility | Called by |
|----------|---------------|-----------|

---

## Launch Guide

### Train Main Model
```bash
bash scripts/train.sh
```

**可调参数**（在 scripts/train.sh 中修改）：
| Param | Default | Description |
|-------|---------|-------------|
| --config | configs/default.yaml | 配置文件路径 |
| --seed | 42 | 随机种子 |
| --gpu | 0 | GPU 索引 |

**输出文件**：
| File | Path | Content | How to read |
|------|------|---------|------------|
| Best weights | results/checkpoints/best.pth | 最佳验证轮次参数 | `torch.load(path)` |
| Training curve | logs/train_{ts}.csv | 每轮 loss/metric | CSV，第一列 = epoch |

> {如何解读训练曲线：正常收敛的样子，以及需要警惕的信号}

### Evaluate
```bash
bash scripts/evaluate.sh --ckpt results/checkpoints/best.pth
```

**输出文件**：{包含路径、内容、格式和字段级说明的表格}

> {如何读取评估 JSON/CSV：每个字段的含义、单位、取值范围}

### Ablation Experiments
```bash
bash scripts/ablation.sh
```

输出：`results/ablation/summary.csv` — 每个变体一行，可直接用于论文表格。

### Run Baseline
```bash
bash scripts/evaluate.sh --baseline {name} --ckpt {path}
```

---

## Each File Explained

> 阅读顺序：数据加载 → 模型 → 训练循环 → 工具函数 → 脚本

### src/data/{dataset}_dataset.py

**Role**: {该文件的功能，一句话}

**Key class**: `{ClassName}(torch.utils.data.Dataset)`

**Input**: {原始数据文件路径和格式}
**Output**: `(x, y)` — x: `[seq_len, feature_dim]`, y: `[1]`

**Core logic**:
```python
def __getitem__(self, idx):
    ...  # 仅展示不显而易见的部分
```

> {对任何不显而易见的设计决策的解释}

---

### src/models/{model_name}.py

**Role**: {该文件的功能}

**Input**: `x: Tensor [{batch}, {seq_len}, {feature_dim}]`
**Output**: `pred: Tensor [{batch}, 1]`

**Structure**:
```text
Input → [Module A: role] → [Module B: role] → Output
```

**Core logic**:
```python
def forward(self, x):
    ...
```

> {对不显而易见部分的通俗解释}

---

{其余每个文件各一个小节，格式相同}

---

## Data Format（可选）

### Input Data

**Raw files**: `data/{dataset}/`

| Field | Type | Unit | Meaning | Normal range |
|-------|------|------|---------|-------------|

> {非专业人员需要了解的领域特定概念}

### Output Data

**Predictions** `results/predictions_{ts}.csv`:
```text
sample_id, true_val, pred_val, abs_error
0,         0.823,    0.817,    0.006
```

> {每列的含义以及如何发现规律}

---

## FAQ（可选——在实现过程中遇到问题时添加条目）

### Q: {问题标题}
**Cause**: {根本原因}
**Fix**: {具体步骤}

---

> 在子阶段 3a 开始时创建。随每个完成的模块同步更新。
```
