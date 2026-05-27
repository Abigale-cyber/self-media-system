#!/usr/bin/env bash
# generate.sh — content-image-gen 主入口
# 用法: ./generate.sh --prompt "场景描述" [--preset deep-insight] [--type scene] [--style blueprint] [--palette default] [--size 1024x1024] [--output ./output.png]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 依赖检查
for dep in curl jq base64; do
  if ! command -v "$dep" &>/dev/null; then
    echo "ERROR: Missing dependency: $dep" >&2
    echo "Install:" >&2
    echo "  macOS:  brew install $dep" >&2
    echo "  Ubuntu: sudo apt install -y $dep" >&2
    echo "  Docker: RUN apt-get update && apt-get install -y $dep" >&2
    exit 1
  fi
done

# 加载依赖
source "$SCRIPT_DIR/lib/config.sh"
source "$SCRIPT_DIR/lib/providers/seedream.sh"

# 默认值
PROMPT=""
PRESET=""
IMG_TYPE=""
IMG_STYLE=""
IMG_PALETTE=""
SIZE="2048x2048"
OUTPUT=""

# 预设映射表
get_preset_defaults() {
  case "$1" in
    deep-insight)  echo "framework blueprint default" ;;
    story-time)    echo "scene watercolor warm" ;;
    hot-take)      echo "comparison editorial default" ;;
    how-to)        echo "flowchart notion default" ;;
    quick-list)    echo "infographic elegant macaron" ;;
    *)             echo "scene notion default" ;;
  esac
}

# 维度→prompt 关键词
get_type_keyword() {
  case "$1" in
    scene)       echo "" ;;
    framework)   echo "concept map relationship diagram" ;;
    flowchart)   echo "flowchart step-by-step process diagram" ;;
    comparison)  echo "side-by-side comparison illustration" ;;
    infographic) echo "data visualization infographic" ;;
    *)           echo "" ;;
  esac
}

get_style_keyword() {
  case "$1" in
    notion)      echo "minimalist hand-drawn line art" ;;
    elegant)     echo "refined sophisticated illustration" ;;
    warm)        echo "friendly approachable warm illustration" ;;
    blueprint)   echo "technical schematic isometric 3D blueprint" ;;
    watercolor)  echo "soft watercolor painting natural warmth" ;;
    editorial)   echo "magazine-style infographic" ;;
    *)           echo "" ;;
  esac
}

get_palette_keyword() {
  case "$1" in
    default)     echo "blue and white color scheme" ;;
    warm)        echo "warm earth tones orange ochre gold" ;;
    macaron)     echo "soft pastel macaron colors" ;;
    mono)        echo "black and white grayscale monochrome" ;;
    *)           echo "clean color scheme" ;;
  esac
}

# 参数解析
while [[ $# -gt 0 ]]; do
  case "$1" in
    --prompt)   PROMPT="$2"; shift 2 ;;
    --preset)   PRESET="$2"; shift 2 ;;
    --type)     IMG_TYPE="$2"; shift 2 ;;
    --style)    IMG_STYLE="$2"; shift 2 ;;
    --palette)  IMG_PALETTE="$2"; shift 2 ;;
    --size)     SIZE="$2"; shift 2 ;;
    --output)   OUTPUT="$2"; shift 2 ;;
    *)          echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

# 校验 prompt
if [[ -z "$PROMPT" ]]; then
  echo "ERROR: --prompt is required" >&2
  exit 1
fi

# 预设填充默认维度
if [[ -n "$PRESET" ]]; then
  read -r default_type default_style default_palette <<< "$(get_preset_defaults "$PRESET")"
  IMG_TYPE="${IMG_TYPE:-$default_type}"
  IMG_STYLE="${IMG_STYLE:-$default_style}"
  IMG_PALETTE="${IMG_PALETTE:-$default_palette}"
fi

# 兜底默认值
IMG_TYPE="${IMG_TYPE:-scene}"
IMG_STYLE="${IMG_STYLE:-notion}"
IMG_PALETTE="${IMG_PALETTE:-default}"

# 构造完整 prompt
type_kw=$(get_type_keyword "$IMG_TYPE")
style_kw=$(get_style_keyword "$IMG_STYLE")
palette_kw=$(get_palette_keyword "$IMG_PALETTE")

# 组合：[Style] [Type] illustration of [scene], [Palette], clean and modern, WeChat article
FULL_PROMPT="${style_kw}"
[[ -n "$type_kw" ]] && FULL_PROMPT="${FULL_PROMPT} ${type_kw}"
FULL_PROMPT="${FULL_PROMPT} illustration of ${PROMPT}, ${palette_kw}, clean and modern style, suitable for WeChat article"

echo "DIMENSIONS: type=$IMG_TYPE style=$IMG_STYLE palette=$IMG_PALETTE" >&2
echo "FULL PROMPT: $FULL_PROMPT" >&2

# 加载配置
if ! load_config; then
  exit 1
fi

# 生成输出路径
if [[ -z "$OUTPUT" ]]; then
  TIMESTAMP=$(date +%Y%m%d-%H%M%S)
  OUTPUT="./image-${TIMESTAMP}.png"
fi

# 确保输出目录存在
mkdir -p "$(dirname "$OUTPUT")"

# 调用 provider
echo "Generating with Seedream ($SEEDREAM_IMAGE_MODEL)..." >&2
if seedream_generate "$FULL_PROMPT" "$SEEDREAM_IMAGE_MODEL" "$SIZE" "$OUTPUT"; then
  echo "$OUTPUT"
else
  exit 1
fi
