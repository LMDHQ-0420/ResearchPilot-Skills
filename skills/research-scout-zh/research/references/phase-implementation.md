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

implementation.md 生成后，主动询问确认：

```
implementation.md 已生成。你觉得实现方案够详细、够完善了吗？
如果可以，下一步是下载数据集，然后开始编码。
或者你有什么需要补充调整的地方？
```

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

## implementation.md 格式规范

### 通用规则

- 精确到每一个函数：函数名、参数（含类型注释）、返回值（含类型）、具体实现逻辑
- 精确到每一个目录和文件：存放什么、职责是什么
- 精确到每一个 results 文件：文件名、格式、每个字段的含义和单位
- 大量使用 `>` 解释每个设计决策的理由
- 使用 `>>` 标注有文献支撑的设计决策，附上原文

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

| 文件 | 操作 | 改写原因 |
|-----|------|---------|
| `{file1.py}` | `[MODIFIED]` | {原因} |
| `{file2.py}` | `[NEW]` | {原因} |
| `{file3.py}` | `[KEEP]` | 无需修改 |
| `{dir/}` | `[KEEP]` | 无需修改 |

> {说明为什么这样划分改写范围：尽量复用原有实现，只修改与创新点直接相关的部分}

---

## 2 项目结构

### 2.1 改写后完整目录树

```text
code/
├── {原有目录/文件}    [KEEP]
├── {原有文件.py}     [MODIFIED] — {一句话说明改了什么}
├── {新文件.py}       [NEW] — {一句话说明功能}
├── data/             [KEEP / 新增]
├── results/          [新增]
├── logs/             [新增]
└── requirements.txt  [MODIFIED] — 新增依赖：{列表}
```

### 2.2 新增目录说明

| 目录/文件 | 存放内容 |
|----------|---------|
| `data/` | 数据集原始文件，按数据集名称子目录组织 |
| `results/` | 实验输出：checkpoints、评估结果、预测文件 |
| `logs/` | 训练日志 CSV 文件 |

---

## 3 现有文件详解与改写方案

> 本章对每个需要修改的文件，先描述现有实现，再给出精确的改写方案。

### 3.x `{需要修改的文件.py}` [MODIFIED]

**文件职责**：{一句话}

#### 现有实现

**现有类/函数列表：**

```python
class {ExistingClass}:
    def __init__(self, {params}):
        """原始 docstring"""
        ...
    
    def {existing_method}(self, {params}) -> {return_type}:
        """原始 docstring"""
        # 现有逻辑描述：{说明现在这个函数做什么}
        ...
```

**现有逻辑说明：**
{描述现有函数的核心逻辑，不需要贴完整代码，用文字+关键代码片段说明}

#### 改写方案

**需要改写的函数：**

**`{method_to_modify}`：**

原始签名：`def {method_to_modify}(self, {original_params})`
改写后签名：`def {method_to_modify}(self, {new_params})`

改写内容：
```python
def {method_to_modify}(self, {new_params}) -> {return_type}:
    # [改写] {说明改了什么，为什么}
    {新的关键逻辑片段}
    
    # [保留] {说明哪些逻辑保持不变}
    {保留的逻辑}
```

> {为什么这样改：设计依据，或文献中的理论支撑}

>> {若改写方案直接借鉴某论文，标注来源} [n]

**需要新增的函数：**

**`{new_method}`（新增）：**

```python
def {new_method}(self, {params}) -> {return_type}:
    """
    {功能描述}
    
    Args:
        {param}: {类型} — {含义}
    Returns:
        {return_type}: {含义}
    """
    # {实现逻辑描述}
    {关键代码片段}
```

> {为什么需要这个新函数：它实现了哪个创新组件}

---

### 3.x `{新增文件.py}` [NEW]

**文件职责**：{一句话}

**完整函数列表：**

#### `{ClassName}`

