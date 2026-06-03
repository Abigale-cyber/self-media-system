---
name: self-media-system
description: 当需要按 Emma 自媒体系统编排内容生产流程，或需要在面诊素材、数字分身、选题、大纲、成稿、审稿和数据复盘之间选择下一步时使用。
---

# self-media-system

这个目录用于承载「完整流程」的 Skill。系统名称保持英文 `self-media-system`，内部说明按已确认的六层架构整理。

## 六层架构

| 层级 | 用途 | 对应 Skill |
| --- | --- | --- |
| 01 素材沉淀层 | 从面诊转写、分说话人文字或咨询对话中沉淀可复用素材，并确认 Emma 人设、口吻、专业边界和禁用表达。 | 面诊素材提炼（`consultation-material-extractor`）、数字分身（`digital-avatar`） |
| 02 选题生产层 | 通过资料访谈或对标拆解，生成候选选题、判断爆款机制并排序推荐。 | 生成选题（`topic-generator`）、爆款拆解（`viral-content-breakdown`） |
| 03 内容策划层 | 把已确定的选题改写成可确认、可成稿、可拍摄的内容大纲。 | 内容大纲（`content-outline-builder`） |
| 04 内容生成层 | 根据大纲生成口播稿、公众号长文和配图 Prompt。 | 口播脚本（`voice-script-writer`）、大纲扩写（`outline-expander`）、生成配图（`content-image-gen`） |
| 05 优化审查层 | 做发布前内容审稿、合规检查和风险表达修订。 | 内容审稿（`adversarial-content-review`） |
| 06 数据复盘层 | 分析已发布内容的数据、反馈和下一轮优化方向。 | 数据复盘（`data-analysis`） |

实际执行时优先使用当前阶段最具体的子 Skill。只有当用户需要查看完整系统结构，或不知道下一步该调用哪个 Skill 时，才使用这个总入口。

## 全局共享规则

子 Skill 执行前优先读取 `_shared/` 中的公共规则：

| 文件 | 用途 |
| --- | --- |
| `_shared/knowledge-base-index.md` | 可向 Emma 索取的知识库资料名称和读取边界 |
| `_shared/emma-profile.md` | 已确认的 Emma 基础定位和事实使用边界 |
| `_shared/account-mode-guide.md` | 认证医生号与非认证人格号的分工和表达规则 |
| `_shared/content-module-map.md` | 各账号适用的内容模块、资料要求和选题边界 |
| `_shared/channel-safety-guide.md` | 账号与发布渠道的风险提示和互动边界 |
| `_shared/style-guide.md` | Emma 默认文风、人设气质和禁用表达 |
| `_shared/scoring-rubric.md` | 选题评分和审稿评分规则 |
| `_shared/intermediate-format.md` | 各层之间交接的中间产物格式 |
| `_shared/test-cases.md` | Skill 修改后的人工验收用例 |

输出给用户的 `建议下一步`、`下一步建议`、`下一步` 字段，必须使用 `_shared/intermediate-format.md` 里的中文名称规则：中文名称在前，英文 Skill 标识放括号里。

## 标准步骤

