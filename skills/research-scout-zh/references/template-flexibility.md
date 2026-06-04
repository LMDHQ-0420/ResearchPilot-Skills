# 模板灵活性规则

这些规则优先于其他参考文件中的所有具体模板指令。
在生成任何文档之前，请先阅读本文件。

## 三种章节类型

每份文档中的每个章节都属于以下三种类型之一：

| 类型 | 定义 | 处理方式 |
|------|------|---------|
| **必选（REQUIRED）** | 每个项目中都必须出现。内容可以是"N/A"，但不可省略。 | 始终生成。内容篇幅遵循研究复杂度。 |
| **可选（OPTIONAL）** | 仅对特定研究类型有意义。 | 相关时包含；不相关时省略。在文件头部注明省略原因：`> Omitted: {chapter} — {reason}` |
| **可扩展（EXTENSIBLE）** | 研究需要但模板未预定义的内容。 | 自由添加。在文件头部注明：`> Extended: {chapter}` |

## 内容篇幅

所有数量提示（"3–5句话"、"5–8篇论文"、"≤3条"）均为参考，而非硬性限制。

标准：写到完整传达信息所需的篇幅——不多也不少。

- 研究背景简单 → 1–2句话即可
- 相关工作异常丰富 → 10篇以上也可以
- 方法有6个创新组件 → 6个小节也可以

## 小节数量

小节数量跟随内容，而非模板槽位数量。

- `Proposed Method` 每个创新组件对应一个小节——方法需要几个组件就有几个小节
- code_guide.md 中的 `Each File Explained` 每个 py 文件对应一个小节——项目有几个文件就有几个小节
- dev_log.md 中的 `Dev Log Entries` 随每个完成的模块增长——没有上限

小节标题使用语义化名称，绝不使用 `{Module Name}` 或 `{Core Component}` 等占位文本。

## 各文档章节分类

### idea_report.md 第一部分

| 章节 | 类型 | 省略条件 |
|------|------|---------|
| Topic Overview | 必选 | — |
| Candidate Idea Selection | 必选 | — |
| Introduction | 必选 | — |
| Related Work | 必选 | — |
| Proposed Method | 必选 | — |
| Feasibility Assessment | 必选 | — |
| Baseline Plan | 必选 | — |
| References | 必选 | — |
| Pending Verification | 可选 | 所有引用已验证，无低置信度内容 |

### idea_report.md 第二部分

| 章节 | 类型 | 省略条件 |
|------|------|---------|
| Feasibility Verification Summary | 必选 | — |
| Experiment Overview | 必选 | — |
| Main Experiments | 必选 | — |
| Ablation Study | 必选 | — |
| Additional Analysis | 可选 | 方法不涉及可视化、效率或鲁棒性分析 |

### code_guide.md

| 章节 | 类型 | 省略条件 |
|------|------|---------|
| Project Origin | 必选 | — |
| Project Structure | 必选 | — |
| Launch Guide | 必选 | — |
| Each File Explained | 必选 | — |
| Data Format | 可选 | 纯算法工作，无自定义数据格式 |
| FAQ | 可选 | 初始为空；在实现过程中遇到问题时添加条目 |

### dev_log.md

| 章节 | 类型 | 省略条件 |
|------|------|---------|
| Project Overview | 必选 | — |
| Project Architecture | 必选 | — |
| Model Architecture | 可选 | 无自定义模型（例如纯数据流水线项目） |
| Project Logic | 必选 | — |
| Progress Table | 必选 | — |
| Dev Log Entries | 必选 | — |
| Known Issues | 可选 | 初始省略；出现问题时添加 |

## 用户文档偏好

在生成任何文档之前，务必先阅读 user_requirements.md 中的 `### Document Preferences` 字段。遵守以下偏好：

- **语言**：中文正文 + 英文标题（默认）/ 全英文 / 全中文
- **Introduction 详细程度**：占位草稿（默认）/ 可投稿的详细版本
- **Data Format 章节**：生成（默认）/ 省略
- **消融表格格式**：单表（默认）/ 按维度拆分
- **自由格式**：用户指定的任何其他结构或内容偏好
