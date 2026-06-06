#!/bin/bash
# VideoTranscribe — 统一入口
# 用法：./run.sh -i "video.mp4"
#       ./run.sh -i "https://youtu.be/xxx"
#       ./run.sh -i "video.mp4" -e mlx
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 加载 API Key（如果有）
ENV_FILE="${HOME}/.config/video-transcribe/.env"
if [[ -f "$ENV_FILE" ]]; then
    set -a
    source "$ENV_FILE"
    set +a
fi

# 备选：从 shared-skills 加载
SHARED_ENV="${HOME}/.shared-skills/api-registry/.env"
if [[ -z "${GEMINI_API_KEY:-}" && -f "$SHARED_ENV" ]]; then
    set -a
    source "$SHARED_ENV"
    set +a
fi

exec python3 "${SCRIPT_DIR}/Tools/transcribe.py" "$@"
