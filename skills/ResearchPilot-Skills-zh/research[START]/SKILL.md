---
name: research[START]
description: >
  检测研究项目进度，依据产物内容、验证与确认记录推荐下一阶段；用于恢复中断项目或判断从哪里继续。
version: 2.0.0
license: LICENSE
---

> 启动时读取 [阶段执行与交接约定](references/workflow-contract.md)，按其中的授权、状态、科研与复现规则执行。


> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前读取该文件（若存在），确保所有输出符合用户已确认的约束。


# ResearchPilot-Skills 入口路由

自动检测当前研究项目所处阶段，引导用户使用对应的阶段 skill。

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
  src/models/baseline/  # Baseline 模型实现（接口与主模型一致）
  notebooks/            # 可视化 notebook；论文图表生成脚本
  data/                 # 数据集（gitignored）
  results/              # 实验结果（gitignored）
  logs/                 # 训练日志（gitignored）
  README.md             # 环境配置与运行命令
  requirements.txt      # 依赖版本与来源；按项目实际方式维护锁文件
```

---

## 命令

| 命令 | 说明 |
|------|------|
| `/research[START]` | 检测当前阶段，告知用户应使用哪个 skill |
| `/research[START] 研究方向描述` | 同上，并生成带描述的阶段 A 建议命令 |
| `/research 描述` | 向后兼容，等同于 `/research[START] 描述` |

---

## 阶段检测逻辑

入口检测默认只读，不创建目录或修复状态。先读取用户的当前意图，再核对 docs/research_state.json 与实际产物；状态字段与完成条件见 [阶段执行与交接约定](references/workflow-contract.md)。

1. 状态有效时，检查产物 SHA-256、完成依据、适用确认及上游依赖；文件哈希变化时检查受影响内容，不能直接沿用 complete。
2. 状态缺失、损坏、版本不支持或冲突时，保留原文件，按下表推断候选状态并报告不确定性。不得把文件、标题或目录存在当作完成。修复或补建状态需要用户确认。
3. 当前用户意图优先于线性阶段顺序：诊断实验结果可进入 F，已有稿件可直接写作或审阅，不要求补齐全部历史阶段。

| 内容证据 | 候选阶段/动作 |
|----------|---------------|
| 没有已明确的问题或 Part 1 只有空标题 | A：探索方向与 RQ |
| Part 1 实质完成，但方法仍缺失或只有占位 | B：深化方法 |
| 方法明确，但缺少可检验的实验协议与资源方案 | C：设计实验 |
| 实验协议明确，但缺少实现接口与数据流说明 | D：实现设计 |
| 实现指南充分，代码或必要验证尚未完成 | E：编码与验证 |
| 已有结果需要诊断、修正或检验边界 | F：迭代；不以指标低自动判定方法错误 |
| 需要写作，结构尚不明确 | G.0：规划论文 |
| 已有结构与素材，需要写/改某章节 | 对应 G.1–G.6；按用户目标选择 |
| 需要核对贡献与证据，或稿件/证据在上次审阅后改变 | G.7：审阅或重验 |
| 当前版本审阅通过且无未解决高优先级问题 | 写作阶段完成；按需 G.8 翻译 |

“完成”和“推断可能完成”必须区分。审阅报告只有绑定当前手稿、引用及结果版本且高优先级问题已解决，才能作为通过依据。输出当前状态、证据、未决项和推荐命令；无法确定的关键分支集中询问，不强行前进。

---

## 输出格式

检测完成后，按下方格式告知用户：

```
━━━━━━━━━━ ResearchPilot 阶段检测 ━━━━━━━━━━
当前状态：{检测到的阶段描述，一句话}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

→ 请使用 `/{skill名称}` 继续研究。

{若携带了研究描述：建议把该描述用于阶段 A，使用 /research[A]-exploration {描述} 启动即可。}
```


---

## 独立下载命令

任何时候均可使用，不依赖阶段状态：

```
/research[A]-exploration download-paper 论文描述 [--to "路径"]
```

---
