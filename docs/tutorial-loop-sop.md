# Tutorial Illustration Loop Engineering 操作指南 (SOP)

**版本**：v1.0  
**日期**：2026-06-15  
**适用场景**：使用 Claude 桌面版 + Codex（ChatGPT 桌面版）进行教程图文混排配图的迭代协作  
**核心理念**：Loop Engineering —— 不是手动指挥两个模型，而是通过这份 SOP 让 Claude 作为 Orchestrator 设计并驱动一个可自我迭代的闭环。  
**不使用 OpenClaw 的原因**：双方均为桌面应用，无法通过命令行高效协同，本 SOP 提供纯聊天界面 + 共享本地文件夹的完整解决方案。

---

## 1. 项目目标（Goal Definition）

**最高层目标**：  
为教程的每一个 section 产出高质量、风格一致、传达清晰的配图，并嵌入 Markdown，整体视觉专业统一，最终形成可直接发布的图文混排教程。

**每张图片 / 每个 section 的可验证完成标准（必须全部满足才算通过）：**

- 视觉 Critic（Claude）综合评分 ≥ 8.5/10
- 完全符合《STYLE-GUIDE.md》中的全局视觉规范
- 清晰、准确传达当前 section 的核心概念，无歧义或误导
- 文字 overlay 可读性高（对比度、字号、布局合理）
- 构图平衡、重点突出、留白恰当
- 图片已正确嵌入对应 Markdown 文件，并配有准确 caption
- 无 blocking 问题（风格漂移、低质、文字错误、与上下文矛盾等）
- 迭代轮次 ≤ 4 轮（超过需 human escalation）

**失败降级方案**：  
若 4 轮后仍未达标，Claude 必须输出详细问题分析 + 建议的人工介入点，并暂停 loop 等待用户确认。

---

## 2. 项目文件夹结构（State Management）

推荐在 Obsidian 或本地文件夹中建立以下结构（强烈建议用 Obsidian 作为 shared blackboard）：

```
tutorial-project/
├── content/                  # 各章节原始/丰富后的内容
│   └── section-01-xxx.md
├── images/                   # 所有生成的图片
│   ├── section-01-fig-01-v1.png
│   ├── section-01-fig-01-v2.png
│   └── ...
├── TUTORIAL-STATUS.md        # 全局进度追踪（必须实时更新）
├── STYLE-GUIDE.md            # 全局视觉风格指南（核心 Harness）
├── section-当前处理中.md     # 当前正在迭代的章节工作文件
└── images-progress.md        # 每张图的版本、评分、批准记录
```

**状态文件规范**：
- 所有状态更新必须由 Claude 精确指示用户在哪个文件追加/修改什么内容。
- 图片命名严格遵守：`section-XX-fig-YY-vN.png`（vN 为迭代版本）。
- 每张图在 `images-progress.md` 中记录：版本、prompt 摘要、critic 分数、批准状态、问题列表。

---

## 3. 全局 Harness（约束与护栏）—— STYLE-GUIDE.md

**请用户先根据自己的教程主题填写或完善以下模板**（这是整个 loop 的护栏，Claude 和 Codex 必须严格遵守）：

```markdown
# STYLE-GUIDE.md（全局视觉风格指南）

## 整体风格
- Clean technical illustration / modern minimal
- 主色调：#1E3A8A（深蓝）+ #F97316（橙色强调）
- 辅助色：中性灰 #64748B，背景白或极浅灰
- 字体：系统 sans-serif（Inter / SF Pro / PingFang SC），标题加粗

## 构图原则
- 信息优先：最重要元素居中或左上
- 留白充足，避免拥挤
- 一致的视觉层次（标题 > 正文 > 标注）
- 适合教程阅读的横向或正方形比例（优先 16:9 或 4:3）

## 文字 overlay 规则
- 必须高对比度（深色背景用白字，浅色背景用深字）
- 字号适中（主标题 24-32pt，标注 14-18pt）
- 最多 2-3 行短句，避免长文本
- 英文 + 中文双语时，中文为主，英文为辅

## 禁止事项（Boundary Conditions）
- 严禁风格漂移（每张图必须与之前已批准的图片保持高度一致）
- 严禁低对比度文字或模糊元素
- 严禁添加与 section 内容无关的装饰
- 严禁生成写实照片风格（除非教程明确需要）
- 严禁文字错误或与上下文矛盾
- 严禁过度拟人化或情绪化图标（保持专业技术感）

## 一致性要求
- 整套教程使用相同 icon 系统 / 配色 / 人物风格（如有 recurring character）
- 流程图、架构图、示意图必须使用统一视觉语言
```

