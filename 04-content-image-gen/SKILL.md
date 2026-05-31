---
name: content-image-gen
description: 为 self-media-system 生成配图。支持类型×风格×色板三维选择和文章类型预设。当用户说"生成配图"、"做封面图"、"给文章配图"时使用。可被 wechat-studio 工作台调用。
---

# content-image-gen

## 触发条件

- 用户说"生成配图"、"做封面图"、"给文章配图"
- wechat-studio 需要生成封面图或正文配图时调用
- 用户说"帮我做一张图"

**不触发：**
- "写文章" → 大纲扩写（`outline-expander`）
- "发草稿箱" → 公众号工作台（`wechat-studio`）
- "改标题" → 大纲扩写（`outline-expander`）

## 不做什么

- 不写文章、不改文章
- 不做排版、不做 HTML 转换
- 不做发布
- 不编辑图片（不裁剪、不压缩）

## 执行流程

### 步骤 1：确定维度

读取 article-draft.md 头部的 `文章预设` 和 `适用账号` 字段，并读取 `../_shared/account-mode-guide.md`，匹配默认维度组合。

- 认证医生号：画面可呈现专业工作状态、判断流程或清晰信息图，不暗示固定疗效。
- 非认证人格号：画面优先生活、工作观察或女性状态场景，不包装成诊疗或机构宣传。

如无预设，或用户显式指定，接受：
- `--type`: scene | framework | flowchart | comparison | infographic
- `--style`: notion | elegant | warm | blueprint | watercolor | editorial
- `--palette`: default | warm | macaron | mono

### 步骤 2：构造提示词

读取 `references/prompt-templates.md`，按公式组装：

```
{style_keyword} {type_keyword} illustration of {场景描述}, {palette_keyword}, clean and modern style, suitable for WeChat article
```

### 步骤 3：调用生图脚本

读取 `../_shared/env-config.md`，确认 `ARK_API_KEY` 和 Seedream 默认参数。

```bash
# 通过 skill 相对路径调用
scripts/generate.sh \
  --prompt "{场景描述}" \
  --preset {文章预设} \
  --output {输出路径}
```

脚本自动：
1. 加载 ARK_API_KEY（读取 `../_shared/env-config.md` 的优先级链）
2. 解析维度 → 构造完整提示词
3. 调用豆包 Seedream API（3 次重试）
4. 下载/解码图片到本地
5. 标准输出返回文件路径

### 步骤 4：返回结果

返回生成的图片路径。多张图时多次调用。

如果没有配置 `ARK_API_KEY`，只输出图片方向和可复制提示词。面向用户或写入 Markdown 文档时，每条可复制提示词必须单独放进代码块：

```text
生成一张……
```

不要把多条提示词混在同一个代码块里，方便用户逐条点击复制。
代码块内默认按句子或语义短句手动换行，避免出现很长的横向滚动行；复制后保留换行也可以正常作为生图提示词使用。

## 命令行用法（CLI）

```bash
# 按文章预设生成（自动匹配维度）
scripts/generate.sh --prompt "杂乱的电脑桌面堆满文件" --preset deep-insight --output ./images/cover.png

# 手动指定维度
scripts/generate.sh --prompt "食材到成品的转化过程" --type framework --style blueprint --palette default --output ./images/content1.png

# 最简模式（默认 scene/notion/default）
scripts/generate.sh --prompt "一个人对着屏幕犹豫" --output ./images/scene.png
```

## 约束规则

- 必须先确认 ARK_API_KEY 可用，否则提示用户配置
- 单篇文章不超过 5 张图
- 生成尺寸统一 2048x2048，后续由发布流程裁剪
- 面向用户输出的可复制提示词主体使用中文；脚本内部如需英文关键词，由脚本或模板自行处理
- 输出路径由调用方指定，不自动猜测
- 图片不得包含疗效承诺、夸张前后对比或与账号模式冲突的医疗暗示
