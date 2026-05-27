---
name: adversarial-content-review
description: 三角色对抗式审稿。对任意成稿 Markdown 做 2-3 轮审阅，输出五维度评分和修改建议。wechat-article-writer 完稿后自动串联，也可独立调用。
---

# adversarial-content-review

## 触发条件

- wechat-article-writer 完稿后自动串联
- 用户说"审稿"、"看看这篇行不行"、"帮我检查一下"
- 用户说"这篇能发吗"

**不触发：**
- "写文章" → wechat-article-writer
- "改标题"、"去AI味" → content-polisher
- "发草稿箱" → wechat-studio

## 不做什么

- 不写文章、不改文章（只输出审稿报告）
- 不做选题、不做内容大纲
- 不做发布

## 执行流程

### Step 1: 读取稿件

读取 `../_shared/account-mode-guide.md`、`../_shared/channel-safety-guide.md` 和 `../_shared/style-guide.md`，用于检查稿件是否跑出账号边界。

读取用户指定的 article-draft.md 文件（或从 wechat-article-writer 自动串联传入），提取：
- 标题
- 正文全部内容
- 字数
- 目标读者（如有 content-outline 来源，读取其中的目标读者）
- 文章预设和主题色
- 适用账号及发布平台

### Step 2: 第 1 轮——笔杆子审

读取 `references/review-rubric.md` 中的笔杆子角色定义。

以内容专家视角逐章节审阅：
- 每个章节的观点清晰度
- 论据支撑度
- 逻辑连贯性
- 输出具体修改建议

### Step 3: 第 2 轮——参谋审

读取 `references/review-rubric.md` 中的参谋角色定义。

以目标读者身份通读全文：
- 哪里看不懂 / 想跳过
- 哪里有共鸣 / 想转发
- 读完整体感受
- 是否像真实的人在表达，还是存在模板化、空泛升华或过度营销的 AI 稿痕迹

### Step 4: 第 3 轮——裁判裁定

读取 `references/review-rubric.md` 中的五维度评分表和结论阈值。

综合前两轮：
- 五维度打分（每个维度 0-2 分）
- 计算总分
- 给出最终结论
- 单独列出账号身份跑偏、强营销或明显 AI 稿表达；医美风险交给合规检查继续处理

| 总分 | 结论 |
|------|------|
| ≥ 8 | 通过 |
| 5-7 | 需修改 |
| < 5 | 需重写 |

### Step 5: 输出

读取 `../_shared/intermediate-format.md` 中 review-report.md 的格式规范，按格式输出。

输出到本地文件：`review-report-<关键词>.md`

如果内容涉及医美项目、效果、适应人群、案例对比、恢复期或诊疗建议，审稿后建议继续调用 `medical-aesthetic-compliance-checker`。

## Guardrails

- 三角色必须依次审阅，不能跳过或合并
- 五维度评分必须有具体理由，不能只给数字
- 修改建议必须具体到位置和改法，不能只说"需要优化"
- "需重写"结论必须说明核心问题是什么（方向错 vs 执行差）
- 审稿报告不直接修改原稿，修改由调用方决定
- 账号模式不清楚时，报告必须先标注需要确认，不默认把人格号稿件写成医生诊疗表达
