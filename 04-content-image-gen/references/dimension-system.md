# 配图维度选择系统

每张配图通过三个独立维度选择，组合灵活。

## 信息类型（Type）— 图要表达什么

| 类型 | 说明 | 适用场景 |
|------|------|---------|
| `scene` | 氛围渲染，不传达具体信息 | 故事开头、情绪转折处 |
| `framework` | 概念关系图，展示结构 | 方法论、理论框架 |
| `flowchart` | 流程步骤可视化 | 教程、工作流 |
| `comparison` | 并排对比 | 优劣对比、前后对照 |
| `infographic` | 数据/指标可视化 | 技术文章、数据分析 |

## 渲染风格（Style）— 图长什么样

| 风格 | 说明 | 适用场景 |
|------|------|---------|
| `notion` | 极简手绘线画 | 知识分享、SaaS |
| `elegant` | 精致、专业 | 商业、思想领导力 |
| `warm` | 友好、亲切 | 个人成长、生活方式 |
| `blueprint` | 技术蓝图、等距 3D | 架构、系统设计 |
| `watercolor` | 柔和水彩、自然温暖 | 生活方式、旅行 |
| `editorial` | 杂志风格信息图 | 科技解说、新闻 |

## 色调（Palette）— 配色方案

| 色调 | 说明 | 适用场景 |
|------|------|---------|
| `default` | 蓝色系 | 通用、技术 |
| `warm` | 暖色系（橙、赭、金） | 品牌、生活方式 |
| `macaron` | 马卡龙柔和色 | 教育、知识分享 |
| `mono` | 黑白灰 | 专业、极简 |

## 文章类型预设

| 预设 | 信息类型 | 渲染风格 | 色调 |
|------|---------|---------|------|
| `deep-insight` | framework / infographic | blueprint | default |
| `story-time` | scene | watercolor | warm |
| `hot-take` | comparison / infographic | editorial | default |
| `how-to` | flowchart | notion | default |
| `quick-list` | infographic | elegant | macaron |

## 图片尺寸

| 类型 | 宽度 | 说明 |
|------|------|------|
| 内容图 | 2048x2048 | 生成后缩放到 900px 用于公众号 |
| 封面图 | 2048x2048 | 生成后裁剪到 900x383 |
