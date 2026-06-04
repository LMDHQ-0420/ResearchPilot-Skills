# Research Scout

**Claude Code 学术研究自动化工作流**

[English](README.en.md) | 中文

---

## 概述

Research Scout 自动化从文献调研到代码实现的完整学术研究工作流。通过三个结构化阶段引导研究者，每个阶段都有人工审查节点，确保高质量输出。

**三阶段流程：**

```
阶段 1：文献调研与 Idea 生成
          ↓（用户审查并确认）
阶段 2：实验设计与可行性验证  
          ↓（用户审查并确认）
阶段 3：代码实现与结果记录
```

## 功能特性

- **4 种输入模式**：研究方向、论文 PDF、论文名称、或自由描述
- **多候选 Idea**：生成 3-5 个 idea 并进行新颖性验证与自我批判
- **引用核验**：从 PDF 中提取支撑句，防止引用幻觉
- **可行性检查**：设计前验证数据集可用性、baseline 代码、GPU 显存
- **结构化文档**：生成严格格式的 `idea_report.md`、`dev_log.md`、`code_guide.md`
- **回溯支持**：可从阶段 3 回到阶段 2 修改实验设计
- **结果追踪**：子阶段 3c 对比实际与预期结果，提供诊断建议

## 安装方法

### 克隆仓库

```bash
git clone https://github.com/YOUR_USERNAME/research-scout.git
cd research-scout
```

### 安装中文版

```bash
cp -r code/skills/research-scout-zh/* ~/.claude/skills/
```

### 验证安装

在 Claude Code 中输入：

```bash
/research "测试安装"
```

若 Claude 开始询问论文信息或提示填写 user_requirements.md，说明安装成功。

> **注意**：中英文版不能同时安装。如需切换，先删除 `~/.claude/skills/` 下现有文件，再复制新版本。

## 快速开始

### 阶段 1：文献调研与 Idea 生成

用研究方向或论文启动：

```bash
# 模式 1 — 研究方向字符串
/research "电池健康状态预测"

# 模式 2 — 附带种子论文（PDF、名称或描述）
/research "电池 SOH" --papers paper1.pdf "BattFormer 2023"

# 模式 3 — 自由描述（可附 PDF）
/research
# 然后用自然语言描述你的研究想法
```

Claude 将：
1. 推断论文元信息（若提供名称/描述）并请求确认
2. 创建 `docs/user_requirements.md` 阶段 1 章节 → 你填写 → `/research confirm`
3. 双轨检索 15+ 篇论文（用户论文 + 自主 web 搜索）
4. 生成 3-5 个候选 idea，附新颖性检查与自我批判
5. 你选择一个：`/research pick 3`
6. Claude 深化选定 idea 并生成 `docs/idea_report.md` Part I
7. 尝试下载 PDF；若失败则提示

**阶段 1 审查节点** — Claude 在此停止。审查 `docs/idea_report.md` Part I，然后：
- `/research step2` — 确认并进入阶段 2
- `/research revise "修改意见"` — 带修改重新生成 Part I

### 阶段 2：实验设计

审查阶段 1 输出后：

```bash
/research step2
```

Claude 将：
1. 检查 `docs/user_requirements.md` 阶段 2 章节（空则提示填写）
2. 读取完整 `idea_report.md` 并从文献中检索实验惯例
3. 设计完整实验方案（数据集、指标、baseline、消融）
4. **可行性验证**（写入文件前）：
   - ✅ 数据集下载链接仍有效？
   - ✅ Baseline 代码仓库可访问？
   - ✅ GPU 显存对提议配置足够？
5. 将 Part II 追加到 `idea_report.md`，包含验证摘要

**阶段 2 审查节点** — Claude 停止。审查实验设计，然后：
- `/research step3` — 确认并进入阶段 3
- `/research revise "修改意见"` — 重新生成 Part II

### 阶段 3：代码实现

审查阶段 2 输出后：

```bash
/research step3
```

Claude 将：

**子阶段 3a — 项目结构设计：**
1. 检查 `docs/user_requirements.md` 阶段 3 章节
2. 选择策略 A（基于已有项目）或策略 B（从头构建）
3. 展示结构 → `/research confirm` 继续或 `/research revise-structure "意见"`

**子阶段 3b — 代码实现：**
1. 创建 `docs/dev_log.md` 和 `docs/code_guide.md`
2. 按顺序实现：`requirements.txt` → `configs/` → `README.md` → `src/` → `scripts/` → `baselines/`
3. **每完成一个文件**：更新进度表 + 添加日志条目 + 更新 code_guide.md 对应章节
4. `requirements.txt` 规则：不含 `torch`/`torchvision`/`torchaudio`，只写库名，不写版本号

**子阶段 3c — 结果记录：**

本地运行实验后：

