# 阶段 A+B+C：方向探索、Idea 深化、实验设计

---

## 论文下载逻辑

所有论文下载（流程内自动触发 或 `/research download-paper` 独立命令）均使用以下逻辑：

```bash
INPUT="{论文标题、arXiv ID、OpenReview ID 或 URL}"
OUTPUT_DIR="${指定路径:-./docs/papers}"
mkdir -p "$OUTPUT_DIR"

TITLE=""
PDF_URL=""

# ── 第一步：判断输入类型，尝试 arXiv ──────────────────────────────────────

if echo "$INPUT" | grep -qE '^[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?$'; then
  ARXIV_ID="$INPUT"
elif echo "$INPUT" | grep -qE 'arxiv\.org/(abs|pdf)/'; then
  ARXIV_ID=$(echo "$INPUT" | grep -oE '[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?')
else
  # 按标题在 arXiv 搜索
  QUERY=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$INPUT")
  API_RESULT=$(curl -s "https://export.arxiv.org/api/query?search_query=ti:${QUERY}&max_results=1")
  ARXIV_ID=$(echo "$API_RESULT" | grep -oE 'arxiv\.org/abs/[0-9]{4}\.[0-9]{4,5}' | grep -oE '[0-9]{4}\.[0-9]{4,5}' | head -1)
fi

if [ -n "$ARXIV_ID" ]; then
  # 获取 arXiv 官方标题
  META=$(curl -s "https://export.arxiv.org/api/query?id_list=${ARXIV_ID}")
  TITLE=$(echo "$META" | python3 -c "
import sys, re, html
c = sys.stdin.read()
m = re.search(r'<entry>.*?<title>(.*?)</title>', c, re.DOTALL)
if m:
    t = html.unescape(m.group(1).strip().replace('\n', ' '))
    print(re.sub(r'\s+', ' ', t))
")
  PDF_URL="https://arxiv.org/pdf/${ARXIV_ID}"
fi

# ── 第二步：arXiv 未找到，尝试 OpenReview ────────────────────────────────

if [ -z "$PDF_URL" ]; then
  # 判断是否直接给了 OpenReview forum ID 或 URL
  if echo "$INPUT" | grep -qE 'openreview\.net'; then
    OR_ID=$(echo "$INPUT" | grep -oE '[?&]id=([A-Za-z0-9_-]+)' | sed 's/[?&]id=//')
  elif echo "$INPUT" | grep -qE '^[A-Za-z0-9_-]{8,}$'; then
    # 看起来像 OpenReview forum ID（非纯数字、非 arXiv 格式）
    OR_ID="$INPUT"
  else
    # 按标题在 OpenReview API v2 搜索
    OR_QUERY=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "$INPUT")
    OR_RESULT=$(curl -s "https://api2.openreview.net/notes?content.title=${OR_QUERY}&limit=1")
    OR_ID=$(echo "$OR_RESULT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    notes = data.get('notes', [])
    if notes:
        print(notes[0].get('forum', ''))
except:
    pass
")
    # 若 API v2 未命中，尝试 API v1
    if [ -z "$OR_ID" ]; then
      OR_RESULT=$(curl -s "https://api.openreview.net/notes?content.title=${OR_QUERY}&limit=1")
      OR_ID=$(echo "$OR_RESULT" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    notes = data.get('notes', [])
    if notes:
        print(notes[0].get('forum', ''))
except:
    pass
")
    fi
  fi

  if [ -n "$OR_ID" ]; then
    # 获取 OpenReview 官方标题
    OR_META=$(curl -s "https://api2.openreview.net/notes?forum=${OR_ID}&limit=1")
    TITLE=$(echo "$OR_META" | python3 -c "
import sys, json
try:
    data = json.load(sys.stdin)
    notes = data.get('notes', [])
    if notes:
        t = notes[0].get('content', {}).get('title', '')
        if isinstance(t, dict):
            t = t.get('value', '')
        print(t)
except:
    pass
")
    PDF_URL="https://openreview.net/pdf?id=${OR_ID}"
  fi
fi

# ── 第三步：执行下载 ───────────────────────────────────────────────────────

if [ -z "$PDF_URL" ]; then
  echo "❌ 下载失败：arXiv 和 OpenReview 均未找到 "$INPUT""
else
  # 若标题为空则回退到输入本身
  [ -z "$TITLE" ] && TITLE="$INPUT"
  FILENAME=$(echo "$TITLE" | python3 -c "
import sys, re
t = sys.stdin.read().strip()
t = re.sub(r'[/\\\\:*?\"<>|]', '', t)
print(t + '.pdf')
")
  curl -L --silent "$PDF_URL" -o "${OUTPUT_DIR}/${FILENAME}"
  if [ -s "${OUTPUT_DIR}/${FILENAME}" ]; then
    echo "✅ 已保存：${OUTPUT_DIR}/${FILENAME}"
  else
    echo "❌ 下载失败：找到链接但 PDF 不可访问（$PDF_URL）"
  fi
fi
```

