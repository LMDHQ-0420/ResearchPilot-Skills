# 阶段 D+E：实现设计与编码

---

## 阶段 D：实现设计

### 触发

阶段 C 用户确认实验设计后自动进入。

---

### D-0 询问是否使用强 Baseline

**强 baseline** 定义：在某个开源项目基础上进行改进，而非从头构建。

```
idea_report.md Part 2 的 Method 章节中提到了 Baseline 参考。
你的实现方案是基于某个开源项目进行改进，还是从头构建？

- 如果是基于某个开源项目（强 baseline），请提供该项目的 GitHub 链接
- 如果是从头构建，直接说明即可
```

根据用户回答，进入以下两条路径之一：

---

### 路径 A：强 Baseline（基于开源项目改进）

#### D-A1 获取开源项目

询问用户如何获取代码：

```
你希望如何获取 {项目名} 的代码？

选项 1：我来执行 git clone，将项目克隆到 code/ 目录
选项 2：我自己 clone，完成后告诉你
```

**若 Claude 执行 git clone：**
```bash
git clone {repo_url} code/
```
执行后确认目录存在且文件完整。

**若用户自行 clone：**
等待用户完成，然后：
```bash
ls code/
```
确认目录存在后继续。

若 clone 失败或目录不存在，提示用户检查链接或权限。

#### D-A2 读取现有项目结构

完整扫描 `code/` 目录：
- 列出所有文件和目录
- 对每个 Python 文件，提取：
  - 所有类定义（类名、继承关系）
  - 所有函数/方法（函数名、参数列表、返回类型、docstring）
  - 关键依赖（import 语句）

#### D-A3 收集编码约束

询问用户（若尚未在对话中提及）：
```
在设计改写方案前，确认几点：
1. PyTorch 版本要求？（与原项目兼容）
2. 需要保留原项目的哪些功能？（全部 / 指定功能）
3. 对代码有什么特殊要求？（风格、多卡支持等）
```
写入 `docs/user_requirements.md`。

#### D-A4 生成 implementation.md（强 baseline 格式）

按下方"强 baseline 格式模板"生成 `docs/implementation.md`。
内容精确到每个需要修改的函数的具体改写方案。

---

### 路径 B：从头构建

#### D-B1 收集编码约束

询问用户（若尚未在对话中提及）：
```
在设计实现方案前，确认几点：
1. 框架用 PyTorch 还是其他？
2. 对代码有什么特殊要求？（风格、多卡支持等）
```
写入 `docs/user_requirements.md`。

#### D-B2 生成 implementation.md（从头构建格式）

按下方"从头构建格式模板"生成 `docs/implementation.md`。
内容精确到每个文件的每个函数签名、参数、返回值、实现逻辑。

---

### D-末 数据下载指南 + 确认

implementation.md 生成后，**立即执行一次实验要求校验**（见下方"校验规则"），再询问用户确认：

```
implementation.md 已生成，并完成了实验要求校验。
校验结果：{通过 / 发现以下问题：…}

你觉得实现方案够详细、够完善了吗？
如果可以，下一步是下载数据集，然后开始编码。
或者你有什么需要补充调整的地方？
```

每次用户要求修改 implementation.md 后，同样执行一次校验，将校验结果附在修改后的输出末尾。

用户确认 implementation.md 后，输出数据下载指引：

```
实现方案已确认。在开始编码前，请先下载数据集：

---

**数据集：{dataset_name}**
下载地址：{官方链接}
下载方式：
  {具体命令或步骤，例如：}
  wget {url} -O data/{filename}
  # 或
  kaggle datasets download {dataset_id} -p data/

解压后放置位置：data/{dataset_name}/
预期目录结构：
  data/{dataset_name}/
  ├── {file1}    # {说明}
  ├── {file2}    # {说明}
  └── ...

{若该领域有统一的预处理工具，在此指出：}
预处理工具：{项目名} {链接}
预处理命令：{具体命令}

数据下载完成后，告知我，我们开始编码阶段。
```

等待用户确认数据下载完成后，进入阶段 E。

---

### implementation.md 校验规则

每次生成或修改 implementation.md 后，Claude 必须执行以下校验，将问题列出并修复后再继续：

