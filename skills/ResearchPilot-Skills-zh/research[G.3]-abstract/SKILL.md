---
name: research[G.3]-abstract
description: >
  ResearchPilot 科研助手[阶段 G.3]：撰写手稿 Abstract
version: 2.0.0
license: LICENSE
---

# 阶段 G.3：Abstract

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件。
> **dev_log.md 只追加，不删除**：每次修改论文时在文件头追加版本记录，不删除已有记录。

## 整体流程与产物

论文写作阶段，每个 skill 负责一个章节，可独立触发，支持多轮迭代。

### 论文阶段链条

| Skill | 职责 |
|-------|------|
| `/research[G.0]-plan` | 更新 idea_report → 规划结构图表 → 选格式 |
| `/research[G.1]-method` | 写 / 改 Method |
| `/research[G.2]-experiments` | 写 / 改 Experiments |
| `/research[G.3]-abstract` | 写 / 改 Abstract |
| `/research[G.4]-introduction` | 写 / 改 Introduction |
| `/research[G.5]-related` | 写 / 改 Related Works |
| `/research[G.6]-conclusion` | 写 / 改 Conclusion + References |
| `/research[G.7]-review` | 整稿审阅（五维度 + claim-evidence）|
| `/research[G.8]-translate` | 中→英翻译 |

---

## 命令

```
research[G.3]-abstract
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


**前置条件**：G.1 Method 和 G.2 Experiments 已写

---

## 触发时必须执行的准备步骤

1. 读取手稿当前全文（避免割裂）
2. 读取参考文献（References 章节或 .bib 文件）
3. 读取手稿开头的 `=== 论文架构 ===` 注释
4. 读取 `docs/idea_report.md` 和 `docs/dev_log.md`（从中找写作内容的答案）
5. 读取写作范例分析（若 `docs/manuscripts/examples/style-notes.md` 存在）
6. 扫描全文批注，列出待处理的批注
7. 向用户确认本章节写作思路，等确认后再写

详见 `references/common-writing-constraints.md`。

---

## Abstract 章节特定要求

**写作前四问（来自 Master-cai abstract.md）**：
1. 我们解决的技术问题是什么？为什么没有成熟解？
2. 我们的技术贡献是什么？
3. 为什么我们的方法在本质上能奏效？
4. 我们提供了什么技术优势和新洞见？

先从 idea_report.md 和 dev_log.md 找答案，再写 Abstract。

**三种模板（选一种）**：
- Version 1：Challenge→Contribution（任务→挑战→贡献→优势→实验）
- Version 2：Challenge→Insight→Contribution（任务→挑战→洞见→贡献→优势→实验）
- Version 3：多贡献（任务→贡献1+优势→贡献2+优势→实验）

详细模板见 `references/examples/template-a.md` / `template-b.md` / `template-c.md`

**约束**：
- 篇幅：会议 150–250 词，期刊 250–350 词
- Result 句必须包含具体数字，从 `dev_log.md` 或 `results/` 取
- 不引用文献
- 写完执行 claim-evidence 对齐：Abstract 中每个 claim 必须在 Experiments 中有对应支撑


---

## 版本管理

写之前先备份：
```bash
cp paper.md paper_{mm-dd_hh-mm}.md   # 或 .tex
```
写完后在文件头追加修改记录（详见 `references/common-writing-constraints.md`）。

---

## 参考文献维护

写作过程中发现需要引用新文献时，立即追加，格式：

**md**：
```markdown
[N] {作者}. "{标题}." *{期刊/会议}*, {年份}.
> 核心工作：{这篇论文做了什么，一句话}
> 引用原因：{在论文哪个位置引用，为什么在此处引用它}
```

**LaTeX .bib**：
```bibtex
% [核心工作] {一句话核心贡献}
% [引用原因] {章节位置}：{为什么引用}
@article{key, ...}
```

---

## 本阶段完成后

```
Abstract 章节写完。

→ 使用 `/research[G.4]-introduction` 进入 Introduction 章节。
→ 或随时使用 `/research[G.7]-review` 进行整稿审阅。
```

---

## 参考文件

- 写作规范：`references/section-guide.md`
- 通用约束：`references/common-writing-constraints.md`
- 模板 A（Challenge→Contribution）：`references/examples/template-a.md`
- 模板 B（Challenge→Insight→Contribution）：`references/examples/template-b.md`
- 模板 C（多贡献）：`references/examples/template-c.md`
- 模板灵活性规则：`references/template-flexibility.md`
