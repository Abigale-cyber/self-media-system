# Emma 自媒体内容生产系统

一个模块化的自媒体内容生产工作流。把从「选题」到「发布」的完整链路拆成 6 个独立 Skill，每个 Skill 只做一件事，可单独调用也可串联使用。

## 适用场景

- 需要系统化管理自媒体内容生产的账号
- 需要把选题、成稿、审稿拆开处理的创作者
- 需要统一人设、规范表达的团队

## 核心流程

```
数字分身 → 生成选题 → 内容大纲 → 大纲扩写/口播脚本 → 内容审稿 → 公众号工作台
```

## Skill 清单

| Skill | 作用 | 典型输出 |
| --- | --- | --- |
| `digital-avatar` | 固定账号的人设、口吻、专业边界和禁用表达 | 人设规则、表达边界 |
| `topic-generator` | 资料盘点访谈，生成候选选题并排序推荐 Top 3 | 选题池、Top 3 推荐 |
| `content-outline-builder` | 把选题整理成可写作的文章大纲 | 大纲（含 SCQA + 章节） |
| `outline-expander` | 按大纲写公众号长文，支持标题/开头/结尾优化和润色 | 文章初稿 |
| `voice-script-generator` | 大纲或文章转口播稿（60s/90s/180s）+ 分镜建议 + 封面标题 | 口播稿 |
| `content-image-gen` | 生成封面图和正文配图 | 图片文件 |
| `content-reviewer` | 内容审稿（三角色对抗式）+ 医美合规检查 | 审稿报告 |
| `wechat-studio` | 公众号工作台：Markdown 导入、HTML 预览、主题调整、草稿箱推送 | 本地预览 |

## 目录结构

```
self-media-system/
├── 01-digital-avatar/              # 人设
├── 02-topic-generator/             # 选题
├── 03-content-outline-builder/     # 大纲
├── 04-outline-expander/            # 长文
├── 04-voice-script-generator/      # 口播
├── 04-content-image-gen/           # 生成配图
├── 05-content-reviewer/            # 审稿+合规
├── 06-wechat-studio/               # 工作台
└── _shared/                        # 公共配置
```

## 使用方式

直接在 Claude Code 中调用 Skill：

```bash
$topic-generator 根据已有资料生成选题并排序
$content-outline-builder 把"眼周抗衰"整理成大纲
$outline-expander 根据大纲写公众号文章
$voice-script-generator 根据大纲写 90 秒口播
$content-reviewer 帮我审稿
```

或者串联使用：

```
digital-avatar → topic-generator → content-outline-builder → outline-expander → content-reviewer → wechat-studio
```

## 配置

在 `.env` 中配置：

| 变量 | 用途 | 必填 |
| --- | --- | --- |
| `ARK_API_KEY` | `content-image-gen` 调用豆包 Seedream 生图 | 是 |
| `WECHAT_APP_ID` | 公众号草稿箱推送 | 推送时必填 |
| `WECHAT_APP_SECRET` | 公众号草稿箱推送 | 推送时必填 |

## 注意事项

- 医美内容必须经过 `content-reviewer` 的合规检查
- 审稿结论为"需重写"时，不自动重写，交由用户决定
- 工作台是人工确认环节，不做自动发布
