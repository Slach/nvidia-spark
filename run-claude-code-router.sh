#!/bin/bash
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"

bash "$CUR_DIR/install-bun.sh"
if [[ "max-inference" == "${AGENT_INFERENCE_SERVER}" ]]; then
  mkdir -p ~/.cache/max_cache
fi

if [[ "openrouter" != "${AGENT_INFERENCE_SERVER}" && "z-ai" != "${AGENT_INFERENCE_SERVER}" ]]; then
  docker compose -f "$CUR_DIR/docker-compose.yaml" up --force-recreate -d --wait --wait-timeout 3600 ${AGENT_INFERENCE_SERVER}
fi

mkdir -p ~/.claude-code-router

CCR_ACTIVE_MODEL="${AGENT_INFERENCE_SERVER}/${AGENT_MAIN_MODEL}"
CCR_BACKGROUND_MODEL="${AGENT_INFERENCE_SERVER}/${AGENT_BACKGROUND_MODEL}"

cat <<EOT > ~/.claude-code-router/config.json
{
  "LOG": true,
  "LOG_LEVEL": "error",
  "API_TIMEOUT_MS": 3600000,
  "NON_INTERACTIVE_MODE": false,
  "HOST": "127.0.0.1",
  "PORT": 3456,
  "routerEndpoint": "http://127.0.0.1:3456",
  "Providers": [
    {
      "name": "max-inference",
      "api_base_url": "http://127.0.0.1:8100/v1/chat/completions",
      "api_key": "max-inference",
      "models": ["noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF"]
    },
    {
      "name": "ds4-sparkinfer",
      "api_base_url": "http://127.0.0.1:8000/v1/chat/completions",
      "api_key": "ds4-sparkinfer",
      "models": [
        "${ATLAS_MODEL}"
      ]
    },
    {
      "name": "atlas",
      "api_base_url": "http://127.0.0.1:30003/v1/chat/completions",
      "api_key": "atlas",
      "models": [
        "${ATLAS_MODEL}"
      ]
    },
    {
      "name": "paroquant",
      "api_base_url": "http://127.0.0.1:30002/v1/chat/completions",
      "api_key": "paroquant",
      "models": [
        "${PAROQUANT_MODEL}"
      ]
    },
    {
      "name": "vllm",
      "api_base_url": "http://127.0.0.1:30001/v1/chat/completions",
      "api_key": "vllm",
      "models": [
        "${VLLM_MODEL}"
      ]
    },
    {
      "name": "sglang",
      "api_base_url": "http://127.0.0.1:30000/v1/chat/completions",
      "api_key": "sglang",
      "models": [
        "${SGLANG_MODEL}"
      ]
    },
    {
      "name": "llama.cpp",
      "api_base_url": "http://127.0.0.1:8090/v1/chat/completions",
      "api_key": "llama.cpp",
      "models": [
        "${AGENT_MAIN_MODEL}",
        "${AGENT_BACKGROUND_MODEL}",
        "unsloth/Qwen3.5-120B",
        "unsloth/Qwen3.5-27B",
        "unsloth/GLM-4.7-Flash-30B",
        "Qwen/Qwen3-Coder-Next-80B-Q8",
        "noctrex/Qwen3.5-35B",
        "noctrex/Qwen3-Next-80B"
      ]
    },
    {
      "name":"z-ai",
      "api_base_url": "https://api.z.ai/api/paas/v4/completions",
      "api_key": "${ZAI_API_KEY}",
      "models": [
          "glm-5.1",
          "glm-4.7"
      ]
    },
    {
      "name": "openrouter",
      "api_base_url": "https://openrouter.ai/api/v1/chat/completions",
      "api_key": "${OPENROUTER_API_KEY}",
      "models": [
        "mistralai/devstral-2512:free",
        "xiaomi/mimo-v2-flash:free",
        "google/gemini-3.1-flash-lite-preview",
        "google/gemini-3.1-pro-preview-customtools",
        "minimax/minimax-m2.5",
        "x-ai/grok-4.1-fast",
        "z-ai/glm-5",
        "qwen/qwen3.5-flash-02-23",
        "moonshotai/kimi-k2.5",
        "deepseek/deepseek-v3.2-speciale",
        "perplexity/sonar"
      ],
      "transformer": {
        "use": ["openrouter","tooluse"]
      }
    },
    {
      "name": "deepseek",
      "api_base_url": "https://api.deepseek.com/chat/completions",
      "api_key": "${DEEPSEEK_API_KEY}",
      "models": ["deepseek-chat", "deepseek-reasoner"],
      "transformer": {
        "use": ["deepseek"],
        "deepseek-chat": {
          "use": ["tooluse"]
        }
      }
    }
  ],
  "Router": {
    "builtInRules": {
      "claude-code": { "enabled": true },
      "codex": { "enabled": true }
    },
    "fallback": {
      "mode": "retry",
      "retryCount": 2,
      "models": [
        "${CCR_BACKGROUND_MODEL}"
      ]
    },
    "rules": []
  },
  "profile": {
    "enabled": true,
    "claudeCode": {
      "enabled": true,
      "model": "${CCR_ACTIVE_MODEL}",
      "sonnetModel": "${CCR_ACTIVE_MODEL}",
      "opusModel": "${CCR_ACTIVE_MODEL}",
      "haikuModel": "${CCR_BACKGROUND_MODEL}",
      "smallFastModel": "${CCR_BACKGROUND_MODEL}",
      "fableModel": "${CCR_BACKGROUND_MODEL}",
      "managedCompact": false,
      "settingsFile": "~/.claude/settings.json"
    },
    "codex": {
      "enabled": false,
      "model": "${CCR_ACTIVE_MODEL}",
      "providerId": "claude-code-router",
      "providerName": "Claude Code Router",
      "cliMiddleware": true,
      "configFormat": "separate_profile_files",
      "configFile": "~/.codex/config.toml",
      "managedCompact": false,
      "showAllSessions": false
    },
    "profiles": [
      {
        "id": "default-claude-code",
        "name": "Claude Code",
        "agent": "claude-code",
        "enabled": true,
        "scope": "global",
        "surface": "auto",
        "model": "${CCR_ACTIVE_MODEL}",
        "sonnetModel": "${CCR_ACTIVE_MODEL}",
        "opusModel": "${CCR_ACTIVE_MODEL}",
        "haikuModel": "${CCR_BACKGROUND_MODEL}",
        "smallFastModel": "${CCR_BACKGROUND_MODEL}",
        "fableModel": "${CCR_BACKGROUND_MODEL}",
        "managedCompact": false,
        "settingsFile": "~/.claude/settings.json"
      }
    ]
  }
}
EOT

# claude CLI with CLAUDE_CONFIG_DIR=~/.claude looks for ~/.claude/.claude.json,
# but the real config lives at ~/.claude.json. Mirror it so ccr's profile wrapper works.
[[ -f ~/.claude.json ]] && cp ~/.claude.json ~/.claude/.claude.json

ccr stop || true

CCR_DB=~/.claude-code-router/config.sqlite
rm -f "$CCR_DB" "$CCR_DB-shm" "$CCR_DB-wal"

screen -L -Logfile /tmp/ccr-server.log -dmS ccr-server ccr start --no-open
sleep 2
screen -list
echo
echo "Web UI:   http://127.0.0.1:3458"
echo "Gateway:  http://127.0.0.1:3456"
echo "Prompt:   ccr default-claude-code -- -p '...'   |   claude -p '...'"