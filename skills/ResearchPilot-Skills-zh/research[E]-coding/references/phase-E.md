# 阶段 E 详细流程：编码

## 阶段 E：编码

> **user_requirements.md 优先**：`docs/user_requirements.md` 中记录的所有约束优先于本文件中的任何默认指令。编码前必须先读取该文件。

> **dev_log.md 只追加，不删除**：dev_log.md 是只增不减的日志，每一次代码修改都必须追加新的日志条目，绝不覆盖或删除已有内容。

### 触发

阶段 D 用户确认 `implementation.md` 后自动进入阶段 E。

---

### E-0 编码前确认清单

**在开始任何编码之前**，逐项与用户确认以下 6 件事（一次性提出，用户可逐条回应）：

```
实现方案已确认。开始编码前，先确认几项准备：

**1. 运行环境**
你打算用哪个环境？环境名称是什么？
  - 我会先查找现有环境（如 `conda env list`）：查到 → 直接复用；查不到 → 我按 requirements.txt 新建。

**2. 设备特殊要求**
你的设备对环境有什么特殊要求？（如：CUDA 版本、特定 cuDNN、Apple MPS、只能 CPU、特定 Python 版本等）

**3. 数据集准备**
{逐个数据集说明}「数据集 {name}」：我检测到 {已下载在 data/{name}/ ✅ / 尚未下载 ❌}。
  - 未下载且下载快（小体积/有直链）→ 我直接下载。
  - 未下载且下载慢（大体积/需登录/需申请）→ 我给你下载地址、命令和存放路径，由你下载：
    下载地址：{链接}；命令：{命令}；放到：`data/raw/{name}/`（有预处理流程）或 `data/{name}/`（直接使用）

**4. 代码是否自动运行**
写完代码后要不要我自动运行？
  - 快（秒级~几分钟）→ 建议我直接运行验证
  - 慢（数小时~数天）→ 建议你自己运行
  - 混合 → 快的脚本我跑，慢的（完整训练/全部消融）你跑
  你的选择？

**5. Git 仓库**
有没有已有的 GitHub 仓库？
  - 有 → 请提供仓库 URL；推送整个项目还是只推送 `code/` 下的内容？
  - 没有 → 是否需要我帮你初始化一个新仓库？
  另外，git 的 username 和 email 是什么？（用于 `git config`）

**6. README 位置**
全部代码完成后我会写一份 README.md（含项目主要内容、环境配置、详细运行命令）。
你希望它放在 {项目根目录} 还是 `code/` 目录下？

确认以上后，我开始编码。
```

将用户回答写入 `docs/user_requirements.md` 阶段 E 章节（环境名称、设备要求、数据集处理方式、运行策略、git 配置、README 位置）。

**数据集处理**：
- 检测 `data/` 下是否已存在各数据集
- 未下载且快 → 直接下载
- 未下载且慢 → 输出下载指引等用户完成：
```
**数据集：{dataset_name}**
下载地址：{官方链接}
下载命令：{wget/kaggle 等具体命令}
放置位置：`data/raw/{dataset_name}/`（有预处理流程）或 `data/{dataset_name}/`（直接使用）
数据下载完成后告知我。
```

**Git 初始化**（若用户有仓库或需要新建）：
```bash
git init
git config user.name "{username}"
git config user.email "{email}"
```

创建 `.gitignore`，内容：
```
# 数据集和大文件
data/
# 模型权重（单个文件可能超过 100MB）
results/checkpoints/
results/**/*.pth
results/**/*.pt
results/**/*.bin
results/**/*.ckpt
# CSV/JSON 结果文件默认跟踪，如有特殊需求在下方添加排除规则
# 日志
logs/
# Python
__pycache__/
*.pyc
.env
```

> **大文件确认**：若任何单个文件（数据集、权重等）可能超过 100MB，询问用户是否确认排除，避免推送失败。

---

### E-1 创建 dev_log.md

