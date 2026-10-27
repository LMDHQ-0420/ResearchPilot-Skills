---
name: research[F]-iteration
description: >
  根据实验日志和评估结果诊断问题，迭代配置、实现或方法，同步受影响的文档并保留失败与负结果。
version: 2.0.0
license: LICENSE
---

> 启动时读取 [阶段执行与交接约定](references/workflow-contract.md)，按其中的授权、状态、科研与复现规则执行。


# 阶段 F：代码迭代与模型优化

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束**优先于本 skill 提示词中的任何默认指令**。每次调用前读取该文件（若存在）。

## 命令

```
/research[F]-iteration
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


---

## 阶段 F 流程概览

```
F-1 诊断分析（读 dev_log.md + results/ + idea_report.md，给出诊断报告）
F-2 确认回溯范围（只改超参 / 改模型架构 / 改实验设计）
F-3 设计语义变化时先更新受影响的设计文档
F-4 编码改动（按有意义改动单元追加 dev_log 迭代记录）
F-5 验证（运行实验，追加结果到 dev_log）
F-6 判断是否继续迭代（循环 F-1，或进入下一阶段）
```

详细执行步骤见 `references/phase-F.md`。

---

## 硬性约束

1. **dev_log.md 只追加，不删除**：按有意义的改动单元追加历史事件；进度与运行说明可更新。
2. 必须先读取 `dev_log.md`、`results/` 数据和 `idea_report.md` 再给出诊断，不得凭空判断。
方法或评估协议变化超出已有授权时集中确认一次；配置和普通修复直接执行。仅在设计语义变化时先更新受影响文档，再改代码。
4. 若改了模型架构（Method），消融设计若随之变化，必须同步更新 Part 3。
5. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。

---

## 本阶段完成后

效果满意时：

```
阶段 F 完成。共迭代 {N} 轮，最终结果已记录在 dev_log.md。

→ 请使用 `/research[G.0]-plan` 进入论文规划阶段。
```

---

## 参考文件

- 详细流程：`references/phase-F.md`
- 模板灵活性规则：`references/template-flexibility.md`
