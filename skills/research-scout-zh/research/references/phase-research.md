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

### A-1 解析输入，收集需求

从用户输入中提取：研究方向、已有想法、参考论文。

若输入信息不足，一次性提问（不分多轮）：
```
在开始检索前，了解几点：
1. 你认为现有方法的核心问题是什么？
2. 你希望从哪个角度切入？
3. 有没有特别想参考的论文？
4. 有其他约束吗？（如：必须单卡运行）
```

收集后写入 `docs/user_requirements.md`。

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

### A-5 提出5个idea方向

基于已下载的论文，提出 5 个 idea 大方向。每个方向需有一定篇幅：

```
基于文献分析，以下是 5 个研究方向供参考：

### 方向 1：{标题}
**核心思路**：{2-3 句描述，说明这个方向要解决什么问题、用什么思路}
**文献依据**：{支撑这个方向的关键论文及其核心发现}
**创新角度**：{方法迁移 / 现有方法改进 / 任务重构}
**主要挑战**：{实现这个方向的核心难点}
**新颖性初判**：{与现有工作的主要差异，相似度：高/中/低}

### 方向 2：...
...
```

然后询问：
```
你对哪个方向感兴趣？或者有其他想法？
可以选择一个方向，或告诉我需要调整的地方。
```

### A-6 迭代优化（循环）

用户选择或提出修改后：
1. 若需要更多文献支撑：重新检索 → 确认下载清单 → 下载 → 更新方向描述
2. 若方向需要调整：根据用户建议修改方向内容
3. 每次输出后主动询问：

```
现在的方向描述是否足够完善？
如果可以，我们进入下一阶段，开始构建详细的 idea。
或者你有什么需要补充调整的？
```

4. 用户确认后，进入阶段 B。

---

## 阶段 B：Idea 深化

### 触发

阶段 A 用户确认方向后自动进入。

### B-1 构建 idea_report.md Part 1 + Part 2

按 `references/document-formats.md` 中的模板生成文档。

**Part 1 Topic Overview**（直接由阶段 A 四轮交互内容汇编，不重新生成）：
- `### 1 Motivation`：方向背景与研究动机，引用关键论文；**末尾必须有"本研究的必要性"分点段落**（应用/理论/时机三点，每点附论文支撑）
- `### 2 Research Questions`：引导性陈述 + 主 RQ（1 个）+ 次 RQ（1–3 个）；每个 RQ 标注对应 gap、新颖性、可回答性
- `### 3 Key Works`：**先输出汇总表格**（简称 / 会议·期刊 / 年份 / 核心贡献一句话 / 借鉴价值），再逐篇输出详细条目；5–8 篇，不局限于 SOTA

**Part 2 Idea Design**：
- `### 1 Introduction`：严格论文风格，无子标题，从大到小，最后分点贡献
- `### 2 Related Works`：归纳现有做法，最后一节固定为"研究空白"
- `### 3 Method`：详细理论框架，每个公式用 `>` 解释，最后一节固定为 Baseline 参考与评价指标（必须有论文依据）

大量使用 `>` 解释每一步的设计理由、文献支撑和来源依据。

生成过程中若需要更多论文支撑：自动执行检索 → 向用户确认下载清单 → 下载 → 继续生成。

### B-2 引用内容核验

对所有来源批注（`>` 后跟引用编号的行）：
1. 打开 `docs/papers/{标题}.pdf`（或 `.txt`）
2. 定位支撑段落，追加原文：
   ```
   > 本设计受 [3] 启发。[3]
   > 原文依据："..." (Section 3.1)
   ```
3. 无法核验时追加 `⚠️ [低置信度：PDF 不可用]`，并登记待核实清单。

### B-3 每次输出后询问确认

每次生成或修改后：
```
idea 的详细描述已更新。你觉得现在的 idea 够完善了吗？
如果可以，我们进入实验设计阶段。
或者你有什么需要调整的地方？
```

### B-4 迭代优化（循环）

用户提出修改建议后：
1. 若需要新论文：检索 → 确认下载清单 → 下载 → 更新文档
2. 若仅需调整内容：直接修改并重新输出相关章节
3. 重新询问确认

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
