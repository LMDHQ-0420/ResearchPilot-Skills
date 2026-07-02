---
name: research[G.0]-plan
description: >
  ResearchPilot 科研助手[阶段 G.0]：论文规划
version: 2.0.0
license: LICENSE
---

# 阶段 G.0：论文规划

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件。

## 整体流程与产物

ResearchPilot-Skills 将完整学术研究拆分为多个阶段，G.0 是论文写作的第一步。

### 论文阶段链条

| Skill | 职责 |
|-------|------|
| `/research[G.0]-plan` | 更新 idea_report → 规划结构图表 → 选格式 → 上传范例 → 询问语言 → 写架构注释 → 生成 notebook |
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
/research[G.0]-plan
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


---

## 流程概览

```
步骤 1：更新 idea_report.md（对比代码，列出差异，用户确认后直接修改原文件）
步骤 2：规划论文结构与图表（大纲 + 每章详细内容 + 图表规划）
步骤 3：询问写作范例（确认结构前上传，放 docs/manuscripts/examples/）
步骤 4：选择论文格式（md / LaTeX）
步骤 5：询问写作语言（中文 / 英文）
步骤 6：将详细架构注释写入手稿文件开头
步骤 7：在 notebooks/figures.ipynb 生成图表单元格
```

详细流程见 `references/phase-G0.md`。

---

## 版本管理规范

**idea_report.md**：直接在原文件修改，不保留备份。修改前在文件头追加：
```markdown
<!--
修改时间：{mm-dd_hh-mm}
修改内容：{具体改了什么}
上一状态：{修改前的主要内容概述}
-->
```

**论文手稿**（paper.md / paper.tex / paper-zh.tex 等）：修改前先复制备份，再修改原文件：
```bash
cp paper.tex paper_{mm-dd_hh-mm}.tex   # 备份
# 然后修改 paper.tex
```
备份文件放在 `docs/manuscripts/` 同目录，不清理。在原文件头追加：
```
% 修改时间：{mm-dd_hh-mm}
% 修改内容：{具体改了什么}
% 上一备份：paper_{mm-dd_hh-mm}.tex
```

---

## 硬性约束

1. 步骤严格顺序：先更新 idea_report → 再规划 → 再选格式/语言 → 再写注释 → 再生成 notebook。
2. 每个步骤必须等用户确认后再进行下一步。
3. 询问写作范例必须在确认论文结构之前完成（步骤 3 先于步骤 2 确认）。
4. 架构注释必须精确到每个小节的标题、写什么内容、每个图表的位置和说明内容。
5. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。

---

## 本阶段完成后

```
G.0 完成。
- idea_report.md 已更新
- 论文架构注释已写入手稿开头
- figures.ipynb 已建立 {N} 个图表单元格
- 格式：{md/LaTeX}，语言：{中文/英文}

建议写作顺序（Master-cai 推荐）：
Method → Experiments → Abstract → Introduction → Related Works → Conclusion

→ 使用 `/research[G.1]-method` 开始写 Method。
```

---

## 参考文件

- 详细流程：`references/phase-G0.md`
- 模板灵活性规则：`references/template-flexibility.md`
