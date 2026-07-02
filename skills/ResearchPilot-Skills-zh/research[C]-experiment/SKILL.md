---
name: research[C]-experiment
description: >
  ResearchPilot 科研助手[阶段 C]：实验设计
version: 2.0.0
license: LICENSE
---

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件，确保所有输出符合用户已确认的约束。


# 阶段 C：实验设计

精读 baseline 论文与代码，归纳领域实验惯例，设计主实验/消融/附加实验，
完成后追加 `docs/idea_report.md` Part 3，进入阶段 D。

**前置条件**：`docs/idea_report.md` 含 Part 2（阶段 B 已完成）。

**实验设计原则**：所有实验设计的第一目的是严格证明 idea 的有效性，
不为迁就资源而削减实验。资源在设计完成后仅作预估，不构成约束。

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

```
/research[C]-experiment
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


---

## 阶段 C 流程概览

```
C-1 Baseline 文献与代码精读（展示精读计划，用户确认后执行）
C-2 检索领域实验惯例（近 3 年同领域论文）
C-3 数据与代码可获取性核实
C-4 提出实验大纲，与用户确认（先出骨架，再展开细节）
C-5 生成 idea_report.md Part 3 完整内容
C-6 给出资源预估（仅供参考，置于 Part 3 末尾）
C-7 询问用户是否进入阶段 D
C-8 迭代优化（循环直到用户确认）
```

详细执行步骤见 `references/phase-C.md`。

---

## 硬性约束

1. 阶段 C 未经用户确认，不得自动进入阶段 D。
2. 必须先出实验大纲（C-4）并经用户确认，再展开撰写 Part 3 完整内容。
3. 不得在设计前收集 GPU/训练时长等资源约束，资源仅作事后预估。
4. 参与评测的每个模型必须逐个说明：与本文方法的区别、纳入意义、出处论文。
5. 不得捏造引用。无法核验的加 `⚠️ [低置信度：原因]`。
6. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。

---

## 本阶段完成后

Part 3 确认后，提示用户：

```
阶段 C 完成。idea_report.md Part 3 已生成。

Part 3 确认后，提示用户：

```
阶段 C 完成。idea_report.md Part 3 已生成。

→ 请使用 `/research[D]-implementation` 进入实现设计阶段。
```
```

---

## 参考文件

- 详细流程：`references/phase-C.md`
- 文档格式规范：`references/document-formats.md`
- 模板灵活性规则：`references/template-flexibility.md`
