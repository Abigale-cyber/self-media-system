# Prompt 模板

## 维度→关键词映射

### Type → Prompt 关键词

| 类型 | Prompt 关键词 |
|------|-------------|
| `scene` | _(无额外关键词，由场景描述决定)_ |
| `framework` | `concept map relationship diagram` |
| `flowchart` | `flowchart step-by-step process diagram` |
| `comparison` | `side-by-side comparison illustration` |
| `infographic` | `data visualization infographic` |

### Style → Prompt 关键词

| 风格 | Prompt 关键词 |
|------|-------------|
| `notion` | `minimalist hand-drawn line art` |
| `elegant` | `refined sophisticated illustration` |
| `warm` | `friendly approachable warm illustration` |
| `blueprint` | `technical schematic isometric 3D blueprint` |
| `watercolor` | `soft watercolor painting natural warmth` |
| `editorial` | `magazine-style infographic` |

### Palette → Prompt 关键词

| 色调 | Prompt 关键词 |
|------|-------------|
| `default` | `blue and white color scheme` |
| `warm` | `warm earth tones orange ochre gold` |
| `macaron` | `soft pastel macaron colors` |
| `mono` | `black and white grayscale monochrome` |

## Prompt 组装公式

```
{style_keyword} {type_keyword} illustration of {scene_description}, {palette_keyword}, clean and modern style, suitable for WeChat article
```

## 示例

### deep-insight 预设 + "食材到成品的转化过程"

```
technical schematic isometric 3D blueprint concept map relationship diagram illustration of ingredient to finished dish transformation process, blue and white color scheme, clean and modern style, suitable for WeChat article
```

### story-time 预设 + "一个人对着电脑屏幕犹豫"

```
soft watercolor painting natural warmth illustration of a person hesitating in front of computer screen, warm earth tones orange ochre gold, clean and modern style, suitable for WeChat article
```

### how-to 预设 + "从选题到发布的四步流程"

```
minimalist hand-drawn line art flowchart step-by-step process diagram illustration of four steps from topic selection to publishing, blue and white color scheme, clean and modern style, suitable for WeChat article
```
