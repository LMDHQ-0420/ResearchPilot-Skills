---
name: research[E]-coding
description: >
  ResearchPilot 科研助手[阶段 E]：编码
version: 2.0.0
license: LICENSE
---

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件，确保所有输出符合用户已确认的约束。


# 阶段 E：编码

按 `docs/implementation.md` 逐文件实现代码，同步维护开发日志，
完工后主动代码审查（可运行 + 逻辑正确）。

**前置条件**：`docs/implementation.md` 已存在，且编码前确认清单（阶段 D 末）已完成。

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
/research[E]-coding
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


---

## 阶段 E 流程概览

```
E-0 创建 README.md 与 notebooks/ 目录
E-1 创建 dev_log.md（含进度表和"运行说明"章节）
E-2 按 implementation.md 实现顺序逐文件编码
    每完成一个文件：更新 dev_log.md + 按需更新 README.md + 补 notebook
    每完成一个模块：与 implementation.md 校验一致性
E-3 requirements.txt 规则（只写库名，不写版本，不含 torch 系）
E-4 发现设计问题 → 暂停告知用户，不擅自跳过
E-5 发现 implementation.md 错误 → 先修改文档再改代码
E-6 代码完成后的必要同步（README + dev_log 运行说明章节）
E-7 全部完成后主动代码审查
E-8 实验效果不佳 → 回溯调整 idea/实验设计（B/C/D 全链路，不允许只在代码里打补丁）
```

详细执行步骤见 `references/phase-E.md`。

---

## dev_log.md 规则

- 随每个完成的文件**同步更新**，不得批量补写
- 末尾固定有"运行说明"章节，每次改代码都判断该章节是否需要同步
- `✅ Done` 只能在文件写完且运行验证无报错后标记

---

## 硬性约束

1. 不得捏造引用。
2. requirements.txt 不得包含 torch、torchvision、torchaudio。
3. dev_log.md 随每个文件同步更新，不得批量补写。
4. 发现设计行不通时，必须先与用户确认回溯范围，按 B/C/D 全链路重走对应阶段，不得只在代码里打补丁。
5. 每次改代码后自动判断 dev_log.md 末尾"运行说明"章节是否需要同步更新。
6. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。

---

## 本阶段完成后

代码审查通过后，提示用户：

```
阶段 E 完成。代码审查通过，代码可运行且逻辑与设计一致。

→ 请使用 `/research[F]-paper` 开始论文撰写。
```

---

## 参考文件

- 详细流程：`references/phase-E.md`
- 模板灵活性规则：`references/template-flexibility.md`
