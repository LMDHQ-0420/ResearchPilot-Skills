---
name: research[G.1]-method
description: >
  ResearchPilot 科研助手[阶段 G.1]：撰写手稿 Method
version: 2.0.0
license: LICENSE
---

# 阶段 G.1：Method

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
research[G.1]-method
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


**前置条件**：G.0 规划完成，手稿架构注释已写入

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

## Method 章节特定要求

**写作前三问（每个模块都要回答）**：
1. 这个模块如何运作？（从代码中读取实现）
2. 为什么需要这个模块？（对应 RQ2 的某个瓶颈，从 idea_report 中找）
3. 为什么这个模块有效？（理论直觉或先验证据）

**三要素顺序（来自 Master-cai method.md）**：
每个模块小节按以下顺序写：
1. **模块设计**：这个模块如何运作，给出公式
2. **设计动机**：为什么需要这个模块，对应哪个研究问题
3. **技术优势**：为什么这个模块有效，与其他设计的对比

**公式约束**：
- 每个公式后必须解释所有变量的含义
- md：公式后用 `>` 批注解释变量
- LaTeX：公式后用 `%批注：` 或内联注释说明变量

**写作顺序**：先写 Overview，再写各模块，最后写训练目标

**例子参考**：`references/examples/example-of-the-three-elements.md`（Neural Body 三要素完整例子）


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
Method 章节写完。

→ 使用 `/research[G.2]-experiments` 进入 Experiments 章节。
→ 或随时使用 `/research[G.7]-review` 进行整稿审阅。
```

---

## 参考文件

- 写作规范：`references/section-guide.md`
- 通用约束：`references/common-writing-constraints.md`
- 三要素例子：`references/examples/example-of-the-three-elements.md`
- 模块设计模式：`references/examples/module-motivation-patterns.md`
- 章节骨架：`references/examples/section-skeleton.md`
- 模板灵活性规则：`references/template-flexibility.md`
