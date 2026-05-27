---
name: content-topic-radar
description: 当 Emma 已提供可用资料盘点结果，需要从资料与必要的外部信号中生成候选自媒体选题时使用。
---

# content-topic-radar

## 触发条件

- 用户提供 `topic-material-pack.md`，要求生成候选选题
- 用户已经确认账号模式、内容模块和可引用资料，要求“找选题”或补充平台信号
- `interview-to-draft` 判断资料足够后转入本 Skill

**不触发：**

- 只有 `/选题`、方向词或热点词，没有资料盘点结果 -> `interview-to-draft`
- 已选定题目，需要整理大纲 -> `content-outline-builder`
- 需要写稿或发布 -> 对应下游 Skill

## 执行流程

### Step 1: 校验资料入口

读取：

- `../_shared/knowledge-base-index.md`
- `../_shared/account-mode-guide.md`
- `../_shared/content-module-map.md`
- `../_shared/scoring-rubric.md`
- `../_shared/intermediate-format.md`

先检查输入中是否包含：

- 账号模式和业务模块
- 目标用户和核心判断方向
- 至少 2 条可用资料，以及每条的来源/可用范围

任一缺失时，停止生成正式选题池，转回 `interview-to-draft` 列出补资料问题。

### Step 2: 从资料形成原始候选

优先从 `topic-material-pack.md` 中的知识库片段、客户问题和 Emma 的判断提取原始候选。每个候选必须关联至少一项资料依据。

需要扩充讨论窗口时，读取 `references/source-playbook.md`，可补充平台搜索、权威信息或近期讨论信号。外部信号只用于补角度和时机，不能替代 Emma 的资料或改变账号边界。

### Step 3: 去重与边界筛选

读取 `references/topic-selection-principles.md`：

- 合并同一问题的重复表达
- 去掉太宽泛、太功效化、太焦虑或无法由资料支撑的题目
- 标明题目适合认证医生号还是非认证人格号
- 保留最多 8-10 个候选进入初评

### Step 4: 初步评分

按 `../_shared/scoring-rubric.md` 的 7 个维度逐项评分：

- 痛点强度
- 业务价值
- 传播潜力
- 专业可信度
- 账号匹配度
- 资料充分度
- 合规风险

资料充分度低于 3 的候选可以作为“待补材料方向”保留，但不得标记为可进入写稿。

### Step 5: 输出选题池

按 `../_shared/intermediate-format.md` 中 `topic-pool.md` 的格式输出。默认保留最适合继续评分的 5 个候选，每项包含：

- 账号模式、内容模块和题目
- 一句话判断、建议角度和推荐钩子
- 资料依据及可验证状态
- 七维初步评分和处理建议
- 适合的内容形态

输出后交给 `topic-score-ranker` 排序，不在本 Skill 直接决定最终选题。

## Guardrails

- 没有资料盘点结果时，不用热点或常识补出正式题库。
- 每个候选题必须能追溯到 Emma 提供的资料或明确标注的外部信号。
- 对标账号只可作为结构与题材参考，不复制其身份、口吻或事实。
- 医美选题不依赖疗效承诺、夸张对比或外貌焦虑获得传播性。
