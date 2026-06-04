---
name: research
description: >
  当用户想要开展学术研究时使用此 skill：包括从研究方向生成 idea、深化 idea、
  设计实验、或实现研究代码。触发格式：/research 后面必须紧跟研究描述文字，
  不能单独使用 /research 不带任何内容。
version: 2.0.0
license: LICENSE
---

# Research Scout（中文版）

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

## 五阶段流程

```
阶段 A：方向探索（迭代）
  描述方向 → 检索论文 → 下载 → 提出5个idea方向 → 用户选择/修改
  → 再检索 → 再下载 → 优化 → Claude询问确认 → 循环直到方向确定

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
  根据 implementation.md 编码
  同步维护 dev_log.md
```

阶段间过渡全部通过 Claude 主动询问完成，例如：
> "方向已整理完毕。你觉得这个方向够完善了吗？如果可以，我们进入 idea 深化阶段。"

---

## 目录结构

```
docs/
  idea_report.md        # 阶段B产出 Part 1+2；阶段C追加 Part 3
  implementation.md     # 阶段D产出，详细实现指南
  dev_log.md            # 阶段E编码日志
  user_requirements.md  # 由 Claude 通过对话收集，自动维护
  papers/               # 下载的论文 PDF / 摘要 TXT
code/
  README.md             # 环境安装、数据准备、运行命令（阶段E初期生成）
  src/ scripts/ configs/ baselines/
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

dev_log.md 存在
  → 阶段 E：编码进行中
```

---

## 流程详情

详细执行步骤见 `references/`：

- 阶段 A+B+C：见 `references/phase-research.md`
- 阶段 D+E：见 `references/phase-implementation.md`
- 文档格式规范：见 `references/document-formats.md`
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
6. dev_log.md 随每个完成的文件同步更新，不得批量补写。
7. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。
8. `download-paper` 命令完成后必须输出文件完整路径。