**1. 实验要求覆盖校验**
- 对照 `idea_report.md` Part 3 中每个实验（主实验、消融实验、附加实验），检查 implementation.md 中是否有对应的模块/函数支撑
- 每个消融变体（w/o X）是否有对应的实现入口（如 config flag 或函数分支）
- 结果输出文件格式是否能记录 Part 3 实验所需的所有评估指标

**2. 逻辑一致性校验**
- 数据流中的 tensor shape 是否在各模块间保持一致（输出 shape = 下一模块的输入 shape）
- 损失函数的输入 shape 是否与模型输出 shape 匹配
- 评估指标的计算方式是否与 Part 3 中定义一致

**3. 完整性校验**
- 实现顺序中列出的每个文件，在"各文件实现说明"中是否都有对应章节
- baselines 列表是否覆盖 Part 3 中所有参与对比的 baseline 模型
- data 目录结构是否与数据流描述一致

校验结果格式：
```
校验结果：
✅ 实验要求覆盖：{通过 / 缺少：…}
✅ 逻辑一致性：{通过 / 发现问题：…}
✅ 完整性：{通过 / 缺少：…}
```
有问题的项目直接在 implementation.md 中修复，修复后重新输出校验结果。

## implementation.md 格式规范

### 通用规则

- 精确到每一个函数：函数名、参数（含类型注释）、返回值（含类型）、具体实现逻辑
- 精确到每一个目录和文件：存放什么、职责是什么
- 精确到每一个 results 文件：文件名、格式、每个字段的含义和单位
- 大量使用 `>` 解释每个设计决策的理由，有文献支撑的附上引用编号

---

### 强 Baseline 格式模板

````markdown
# Implementation Guide — {Topic}
> 生成时间：{YYYY-MM-DD} | 策略：强 Baseline 改进 | 状态：PENDING_REVIEW
> 原始项目：{repo_url}
> 关联实验设计：docs/idea_report.md Part 3

---

## 1 原始项目信息

### 1.1 项目概况

- **名称**：{项目名}
- **链接**：{GitHub URL}
- **Commit**：{hash}（锁定版本，避免上游变更影响）
- **框架**：{PyTorch x.x / 其他}
- **原始功能**：{一段话描述原项目做什么}

### 1.2 改写范围总览

| 文件/目录 | 操作 | 改写原因 |
|----------|------|---------|
| `{file1.py}` | `[MODIFIED]` | {原因} |
| `{file2.py}` | `[NEW]` | {原因} |
| `{file3.py}` | `[KEEP]` | 无需修改 |

> {说明为什么这样划分改写范围：尽量复用原有实现，只修改与创新点直接相关的部分}

---

## 2 数据流

从原始数据文件到模型输入的完整路径：

```text
原始文件（data/{dataset_name}/）
  → 读取与解析（{dataset_file.py}）
      {说明：读取格式、字段提取、缺失值处理方式}
  → 划分（train / val / test）
      {说明：划分方式，如官方划分/时间顺序/随机；比例；引用 Part 3}
  → 标准化（{transforms_file.py}）
      {说明：均值方差从训练集计算，对所有 split 应用；或其他标准化方式}
  → 滑窗 / 分块 / 采样（若适用）
      {说明：窗口大小、步长、标签取法；引用 Part 3}
  → 模型输入 Tensor
      输入 x：shape {[B, ?, ?]}，含义：{每个维度说明}
      标签 y：shape {[B, ?]}，含义：{说明}
```

> {数据流设计的关键决策说明：为什么这样划分、为什么这样标准化}

---

## 3 现有文件改写方案

> 每个需要修改的文件，先说明现有实现的核心逻辑，再给出改写方案。

### 3.x `{需要修改的文件.py}` [MODIFIED]

**文件职责**：{一句话}

**现有核心逻辑**：
{用文字描述现有函数的行为，不贴原始代码。重点说明与创新点相关的部分。}

**需要改写的函数：**

**`{method_to_modify}({params}) -> {return_type}`**

- 原来做什么：{描述原始逻辑}
- 改为做什么：{描述新逻辑，逐步说明}
  1. {步骤1}
  2. {步骤2}
  3. {步骤3}
- 参数变化：{新增/删除/修改了哪些参数，及其含义}
- 返回值变化：{若有变化，说明新的返回值语义及 shape}

> {为什么这样改：设计依据，或文献支撑} [n]

