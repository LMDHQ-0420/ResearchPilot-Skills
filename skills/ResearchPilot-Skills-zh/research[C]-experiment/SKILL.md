---
name: research[C]-experiment
description: >
  根据研究假设与 baseline 文献和代码设计主实验、消融及边界实验，结合预算生成可执行的研究报告 Part 3。
version: 2.0.0
license: LICENSE
---

> 启动时读取 [阶段执行与交接约定](references/workflow-contract.md)，按其中的授权、状态、科研与复现规则执行。


> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前读取该文件（若存在），确保所有输出符合用户已确认的约束。


# 阶段 C：实验设计

精读 baseline 论文与代码，归纳领域实验惯例，设计主实验/消融/附加实验，
完成后追加 `docs/idea_report.md` Part 3，进入阶段 D。

**前置条件**：Part 2 有实质方法内容和适用的确认记录；仅有标题不能判定阶段 B 完成。

**实验设计原则**：检验可证伪的假设，同时定义支持、反对与不确定结果。设计前了解资源边界，提供完整证据方案和预算内的核心执行方案，说明各自可支持的结论。

## 命令

```
/research[C]-experiment
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


---

## 阶段 C 流程概览

```
C-1 读取已有约束和资源信息，精读相关 baseline 文献与代码
C-2 检索领域实验惯例（近 3 年同领域论文）
C-3 数据与代码可获取性核实
C-4 提出实验大纲，与用户确认（先出骨架，再展开细节）
C-5 生成 idea_report.md Part 3 完整内容
C-6 估计运行成本，核对核心方案可执行性和结论边界
C-7 检查完成依据，按已有授权继续或提示阶段 D 命令
C-8 在约定范围内修订，重要未决选择集中确认
```

详细执行步骤见 `references/phase-C.md`。

---

## 硬性约束

1. 进入阶段 D 需有适用授权；用户已明确授权连续执行时不重复确认。
2. 必须先出实验大纲（C-4）并经用户确认，再展开撰写 Part 3 完整内容。
3. 设计前复用或补充设备、时间和预算约束；不得擅自缩减必要证据或隐瞒未验证结论。
4. 参与评测的每个模型必须逐个说明：与本文方法的区别、纳入意义、出处论文。
5. 不得捏造引用。无法核验的加 `⚠️ [低置信度：原因]`。
6. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。

---

## 本阶段完成后

Part 3 确认后，提示用户：

```
阶段 C 完成。idea_report.md Part 3 已生成。

→ 请使用 `/research[D]-implementation` 进入实现设计阶段。
```

---

## 参考文件

- 详细流程：`references/phase-C.md`
- 文档格式规范：`references/document-formats.md`
- 模板灵活性规则：`references/template-flexibility.md`
