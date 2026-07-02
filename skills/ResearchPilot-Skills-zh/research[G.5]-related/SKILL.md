---
name: research[G.5]-related
description: >
  ResearchPilot 科研助手[阶段 G.5]：撰写手稿 Related Works
version: 2.0.0
license: LICENSE
---

# 阶段 G.5：Related Works

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
research[G.5]-related
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


**前置条件**：G.4 Introduction 已写

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

## Related Works 章节特定要求

**结构（来自 Master-cai related-work.md）**：
- 2–4 个小节，每节一类相关方法
- 每节四步结构：主题句（这类方法的核心思路）→ 代表性工作（3-5 篇，附引用）→ 局限 → 过渡句
- **最后一节固定为 Research Gap**：综合各类方法的局限，指出本文填补的空白

**约束**：
- Research Gap 节的描述必须与 Introduction Part 2 完全一致，不能矛盾
- 不写流水账式 "XXX et al. propose..."，要有观点：这类方法的共同局限是什么
- 每条引用说明为什么引用它（代表哪类方法，证明哪个局限）
- 相关工作的选取从 idea_report.md Part 1 Key Works 和已有文献中找


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
Related Works 章节写完。

→ 使用 `/research[G.6]-conclusion` 进入 Conclusion 章节。
→ 或随时使用 `/research[G.7]-review` 进行整稿审阅。
```

---

## 参考文件

- 写作规范：`references/section-guide.md`
- 通用约束：`references/common-writing-constraints.md`
- 模板灵活性规则：`references/template-flexibility.md`
