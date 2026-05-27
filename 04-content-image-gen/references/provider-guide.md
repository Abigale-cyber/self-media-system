# Provider 指南

## Seedream（豆包）— 当前唯一 Provider

### API 信息

| 项目 | 值 |
|------|---|
| Endpoint | `POST ${SEEDREAM_BASE_URL}/images/generations` |
| 认证 | `Authorization: Bearer ${ARK_API_KEY}` |
| 模型 | `doubao-seedream-5-0-260128`（默认） |
| 请求格式 | JSON |
| 响应格式 | URL 或 b64_json |

### 请求体

```json
{
  "model": "doubao-seedream-5-0-260128",
  "prompt": "图片描述",
  "size": "2048x2048"
}
```

### 支持的尺寸

Seedream 要求图片至少 3,686,400 像素（如 2048x2048、1920x1080 不够）。
推荐统一使用 `2048x2048`，后续裁剪到目标尺寸。

### 错误码

| HTTP 状态 | 含义 | 处理 |
|-----------|------|------|
| 200 | 成功 | 提取 .data[0].url 或 .data[0].b64_json |
| 400 | 参数错误 | 检查 size、prompt 格式 |
| 401/403 | 认证失败 | 检查 ARK_API_KEY |
| 429 | 限流 | 等待 5 秒重试 |
| 500+ | 服务端错误 | 等待 2 秒重试 |

## OpenAI DALL-E（待实现）

| 项目 | 值 |
|------|---|
| Endpoint | `POST https://api.openai.com/v1/images/generations` |
| 认证 | `Authorization: Bearer ${OPENAI_API_KEY}` |
| 模型 | `gpt-image-1` |
| 状态 | 仅占位，未实现 |