**需要新增的函数：**

**`{new_method}({params}) -> {return_type}`**（新增）

- 功能：{一句话说明这个函数做什么}
- 参数：{param}：{类型}，{含义和取值约束}
- 返回值：{类型}，shape {[?]}，{含义}
- 实现逻辑：
  1. {步骤1}
  2. {步骤2}
  3. {步骤3}

> {为什么需要这个新函数：它实现了哪个创新组件}

---

### 3.x `{新增文件.py}` [NEW]

**文件职责**：{一句话}

**函数/类列表：**

**`{ClassName}`**

- 职责：{说明}
- 初始化参数：{param}（{类型}）— {含义，取值约束}
- 关键方法：

  **`{method1}({params}) -> {return_type}`**
  - 输入：{说明，包括 shape}
  - 输出：{说明，包括 shape}
  - 实现逻辑：
    1. {步骤1}
    2. {步骤2}

  > {步骤中关键设计决策的理由}

---

## 4 数据下载与准备

### 4.1 数据集

| 数据集 | 类型 | 来源 | 下载链接 | 存放路径 |
|-------|------|------|---------|---------|

### 4.2 下载步骤

```bash
mkdir -p data/{dataset_name}
{具体下载命令}
```

### 4.3 下载后目录结构

```text
data/
└── {dataset_name}/
    ├── {file1}    # {格式说明：文件类型、行数/大小、内容}
    ├── {file2}    # {说明}
    └── ...
```

### 4.4 数据字段说明

| 字段 | 类型 | 单位 | 含义 | 正常范围 |
|-----|------|------|------|---------|
| {field} | {type} | {unit} | {含义} | [{min}, {max}] |

> {领域特有概念解释}

---

## 5 results 文件格式规范

### 5.1 模型权重 `results/checkpoints/best.pth`

- **格式**：PyTorch state_dict
- **读取**：`torch.load('results/checkpoints/best.pth', map_location='cpu')`
- **内容**：验证集最优 epoch 的模型参数字典

### 5.2 训练曲线 `logs/train_{timestamp}.csv`

| 字段 | 类型 | 含义 |
|-----|------|------|
| epoch | int | 当前 epoch 编号，从 1 开始 |
| train_loss | float | 训练集平均损失 |
| val_loss | float | 验证集平均损失 |
| val_{metric1} | float | {指标名}，{单位}，{越高/低越好} |
| lr | float | 当前学习率 |

### 5.3 评估结果 `results/eval_{timestamp}.json`

| 字段 | 类型 | 单位 | 含义 | 方向 |
|-----|------|------|------|------|
| {metric1} | float | {unit} | {含义} | 越低越好 |
| num_samples | int | — | 测试集样本总数 | — |
| dataset | str | — | 数据集名称 | — |
| split | str | — | 评估集划分 | — |
| checkpoint | str | — | 使用的权重路径 | — |

### 5.4 逐样本预测 `results/predictions_{timestamp}.csv`

| 字段 | 类型 | 单位 | 含义 |
|-----|------|------|------|
| sample_id | int | — | 测试集中的样本序号 |
| {true_col} | float | {unit} | 真实标签值 |
| {pred_col} | float | {unit} | 模型预测值 |
| abs_error | float | {unit} | 绝对误差 = \|pred - true\| |

> 按 abs_error 降序排列可定位最难预测的样本，按 sample_id 可追溯到原始数据。

### 5.5 消融实验汇总 `results/ablation/summary.csv`

| 字段 | 含义 |
|-----|------|
| variant | 变体名称，对应 ablation.sh 中的 --ablation 参数 |
| {metric1} | 测试集上的指标1 |
| notes | 变体说明 |

---

## 6 实现顺序

```
1. 确认原项目可正常运行（跑通原始训练脚本），记录原始性能作为基准
2. 按改写范围表的顺序，从最核心的改动开始
   → 每改一个文件，做最小可运行测试确认无误
3. 集成所有改写，完整训练运行
4. 新增 baselines/ 中的对比实现（若有）
5. 添加 results/ 输出和 logs/ 日志功能
```

每完成一个文件，立即在 `docs/dev_log.md` 更新进度并添加日志条目。
````

---

### 从头构建格式模板