Claude 在每次生成 prompt 前必须先读取并严格遵循此文件。

---

## 4. 角色定义（Sub-agents）

**Claude 的角色（Orchestrator + 多重身份）**：
- Loop Orchestrator（最高层调度）
- Content Enricher（丰富教程内容）
- Prompt Engineer（为 Codex 生成极致详细的图片 prompt）
- Vision Critic & Refiner（上传图片后进行视觉审核 + 给出精准修改建议）
- State Updater（精确告诉用户如何更新 Markdown 和状态文件）

**Codex 的角色（Image Generator）**：
- 仅负责根据 Claude 提供的精确 prompt 生成图片
- 输出图片 + 简要描述（可选）
- 不参与内容规划或审核

**用户角色**：
- 提供原始 section 内容
- 在 Claude 和 Codex 之间复制粘贴 prompt / 图片
- 执行 Claude 指示的文件更新操作
- 在关键节点进行最终人工审核（Human Gate）

---

## 5. 完整 Loop 流程（Step-by-Step Protocol）

### 启动新 Section（用户操作）
1. 在 `content/` 文件夹新建或打开 `section-XX-主题.md`
2. 把该 section 的**原始内容** + 想配的图数量/类型 复制给 Claude
3. 告诉 Claude：“开始处理 section-XX，按照 SOP 执行 Loop”

### Claude 执行步骤（必须严格按顺序）

**Step 1: 规划与丰富内容**
- 读取 STYLE-GUIDE.md 和 TUTORIAL-STATUS.md
- 丰富/优化 section 文字内容（使之更适合配图）
- 决定需要配几张图、每张图的类型和位置
- 输出：丰富后的 section 内容 + 图片规划列表

**Step 2: 为每张图生成详细 Prompt**
- 为每张图写出**极致详细**的 prompt（构图、风格、文字、颜色、参考元素、一致性要求）
- Prompt 必须引用 STYLE-GUIDE.md 的关键规则
- 输出格式严格使用下方 Handoff 模板

**Step 3: 指示用户把 Prompt 丢给 Codex**
- 明确告诉用户：“请把下面这段 prompt 复制到 Codex 桌面版生成图片”
- 生成后把图片保存到 `images/section-XX-fig-YY-v1.png`

**Step 4: 视觉审核（用户上传图片后）**
- 用户把生成的图片上传到 Claude 聊天
- Claude 使用 vision 能力进行审核
- 输出结构化 review（见下方模板）

**Step 5: 决策与迭代**
- 如果 approved：输出“Approved v1”，指示用户更新状态文件和 Markdown 嵌入
- 如果需要迭代：输出 refined prompt（v2），重复 Step 3-4，最多 4 轮
- 每轮必须在 `images-progress.md` 记录

**Step 6: Section 完成与一致性检查**
- 所有图片 approved 后，Claude 执行类似 “neat-freak” 的检查
- 确认整套图片与之前 section 风格一致
- 输出最终 section Markdown（含图片嵌入）
- 更新 TUTORIAL-STATUS.md

**Step 7: Human Gate（可选但推荐）**
- 重要 section 或第一张图后，Claude 主动要求用户确认方向后再继续

---

## 6. Handoff 模板（必须严格使用）

### 6.1 Claude → Codex 的 Prompt 模板

