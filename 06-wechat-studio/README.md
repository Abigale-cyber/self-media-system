# wechat-studio

`wechat-studio` 是 self-media-system 的公众号工作台，对应 ClawHub 发布名 `content-system-wechat-studio`。它用于 Markdown 导入、公众号 HTML 预览、主题微调、封面和配图确认，以及可选的公众号草稿箱推送。

## 能做什么

- 导入 `outline-expander` 产出的 Markdown。
- 承接内容审稿后的成稿。
- 管理 `content-image-gen` 生成的封面图和正文配图。
- 在本地预览公众号样式，调整主题、字号、标题样式和图片位置。
- 人工确认后，按本机已配置的公众号能力推送草稿箱。

## 启动

```bash
python3 "$HOME/.agents/skills/self-media-system/06-wechat-studio/frontend/server.py"
```

打开：

```text
http://127.0.0.1:4173
```

首次使用前安装前端依赖：

```bash
cd "$HOME/.agents/skills/self-media-system/06-wechat-studio/frontend"
npm install
```

## 输入和输出

**输入**

- `article-draft.md`
- `publish-pack.md` 或 `publish-pack.json`
- 封面图、正文配图、图片 Prompt

**输出**

- 本地预览页面：`http://127.0.0.1:4173`
- 文章工作区：`06-wechat-studio/content/articles/<slug>/`
- 工作台状态：`studio-state.json`
- 可选公众号草稿箱草稿

## 图片配置

工作台设置页里的图片默认值只用于工作台内的可选生图能力。`content-image-gen` 当前以 `../_shared/env-config.md` 和本地脚本为准。

不要把工作台图片配置当成 `content-image-gen` 的真实运行配置；两边没有统一前，只在发布包里记录实际使用的图片路径和 Prompt。

## 使用流程

1. 导入公众号 Markdown 主稿。
2. 检查标题、摘要、封面图方向和正文结构。
3. 调整主题、字号、图片圆角、封面和正文配图。
4. 预览手机阅读效果。
5. 人工确认后，再决定是否推送公众号草稿箱。

## 注意事项

- 这是工作台 Skill，不是全自动发布器。
- 未配置公众号发布能力时，只做本地预览和发布包整理。
- 推送草稿箱前仍需要人工检查标题、封面、摘要和图片引用。
- 医美内容进入工作台前，应先经过 `content-reviewer`。

## 相关文件

- [SKILL.md](./SKILL.md)
- [skill.json](./skill.json)
- [frontend/server.py](./frontend/server.py)
- [frontend/index.html](./frontend/index.html)