**独立命令 `/research download-paper "描述" [--to "路径"]`：**
- 不依赖任何流程状态，随时可用
- 默认保存到 `docs/papers/`，`--to` 参数可指定其他路径
- 下载完成后必须输出文件完整路径
- 下载失败时说明原因

**下载失败处理（流程内）：**
1. 告知用户哪些论文下载失败
2. 说明 Claude 是否能读到该论文的摘要
3. 请用户将 PDF 放入 `docs/papers/`，文件名为论文完整标题
4. 若用户未提供 PDF 且 Claude 有摘要：创建 `docs/papers/{论文完整标题}.txt` 存入摘要
5. 若用户未提供 PDF 且 Claude 无摘要：在引用处标注 `⚠️ [低置信度：PDF 不可用，摘要也不可用]`

---

## 阶段 A：方向探索

### 触发

用户输入 `/research "研究方向描述"` 或 `/research --papers ...`。

若用户仅输入 `/research`（无内容），回复：
```
请告诉我你想研究的方向，例如：
/research "我想做电池 SOH 预测，现有 Transformer 方法没有利用局部特征"
```

### 确认卡片（阶段 A / B 通用）

阶段 A 和阶段 B 的每一次输出，开头都先输出"已确认内容卡片"，让用户随时看到当前已锁定的共识。格式如下：

```
━━━━━━━━━━ 已确认内容 ━━━━━━━━━━
研究方向：{已确认的研究方向一句话描述}
主 RQ：{已确认的主 RQ}
次 RQ：{已确认的次 RQ}
方向约束：{用户对研究方向提出的约束}
RQ 约束：{用户对研究问题提出的约束}
参考论文：{用户明确点名要参考的论文}
技术框架：{阶段 B 已确认的技术框架，一句话}
Pipeline：{阶段 B 已确认的 pipeline，一句话}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**卡片规则**：
- **仅输出已确认且非空的字段行，未确认或无内容的字段整行省略**——不写"待确认""无"等占位文字
- 若当前还没有任何已确认内容（流程最开始），则不输出卡片
- 字段不加粗，保持纯文本，对齐美观；上下用 `━` 横线包裹
- 技术框架、Pipeline 两行仅在阶段 B 出现；阶段 A 不显示
- 卡片只放"已被用户确认"的内容，未确认的方向/RQ 候选不进卡片
- 卡片不含详细文献检索清单（那是过程性内容）；仅当用户明确点名某篇论文作为必读参考时，才列入"参考论文"
- 卡片内容与 `docs/user_requirements.md` 阶段 A 章节保持同步（见 `references/user-requirements-template.md`）
- 每次确认新内容后，先更新 `user_requirements.md`，再在下一次输出顶部刷新卡片

### A-1 解析输入，收集需求

从用户输入中提取：研究方向、已有想法、参考论文、约束。

若输入信息不足，一次性提问（不分多轮）：
```
在开始检索前，了解几点：
1. 你认为现有方法的核心问题是什么？
2. 你希望从哪个角度切入？
3. 有没有特别想参考的论文？
4. 有其他约束吗？（如：必须单卡运行）
```

收集后写入 `docs/user_requirements.md` 阶段 A 章节（区分方向约束 / RQ 约束）。

### A-2 初步文献检索

**优先检索顶会/顶刊**：NeurIPS、ICML、ICLR、CVPR、ECCV、ICCV、ACL、EMNLP、KDD、IEEE TII、IEEE TNNLS 等。
可下载 arXiv 版本，但以正式发表信息为准。

**搜索自反思**：检查每个 research gap 是否有 ≥2 篇论文支撑，不足则补充检索（最多 3 轮）。

**目标：不少于 15 篇有效文献。**

若 3 轮检索后仍不足 15 篇，在向用户展示下载清单时说明原因：
```
注：本方向文献较少，当前共检索到 {N} 篇（目标 15 篇），原因：{领域较新 / 跨领域交叉 / 关键词覆盖有限}。
是否以现有 {N} 篇继续，还是希望我调整检索策略？
```
等待用户确认后再继续。

### A-3 向用户确认下载清单

```
初步检索完成。以下论文建议下载（可增删）：

