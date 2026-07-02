---
name: research[A]-exploration
description: >
  ResearchPilot 科研助手[阶段 A]：方向探索
version: 2.0.0
license: LICENSE
---

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件，确保所有输出符合用户已确认的约束。


# 阶段 A：方向探索与调研

从模糊的研究兴趣，通过充分的多轮交互，收敛成一个客观成立的研究方向和一组明确的研究问题（RQ）。
完成后生成 `docs/idea_report.md` Part 1，进入阶段 B。

## 整体流程与产物

ResearchPilot-Skills 将完整学术研究拆分为七个阶段，每个阶段是独立的 skill。当前 skill 是其中一环。

### 七阶段链条

| Skill | 阶段 | 主要产物 |
|-------|------|---------|
| `/research[A]-exploration` | 方向探索与调研 | `docs/idea_report.md` Part 1 |
| `/research[B]-idea` | Idea 深化 | `docs/idea_report.md` Part 2 |
| `/research[C]-experiment` | 实验设计 | `docs/idea_report.md` Part 3 |
| `/research[D]-implementation` | 实现设计 | `docs/implementation.md` |
| `/research[E]-coding` | 编码 | `code/` + `docs/dev_log.md` |
| `/research[F]-iteration` | 代码迭代 | `dev_log.md` 迭代记录 |
| `/research[G.0]-plan` | 论文规划 | 手稿架构注释 + `notebooks/figures.ipynb` |
| `/research[G.1]-method` | Method | 手稿 Method 章节 |
| `/research[G.2]-experiments` | Experiments | 手稿 Experiments 章节 |
| `/research[G.3]-abstract` | Abstract | 手稿 Abstract |
| `/research[G.4]-introduction` | Introduction | 手稿 Introduction |
| `/research[G.5]-related` | Related Works | 手稿 Related Works |
| `/research[G.6]-conclusion` | Conclusion + References | 手稿 Conclusion |
| `/research[G.7]-review` | 整稿审阅 | 审阅报告 |
| `/research[G.8]-translate` | 中→英翻译（仅中文版）| `paper-en.tex` |

### 项目目录结构

```
docs/
  idea_report.md        # 研究报告，分三部分：
                        #   Part 1：研究动机、研究问题（RQ）、关键文献（阶段 A 产出）
                        #   Part 2：Introduction、Related Works、Method（阶段 B 产出）
                        #   Part 3：数据集、实验设计、资源预估（阶段 C 产出）
  implementation.md     # 编码指南：精确到每个文件/函数的实现说明（阶段 D 产出）
  dev_log.md            # 开发日志：进度、决策记录、运行说明（阶段 E 维护）
  user_requirements.md  # 用户约束：由 Claude 通过对话收集，自动维护
  papers/               # 下载的论文 PDF 或摘要 TXT
  manuscripts/          # 论文稿件，每版独立存档（v1.0-初稿.md、v1.1-修订.md 等）

code/
  src/                  # 核心模型与训练代码
  scripts/              # 运行脚本（train.sh、evaluate.sh、ablation.sh）
  configs/              # 超参数配置文件
  baselines/            # Baseline 模型实现
  notebooks/            # 可视化 notebook；论文图表生成脚本
  data/                 # 数据集（gitignored）
  results/              # 实验结果（gitignored）
  logs/                 # 训练日志（gitignored）
  README.md             # 环境配置与运行命令
  requirements.txt      # 依赖库（只写库名，不含 torch 系）
```

---

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
A-2 初步文献检索（≥15 篇，每个 gap ≥2 篇支撑，最多 3 轮补充）
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

本阶段每次输出开头都带已确认内容卡片（有已确认内容时显示）：

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

1. 阶段 A 未经用户确认，不得自动进入阶段 B。
2. 不得捏造引用。所有参考文献必须经 web_search 验证，无法确认的加 `[待核实]`。
3. 不得隐藏不确定性。低置信度内容加 `⚠️ [低置信度：原因]`。
4. `download-paper` 命令完成后必须输出文件完整路径。
5. `user_requirements.md` 由 Claude 通过对话收集维护，不由用户直接编辑。
6. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。
7. 每一次 idea 生成或调整前都必须大量阅读文献（见 `references/phase-A.md` 文献阅读原则）。

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
