# Research Scout

**Claude Code 学术研究自动化 Skill**

[English](README.en.md) | 中文

---

## 概述

Research Scout 是一个 Claude Code Skill，将完整的学术研究流程自动化：从方向探索、文献检索、Idea 深化、实验设计，到实现设计和代码实现。全程通过对话自然推进，Claude 在每个关键节点主动询问是否继续，无需记忆切换命令。

---

## 安装

```bash
git clone https://github.com/YOUR_USERNAME/research-scout.git
cd research-scout

# 安装中文版
cp -r code/skills/research-scout-zh ~/.claude/skills/research
```

> 中英文版互斥，安装后触发命令均为 `/research`。切换版本时先删除 `~/.claude/skills/research`，再安装另一版本。

验证安装：

```bash
/research 测试安装
```

若 Claude 开始询问研究方向，说明安装成功。

---

## 命令

| 命令 | 说明 |
|------|------|
| `/research 研究方向描述` | 启动完整研究流程|
| `/research --papers <pdf/名称/描述>` | 带参考论文启动流程 |
| `/research download-paper 描述 [--to "路径"]` | 独立下载单篇论文（随时可用，与研究流程无关）|

### 启动示例

```bash
# 从研究方向启动
/research 我想做电池 SOH 预测，现有 Transformer 方法没有利用局部时序特征

# 带种子论文启动（可以是 PDF 文件名、arXiv ID、或论文标题）
/research 时序预测 --papers 2310.06625 "Informer 2021" paper.pdf

# 独立下载论文（不启动研究流程）
/research download-paper Attention Is All You Need
/research download-paper 2310.06625 --to ./my-papers
```

启动后，后续所有流程通过对话推进。Claude 在每个阶段结束时询问："是否够完善了？可以进入下一阶段。"

---

## 五阶段流程

### 阶段 A：方向探索

Claude 检索文献，提出 5 个研究方向供选择。

1. 解析输入，若信息不足一次性提问收集约束（方向偏好、排除方向）
2. 检索顶会/顶刊文献，目标 15 篇以上；不足时说明原因，等用户确认是否继续
3. 列出建议下载的论文清单（含每篇摘要和下载原因），确认后批量下载到 `docs/papers/`
   - 优先从 arXiv 下载；找不到时自动尝试 OpenReview；两者均失败则保存摘要 TXT
4. 提出 5 个方向，每个方向包含：核心思路、文献依据、创新角度、主要挑战、新颖性初判
5. 用户选择或提出修改意见，Claude 补充检索迭代

---

### 阶段 B：Idea 深化

Claude 将选定方向构建为结构完整的 idea，生成 `idea_report.md` Part 1 和 Part 2。

- **Part 1**：Motivation、方法发展时间线、Key Works
- **Part 2**：Introduction、Related Works（含研究空白分析）、Method
  - Method 分三层：整体框架（3.1）、通俗流程详解（3.2）、理论推导（3.3+）
- **References**：MLA 格式，Part 1+2 的引用统一汇总，每条附主要工作和引用原因

所有引用通过 `web_search` 核实，无法确认的标注 `[待核实]`。

---

### 阶段 C：实验设计

Claude 基于领域惯例设计完整实验方案，追加到 `idea_report.md` Part 3。

1. 询问 GPU 约束和训练时长上限（写入 `user_requirements.md`）
2. 检索同领域近 3 年论文，提取数据集、指标、消融设计惯例
3. **可行性核实**：数据集链接是否可访问、Baseline 代码仓库是否可访问、GPU 显存是否满足
4. 生成实验设计，顶会标准工作量：
   - 主实验：3–5 个数据集，5–8 个 baseline
   - 消融实验：系统覆盖所有创新模块，3–6 个变体
   - 附加实验：2–3 类（泛化性/效率/鲁棒性/可视化中选）
   - 所有实验报告均值±标准差，至少 3 次随机种子

每个实验说明：目的、数据集划分及理由、评估指标及含义、预期效果、参与评测的模型（含每个模型简介）。

---

### 阶段 D：实现设计

Claude 生成 `implementation.md`，作为阶段 E 编码的精确指南。每次生成或修改后自动执行校验：实验覆盖、逻辑一致性、完整性。

**强 Baseline 路径**（基于已有开源项目）：
- git clone 原始项目 → 扫描现有结构 → 生成改写方案
- 每个需修改的函数：原来做什么 → 改为做什么（文字步骤）→ 参数/返回值变化

**从头构建路径**：
- 完整目录树 + 每个文件职责
- 独立数据流章节：原始文件 → 解析 → 划分 → 标准化 → 模型输入 tensor（含 shape）
- 每个函数：签名 + 参数含义 + 返回值语义 + 实现逻辑（文字步骤）

`implementation.md` 确认后，Claude 输出数据下载指令，等待用户完成数据准备后进入阶段 E。

---

### 阶段 E：编码

Claude 按 `implementation.md` 顺序逐文件实现，同步维护 `dev_log.md`。

- 每完成一个模块后，与 implementation.md 做一次校验（签名、shape、指标一致性）
- 发现 implementation.md 有错误时：停止 → 报告问题和建议 → 等用户确认 → 先改 implementation.md → 再改代码
- `requirements.txt` 只写库名，不写版本号，不含 `torch`/`torchvision`/`torchaudio`

---

## 生成的文件

```
docs/
  idea_report.md        # 完整研究报告
                        #   Part 1：Motivation、发展时间线、Key Works
                        #   Part 2：Introduction、Related Works、Method
                        #   Part 3：数据集、实验设计（主实验/消融/附加）
                        #   References：MLA 格式，含主要工作和引用原因
  implementation.md     # 逐文件、逐函数的实现指南（含数据流、校验记录）
  dev_log.md            # 编码进度与决策日志
  user_requirements.md  # Claude 通过对话收集的约束（方向偏好、GPU 限制等）
  papers/               # 下载的论文 PDF 或摘要 TXT

code/
  README.md             # 环境安装、数据准备、运行命令
  requirements.txt
  src/                  # 核心模型与训练代码
  scripts/              # 数据处理与实验脚本
  configs/              # 超参数配置
  baselines/            # Baseline 实现
  data/                 # gitignored
  results/              # gitignored
  logs/                 # gitignored
```

---

## 常见问题

**Claude 没有触发 skill？**

```bash
ls ~/.claude/skills/research/SKILL.md
```
若文件不存在，重新执行安装命令。重启 Claude Code 后再试。

**想修改生成的文档格式？**

直接在对话中告诉 Claude，例如"Introduction 写详细一些"。Claude 会记录到 `user_requirements.md` 并应用。

**某篇论文下载失败？**

Claude 会依次尝试 arXiv → OpenReview。两者均失败时，提示原因并保存摘要 TXT（若有摘要），或在引用处标注 `⚠️ [PDF 不可用]`。也可手动将 PDF 放入 `docs/papers/`，文件名用论文完整标题。

**只想下载一篇论文，不启动研究流程？**

```bash
/research download-paper Mamba: Linear-Time Sequence Modeling with Selective State Spaces
/research download-paper 2312.00752 --to ./papers
```

**如何切换到英文版？**

```bash
rm -rf ~/.claude/skills/research
cp -r code/skills/research-scout-en ~/.claude/skills/research
```

---

## 许可证

MIT License — 见 [LICENSE](LICENSE)
