---
name: research[G.7]-review
description: >
  ResearchPilot 科研助手[阶段 G.7]：整稿审阅
version: 2.0.0
license: LICENSE
---

# 阶段 G.7：整稿审阅

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束**优先于本 skill 提示词中的任何默认指令**。

## 命令

```
/research[G.7]-review
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


可在任意章节写完后触发，也可在全部章节完成后做最终审阅。

---

## 触发时必须执行

1. 读取手稿全文
2. 读取参考文献（References 章节或 .bib 文件）
3. 读取 `docs/idea_report.md` 全文
4. 读取 `docs/dev_log.md` 实验结果
5. 读取 `results/` 下评估结果文件

---

## 五维度检查（来自 Master-cai paper-review.md）

### 维度 1：贡献

- 每个声称的贡献（Introduction 贡献列表中的每条）是否在 Experiments 中有直接支撑？
- 贡献描述是否与实验结果一致？（不夸大）
- Abstract 中的贡献描述是否与 Introduction 贡献列表一致？

### 维度 2：写作清晰度

- 每段是否只表达一个核心信息？
- 每段段首句是否概括全段？（反向大纲检验：抽出每段首句，能否形成完整的论文 story？）
- 术语是否全文一致？（缩写定义是否只出现一次）
- 是否有混合多个信息的段落？

### 维度 3：实验充分性

- 主实验是否回答了 RQ1？（方法是否优于所有 baseline？）
- 消融实验是否覆盖了每个关键模块（RQ2）？
- 附加实验是否验证了 RQ3（若有）？
- 是否遗漏了重要的强 baseline？

### 维度 4：评估完整性

- 所有 baseline 的比较是否公平？（相同数据划分、相同超参数搜索策略）
- 评估指标选择是否有领域依据？（是否引用了使用相同指标的先行工作）
- 是否报告了统计显著性（若领域惯例需要）？

### 维度 5：方法设计合理性

- 每个设计选择是否有动机说明？
- 每个模块是否有消融实验验证其必要性？
- 是否有未被实验验证的设计断言？

---

## Claim-Evidence 对齐

对 Abstract 和 Introduction 中每个主要 claim，输出对齐表：

```
| Claim | Evidence | Status |
|-------|----------|--------|
| {claim 内容} | {对应实验/表格/图} | supported / needs evidence / missing |
```

**约束**：
- Status 为 `needs evidence` 或 `missing` 的 claim，必须要求用户补充实验或弱化表述
- 不允许跳过未支撑的 claim

---

## 反向大纲检验（写作清晰度）

1. 抽取全文每段的段首句
2. 检查这些首句能否形成完整且逻辑连贯的论文 story
3. 找出逻辑跳跃、重复或缺失的地方，给出修改建议

---

## 输出格式

```
整稿审阅完成。

**五维度评分**：
1. 贡献：✅ 全部有支撑 / ⚠️ 部分需补充 / ❌ 存在无支撑 claim
2. 写作清晰度：✅ / ⚠️ {问题说明} / ❌
3. 实验充分性：✅ / ⚠️ / ❌
4. 评估完整性：✅ / ⚠️ / ❌
5. 方法设计合理性：✅ / ⚠️ / ❌

**Claim-Evidence 对齐**：
{对齐表}

**发现的问题**（按优先级排序）：
1. [高优先级] {位置}：{问题描述} → 建议：{修改方案}
2. ...

**反向大纲检验**：
{首句列表，标注逻辑问题}

建议解决所有高优先级问题后再提交。
```

---

## 本阶段完成后

所有高优先级问题解决后：

```
审阅通过。

→ 若用中文写作，使用 `/research[G.8]-translate` 生成英文版本。
→ 若直接用英文写作，论文已完成。
```

---

## 参考文件

- 审阅规范来源：`references/section-guide-source.md`（来自 Master-cai paper-review.md）
- 写作流程检验：`references/writing-flow-source.md`
- 模板灵活性规则：`references/template-flexibility.md`
