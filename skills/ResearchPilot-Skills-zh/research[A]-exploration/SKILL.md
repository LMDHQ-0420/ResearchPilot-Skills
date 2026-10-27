---
name: research[A]-exploration
description: >
  探索研究方向，检索并核实文献，收敛可研究的问题与 RQ，生成研究报告 Part 1；也支持独立下载论文。
version: 2.0.0
license: LICENSE
---

> 启动时读取 [阶段执行与交接约定](references/workflow-contract.md)，按其中的授权、状态、科研与复现规则执行。


> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前读取该文件（若存在），确保所有输出符合用户已确认的约束。


# 阶段 A：方向探索与调研

从模糊的研究兴趣，通过充分的多轮交互，收敛成一个客观成立的研究方向和一组明确的研究问题（RQ）。
完成后生成 `docs/idea_report.md` Part 1，进入阶段 B。

## 命令

| 命令 | 说明 |
|------|------|
| `/research[A]-exploration 研究方向描述` | 启动方向探索流程 |
| `/research[A]-exploration --papers <pdf/名称/描述>` | 带参考论文启动 |
| `/research[A]-exploration download-paper 描述 [--to "路径"]` | 独立下载单篇论文（随时可用，不依赖流程状态） |

---

## 触发判断

```
/research[A]-exploration download-paper → 执行独立下载，不进入流程

/research[A]-exploration（无内容）→ 拒绝，回复：
  "请告诉我你想研究的方向，例如：
   /research[A]-exploration 我想做电池 SOH 预测，现有 Transformer 方法没有利用局部特征"

其他情况 → 进入方向探索流程
```

---

## 阶段 A 流程概览

```
A-1 解析输入，收集需求（写入 user_requirements.md）
A-2 按问题范围检索文献，检查每个 gap 的支持与反对证据，覆盖充分后停止
A-3 向用户确认下载清单
A-4 执行下载，反馈结果
A-4.5 询问是否需要逐篇详细介绍论文
A-5 锚定问题域，逐个确认研究方向（先三维汇报，再 1-2 个候选深入讨论）
A-6 逐个提炼并确认 RQ（主 RQ + 次 RQ）
A-7 汇编 idea_report.md Part 1
```

详细执行步骤见 `references/phase-A.md`。

---

## 确认卡片

本阶段在新增确认、恢复会话或阶段交接时显示简洁的已确认内容卡片：

```
━━━━━━━━━━ 已确认内容 ━━━━━━━━━━
研究方向：{已确认的研究方向}
主 RQ：{已确认的主 RQ}
次 RQ：{已确认的次 RQ}
方向约束：{用户约束}
RQ 约束：{用户约束}
参考论文：{用户指定论文}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

仅输出已确认且非空的字段，未确认或空字段整行省略。

---

## 论文下载

完整下载逻辑（arXiv → OpenReview → 摘要 TXT 降级）见 `references/phase-A.md` 论文下载章节。

---

## 硬性约束

1. 未经用户明确确认 `idea_report.md` Part 1 内容，不得启动阶段 B 流程。
2. 不得捏造引用。所有参考文献必须经 web_search 验证，无法确认的加 `[待核实]`。
3. 不得隐藏不确定性。低置信度内容加 `⚠️ [低置信度：原因]`。
4. `download-paper` 命令完成后必须输出文件完整路径。
5. `user_requirements.md` 记录已确认用户约束；尊重用户直接编辑，冲突时以当前明确指令为准。
6. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。
7. idea 生成或调整前读取与当前决策直接相关的原始文献；已有阅读记录可复用，关键证据不足才补充，不强制每次重读固定篇数。

---

## 本阶段完成后

Part 1 汇编确认后，提示用户：

```
阶段 A 完成。idea_report.md Part 1 已生成。

→ 请使用 `/research[B]-idea` 进入 Idea 深化阶段。
```

---

## 参考文件

- 详细流程：`references/phase-A.md`
- 文档格式规范：`references/document-formats.md`
- idea_report.md 空白模板：`references/idea_report-template.md`
- 模板灵活性规则：`references/template-flexibility.md`
- 用户需求收集：`references/user-requirements-template.md`
