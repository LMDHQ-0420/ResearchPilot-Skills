# 阶段 D 详细流程：实现设计

---

## 阶段 D：实现设计

> **user_requirements.md 优先**：`docs/user_requirements.md` 中记录的所有约束（框架、设备、代码风格、硬性要求等）优先于本文件中的任何默认指令。生成 implementation.md 前必须先读取该文件，确保所有设计决策符合用户约束。

### 触发

阶段 C 用户确认实验设计后自动进入。

---

### D-0 收集编码约束

询问用户（若尚未在对话中提及）：

```
在设计实现方案前，确认几点：
1. 框架用 PyTorch 还是其他？
2. 对代码有什么特殊要求？（风格、多卡支持、ONNX 导出等）
3. 有其他硬性要求吗？
```

将回答写入 `docs/user_requirements.md` 阶段 D 章节。

---

### D-1 生成 implementation.md

按下方"格式模板"生成 `docs/implementation.md`，内容精确到每个文件的每个函数签名、参数、返回值、实现逻辑。

---

### D-末1 implementation.md 校验与确认

implementation.md 生成后，**立即执行一次实验要求校验**（见下方"校验规则"），再询问用户确认：

```
implementation.md 已生成，并完成了实验要求校验。
校验结果：{通过 / 发现以下问题：…}

你觉得实现方案够详细、够完善了吗？
如果可以，下一步是确认编码前的几项准备，然后开始编码。
或者你有什么需要补充调整的地方？
```

每次用户要求修改 implementation.md 后，同样执行一次校验，将校验结果附在修改后的输出末尾。

implementation.md 确认后，提示用户进入阶段 E：

```
implementation.md 已确认。

→ 请使用 `/research[E]-coding` 开始编码（阶段 E 开始时会进行编码前确认）。
```


## implementation.md 格式规范

### 通用规则

- 精确到每一个函数：函数名、参数（含类型注释）、返回值（含类型）、具体实现逻辑
- 精确到每一个目录和文件：存放什么、职责是什么
- 精确到每一个 results 文件：文件名、格式、每个字段的含义和单位
- 大量使用 `>` 解释每个设计决策的理由，有文献支撑的附上引用编号

---

### 格式模板

````markdown
# Implementation Guide — {Topic}
> 生成时间：{YYYY-MM-DD} | 策略：从头构建 | 状态：PENDING_REVIEW
> 关联实验设计：docs/idea_report.md Part 3

---

## 1 项目结构

> 本章是 implementation.md 开头的关键部分：先给出完整目录树（1.1），再用表格逐文件说明功能（1.2）。

### 1.1 完整目录树

```text
code/
├── src/
│   ├── models/
│   │   ├── {model_name}.py         # 本文提出的模型（一个文件一个模型）
│   │   └── baseline/
│   │       ├── {baseline1}.py      # 一个 baseline 一个文件
│   │       └── {baseline2}.py
│   ├── data/                       # 多个数据处理文件时建子目录；单文件时直接 src/dataset.py
│   │   ├── {dataset}_dataset.py    # Dataset 类
│   │   └── transforms.py           # 预处理/增强
│   ├── train/                      # 多个训练文件时建子目录；单文件时直接 src/train.py
│   │   ├── trainer.py              # 训练循环封装
│   │   └── scheduler.py            # 学习率调度（若独立）
│   ├── evaluate/                   # 多个评估文件时建子目录；单文件时直接 src/evaluate.py
│   │   └── evaluator.py
│   ├── utils/
│   │   ├── metrics.py              # 评估指标计算
│   │   └── logger.py               # 日志工具
│   ├── train.py                    # 训练入口（被 scripts/train.sh 调用）
│   ├── evaluate.py                 # 评估入口
│   └── predict.py                  # 推理入口（可选）
├── scripts/
│   ├── train.sh                    # nohup 启动训练，日志 → logs/
│   ├── evaluate.sh                 # nohup 启动评估
│   └── ablation.sh                 # nohup 批量消融
├── configs/
│   ├── default.yaml                # 所有超参数集中于此
│   └── ablation_{variant}.yaml     # 每个消融变体一个 config
├── data/                           # 若运行会产生数据（需预处理）：raw/ + processed/
│   ├── raw/                        # 原始下载数据（有预处理流程时）
│   └── processed/                  # 预处理后数据（有预处理流程时）
│   # 若不产生中间数据，直接存放在 data/ 下，不建子目录
├── results/                        # gitignored
├── logs/                           # gitignored，文件名：YY-MM-DD_HH-MM-SS.log
├── README.md
└── requirements.txt
```