```
【Codex 图片生成任务 - Section XX - Fig YY vN】

请严格按照以下详细描述生成一张高质量插图：

[在这里粘贴极致详细的 prompt，包括：
- 整体风格与构图
- 具体元素、布局、颜色
- 文字 overlay 内容和样式（必须引用 STYLE-GUIDE）
- 一致性要求（参考已批准的图片风格）
- 技术细节（线条粗细、阴影、透视等）]

生成要求：
- 风格必须专业、技术、干净
- 文字必须清晰可读
- 输出图片后请简单描述你理解的重点

直接生成图片即可。
```

### 6.2 Claude 视觉审核输出模板（Review）

```
【图片审核报告 - Section XX - Fig YY vN】

评分：X.X / 10

优点：
- ...

问题与改进建议（按优先级）：
1. ...
2. ...

决策：
- [ ] Approved（可直接使用）
- [ ] 需要迭代（vN+1）
  - 精炼后的 Prompt（直接可复制给 Codex）：
    [完整新 prompt]

状态更新建议：
请用户在 images-progress.md 中追加以下记录：
...
```

---

## 7. 迭代与收敛规则

- 每张图最多迭代 **4 轮**
- 每轮必须有结构化 review 和新 prompt
- 第 4 轮仍未达标 → Claude 必须：
  1. 输出详细失败分析
  2. 建议的人工修改方向
  3. 暂停并请求用户介入
- 收敛条件：Critic 评分 ≥ 8.5/10 + 无 blocking 问题 + 符合 Harness

---

## 8. 启动新 Section 的完整提示词（用户直接复制给 Claude）

```
你现在是 Tutorial Illustration Loop 的 Orchestrator。
请严格按照 /home/workdir/artifacts/Tutorial_Illustration_Loop_Engineering_SOP.md 中的所有规则执行。

当前任务：处理 section-XX-主题
原始内容如下：
[粘贴原始内容]

请开始执行完整的 Loop 流程。
```

---

## 9. 注意事项与最佳实践

- **图片上传**：Claude 桌面版支持直接拖拽图片进行 vision 审核，建议每次只上传 1 张图以便精准 review。
- **状态文件**：Claude 每次必须给出**精确的追加/修改指令**（复制粘贴即可执行）。
- **一致性**：处理新 section 时，Claude 必须先回顾已批准图片的风格。
- **Token 管理**：长 section 可分段处理；review 时可要求 Claude 先总结再 review。
- **备份**：重要状态文件建议 git 管理或定期备份。
- **风格指南迭代**：如果发现 STYLE-GUIDE 有遗漏，Claude 可建议更新，但需用户确认。

---

## 10. 为什么这个 SOP 有效（Loop Engineering 原理）

- **清晰可验证 Goal**：取代模糊的“配几张图”
- **Harness（约束）**：STYLE-GUIDE + 禁止事项防止 Agent 钻空子
- **Sub-agents 分工**：Claude 负责思考与审核，Codex 专注生成
- **State 管理**：Markdown 文件作为持久记忆和黑板
- **迭代闭环**：自动 review → refine → re-generate，直到达标
- **Human-in-the-loop**：关键节点保留人工把关

这正是文章中强调的：**定义目标 + 设计 loop + 约束先行**，而不是一次次手动指挥。

---

**使用方法**：
1. 把本文件保存到你的 tutorial-project 根目录
2. 先完善 `STYLE-GUIDE.md`
3. 建立好文件夹结构
4. 把上面“启动新 Section 的完整提示词” + 原始内容丢给 Claude
5. 按照 Claude 的指示在 Claude 和 Codex 之间来回操作即可

需要我根据你的具体教程主题（例如 AI Agent、Loop Engineering 本身、或其他）进一步定制 STYLE-GUIDE 示例、增加特定图类型模板、或调整任何部分，请随时告诉我。

这个 SOP 一旦跑顺，你以后做任何教程配图都会变得系统化、高效、一致性极强。

准备好开始第一个 section 了吗？把第一个 section 的内容发给我，我可以帮你测试跑一遍完整 loop。