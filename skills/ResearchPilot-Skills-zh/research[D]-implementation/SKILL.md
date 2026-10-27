---
name: research[D]-implementation
description: >
  将已确认的实验方案转为文件和函数级实现指南，检查实验覆盖、接口与数据流一致性，生成 implementation.md。
version: 2.0.0
license: LICENSE
---

> 启动时读取 [阶段执行与交接约定](references/workflow-contract.md)，按其中的授权、状态、科研与复现规则执行。


> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束（方向偏好、实现要求、文档格式等）**优先于本 skill 提示词中的任何默认指令**。每次调用前读取该文件（若存在），确保所有输出符合用户已确认的约束。


# 阶段 D：实现设计

生成精确到函数级别的编码指南，校验实验覆盖与逻辑一致性，
完成后生成 `docs/implementation.md`，进入阶段 E。

**前置条件**：`docs/idea_report.md` 含 Part 3（阶段 C 已完成）。

## 命令

```
/research[D]-implementation
```
> 命令后可跟可选的自然语言指令，AI 会将其作为本次调用的额外约束或补充说明优先处理。


---

## 阶段 D 流程概览

```
D-0 询问是否使用强 Baseline（基于开源项目改进 vs 从头构建）

路径 A（强 Baseline）：
  D-A1 获取开源项目（git clone 或用户自行克隆）
  D-A2 扫描现有项目结构，提取所有类/函数/依赖
  D-A3 收集编码约束（框架、保留功能、特殊要求）
  D-A4 生成 implementation.md（强 baseline 格式）

路径 B（从头构建）：
  D-B1 收集编码约束（框架、特殊要求）
  D-B2 生成 implementation.md（从头构建格式）

D-末1 执行 implementation.md 校验（实验覆盖/逻辑一致性/完整性）
D-末2 编码前确认清单（环境/设备/数据集/运行策略/README 位置）
```

详细执行步骤见 `references/phase-D.md`。

---

## implementation.md 校验规则

每次生成或修改后，必须执行三项校验：

1. **实验要求覆盖**：Part 3 每个实验是否有对应模块/函数支撑
2. **逻辑一致性**：tensor shape 在各模块间是否一致
3. **完整性**：每个列出的文件是否有对应实现章节

校验结果格式：
```
✅ 实验要求覆盖：{通过 / 缺少：…}
✅ 逻辑一致性：{通过 / 发现问题：…}
✅ 完整性：{通过 / 缺少：…}
```

---

## 硬性约束

1. 阶段 D 未经用户确认，不得自动进入阶段 E。
2. implementation.md 生成后必须立即执行校验，有问题先修复再提交给用户确认。
3. requirements.txt 不得包含 torch、torchvision、torchaudio。
4. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。
5. 编码前确认清单（D-末2）必须在开始编码前逐项与用户确认。

---

## 本阶段完成后

implementation.md 和编码前确认清单均确认后，提示用户：

```
阶段 D 完成。implementation.md 已生成并通过校验，编码前确认清单已确认。

implementation.md 和编码前确认清单均确认后，提示用户：

```
阶段 D 完成。implementation.md 已生成并通过校验。

→ 请使用 `/research[E]-coding` 开始编码。
```
```

---

## 参考文件

- 详细流程：`references/phase-D.md`
- 文档格式规范：`references/document-formats.md`
- 模板灵活性规则：`references/template-flexibility.md`
