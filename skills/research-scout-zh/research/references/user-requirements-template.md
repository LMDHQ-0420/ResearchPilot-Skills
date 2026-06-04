# user_requirements.md 模板

本文件由 Claude 在第一阶段开始时创建（如不存在）。
用户填写内容；Claude 在每个阶段开始前读取对应章节。

**规则：**
- Claude 绝不将本文件中的内容复制到 `idea_report.md`、`dev_log.md` 或 `code_guide.md` 中
- 主文档只展示结果；本文件保存用户的原始输入
- 用户可在任意阶段章节中追加 `### Document Preferences` 字段
- 如果某字段不适用，填写"none"——不要留空

---

## 模板

```markdown
# User Requirements — {Topic}
> Created: {YYYY-MM-DD} | Project: {project_name}
> Claude reads the relevant phase section before each phase begins.
> Fill fields with your requirements, or write "none" if not applicable.

---

## Phase 1: Literature & Idea Requirements
> 确认论文/主题后填写。引导候选想法生成方向。

### Your understanding of this topic
{你对该研究问题的现有知识、判断或背景。
自由格式文本——想写多少就写多少。}

### Preferred research directions
{例如：轻量化方法 / 可解释性 / 跨域泛化 /
数据效率 / 实时推理 / 理论保证}

### Directions to avoid
{例如：已存在平行工作使该方向失去意义 /
需要大规模预训练 / 依赖私有或专有数据}

### Other constraints
{例如：必须在单张消费级 GPU 上运行 /
方法需要可部署在嵌入式硬件上}

### Document preferences (optional)
{例如：全英文 / 中文正文 + 英文标题（默认）/
Introduction 应为可投稿的详细版本，而非占位草稿 /
省略 code_guide.md 中的 Data Format 章节}

---

## Phase 2: Experiment Design Requirements
> 运行 /research step2 前填写。

### Hardware
{GPU 型号和数量，可用显存。
示例：RTX 3090 × 1，24GB 显存}

### Time constraints
{每次运行可接受的最长训练时间。
示例：单次训练必须在 12 小时内完成}

### Dataset preference
{指定要使用的数据集名称，或填写"let Claude recommend"}

### Experiment emphasis
{哪些方面的结果对你最重要。
示例：重点关注消融实验 A1 和 A2 / 强调效率对比 /
需要跨数据集泛化测试}

### Other constraints
{示例：不使用预训练权重 / 必须支持多 GPU DDP /
结果需要统计显著性检验并报告标准差}

---

## Phase 3: Coding Requirements
> 运行 /research step3 前填写。

### Programming language
{默认：Python。如有不同请指定。}

### Framework
{默认：PyTorch。可选：TensorFlow / JAX / scikit-learn / 其他}

### Code style
{示例：可读性优先 / 减少第三方依赖 /
需要 DDP 多 GPU 支持 / 需要 ONNX 导出}

### Based on existing project
{如果是在现有代码库上修改，提供本地路径或 GitHub URL。
否则填写"from scratch"。}

### Other requirements
{示例：包含详细使用示例的完整 README /
必须兼容 Windows / 需要 Docker 支持 /
代码应对初学者友好，包含大量注释}
```

---

## Claude 如何使用本文件

### 第一阶段
- 在生成候选想法前读取 `## Phase 1` 章节
- 偏好方向 → 优先匹配对应的想法角度
- 需要避免的方向 → 不在这些方向上生成候选
- 文档偏好 → 应用于本次会话中所有文档的生成

### 第二阶段
- 在设计实验前读取 `## Phase 2` 章节
- 硬件 → 用于可行性验证（GPU 显存检查）
- 时间约束 → 影响批量大小和训练轮数建议
- 数据集偏好 → 直接采用；填写"let Claude recommend"时触发领域规范搜索
- 实验侧重 → 影响消融设计和附加分析的选择

### 第三阶段
- 在设计项目结构前读取 `## Phase 3` 章节
- 框架 → 决定导入风格和训练循环约定
- 基于现有项目 → 触发策略 A；Claude 读取该项目的结构
- 代码风格 → 贯穿整个实现过程
