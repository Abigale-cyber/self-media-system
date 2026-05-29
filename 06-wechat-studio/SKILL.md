---
name: wechat-studio
description: 当需要启动本地公众号文章工作台，用于 Markdown 导入、公众号 HTML 预览、主题调整、图片选择、人工确认和可选草稿箱推送时使用。
---

# wechat-studio

`wechat-studio` 是内容成稿到最终发布之间的人工确认工作台。在 ClawHub 上发布名为 `content-system-wechat-studio`。

## 快速启动

安装工作台前端依赖：

```bash
cd "$HOME/.agents/skills/self-media-system/06-wechat-studio/frontend"
npm install
```

启动本地服务：

```bash
python3 "$HOME/.agents/skills/self-media-system/06-wechat-studio/frontend/server.py"
```

在浏览器打开工作台：

```text
http://127.0.0.1:4173
```

设置页里的图片默认值只用于工作台内的可选生图能力；`content-image-gen` 当前以 `../_shared/env-config.md` 和本地脚本配置为准，两者不要互相假设。

```text
provider: openai
api base: https://new.suxi.ai/v1
model: nano-nx
```

## 适合什么时候用

- 发布前需要本地公众号预览
- 需要把 Markdown 导入成可复用的文章工作区
- 需要人工调整主题、字号、排版和布局
- 需要检查封面图或正文配图位置
- 需要把确认后的文章推送到公众号草稿箱

## 默认流程

1. 启动本地服务，并打开工作台。
2. 导入 Markdown 文章，或切换到已有文章工作区。
3. 检查生成的公众号预览和文章元信息。
4. 调整主题、字号、封面图和正文配图。
5. 如有需要，把最终确认版本推送到公众号草稿箱。

通过设置页区分：

- 当前 `md2wechat` 配置里的图片参数
- `content-image-gen` 运行时实际使用的图片参数

## 相关 Skill

- `outline-expander`：负责公众号长文成稿
- `content-image-gen`：负责封面图和正文配图 Prompt/图片
删除以下 Skill 引用（因为已删除）：
- `content-reviewer`：负责内容审稿和合规检查

## 注意事项

- 这是一个工作台 Skill，不是一次性自动执行器。
- 推送草稿箱依赖本地已经配置好公众号发布能力。
- 文章工作区位于 `06-wechat-studio/content/articles/`。
- 如果使用工作台内置生图能力，需要在设置页填入对应图片服务的 token；如果只导入已有图片和 Markdown，可以不配置。

## 最小验收

- 能启动 `frontend/server.py` 并打开 `http://127.0.0.1:4173`。
- 能导入 `outline-expander` 产出的 Markdown。
- 能展示公众号预览、标题、摘要、封面图和正文配图位置。
- 未配置草稿箱推送时，不自动发布，只保留本地预览和发布包。