```python
class {ClassName}({BaseClass}):
    def __init__(self, {params: types}) -> None:
        """
        {类描述}
        
        Args:
            {param}: {类型} — {含义，包括取值范围}
        """
    
    def {method1}(self, {params: types}) -> {return_type}:
        """
        {方法描述}
        
        Args:
            {param}: {类型} — {含义}
        Returns:
            {类型}: shape {[B, L, D]} — {每个维度的含义}
        """
        # 实现逻辑：
        # 1. {步骤1}
        # 2. {步骤2}
        # 3. {步骤3}
```

> {每个关键步骤的设计理由}

---

## 4 数据下载与准备

### 4.1 数据集

| 数据集 | 类型 | 来源 | 下载链接 | 存放路径 |
|-------|------|------|---------|---------|

### 4.2 下载步骤

```bash
# {数据集名称}
{具体下载命令}

# 解压（若需要）
{解压命令}

# 预处理（若有统一工具）
{预处理命令}
```

### 4.3 下载后目录结构

```text
data/
└── {dataset_name}/
    ├── {file1}    # {说明：格式、内容、行数/大小}
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
- **读取**：`model.load_state_dict(torch.load('results/checkpoints/best.pth'))`
- **内容**：验证集最优 epoch 的模型参数

### 5.2 训练曲线 `logs/train_{timestamp}.csv`

```text
epoch, train_loss, val_loss, val_{metric1}, val_{metric2}, lr
1,     0.042,      0.038,    0.021,         0.031,         1e-3
```

| 字段 | 类型 | 含义 |
|-----|------|------|
| epoch | int | 当前轮次 |
| train_loss | float | 训练集损失，越低越好 |
| val_loss | float | 验证集损失，越低越好 |
| val_{metric1} | float | {指标名}，{单位}，越{高/低}越好 |
| lr | float | 当前学习率 |

### 5.3 评估结果 `results/eval_{timestamp}.json`

```json
{
  "{metric1}": 0.018,
  "{metric2}": 0.026,
  "{metric3}": 2.3,
  "dataset": "{dataset_name}",
  "split": "test",
  "checkpoint": "results/checkpoints/best.pth"
}
```

| 字段 | 类型 | 单位 | 含义 | 越{高/低}越好 |
|-----|------|------|------|-------------|
| {metric1} | float | {unit} | {含义} | 越低越好 |

### 5.4 逐样本预测 `results/predictions_{timestamp}.csv`

```text
sample_id, {true_col}, {pred_col}, abs_error
0,         0.823,      0.817,      0.006
```

| 字段 | 类型 | 单位 | 含义 |
|-----|------|------|------|
| sample_id | int | — | 测试集样本序号 |
| {true_col} | float | {unit} | 真实标签值 |
| {pred_col} | float | {unit} | 模型预测值 |
| abs_error | float | {unit} | 绝对误差 = \|pred - true\| |

> 可通过 abs_error 排序定位模型误差最大的样本，分析哪类样本最难预测。

### 5.5 消融实验汇总 `results/ablation/summary.csv`

```text
variant,       {metric1}, {metric2}, notes
full_model,    0.018,     0.026,     完整模型
w/o_{moduleA}, 0.024,     0.033,     去掉{模块A}
w/o_{moduleB}, 0.021,     0.029,     去掉{模块B}
```

---

## 6 实现顺序

{针对强 baseline 改写的顺序}

```
1. 确认原项目可正常运行（跑通原始训练脚本）
   → 记录原始性能作为基准

2. {按改写范围表的顺序，从最核心的改动开始}
   → 每改一个文件，运行单元测试或简短训练确认无误

3. 集成所有改写，完整训练运行

4. 新增 baselines/ 中的对比实现（若有）

