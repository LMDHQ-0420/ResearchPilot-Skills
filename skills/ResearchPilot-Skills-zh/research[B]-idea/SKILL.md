---
name: research[B]-idea
description: >
  将研究问题深化为技术方案，解释 pipeline、设计依据与可检验假设，生成或修改研究报告 Part 2。
version: 2.0.0
license: LICENSE
---

> 启动时读取 [阶段执行与交接约定](references/workflow-contract.md)，按其中的授权、状态、科研与复现规则执行。


> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前读取该文件（若存在），确保所有输出符合用户已确认的约束。


# 阶段 B：Idea 深化

在已确认的研究方向和 RQ 基础上，把"研究问题"深化为"可实现的方法"。
分三层逐步确认，完成后生成 `docs/idea_report.md` Part 2，进入阶段 C。

**前置条件**：`docs/idea_report.md` 已存在且含 Part 1（阶段 A 已完成）。

## 命令

```
/research[B]-idea
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


---

## 阶段 B 流程概览

```
B-0 汇编 Part 1（从阶段 A 已确认内容直接汇编，不重新生成）
B-1 确认技术框架（第一层）
B-2 确认详细 pipeline（第二层，大白话逐步讲清）
    → 落笔 Part 2：Related Works + Method
B-3 引用内容核验（逐条从 PDF 定位支撑句）
B-4 Introduction 精修（第三层）
B-5 询问用户是否进入阶段 C
```

详细执行步骤见 `references/phase-B.md`。

---

## 确认卡片

新增确认、恢复会话或阶段交接时显示简洁的已确认内容卡片：

```
━━━━━━━━━━ 已确认内容 ━━━━━━━━━━
研究方向：{已确认}
主 RQ：{已确认}
次 RQ：{已确认}
方向约束：{用户约束}
RQ 约束：{用户约束}
参考论文：{用户指定}
技术框架：{已确认技术框架，一句话}
Pipeline：{已确认 pipeline，一句话}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

仅输出已确认且非空的字段，未确认或空字段整行省略。

---

## 硬性约束

1. 未经用户明确确认 `idea_report.md` Part 2 内容，不得启动阶段 C 流程。
2. 不得捏造引用。无法核验的加 `⚠️ [低置信度：原因]` 并登记待核实清单。
3. idea 决策前读取相关原始文献，复用已有阅读记录，关键证据不足时补充（详见 `references/phase-B.md` 文献阅读原则）。
4. pipeline 输出必须用大白话"第一步…第二步…"形式，每步说明输入是什么、做什么处理、输出是什么；禁止出现公式、张量维度描述或伪代码。
5. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。

---

## 本阶段完成后

Part 2 全部确认后，提示用户：

```
阶段 B 完成。idea_report.md Part 2 已生成。

→ 请使用 `/research[C]-experiment` 进入实验设计阶段。
```

---

## 参考文件

- 详细流程：`references/phase-B.md`
- 文档格式规范：`references/document-formats.md`
- 模板灵活性规则：`references/template-flexibility.md`
