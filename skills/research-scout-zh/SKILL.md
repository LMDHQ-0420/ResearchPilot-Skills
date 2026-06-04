---
name: research-scout-zh
description: >
  当用户想要开展学术研究时使用此 skill：包括从研究方向或论文生成 idea、设计实验、或实现研究代码。
  在以下情况触发：/research-scout-zh 后跟研究方向字符串、--papers 参数、或子命令（step2、step3、
  confirm、pick、revise、revise-paper、skip-papers、revise-structure、back-to-step2、log-results）。
  当用户说"开始科研流程"、"帮我找论文"、"生成研究 idea"、"帮我设计实验"、"根据 idea 报告写代码"，
  或用一大段中文描述研究方向（可附带 PDF）时也触发。
version: 1.0.0
license: LICENSE
---

# Research Scout（中文版）

自动化三阶段学术研究工作流。每个阶段产出结构化文档供用户审查。
Claude 必须在每个阶段结束后停止，等待用户明确确认后才能进入下一阶段。

## 阶段概览

| 阶段 | 触发命令 | 产出文件 |
|------|---------|---------|
| 1 — 文献调研与 Idea 生成 | `/research-scout-zh "topic"` 或 `--papers` | `docs/idea_report.md` Part I |
| 2 — 实验设计 | `/research-scout-zh step2` | `docs/idea_report.md` Part II（追加）|
| 3 — 代码实现 | `/research-scout-zh step3` | `docs/dev_log.md`、`docs/code_guide.md`、`code/` |

## 状态检测

每次调用开始前必须执行以下检测：

```
0. 读取 docs/user_requirements.md 对应阶段章节。
   若文件不存在或章节为空：创建文件，提示用户填写，等待 confirm。

1. docs/idea_report.md 不存在 → 执行 Phase 1
2. idea_report.md 存在，不含 "# Part II" → Phase 1 已完成
   pick {n}  → 深化选定 idea，继续 Phase 1
   step2     → 检查 Phase 2 要求，执行 Phase 2
   revise    → 重新生成 Part I
3. idea_report.md 含 "# Part II" → Phase 2 已完成
   step3     → 检查 Phase 3 要求，执行 Phase 3
   revise    → 重新生成 Part II
4. docs/dev_log.md 存在 → Phase 3 进行中
   confirm       → 继续编码或确认项目结构
   log-results   → 子阶段 3c：记录实验结果
   back-to-step2 → 回溯到实验设计阶段
```

## 命令速查

| 命令 | 适用阶段 | 说明 |
|------|---------|------|
| `/research-scout-zh "topic"` | Phase 1 入口 | 提供研究方向启动 |
| `/research-scout-zh --papers <pdf/名称/描述>` | Phase 1 入口 | 提供种子论文启动 |
| `/research-scout-zh`（自由描述 + 可附 PDF）| Phase 1 入口 | 从描述中提炼 topic 和论文 |
| `/research-scout-zh confirm` | Phase 1 / Phase 3 子步骤 | 确认论文列表、PDF 上传、或项目结构 |
| `/research-scout-zh revise-paper {n} "修正信息"` | Phase 1 子步骤 | 局部修正第 n 条论文推断信息 |
| `/research-scout-zh skip-papers` | Phase 1 子步骤 | 跳过无法下载的论文，标注 [PDF 不可用] |
| `/research-scout-zh pick {n}` | Phase 1 子步骤 | 选定第 n 个候选 idea 进入深化 |
| `/research-scout-zh step2` | Phase 1 → 2 | 确认 idea 报告，进入实验设计 |
| `/research-scout-zh step3` | Phase 2 → 3 | 确认实验设计，进入编码 |
| `/research-scout-zh revise "意见"` | Phase 1 / Phase 2 | 修改当前阶段文档并重新生成 |
| `/research-scout-zh revise-structure "意见"` | Phase 3 子步骤 | 调整项目结构后重新确认 |
| `/research-scout-zh back-to-step2 "原因"` | Phase 3 | 归档 dev_log，回溯到实验设计 |
| `/research-scout-zh log-results` | Phase 3 子阶段 3c | 记录实验实际结果并与预期对比 |

## 目录结构

```
docs/
  idea_report.md        # Phase 1 + Phase 2 共用文档
  dev_log.md            # Phase 3 修改日志
  code_guide.md         # Phase 3 实现逻辑参考文档
  user_requirements.md  # 用户各阶段输入要求（不得复制进主文档）
  papers/               # 下载的论文 PDF，文件名 = 论文完整标题
code/                   # 所有项目代码（扁平结构，不嵌套 project_name 子目录）
  src/
  scripts/
  configs/
  data/                 # 加入 .gitignore
  results/              # 加入 .gitignore
  logs/                 # 加入 .gitignore
  README.md
  requirements.txt      # 不含 torch/torchvision/torchaudio；只写库名，不写版本号
```

## 流程详情

各阶段的详细执行步骤在 `references/` 中：

- Phase 1 详细步骤：见 `references/phase1-idea-generation.md`
- Phase 2 详细步骤：见 `references/phase2-experiment-design.md`
- Phase 3 详细步骤：见 `references/phase3-implementation.md`
- 文档格式规范：见 `references/document-formats.md`
- 模板灵活性规则：见 `references/template-flexibility.md`
- user_requirements.md 模板：见 `references/user-requirements-template.md`

## 硬性约束（始终执行）

1. 未经用户确认，不得推进到下一阶段。每个阶段以停止 + 审查节点结束。
2. 不得捏造引用。所有参考文献必须经 web_search 验证。无法确认的加 `[待核实]`。
3. 不得隐藏不确定性。低置信度内容加 `⚠️ [低置信度：原因]`，并写入待核实清单。
4. requirements.txt 不得包含 torch、torchvision、torchaudio。
5. user_requirements.md 内容不得复制进主文档。主文档只体现执行结果。
6. 进度表 `✅ Done` 表示已运行验证，不是写完即标。
7. code_guide.md 和 dev_log.md 随每个完成的文件同步更新，不得批量补写。
8. 若某阶段产出已存在，先询问"已存在——是否覆盖？"再重新生成。
9. 文档默认中文正文 + 英文章节标题，除非 user_requirements 另有声明。
10. `references/template-flexibility.md` 中的模板灵活性规则优先于任何具体模板指令。