````markdown
# Implementation Guide — {Topic}
> 生成时间：{YYYY-MM-DD} | 策略：从头构建 | 状态：PENDING_REVIEW
> 关联实验设计：docs/idea_report.md Part 3

---

## 1 项目结构

### 1.1 完整目录树

```text
code/
├── src/
│   ├── data/
│   │   ├── {dataset}_dataset.py    # {一句话：职责}
│   │   └── transforms.py           # {一句话：职责}
│   ├── models/
│   │   ├── {model_name}.py         # {一句话：职责}
│   │   └── losses.py               # {一句话：职责}
│   ├── trainers/
│   │   └── trainer.py              # {一句话：职责}
│   └── utils/
│       ├── metrics.py              # {一句话：职责}
│       └── logger.py               # {一句话：职责}
├── scripts/
│   ├── train.sh                    # 启动训练
│   ├── evaluate.sh                 # 评估指定 checkpoint
│   └── ablation.sh                 # 批量消融实验
├── configs/
│   └── default.yaml                # 所有超参数集中于此
├── baselines/
│   └── {baseline_name}.py          # 接口与主模型一致
├── data/                           # gitignored
├── results/                        # gitignored
├── logs/                           # gitignored
├── README.md
└── requirements.txt
```

### 1.2 各目录/文件职责

| 路径 | 存放内容 | 关键约束 |
|-----|---------|---------|
| `src/data/` | 数据集类和预处理 | 只处理数据，不包含模型逻辑 |
| `src/models/` | 模型定义和损失函数 | 只定义结构，不包含训练循环 |
| `src/trainers/` | 训练和验证循环 | 不包含模型定义，通过参数接收模型 |
| `src/utils/` | 指标计算和日志 | 无状态工具函数 |
| `scripts/` | Shell 启动脚本 | 不包含业务逻辑，只调用 Python 模块 |
| `configs/` | 超参数配置 | YAML 格式，不同实验复制为独立 yaml |
| `baselines/` | Baseline 复现 | 与主模型输入输出接口完全一致 |

---

## 2 数据流

从原始数据文件到模型输入的完整路径：

```text
原始文件（data/{dataset_name}/）
  → 读取与解析（{dataset}_dataset.py）
      {说明：读取格式、字段提取、缺失值处理方式}
  → 划分（train / val / test）
      {说明：划分方式，如官方划分/时间顺序/随机；比例；引用 Part 3}
  → 标准化（transforms.py）
      {说明：均值方差从训练集计算，对所有 split 应用；或其他标准化方式}
  → 滑窗 / 分块 / 采样（若适用）
      {说明：窗口大小、步长、标签取法；引用 Part 3}
  → 模型输入 Tensor
      输入 x：shape {[B, ?, ?]}，含义：{每个维度说明}
      标签 y：shape {[B, ?]}，含义：{说明}
```

> {数据流设计的关键决策说明：为什么这样划分、为什么这样标准化}

---

## 3 各文件实现说明

> 每个函数说明：签名、参数含义、返回值语义、实现逻辑（文字步骤，不写代码）。
> 阅读顺序：数据 → 模型 → 损失 → 训练循环 → 工具 → 脚本 → baselines

### 3.1 `src/data/{dataset}_dataset.py`

**文件职责**：加载 {数据集名称} 数据，执行预处理，返回模型所需 tensor。

**`{DatasetName}(Dataset)`**

- 初始化参数：
  - `data_path`（str）：数据集根目录
  - `split`（str）："train" / "val" / "test"
  - `{其他参数}`（{类型}）：{含义，取值约束}
- 初始化逻辑：
  1. 读取原始文件（{格式：csv / mat / hdf5}）
  2. 按 {方式} 划分 split（{依据，引用 Part 3}）
  3. {标准化 / 滑窗 / 其他预处理步骤}
- `__len__() -> int`：返回样本总数，计算方式：{说明}
- `__getitem__(idx) -> tuple[Tensor, Tensor]`：
  - 返回 `(x, y)`，x shape：{[?, ?]}，y shape：{[?]}
  - 取法：{说明窗口起止、标签取法}

> {预处理关键决策的依据，引用论文或领域惯例}

---

### 3.2 `src/data/transforms.py`

**文件职责**：数据标准化和增强变换，无状态或携带训练集统计量。

**`Normalize`**

