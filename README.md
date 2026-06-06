# Research Scout

**Claude Code 学术研究自动化 Skill**

[English](README.en.md) | 中文

---

## 概述

Research Scout 是一个 Claude Code Skill，将完整的学术研究流程自动化：从方向探索、文献检索、Idea 深化、实验设计，到实现设计和代码实现。全程通过对话自然推进，Claude 在每个关键节点主动询问是否继续，无需记忆切换命令。

---

## 亮点

- **逐步确认，绝不替你做决定**：研究方向和每个 RQ 都通过多轮对话逐个锁定；阶段 A/B 每次输出都带「已确认内容卡片」，当前共识一目了然，未经确认绝不跳阶段。
- **调研先于设计，方法基于证据**：先深度调研文献，每个 research gap 都要有论文段落支撑；RQ 经专项查重验证新颖性，从源头杜绝伪创新。
- **实验设计前先精读 baseline**：设计实验前，Claude 先精读被选作 baseline 的论文和 GitHub 代码，提取它们的真实实验设计，再据此对齐领域惯例——而不是凭空设计。
- **大白话讲方法**：idea 深化分三层（技术框架 → 详细 pipeline → Introduction 精修），pipeline 用「第一步…第二步…」讲清逻辑，不堆砌公式。
- **反幻觉引用核验**：每条引用都从 PDF 原文定位支撑句，无法核验的显式标注 `⚠️ [低置信度]` 并登记待核实清单，不确定性绝不掩盖。
- **可行性闭环 + 实现校验**：实验设计前核实数据集/代码/显存可行性；实现指南自动校验实验覆盖、逻辑一致性、完整性，避免「看起来完整但跑不起来」。

> 想了解每个阶段 Claude 具体做什么、如何与你交互，见 **[完整流程详解 →](WORKFLOW.md)**。

---

## 安装

```bash
git clone https://github.com/YOUR_USERNAME/research-scout.git
cd research-scout

# 安装中文版
cp -r skills/research-scout-zh ~/.claude/skills/
```

> 中英文版互斥，安装后触发命令均为 `/research`。切换版本时先删除 `~/.claude/skills/research`，再安装另一版本。

验证安装：

```bash
/research 测试安装
```

若 Claude 开始询问研究方向，说明安装成功。

---

## 命令

| 命令 | 说明 |
|------|------|
| `/research 研究方向描述` | 启动完整研究流程|
| `/research --papers <pdf/名称/描述>` | 带参考论文启动流程 |
| `/research download-paper 描述 [--to "路径"]` | 独立下载单篇论文（随时可用，与研究流程无关）|

### 启动示例

```bash
# 从研究方向启动
/research 我想做电池 SOH 预测，现有 Transformer 方法没有利用局部时序特征

# 带种子论文启动（可以是 PDF 文件名、arXiv ID、或论文标题）
/research 时序预测 --papers 2310.06625 "Informer 2021" paper.pdf

# 独立下载论文（不启动研究流程）
/research download-paper Attention Is All You Need
/research download-paper 2310.06625 --to ./my-papers
```

启动后，后续所有流程通过对话推进。Claude 在每个阶段结束时询问："是否够完善了？可以进入下一阶段。"

---

## 五阶段流程

| 阶段 | 名称 | Claude 主要做什么 | 产物 |
|------|------|-----------------|------|
| **A** | 方向探索与调研 | 检索文献，逐步确认研究方向和 RQ，撰写必要性论证 | `idea_report.md` Part 1 |
| **B** | Idea 深化 | 三层确认：技术框架 → 大白话 pipeline → Introduction 精修 | `idea_report.md` Part 2 |
| **C** | 实验设计 | 精读 baseline 论文与代码，归纳领域惯例，设计完整实验方案 | `idea_report.md` Part 3 |
| **D** | 实现设计 | 生成精确到函数的编码指南，自动校验覆盖/一致性/完整性 | `implementation.md` |
| **E** | 编码 | 按指南逐文件实现，同步维护开发日志，逐模块校验 | 代码 + `dev_log.md` |

阶段间均有强制人工确认节点，未经你确认绝不跳到下一阶段。每个阶段 Claude 具体做什么、如何与你交互，见 **[完整流程详解 →](WORKFLOW.md)**。

---

## 生成的文件

```
docs/
  idea_report.md        # 完整研究报告
                        #   Part 1：Motivation（含必要性分点）、Research Questions、Key Works（汇总表+详细条目）
                        #   Part 2：Introduction、Related Works、Method
                        #   Part 3：数据集、实验设计（主实验/消融/附加）
                        #   References：MLA 格式，含主要工作和引用原因
  implementation.md     # 逐文件、逐函数的实现指南（含数据流、校验记录）
  dev_log.md            # 编码进度与决策日志
  user_requirements.md  # Claude 通过对话收集的约束（方向偏好、GPU 限制等）
  papers/               # 下载的论文 PDF 或摘要 TXT

code/
  README.md             # 环境安装、数据准备、运行命令
  requirements.txt
  src/                  # 核心模型与训练代码
  scripts/              # 数据处理与实验脚本
  configs/              # 超参数配置
  baselines/            # Baseline 实现
  data/                 # gitignored
  results/              # gitignored
  logs/                 # gitignored
```

---

## 常见问题

**Claude 没有触发 skill？**

```bash
ls ~/.claude/skills/research/SKILL.md
```
若文件不存在，重新执行安装命令。重启 Claude Code 后再试。

**想修改生成的文档格式？**

直接在对话中告诉 Claude，例如"Introduction 写详细一些"。Claude 会记录到 `user_requirements.md` 并应用。

**某篇论文下载失败？**

Claude 会依次尝试 arXiv → OpenReview。两者均失败时，提示原因并保存摘要 TXT（若有摘要），或在引用处标注 `⚠️ [PDF 不可用]`。也可手动将 PDF 放入 `docs/papers/`，文件名用论文完整标题。

**只想下载一篇论文，不启动研究流程？**

```bash
/research download-paper Mamba: Linear-Time Sequence Modeling with Selective State Spaces
/research download-paper 2312.00752 --to ./papers
```

**如何切换到英文版？**

```bash
rm -rf ~/.claude/skills/research
cp -r code/skills/research-scout-en ~/.claude/skills/
```

---

## 许可证

MIT License — 见 [LICENSE](LICENSE)
