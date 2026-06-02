# self-media-system 环境配置

本文件只记录配置读取规则，不保存真实密钥。

## 凭证读取优先级

1. CLI 环境变量
2. 当前进程环境变量
3. 项目级 `.self-media-system/.env`
4. 用户级 `~/.self-media-system/.env`
5. 用户在本地工具或运行环境中手动填写的 token

## 生图能力

`content-image-gen` 当前脚本使用豆包 Seedream：

| 变量 | 说明 | 默认值 |
| --- | --- | --- |
| `ARK_API_KEY` | 火山引擎 ARK API Key | 无 |
| `SEEDREAM_IMAGE_MODEL` | Seedream 模型 | `doubao-seedream-5-0-260128` |
| `SEEDREAM_BASE_URL` | ARK API 地址 | `https://ark.cn-beijing.volces.com/api/v3` |

## 缺少配置时

| 场景 | 处理方式 |
| --- | --- |
| 缺少 `ARK_API_KEY` | 不调用生图脚本，先输出可复制的图片 Prompt 和配置提示 |