- 初始化：接受 `mean`、`std`（shape `[feature_dim]`，从训练集计算）
- `__call__(x) -> ndarray`：执行 `(x - mean) / (std + 1e-8)`

> {为什么需要 +1e-8：防止标准差为零时除零}

**{其他变换类（若有）}**：{简要说明}

---

### 3.3 `src/models/{model_name}.py`

**文件职责**：定义主模型，实现 {核心机制} 的前向推断。

**模型结构**：
```text
输入 [B, L, D]
  → {模块A（类名）}：{作用} → [B, L, D']
  → {模块B（类名）}：{作用} → [B, D']
  → 预测头（Linear）        → [B, {output_dim}]
```

**`{ModelName}(nn.Module)`**

- 初始化参数：`input_dim`（int）、`hidden_dim`（int，默认 {N}）、`{其他}`
- `forward(x: Tensor) -> Tensor`：
  - 输入 x：shape `[B, L, D]`
  - 实现逻辑：
    1. 经过 {模块A}：{说明做了什么，输出 shape 变化}
    2. 经过 {模块B}：{说明}
    3. 预测头：{说明}
  - 输出 shape：`[B, {output_dim}]`

> {模型整体设计的理由，对应 idea_report.md Part 2 Method 章节}

**`{CoreModule}(nn.Module)`**（核心创新模块）

- 初始化参数：{param}（{类型}）— {含义}
- `forward(x: Tensor) -> Tensor`：
  - 输入：shape `[B, L, D]`
  - 实现逻辑：
    1. {步骤1，说明操作和输出 shape 变化}
    2. {步骤2}
    3. {步骤3}
  - 输出：shape `[B, L, D]`（或变化后的 shape）

> {每个关键步骤的设计理由，对应 idea_report.md Method 3.3 的理论描述}
> {若某步骤借鉴论文，标注来源} [n]

**参数量估算**：约 {N}M 参数
**显存估算**：batch_size={B} 时约 {N}GB

---

### 3.4 `src/models/losses.py`

**文件职责**：定义训练损失函数。

**`{loss_fn}(pred: Tensor, target: Tensor) -> Tensor`**

- 输入：`pred` shape `[B, {dim}]`，`target` shape `[B, {dim}]`
- 输出：标量
- 公式：$\mathcal{L} = {公式}$
- 实现逻辑：{逐步说明计算过程}

> {为什么选这个损失函数；文献依据} [n]

---

### 3.5 `src/trainers/trainer.py`

**文件职责**：封装完整训练/验证循环，支持 early stopping、学习率调度、checkpoint 保存。

**`Trainer`**

- 初始化参数：`model`、`train_loader`、`val_loader`、`config`（来自 yaml）
- 初始化逻辑：从 config 构建 optimizer、scheduler、criterion，设置 patience 计数器

**`train_one_epoch() -> float`**

- 返回：当前 epoch 平均训练 loss
- 逻辑：遍历 train_loader → 前向 → 计算 loss → 反向 → 更新参数
- 梯度裁剪：{是否需要 clip_grad_norm\_，阈值及理由}

**`validate() -> tuple[float, dict]`**

- 返回：`(val_loss, {metric_name: value})`
- 逻辑：model.eval() → no_grad → 遍历 val_loader → 收集预测 → 调用 metrics.py 计算

**`fit() -> None`**

- 逻辑：epoch 循环 → train_one_epoch + validate → early stopping 判断 → 保存最优 checkpoint
- Early stopping：val_loss 连续 {patience} epoch 无改善（阈值 {min_delta}）

> {patience 和 min_delta 的选择依据}

---

### 3.6 `src/utils/metrics.py`

**文件职责**：计算评估指标，所有函数接受 numpy array，返回 float。

| 函数 | 指标 | 公式 | 值域 | 方向 |
|-----|------|------|------|------|
| `{metric1}(pred, true)` | {名称} | {公式} | {值域} | 越{高/低}越好 |
| `{metric2}(pred, true)` | {名称} | {公式} | {值域} | 越{高/低}越好 |

> {各指标在该领域的使用惯例，引用使用相同指标的论文}

---

### 3.7 `src/utils/logger.py`

**文件职责**：统一管理训练日志，按 epoch 写入 CSV。

**`Logger.log(epoch: int, metrics: dict) -> None`**

