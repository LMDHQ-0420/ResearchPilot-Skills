---
name: research[G.4]-introduction
description: >
  ResearchPilot 科研助手[阶段 G.4]：撰写手稿 Introduction
version: 2.0.0
license: LICENSE
---

# 阶段 G.4：Introduction

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
research[G.4]-introduction
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


**前置条件**：G.3 Abstract 已写

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

## Introduction 章节特定要求

**写作前反向推理（来自 Master-cai introduction.md）**：
先回答这四个问题（从 idea_report.md 找答案），再动笔：
1. 我们解决的技术问题是什么？为什么没有成熟解？
2. pipeline 的贡献是什么（新任务/新指标/新技术/新设计选择）？
3. 贡献的优势是什么？为什么能解决挑战？带来了什么洞见？
4. 如何用已有方法引导读者到我们解决的挑战？

**五部分结构（来自 Master-cai introduction.md）**：
- Part 1：任务介绍 + 应用价值 + 目标指标
- Part 2：现有 SOTA 方法的失败 + 根本技术原因（对应 RQ2）
- Part 3：本文方法 + 为什么能解决挑战 + 新洞见
- Part 4：附加贡献 + 影响
- Part 5：实验摘要 + 贡献列表

**贡献列表约束**：
- 每条只陈述事实，不用"novel"/"significant"等主观词
- 每条贡献对应 Experiments 中的某个实验
- 通常 3–5 条

**范例**：`references/examples/pipeline-v1.md` 到 `pipeline-v3.md`


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
Introduction 章节写完。

→ 使用 `/research[G.5]-related` 进入 Related Works 章节。
→ 或随时使用 `/research[G.7]-review` 进行整稿审阅。
```

---

## 参考文件

- 写作规范：`references/section-guide.md`
- 通用约束：`references/common-writing-constraints.md`
- Introduction 例子（单贡献多优势）：`references/examples/pipeline-v1.md`
- Introduction 例子（双贡献）：`references/examples/pipeline-v2.md`
- Introduction 例子（在已有 pipeline 上新增模块）：`references/examples/pipeline-v3.md`
- 模板灵活性规则：`references/template-flexibility.md`