```bash
/research log-results
# Claude 提示粘贴实验输出
# 将实际结果填入 Part II 表格
# 与预期对比，低于目标时提供诊断
```

### 回溯到阶段 2

若阶段 3 发现实验设计问题：

```bash
/research back-to-step2 "数据集无法访问"
# 归档 dev_log.md
# 标记 Part II 状态为 REVISING
# 运行 /research revise "意见" 更新 Part II
# 然后 /research step3 重新开始编码
```

## 命令速查表

| 命令 | 阶段 | 说明 |
|------|------|------|
| `/research "topic"` | 1 入口 | 提供研究方向启动 |
| `/research --papers <文件/名称>` | 1 入口 | 提供种子论文启动 |
| `/research`（自由描述）| 1 入口 | 从用户描述中提取 |
| `/research confirm` | 1, 3 | 确认论文、PDF、或结构 |
| `/research revise-paper {n} "修正"` | 1 | 修正第 n 条论文推断 |
| `/research skip-papers` | 1 | 跳过缺失的 PDF |
| `/research pick {n}` | 1 | 选择候选 idea |
| `/research step2` | 1→2 | 进入实验设计 |
| `/research step3` | 2→3 | 进入编码 |
| `/research revise "意见"` | 1, 2 | 重新生成当前阶段文档 |
| `/research revise-structure "意见"` | 3 | 调整项目结构 |
| `/research back-to-step2 "原因"` | 3 | 回溯到阶段 2 |
| `/research log-results` | 3c | 记录实验结果 |

## 输出文件

```
docs/
  idea_report.md        # 阶段 1 Part I + 阶段 2 Part II
  dev_log.md            # 阶段 3 修改日志
  code_guide.md         # 阶段 3 实现逻辑参考
  user_requirements.md  # 各阶段用户输入（不复制进主文档）
  papers/               # 下载的 PDF（文件名 = 论文完整标题）
code/
  src/, scripts/, configs/, baselines/
  data/, results/, logs/  # gitignored
  README.md, requirements.txt
```

## 文档模板灵活性

所有文档遵循灵活模板规则：

- **必选章节**：必须出现（内容可为"不适用"）
- **可选章节**：仅在相关时包含（如纯算法工作省略数据格式章节）
- **可扩展章节**：研究需要时自由添加

内容量提示（"3-5 句"）是指导，非硬限制。

### 文档偏好设置

在 `user_requirements.md` 任意阶段章节中，可添加：

```markdown
### 文档偏好设置
- 语言：全英文 / 中文正文 + 英文章节标题（默认）/ 全中文
- Introduction 详细程度：占位草稿（默认）/ 可直接投稿的详细版本
- 数据格式章节：生成（默认）/ 省略
- 其他：{你的偏好}
```

## 常见问题

### 如何切换到英文版？

```bash
# 删除中文版
rm -rf ~/.claude/skills/*

# 安装英文版
cd research-scout
cp -r code/skills/research-scout-en/* ~/.claude/skills/
```

### Claude 没有触发 skill？

1. 检查是否正确输入命令 `/research`
2. 重启 Claude Code
3. 确认安装目录：`ls -la ~/.claude/skills/`

### 可以修改生成的文档格式吗？

可以。在 `user_requirements.md` 的"文档偏好设置"中声明，或直接修改 `~/.claude/skills/references/document-formats.md`。

### Phase 1 生成的 idea 不满意怎么办？

运行 `/research revise "更具体的方向指导"`，Claude 会重新生成候选 idea。

### 如何从失败的实验中恢复？

使用 `/research back-to-step2 "失败原因"`，修改实验设计后重新进入 Phase 3。

## 项目结构

```
code/
├── .claude-plugin/
│   └── plugin.json
├── skills/
│   ├── research-scout-zh/      # 中文版 skill（安装此目录到 ~/.claude/skills/）
│   │   ├── SKILL.md
│   │   └── references/
│   │       ├── phase1-idea-generation.md
│   │       ├── phase2-experiment-design.md
│   │       ├── phase3-implementation.md
│   │       ├── document-formats.md
│   │       ├── template-flexibility.md
│   │       └── user-requirements-template.md
│   └── research-scout-en/      # 英文版 skill（安装此目录到 ~/.claude/skills/）
│       └── ...（结构相同）
├── LICENSE
├── README.md（本文件）
└── README.en.md（English）
```

## 贡献指南

欢迎提交 Issue 和 Pull Request！

改进方向：
- 支持更多领域的论文检索源
- 增强引用核验的 PDF 解析能力
- 新增实验结果可视化模板
- 支持更多编程语言/框架

## 许可证

MIT License - 见 [LICENSE](LICENSE)

## 致谢

本项目基于 [Claude Code](https://code.claude.com) 的 skill 框架构建。