5. 添加 results/ 输出和 logs/ 日志功能
```

每完成一个文件，立即在 `docs/dev_log.md` 更新进度表并添加日志条目。
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
│   │   ├── __init__.py
│   │   ├── {dataset}_dataset.py    # {一句话}
│   │   └── transforms.py           # {一句话}
│   ├── models/
│   │   ├── __init__.py
│   │   ├── {model_name}.py         # {一句话}
│   │   └── losses.py               # {一句话}
│   ├── trainers/
│   │   ├── __init__.py
│   │   └── trainer.py              # {一句话}
│   └── utils/
│       ├── metrics.py              # {一句话}
│       └── logger.py               # {一句话}
├── scripts/
│   ├── train.sh
│   ├── evaluate.sh
│   └── ablation.sh
├── configs/
│   └── default.yaml
├── baselines/
│   └── {baseline_name}.py
├── data/                           # gitignored
├── results/                        # gitignored
├── logs/                           # gitignored
├── README.md
└── requirements.txt
```

### 1.2 各目录/文件职责

| 路径 | 存放内容 | 说明 |
|-----|---------|------|
| `src/data/` | 数据集类和预处理 | 所有与数据加载相关的代码 |
| `src/models/` | 模型定义和损失函数 | 不包含训练逻辑 |
| `src/trainers/` | 训练和验证循环 | 不包含模型定义 |
| `src/utils/` | 指标计算和日志 | 无状态工具函数 |
| `scripts/` | Shell 启动脚本 | 不包含业务逻辑，只调用 Python 模块 |
| `configs/` | 超参数配置 | YAML 格式，所有超参数集中在此 |
| `baselines/` | Baseline 复现 | 接口与主模型一致，便于直接替换 |
| `data/` | 原始数据集 | gitignored，不提交 |
| `results/` | 实验输出 | checkpoints、评估结果、预测文件 |
| `logs/` | 训练日志 | CSV 格式 |

---

## 2 各文件详细实现说明

> 精确到每个函数：签名、参数、返回值、实现逻辑。
> 阅读顺序：数据加载 → 模型 → 损失 → 训练循环 → 工具 → 脚本

### 2.1 `src/data/{dataset}_dataset.py`

**文件职责**：加载 {数据集名称} 数据，执行滑窗切片，返回模型所需 tensor。

#### `{DatasetName}(torch.utils.data.Dataset)`

```python
class {DatasetName}(Dataset):
    def __init__(
        self,
        data_path: str,      # 数据集根目录
        split: str,          # "train" / "val" / "test"
        seq_len: int,        # 滑窗长度
        stride: int,         # 滑窗步长
        normalize: bool = True  # 是否标准化，均值方差从训练集计算
    ) -> None:
```

> {为什么需要这些参数：seq_len 和 stride 的选择依据引用 Part 3 实验参数表}

```python
    def __len__(self) -> int:
        # 返回：(总时间步数 - seq_len) // stride + 1
```

```python
    def __getitem__(self, idx: int) -> tuple[torch.Tensor, torch.Tensor]:
        # 返回：
        #   x: [seq_len, feature_dim]  输入序列
        #   y: [1]                     标签（窗口末尾时刻的值）
        start = idx * self.stride
        x = self.data[start: start + self.seq_len]
        y = self.labels[start + self.seq_len - 1]
        return torch.tensor(x, dtype=torch.float32), torch.tensor([y], dtype=torch.float32)
```

> {为什么取窗口末尾而非均值作为标签：说明与任务定义的对齐关系}

**预处理流程**（在 `__init__` 中执行）：
1. 读取原始数据文件（{格式：csv / mat / hdf5}）
2. 按 {split} 比例划分（{说明：官方划分 / 按时间顺序划分，引用 Part 3}）
3. 若 `normalize=True`：从训练集计算均值和标准差，对所有 split 应用

> {预处理方式的依据：引用使用相同预处理的论文或领域惯例}

---

### 2.2 `src/data/transforms.py`

**文件职责**：数据增强和标准化变换。

#### `Normalize`

```python
class Normalize:
    def __init__(self, mean: np.ndarray, std: np.ndarray) -> None:
        # mean, std: shape [feature_dim]，从训练集计算
    
    def __call__(self, x: np.ndarray) -> np.ndarray:
        # 返回：(x - mean) / (std + 1e-8)
        # +1e-8 防止除零
```

---

### 2.3 `src/models/{model_name}.py`

