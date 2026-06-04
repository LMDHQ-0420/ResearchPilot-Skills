# Research Scout

**Claude Code 学术研究自动化 Skill**

[English](README.en.md) | 中文

---

## 概述

Research Scout 是一个 Claude Code Skill，将完整的学术研究流程自动化：从方向探索、文献检索、Idea 深化、实验设计，到代码实现。全程通过对话自然推进，Claude 在每个关键节点主动询问是否继续，无需记忆切换命令。

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
/research "测试安装"
```

若 Claude 开始询问研究方向，说明安装成功。

---

## 命令

| 命令 | 说明 |
|------|------|
| `/research "研究方向描述"` | 启动完整研究流程 |
| `/research --papers <pdf/名称/描述>` | 带参考论文启动流程 |
| `/research download-paper "描述" [--to "路径"]` | 独立下载单篇论文（随时可用，与研究流程无关）|

### 启动流程

```bash
# 从研究方向启动
/research "我想做电池 SOH 预测，现有 Transformer 方法没有利用局部时序特征"

# 带种子论文启动（可以是 PDF 文件名、arXiv ID、或论文标题描述）
/research "时序预测" --papers 2310.06625 "Informer 2021" paper.pdf

# 独立下载论文（不启动研究流程）
/research download-paper "Attention Is All You Need"
/research download-paper "2310.06625" --to "./my-papers"
```

启动后，后续所有流程通过对话推进，不需要额外命令。Claude 在每个阶段结束时询问："是否够完善了？可以进入下一阶段。"

---

## 五阶段流程

### 阶段 A：方向探索

Claude 根据输入检索文献，提出 5 个研究方向供选择。

1. 解析输入，若信息不足，一次性提问收集研究约束
2. 检索顶会/顶刊文献（目标 10+ 篇），优先 NeurIPS、ICML、ICLR、CVPR、ACL 等
3. 列出建议下载的论文清单，确认后批量下载到 `docs/papers/`
4. 给出 5 个方向，每个方向包含：核心思路、文献依据、创新角度、主要挑战、新颖性初判
5. 用户选择或提出修改意见，Claude 补充检索迭代

每轮结束后 Claude 询问："方向够完善了吗？可以进入 idea 深化阶段。"

---

### 阶段 B：Idea 深化

Claude 将选定方向构建成结构完整的 idea，生成 `idea_report.md` Part 1 和 Part 2。

- **Part 1**：Motivation（当前局限性 + 提出的解决思路）、方法发展时间线、关键论文列表
- **Part 2**：Introduction（研究背景与意义）、Related Works（含研究空白分析）、Method（方法描述 + Baseline 参考 + 评估指标）

所有引用来源通过 `web_search` 核实，无法确认的标注 `[待核实]`。有论文依据的结论用 `>>` 标注支撑文本。

每轮结束后 Claude 询问："Idea 够完善了吗？可以进入实验设计阶段。"

---

### 阶段 C：实验设计

Claude 基于领域惯例设计完整的实验方案，追加到 `idea_report.md` Part 3。

1. 询问硬件配置、时间约束、数据集偏好（写入 `user_requirements.md`）
2. 检索同领域近 3 年论文，提取常用数据集、评估指标、消融设计模式
3. **可行性核实**：
   - 数据集下载链接是否可访问
   - Baseline 代码仓库是否可访问
   - GPU 显存是否满足估算需求
4. 生成实验设计：主实验表格（方法对比）、消融实验、附加分析

不通过可行性核实的项目会标注 ⚠️ 并暂停等待用户处理。

每轮结束后 Claude 询问："实验方案够完善了吗？可以进入实现设计阶段。"

---

### 阶段 D：实现设计

Claude 生成 `implementation.md`，作为阶段 E 编码的精确指南。

**强 Baseline 路径（用户方法基于已有开源项目）：**
1. git clone 原始项目
2. 扫描现有代码结构，列出所有文件、目录用途
3. 生成改写计划：逐函数说明修改内容（原始签名 → 改写后签名 + 改写逻辑）

**从头构建路径：**
1. 收集用户的框架偏好、代码风格约束
2. 生成完整目录树，说明每个文件/目录用途
3. 逐函数规定：完整签名 + 参数类型说明 + 返回值 + 实现逻辑

两种路径都包含：结果文件格式（每个字段含义）、数据下载目录结构说明。

`implementation.md` 确认后，Claude 输出数据下载指令，等待用户完成数据准备，再进入阶段 E。

---

### 阶段 E：编码

Claude 按 `implementation.md` 的顺序逐文件实现代码，同步维护 `dev_log.md`。

实现顺序：`requirements.txt` → `configs/` → `code/README.md` → `src/` → `scripts/` → `baselines/`

每完成一个文件后：
- 在 `dev_log.md` 记录：完成的文件、关键实现决策、待测试项
- 询问用户是否继续下一个文件

`requirements.txt` 规则：只写库名，不写版本号，不含 `torch`、`torchvision`、`torchaudio`。

---

## 生成的文件

```
docs/
  idea_report.md        # 完整研究报告
                        #   Part 1：Motivation、发展时间线、关键论文
                        #   Part 2：Introduction、Related Works、Method
                        #   Part 3：数据集、主实验设计、消融实验、附加分析
  implementation.md     # 逐文件、逐函数的实现指南
  dev_log.md            # 编码进度与决策日志
  user_requirements.md  # Claude 通过对话收集的用户约束（自动维护）
  papers/               # 下载的论文 PDF（文件名 = 论文完整标题）

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

检查安装路径：
```bash
ls ~/.claude/skills/research/SKILL.md
```
若文件不存在，重新执行安装命令。重启 Claude Code 后再试。

**想修改生成的文档格式？**

直接在对话中告诉 Claude，例如"Introduction 写详细一些"、"消融实验加 learning rate 对比"。Claude 会记录到 `user_requirements.md` 并应用。

**某篇论文下载失败怎么办？**

Claude 会提示哪些论文下载失败，以及是否有摘要可用。可以手动将 PDF 放入 `docs/papers/`，文件名用论文完整标题。也可以跳过，Claude 会标注 `⚠️ [PDF 不可用]`。

**如何只下载一篇论文，不启动研究流程？**

```bash
/research download-paper "Mamba: Linear-Time Sequence Modeling with Selective State Spaces"
/research download-paper "2312.00752" --to "./papers"
```

**如何切换到英文版？**

```bash
rm -rf ~/.claude/skills/research
cp -r code/skills/research-scout-en ~/.claude/skills/research
```

---

## 许可证

MIT License — 见 [LICENSE](LICENSE)
