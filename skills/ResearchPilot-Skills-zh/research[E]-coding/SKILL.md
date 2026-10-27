---
name: research[E]-coding
description: >
  按实现指南编码、验证与维护运行说明，记录可重建环境和开发日志；适用于研究代码首次实现或继续编码。
version: 2.0.0
license: LICENSE
---

# 阶段 E：编码

启动时读取 [阶段执行与交接约定](references/workflow-contract.md) 和已存在的 docs/user_requirements.md。按有实质内容的 docs/implementation.md 实现与验证，不以文件存在作为前置阶段完成依据。

## 执行流程

1. 检查现有项目、环境和运行策略，只补问影响执行的缺失信息。
2. 按实现依赖顺序编码，每个模块进行接口、数据流与实验协议校验。
3. 记录完整的可重建环境，保留 Python、PyTorch、CUDA、依赖版本及安装来源。
4. 在授权范围内直接修复普通实现错误；方法变化时先同步受影响的设计文档，必要时集中确认。
5. 按有意义的改动单元追加历史日志，更新进度、运行说明与 README。
6. 执行适合变更的检查，明确区分静态检查、冒烟运行与完整实验。

详细步骤见 [编码流程](references/phase-E.md)。文档结构按需参考 [模板规则](references/template-flexibility.md)。

## 完成与交接

列出实现范围、实际验证命令与结果、未运行实验和剩余问题，更新阶段状态。提交与推送是可选的授权动作，不是编码完成条件。不得用审查或一次无报错运行保证所有逻辑正确。

需要进一步实验诊断时建议 /research[F]-iteration；准备写作时建议 /research[G.0]-plan。用户已授权连续任务时继续执行。