**文件职责**：定义主模型 `{ModelName}`，实现 {核心机制} 的前向推断。

**模型结构图**：
```text
输入 [B, L, D]
  → {模块A（类名：ModuleA）}：{作用}  → [B, L, D']
  → {模块B（类名：ModuleB）}：{作用}  → [B, D']
  → 预测头（nn.Linear）              → [B, 1]
```

#### `{ModelName}(nn.Module)`

```python
class {ModelName}(nn.Module):
    def __init__(
        self,
        input_dim: int,      # 输入特征维度
        hidden_dim: int,     # 隐藏层维度，默认 128
        num_layers: int,     # {模块} 层数，默认 {N}
        dropout: float = 0.1 # Dropout 概率
    ) -> None:
```

> {hidden_dim 和 num_layers 的选择依据：引用 Part 3 实验参数表或相关论文}

```python
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        # x: [B, L, D] → pred: [B, 1]
        # 步骤：
        # 1. {模块A}：{说明}
        # 2. {模块B}：{说明}
        # 3. 预测头：Linear(hidden_dim, 1)
```

#### `{CoreModule}(nn.Module)`（核心创新模块）

```python
class {CoreModule}(nn.Module):
    def __init__(self, dim: int, {其他参数}) -> None:
        # {初始化逻辑说明}
    
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        # x: [B, L, D] → out: [B, L, D]
        # 关键步骤：
        # 1. {步骤1}
        # 2. {步骤2}
```

> {每个步骤的设计理由，尤其是与创新点相关的部分}

>> {若某步骤直接借鉴论文，标注来源并附原文} [n]

**参数量估算**：约 {N}M 参数
**显存估算**：batch_size={B} 时约 {N}GB

---

### 2.4 `src/models/losses.py`

**文件职责**：定义训练使用的损失函数。

#### `{LossName}`

```python
def {loss_fn}(
    pred: torch.Tensor,   # [B, 1] 预测值
    target: torch.Tensor  # [B, 1] 真实标签
) -> torch.Tensor:        # 标量
```

**公式**：
$$
\mathcal{L} = {公式}
$$

> {每个符号的含义；为什么选这个损失函数而不是 MSE；文献依据}

---

### 2.5 `src/trainers/trainer.py`

**文件职责**：封装完整训练/验证循环，支持 early stopping、学习率调度、checkpoint 保存。

#### `Trainer`

```python
class Trainer:
    def __init__(
        self,
        model: nn.Module,
        train_loader: DataLoader,
        val_loader: DataLoader,
        config: dict              # 来自 configs/default.yaml
    ) -> None:
        # 从 config 初始化：optimizer, scheduler, criterion, patience 等
```

**`train_one_epoch() -> float`**：
```python
    def train_one_epoch(self) -> float:
        # 返回：平均训练 loss
        self.model.train()
        for batch_x, batch_y in self.train_loader:
            self.optimizer.zero_grad()
            pred = self.model(batch_x.to(self.device))
            loss = self.criterion(pred, batch_y.to(self.device))
            loss.backward()
            # {是否需要梯度裁剪？clip_grad_norm_ 阈值及理由}
            self.optimizer.step()
        return avg_loss
```

**`validate() -> tuple[float, dict]`**：
```python
    def validate(self) -> tuple[float, dict]:
        # 返回：(val_loss, {metric_name: value})
        self.model.eval()
        with torch.no_grad():
            # 遍历验证集，计算 loss 和所有评估指标
```

**`fit() -> None`**：
```python
    def fit(self) -> None:
        # epoch 循环 + early stopping
        # early stopping 逻辑：
        if val_loss < self.best_val_loss - self.min_delta:
            self.best_val_loss = val_loss
            self.patience_counter = 0
            self.save_checkpoint()
        else:
            self.patience_counter += 1
            if self.patience_counter >= self.patience:
                break
```

> {patience 和 min_delta 的选择依据}

---

### 2.6 `src/utils/metrics.py`

**文件职责**：计算评估指标，所有函数接受 numpy array，返回 float。

