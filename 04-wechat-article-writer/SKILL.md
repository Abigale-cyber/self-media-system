---
name: wechat-article-writer
description: 按 content-outline 写公众号完整文章。当用户说"写文章"、"按大纲写"、"帮我写公众号"时使用。分两阶段：先出标题+确认大纲，再写全文。完稿后自动串联审稿。
---

# wechat-article-writer

## 母规则

**创作是对话。** 写每一个字之前，想清楚对面坐的是谁，他在想什么，他为什么要听你说下去。

**没有观点的内容是信息搬运。** 如果 outline 的核心判断站不住，先回去改 outline，不要硬写。

## 触发条件

- 用户说"写文章"、"按大纲写"、"帮我写公众号"
- 用户提供了 content-outline.md，要求写正文
- 用户说"帮我从选题到成稿走一遍"（由 self-media-system 编排时触发）

**不触发：**
- "整理大纲" / "生成 outline" → content-outline-builder
- "改标题"、"去AI味" → content-polisher
- "发草稿箱" → wechat-studio

## 不做什么

- 不做选题、不做 outline
- 不做包装改稿（标题优化、开头重写等由 content-polisher 负责）
- 不做发布

## 执行模式

| 模式 | 触发方式 | Step 2 行为 |
|------|---------|------------|
| 交互模式 | 直接对话调用 | 出标题+大纲，停下来等用户确认 |
| 自动模式 | 被 self-media-system 串联调用，或用户说"直接写" | 跳过确认，用 outline 大纲 + 评分最高的标题 |

## 执行流程

### Step 0: 读取定制配置

读取 `../_shared/knowledge-base-index.md`、`../_shared/emma-profile.md`、`../_shared/account-mode-guide.md`、`../_shared/style-guide.md` 和 `../_shared/extend-system.md`，检查项目级和用户级 EXTEND.md 是否存在：
- 排版参数覆盖（字号、颜色等）
- 文章类型预设扩展
- 品牌信息

### Step 0.5: 写前门控

读取 `references/pre-write-checks.md` 中的写前门控清单，检查 outline 的：

1. **核心判断**：能不能一句话说清楚？够不够硬？
2. **读者定义**：够不够具体？
3. **素材充足度**：至少 3 条可用素材？
4. **账号模式**：正文使用的身份和语气是否已明确？

任何一项不通过 -> 停下来告诉用户哪里不够，建议先补资料或修改 outline。**不硬写。**

### Step 1: 读取 Outline

读取用户指定的 content-outline.md 文件。提取：
- 目标读者、核心判断、切入角度
- SCQA 结构
- 推荐框架
- 素材清单
- **文章大纲**（content-outline-builder 产出的 outline 必须包含分章节大纲，含每章要回答的问题、关键内容和可使用素材）

### Step 2: 阶段一——出标题 + 确认大纲

**标题**：读取 `../_shared/title-and-packaging.md`，按标题 5 大原则生成 3 个候选标题。

**大纲**：
- **如果 outline 中包含文章大纲**（必须如此）：直接呈现 outline 中的大纲给用户确认，不重新生成
- **如果 outline 中没有章节大纲**：先停止写作，建议回到 `content-outline-builder` 补齐；只有用户明确要求继续时，才基于 SCQA 和推荐框架临时生成提纲，每个章节包含：

```yaml
章节序号: number
章节标题: string
本节观点: string            # 这一节要传递的核心观点（一句话）
本节在整篇里的作用: string  # 为什么需要这一节
用哪条素材: string
大概字数: number
```

**停下来等用户确认标题和大纲。** 不要直接跳到写全文。

### Step 3: 阶段二——写全文

用户确认标题和大纲后，按大纲逐章节写作。

读取 `references/framework-selection.md`，遵守：
- 根据文章类型预设对齐所有维度（框架 × 语调 × 配图风格 × 结尾模板）
- 分段写作法：每章独立交付价值
- 开头用 `../_shared/hook-and-ending.md` 中的模板
- 结尾用同一文件中的模板
- 遵守去 AI 痕迹规则

读取 `../_shared/wechat-channel-profile.md`，遵守排版规范。

### Step 4: 自检

读取 `references/pre-write-checks.md` 中的写后自检清单，逐条自检。
不通过的项目先自行修复。

### Step 5: 输出

读取 `../_shared/intermediate-format.md` 中 article-draft.md 的格式规范，按格式输出。

**article-draft.md 中只包含最终确认的标题**（不是 3 个候选）。3 个候选标题是 Step 2 的交互状态，不写入最终产物。

在 article-draft.md 头部追加文章类型预设信息，供下游 wechat-studio 读取：

```yaml
文章预设: deep-insight|story-time|hot-take|how-to|quick-list
主题色: default|warm|dark
```

输出到本地文件：`article-draft-<选题关键词>.md`

### Step 6: 自动串联审稿

完稿后自动调用 adversarial-content-review Skill，将 article-draft.md 送去审稿。

**审稿产物处理：**

| 审稿结论 | 处理方式 |
|---------|---------|
| 通过（≥8分） | 呈现 review-report.md 给用户，完成 |
| 需修改 | 按修改建议做针对性修复，覆盖 `article-draft-<keyword>.md`，呈现 review-report + 修订说明 |
| 需重写 | 呈现 review-report.md 给用户，**不自动重写**，建议用户考虑是否需要回到内容大纲重做 |

**产物位置：**
- `review-report-<关键词>.md`：与 article-draft 同目录
- 修订后的文章直接覆盖原 `article-draft-<keyword>.md`

## Guardrails

- 必须先通过写前门控，核心判断不够硬时不硬写
- 交互模式下必须先出标题+确认大纲，用户确认后再写全文；自动模式下跳过确认
- content-outline 中已有章节大纲时，直接使用，不重新生成
- 优先使用 EXTEND.md 中的定制配置（排版参数、品牌信息、预设扩展）
- 正文每段不超过 5 行，每句不超过 25 字
- 标题 3 个候选必须符合 5 大原则之一
- 写完全文后做一遍去AI痕迹检查
- 如果 content-outline 中有明确的核心判断，正文不能跑偏
- 字数控制在 1500-3000 字
- 审稿结论为"需重写"时，不自动重写，交由用户决定