> **目录规则**：
> - `src/models/` 下只有一个提出模型时，直接放 `{model_name}.py`，不建子目录
> - `src/data/`、`src/train/`、`src/evaluate/` 在只有一个文件时，直接将文件放在 `src/` 下，不建子目录
> - `data/` 目录：若数据处理流程会产生中间文件，建 `raw/` + `processed/`；否则直接存放原始数据，不建子目录

### 1.2 各文件功能表

> 逐文件（不只逐目录）用表格说明功能。文件有几个就写几行。

| 文件 | 功能 | 输入 | 输出 | 被谁调用 |
|------|------|------|------|---------|
| `src/models/{model_name}.py` | {职责} | {输入} | {输出} | `src/train.py` |
| `src/models/baseline/{baseline1}.py` | {职责} | {输入} | {输出} | `src/train.py` |
| `src/data/{dataset}_dataset.py` | {职责} | {输入} | {输出} | `src/train.py` |
| `src/train.py` | {职责} | {输入} | {输出} | `scripts/train.sh` |
| `src/evaluate.py` | {职责} | {输入} | {输出} | `scripts/evaluate.sh` |
| `src/utils/metrics.py` | {职责} | {输入} | {输出} | `src/train.py`, `src/evaluate.py` |
| `configs/default.yaml` | 集中超参数 | — | — | 所有模块经 config 读取 |
| ... | ... | ... | ... | ... |

**目录级约束**：

| 路径 | 关键约束 |
|-----|---------|
| `src/models/` | 只定义结构，不包含训练循环 |
| `src/models/baseline/` | 与主模型输入输出接口完全一致，便于在训练入口直接替换 |
| `src/data/` | 只处理数据，不包含模型逻辑 |
| `src/utils/` | 无状态工具函数 |
| `scripts/` | 只负责参数拼装和 nohup 调用，不包含业务逻辑 |

---

## 2 数据流

从原始数据文件到模型输入的完整路径：

```text
data/raw/{dataset_name}/（或 data/{dataset_name}/）
  → 读取与解析（{dataset_file.py}）
      {说明：读取格式、字段提取、缺失值处理方式}
  → 预处理（若有）：输出到 data/processed/{dataset_name}/
      {说明：预处理步骤}
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
> 阅读顺序：数据 → 模型 → baseline → 损失 → 训练循环 → 评估 → 工具 → 脚本

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

### 3.2 `src/models/{model_name}.py`

**文件职责**：定义本文提出的模型结构。

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

---

### 3.3 `src/models/baseline/{baseline_name}.py`

**文件职责**：复现 {baseline 名称}，接口与主模型完全一致。

- `__init__` 参数签名与主模型保持一致
- `forward(x: Tensor) -> Tensor` 输入输出格式与主模型相同
- 实现逻辑：{描述该 baseline 的核心做法}

> 接口一致的原因：便于在 src/train.py 中直接替换模型，无需修改训练代码。

---

### 3.4 `src/train.py`（或 `src/train/trainer.py`）

**文件职责**：封装完整训练/验证循环，支持 early stopping、学习率调度、checkpoint 保存。

**`Trainer`**

- 初始化参数：`model`、`train_loader`、`val_loader`、`config`（来自 yaml）
- 初始化逻辑：从 config 构建 optimizer、scheduler、criterion，设置 patience 计数器

**`train_one_epoch() -> float`**

- 返回：当前 epoch 平均训练 loss
- 逻辑：遍历 train_loader → 前向 → 计算 loss → 反向 → 更新参数

**`validate() -> tuple[float, dict]`**

- 返回：`(val_loss, {metric_name: value})`
- 逻辑：model.eval() → no_grad → 遍历 val_loader → 收集预测 → 调用 metrics.py 计算

**`fit() -> None`**

- 逻辑：epoch 循环 → train_one_epoch + validate → early stopping 判断 → 保存最优 checkpoint
- Early stopping：val_loss 连续 {patience} epoch 无改善（阈值 {min_delta}）

---

### 3.5 `src/utils/metrics.py`

**文件职责**：计算评估指标，所有函数接受 numpy array，返回 float。

| 函数 | 指标 | 公式 | 值域 | 方向 |
|-----|------|------|------|------|
| `{metric1}(pred, true)` | {名称} | {公式} | {值域} | 越{高/低}越好 |
| `{metric2}(pred, true)` | {名称} | {公式} | {值域} | 越{高/低}越好 |

---

### 3.6 `configs/default.yaml`

所有超参数集中于此，按功能分块：`data`、`model`、`training`、`logging`。

| 参数 | 位置 | 默认值 | 说明 |
|-----|------|-------|------|
| `data.seq_len` | data | {N} | {选择依据，引用 Part 3} |
| `model.hidden_dim` | model | {N} | {选择依据} |
| `training.lr` | training | {float} | {选择依据} |
| `training.batch_size` | training | {N} | {显存限制或领域惯例} |
| `training.patience` | training | {N} | {early stopping 依据} |

> 消融实验复制为 `configs/ablation_{variant}.yaml`，训练时用 `--config` 指定。

---

### 3.7 `scripts/train.sh`

```bash
#!/bin/bash
TIMESTAMP=$(date +"%y-%m-%d_%H-%M-%S")
LOG_FILE="logs/${TIMESTAMP}.log"
mkdir -p logs

