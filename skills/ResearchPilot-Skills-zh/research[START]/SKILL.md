---
name: research[START]
description: >
  ResearchPilot 学术研究流程的入口与路由 skill。当用户输入 /research[START] 或 /research 描述方向时触发，
  检测当前项目所处阶段，引导用户使用对应的阶段 skill。不执行任何研究工作，只做阶段检测和路由。
version: 2.0.0
license: LICENSE
---

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件，确保所有输出符合用户已确认的约束。


# ResearchPilot-Skills 入口路由

自动检测当前研究项目所处阶段，引导用户使用对应的阶段 skill。

## 整体流程与产物

ResearchPilot-Skills 将完整学术研究拆分为六个阶段，每个阶段是独立的 skill。当前 skill 是其中一环。

### 六阶段链条

| Skill | 阶段 | 主要产物 |
|-------|------|---------|
| `/research[A]-exploration` | 方向探索与调研 | `docs/idea_report.md` Part 1 |
| `/research[B]-idea` | Idea 深化 | `docs/idea_report.md` Part 2 |
| `/research[C]-experiment` | 实验设计 | `docs/idea_report.md` Part 3 |
| `/research[D]-implementation` | 实现设计 | `docs/implementation.md` |
| `/research[E]-coding` | 编码 | `code/` 代码 + `docs/dev_log.md` |
| `/research[F]-paper` | 论文撰写 | `docs/manuscripts/v*.md` |

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
| `/research[START]` | 检测当前阶段，告知用户应使用哪个 skill |
| `/research[START] 研究方向描述` | 同上，并将描述传递给阶段 A |
| `/research 描述` | 向后兼容，等同于 `/research[START] 描述` |

---

## 阶段检测逻辑

按以下顺序检测 `docs/` 目录状态：

```
docs/idea_report.md 不存在
  → 尚未开始，进入阶段 A

idea_report.md 存在，不含 "## Part 2"
  → 阶段 A 进行中

idea_report.md 含 "## Part 2"，不含 "## Part 3"
  → 阶段 B 进行中

idea_report.md 含 "## Part 3"，docs/implementation.md 不存在
  → 阶段 C 完成 / 阶段 D 尚未开始

docs/implementation.md 存在，docs/dev_log.md 不存在
  → 阶段 D 完成 / 阶段 E 尚未开始

docs/dev_log.md 存在，docs/manuscripts/ 不存在
  → 阶段 E 编码进行中

docs/manuscripts/ 存在
  → 阶段 F 论文撰写进行中
```

---

## 输出格式

检测完成后，按下方格式告知用户：

```
━━━━━━━━━━ ResearchPilot 阶段检测 ━━━━━━━━━━
当前状态：{检测到的阶段描述，一句话}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

→ 请使用 `/{skill名称}` 继续研究。

{若携带了研究描述：已将描述传递给阶段 A，直接使用 /research[A]-exploration {描述} 启动即可。}
```

各阶段对应 skill：

| 阶段 | 使用 skill |
|------|-----------|
| A：方向探索（未开始或进行中） | `/research[A]-exploration 研究方向描述` |
| B：Idea 深化进行中 | `/research[B]-idea` |
| C 完成，D 未开始 | `/research[D]-implementation` |
| D 完成，E 未开始 | `/research[E]-coding` |
| E 进行中 | `/research[E]-coding` |
| F 进行中 | `/research[F]-paper` |

---

## 独立下载命令

任何时候均可使用，不依赖阶段状态：

```
/research[A]-exploration download-paper 论文描述 [--to "路径"]
```

---

## 六阶段 skill 一览

| Skill | 阶段 | 主要产物 |
|-------|------|---------|
| `/research[A]-exploration` | 方向探索与调研 | `docs/idea_report.md` Part 1 |
| `/research[B]-idea` | Idea 深化 | `idea_report.md` Part 2 |
| `/research[C]-experiment` | 实验设计 | `idea_report.md` Part 3 |
| `/research[D]-implementation` | 实现设计 | `docs/implementation.md` |
| `/research[E]-coding` | 编码 | 代码 + `docs/dev_log.md` |
| `/research[F]-paper` | 论文撰写 | `docs/manuscripts/v*.md` |
