---
name: research[G.2]-experiments
description: >
  ResearchPilot 科研助手[阶段 G.2]：撰写手稿 Experiments
version: 2.0.0
license: LICENSE
---

# 阶段 G.2：Experiments

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件。
> **dev_log.md 只追加，不删除**：每次修改论文时在文件头追加版本记录，不删除已有记录。

## 整体流程与产物

论文写作阶段，每个 skill 负责一个章节，可独立触发，支持多轮迭代。

### 论文阶段链条

| Skill | 职责 |
|-------|------|
| `/research[G.0]-plan` | 更新 idea_report → 规划结构图表 → 选格式 |
| `/research[G.1]-method` | 写 / 改 Method |
| `/research[G.2]-experiments` | 写 / 改 Experiments |
| `/research[G.3]-abstract` | 写 / 改 Abstract |
| `/research[G.4]-introduction` | 写 / 改 Introduction |
| `/research[G.5]-related` | 写 / 改 Related Works |
| `/research[G.6]-conclusion` | 写 / 改 Conclusion + References |
| `/research[G.7]-review` | 整稿审阅（五维度 + claim-evidence）|
| `/research[G.8]-translate` | 中→英翻译 |

---

## 命令

```
research[G.2]-experiments
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


**前置条件**：G.1 Method 已写

---

## 触发时必须执行的准备步骤

1. 读取手稿当前全文（避免割裂）
2. 读取参考文献（References 章节或 .bib 文件）
3. 读取手稿开头的 `=== 论文架构 ===` 注释
4. 读取 `docs/idea_report.md` 和 `docs/dev_log.md`（从中找写作内容的答案）
5. 读取写作范例分析（若 `docs/manuscripts/examples/style-notes.md` 存在）
6. 扫描全文批注，列出待处理的批注
7. 向用户确认本章节写作思路，等确认后再写

详见 `references/common-writing-constraints.md`。

---

## Experiments 章节特定要求

**三个核心问题（来自 Master-cai experiments.md）**：
1. 本文方法是否优于强 baseline？（主实验）
2. 哪些模块/设计选择带来了提升？（消融实验）
3. 方法的泛化能力/适用范围如何？（附加实验）

**数据来源**：所有定量结果必须从 `results/` 下的文件读取真实数据，禁止估计或捏造。

**表格约束**：
- 使用 booktabs 格式（`\toprule / \midrule / \bottomrule`），无竖线
- 本文方法最优值加粗，次优值加下划线
- 表注完整：表名 + 每列含义 + 说明哪些结果是复现的
- `notebooks/figures.ipynb` 中已有对应表格单元格，从中取 LaTeX 代码

**文字分析约束**：
- 必须说清本文在哪个指标超过哪个 baseline 多少（具体数字）
- 必须给出原因解释（为什么本文方法更好）
- 消融实验：每个变体说明 w/o 什么，指标如何变化，说明该组件必要性

**图表引用**：所有图表已在 `notebooks/figures.ipynb` 中生成，直接引用编号


---

## 版本管理

写之前先备份：
```bash
cp paper.md paper_{mm-dd_hh-mm}.md   # 或 .tex
```
写完后在文件头追加修改记录（详见 `references/common-writing-constraints.md`）。

---

## 参考文献维护

写作过程中发现需要引用新文献时，立即追加，格式：

**md**：
```markdown
[N] {作者}. "{标题}." *{期刊/会议}*, {年份}.
> 核心工作：{这篇论文做了什么，一句话}
> 引用原因：{在论文哪个位置引用，为什么在此处引用它}
```

**LaTeX .bib**：
```bibtex
% [核心工作] {一句话核心贡献}
% [引用原因] {章节位置}：{为什么引用}
@article{key, ...}
```

---

## 本阶段完成后

```
Experiments 章节写完。

→ 使用 `/research[G.3]-abstract` 进入 Abstract 章节。
→ 或随时使用 `/research[G.7]-review` 进行整稿审阅。
```

---

## 参考文件

- 写作规范：`references/section-guide.md`
- 通用约束：`references/common-writing-constraints.md`
- 模板灵活性规则：`references/template-flexibility.md`
