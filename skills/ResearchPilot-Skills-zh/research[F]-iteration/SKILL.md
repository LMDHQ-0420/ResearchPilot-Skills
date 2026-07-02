---
name: research[F]-iteration
description: >
  ResearchPilot 科研助手[阶段 F]：代码迭代
version: 2.0.0
license: LICENSE
---

# 阶段 F：代码迭代与模型优化

> **user_requirements.md 优先级**：`docs/user_requirements.md` 中记录的所有用户约束**优先于本 skill 提示词中的任何默认指令**。每次调用前必须先读取该文件。

## 整体流程与产物

ResearchPilot-Skills 将完整学术研究拆分为七个阶段，每个阶段是独立的 skill。当前 skill 是其中一环。

### 七阶段链条

| Skill | 阶段 | 主要产物 |
|-------|------|---------|
| `/research[A]-exploration` | 方向探索与调研 | `docs/idea_report.md` Part 1 |
| `/research[B]-idea` | Idea 深化 | `docs/idea_report.md` Part 2 |
| `/research[C]-experiment` | 实验设计 | `docs/idea_report.md` Part 3 |
| `/research[D]-implementation` | 实现设计 | `docs/implementation.md` |
| `/research[E]-coding` | 编码 | `code/` + `docs/dev_log.md` |
| `/research[F]-iteration` | 代码迭代 | `dev_log.md` 迭代记录 |
| `/research[G.0]-plan` | 论文规划 | 手稿架构注释 + `notebooks/figures.ipynb` |
| `/research[G.1]-method` | Method | 手稿 Method 章节 |
| `/research[G.2]-experiments` | Experiments | 手稿 Experiments 章节 |
| `/research[G.3]-abstract` | Abstract | 手稿 Abstract |
| `/research[G.4]-introduction` | Introduction | 手稿 Introduction |
| `/research[G.5]-related` | Related Works | 手稿 Related Works |
| `/research[G.6]-conclusion` | Conclusion + References | 手稿 Conclusion |
| `/research[G.7]-review` | 整稿审阅 | 审阅报告 |
| `/research[G.8]-translate` | 中→英翻译（仅中文版）| `paper-en.tex` |

### 项目目录结构

```
docs/
  idea_report.md        # Part 1（阶段 A）/ Part 2（阶段 B）/ Part 3（阶段 C）
  implementation.md     # 编码指南（阶段 D）
  dev_log.md            # 开发日志（只追加，不删除）
  user_requirements.md  # 用户约束，由 Claude 通过对话收集
  papers/               # 下载的论文 PDF 或摘要 TXT
  manuscripts/          # 阶段 G 论文稿件

code/
  src/models/{model}.py / baseline/
  src/data/ / src/train.py / src/evaluate.py / src/utils/
  scripts/              # nohup shell 脚本
  configs/
  data/ / results/ / logs/
  README.md / requirements.txt
```

---

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
F-3 更新设计文档（先改文档再改代码，不得跳过）
F-4 编码改动（每改一个文件追加 dev_log 迭代记录）
F-5 验证（运行实验，追加结果到 dev_log）
F-6 判断是否继续迭代（循环 F-1，或进入下一阶段）
```

详细执行步骤见 `references/phase-F.md`。

---

## 硬性约束

1. **dev_log.md 只追加，不删除**：每一次代码修改都必须追加新的日志条目。
2. 必须先读取 `dev_log.md`、`results/` 数据和 `idea_report.md` 再给出诊断，不得凭空判断。
3. 改动范围必须经用户确认，先更新设计文档（`idea_report.md` / `implementation.md`），再修改代码，不允许只改代码跳过文档更新。
4. 若改了模型架构（Method），消融设计若随之变化，必须同步更新 Part 3。
5. `references/template-flexibility.md` 中的规则优先于任何具体模板指令。

---

## 本阶段完成后

效果满意时：

```
阶段 F 完成。共迭代 {N} 轮，最终结果已记录在 dev_log.md。

→ 请使用 `/research[G]-paper` 进入论文撰写阶段。
```

---

## 参考文件

- 详细流程：`references/phase-F.md`
- 模板灵活性规则：`references/template-flexibility.md`
