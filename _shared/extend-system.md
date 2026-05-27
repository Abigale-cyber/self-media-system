# self-media-system 定制说明

所有子 Skill 可通过项目级或用户级配置补充品牌、排版和凭证信息，但不得覆盖医美安全边界。

## 加载优先级

1. 项目级 `<cwd>/.self-media-system/<skill-name>/EXTEND.md`
2. 用户级 `~/.self-media-system/<skill-name>/EXTEND.md`
3. Skill 内置规则和 `_shared/` 默认规则

## 可定制项

```yaml
品牌:
  作者名: string
  账号名称: string
  默认作者简介: string

排版:
  字号: 15
  字体颜色: "#333333"
  加粗颜色: "#2f6f9f"
  行高: 2
  段间距: 15px

配图:
  默认预设: deep-insight
  自定义提示词前缀: string
  默认尺寸: 2048x2048

凭证:
  ARK_API_KEY: string
  WECHAT_APP_ID: string
  WECHAT_APP_SECRET: string
```

## 禁止覆盖

- 不允许把“疗效承诺、绝对化表达、焦虑营销”设为允许。
- 不允许虚构 Emma 的资质、履历、案例或门店。
- 不允许把 `wechat-studio` 改成全自动发布流程；必须保留人工确认。
