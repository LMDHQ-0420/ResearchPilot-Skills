<div align="center">

<img src="logo.png" alt="ResearchPilot-Skills" width="600" />

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/LMDHQ-0420/ResearchPilot-Skills/releases)
[![Platform](https://img.shields.io/badge/platform-Claude%20Code%20%7C%20Codex%20%7C%20CodeBuddy-lightgrey.svg)](https://github.com/LMDHQ-0420/ResearchPilot-Skills)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

**学术研究全流程自动化 Skill**

从方向探索、文献检索、Idea 深化、实验设计、代码实现，到论文撰写。  
全程通过对话自然推进，每个关键节点主动询问确认，无需记忆切换命令。

[English](README.en.md) | 中文

</div>

---

## News

- 🎉 **[2026/07/01]** 项目正式更名为 **ResearchPilot-Skills**，同步完成六阶段拆分重构，每个阶段独立 skill，告别提示词遗忘问题。
- 📄 **[2026/06/07]** 新增论文撰写功能（阶段 F），支持版本存档、批注改稿、Python 图表生成。
- 🚀 **[2026/06/04]** 项目诞生，发布初始版本，覆盖方向探索 → 编码全流程。

---

## 概述

ResearchPilot-Skills 是一套兼容 SKILL.md 标准的学术研究 Skill，支持 **Claude Code**、**OpenAI Codex CLI**、**腾讯 CodeBuddy** 等主流 AI 编程助手。七个阶段各自独立，按需加载，上下文精准，不会因提示词过长产生遗忘。

---

## 亮点

- **逐步确认，绝不替你做决定**：研究方向和每个 RQ 都通过多轮对话逐个锁定；阶段 A/B 每次输出都带「已确认内容卡片」，当前共识一目了然，未经确认绝不跳阶段。
- **调研先于设计，方法基于证据**：先深度调研文献，每个 research gap 都要有论文段落支撑；RQ 经专项查重验证新颖性，从源头杜绝伪创新。
- **实验设计前先精读 baseline**：设计实验前，先精读被选作 baseline 的论文和 GitHub 代码，提取它们的真实实验设计，再据此对齐领域惯例——而不是凭空设计。
- **大白话讲方法**：idea 深化分三层（技术框架 → 详细 pipeline → Introduction 精修），pipeline 用「第一步…第二步…」讲清逻辑，不堆砌公式。
- **反幻觉引用核验**：每条引用都从 PDF 原文定位支撑句，无法核验的显式标注 `⚠️ [低置信度]` 并登记待核实清单，不确定性绝不掩盖。
- **有效性优先 + 实现校验**：实验设计第一目的是严格证明 idea 有效性，不为资源削减实验；实现指南自动校验实验覆盖、逻辑一致性、完整性。
- **论文撰写带版本与批注**：先确认论文结构再写初稿；正文留空白 `>` 供你逐处批注，AI 读批注改稿；每改一版独立存档（`v{大}.{小}-{简述}`），图表由 Python 脚本按论文格式生成。

> 想了解每个阶段具体做什么、如何与你交互，见 **[完整流程详解 →](WORKFLOW.md)**。

---

## 安装

先克隆仓库：

```bash
git clone https://github.com/LMDHQ-0420/ResearchPilot-Skills.git
cd ResearchPilot-Skills
```

> 每个阶段是独立的 skill，需全部安装才能使用完整流程。中英文版互斥，不要混装。

### Claude Code

```bash
cp -r skills/ResearchPilot-Skills-zh/research[START]            ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[A]-exploration    ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[B]-idea           ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[C]-experiment     ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[D]-implementation ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[E]-coding         ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[F]-iteration       ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.0]-plan           ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.1]-method          ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.2]-experiments     ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.3]-abstract        ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.4]-introduction    ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.5]-related         ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.6]-conclusion      ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.7]-review          ~/.claude/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.8]-translate       ~/.claude/skills/
```

验证：`ls ~/.claude/skills/ | grep research`（应看到 16 个目录（含 G.0–G.8））

### OpenAI Codex CLI

```bash
mkdir -p ~/.codex/skills
cp -r skills/ResearchPilot-Skills-zh/research[START]            ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[A]-exploration    ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[B]-idea           ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[C]-experiment     ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[D]-implementation ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[E]-coding         ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[F]-iteration       ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.0]-plan           ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.1]-method          ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.2]-experiments     ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.3]-abstract        ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.4]-introduction    ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.5]-related         ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.6]-conclusion      ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.7]-review          ~/.codex/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.8]-translate       ~/.codex/skills/
```

验证：`ls ~/.codex/skills/ | grep research`（应看到 16 个目录（含 G.0–G.8））

### 腾讯 CodeBuddy

CodeBuddy 的 skill 安装在 workspace 的 `.codebuddy/skills/` 目录下：

```bash
mkdir -p .codebuddy/skills
cp -r skills/ResearchPilot-Skills-zh/research[START]            .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[A]-exploration    .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[B]-idea           .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[C]-experiment     .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[D]-implementation .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[E]-coding         .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[F]-iteration       .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.0]-plan           .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.1]-method          .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.2]-experiments     .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.3]-abstract        .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.4]-introduction    .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.5]-related         .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.6]-conclusion      .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.7]-review          .codebuddy/skills/
cp -r skills/ResearchPilot-Skills-zh/research[G.8]-translate       .codebuddy/skills/
```

验证安装（任意工具）：在对话中运行 `/research[START]`，若显示阶段检测结果则安装成功。

---

## 命令

| 命令 | 说明 |
|------|------|
| `/research[START] 研究方向描述` | 检测当前阶段，自动路由到对应 skill |
| `/research[A]-exploration 研究方向描述` | 直接进入方向探索（全新项目从这里开始）|
| `/research[B]-idea` | 进入 Idea 深化 |
| `/research[C]-experiment` | 进入实验设计 |
| `/research[D]-implementation` | 进入实现设计 |
| `/research[E]-coding` | 进入编码 |
| `/research[F]-iteration` | 进入代码迭代 |
| `/research[G]-paper` | 进入论文撰写 |
| `/research[A]-exploration download-paper 描述 [--to "路径"]` | 独立下载单篇论文（随时可用）|

> `/research 描述` 是 `/research[START] 描述` 的向后兼容别名。

### 启动示例

```bash
# 全新项目，直接进入方向探索
/research[A]-exploration 我想做电池 SOH 预测，现有 Transformer 方法没有利用局部时序特征

# 不确定当前处于哪个阶段，用路由入口检测
/research[START]

# 带种子论文启动
/research[A]-exploration 时序预测 --papers 2310.06625 "Informer 2021" paper.pdf

# 独立下载论文
/research[A]-exploration download-paper Attention Is All You Need
/research[A]-exploration download-paper 2310.06625 --to ./my-papers
```

每个阶段结束时会提示下一步命令，例如：
```
阶段 A 完成。→ 请使用 `/research[B]-idea` 进入 Idea 深化阶段。
```

---

## 七阶段流程

| 阶段 | 名称 | 主要工作 | 产物 |
|------|------|---------|------|
| **A** | 方向探索与调研 | 检索文献，逐步确认研究方向和 RQ，撰写必要性论证 | `idea_report.md` Part 1 |
| **B** | Idea 深化 | 三层确认：技术框架 → 大白话 pipeline → Introduction 精修 | `idea_report.md` Part 2 |
| **C** | 实验设计 | 精读 baseline 论文与代码，归纳领域惯例，先确认实验大纲再展开完整方案并给出资源预估 | `idea_report.md` Part 3 |
| **D** | 实现设计 | 生成精确到函数的编码指南，自动校验覆盖/一致性/完整性 | `implementation.md` |
| **E** | 编码 | 按指南逐文件实现，同步维护开发日志，逐模块校验，完工后主动代码审查 | 代码 + `dev_log.md` |
| **F** | 代码迭代 | 读取实验结果诊断问题，先更新设计文档再改代码，每次改动追加日志，支持多轮迭代 | `dev_log.md` 迭代记录 |
| **G** | 论文撰写 | 先确认论文结构，生成初稿，按批注逐版改稿（每版独立存档），引导生成图表 | `docs/manuscripts/` 论文 |

阶段间均有强制人工确认节点，未经确认绝不跳到下一阶段。每个阶段具体做什么、如何与你交互，见 **[完整流程详解 →](WORKFLOW.md)**。

---

## 生成的文件

```
docs/
  idea_report.md        # 完整研究报告
                        #   Part 1：Motivation（含必要性分点）、Research Questions、Key Works
                        #   Part 2：Introduction、Related Works、Method
                        #   Part 3：数据集、实验设计（主实验/消融/附加）、资源预估
                        #   References：MLA 格式，含主要工作和引用原因
  implementation.md     # 逐文件、逐函数的实现指南（目录树+文件功能表+数据流+校验记录）
  dev_log.md            # 编码进度与决策日志
  user_requirements.md  # 通过对话收集的约束（方向偏好、RQ 约束、实现约束等）
  papers/               # 下载的论文 PDF 或摘要 TXT
  manuscripts/          # 阶段 F 论文，每改一版独立存档 v{大}.{小}-{简述}.md

code/
  README.md             # 项目内容、环境配置、详细运行命令
  requirements.txt
  src/                  # 核心模型与训练代码
  scripts/              # 数据处理与实验脚本
  configs/              # 超参数配置
  baselines/            # Baseline 实现
  notebooks/            # 关键步骤可视化；论文图表 image.ipynb / table.ipynb
  data/                 # gitignored
  results/              # gitignored
  logs/                 # gitignored
```

---

## 常见问题

**Skill 没有触发？**

检查 skill 目录是否存在，以 Claude Code 为例：
```bash
ls ~/.claude/skills/ | grep research
```
若缺少目录，重新执行安装命令，重启 AI 助手后再试。

**想修改生成的文档格式？**

直接在对话中说明，例如"Introduction 写详细一些"。AI 会记录到 `user_requirements.md` 并应用。

**某篇论文下载失败？**

依次尝试 arXiv → OpenReview。两者均失败时，保存摘要 TXT（若有）或在引用处标注 `⚠️ [PDF 不可用]`。也可手动将 PDF 放入 `docs/papers/`，文件名用论文完整标题。

**只想下载一篇论文，不启动研究流程？**

```bash
/research[A]-exploration download-paper Mamba: Linear-Time Sequence Modeling with Selective State Spaces
/research[A]-exploration download-paper 2312.00752 --to ./papers
```

**如何切换到英文版？**

先删除已安装的中文版 skill（以 Claude Code 为例）：
```bash
rm -rf ~/.claude/skills/research[START]
rm -rf ~/.claude/skills/research[A]-exploration
rm -rf ~/.claude/skills/research[B]-idea
rm -rf ~/.claude/skills/research[C]-experiment
rm -rf ~/.claude/skills/research[D]-implementation
rm -rf ~/.claude/skills/research[E]-coding
rm -rf ~/.claude/skills/research[F]-iteration
rm -rf ~/.claude/skills/research[G.0]-plan
rm -rf ~/.claude/skills/research[G.1]-method
rm -rf ~/.claude/skills/research[G.2]-experiments
rm -rf ~/.claude/skills/research[G.3]-abstract
rm -rf ~/.claude/skills/research[G.4]-introduction
rm -rf ~/.claude/skills/research[G.5]-related
rm -rf ~/.claude/skills/research[G.6]-conclusion
rm -rf ~/.claude/skills/research[G.7]-review
rm -rf ~/.claude/skills/research[G.8]-translate
```

再将上方安装命令中的 `ResearchPilot-Skills-zh` 改为 `ResearchPilot-Skills-en` 重新安装。

---

## 许可证

MIT License — 见 [LICENSE](LICENSE)
