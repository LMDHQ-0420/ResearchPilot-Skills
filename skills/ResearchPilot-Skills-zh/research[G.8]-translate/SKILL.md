---
name: research[G.8]-translate
description: >
  ResearchPilot 科研助手[阶段 G.8]：中英翻译（仅中文版）
version: 2.0.0
license: LICENSE
---

# 阶段 G.8：中→英翻译

> **仅中文版 skill 包含本阶段。英文版 skill 无此阶段。**

## 命令

```
/research[G.8]-translate
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


**前置条件**：G.7 审阅通过，中文手稿基本定稿。

---

## 流程

### 步骤 1：确认是否需要英文版本

```
当前论文为中文稿，是否需要生成英文 LaTeX 版本？

→ 需要：继续步骤 2
→ 不需要：G 阶段完成
```

### 步骤 2：选择 LaTeX 模版

```
请选择英文版 LaTeX 模版：

① 使用 G.0 中已有的模版（docs/manuscripts/templates/ 下现有文件）
   请告知模版文件名

② 上传新模版
   请将模版文件放入 docs/manuscripts/templates/ 目录，完成后告知我
```

### 步骤 3：初始化英文手稿

1. 将选定模版复制为 `docs/manuscripts/paper-en.tex`（模版原文件不动）
2. 将中文手稿重命名/复制确认 `-zh` 后缀：
   - md 格式：`paper.md` → 确认存为 `paper-zh.md`
   - LaTeX 格式：`paper.tex` → 确认存为 `paper-zh.tex`
3. 中英文共用 `docs/manuscripts/references.bib`（无需复制）

### 步骤 4：逐章翻译

按章节顺序翻译，每章完成后展示给用户确认，再进行下一章。

**翻译格式规范**：
- 每句英文上方一行保留原始中文注释
- LaTeX 格式：
```latex
% 局部注意力机制能够有效捕捉短时间窗内的特征变化。
Local attention effectively captures feature variations within short temporal windows.

% 与标准 Transformer 相比，我们的方法将计算复杂度从 O(n²) 降低至 O(nW)。
Compared to standard Transformers, our method reduces computational complexity from $\mathcal{O}(n^2)$ to $\mathcal{O}(nW)$.
```
- 公式、图表引用编号保持与中文稿一致
- 每个 section 开头保留写作思路注释块（翻译为英文）：
```latex
% === WRITING PLAN: Method ===
% 3.1 Overview: introduce overall pipeline with Fig.1
% 3.2 Local Temporal Attention (LTA): design → motivation → advantage
% ...
```

**翻译约束**：
- 术语翻译必须全文一致（建立术语对照表写在文件头注释中）
- 专有名词（数据集名、方法名）保持英文原名，不翻译
- 数字、公式、引用编号与中文稿完全一致

### 步骤 5：版本记录

翻译完成后在 `paper-en.tex` 文件头追加：
```latex
% 修改时间：{mm-dd_hh-mm}
% 修改内容：从中文稿翻译生成英文版
% 对应中文稿：paper-zh.{md/tex}（或 paper-zh_{mm-dd_hh-mm}.{md/tex}）
% 上一备份：（首次生成，无备份）
```

---

## 完成提示

```
G.8 完成。英文版已生成：docs/manuscripts/paper-en.tex

文件说明：
- docs/manuscripts/paper-zh.{md/tex}：中文稿
- docs/manuscripts/paper-en.tex：英文稿
- docs/manuscripts/references.bib：共用参考文献

→ 论文全流程完成。
```

---

## 参考文件

- 模板灵活性规则：`references/template-flexibility.md`
