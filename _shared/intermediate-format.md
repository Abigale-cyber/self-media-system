# self-media-system 中间产物格式

本文件是 Emma 自媒体系统的全局交付物契约。任何子 Skill 输出给下一层使用的内容，都优先按这里的字段组织。

## topic-material-pack.md

由 `interview-to-draft` 输出，供 `content-topic-radar`、`topic-score-ranker` 和 `content-outline-builder` 使用。

```yaml
生成时间: string
来源: 用户访谈|知识库资料|客户问题|真实经历|业务方向
原始输入: string
账号模式: 认证医生号|非认证人格号|待确认
发布平台: 视频号|小红书|公众号|其他|待确认
目标用户: string
业务模块: 眼周抗衰|痘肌问题肌|生活美学|创业医生人格|AI时代观察|女性状态|其他
核心想法: string
资料盘点:
  已提供:
    - 文档名称: string
      关键内容: string
      可用范围: 可直接引用|仅作方向参考|待确认
  建议补充:
    - string
  是否足够进入选题生成: 是|否
痛点清单:
  - 痛点: string
    用户原话: string
    可信度: 用户确认|推断|待确认
场景素材:
  - 场景或问题: string
    关键冲突: string
    可用范围: 可直接引用|仅作方向参考|待确认
专业判断:
  - 判断: string
    依据: string
可用金句:
  - string
风险边界:
  - string
建议下一步: 补资料|content-topic-radar|topic-score-ranker|content-outline-builder
```

## topic-pool.md

由 `content-topic-radar` 输出，供 `topic-score-ranker` 使用。

```yaml
生成时间: string
账号模式: 认证医生号|非认证人格号|待确认
目标用户: string
业务模块: string
搜索方式: 用户素材|联网搜索|混合
候选题目:
  - 题目: string
    一句话判断: string
    原始信号:
      平台或来源: string
      证据: string
      可信度: 高|中|低|待验证
    建议角度: string
    推荐钩子: string
    资料依据:
      - string
    初步评分:
      痛点强度: 1-5
      业务价值: 1-5
      传播潜力: 1-5
      专业可信度: 1-5
      账号匹配度: 1-5
      资料充分度: 1-5
      合规风险: 1-5
    处理建议: 进入评分|补素材|观察|丢弃
    可延展形态:
      - 口播
      - 公众号
      - 小红书
```

## topic-ranking.md

由 `topic-score-ranker` 输出，供 `content-outline-builder` 使用。

```yaml
生成时间: string
候选来源: topic-pool.md|用户输入|访谈素材
账号模式: 认证医生号|非认证人格号|待确认
评分规则: 痛点强度*4 + 业务价值*4 + 传播潜力*3 + 专业可信度*3 + 账号匹配度*2 + 资料充分度*2 + (6-合规风险)*2
排序结果:
  - 排名: number
    选题: string
    综合分: number
    痛点强度: 1-5
    业务价值: 1-5
    传播潜力: 1-5
    专业可信度: 1-5
    账号匹配度: 1-5
    资料充分度: 1-5
    合规风险: 1-5
    处理建议: 优先做|合并|降级|淘汰
    推荐切入角度: string
    安全改写方向: string
Top3:
  - string
下一步: content-outline-builder
```

## content-outline.md

由 `content-outline-builder` 输出，供 `outline-to-script` 和 `wechat-article-writer` 使用。

```yaml
选题: string
来源: topic-ranking.md|topic-pool.md|访谈素材|用户输入
适用账号: 认证医生号|非认证人格号|待确认
目标用户: string
读者痛点: string
核心判断: string
写作目的: string
切入角度: string
推荐形态: 口播|公众号|图文|多平台
SCQA:
  情境: string
  冲突: string
  问题: string
  答案: string
文章大纲:
  - 章节: string
    要回答的问题: string
    关键内容: string
    可使用素材:
      - string
素材清单:
  - 类型: 案例|客户原话|专业判断|数据|金句|风险
    内容: string
    来源: 用户确认|知识库资料|联网资料|推断|待确认
    可信度: 高|中|低|待验证
风险提醒:
  - string
下一步建议:
  - outline-to-script
  - wechat-article-writer
```

