# Emma 自媒体内容生产系统

一个模块化的自媒体内容生产工作流。把从「人设」到「选题、成稿、审稿、复盘」的链路拆成独立 Skill，每个 Skill 只做一件事，可单独调用也可串联使用。

## 适用场景

- 需要系统化管理自媒体内容生产的账号
- 需要把选题、成稿、审稿拆开处理的创作者
- 需要统一人设、规范表达的团队

## 核心流程

```
面诊素材提炼/数字分身 → 生成选题/爆款拆解 → 内容大纲 → 大纲扩写/口播脚本/生成配图 → 内容审稿 → 数据复盘
```

## Skill 清单

| Skill | 作用 | 典型输出 |
| --- | --- | --- |
| `consultation-material-extractor` | 从面诊转写、分说话人文字或咨询对话中提炼长期可复用素材 | 4 类素材表 |
| `digital-avatar` | 固定账号的人设、口吻、专业边界和禁用表达 | 人设规则、表达边界 |
| `topic-generator` | 资料盘点访谈，生成候选选题并排序推荐 Top 3 | 选题池、Top 3 推荐 |
| `viral-content-breakdown` | 拆解对标内容、爆款作品、热门截图或脚本，提炼可迁移方法 | 爆款拆解报告 |
| `content-outline-builder` | 把选题整理成可写作的文章大纲 | 大纲（含 SCQA + 章节） |
| `outline-expander` | 按大纲写公众号长文，支持标题/开头/结尾优化和润色 | 文章初稿 |
| `voice-script-writer` | 大纲、文章或素材转口播稿、分镜、封面标题、发布标题、标签和评论引导 | 口播稿 |
| `content-image-gen` | 生成封面图和正文配图 | 图片文件 |
| `adversarial-content-review` | 发布前内容审稿、合规检查和风险表达修订 | 审稿结论与修订建议 |
| `data-analysis` | 分析已发布内容的数据、反馈和下一轮优化方向 | 数据复盘报告 |

## 目录结构

```
self-media-system/
├── 01-digital-avatar/              # 人设
├── 01-consultation-material-extractor/ # 面诊素材提炼
├── 02-topic-generator/             # 选题
├── 02-viral-content-breakdown/      # 爆款拆解
├── 03-content-outline-builder/     # 大纲
├── 04-outline-expander/            # 长文
├── 04-voice-script-writer/         # 口播
├── 04-content-image-gen/           # 生成配图
├── 05-adversarial-content-review/  # 审稿+合规
├── 06-data-analysis/               # 数据复盘
└── _shared/                        # 公共配置
```

## 使用方式

直接在 Claude Code 中调用 Skill：

```bash
$consultation-material-extractor 整理这段面诊转写
$digital-avatar 更新 Emma 数字分身规则卡
$topic-generator 根据已有资料生成选题并排序
$viral-content-breakdown 拆解这条爆款视频
$content-outline-builder 把"眼周抗衰"整理成大纲
$outline-expander 根据大纲写公众号文章
$voice-script-writer 根据大纲写 90 秒口播
$adversarial-content-review 帮我审稿
$data-analysis 复盘这条内容的数据
```

或者串联使用：

```
consultation-material-extractor/digital-avatar → topic-generator/viral-content-breakdown → content-outline-builder → outline-expander/voice-script-writer/content-image-gen → adversarial-content-review → data-analysis
```

## 配置

在 `.env` 中配置：

| 变量 | 用途 | 必填 |
| --- | --- | --- |
| `ARK_API_KEY` | `content-image-gen` 调用豆包 Seedream 生图 | 是 |

## 注意事项

- 医美内容必须经过 `adversarial-content-review` 的合规检查
- 审稿结论为"需重写"时，不自动重写，交由用户决定
- `data-analysis` 只处理已发布内容的数据和反馈，不负责发布或生成发布包
