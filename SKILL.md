---
name: self-media-system
description: 当需要按 Emma 自媒体系统编排内容生产流程，或需要在数字分身、选题、大纲、成稿、审稿和工作台之间选择下一步时使用。
---

# self-media-system

这个目录用于承载「完整流程」的 Skill。系统名称保持英文 `self-media-system`，内部说明按已确认的六层架构整理。

## 六层架构

| 层级 | 用途 | 对应 Skill |
| --- | --- | --- |
| 01 数字分身层 | 统一人设、口吻、专业边界和禁用表达。 | 数字分身（`digital-avatar`） |
| 02 选题生产层 | 通过访谈挖真实问题和素材，生成候选选题并排序推荐。 | 生成选题（`topic-generator`） |
| 03 内容策划层 | 把已确定的选题改写成可确认、可成稿、可拍摄的内容大纲。 | 内容大纲（`content-outline-builder`） |
| 04 内容生成层 | 根据大纲生成口播稿、公众号长文和配图 Prompt。 | 口播脚本（`voice-script-generator`）、大纲扩写（`outline-expander`）、封面配图（`content-image-gen`） |
| 05 优化审查层 | 做内容审稿和合规检查。 | 内容审稿（`content-reviewer`） |
| 06 分发复盘层 | 公众号工作台预览和草稿推送。 | 公众号工作台（`wechat-studio`） |

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
| 1A | 读取数字分身，明确账号定位、人设口吻和表达边界。 | 01 数字分身层 | 数字分身（`digital-avatar`） |
| 2A | 访谈用户并盘点知识库资料，形成可引用的选题素材包，生成候选选题并排序推荐 Top 3。 | 02 选题生产层 | 生成选题（`topic-generator`） |
| 3A | 把优先选题改写成内容大纲。 | 03 内容策划层 | 内容大纲（`content-outline-builder`） |
| 4A | 根据大纲或文章生成短视频口播稿和分镜建议。 | 04 内容生成层 | 口播脚本（`voice-script-generator`） |
| 4B | 根据大纲生成公众号长文稿，并支持标题/开头/结尾优化和润色。 | 04 内容生成层 | 大纲扩写（`outline-expander`） |
| 4C | 根据主题生成封面图和配图 Prompt。 | 04 内容生成层 | 封面配图（`content-image-gen`） |
| 5A | 对成稿做内容审稿和合规检查，包括三角色审稿和医美风险检查。 | 05 优化审查层 | 内容审稿（`content-reviewer`） |
| 6A | 进入公众号工作台做预览、排版、图片和草稿确认。 | 06 分发复盘层 | 公众号工作台（`wechat-studio`） |

## `/选题` 门控流程

用户提出 `/选题`、寻找选题或仅给出一个方向时，直接由 `topic-generator` 完成访谈、生成选题和排序推荐。

```text
生成选题（topic-generator）访谈+生成+排序，推荐 Top 3
```

资料不足时，应先列出需要 Emma 提供的知识库文档名称和关键信息，不直接输出可进入写稿环节的正式选题。
