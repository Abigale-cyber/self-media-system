# self-media-system 中间产物格式

本文件是 Emma 完整流程的全局交付物契约。任何子 Skill 输出给下一层使用的内容，都优先按这里的字段组织。

## 下一步名称规则

所有面向用户的 `建议下一步`、`下一步建议`、`下一步` 字段，都必须写成「中文名称（英文 Skill 标识）」；不要只写英文 Skill 名。`补资料`、`重写` 这类非 Skill 动作直接写中文。

## 用户展示规则

所有面向用户的中间产物默认用 Markdown 表格和分节列表展示，不要包在 `yaml`、`json` 或 `markdown` 代码块里。只有用户明确要求“给我机器可读 YAML/JSON”时，才输出 fenced code block。

表格字段较多时，优先拆成 2-4 个短表，但具体产物有更严格展示规则时，以具体产物为准。例如生成选题（topic-generator）的 `topic-pool.md` 默认只能输出一张候选选题表。

- 基础信息表
- 资料/痛点/场景表
- 候选选题横向对比表
- 风险边界与下一步表

## 文档产物规则

从内容大纲开始，后续主产物必须是本地 Markdown 文档，而不是聊天里的代码块：

- 默认根目录是当前工作区下的 `content-production/`。
- 文件名默认使用用户最终选择或确认的标题：`<用户选择的标题>.md`
- 不使用 `content-outline-`、`voice-script-`、`article-draft-`、`review-report-`、`publish-pack-` 等英文前缀。
- 如果同一标题下需要保留多个阶段文档，优先放入中文阶段目录区分，例如 `content-production/内容大纲/<用户选择的标题>.md`、`content-production/长文草稿/<用户选择的标题>.md` 改成 `content-production/文章初稿/<用户选择的标题>.md`。
- 如果必须在同一目录保存多个阶段版本，只能追加中文阶段后缀，例如 `<用户选择的标题>-内容大纲.md`，不要追加英文阶段名。
- 用户可以指定保存位置。若用户指定完整 `.md` 文件路径，按该路径保存；若用户指定目录，则保存为 `<用户指定目录>/<用户选择的标题>.md`。
- 用户给相对路径时，按当前工作区解析；用户给绝对路径时，按绝对路径保存。
- 文件名保留中文标题，只替换文件系统不允许的字符，例如 `/`、`:`。
- 目标目录不存在时先创建目录，再写入 Markdown 文档。

这些步骤完成后，聊天窗口只返回：文档链接、关键摘要、需要用户确认的问题和建议下一步。不要把整篇文档包进代码块展示。

| 中文名称 | 英文 Skill 标识 |
| --- | --- |
| 完整流程 | `self-media-system` |
| 数字分身 | `digital-avatar` |
| 生成选题 | `topic-generator` |
| 内容大纲 | `content-outline-builder` |
| 口播脚本 | `voice-script-generator` |
| 大纲扩写 | `outline-expander` |
| 生成配图 | `content-image-gen` |
| 风格改写 | （已合并到 outline-expander） |
| 内容审稿 | `content-reviewer` |
| 合规检查 | `medical-aesthetic-compliance-checker` |
| 平台适配 | （已删除） |
| 公众号工作台 | `wechat-studio` |

## topic-material-pack.md

由 `topic-generator` 输出，供 `content-outline-builder` 使用。

面向用户展示时按以下表格输出，不要使用 YAML 代码块。

**基础信息**

| 字段 | 内容 |
| --- | --- |
| 生成时间 | string |
| 来源 | 用户访谈 / 知识库资料 / 客户问题 / 真实经历 / 业务方向 |
| 原始输入 | string |
| 账号模式 | 认证医生号 / 非认证人格号 / 待确认 |
| 发布平台 | 视频号 / 小红书 / 公众号 / 其他 / 待确认 |
| 目标用户 | string |
| 业务模块 | 眼周抗衰 / 痘肌问题肌 / 生活美学 / 创业医生人格 / AI时代观察 / 女性状态 / 其他 |
| 核心想法 | string |

**资料盘点**

| 类型 | 内容 | 可用范围 |
| --- | --- | --- |
| 已提供 | 文档名称或资料片段 | 可直接引用 / 仅作方向参考 / 待确认 |
| 建议补充 | string | - |
| 是否足够进入生成选题 | 是 / 否 | - |

**素材与判断**

| 类型 | 内容 | 依据或可信度 |
| --- | --- | --- |
| 痛点 | string | 用户确认 / 推断 / 待确认 |
| 场景素材 | string | 可直接引用 / 仅作方向参考 / 待确认 |
| 专业判断 | string | string |
| 可用金句 | string | - |
| 风险边界 | string | - |

**下一步**

| 字段 | 内容 |
| --- | --- |
| 建议下一步 | 补资料 / 生成选题（topic-generator） / 内容大纲（content-outline-builder） |

## topic-pool.md

由 `topic-generator` 输出，供内部筛选使用。

面向用户展示时默认只输出一张候选选题表，不要使用 YAML 代码块，不要输出基础信息表、评分表、资料依据表或原始信号表。

| 序号 | 题目 | 受众痛点 | 内容角度 |
| ---: | --- | --- | --- |
| 1 | string | string | string |

