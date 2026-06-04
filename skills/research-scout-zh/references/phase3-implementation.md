# 阶段三：代码实现

## 入口

由 `/research-scout-zh step3` 触发。

前置条件：`docs/idea_report.md` 存在且包含 `# 第二部分`。

---

## 子阶段 3a：项目结构设计与确认

### 第一步 —— 读取用户编码需求

检查 `docs/user_requirements.md` → `## 阶段三` 章节。
- 若为空：提示用户填写阶段三章节，等待 `/research-scout-zh confirm`
- 若已填写：读取并应用（语言、框架、现有项目、代码风格）

### 第二步 —— 读取完整 idea_report.md

提取：方法模块、数据集、基线、消融组件、评估指标。
用于确定文件命名和模块职责分配。

### 第三步 —— 选择结构策略

**策略 A —— 基于现有开源项目：**

条件：`user_requirements.md` 阶段三"基于现有项目"字段包含路径或 URL。

- 读取原始项目的目录树
- 设计修改方案：为每个文件标注 `[新建]` / `[修改]` / `[保留]`
- 不得重构原始目录层级，仅在其基础上添加内容

**策略 B —— 从零构建（默认）：**

使用以下标准布局。根据实际需求增减子目录
（例如，若只有一个基线且位于 `src/` 中，则无需 `baselines/`）。

```
code/
├── src/
│   ├── data/           # 数据集加载与预处理
│   ├── models/         # 模型定义与损失函数
│   ├── trainers/       # 训练/验证循环
│   └── utils/          # 指标、日志、辅助工具
├── scripts/
│   ├── train.sh        # 训练启动脚本（超参数作为参数传入）
│   ├── evaluate.sh     # 评估脚本
│   └── ablation.sh     # 消融实验运行脚本
├── configs/
│   └── default.yaml    # 所有超参数集中在此
├── baselines/          # 基线复现代码
├── data/               # 数据集 —— 添加至 .gitignore
├── results/            # 实验输出 —— 添加至 .gitignore
├── logs/               # 训练日志 —— 添加至 .gitignore
├── README.md
└── requirements.txt    # 仅列库名；不含 torch/torchvision/torchaudio；不固定版本
```

### 第四步 —— 展示结构并请求确认

```
结构策略：从零构建 / 基于 {项目名称}（策略 A）

code/
{渲染的目录树，每个文件附一行注释}

确认：  /research-scout-zh confirm
调整：  /research-scout-zh revise-structure "反馈"
```

等待 `/research-scout-zh confirm` 后再进入子阶段 3b。

---

## 子阶段 3b：代码实现

### 开始时

同时创建两个文档：

1. `docs/dev_log.md` —— 填写项目概览表和项目架构章节
2. `docs/code_guide.md` —— 填写"项目来源"和"项目结构"章节；
   其他章节留为 `{占位符 —— 模块完成后填写}`

### 第一个文件：README.md

README.md 必须包含：

**项目简介**：来自 idea_report.md 主题描述的一段话。

**环境配置**（格式固定，不得偏离）：

```markdown
## 环境配置

```bash
# 1. 创建 conda 环境
conda create -n {env_name} python={x.x}
conda activate {env_name}

# 2. 安装 PyTorch（根据您的 CUDA 版本选择）
# 参见：https://pytorch.org/get-started/locally/
# CUDA 12.1 示例：
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121

# 3. 安装其他依赖
pip install -r requirements.txt
```
```

**数据集准备**：来自 idea_report.md 第二部分数据集章节。

**运行命令**：来自 scripts/（scripts/ 完成后填写 —— 初始使用占位符）。

### requirements.txt 规则

- 仅列库名 —— 不固定版本，不添加注释
- 不得包含：`torch`、`torchvision`、`torchaudio`
- 有效条目示例：`numpy`、`pandas`、`scikit-learn`、`wandb`、`tqdm`、`einops`

### 实现顺序

```
requirements.txt → configs/default.yaml → README.md → src/data/ → src/models/ →
src/trainers/ → src/utils/ → scripts/ → baselines/
```

### 每个文件的同步协议

完成每个文件后，同时执行以下三项操作：

1. 更新 `dev_log.md` 进度表：将状态改为 `✅ 已完成`，填写完成日期
2. 在 `dev_log.md` 中添加条目：
   ```markdown
   ### {YYYY-MM-DD} —— {模块名称}
   - **完成内容**：{实现了什么}
   - **遇到的问题**：{遇到的问题，或"无"}
   - **解决方案**：{如何解决，或"无"}
   ```
3. 在 `code_guide.md` 的"各文件说明"章节中添加对应子章节

完成 `scripts/` 后：填写 `code_guide.md` 中的"启动指南"章节。
完成 `src/data/` 后：填写 `code_guide.md` 中的"数据格式"章节（按模板灵活性规则，视情况而定）。

### 阻塞性问题

若遇到实验设计层面的问题（数据集不可访问、指标未定义、
基线接口不兼容等）：立即停止并显示：

```
⚠️ 阻塞：{具体问题}

此问题需要回顾实验设计。
执行 /research-scout-zh back-to-step2 "{原因}" 以回滚。
若问题无需修改设计即可解决，请直接回复。
```

---

## 子阶段 3c：结果反馈循环

在编码过程中或编码完成后，随时可由 `/research-scout-zh log-results` 触发。

### 步骤

1. 提示用户粘贴实验输出（指标数值或日志摘录）

2. 将实际结果填入第二部分预期结果表 —— 替换 `?` 占位符

3. 与"预期（我们的方法）"列对比：
   - 超出预期 > 5%：`✅ 超出预期 +{差值}`
   - 在 ±5% 以内：`✅ 符合预期`
   - 低于预期 > 5%：`⚠️ 低于预期 -{差值}`

4. 若主实验低于预期，显示诊断信息：

```
主实验结果低于预期。可能原因：
1. {原因}（建议：{具体修复措施}）
2. {原因}（建议：{具体修复措施}）

选项：
- /research-scout-zh revise "调整内容"  —— 调整超参数或预处理
- /research-scout-zh back-to-step2 "原因"  —— 修改实验设计
- /research-scout-zh log-results  —— 继续记录下一个实验
```

5. 在 `dev_log.md` 中添加条目：

```markdown
### {YYYY-MM-DD} —— 结果：{实验名称}
- **实际值**：{指标} = {数值}
- **预期值**：{指标} = {预期数值}
- **评估**：✅ 超出预期 / ✅ 符合预期 / ⚠️ 低于预期
- **分析**：{发现或结论}
```

---

## back-to-step2 回滚

当用户执行 `/research-scout-zh back-to-step2 "原因"` 时：

1. 在 `dev_log.md` 顶部前置：
   ```markdown
   [已归档 - {YYYY-MM-DD} - {原因}]
   ```
2. 将 `idea_report.md` 第二部分标题中的 `Status` 字段改为 `REVISING`
3. 显示：
   ```
   dev_log.md 已归档。实验设计现已标记为 REVISING。
   执行 /research-scout-zh revise "反馈" 以更新第二部分。
   然后执行 /research-scout-zh step3 以使用修订后的设计重新进入编码阶段。
   ```
