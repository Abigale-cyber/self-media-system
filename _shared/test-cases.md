# self-media-system 测试用例

每次修改 Skill 后，至少用以下 5 组输入做人工验收。测试重点是“是否调用正确 Skill、是否守住职责边界、是否能交给下一层”。

| 测试组 | 推荐输入 | 预期触发 | 通过标准 |
| --- | --- | --- | --- |
| 常规主流程 | 我想做一条“为什么眼周抗衰不能只看项目”的视频，帮我走一遍。 | `self-media-system` -> 具体子 Skill | 能从 1A 到 6A 串联，且每层产物可复用 |
| 模糊想法 | 我想发一个讲眼睛显老的视频，但不知道从哪里开始。 | `interview-to-draft` | 先访谈挖素材，不直接写成稿 |
| 选题但无资料 | `/选题` 我想做眼周抗衰内容，但资料还没整理。 | `interview-to-draft` | 先确认账号模式并请 Emma 提供对应知识库资料名称/片段，不直接输出正式选题池 |
| 资料齐备生成选题 | 我已提供账号模式、眼周模块资料和客户问题，请生成候选选题。 | `content-topic-radar` -> `topic-score-ranker` | 选题标注资料依据，并按账号匹配度和资料充分度参与排序 |
| 高风险合规 | 一次解决眼袋，永久年轻，完全没有恢复期。 | `medical-aesthetic-compliance-checker` | 标出疗效承诺、绝对化和恢复期风险，给替代表达 |
| 公众号链路 | 根据这个大纲写公众号文章，并进入公众号工作台预览。 | `wechat-article-writer` -> `wechat-studio` | 先确认标题和大纲，再写文；可交给工作台预览 |
| 平台适配 | 把这篇合规终稿适配成小红书、视频号、公众号发布包。 | `platform-adapter` | 输出三平台差异、标题、封面文字、标签、CTA、复核提示 |

## 验收表

| Skill | 输入 | 是否正确触发 | 输出是否合格 | 是否能交给下一层 | 问题 | 结论 |
| --- | --- | --- | --- | --- | --- | --- |
| `digital-avatar` | 统一 Emma 人设和表达边界 |  |  |  |  |  |
| `interview-to-draft` | `/选题` 我有方向但还没整理资料 |  |  |  |  |  |
| `content-topic-radar` | 根据已提供的资料包找 5 个眼周抗衰选题 |  |  |  |  |  |
| `topic-score-ranker` | 给这些选题排序 |  |  |  |  |  |
| `content-outline-builder` | 把优先选题整理成大纲 |  |  |  |  |  |
| `outline-to-script` | 根据大纲写 90 秒口播 |  |  |  |  |  |
| `wechat-article-writer` | 根据大纲写公众号文章 |  |  |  |  |  |
| `medical-aesthetic-compliance-checker` | 做医美合规检查 |  |  |  |  |  |
| `platform-adapter` | 适配三平台发布包 |  |  |  |  |  |
| `wechat-studio` | 导入公众号工作台预览 |  |  |  |  |  |