- 将当前 epoch 的所有指标追加写入 `logs/train_{timestamp}.csv`

---

### 3.8 `configs/default.yaml`

所有超参数集中于此，按功能分块：`data`、`model`、`training`、`logging`。

| 参数 | 位置 | 默认值 | 说明 |
|-----|------|-------|------|
| `data.seq_len` | data | {N} | {选择依据，引用 Part 3} |
| `model.hidden_dim` | model | {N} | {选择依据} |
| `training.lr` | training | {float} | {选择依据} |
| `training.batch_size` | training | {N} | {显存限制或领域惯例} |
| `training.patience` | training | {N} | {early stopping 依据} |

> 不同实验复制为 `configs/{experiment_name}.yaml`，训练时用 `--config` 指定。

---

### 3.9 `scripts/`

**`train.sh`**：调用 trainer，传入 config 路径和 GPU 编号。
**`evaluate.sh`**：加载指定 checkpoint，在测试集上评估，输出 eval json。
**`ablation.sh`**：循环执行各消融变体，汇总结果到 `results/ablation/summary.csv`。

> scripts 不包含业务逻辑，只负责参数拼装和调用 Python 模块。

---

### 3.10 `baselines/{baseline_name}.py`

**文件职责**：复现 baseline 方法，接口与主模型完全一致。

- `__init__` 参数签名与主模型保持一致
- `forward(x: Tensor) -> Tensor` 输入输出格式与主模型相同
- 实现逻辑：{描述该 baseline 的核心做法}

> 接口一致的原因：便于在 trainer.py 中直接替换模型，无需修改训练代码。

---

## 4 数据下载与准备

### 4.1 数据集

| 数据集 | 类型 | 来源 | 下载链接 | 存放路径 |
|-------|------|------|---------|---------|

### 4.2 下载步骤

```bash
mkdir -p data/{dataset_name}
{具体下载命令}
```

### 4.3 下载后目录结构

```text
data/
└── {dataset_name}/
    ├── {file1}    # {格式说明：文件类型、行数/大小、内容}
    ├── {file2}    # {说明}
    └── ...
```

### 4.4 数据字段说明

| 字段 | 类型 | 单位 | 含义 | 正常范围 |
|-----|------|------|------|---------|
| {field} | {type} | {unit} | {含义} | [{min}, {max}] |

> {领域特有概念解释}

---

## 5 results 文件格式规范

### 5.1 模型权重 `results/checkpoints/best.pth`

- **格式**：PyTorch state_dict
- **读取**：`torch.load('results/checkpoints/best.pth', map_location='cpu')`
- **内容**：验证集最优 epoch 的模型参数字典

### 5.2 训练曲线 `logs/train_{timestamp}.csv`

| 字段 | 类型 | 含义 |
|-----|------|------|
| epoch | int | 当前 epoch 编号，从 1 开始 |
| train_loss | float | 训练集平均损失 |
| val_loss | float | 验证集平均损失 |
| val_{metric1} | float | {指标名}，{单位}，{越高/低越好} |
| lr | float | 当前学习率 |

### 5.3 评估结果 `results/eval_{timestamp}.json`

| 字段 | 类型 | 单位 | 含义 | 方向 |
|-----|------|------|------|------|
| {metric1} | float | {unit} | {含义} | 越低越好 |
| num_samples | int | — | 测试集样本总数 | — |
| dataset | str | — | 数据集名称 | — |
| split | str | — | 评估集划分 | — |
| checkpoint | str | — | 使用的权重路径 | — |

### 5.4 逐样本预测 `results/predictions_{timestamp}.csv`

| 字段 | 类型 | 单位 | 含义 |
|-----|------|------|------|
| sample_id | int | — | 测试集中的样本序号 |
| {true_col} | float | {unit} | 真实标签值 |
| {pred_col} | float | {unit} | 模型预测值 |
| abs_error | float | {unit} | 绝对误差 = \|pred - true\| |

> 按 abs_error 降序排列可定位最难预测的样本，按 sample_id 可追溯到原始数据。

### 5.5 消融实验汇总 `results/ablation/summary.csv`

| 字段 | 含义 |
|-----|------|
| variant | 变体名称，对应 ablation.sh 中的 --ablation 参数 |
| {metric1} | 测试集上的指标1 |
| notes | 变体说明 |