nohup python src/train.py \
    --config configs/default.yaml \
    --gpu 0 \
    > "$LOG_FILE" 2>&1 &

echo "Training started. PID: $! | Log: $LOG_FILE"
```

`evaluate.sh` 和 `ablation.sh` 按同样的 nohup 模式，分别调用 `src/evaluate.py` 和循环调用不同 config 的 `src/train.py`。

---

## 4 数据下载与准备

### 4.1 数据集

| 数据集 | 类型 | 来源 | 下载链接 | 存放路径 |
|-------|------|------|---------|---------|

### 4.2 下载步骤

```bash
mkdir -p data/raw/{dataset_name}
{具体下载命令}
```

### 4.3 下载后目录结构

```text
data/
├── raw/
│   └── {dataset_name}/
│       ├── {file1}    # {格式说明}
│       └── ...
└── processed/         # 预处理后自动生成（若有预处理流程）
```

若数据无需预处理，直接存放：
```text
data/
└── {dataset_name}/
    ├── {file1}    # {格式说明}
    └── ...
```

### 4.4 数据字段说明

| 字段 | 类型 | 单位 | 含义 | 正常范围 |
|-----|------|------|------|---------|
| {field} | {type} | {unit} | {含义} | [{min}, {max}] |

---

## 5 results 文件格式规范

### 5.1 模型权重 `results/checkpoints/best.pth`

- **格式**：PyTorch state_dict
- **读取**：`torch.load('results/checkpoints/best.pth', map_location='cpu')`
- **内容**：验证集最优 epoch 的模型参数字典

### 5.2 训练日志 `logs/YY-MM-DD_HH-MM-SS.log`

每次通过 `scripts/train.sh` 启动训练，自动生成以时间戳命名的日志文件，包含训练过程的完整 stdout/stderr 输出。

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

### 5.5 消融实验汇总 `results/ablation/summary.csv`

| 字段 | 含义 |
|-----|------|
| variant | 变体名称，对应 configs/ablation_{variant}.yaml |
| {metric1} | 测试集上的指标1 |
| notes | 变体说明 |

---

## 6 实现顺序

```
requirements.txt
  → configs/default.yaml（及各消融 config）
  → README.md（初稿：项目内容 + 环境配置，运行命令随后补全）
  → src/data/（Dataset 类 + transforms）
  → src/models/{model_name}.py（先实现核心创新模块，再组装完整模型）
  → src/models/baseline/（各 baseline，接口与主模型一致）
  → src/train.py（或 src/train/trainer.py）
  → src/utils/metrics.py + logger.py
  → src/evaluate.py
  → src/predict.py（若需要）
  → scripts/（补全 README.md 运行命令）
```

每完成一个文件，立即在 `docs/dev_log.md` 更新进度并添加日志条目；影响运行/环境的同步更新 `README.md`。
`✅ Done` 只能在文件写完且本地运行验证无报错后标记（用户运行策略下，待用户反馈通过后标记）。
````
