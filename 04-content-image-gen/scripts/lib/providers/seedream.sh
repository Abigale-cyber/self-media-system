#!/usr/bin/env bash
# seedream.sh — 豆包 Seedream 生图 Provider

seedream_generate() {
  local prompt="$1"
  local model="$2"
  local size="$3"
  local output_path="$4"
  local response_json="${output_path%.png}.json"

  # 用 jq 构造 JSON body（安全转义中文和特殊字符）
  local request_body
  request_body=$(jq -n \
    --arg model "$model" \
    --arg prompt "$prompt" \
    --arg size "$size" \
    '{
      model: $model,
      prompt: $prompt,
      size: $size
    }')

  local max_attempts=3
  local attempt=1

  while [[ $attempt -le $max_attempts ]]; do
    local http_code
    http_code=$(curl -s -w "%{http_code}" -o "$response_json" \
      -X POST "${SEEDREAM_BASE_URL}/images/generations" \
      -H "Content-Type: application/json" \
      -H "Authorization: Bearer ${ARK_API_KEY}" \
      -d "$request_body")

    # 成功
    if [[ "$http_code" == "200" ]]; then
      # 检查返回格式：URL 模式 or b64_json 模式
      local url_field
      url_field=$(jq -r '.data[0].url // empty' "$response_json" 2>/dev/null)

      if [[ -n "$url_field" ]]; then
        # URL 模式：下载图片
        curl -s -o "$output_path" "$url_field"
        if [[ $? -eq 0 && -s "$output_path" ]]; then
          rm -f "$response_json"
          return 0
        fi
      else
        # b64_json 模式：解码
        local b64_data
        b64_data=$(jq -r '.data[0].b64_json // empty' "$response_json" 2>/dev/null)
        if [[ -n "$b64_data" ]]; then
          echo "$b64_data" | base64 -d > "$output_path"
          if [[ $? -eq 0 && -s "$output_path" ]]; then
            rm -f "$response_json"
            return 0
          fi
        fi
      fi

      # 200 但解析失败
      echo "ERROR: HTTP 200 but failed to extract image from response" >&2
      jq . "$response_json" >&2
      rm -f "$response_json"
      return 1
    fi

    # 错误处理
    local error_body
    error_body=$(cat "$response_json" 2>/dev/null)

    case "$http_code" in
      401|403)
        echo "ERROR: Authentication failed (HTTP $http_code). Check ARK_API_KEY." >&2
        echo "$error_body" >&2
        rm -f "$response_json"
        return 1
        ;;
      429)
        echo "WARN: Rate limited (HTTP 429). Attempt $attempt/$max_attempts. Waiting 5s..." >&2
        sleep 5
        ;;
      5*)
        echo "WARN: Server error (HTTP $http_code). Attempt $attempt/$max_attempts. Waiting 2s..." >&2
        sleep 2
        ;;
      *)
        echo "ERROR: Unexpected HTTP $http_code" >&2
        echo "$error_body" >&2
        rm -f "$response_json"
        return 1
        ;;
    esac

    attempt=$((attempt + 1))
  done

  echo "ERROR: Failed after $max_attempts attempts" >&2
  rm -f "$response_json"
  return 1
}