---

## 6 实现顺序

```
requirements.txt
  → configs/default.yaml
  → README.md（初稿，运行命令占位）
  → src/data/{dataset}_dataset.py
  → src/data/transforms.py
  → src/models/{model_name}.py（先实现核心创新模块，再组装完整模型）
  → src/models/losses.py
  → src/trainers/trainer.py
  → src/utils/metrics.py
  → src/utils/logger.py
  → scripts/（完成后补全 README.md 运行命令）
  → baselines/{baseline_name}.py
```

每完成一个文件，立即在 `docs/dev_log.md` 更新进度并添加日志条目。
`✅ Done` 只能在文件写完且本地运行验证无报错后标记。
````

## 阶段 E：编码

### 触发

阶段 D 用户确认 `implementation.md` 并完成数据下载后自动进入。

### E-1 创建 dev_log.md

```markdown
# 开发日志 — {topic}
> 创建时间：{YYYY-MM-DD} | 最后更新：{YYYY-MM-DD}
> 关联实现指南：docs/implementation.md

## 项目概览
| 项目 | 内容 |
|------|------|
| 研究方向 | {topic} |
| 实现策略 | 从头构建 / 强 baseline 改写：{项目名} |
| 框架 | {PyTorch x.x} |

## 实现进度

| 模块 | 文件 | 状态 | 完成时间 | 备注 |
|------|------|------|---------|------|
| 初始化 | requirements.txt, configs/, README.md | ⬜ TODO | — | |
| 数据加载 | src/data/ | ⬜ TODO | — | |
| 主模型 | src/models/{model}.py | ⬜ TODO | — | |
| 损失函数 | src/models/losses.py | ⬜ TODO | — | |
| 训练循环 | src/trainers/trainer.py | ⬜ TODO | — | |
| 工具函数 | src/utils/ | ⬜ TODO | — | |
| 运行脚本 | scripts/ | ⬜ TODO | — | |
| Baseline | baselines/ | ⬜ TODO | — | |

状态：⬜ TODO / 🔄 WIP / ✅ Done（已运行验证）/ ❌ Blocked

## 开发日志

### {YYYY-MM-DD} — 初始化项目
- **完成内容**：{具体内容}
- **遇到的问题**：{描述，或"无"}
- **解决方案**：{描述，或"无"}

## 已知问题
- [ ] {问题描述}
```

### E-2 按 implementation.md 中的实现顺序逐文件编码

每完成一个文件，立即同步：
1. 更新 `dev_log.md` 进度表（`✅ Done`，填写完成时间）
2. 在 `dev_log.md` 中添加日志条目

**每完成一个模块（数据/模型/训练循环/工具/脚本）后，执行一次与 implementation.md 的校验**：
- 检查已实现的函数签名、参数、返回值是否与 implementation.md 中的描述一致
- 检查数据流中的 tensor shape 是否符合预期
- 若发现不一致，进入"发现 implementation 错误"流程（见 E-5）

### E-3 requirements.txt 规则

- 只写库名，不写版本号
- 不得包含 `torch`、`torchvision`、`torchaudio`

### E-4 遇到阻塞性问题

立即停止并提示：
```
⚠️ 遇到阻塞问题：{具体问题}

选择：
- 告诉我如何解决 → 直接修改并继续
- 需要修改实验设计 → 我们回到阶段 C
- 需要修改实现方案 → 我们回到阶段 D
```

### E-5 发现 implementation.md 错误

编码过程中若发现 implementation.md 中存在逻辑错误、描述与实际不符、或设计无法实现，**不得擅自修改代码绕过**，必须执行以下流程：

1. 立即停止当前文件的编码
2. 向用户说明发现的问题：
   ```
   ⚠️ 发现 implementation.md 中存在问题：

   **位置**：{章节/函数名}
   **问题**：{具体描述：逻辑错误 / 描述与实际不符 / 设计无法实现}
   **影响**：{说明这个问题会导致什么后果}
   **建议修改**：{建议的修改方案}

   是否允许按上述方案修改 implementation.md？
   ```
3. 等待用户确认
4. 用户确认后，**先修改 implementation.md**，执行一次校验（见"校验规则"）
5. 校验通过后，再根据更新后的 implementation.md 修改代码，继续编码