```markdown
# 开发日志 — {topic}
> 创建时间：{YYYY-MM-DD} | 最后更新：{YYYY-MM-DD}
> 关联实现指南：docs/implementation.md
> ⚠️ 本文件只追加，不删除。每一次代码修改都必须追加新的日志条目。

## 项目概览
| 项目 | 内容 |
|------|------|
| 研究方向 | {topic} |
| 实现策略 | 从头构建 |
| 框架 | {PyTorch x.x} |
| Git 仓库 | {仓库 URL 或"本地"} |
| 推送范围 | {整个项目 / 只推送 code/} |

## 实现进度

| 模块 | 文件 | 状态 | 完成时间 | 备注 |
|------|------|------|---------|------|
| 初始化 | requirements.txt, configs/ | ⬜ TODO | — | |
| 数据加载 | src/data/ | ⬜ TODO | — | |
| 主模型 | src/models/{model}.py | ⬜ TODO | — | |
| Baseline | src/models/baseline/ | ⬜ TODO | — | |
| 训练逻辑 | src/train.py（或 src/train/） | ⬜ TODO | — | |
| 评估逻辑 | src/evaluate.py（或 src/evaluate/） | ⬜ TODO | — | |
| 工具函数 | src/utils/ | ⬜ TODO | — | |
| 运行脚本 | scripts/ | ⬜ TODO | — | |
| README | README.md | ⬜ TODO | — | 全部编码完成后写 |

状态：⬜ TODO / 🔄 WIP / ✅ Done（已运行验证）/ ❌ Blocked

## 开发日志

### {YYYY-MM-DD HH:MM} — 初始化项目
- **完成内容**：{具体内容}
- **遇到的问题**：{描述，或"无"}
- **解决方案**：{描述，或"无"}

## 已知问题
- [ ] {问题描述}

## 运行说明

> 本章固定置于 dev_log.md 最末尾，是这份代码的"运行手册"。逐条列出**所有运行命令**；每条命令都说明：每个参数的含义、运行后会发生什么、会输出什么（到哪个文件/目录、格式是什么）。命令随代码推进逐步补全，**每次改代码都判断本章是否需要同步更新**。

### 环境准备
```bash
{创建/激活环境的命令}
```
> 说明：{这条命令做什么；前置条件，如已装好对应 CUDA 的 PyTorch}

### {命令1：如 训练}
```bash
{完整运行命令，如 bash scripts/train.sh --config configs/default.yaml}
```
- **参数说明**：
  - `{--参数A}`：{含义、取值范围、默认值}
- **运行后会发生什么**：{逐步说明}
- **输出什么**：{产出的文件/目录及格式}

### {命令2：如 评估 / 消融 / 预处理 …}
> 按上述格式逐条补全，覆盖所有训练 / 评估 / 消融 / 数据预处理命令。
```

---

### E-2 按 implementation.md 中的实现顺序逐文件编码

实现顺序：`requirements.txt` → `configs/` → `src/data/` → `src/models/{model}.py` → `src/models/baseline/` → `src/train.py` → `src/utils/` → `src/evaluate.py` → `scripts/`

每完成一个文件，立即同步：
1. 更新 `dev_log.md` 进度表（`✅ Done`，填写完成时间）
2. 在 `dev_log.md` 中**追加**日志条目（完成内容 / 遇到的问题 / 解决方案）
3. **自动判断 `dev_log.md` 末尾"运行说明"章节是否需要更新**：若该文件新增/修改了运行命令、参数、输出文件或输出格式，立即在"运行说明"中补全或修订对应条目；若不涉及则跳过

每完成一个模块（数据/模型/训练循环/工具/脚本）后，执行一次与 implementation.md 的校验：
- 已实现的函数签名、参数、返回值是否与 implementation.md 描述一致
- 数据流中的 tensor shape 是否符合预期
- 若发现不一致，进入 E-5 流程

