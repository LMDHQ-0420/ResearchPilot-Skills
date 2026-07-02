---
name: research[D]-implementation
description: >
  ResearchPilot 科研助手[阶段 D]：实现设计
version: 2.0.0
license: LICENSE
---

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件，确保所有输出符合用户已确认的约束。


# 阶段 D：实现设计

生成精确到函数级别的编码指南，校验实验覆盖与逻辑一致性，
完成后生成 `docs/implementation.md`，进入阶段 E。

**前置条件**：`docs/idea_report.md` 含 Part 3（阶段 C 已完成）。

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
/research[D]-implementation
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


---

## 阶段 D 流程概览

```
D-0 询问是否使用强 Baseline（基于开源项目改进 vs 从头构建）

路径 A（强 Baseline）：
  D-A1 获取开源项目（git clone 或用户自行克隆）
  D-A2 扫描现有项目结构，提取所有类/函数/依赖
  D-A3 收集编码约束（框架、保留功能、特殊要求）
  D-A4 生成 implementation.md（强 baseline 格式）

路径 B（从头构建）：
  D-B1 收集编码约束（框架、特殊要求）
  D-B2 生成 implementation.md（从头构建格式）

D-末1 执行 implementation.md 校验（实验覆盖/逻辑一致性/完整性）
D-末2 编码前确认清单（环境/设备/数据集/运行策略/README 位置）
```

详细执行步骤见 `references/phase-D.md`。

---

## implementation.md 校验规则

每次生成或修改后，必须执行三项校验：

1. **实验要求覆盖**：Part 3 每个实验是否有对应模块/函数支撑
2. **逻辑一致性**：tensor shape 在各模块间是否一致
3. **完整性**：每个列出的文件是否有对应实现章节

校验结果格式：
```
✅ 实验要求覆盖：{通过 / 缺少：…}
✅ 逻辑一致性：{通过 / 发现问题：…}
✅ 完整性：{通过 / 缺少：…}
```

---

## 硬性约束

1. 阶段 D 未经用户确认，不得自动进入阶段 E。
2. implementation.md 生成后必须立即执行校验，有问题先修复再提交给用户确认。
3. requirements.txt 不得包含 torch、torchvision、torchaudio。
4. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。
5. 编码前确认清单（D-末2）必须在开始编码前逐项与用户确认。

---

## 本阶段完成后

implementation.md 和编码前确认清单均确认后，提示用户：

```
阶段 D 完成。implementation.md 已生成并通过校验，编码前确认清单已确认。

implementation.md 和编码前确认清单均确认后，提示用户：

```
阶段 D 完成。implementation.md 已生成并通过校验。

→ 请使用 `/research[E]-coding` 开始编码。
```
```

---

## 参考文件

- 详细流程：`references/phase-D.md`
- 文档格式规范：`references/document-formats.md`
- 模板灵活性规则：`references/template-flexibility.md`