**content-outline.md 不包含完整正文。** 如果用户要求直接写正文，仍应先确认核心判断和文章大纲是否成立。

## voice-script.md

由 `outline-to-script` 或 `voice-script-writer` 输出。

```yaml
主题: string
来源: content-outline.md|article-draft.md|用户粘贴文本
账号模式: 认证医生号|非认证人格号|待确认
目标平台: 视频号|小红书|抖音|其他
建议时长: 60秒|90秒|180秒
核心观点: string
合规提醒:
  - string
开头钩子备选:
  - 钩子: string
    适合原因: string
逐字稿: string
分镜建议:
  - 镜头: number
    时长: string
    画面内容: string
    字幕重点: string
    对应口播: string
封面标题:
  - string
下一步建议:
  - content-polisher
  - medical-aesthetic-compliance-checker
```

## article-draft.md

由 `wechat-article-writer` 输出，供 `content-polisher`、`adversarial-content-review`、`medical-aesthetic-compliance-checker`、`platform-adapter` 和 `wechat-studio` 使用。

```yaml
标题: string
摘要: string
适用账号: 认证医生号|非认证人格号|待确认
文章预设: deep-insight|story-time|hot-take|how-to|quick-list
主题色: default|warm|dark
来源大纲: string
目标读者: string
核心判断: string
风险提醒:
  - string
正文: markdown
字数: number
下一步建议:
  - adversarial-content-review
  - medical-aesthetic-compliance-checker
```

## review-report.md

由 `adversarial-content-review` 输出。

```yaml
稿件来源: string
总分: 0-10
维度评分:
  标题吸引力: 0-2
  结构稳定性: 0-2
  论据强度: 0-2
  用户价值: 0-2
  表达完成度: 0-2
主要问题:
  - 位置: string
    问题: string
    修改建议: string
结论: 通过|需修改|需重写
下一步建议: content-polisher|medical-aesthetic-compliance-checker|返回content-outline-builder
```

## compliance-report.md

由 `medical-aesthetic-compliance-checker` 输出。

```yaml
稿件来源: string
检查日期: string
账号模式: 认证医生号|非认证人格号|待确认
平台: 公众号|视频号|小红书|多平台|待确认
结论: PASS|NEEDS_EDIT|HIGH_RISK
是否建议发布: 是|修改后发布|否
风险明细:
  - 等级: 高|中|低
    原句或位置: string
    风险类型: 疗效承诺|绝对化表达|焦虑营销|前后对比|资质暗示|诊疗建议|风险提示缺失|平台表达风险
    问题说明: string
    替代表达: string
合规改写原则:
  - string
合规版全文: markdown
下一步建议: platform-adapter|content-polisher|重写
```

## publish-pack.md / publish-pack.json

由 `platform-adapter` 输出，供人工发布或 `wechat-studio` 使用。

```yaml
稿件来源: string
合规报告: string
账号模式: 认证医生号|非认证人格号|待确认
平台发布总览:
  - 平台: 小红书|视频号|公众号
    推荐内容形态: string
    核心角度: string
    是否需要二次合规复核: 是|否
小红书发布包:
  标题备选: [string]
  封面文字: [string]
  正文: string
  标签: [string]
  评论区引导: string
  CTA: string
  发布注意事项: [string]
视频号发布包:
  视频标题: [string]
  开头3秒字幕: string
  简介文案: string
  封面文字: string
  评论区引导: string
  CTA: string
  发布注意事项: [string]
公众号发布包:
  标题备选: [string]
  摘要: [string]
  封面图方向: string
  正文Markdown: string
  排版建议: [string]
  wechatStudio交接:
    markdown路径: string
    封面图路径: string
    主题建议: string
    是否人工确认: true
```
