#!/bin/bash
CUR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
source "${CUR_DIR}/.env"

bash "$CUR_DIR/install-bun.sh"
if [[ "max-inference" == "${AGENT_INFERENCE_SERVER}" ]]; then
  mkdir -p ~/.cache/max_cache
fi

if [[ "openrouter" != "${AGENT_INFERENCE_SERVER}" && "z-ai" != "${AGENT_INFERENCE_SERVER}" ]]; then
  docker compose -f "$CUR_DIR/docker-compose.yaml" up --force-recreate -d ${AGENT_INFERENCE_SERVER}
fi 

mkdir -p ~/.claude-code-router
cat <<EOT > ~/.claude-code-router/config.json
{
  "LOG": true,
  "LOG_LEVEL": "error",
  "API_TIMEOUT_MS": 3600000,
  "NON_INTERACTIVE_MODE": false,
  "Providers": [
    {
      "name": "max-inference",
      "api_base_url": "http://127.0.0.1:8100/v1/chat/completions",
      "api_key": "max-inference",
      "models": ["noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF"]
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
      ],
      "transformer": {
        "use": ["tooluse"]
      }
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
          "glm-4.7", 
          "glm-4.7-flash", 
          "glm-4.7-flashx"
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
        "perplexity/sonar",
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
    "default": "${AGENT_INFERENCE_SERVER},${AGENT_MAIN_MODEL}",
    "background": "${AGENT_INFERENCE_SERVER},${AGENT_BACKGROUND_MODEL}",
    "think": "${AGENT_INFERENCE_SERVER},${AGENT_BACKGROUND_MODEL}",
    "longContext": "${AGENT_INFERENCE_SERVER},${AGENT_BACKGROUND_MODEL}",
    "longContextThreshold": 131072,
    "webSearch": "${AGENT_INFERENCE_SERVER},${AGENT_MAIN_MODEL}"
  }
}
EOT



ccr stop || true

screen -L -Logfile /tmp/ccr-server.log -dmS ccr-server ccr start
screen -list