| # | 标题 | 发表信息 | arXiv 版本 | 内容 | 下载原因 |
|---|-----|---------|-----------|------|---------|
| 1 | {标题} | {Venue Year} | {ID 或 无} | {一句话说明该论文做了什么} | {一句话说明与当前研究方向的关联} |
...

有 arXiv 版本的将自动下载，无 arXiv 版本的需手动提供。
确认下载请回复"确认"或直接说明修改意见。
```

### A-4 执行下载，反馈结果

批量执行下载逻辑，完成后反馈：
```
下载结果：
✅ {标题}.pdf
✅ {标题}.pdf
❌ {标题}（无 arXiv 版本，Claude 能读到摘要 / 不能读到摘要）
   → 如需补全，请将 PDF 放入 docs/papers/，文件名为论文完整标题
```

若有下载失败，询问用户是否手动补全，然后继续。

### A-5 锚定问题域，逐个确认研究方向

> 本步骤目标：与用户充分交互，逐个收敛到 1 个明确的研究方向。不一次性抛出 5 个方向让用户选，而是引导用户逐步确认。

**第一步：问题域汇报**。基于已下载文献，从三个维度向用户汇报，帮助用户建立全局认知：
```
{确认卡片}

我已通读检索到的文献，这个方向目前的全貌如下：

**① 主要在解决什么问题**：{该方向的核心任务和目标}
**② 主流方法分为哪几类**：{方法大类划分，每类一句话}
**③ 近两年最活跃的子方向**：{2-3 个正在升温的子方向}

你最感兴趣 / 最想深入的是哪一块？或者你心里已经有更具体的切入点？
```

**第二步：候选方向逐个讨论**。根据用户兴趣，一次聚焦 1-2 个候选方向深入讨论（核心思路、文献依据、创新角度、主要挑战、新颖性初判），与用户来回交互，直到用户明确选定一个方向。

**第三步：锁定方向**。用户确认后，将该方向写入 `user_requirements.md`，并在下一次输出的确认卡片"研究方向"栏填入。

### A-6 逐个提炼并确认 RQ

> 研究方向锁定后，进入 RQ 提炼。同样逐个确认，不一次性堆出全部 RQ。

**第一步：gap → RQ 推导**。基于确认的方向，从文献 gap 中推导候选 RQ，**一次提出一个主 RQ 候选**，附：
- 对应哪个具体 gap（引用支撑论文）
- 新颖性核查（专项搜索结果：已有 / 部分有 / 空白）
- 可回答性（能否在一篇论文实验范围内回答）

与用户讨论这个主 RQ，可改写 / 合并 / 替换，直到用户确认主 RQ。

**第二步：补充次 RQ**。主 RQ 确认后，按同样方式逐个提出次 RQ（1-3 个），每个都与用户确认。

**第三步：锁定 RQ**。每确认一个 RQ，立即写入 `user_requirements.md` 并刷新确认卡片。

**第四步：必要性论证**。所有 RQ 确认后，针对选定 RQ 撰写必要性论证（应用 / 理论 / 时机三点，分点回答，每点附论文支撑），与用户确认论证成立。

### A-7 进入阶段 B

研究方向、全部 RQ、必要性论证均确认后，主动询问：
```
{确认卡片}

