---
name: research[G]-paper
description: >
  ResearchPilot 学术研究阶段 F：论文撰写。在阶段 E 编码与实验完成后使用。
  先确认论文结构，生成初稿，按用户批注逐版改稿（每版独立存档），
  引导生成图表 Python 脚本。触发格式：/research[F]-paper
version: 2.0.0
license: LICENSE
---

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件，确保所有输出符合用户已确认的约束。


# 阶段 G：论文撰写

根据前面所有产物（`idea_report.md`、`dev_log.md` 实验结果、`docs/papers/` 文献）撰写论文。
每次修改都复制为新版本文件，形成可追溯的版本链。

**前置条件**：`docs/dev_log.md` 已存在（阶段 E 已完成）。

## 整体流程与产物

ResearchPilot-Skills 将完整学术研究拆分为七个阶段，每个阶段是独立的 skill。当前 skill 是其中一环。

### 七阶段链条

| Skill | 阶段 | 主要产物 |
|-------|------|---------|
| `/research[A]-exploration` | 方向探索与调研 | `docs/idea_report.md` Part 1 |
| `/research[B]-idea` | Idea 深化 | `docs/idea_report.md` Part 2 |
| `/research[C]-experiment` | 实验设计 | `docs/idea_report.md` Part 3 |
| `/research[D]-implementation` | 实现设计 | `docs/implementation.md` |
| `/research[E]-coding` | 编码 | `code/` 代码 + `docs/dev_log.md` |
| `/research[G]-paper` | 论文撰写 | `docs/manuscripts/v*.md` |

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
/research[F]-paper
```

---

## 阶段 F 流程概览

```
F-1 确认论文结构（大纲 + 写作思路 + 图表规划 + 额外要求）
F-2 生成论文初稿（v1.0-初稿.md）
F-3 按用户批注改稿（读取空白 > 处批注，每改一版复制新文件）
F-4 引导生成 Python 图表（用户同意后生成 notebooks/image.ipynb 和 table.ipynb）
F-5 完成，汇报最终版本文件名与图表清单
```

详细执行步骤见 `references/phase-F.md`。

---

## 版本命名规则

```
docs/manuscripts/v{大}.{小}-{主要修改内容（15字以内）}.md
```

- 大版本 +1：结构性改动（增删章节、重写整章）
- 小版本 +1：局部改动（润色、补段落、修参考文献）
- 每次改稿都新建文件，旧版本保留不动

---

## 论文格式规范（中文版）

- **标题**：英文，紧跟一行中文斜体翻译
- **一级标题**：英文（Introduction / Related Works / Method / Experiments / Conclusion）
- **其余全部中文**：二级标题、正文、图注、表注
- 最多只有二级标题（不得出现 `####`）
- 每章/节开头有写作思路批注（`>` 标注）
- 每个自然段结尾、图注/表注下方留一个空白 `>` 供用户批注
- 参考文献用 MLA 格式，每条附"主要贡献"和"引用原因"说明

---

## 硬性约束

1. 必须先确认论文结构（F-1）再写初稿，不得跳过。
2. 每次改稿必须复制为新版本文件，不得覆盖旧版本。
3. Python 图表生成（image.ipynb / table.ipynb）须经用户同意后才进行。
4. 所有文献必须真实存在（经 web_search 验证或来自 `docs/papers/`），不得捏造。
5. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。

---

## 本阶段完成后

论文定稿、图表生成完毕后：

```
阶段 F 完成。论文已定稿，全流程结束。

最终版本：docs/manuscripts/{最新版本文件名}
图表文件：notebooks/image.ipynb、notebooks/table.ipynb（若已生成）
```

---

## 参考文件

- 详细流程：`references/phase-F.md`
- 模板灵活性规则：`references/template-flexibility.md`
