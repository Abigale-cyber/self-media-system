---
name: self-media-system
description: 当需要按 Emma 自媒体六层系统编排内容生产流程，或需要在数字分身、选题访谈、选题生成、大纲、成稿、审查、合规、平台适配和发布之间选择下一步时使用。
---

# self-media-system

这个目录用于承载「自媒体系统」的 Skill。系统名称保持英文 `self-media-system`，内部说明按已确认的六层架构整理。

## 六层架构

| 层级 | 用途 | 对应 Skill |
| --- | --- | --- |
| 01 数字分身层 | 统一人设、口吻、专业边界和禁用表达。 | `01-digital-avatar` |
| 02 选题生产层 | 通过访谈挖真实问题和素材，生成候选选题，并按优先级排序。 | `02-interview-to-draft`, `02-content-topic-radar`, `02-topic-score-ranker` |
| 03 内容策划层 | 把已确定的选题改写成可确认、可成稿、可拍摄的内容大纲。 | `03-content-outline-builder` |
| 04 内容生成层 | 根据大纲生成口播稿、公众号长文和配图 Prompt。 | `04-voice-script-writer`, `04-outline-to-script`, `04-wechat-article-writer`, `04-content-image-gen` |
| 05 优化审查层 | 做风格优化、内容审稿和医美合规检查。 | `05-content-polisher`, `05-adversarial-content-review`, `05-medical-aesthetic-compliance-checker` |
| 06 分发复盘层 | 做平台适配、公众号工作台预览和草稿推送。 | `06-platform-adapter`, `06-wechat-studio` |

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

## 标准步骤

| 步骤 | 动作 | 对应层级 | 对应 Skill |
| --- | --- | --- | --- |
| 1A | 读取数字分身，明确账号定位、人设口吻和表达边界。 | 01 数字分身层 | `01-digital-avatar` |
| 2A | 访谈用户并盘点知识库资料，形成可引用的选题素材包。 | 02 选题生产层 | `02-interview-to-draft` |
| 2B | 基于账号定位、资料素材和必要的外部信号生成候选选题。 | 02 选题生产层 | `02-content-topic-radar` |
| 2C | 对候选选题评分排序，确定优先选题。 | 02 选题生产层 | `02-topic-score-ranker` |
| 3A | 把优先选题改写成内容大纲。 | 03 内容策划层 | `03-content-outline-builder` |
| 4A | 根据大纲生成短视频口播稿和分镜建议。 | 04 内容生成层 | `04-outline-to-script`, `04-voice-script-writer` |
| 4B | 根据大纲生成公众号长文稿。 | 04 内容生成层 | `04-wechat-article-writer` |
| 4C | 根据主题生成封面图和配图 Prompt。 | 04 内容生成层 | `04-content-image-gen` |
| 5A | 做风格优化和去 AI 味润色。 | 05 优化审查层 | `05-content-polisher` |
| 5B | 做内容质量审稿。 | 05 优化审查层 | `05-adversarial-content-review` |
| 5C | 做医美合规检查和风险表达替换。 | 05 优化审查层 | `05-medical-aesthetic-compliance-checker` |
| 6A | 做小红书、视频号、公众号发布包适配。 | 06 分发复盘层 | `06-platform-adapter` |
| 6B | 进入公众号工作台做预览、排版、图片和草稿确认。 | 06 分发复盘层 | `06-wechat-studio` |

## `/选题` 门控流程

用户提出 `/选题`、寻找选题或仅给出一个方向时，默认流程是：

```text
interview-to-draft 资料盘点访谈
-> topic-material-pack.md
-> content-topic-radar 基于资料生成选题
-> topic-score-ranker 排序推荐 Top 3
```

资料不足时，应先列出需要 Emma 提供的知识库文档名称和关键信息，不直接输出可进入写稿环节的正式选题。
