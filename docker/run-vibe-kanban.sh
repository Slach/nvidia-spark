#!/bin/bash

set -e

# Set default model values
DEFAULT_MODEL="noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF"

# Source environment variables if available
if [ -f /root/src/github.com/Slach/nvidia-spark/.env ]; then
  source /root/src/github.com/Slach/nvidia-spark/.env
fi

# Wait for the selected inference service to be available
SERVICE_HOST="${AGENT_INFERENCE_SERVER:-max-inference}"
SERVICE_PORT="8100"

if [ "$SERVICE_HOST" = "llama.cpp" ]; then
  SERVICE_PORT="8090"
fi

echo "Waiting for $SERVICE_HOST service... "
while ! nc -z "$SERVICE_HOST" "$SERVICE_PORT"; do
  sleep 1
done
echo "$SERVICE_HOST service is available"

# Create Claude Code Router config
cat <<EOT > /root/.claude-code-router/config.json
{
  "LOG": false,
  "API_TIMEOUT_MS": 600000,
  "NON_INTERACTIVE_MODE": false,
  "Providers": [
    {
      "name": "max-inference",
      "api_base_url": "${AGENT_HTTP_ENDPOINT:-http://max-inference:8100/v1/chat/completions}",
      "api_key": "EMPTY",
      "models": ["${AGENT_MAIN_MODEL:-noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF}","noctrex/Qwen3-Next-80B","noctrex/Nemotron-3-Nano-30B"]
    },
    {
      "name": "llama.cpp",
      "api_base_url": "http://llama.cpp:8090/v1/chat/completions",
      "api_key": "llama.cpp",
      "models": ["noctrex/MiniMax-M2-139B","noctrex/Qwen3-Next-80B","noctrex/Nemotron-3-Nano-30B"]
    },
    {
      "name": "openrouter",
      "api_base_url": "https://openrouter.ai/api/v1/chat/completions",
      "api_key": "${OPENROUTER_API_KEY}",
      "models": [
        "google/gemini-3-pro-preview",
        "anthropic/claude-sonnet-4.5",
        "x-ai/grok-4.1-fast",
        "qwen/qwen-plus-2025-07-28",
        "qwen/qwen3-coder:exacto",
        "moonshotai/kimi-k2-0905:exacto",
        "deepseek/deepseek-v3.2-speciale",
        "perplexity/sonar",
      ],
      "transformer": {
        "use": ["openrouter"]
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
    "default": "${AGENT_INFERENCE_SERVER:-max-inference},${AGENT_MAIN_MODEL:-noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF}",
    "background": "${AGENT_INFERENCE_SERVER:-max-inference},${AGENT_BACKGROUND_MODEL:-${AGENT_MAIN_MODEL:-noctrex/MiniMax-M2-REAP-139B-A10B-MXFP4_MOE-GGUF}}",
    "think": "openrouter,x-ai/grok-4.1-fast",
    "longContext": "openrouter,x-ai/grok-4.1-fast",
    "longContextThreshold": 98304,
    "webSearch": "openrouter,perplexity/sonar"
  }
EOT

# Create Vibe Kanban config
cat <<EOT > /root/.local/share/vibe-kanban/profiles.json
{
  "executors": {
    "CLAUDE_CODE": {
      "DEFAULT": {
        "CLAUDE_CODE": {
          "append_prompt": null,
          "claude_code_router": true,
          "plan": false,
          "approvals": true,
          "dangerously_skip_permissions": true,
          "disable_api_key": true,
          "base_command_override": "bunx --bun @musistudio/claude-code-router@latest code"
        }
      }
    },
    "QWEN_CODE": {
      "DEFAULT": {
        "QWEN_CODE": {
          "append_prompt": null,
          "yolo": true,
          "base_command_override": "bunx @qwen-code/qwen-code@latest"
        }
      }
    }
  }
}
EOT

cat <<EOT > /root/.local/share/vibe-kanban/config.json
{
  "config_version": "v8",
  "theme": "DARK",
  "executor_profile": {
    "executor": "CLAUDE_CODE"
  },
  "disclaimer_acknowledged": true,
  "onboarding_acknowledged": true,
  "notifications": {
    "sound_enabled": true,
    "push_enabled": true,
    "sound_file": "COW_MOOING"
  },
  "editor": {
    "editor_type": "VS_CODE",
    "custom_command": null,
    "remote_ssh_host": null,
    "remote_ssh_user": null
  },
  "github": {
    "pat": null,
    "oauth_token": null,
    "username": "${GITHUB_USER:-}",
    "primary_email": "${GITHUB_EMAIL:-}",
    "default_pr_base": "main"
  },
  "analytics_enabled": true,
  "workspace_dir": null,
  "last_app_version": "0.0.137",
  "show_release_notes": false,
  "language": "BROWSER",
  "git_branch_prefix": "vk",
  "showcases": {
    "seen_features": [
      "task-panel-onboarding"
    ]
  },
  "pr_auto_description_enabled": true,
  "pr_auto_description_prompt": null
}
EOT

# Kill existing screens if they exist
if screen -list | grep -q "ccr-server"; then
  ccr stop 2>/dev/null || true
  sleep 2
  screen -S ccr-server -X quit 2>/dev/null || true
fi

if screen -list | grep -q "vibe-kanban"; then
  ccr stop 2>/dev/null || true
  sleep 2
  screen -S vibe-kanban -X quit 2>/dev/null || true
fi

# Start Claude Code Router in screen
screen -L -Logfile /tmp/ccr-server.log -dmS ccr-server ccr start

# Start Vibe Kanban in screen on port 8888
screen -L -Logfile /tmp/vibe-kanban.log -dmS vibe-kanban bash -c "PORT=8888 bunx vibe-kanban@latest"

# Show active screens
screen -list

# Keep container running and monitor logs
tail -f /tmp/ccr-server.log /tmp/vibe-kanban.log