**按确认的运行策略执行**（E-0 第 4 项）：
- "自动运行" → 写完即运行验证，`✅ Done` 只在运行无报错后标记
- "用户运行" → 写完做静态检查（import/语法/shape 推演），状态标 `🔄 WIP`，用户反馈通过后标 `✅ Done`
- "混合" → 快脚本自动跑，慢脚本交用户跑

---

### E-3 requirements.txt 规则

- 只写库名，不写版本号
- **不得包含 `torch`、`torchvision`、`torchaudio`**

---

### E-4 遇到阻塞性问题

立即停止并提示：
```
⚠️ 遇到阻塞问题：{具体问题}

选择：
- 告诉我如何解决 → 直接修改并继续
- 需要修改 idea → 请使用 `/research[B]-idea` 回到阶段 B
- 需要修改实验设计 → 请使用 `/research[C]-experiment` 回到阶段 C
- 需要修改实现方案 → 请使用 `/research[D]-implementation` 回到阶段 D
```

---

### E-5 发现 implementation.md 错误

编码过程中若发现 implementation.md 存在逻辑错误、描述与实际不符或设计无法实现，**不得擅自修改代码绕过**：

1. 立即停止当前文件的编码
2. 向用户说明问题（位置 / 具体描述 / 影响 / 建议修改方案）
3. 等待用户确认
4. 用户确认后，**先修改 implementation.md**，执行校验
5. 校验通过后，再修改代码继续编码
6. 在 `dev_log.md` 追加一条日志，记录发现的问题和修正内容

---

### E-6 用户提出代码改进要求时

每次改完必须同步：
1. **`docs/dev_log.md`**：追加日志条目（完成内容 / 原因 / 影响），并判断"运行说明"章节是否需要更新
2. **`README.md`**（若已存在且改动影响运行命令/环境/结构）：更新对应小节

> **不得只改代码不更新 dev_log**。每一次代码修改都必须追加日志。

---

### E-7 代码审查（全部编码完成后主动执行）

所有文件编码完成后，主动对全部代码做一次审查：

审查只盯两条硬底线：
1. **代码能跑起来**：import 完整、requirements.txt 覆盖所用库、文件路径与配置一致、scripts 以 nohup 调起对应模块且日志路径正确
2. **逻辑完全正确**：核心创新模块与 Method 描述一致、tensor shape 全链路自洽、loss/metrics 计算口径与 Part 3 一致、消融开关真正生效

发现"跑不起来"或"逻辑错误"→ 必须修，经用户确认后修复并追加 dev_log 条目。
仅风格/工程优化问题 → 不主动改，至多一句话提示。

---

### E-8 编写 README.md

全部代码编码完成且审查通过后，写 README.md（放在 E-0 确认的位置）：

**必须包含**：
- **项目主要内容**：一段话说明这个项目做什么（来自 idea_report.md topic）
- **环境配置**：基于 E-0 确认的环境名称和设备要求，给出创建/激活命令；PyTorch 按官网指引装（区分 CUDA 版本），其余 `pip install -r requirements.txt`
- **详细运行命令**：训练/评估/消融/预处理的逐条命令，从 dev_log.md 的"运行说明"章节同步

---

### E-9 Git 提交与推送

README.md 写完后，按 E-0 确认的 git 配置执行提交和推送：

```bash
# 初次提交
git add .
git commit -m "初始化项目：{topic} 实现"
git branch -M main
git remote add origin {repo_url}
git push -u origin main
```

> **推送范围**：
> - 整个项目 → 在项目根目录执行
> - 只推送 `code/` → 在 `code/` 目录下初始化 git，只推送该目录

**大文件检查**：推送前检查是否有文件超过 100MB（`find . -size +100M`），若有则询问用户确认是否排除。

---

### E-10 阶段 E 完成

代码审查通过、README 写完、git 推送完成后，提示用户：

```
阶段 E 完成。代码审查通过，README 已写，代码已推送。

→ 实验效果不佳时，使用 `/research[F]-iteration` 进入代码迭代阶段。
→ 实验效果满意，直接进入论文撰写，使用 `/research[G]-paper`。
```
