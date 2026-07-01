# 阶段 A 详细流程：方向探索与调研

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

## 文献阅读原则（贯穿 idea 生成与每一次调整）

> 本原则适用于**初次生成 idea** 以及**后续任何一次对 idea 的调整**（含从阶段 D/E 回溯而来的调整，见 `phase-implementation.md` 回溯流程）。

每一次动笔 / 改写 idea 之前，都必须**大量阅读现有文献**：

- **优先读已下载，先不急于下载新论文**：先精读 `docs/papers/` 中已有的相关论文，把它们读透作为设计依据。
- **不够再下载**：当发现现有文献**无法支撑当前的设计决策、或无法回答新出现的问题**时，再重新走"论文下载逻辑"（检索 → 向用户确认下载清单 → 下载 → 精读），把新论文纳入 `docs/papers/`。
- 每一条关键设计决策都应有文献支撑，来源用 `>` 标注引用编号；无支撑的论断登记待核实清单或标注低置信度。

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

### A-4.5 询问是否需要逐篇详细介绍论文

下载完成后（含用户手动补全的论文），考虑到用户可能尚未读过其中部分论文，主动询问是否需要 Claude 对每篇论文做详细介绍：
```
论文已全部下载完成。其中有些论文你可能还没读过。
需要我对每篇论文做一个详细介绍吗？如果需要，我会逐篇说明四点：
1. 解决了什么研究问题；
2. 用了什么方法、为什么这样设计；
3. 这个方法的效果如何；
4. 这篇论文对我们的研究有什么意义。

（无论你是否需要详细介绍，Part 1 Key Works 下方的逐条论文都会收录你下载的**全部论文**，并各自标明它是不是关键工作。）

回复"需要"或"不需要"。
```
将用户的选择（需要 / 不需要逐篇详细介绍）记入 `docs/user_requirements.md` 阶段 A 章节，供 B-0 汇编 Key Works 时使用。

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

### A-6 逐层提炼并确认 RQ

> 研究方向锁定后，进入 RQ 提炼。RQ 分三层，层层递进，依次确认，不一次性堆出全部。

**三层 RQ 的定义与关系**：

| 层次 | 名称 | 回答什么 | 对应实验 |
|------|------|---------|---------|
| RQ1 | 核心问题 | 我在解决什么大问题（领域痛点） | 主实验 |
| RQ2 | 机制问题 | 为什么现有方法做不好（关键瓶颈在哪） | 消融实验 |
| RQ3 | 边界问题 | 方法在什么条件下有效，局限在哪 | 附加实验（可选）|

> RQ1 定义研究目标，RQ2 是 Method 设计的直接依据，RQ3 让论文更严谨。三者缺一则论文论证链条不完整。

---

**第一步：确认 RQ1（核心问题）**

RQ1 是一个大问题，直接定义整个研究的目标，读者看到就能理解论文在解决什么。形式：一个完整的大问句，对应领域痛点。

```
{确认卡片}

基于已确认的研究方向，我提出以下核心问题（RQ1）：

**RQ1：{一个大问句，直接描述领域痛点，如"如何提高电池 SOH 预测精度？" "如何提升 RAG 系统的检索精度？"}**

- 对应 gap：{指向哪个具体局限，引用支撑论文 [n]}
- 新颖性：{专项搜索结果——现有工作是否已完整回答这个问题}
- 可回答性：{这个大问题能否在一篇论文范围内被证明，通过什么主实验验证}

这个核心问题的表述是否准确？
```

与用户来回交互，直到 RQ1 确认。确认后写入 `user_requirements.md` 并刷新确认卡片。

---

**第二步：确认 RQ2（机制问题）**

RQ2 是对 RQ1 的深度分析：**为什么现有方法做不好**，具体是哪个机制或特性是瓶颈。RQ2 直接决定 Method 的设计逻辑——回答它就是在说"我的方法为什么能解决 RQ1"。

```
{确认卡片}

RQ1 确认后，进一步分析：为什么现有方法无法很好地回答 RQ1？我提出机制问题（RQ2）：

**RQ2：{一个机制分析问句，如"局部时序特征是否是 SOH 预测精度的关键瓶颈？" "查询与文档的语义鸿沟对检索精度影响有多大？"}**

- 与 RQ1 的关系：{说明 RQ2 如何解释了 RQ1 中的核心障碍——回答 RQ2 就为解决 RQ1 提供了设计依据}
- 对应 gap：{现有工作是否分析过这个机制，引用支撑论文 [n]}
- 对应实验：{通过哪类消融实验验证——如去掉某模块、对比不同设计选择}

这个机制问题是否准确抓住了现有方法的核心瓶颈？
```

与用户来回交互，直到 RQ2 确认。确认后写入 `user_requirements.md` 并刷新确认卡片。

---

**第三步：确认 RQ3（边界问题，可选）**

RQ3 追问方法的适用边界、泛化性或额外贡献，对应附加实验。若研究范围较窄或工作量已足够，RQ3 可省略。

```
{确认卡片}

可选：是否需要追问方法的边界问题（RQ3）？

**RQ3 候选：{一个边界/泛化问句，如"提出的局部特征模块在不同电池化学体系下是否泛化？" "查询改写策略在不同领域知识库上是否稳定有效？"}**

- 与 RQ1/RQ2 的关系：{说明 RQ3 是对结论适用范围的追问，让整体论证更严谨}
- 对应实验：{通过哪类附加实验验证}

是否需要 RQ3？如果研究范围已经足够聚焦，也可以不设。
```

与用户确认是否纳入 RQ3。若纳入则写入 `user_requirements.md`；若不纳入则跳过。

---

**第四步：必要性论证**

所有 RQ 确认后，撰写必要性论证（应用 / 理论 / 时机三点，每点附论文支撑），与用户确认论证成立。

### A-7 汇编 Part 1，提交用户审核，引导进入阶段 B

研究方向、全部 RQ、必要性论证均确认后，汇编写入 `idea_report.md` Part 1：

- `### 1 Motivation`：方向背景与研究动机，引用关键论文；末尾必须有"本研究的必要性"分点段落（应用/理论/时机三点，每点附论文支撑）
- `### 2 Research Questions`：引导性陈述 + 三层 RQ（RQ1 核心问题 / RQ2 机制问题 / RQ3 边界问题可选）；每个 RQ 标注对应 gap、新颖性/机制分析、对应实验
- `### 3 Key Works`：汇总表格（5–8 篇关键工作）+ 逐条论文（收录全部已下载论文，遵从 A-4.5 选择的详略）

汇编完成后展示 Part 1 完整内容，主动询问用户审核：

```
{确认卡片}

idea_report.md Part 1 已汇编完成，请审核：

**Motivation**：{已写内容摘要}
**Research Questions**：RQ1 / RQ2 / RQ3（若有）
**Key Works**：共 {N} 篇，其中关键工作 {N} 篇

你觉得 Part 1 的内容准确、完整吗？有需要调整的地方吗？
确认后我们进入 Idea 深化阶段。
```

用户确认 Part 1 无误后，引导进入阶段 B：

```
Part 1 已确认。

→ 请使用 `/research[B]-idea` 进入 Idea 深化阶段。
```
