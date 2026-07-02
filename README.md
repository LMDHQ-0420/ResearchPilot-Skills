<div align="center">

<img src="logo.png" alt="ResearchPilot-Skills" width="600" />

[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/LMDHQ-0420/ResearchPilot-Skills/releases)
[![Platform](https://img.shields.io/badge/platform-Claude%20Code%20%7C%20Codex%20%7C%20CodeBuddy-lightgrey.svg)](https://github.com/LMDHQ-0420/ResearchPilot-Skills)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

**从研究问题到发表论文的全流程 AI 研究助手**

[English](README.en.md) | 中文

</div>

---

## News

- 📄 **[2026/07/02]** v2.0 大版本更新：新增代码迭代阶段（F）和论文写作阶段（G，G.0–G.8），论文写作基于彭思达老师学习笔记，覆盖规划、各章节撰写、整稿审阅到中英翻译全流程。
- 🎉 **[2026/07/01]** 正式更名为 **ResearchPilot-Skills**，完成多阶段独立 skill 重构，告别提示词过长导致的遗忘。
- 📝 **[2026/06/07]** 新增论文写作功能（阶段 F），支持版本存档、批注改稿、Python 图表生成。
- 🚀 **[2026/06/04]** 项目诞生，发布初始版本，覆盖方向探索至代码实现全流程。

---

## 为什么用 ResearchPilot-Skills

🔬 **端到端覆盖**：方向探索 → 文献调研 → Idea 深化 → 实验设计 → 编码 → 代码迭代 → 论文写作，一套 skill 贯穿全程，每个阶段独立加载，上下文精准。

📐 **实验设计不妥协**：实验的唯一目的是严格证明 idea 有效性。资源约束不参与设计，只在方案完成后作事后预估。

🧱 **设计文档与代码强绑定**：每次修改代码前必须先更新设计文档（`idea_report.md` / `implementation.md`），禁止只在代码里打补丁绕过设计问题，回溯全链路进行。

📝 **论文写作有据可依**：基于彭思达老师公开学习笔记，每个章节有写作框架、例子和约束。每次修改前先读全文，避免章节割裂。

---

## 七阶段流程

| 阶段 | Skill | 主要工作 | 产物 |
|------|-------|---------|------|
| **A** 方向探索 | `research[A]-exploration` | 文献检索（≥15 篇）→ 三层 RQ 确认 → 必要性论证 → 汇编 Part 1 | `idea_report.md` Part 1 |
| **B** Idea 深化 | `research[B]-idea` | 技术框架 → 大白话 pipeline → Method 撰写 → Introduction 精修 | `idea_report.md` Part 2 |
| **C** 实验设计 | `research[C]-experiment` | 精读 baseline 代码 → 归纳领域惯例 → 确认实验大纲 → 设计主/消融/附加实验 | `idea_report.md` Part 3 |
| **D** 实现设计 | `research[D]-implementation` | 生成函数级编码指南 → 三项校验（覆盖/一致性/完整性）| `implementation.md` |
| **E** 编码 | `research[E]-coding` | 逐文件实现 → 逐模块校验 → 代码审查 → 写 README → git 推送 | 代码 + `dev_log.md` |
| **F** 代码迭代 | `research[F]-iteration` | 读实验结果诊断 → 确认回溯范围 → 先改文档再改代码 → 追加迭代记录 | `dev_log.md` 迭代记录 |
| **G** 论文写作 | `research[G.0]`–`research[G.8]` | 更新 idea_report → 规划结构图表 → 按章节写作 → 整稿审阅 → 中英翻译 | `docs/manuscripts/` |

> 每个阶段结束时 AI 主动给出下一步命令，未经你确认绝不跳阶段。详细流程见 **[完整流程详解 →](WORKFLOW.md)**。

---

## Skill 列表

| Skill | 命令 | 职责 |
|-------|------|------|
| 入口路由 | `/research[START]` | 检测当前阶段，路由到对应 skill |
| 方向探索 | `/research[A]-exploration` | 文献检索、RQ 确认、Part 1 汇编 |
| Idea 深化 | `/research[B]-idea` | 技术框架、pipeline、Method 写作 |
| 实验设计 | `/research[C]-experiment` | baseline 精读、实验方案设计 |
| 实现设计 | `/research[D]-implementation` | 函数级编码指南生成与校验 |
| 编码 | `/research[E]-coding` | 逐文件实现、日志维护、git 推送 |
| 代码迭代 | `/research[F]-iteration` | 诊断→回溯→改文档→改代码→验证 |
| 论文规划 | `/research[G.0]-plan` | 更新 idea_report、规划图表、选格式 |
| Method | `/research[G.1]-method` | 写 / 改 Method 章节 |
| Experiments | `/research[G.2]-experiments` | 写 / 改 Experiments 章节 |
| Abstract | `/research[G.3]-abstract` | 写 / 改 Abstract |
| Introduction | `/research[G.4]-introduction` | 写 / 改 Introduction |
| Related Works | `/research[G.5]-related` | 写 / 改 Related Works |
| Conclusion | `/research[G.6]-conclusion` | 写 / 改 Conclusion + References |
| 整稿审阅 | `/research[G.7]-review` | 五维度审阅 + claim-evidence 对齐 |
| 中英翻译 | `/research[G.8]-translate` | 中文稿 → 英文 LaTeX（仅中文版）|
| 论文下载 | `/research[A]-exploration download-paper 描述` | 独立下载单篇论文，随时可用 |

---

## 启动示例

```bash
# 全新项目，直接从方向描述开始
/research[A]-exploration 我想做电池 SOH 预测，现有 Transformer 方法没有利用局部时序特征

# 带种子论文启动
/research[A]-exploration 时序预测 --papers 2310.06625 "Informer 2021" paper.pdf

# 不清楚当前在哪个阶段
/research[START]

# 独立下载一篇论文（不启动研究流程）
/research[A]-exploration download-paper Attention Is All You Need
/research[A]-exploration download-paper 2312.00752 --to ./my-papers
```

---

## 安装

```bash
git clone https://github.com/LMDHQ-0420/ResearchPilot-Skills.git
cd ResearchPilot-Skills

# 安装中文版
bash install-zh.sh          # Claude Code（默认）
bash install-zh.sh codex    # OpenAI Codex CLI
bash install-zh.sh codebuddy # 腾讯 CodeBuddy（在项目目录下运行）
```

验证：`ls ~/.claude/skills/ | grep research`（应看到 16 个目录）

```bash
# 卸载
bash uninstall.sh

# 切换英文版
bash uninstall.sh && bash install-en.sh
```

---

## 生成的文件

```
docs/
  idea_report.md          # 研究报告（贯穿 A/B/C 阶段）
    Part 1                #   Motivation、Research Questions（三层 RQ）、Key Works
    Part 2                #   Introduction、Related Works、Method
    Part 3                #   数据集、实验设计（主/消融/附加）、资源预估
  implementation.md       # 函数级编码指南（D 阶段）
  dev_log.md              # 开发日志，只追加不删除（E/F 阶段）
  user_requirements.md    # 用户约束，AI 通过对话自动维护
  papers/                 # 下载的论文 PDF 或摘要 TXT
  manuscripts/            # 论文手稿（G 阶段）
    paper.md / paper.tex  # 当前最新稿
    paper_{mm-dd_hh-mm}.* # 每次修改前的备份
    examples/             # 用户上传的写作范例
    templates/            # LaTeX 模版

code/
  src/
    models/               # 本文方法（一个文件一个模型）
      baseline/           # Baseline 实现（接口与主模型一致）
    data/                 # 数据处理
    train.py              # 训练入口
    evaluate.py           # 评估入口
    utils/                # 工具函数
  scripts/                # nohup shell 脚本，日志 → logs/YY-MM-DD_HH-MM-SS.log
  configs/                # 超参数 yaml
  data/                   # gitignored
  results/                # gitignored
  logs/                   # gitignored
  README.md               # 环境配置 + 运行命令
  requirements.txt        # 依赖库（不含 torch 系）
```

---

## FAQ

**Skill 没有触发？**
```bash
ls ~/.claude/skills/ | grep research
```
若目录缺失，重新执行安装脚本，重启 AI 助手后再试。

**论文下载失败？**
依次尝试 arXiv → OpenReview。两者均失败时，保存摘要 TXT，或在引用处标注 `⚠️ [PDF 不可用]`。也可手动将 PDF 放入 `docs/papers/`，文件名用论文完整标题。

**中途改了模型架构，怎么办？**
使用 `/research[F]-iteration`。诊断问题 → 确认回溯范围 → 先更新 `idea_report.md` 和 `implementation.md` → 再改代码。不允许只在代码里打补丁。

**能不能跳过某个阶段？**
每个阶段 skill 可以独立触发，但跳过前置阶段可能导致文档不完整。建议用 `/research[START]` 检测当前状态，再决定从哪里继续。

**如何写英文论文？**
安装英文版 skill（`bash install-en.sh`），在 G.0 阶段选择英文写作即可。中文版也支持直接用英文写作，或完稿后通过 `/research[G.8]-translate` 翻译为英文 LaTeX。

---

## 致谢

论文写作阶段（G.1–G.7）的写作框架、章节规范和例子主要来自以下资源：

- **彭思达（Pengsida）** — [学习笔记 Notion](https://pengsida.notion.site/c1a22465a0fa4b15a12985223916048e) | [GitHub: learning_research](https://github.com/pengsida/learning_research)
- **[Master-cai/Research-Paper-Writing-Skills](https://github.com/Master-cai/Research-Paper-Writing-Skills)** — ML/CV/NLP 论文写作 skill，改编自彭思达老师公开笔记
- **[Yuan1z0825/nature-skills](https://github.com/Yuan1z0825/nature-skills)** — Nature 系列期刊写作与科研绘图 skill，提供图表设计思路
- **[Imbad0202/academic-research-skills](https://github.com/Imbad0202/academic-research-skills)** — 学术研究全流程 skill，提供写作例子参考

---

## 许可证

MIT License — 见 [LICENSE](LICENSE)