研究方向和 RQ 都已锁定，必要性论证也已成立。
我现在可以汇编 Part 1（Motivation / Research Questions / Key Works），然后进入 idea 深化阶段。
是否继续？或还有需要补充的？
```

用户确认后，汇编 Part 1（见 B-1），进入阶段 B。

---

## 阶段 B：Idea 深化

### 触发

阶段 A 用户确认方向后自动进入。

> 阶段 B 已明确研究方向和 RQ，目标是把"研究问题"深化为"可实现的方法"。**每一次输出同样以确认卡片开头**（阶段 B 的卡片在阶段 A 基础上增加"已确认技术框架"和"已确认 pipeline"两栏）。深化分三层逐步确认：技术框架 → 详细 pipeline → Introduction 精修。

### B-0 汇编 Part 1

阶段 A 确认的内容直接汇编为 `idea_report.md` Part 1，不重新生成：
- `### 1 Motivation`：方向背景与研究动机，引用关键论文；**末尾必须有"本研究的必要性"分点段落**（应用/理论/时机三点，每点附论文支撑）
- `### 2 Research Questions`：引导性陈述 + 主 RQ（1 个）+ 次 RQ（1–3 个）；每个 RQ 标注对应 gap、新颖性、可回答性
- `### 3 Key Works`：**先输出汇总表格**（简称 / 会议·期刊 / 年份 / 核心贡献一句话 / 借鉴价值），再逐篇输出详细条目；5–8 篇，不局限于 SOTA

汇编完成后展示 Part 1 供用户审阅，确认无误再进入 B-1。

### B-1 确认技术框架（第一层）

> 目标：先和用户对齐"用什么大方向的技术来回答 RQ"，不涉及实现细节。

向用户提出整体技术框架：
```
{确认卡片}

针对已确认的 RQ，我设想的技术框架如下：

**整体思路**：{一段话，说明用什么核心技术回答 RQ，对应哪个创新点}
**框架草图**：
{输入 → [模块A：作用] → [模块B：作用] → 输出 —— 用 text 流程图}
**每个模块解决什么**：
- 模块A：{对应 RQ 的哪一部分}
- 模块B：{...}

这个技术框架方向对吗？哪些模块需要调整？
```

与用户来回交互，直到框架确认。确认后将框架写入确认卡片"已确认技术框架"栏。

### B-2 确认详细 pipeline（第二层，大白话）

> 目标：把框架细化为可执行的完整流程。**输出必须是大白话，用"第一步…第二步…"逐步讲清每个环节在做什么，不堆砌公式。**

```
{确认卡片}

技术框架确认后，完整 pipeline 是这样运作的（先讲清流程，公式留到写文档时）：

**第一步**：{输入是什么，怎么处理，产出什么——用日常语言}
**第二步**：{...}
**第三步**：{...}
...

每一步为什么这样设计：{对应的直觉理由}

这个流程有没有缺漏或不合理的地方？
```

与用户来回交互，直到 pipeline 确认。确认后写入确认卡片"已确认 pipeline"栏。

此后才落笔 Part 2 的 Method 章节：
- `### 1 Introduction`：暂留占位，B-4 精修
- `### 2 Related Works`：归纳现有做法，最后一节固定为"研究空白"
- `### 3 Method`：基于已确认 pipeline 撰写详细理论框架，3.2 为大白话流程详解（与已确认 pipeline 一致），3.3+ 为对应的理论/公式表述，每个公式用 `>` 解释，最后一节固定为 Baseline 参考与评价指标（必须有论文依据）

大量使用 `>` 解释每一步的设计理由、文献支撑和来源依据。生成过程中若需要更多论文支撑：检索 → 确认下载清单 → 下载 → 继续。

### B-3 引用内容核验

对所有来源批注（`>` 后跟引用编号的行）：
1. 打开 `docs/papers/{标题}.pdf`（或 `.txt`）
2. 定位支撑段落，追加原文：
   ```
   > 本设计受 [3] 启发。[3]
   > 原文依据："..." (Section 3.1)
   ```
3. 无法核验时追加 `⚠️ [低置信度：PDF 不可用]`，并登记待核实清单。

### B-4 Introduction 精修（第三层）

> Method 确认后，最后专门打磨 Introduction，使其达到可投稿质量。

按论文风格撰写 Introduction（无子标题，从领域重要性 → 现有方法局限逐条引用 → 本文动机 → 方法概述 → 分点贡献），输出后询问：
```
{确认卡片}

Introduction 已按论文风格精修，你看这个开篇的逻辑和力度是否到位？
需要加强哪一部分（背景铺垫 / 局限论证 / 贡献提炼）？
```