| 函数 | 指标 | 公式 | 值域 | 方向 | 注意事项 |
|-----|------|------|------|------|---------|
| `mae(pred, true)` | MAE | mean(\|pred-true\|) | [0,+∞) | 越低越好 | — |
| `rmse(pred, true)` | RMSE | sqrt(mean((pred-true)²)) | [0,+∞) | 越低越好 | 对大误差更敏感 |
| `mape(pred, true)` | MAPE | mean(\|pred-true\|/true)×100% | [0,+∞) | 越低越好 | true≈0 时不稳定 |

> {各指标在该领域的使用惯例，引用使用相同指标的论文}

---

### 2.7 `src/utils/logger.py`

**文件职责**：统一管理训练日志，写入 CSV，可选 wandb/tensorboard。

**`Logger.log(epoch: int, metrics: dict) -> None`**：
将当前 epoch 的所有指标写入 `logs/train_{timestamp}.csv`。

---

### 2.8 `configs/default.yaml`

```yaml
data:
  dataset: {dataset_name}
  data_dir: data/
  seq_len: {N}       # {选择依据：引用 Part 3 或领域惯例}
  stride: {N}        # {选择依据}
  train_ratio: 0.7
  val_ratio: 0.1
  test_ratio: 0.2

model:
  name: {model_name}
  input_dim: {N}
  hidden_dim: {N}    # {选择依据}
  num_layers: {N}    # {选择依据}
  dropout: 0.1

training:
  epochs: {N}
  batch_size: {N}    # {选择依据：显存限制或领域惯例}
  lr: {float}        # {选择依据：引用论文或调参经验}
  optimizer: adamw
  scheduler: cosine
  patience: {N}
  min_delta: 1e-4
  seed: 42

logging:
  use_wandb: false
  log_dir: logs/
  result_dir: results/
```

> 修改超参数只需编辑此文件。不同实验可复制为 `configs/{experiment_name}.yaml`，训练时用 `--config` 指定。

---

### 2.9 `scripts/train.sh`

```bash
#!/bin/bash
set -e
python -m src.trainers.trainer \
  --config configs/default.yaml \
  --gpu 0 \
  --seed 42
echo "训练完成，权重保存在 results/checkpoints/best.pth"
```

### 2.10 `scripts/evaluate.sh`

```bash
#!/bin/bash
python -m src.evaluate \
  --config configs/default.yaml \
  --ckpt results/checkpoints/best.pth \
  --split test
```

### 2.11 `scripts/ablation.sh`

```bash
#!/bin/bash
# 消融实验 A1：去掉 {模块A}
python -m src.trainers.trainer \
  --config configs/default.yaml \
  --ablation w/o_{moduleA}

# 消融实验 A2：去掉 {模块B}
python -m src.trainers.trainer \
  --config configs/default.yaml \
  --ablation w/o_{moduleB}

# 汇总结果
python -m src.utils.summarize_ablation \
  --result_dir results/ablation/
```

### 2.12 `baselines/{baseline_name}.py`

**文件职责**：复现 baseline 方法，接口与主模型完全一致。

```python
class {BaselineName}(nn.Module):
    def __init__(self, input_dim: int, hidden_dim: int, ...) -> None:
        # 参数签名与主模型保持一致
    
    def forward(self, x: torch.Tensor) -> torch.Tensor:
        # x: [B, L, D] → pred: [B, 1]
        # 与主模型输入输出格式完全相同
```

> 接口一致的原因：便于在 trainer.py 中直接替换模型，避免为每个 baseline 写单独的训练代码。

---

## 3 数据下载与准备

### 3.1 数据集

| 数据集 | 类型 | 来源 | 下载链接 | 存放路径 |
|-------|------|------|---------|---------|

### 3.2 下载步骤

```bash
mkdir -p data/{dataset_name}
{具体下载命令，如 wget / kaggle / 手动下载说明}
```

### 3.3 下载后目录结构

