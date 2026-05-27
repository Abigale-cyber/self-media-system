#!/usr/bin/env bash
# config.sh — 环境变量加载，兼容本系统和旧 writing-skills 配置
# 优先级：CLI env > SELF_MEDIA_SYSTEM_ENV > 项目级 .env > 用户级 .env > 旧配置

load_config() {
  # 默认值
  SEEDREAM_IMAGE_MODEL="${SEEDREAM_IMAGE_MODEL:-doubao-seedream-5-0-260128}"
  SEEDREAM_BASE_URL="${SEEDREAM_BASE_URL:-https://ark.cn-beijing.volces.com/api/v3}"

  # 如果 ARK_API_KEY 已设置（CLI env 或 process.env），直接使用
  if [[ -n "${ARK_API_KEY:-}" ]]; then
    return 0
  fi

  if [[ -n "${SELF_MEDIA_SYSTEM_ENV:-}" && -f "$SELF_MEDIA_SYSTEM_ENV" ]]; then
    source "$SELF_MEDIA_SYSTEM_ENV"
    if [[ -n "${ARK_API_KEY:-}" ]]; then
      return 0
    fi
  fi

  # 项目级 .env
  local project_env="$(pwd)/.self-media-system/.env"
  if [[ -f "$project_env" ]]; then
    source "$project_env"
    if [[ -n "${ARK_API_KEY:-}" ]]; then
      return 0
    fi
  fi

  # 用户级 .env
  local user_env="$HOME/.self-media-system/.env"
  if [[ -f "$user_env" ]]; then
    source "$user_env"
    if [[ -n "${ARK_API_KEY:-}" ]]; then
      return 0
    fi
  fi

  # 兼容旧 writing-skills 套件配置
  local legacy_project_env="$(pwd)/.writing-skills/.env"
  if [[ -f "$legacy_project_env" ]]; then
    source "$legacy_project_env"
    if [[ -n "${ARK_API_KEY:-}" ]]; then
      return 0
    fi
  fi

  local legacy_user_env="$HOME/.writing-skills/.env"
  if [[ -f "$legacy_user_env" ]]; then
    source "$legacy_user_env"
    if [[ -n "${ARK_API_KEY:-}" ]]; then
      return 0
    fi
  fi

  # 都没找到
  echo "ERROR: ARK_API_KEY not found." >&2
  echo "Set it in one of:" >&2
  echo "  1. Environment variable: export ARK_API_KEY=xxx" >&2
  echo "  2. Explicit env file: export SELF_MEDIA_SYSTEM_ENV=/path/to/.env" >&2
  echo "  3. Project config: .self-media-system/.env" >&2
  echo "  4. User config: ~/.self-media-system/.env" >&2
  return 1
}
