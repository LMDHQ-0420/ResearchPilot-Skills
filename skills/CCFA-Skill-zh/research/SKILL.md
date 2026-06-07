---
name: research
description: >
  当用户想要开展学术研究时使用此 skill：包括从研究方向生成 idea、深化 idea、
  设计实验、或实现研究代码。触发格式：/research 后面必须紧跟研究描述文字，
  不能单独使用 /research 不带任何内容。
version: 2.0.0
license: LICENSE
---

# CCFA-Skill（中文版）

自动化学术研究工作流，从方向探索到代码实现。流程通过对话自然推进，
Claude 在每个节点主动询问用户是否继续，无需记忆命令切换阶段。

---

## 命令

| 命令 | 说明 |
|------|------|
| `/research 研究方向描述` | 启动完整研究流程（描述不需要引号）|
| `/research --papers <pdf/名称/描述>` | 带参考论文启动流程 |
| `/research download-paper 描述 [--to "路径"]` | 独立下载单篇论文（与流程无关，随时可用）|

> **`/research download-paper`** 是独立命令，不依赖任何流程状态。
> 用户可在任何时候使用，指定论文描述和可选的保存路径（默认 `docs/papers/`）。
> 下载完成后 Claude 输出文件的完整路径。

---

## 六阶段流程

```
阶段 A：方向探索（迭代）
  描述方向 → 检索论文 → 下载 → 逐步确认方向与 RQ
  → Claude询问确认 → 循环直到方向确定

阶段 B：Idea 深化（迭代）
  构建 idea_report.md Part 1 + Part 2 → 检索/下载论文
  → 用户提建议 → 优化 → Claude询问确认 → 循环直到 idea 完善

阶段 C：实验设计（迭代）
  生成 idea_report.md Part 3 → 用户提建议 → 优化
  → Claude询问确认 → 循环直到实验设计完善

阶段 D：实现设计（迭代）
  生成 implementation.md（非常详细，直接指导编码）
  → 用户提建议 → 优化 → Claude询问确认 → 循环直到实现方案完善

阶段 E：编码
  根据 implementation.md 编码 → 同步维护 dev_log.md
  → 完工后主动代码审查（可运行 + 逻辑正确）

阶段 F：论文撰写（迭代）
  确认论文结构 → 生成初稿到 docs/manuscripts/ → 用户在空白 > 处批注
  → Claude读批注改稿（每改一版复制新文件 v{大}.{小}-{简述}）
  → 引导生成 Python 图/表（notebooks/image.ipynb、table.ipynb）
```

阶段间过渡全部通过 Claude 主动询问完成，例如：
> "方向已整理完毕。你觉得这个方向够完善了吗？如果可以，我们进入 idea 深化阶段。"

---

## 目录结构

```
docs/
  idea_report.md        # 阶段B产出 Part 1+2；阶段C追加 Part 3
  implementation.md     # 阶段D产出，详细实现指南
  dev_log.md            # 阶段E编码日志（条目带 YYYY-MM-DD HH:MM）；末尾固定"运行说明"章节（所有运行命令+参数含义+运行后发生什么+输出什么）
  user_requirements.md  # 由 Claude 通过对话收集，自动维护
  papers/               # 下载的论文 PDF / 摘要 TXT
  manuscripts/          # 阶段F论文，每改一版复制新文件 v{大}.{小}-{简述}.md
code/
  README.md             # 项目内容、环境配置、运行命令（阶段E初期生成）
  src/ scripts/ configs/ baselines/
  notebooks/            # 关键步骤可视化；阶段F的 image.ipynb / table.ipynb 生成论文图表
  data/ results/ logs/  # gitignored
  requirements.txt      # 只写库名，不写版本，不含 torch/torchvision/torchaudio
```

---

## 状态检测

每次调用时按以下顺序判断当前状态：

```
/research download-paper → 执行独立下载，不进入流程

/research（无内容）→ 拒绝执行，回复："请提供研究方向描述，例如：/research 我想研究电池 SOH 预测"

docs/idea_report.md 不存在
  → 阶段 A：方向探索

idea_report.md 存在，不含 "## Part 3"
  → 阶段 A/B 进行中（看 Part 2 是否存在来区分）

idea_report.md 含 "## Part 3"，docs/implementation.md 不存在
  → 阶段 C/D 之间

implementation.md 存在，docs/dev_log.md 不存在
  → 阶段 D 完成，可进入阶段 E

dev_log.md 存在，docs/manuscripts/ 不存在
  → 阶段 E：编码进行中（完成后可进入阶段 F）

docs/manuscripts/ 存在
  → 阶段 F：论文撰写进行中（取版本号最新的 md 为当前稿）
```

---

## 流程详情

详细执行步骤见 `references/`：

- 阶段 A+B+C：见 `references/phase-research.md`
- 阶段 D+E：见 `references/phase-implementation.md`
- 阶段 F（论文撰写）：见 `references/phase-paper.md`
- 文档格式规范：见 `references/document-formats.md`
- idea_report.md 空白模板：见 `references/idea_report-template.md`
- 模板灵活性规则：见 `references/template-flexibility.md`
- 用户需求收集：见 `references/user-requirements-template.md`

---

## 论文下载逻辑

论文下载使用 arXiv API，集成在流程中，也可独立触发。
完整下载逻辑见 `references/phase-research.md` 中的"论文下载"章节。

---

## 硬性约束

1. 阶段间过渡必须由 Claude 主动询问用户确认，不得自动跳过。
2. 不得捏造引用。所有参考文献必须经 web_search 验证，无法确认的加 `[待核实]`。
3. 不得隐藏不确定性。低置信度内容加 `⚠️ [低置信度：原因]`。
4. requirements.txt 不得包含 torch、torchvision、torchaudio。
5. user_requirements.md 由 Claude 通过对话收集维护，内容不复制进主文档。
6. dev_log.md 随每个完成的文件同步更新，不得批量补写；其末尾固定有"运行说明"章节，每次改代码都必须自动判断该章节是否需要同步（运行命令/参数/输出有变即更新）。
7. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。
8. `download-paper` 命令完成后必须输出文件完整路径。
9. 阶段 F 论文每次改稿必须复制为新版本文件（`v{大}.{小}-{简述}.md`），不得覆盖旧版本。
10. 论文图/表的 Python 生成（`notebooks/image.ipynb`、`table.ipynb`）须经用户同意后才进行。
11. 阶段 E 编码中或实验跑完后若需调整 idea / 实验设计，必须先与用户确认回溯范围，再按 B/C/D 全链路重走对应阶段流程更新 `idea_report.md` / `implementation.md`，不得只在代码里打补丁绕过（见 `phase-implementation.md` E-8）。
12. 每一次 idea 生成或调整前都必须大量阅读文献：优先精读 `docs/papers/` 已有论文，现有文献无法解决问题时再重新走下载流程（见 `phase-research.md`"文献阅读原则"）。