```text
data/
└── {dataset_name}/
    ├── {file1}    # {格式说明，如：CSV，每行一个样本，{N}列}
    ├── {file2}    # {说明}
    └── ...
```

### 3.4 数据字段说明

| 字段 | 类型 | 单位 | 含义 | 正常范围 |
|-----|------|------|------|---------|
| {field} | {type} | {unit} | {含义} | [{min}, {max}] |

> {领域特有概念解释}

---

## 4 results 文件格式规范

### 4.1 模型权重 `results/checkpoints/best.pth`

- **格式**：PyTorch state_dict
- **读取**：`torch.load('results/checkpoints/best.pth', map_location='cpu')`
- **内容**：验证集最优 epoch 的模型参数字典

### 4.2 训练曲线 `logs/train_{timestamp}.csv`

```text
epoch, train_loss, val_loss, val_{metric1}, val_{metric2}, lr
1,     0.042,      0.038,    0.021,         0.031,         1e-3
```

| 字段 | 类型 | 含义 |
|-----|------|------|
| epoch | int | 当前 epoch 编号，从 1 开始 |
| train_loss | float | 训练集平均损失 |
| val_loss | float | 验证集平均损失 |
| val_{metric1} | float | {指标名}，{单位}，{越高/低越好} |
| lr | float | 当前学习率 |

> 正常收敛曲线：val_loss 在前 N epoch 持续下降后趋于平稳。
> 若 val_loss 在 train_loss 仍在下降时上升，说明过拟合，可增大 dropout 或减小 lr。

### 4.3 评估结果 `results/eval_{timestamp}.json`

```json
{
  "{metric1}": 0.018,
  "{metric2}": 0.026,
  "dataset": "{dataset_name}",
  "split": "test",
  "num_samples": {N},
  "checkpoint": "results/checkpoints/best.pth",
  "timestamp": "{YYYY-MM-DD HH:MM:SS}"
}
```

| 字段 | 类型 | 单位 | 含义 | 方向 |
|-----|------|------|------|------|
| {metric1} | float | {unit} | {含义} | 越低越好 |
| num_samples | int | — | 测试集样本总数 | — |

### 4.4 逐样本预测 `results/predictions_{timestamp}.csv`

```text
sample_id, {true_col}, {pred_col}, abs_error
0,         0.823,      0.817,      0.006
1,         0.791,      0.804,      0.013
```

| 字段 | 类型 | 单位 | 含义 |
|-----|------|------|------|
| sample_id | int | — | 测试集中的样本序号 |
| {true_col} | float | {unit} | 真实标签值 |
| {pred_col} | float | {unit} | 模型预测值 |
| abs_error | float | {unit} | 绝对误差 = \|pred - true\| |

> 使用方式：按 abs_error 降序排列，可定位最难预测的样本；按 sample_id 可追溯到原始数据。

### 4.5 消融实验汇总 `results/ablation/summary.csv`

```text
variant,       {metric1}, {metric2}, notes
full_model,    0.018,     0.026,     完整模型（基准）
w/o_{moduleA}, 0.024,     0.033,     去掉{模块A}
w/o_{moduleB}, 0.021,     0.029,     去掉{模块B}
```

| 字段 | 含义 |
|-----|------|
| variant | 变体名称，对应 ablation.sh 中的 --ablation 参数 |
| {metric1} | {测试集上的指标1} |
| notes | 变体说明 |

---

## 5 实现顺序

```
requirements.txt
  → configs/default.yaml
  → README.md（初稿，运行命令占位）
  → src/data/{dataset}_dataset.py
  → src/data/transforms.py
  → src/models/{model_name}.py（先实现核心模块，再组装完整模型）
  → src/models/losses.py
  → src/trainers/trainer.py
  → src/utils/metrics.py
  → src/utils/logger.py
  → scripts/（完成后补全 README.md 运行命令）
  → baselines/{baseline_name}.py
```

每完成一个文件，立即在 `docs/dev_log.md` 更新进度表并添加日志条目。
`✅ Done` 只能在文件写完且本地运行验证无报错后标记。
````

---

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