面向用户默认不要输出账号模式、目标用户、业务模块、搜索方式、可用资料、资料依据、风险边界、处理建议、初步评分、综合分、原始信号表或可延展形态。上述信息只作为内部筛选依据，除非用户明确追问。

表格后只补一句下一步：建议下一步：内容大纲（content-outline-builder）。

## topic-ranking.md

由 `topic-generator` 输出，供 `content-outline-builder` 使用。

面向用户展示时，默认只输出极简横向对比表：

| 优先级 | 选题 | 核心优势 | 主要短板 |
| ---: | --- | --- | --- |

不要默认展示综合分、七维分数、处理建议、完整资料依据或风险清单；这些只作为内部判断和追问时的补充说明。

以下字段仅作为内部交接契约，不作为面向用户的展示格式：生成时间、候选来源、账号模式、内部评分规则、排序结果、Top3、下一步。

排序结果至少保留：优先级、选题、核心优势、主要短板、内部判断、推荐切入角度、安全改写方向。

下一步写：内容大纲（content-outline-builder）。

## content-outline.md

由 `content-outline-builder` 输出，供 `voice-script-generator`、`outline-expander` 和 `content-image-gen` 使用。

主产物是 Markdown 文档。建议结构：

- 基础信息：选题、来源、适用账号、目标用户、推荐形态
- 核心判断：读者痛点、写作目的、切入角度、核心判断
- SCQA：情境、冲突、问题、答案
- 文章大纲：每章写清楚章节标题、要回答的问题、关键内容、可使用素材
- 素材清单：用表格列出类型、内容、来源、可信度
- 风险提醒
- 下一步建议：口播脚本（voice-script-generator）/大纲扩写（outline-expander）

如果需要给用户比较多个大纲方案，聊天里用纵向对比表，不要输出多份代码块：

| 方案 | 核心判断 | 结构优势 | 适合平台 | 风险/短板 | 建议 |
| --- | --- | --- | --- | --- | --- |

**content-outline.md 不包含完整正文。** 如果用户要求直接写正文，仍应先确认核心判断和文章大纲是否成立。

## voice-script.md

由 `voice-script-generator` 输出。

主产物是 Markdown 文档。建议结构：

- 口播策略：主题、来源、账号模式、目标平台、建议时长、核心观点、合规提醒
- 开头钩子备选：3 条，说明适合原因
- 口播逐字稿：可直接录制的正文
- 分镜建议：用表格列出镜头、时长、画面内容、字幕重点、对应口播
- 封面标题：按类型给备选
- 下一步建议：内容审稿（adversarial-content-review）/合规检查（medical-aesthetic-compliance-checker）

## article-draft.md

由 `outline-expander` 输出，供 `content-reviewer` 和 `wechat-studio` 使用。

主产物是完整 Markdown 文章文档。不要把正文放进代码块。建议结构：

- 标题
- 摘要
- 文章信息：适用账号、文章预设、主题色、来源大纲、目标读者、核心判断
- 风险提醒
- 正文：按公众号可读排版写成 Markdown 小标题和自然段
- 字数
- 下一步建议：内容审稿（adversarial-content-review）/合规检查（medical-aesthetic-compliance-checker）

## review-report.md

由 `adversarial-content-review` 输出。

主产物是 Markdown 审稿报告文档。建议结构：

- 审稿对象：稿件来源
- 总体结论：通过 / 需修改 / 需重写
- 维度评分：用表格列出标题吸引力、结构稳定性、论据强度、用户价值、表达完成度
- 主要问题：用表格列出位置、问题、修改建议
- 优先修改清单
- 下一步建议：内容审稿（adversarial-content-review）/合规检查（medical-aesthetic-compliance-checker）/返回内容大纲（content-outline-builder）

## compliance-report.md

由 `medical-aesthetic-compliance-checker` 输出。

主产物是 Markdown 合规报告文档。建议结构：

- 审查结论：稿件来源、检查日期、账号模式、平台、结论、是否建议发布
- 风险明细：用表格列出等级、原句/位置、风险类型、问题说明、替代表达
- 合规改写原则
- 合规版全文：当原稿完整且可改写时，直接写成 Markdown 正文
- 下一步建议：公众号工作台（wechat-studio）/大纲扩写（outline-expander）/重写

## publish-pack.md / publish-pack.json

由 `content-reviewer` 输出，供人工发布或 `wechat-studio` 使用。

主产物是 Markdown 发布包文档。只有用户明确要求系统导入或 API 对接时，才额外生成 `publish-pack.json`。建议结构：

- 基础信息：稿件来源、合规报告、账号模式
- 平台发布总览：用表格列出平台、推荐内容形态、核心角度、是否需要二次合规复核
- 小红书发布包：标题备选、封面文字、正文、标签、评论区引导、CTA、发布注意事项
- 视频号发布包：视频标题、开头 3 秒字幕、简介文案、封面文字、评论区引导、CTA、发布注意事项
- 公众号发布包：标题备选、摘要、封面图方向、正文 Markdown、排版建议
- wechat-studio 交接：Markdown 路径、封面图路径、主题建议、是否需要人工确认