| 步骤 | 动作 | 对应层级 | 对应 Skill |
| --- | --- | --- | --- |
| 1A | 从 Emma 与客户的面诊转写、分说话人文字或咨询对话中提炼选题素材、Emma 表达样本、信任建立和临床判断素材。 | 01 素材沉淀层 | 面诊素材提炼（`consultation-material-extractor`） |
| 1B | 更新或读取数字分身，明确账号定位、人设口吻、目标受众和表达边界。 | 01 素材沉淀层 | 数字分身（`digital-avatar`） |
| 2A | 访谈用户并盘点知识库资料；资料不足时每轮只问 1 个关键问题，资料确认完整后生成候选选题并排序推荐 Top 3。 | 02 选题生产层 | 生成选题（`topic-generator`） |
| 2B | 拆解对标内容、爆款作品、热门截图或脚本，提炼可迁移的结构和创作方法。 | 02 选题生产层 | 爆款拆解（`viral-content-breakdown`） |
| 3A | 把优先选题改写成内容大纲。 | 03 内容策划层 | 内容大纲（`content-outline-builder`） |
| 4A | 根据大纲、文章或素材生成短视频口播稿、分镜和发布素材。 | 04 内容生成层 | 口播脚本（`voice-script-writer`） |
| 4B | 根据大纲生成公众号长文稿，并支持标题/开头/结尾优化和润色。 | 04 内容生成层 | 大纲扩写（`outline-expander`） |
| 4C | 根据主题生成封面图和配图 Prompt。 | 04 内容生成层 | 生成配图（`content-image-gen`） |
| 5A | 对成稿或发布素材做内容审稿、合规检查和风险表达修订。 | 05 优化审查层 | 内容审稿（`adversarial-content-review`） |
| 6A | 对已发布内容做数据复盘，判断选题、标题、封面、脚本结构和反馈回流。 | 06 数据复盘层 | 数据复盘（`data-analysis`） |

## 阶段停止规则

- 生成选题完成后，停下来让用户选 1 个题，不自动生成大纲。
- 内容大纲完成后，停下来让用户确认结构、角度和素材使用方式，不自动写正文。
- 大纲扩写必须在用户明确确认“继续写正文”“大纲没问题”后才写全文。
- 正文或口播稿完成后停下来；只有用户明确说“审稿”“发布前检查”或“检查风险表达”时，才进入内容审稿。
- 内容审稿发现问题时优先直接修订原文；不再另行生成 `review-report.md`。
- 数据复盘只在用户提供已发布内容的数据、截图、评论反馈或手动记录后启动。

## `/选题` 门控流程

用户提出 `/选题`、寻找选题或仅给出一个方向时，由 `topic-generator` 先进入资料访谈。

```text
生成选题（topic-generator）
-> 每轮只问 1 个关键问题
-> 资料确认完整后生成并排序推荐 Top 3
-> 停下来让用户确认选题
```

资料不足时，只追问当前最高优先级缺口，不直接输出可进入写稿环节的正式选题。

## 面诊素材门控流程

用户上传 Emma 与客户的面诊语音转文字、分说话人 transcript、咨询对话或面诊素材时，先进入 `consultation-material-extractor`。

```text
面诊素材提炼（consultation-material-extractor）
-> 判断说话人归属
-> 追加到 4 类素材表，每张表最多 50 条
-> 只沉淀素材，不总结面诊、不写正文
```

提炼完成后，再根据用户目的进入生成选题（topic-generator）、数字分身（digital-avatar）或内容大纲（content-outline-builder）。

## 有效 Skill 清单

当前主流程把以下 Skill 作为六层架构内的有效入口：

| Skill | 职责 |
| --- | --- |
| `self-media-system` | 判断当前处在哪个阶段，并推荐下一步调用哪个子 Skill。 |
| `consultation-material-extractor` | 从面诊转写、分说话人文字或咨询对话中提炼长期可复用素材。 |
| `digital-avatar` | 账号人设、口吻、专业边界和禁用表达。 |
| `topic-generator` | 资料访谈、素材盘点、候选选题生成和排序推荐。 |
| `viral-content-breakdown` | 拆解对标内容和爆款机制，提炼可迁移结构和提示词。 |
| `content-outline-builder` | 把已确认选题整理成可写、可拍、可确认的内容大纲。 |
| `outline-expander` | 根据内容大纲写公众号长文，并支持标题、开头、结尾和句子优化。 |
| `voice-script-writer` | 生成口播逐字稿、分镜、封面提示词、标题、标签和首评。 |
| `content-image-gen` | 生成封面图、正文配图或图片提示词。 |
| `adversarial-content-review` | 做内容质量和合规审稿，发现问题时直接修订原文。 |
| `data-analysis` | 分析发布数据、评论反馈和下一轮优化动作。 |