与用户来回交互，直到 Introduction 确认。

### B-5 进入阶段 C

技术框架、pipeline、Method、Introduction 均确认后，主动询问：
```
{确认卡片}

idea 已深化完整（技术框架 → pipeline → Method → Introduction 全部确认）。
是否进入实验设计阶段？或还有需要调整的？
```

用户确认后，进入阶段 C。

---

## 阶段 C：实验设计

### 触发

阶段 B 用户确认 idea 后自动进入。

### C-1 收集实验约束

询问用户（若尚未在对话中提及）：
```
在设计实验前，确认几点：
1. GPU 配置？（型号 + 显存）
2. 单次训练时间限制？
3. 数据集有偏好，还是让我推荐？
4. 实验有特别侧重的部分吗？
```

写入 `docs/user_requirements.md`。

### C-2 Baseline 文献与代码精读

从 `idea_report.md` Part 2 Method 章节中提取所有选定的 baseline，向用户展示精读计划并请求确认：

```
在设计实验之前，我打算精读以下 baseline 的论文和代码仓库，
以了解它们如何设计实验，避免实验设计与领域惯例脱节：

| # | Baseline | 论文 | GitHub | 精读目的 |
|---|---------|------|--------|---------|
| 1 | {名称} | {标题} [n] | {repo 链接 或 暂未找到} | {一句话：为什么读这个——它代表了哪类方法，或实验设计有什么参考价值} |
| 2 | {名称} | ... | ... | ... |

确认后我将逐一读取，整理为 Part 3 第 0 节。
```

等待用户确认（可补充或删减列表）。

确认后，对每个 baseline 执行：
1. 下载论文 PDF（已在 `docs/papers/` 中的直接读取，否则按论文下载逻辑获取）
2. 读取 GitHub README 及核心训练脚本（若仓库可访问）
3. 从论文和代码中提取：
   - 使用了哪些数据集，如何划分（比例 / 官方划分 / 交叉验证）
   - 设计了哪些实验（主实验、消融、附加），每个实验的目的
   - 对比了哪些模型，模型选取逻辑
   - 使用了哪些评估指标，计算方式
   - 关键超参数设置（batch size、lr、训练轮数等）

提取完成后，向用户展示摘要确认无误，再进入 C-3。

### C-3 检索领域实验惯例

搜索同领域近 3 年论文，结合 C-2 的精读结果，归纳：
- 各 baseline 共同使用的数据集（视为该领域标准 benchmark）
- 各 baseline 共同使用的评估指标（视为领域标准指标）
- 消融实验的典型设计模式（哪些组件通常需要消融）
- 结果表格规范（是否报告标准差、是否多次运行取均值）

### C-4 可行性核实

检查三项（任一不通过，暂停并告知用户）：
- **数据集**：下载链接可访问，权限公开，数据量匹配
- **Baseline 代码**：仓库可访问，框架兼容，无代码则标注"需自行实现"
- **硬件**：估算显存是否满足，不满足则建议调整

可行性摘要写在 Part 3 第 0 节末尾：
```markdown
### 可行性核实摘要
| 项目 | 状态 | 备注 |
|------|------|------|
| 数据集 {名称} | ✅/⚠️/❌ | {说明} |
| Baseline {名称} 代码 | ✅/⚠️/❌ | {说明} |
| GPU 显存 | ✅/⚠️ | 估算 {N}GB，用户有 {M}GB |
```

### C-5 生成 idea_report.md Part 3

按 `references/document-formats.md` 中的 Part 3 模板生成，追加到 `idea_report.md` 末尾。

第 0 节（Baseline 实验调研）直接由 C-2 精读结果填入，第 1 节起的实验设计基于第 0 节归纳的领域惯例展开。每个实验设计决策用 `>` 说明理由，有论文依据的附引用编号。

### C-5 每次输出后询问确认

```
实验设计已生成。你觉得现在的实验方案够完善了吗？
如果可以，我们进入实现设计阶段，生成详细的编码指南。
或者你有什么需要调整的地方？
```

### C-6 迭代优化（循环）

用户提出修改后，更新 Part 3 内容，重新询问确认。
用户确认后，进入阶段 D（见 `references/phase-implementation.md`）。
